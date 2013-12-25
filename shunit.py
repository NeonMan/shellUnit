#!/usr/bin/env python3
#
# Copyright (c) 2013, Juan Luis Álvarez Martínez
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
# -------------------------------------------------------------------------------
# File description here
# -------------------------------------------------------------------------------
#

import tempfile
import re
import sys
import os.path
import os
import subprocess
import time
import csv

#Default level 1 (only errors and messages)
VERBOSE_LEVEL = 1
SHELL = "/bin/bash"
SHUNIT_DIR = "/usr/share/shunit.d/"
SHUNIT_FILES = ('assertions.sh',  'basic-asserts.sh',  'colors.sh',  'file-asserts.sh',  'setup-shell.sh',  'tests.sh',  'utils.sh', 'string-asserts.sh', 'filesystem-asserts.sh')

#Prints to console, with colours
def print_colored(msg, colour=None, bold=True):
  colours = {'red':'37;41', 'green':'37;42', 'yellow':'33;40'}
  if colour==None:
    print(msg)
  else:
    print('\033[%sm\033[1m%s\033[0m' % (colours[colour], msg))

#Print an error, vervosity must be at least 0
def print_error(msg):
  if VERBOSE_LEVEL >= 0:
    print_colored("[ERROR] %s" % msg, 'red')

#Print a warning, vervosity must be at least 2
def print_warning(msg):
  if VERBOSE_LEVEL >= 2:
    print_colored("[WARNING] %s" % msg, 'yellow')

#Print an info message, vervosity must be at least 3
def print_info(msg):
  if VERBOSE_LEVEL >= 3:
    print("[INFO] %s" % msg)

#Print a debug message, min. verbosity = 4
def print_debug(msg, level=0):
  if VERBOSE_LEVEL >= (level + 4):
    print("[DBG%d] %s" % (level, msg))

#Print a message, vervosity must be at least 1
def print_message(msg, colour=None):
  if VERBOSE_LEVEL >= 1:
    print_colored(msg, colour)

#Show usage and help
def show_help(exec_name):
  print("Usage: %s [DIRECTORY]|[TEST SCRIPT]" % exec_name)

#Returns a list of test function names, namely functions starting with test
def extract_tests(path):
  name_regex      = re.compile("test[a-zA-Z0-9]*\ \(\)\ \{")
  name_regex_bash = re.compile("function\ test[a-zA-Z0-9]*\ \{")
  rv = []
  with open(path, 'r') as sh_file:
    for l in sh_file.readlines():
      match = name_regex.match(l)
      if match:
        #if line matches the head definition, append the test name to the rv list
        header = l.strip()
        name = header[:header.find("(")-1]
        rv.append(name)
      else:
        #Alternate function definition, bash-style
        match = name_regex_bash.match(l)
        if match:
          header = l.strip()
          name = header[len("function "):header.find("{")-1]
          rv.append(name)
  return rv

def show_results(csv_file, test_time):
  lines = []
  #Extract info from the result CSV file
  with open(csv_file, 'r') as f:
    csv_reader = csv.reader(f)
    for row in csv_reader:
      lines.append(row)

  if len(lines) == 0:
    print_warning("No test results")
    return

  test_file = lines[0][0]
  current_test = ''
  assert_count = 0
  fail_count = 0
  for line in lines:
    if current_test != line [1]:
      #Prepare state for a new test
      current_test = line [1]
      assert_count = 0
      fail_count = 0
      print_message("Test <%s> completed in %fs:" % (current_test, test_time), 'yellow')
    if line[3] == 'OK':
      print_message("  Assert @%s: OK" % line[2], 'green')
      assert_count = assert_count + 1
    else:
      print_message("  Assert @%s: FAIL (%s)" % (line[2], line[4]), 'red')
      assert_count = assert_count + 1
      fail_count = fail_count + 1
  if fail_count == 0:
    print_message("All tests from <%s> OK" % test_file, 'green')
  else:
    print_message("A test from <%s> has failed" % test_file, 'red')

#Run a test file
def run_test(path):
  #setup a temporary dir to store test results
  tmp_dir =  tempfile.mkdtemp('', "shunit-") #tempfile.TemporaryDirectory("-shunit")
  tmp_result = os.path.join(tmp_dir, 'result.csv')
  os.putenv('SHU_TMP_DIR', tmp_dir)
  os.putenv('SHU_TMP_RESULT', tmp_result)

  #'touch' result.csv
  f = open(tmp_result, 'wb')
  f.close()

  #export test file name
  os.putenv('SHU_TEST_FILE', path)
  print_info("Running test file <%s>" % path)

  #Get a list of all the tests contained in the testfile
  tests = extract_tests(path)
  if len(tests) == 0:
    print_error("No tests found on file <%s>" % path)
    return


  #spawn a shell instance
  sh = subprocess.Popen(SHELL, stdin=subprocess.PIPE)
  #load the framework
  dir_join = lambda f: os.path.join(SHUNIT_DIR, f)
  #For each framework file
  for sh_path in map(dir_join, SHUNIT_FILES):
    print_debug("Loading framework file <%s>" % sh_path)
    #Add file to the shell context
    sh.stdin.write(bytes(". %s\n" % sh_path, 'utf-8'))
  #Start time in seconds
  start_time = time.time()

  #Load test file into the context
  with open(path, 'r') as sh_file:
    current_line = 1
    for l in sh_file.readlines():
      sh.stdin.write(bytes("SHU_TEST_LINE=%d\n" % current_line, 'utf-8'))
      current_line = current_line + 1
      sh.stdin.write(bytes("%s\n" % l, 'utf-8'))

  #Run each test
  for t in tests:
     #Set SHU_TEST_NAME var
     sh.stdin.write(bytes("SHU_TEST_NAME=%s\n" % t, 'utf-8'))
     sh.stdin.write(bytes("%s\n" % t, 'utf-8'))

  #end time in seconds
  end_time = time.time()
  print_info("Test file completed in %f seconds" % (end_time - start_time))

  #Wait for test to end
  if sh.poll() == None:
    print_debug("Waiting for spawned shell to terminate <%s>" % path)
    sh.stdin.close()
    time.sleep(0.1)
    sh.wait()

  show_results(tmp_result, (end_time - start_time))

  #Cleanup temporary directory
  #tmp_dir.cleanup()

#Run all test files from a directory
def run_directory(path):
  #Walk this directory files
  #Call run_test with all the files ending with .shu
  for dirname, dirnames, filenames in os.walk(path):
    for f in filenames:
      if f[-4:] == '.shu':
        run_test(os.path.join(path,f))

#Parse command line and start test(s) accordingly
def start_test(path):
  #test if argument is a regular file or a directory
  if os.path.isdir(path):
    print_info("Running tests on directory <%s>" % os.path.normpath(path))
    run_directory(os.path.normpath(path))
  elif os.path.isfile(path):
    print_info("Running test file <%s>" % os.path.normpath(path))
    run_test(os.path.normpath(path))
  else:
    print_error("Argument <%s> not a directory or regular file" % os.path.normpath(path))

#Main procedure
if __name__ == '__main__':
  #Check if shunit is available at default location
  #if not, try current directory
  #otherwise, fail
  if not os.path.exists(SHUNIT_DIR):
    SHUNIT_DIR="./shunit.d/"
    if not os.path.exists(SHUNIT_DIR):
      print_error("Shunit framework directory (shunit.d) not found")
      exit(-1)
    
  #Read command line arguments
  if len(sys.argv) == 2:
    start_test(sys.argv[1])
  else:
    show_help(sys.argv[0])
