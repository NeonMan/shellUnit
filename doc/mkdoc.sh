#!/bin/bash

HEADER='<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>shellUnit &mdash; Quickstart</title>
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/shunit.css" />
</head>
<body>
<div id="header">
    <h1>
      <img src="./img/shellUnit.png" alt="shellUnit">
    </h1>
	<p>
      shellUnit is a unit-test framework for bash-style and csh-style shells. It provides a way to separate the tests from the scripts, test functions main procedure and code blocks from a shell script.
    </p>
</div>

<div id="content">
<table cellspacin=0 cellpadding=0>'

FOOTER='</table>
</div>
<div id="footer">
  <p>Footer</p>
</div>
</body>'

#Make a documentation row, two 960gs columns.
#
# Params:
#     $1 <-- Col 1
#     $2 <-- Col 2
# Echoes:
#     HTML code, with 960 div tags
mkrow () {
  COL1=`echo -e "$1" | txt2html --extract`
  COL2=`echo -e "$2" | sed -r "s/\x1B\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g" | awk '{print "    "$0}' | pandoc -f markdown -t html`
  if [ "$3" != "" ]
  then
    COL1="$3"
  fi
  echo '<tr>'
    echo '<td class="doc">'
      echo "$COL1"
    echo '</td>'
    echo '<td class="code">'
      echo "$COL2"
    echo '</td>'
  echo '</tr>'
}

# Makes a row from a shell command
#
mkshrow () {
    C1="$1"
    C2=`$1`
    if [ "$2" = "" ]
    then
      mkrow "$C1" "$C2"
    else
      mkrow "$2" "$C2"
    fi
}

mkdoc () {

  C1="A set os exaples will we shown now. This document is automatically generated by the mkdoc.sh script in the documents directory so commands and outputs match."
  C2=""
  mkrow "$C1" "$C2"

  TXT="A test script is a plain shell script with a few characteristics. Test functions are declared csh-style and start with 'test', also, to be recogniced by automatic directory testing, its extension must be '.shu'"
  CMD="cat sample-01.shu"
  mkshrow "$CMD" "$TXT"


  C1="To execute a test file we use the 'shu' command. It needs at least one parameter, indicating either a test file:"
  C2=""
  mkrow "$C1" "$C2"
  C1="shu sample-01.shu"
  mkshrow "$C1"

  C1="Or a directory containing various .shu files"
  C2=""
  mkrow "$C1" "$C2"
  C1="shu ./sample-dir/"
  mkshrow "$C1"

  TXT="To provide a target we use the 'shu_loadTarget' function which as a parameter has the path to the shell script to be tested. At pressent, loading a target executes its 'main' procedure (all commands not in a function) so be careful with that."
  CMD="cat sample-target.shu"
  mkshrow "$CMD" "$TXT"

  TXT="The sample target file:"
  CMD="cat target.sh"
  mkshrow "$CMD" "$TXT"

  TXT="The output of shu ./sample-02/"
  CMD="shu sample-target.shu"
  mkshrow "$CMD" "$TXT"

  TXT="The test asserts that 'a_function' will echo the string 'TEST'. shellUnit provides many assertions for different situations. here is a test using all the 'basic' asserts."
  CMD="cat basic-asserts.shu"
  mkshrow "$CMD" "$TXT"

  TXT="The result of executing this test file is:"
  CMD="shu basic-asserts.shu"
  mkshrow "$CMD" "$TXT"

  TXT="shellUnit works as a preprocessor for test files. This means that to provide meaningful messages and dispatch tests it reads a test file and its targets and produces a single shell script which is executed. Because of that, some variables won't be accesible from a shell script, most notably the return-value variable\$?. To access the return value, the SHU_RV variable is provided."
  CMD="cat sample-return.shu"
  mkshrow "$CMD" "$TXT"

  TXT="Executing the test will yield the following output. Notice that an assert, wether failed or not, will print the line it is located preceded by an '@', and if failed, a reason why will be provided. Also, any function not starting with 'test' will be ignored by shellUnit, this way we can make self-contained tests if wanted."
  CMD="shu sample-return.shu"
  mkshrow "$CMD" "$TXT"

  TXT="For testing the 'main' function, as if we called the script from the shell, shellUnit provided the 'shu_main' function, which will behave like the shell script."
  CMD="cat test-main.shu"
  mkshrow "$CMD" "$TXT"

  TXT="shellUnit results can be formatted in different ways, the results shown so far being the default output formatter. So far, the default ot 'pretty' formatter and 'raw' are available. The 'raw' output can be activated by passing the --raw option to shellUnit. This format is intended to be used by other programs as its input. It provides various information about the tests and asserts being run in CSV format."
  mkrow "$TXT" ""

  CMD="shu --raw basic-asserts.shu"
  TXT="An example of the raw output, using the basic asserts files:"
  mkrow "$TXT" ""
  mkshrow "$CMD"

  TXT="The CSV format is not yet frozen so no information on what each column is will be provided until then."
  mkrow "$TXT" ""

  TXT="Test scripts may optionally have a 'setup' and 'teardown' function, which will be executed before and after every test respectively."
  CMD="cat sample-setup.shu"
  mkshrow "$CMD" "$TXT"
}

mainp () {
  echo "$HEADER"
  mkdoc
  echo "$FOOTER"
}

mainp
