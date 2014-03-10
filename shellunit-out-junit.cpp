#include <iostream>
#include <map>
#include <list>
#include <string>

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
    map<string, string> getProperties(){
      return properties;
    }
    ///Add a test object
    void addTest(test t){
      tests.push_back(t);
    }
    ///Return all tests
    list<test> getTests(){
      return tests;
    }
  };

  /**
   * Write a XML document from testSuite.
   *
   */
  void dump_xml(testSuite ts){
    //Get testSuite info
    string test_name = "";
    double total_time = 0.0;
    int    error_count = 0, skip_count = 0, test_count = 0, fail_count = 0;

    //Write XML header
    cout<< "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"<<endl;
    cout<< "<testsuite failures=\""<<fail_count
        << "\" time=\""<<total_time
        << "\" errors=\""<<error_count
        << "\" skipped=\""<<skip_count
        << "\" tests=\""<<test_count
        << "\" name=\""<<test_name
        << "\">"<<endl;

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

    }
    cout<< "  <testcase time=\"0.02\" classname=\"net.heavydeck.ini.IniFileTest\" name=\"testGetValue\">" << endl;
    cout<< "    <failure message=\"expected:&lt;null&gt; but was:&lt;0&gt;\" type=\"java.lang.AssertionError\"/>" << endl;
    cout<< "    <system-out></system-out>" << endl;
    cout<< "  </testcase>" << endl;

    //Write XML footer
    cout<< "</testsuite>"<<endl;
  }
} //Namespace

int main (int argc, char** argv){
  shellUnit::testSuite t;
  t.addProperty("AAA", "BBB");
  dump_xml(t);
  return 0;
}

