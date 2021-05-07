EXPORT fIntWithCommas( pint) :=
functionmacro

  import std;
  myint         := pint;
  mystring      := trim((string)myint,all);
  
  dotindex      := std.str.find(mystring  ,'.'  ,1);
  
  mystring_whole    := if(dotindex > 0  ,mystring[1..(dotindex - 1)]  ,mystring );
  mystring_fraction := if(dotindex > 0  ,mystring[(dotindex + 1)..]   ,''       );
  
  reversestring := stringlib.stringreverse(mystring_whole);
  addcommas     := if(regexfind('[[:digit:]]{3}',reversestring) = true  ,regexreplace('([[:digit:]]{3})',reversestring,'$1,') ,reversestring);
  reverseagain  := stringlib.stringreverse(addcommas) + if(trim(mystring_fraction) != ''  ,'.' + mystring_fraction  ,'');
  trimit        := map(reverseagain[1   ] = ','  => reverseagain[2..]  
                      ,reverseagain[1..2] = '-,' => reverseagain[1] + reverseagain[3..] //negative integer
                      ,                             reverseagain
                   );
  return trimit;
  
endmacro;