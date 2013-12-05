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

import sys
import os.path
import os
import subprocess
import time

#Default level 1 (only errors and messages)
VERBOSE_LEVEL = 1
SHELL = "/bin/bash"
SHUNIT_DIR = "./shunit.d/"
SHUNIT_FILES = ('assertions.sh',  'basic-asserts.sh',  'colors.sh',  'file-asserts.sh',  'setup-shell.sh',  'test-dir.sh',  'test-file.sh',  'tests.sh',  'utils.sh')

#Print an error, vervosity must be at least 0
def print_error(msg):
  if VERBOSE_LEVEL >= 0:
    print("[ERROR] %s" % msg)

#Print a warning, vervosity must be at least 2
def print_warning(msg):
  if VERBOSE_LEVEL >= 2:
    print("[WARNING] %s" % msg)

#Print an ino message, vervosity must be at least 3
def print_info(msg):
  if VERBOSE_LEVEL >= 3:
    print("[INFO] %s" % msg)

#Print a debug message, min. verbosity = 4
def print_debug(msg, level=0):
  if VERBOSE_LEVEL >= (level + 4):
    print("[DBG%d] %s" % (level, msg))

#Print a message, vervosity must be at least 1
def print_message(msg):
  if VERBOSE_LEVEL >= 1:
    print(msg)

#Show usage and help
def show_help(exec_name):
  print("Usage: %s [DIRECTORY]|[TEST SCRIPT]" % exec_name)

#Run a test file
def run_test(path):
  print_message("Running test file <%s>" % path)
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

  #Run test calling the testFile shell function
  sh.stdin.write(bytes("testFile %s\n" % path, 'utf-8'))
  #Wait for test to end
  if sh.poll() == None:
    print_debug("Waiting for spawned shell to terminate <%s>" % path)
    sh.stdin.write(bytes("exit\n", 'utf-8'))
    sh.wait()
  #end time in seconds
  end_time = time.time()
  print_message("Test file completed in %f seconds" % (end_time - start_time))


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
  #Read command line arguments
  if len(sys.argv) == 1:
    start_test("./")
  elif len(sys.argv) == 2:
    start_test(sys.argv[1])
  else:
    show_help(sys.argv[0])
  print("FINISHED!")