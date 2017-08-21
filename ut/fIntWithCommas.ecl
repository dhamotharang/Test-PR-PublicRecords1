EXPORT fIntWithCommas(unsigned8 pint) :=
function

  myint         := pint;
  mystring      := (string)myint;
  reversestring := stringlib.stringreverse(mystring);
  addcommas     := if(regexfind('[[:digit:]]{3}',reversestring) = true  ,regexreplace('([[:digit:]]{3})',reversestring,'$1,') ,reversestring);
  reverseagain  := stringlib.stringreverse(addcommas);
  trimit        := if(reverseagain[1] = ',' ,reverseagain[2..]  ,reverseagain);
  return trimit;
  
end;