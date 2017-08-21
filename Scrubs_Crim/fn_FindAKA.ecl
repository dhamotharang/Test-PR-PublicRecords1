import STD;

EXPORT fn_FindAKA(string inString) := function

UpperVersion:=STD.Str.ToUpperCase(inString);
RegularExpression:= '([^A-Z0-9]AKA[^A-Z0-9])';
return if(REGEXFIND(RegularExpression,UpperVersion),0,1);
end;