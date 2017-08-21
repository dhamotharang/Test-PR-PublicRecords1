//-----------------------------------------------------------------------------
// fn_miskey_compare takes two strings and determines the probability that they
// may be a match with mis-keyed data based on a map of keys that are 
// physically near the digits that are off.
// RETURN VALUES:
//   0  : The strings match exactly
//   >0 : Some characters do not match, but where they don't match the 
//        characters are within the miskey map.  The return value is the
//        number of characters that do not match.
//   -1 : At least one character is not matched and not within the miskey map
//-----------------------------------------------------------------------------
EXPORT fn_miskey_compare(STRING s01,STRING s02) := FUNCTION
  IMPORT Std;
  SET OF STRING5 ssMap:=['1296','0247','0135','246','13579','2468','3579','1468','579','068'];
  d01:=DATASET([{s01,s02}],{STRING s1;STRING s2});
  PATTERN c:=PATTERN('[0-9]');
  d02:=PARSE(d01,s01,c,{STRING1 c:=MATCHTEXT(c);d01.s2;});
  d03:=PROJECT(d02,TRANSFORM({INTEGER1 compare;},
    SELF.compare:=IF(LEFT.c=LEFT.s2[COUNTER],0,IF(Std.Str.Find(ssMap[(UNSIGNED1)(LEFT.s2[COUNTER])+1],LEFT.c)>0,1,-1));
  ))(compare<>0);
  iRetVal:=IF(COUNT(d03(compare=-1))>0,-1,SUM(d03,compare));
  RETURN IF(s01=s02,0,iRetVal);
END;