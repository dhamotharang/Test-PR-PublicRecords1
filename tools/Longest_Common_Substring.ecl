/*
  Solves the longest common substring problem.
  it returns a string with three components separated by commas:
    1. size of the longest common substring
    2. index of the start of the substring in string1(index starts at zero, not one)
    3. index of the start of the substring in string2(index starts at zero, not one)

  Example:
      execute: tools.Longest_Common_Substring('betty white','white christmas');
      result : 5,6,0
      http://dataland_esp:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20170512-162142#/stub/Summary
*/

IMPORT Python3;
EXPORT string Longest_Common_Substring(STRING s01,STRING s02) := 
EMBED(Python3)
  import difflib
  d=difflib.SequenceMatcher(None,s01,s02)
  substring=d.find_longest_match(0, len(s01), 0, len(s02))
  return str(substring.size) + "," + str(substring.a) + "," + str(substring.b)
ENDEMBED;