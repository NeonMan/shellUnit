/*
 * shunit-out-pretty.c
 *     Default output formatter for shunit. colorizes the output and shows some timing
 */

/*
 Copyright (c) 2013, Juan Luis Álvarez Martínez
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <iostream>
#include <string>
#include <cstdlib>
#include <climits>

//White on something colors
#define BUFFER_SIZE (1024*8)
#define COLOR_RED    "\033[1;37;41m"
#define COLOR_GREEN  "\033[1;37;42m"

//Something on black colors
#define COLOR_YELLOW_FG "\033[1;33;40m"

//Default color
#define COLOR_RESET  "\033[0m"
using namespace std;

//Globals (forgive me)
long ini_time = LONG_MAX;
long end_time = LONG_MIN;
int err_count = 0;

/*
 * Test lines have the format:
 * SHU,TEST,<test name>
 */
void parse_test(string line){
  cout<<COLOR_YELLOW_FG<<"TEST: "<<line.substr(line.rfind(",")+1)<<COLOR_RESET<<endl;
}

/*
 * Assert lines have the format
 * SHU,ASSERT,<test file>,<test name>,<asser line>,<start time milis>,<end time milis>,<OK|FAIL>,<comment>
 */
void parse_assert(string line){
  string splitline[9];
  for(int i=0;i<9;i++){
    splitline[i] = line.substr(0, line.find(","));
    line = line.substr(line.find(",")+1);
  }
  string test_file    = splitline[2];
  string test_name    = splitline[3];
  string test_line    = splitline[4];
  string test_initime = splitline[5];
  string test_endtime = splitline[6];
  string test_ok      = splitline[7];
  string test_msg     = splitline[8];

  long ms_ini = atol(test_initime.c_str());
  long ms_end = atol(test_endtime.c_str());
  ini_time = ini_time > ms_ini ? ms_ini : ini_time;
  end_time = end_time < ms_end ? ms_end : end_time;

  if(splitline[7].compare("OK") == 0){
    cout<<" "<<COLOR_GREEN<<"Assert @"<<test_line<<" succeeded. ("<<ms_end-ms_ini<<"ms)";
  }
  else{
    cout<<" "<<COLOR_RED  <<"Assert @"<<test_line<<" failed. ("<<ms_end-ms_ini<<"ms) Reason: "<<test_msg;
    err_count++;
  }
  cout<<COLOR_RESET<<endl;
}

void parse_line(string line){
  if(line.find("SHU,TEST,")==0){
    parse_test(line);
  }
  else if(line.find("SHU,ASSERT,")==0){
    parse_assert(line);
  }
}

int main(int argc, char** argv){
  std::string line;
  while (std::getline(std::cin, line))
  {
    parse_line(line);
  }
  //Show timings
  cout<<COLOR_YELLOW_FG;
  cout<<"-----------------------------------"<<endl;
  cout<<" All test completed in "<<end_time-ini_time<<"ms"<<endl;
  if(err_count){
    cout<<" "<<COLOR_RED<<err_count<<" asserts failed."<<COLOR_YELLOW_FG<<endl;
  }
  else{
    cout<<" "<<COLOR_GREEN<<"Al asserts passed."<<COLOR_YELLOW_FG<<endl;
  }
  cout<<"-----------------------------------";
  cout<<COLOR_RESET<<endl;
  return 0;
}
