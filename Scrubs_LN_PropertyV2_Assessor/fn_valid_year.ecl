import _validate,Std;

EXPORT fn_valid_year(string st) := function

string currentYear:= (STRING8)Std.Date.Today();

return if(st = '' or _Validate.Support.fIntegerInRange((integer)st,1900,(integer)(CurrentYear[1..4])),1,0);

end;