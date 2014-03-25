/*
 * shellunit-out-pretty.c
 * jUnit formatter, outputs an XML document to be parsed by junit tools
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
#include <map>
#include <list>
#include <string>
#include <vector>
#include <sstream>

/*

  +-----------+        +------+        +--------+
  | testSuite | <>---- | test | <>---- | assert |
  +-----------+        +------+        +--------+
  |properties |                        |message |
  +-----------+                        +--------+

*/

namespace shellUnit {
  using namespace std;

  /**
   * Add doxygen comment here
   *
   */
  class assert{

  };

  /**
   * Add doxygen comment here
   *
   */
  class test{
  private:
    list<assert> asserts;

  public:
    test(){}
    test(string cname, string tname, string err){
      className = cname;
      testName = tname;
      errorMessage = err;
      failed = true;
    }
    test(string cname, string tname){
      className = cname;
      testName = tname;
      errorMessage = "";
      failed = false;
    }
    bool   failed;
    string className;
    string testName;
    string errorMessage;
  };

  /**
   * @brief Add doxygen comment here
   *
   */
  class testSuite {
  private:
    list<test> tests;
    map<string, string> properties;

  public:
    ///Default Constructor
    testSuite(){}
    ///Add a property/value pair, maps to <property> tags
    void addProperty(string key, string val){
      properties[key]=val;
    }
    ///Get the properties list
    map<string, string>& getProperties(){
      return properties;
    }
    ///Add a test object
    void addTest(test t){
      tests.push_back(t);
    }
    ///Add a sucessful test
    void addSuccess(string className, string assertName){
      test t(className, assertName);
      tests.push_back(t);
    }
    ///Add a failing test
    void addFail(string className, string assertName, string reason){
      test t (className, assertName, reason);
      tests.push_back(t);
    }
    ///Return all tests
    list<test>& getTests(){
      return tests;
    }
  };

  /**
   * Write a XML document from testSuite.
   *
   */
  void dump_xml(testSuite ts){
    //Write XML header
    cout<< "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"<<endl;
    cout<< "<testsuite>"<<endl;

    //Dump all properties
    cout<< "  <properties>"<<endl;
    for(map<string,string>::iterator iter=ts.getProperties().begin();
        iter != ts.getProperties().end();
        iter++){
      cout<< "    <property name=\"" << iter->first << "\" value=\"" << iter->second << "\"/>" << endl;
    }
    cout<< "  </properties>"<<endl;

    //Dump all tests
    for(test t : ts.getTests()){
      cout<<"  <testcase class=\""<<t.className<<"\" name=\""<<t.testName<<"\">";
      if (t.failed){
        cout<<endl;
        cout<<"    <failure type=\""<<t.errorMessage<<"\"/>"<<endl;
      }
      cout<<"  </testcase>"<<endl;
    }

    //Write XML footer
    cout<< "</testsuite>"<<endl;
  }

  //String-splitting utility
  std::vector<std::string> &split(const std::string &s, char delim, std::vector<std::string> &elems) {
    std::stringstream ss(s);
    std::string item;
    while (std::getline(ss, item, delim)) {
        elems.push_back(item);
    }
    return elems;
  }
  std::vector<std::string> split(const std::string &s, char delim) {
    std::vector<std::string> elems;
    split(s, delim, elems);
    return elems;
  }

  void parseTest(string line, testSuite& t){
    //cout<<"TEST"<<endl;
  }

  void parseAssert(string line, testSuite& t){
    ///Get required info
    vector<string> lv = split(line, ',');
    bool failed = lv[7]=="OK" ? false : true;
    string testName  = "@" + lv[4];
    string className = lv[3];
    string errMessage = lv[7];
    if (failed)
      t.addFail(className, testName, errMessage);
    else
      t.addSuccess(className, testName);
  }

  void parseLine(string line, testSuite& t){
    if(line.find("SHU,TEST,")==0){
      parseTest(line, t);
    }
    else if(line.find("SHU,ASSERT,")==0){
      parseAssert(line, t);
    }
    else{
      cerr<<line<<endl;
    }
  }

  int process_input () {
    testSuite t;
    while(!cin.eof()){
      string s;
      cin>>s;
      parseLine(s, t);
    }
    dump_xml(t);
    return 0;
  }

} //Namespace

int main (int argc, char** argv){
  return shellUnit::process_input();
}
