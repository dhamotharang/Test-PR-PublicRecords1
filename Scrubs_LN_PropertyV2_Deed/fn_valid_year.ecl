import ut, _validate;

EXPORT fn_valid_year(string st) := function

string currentYear:= ut.GetDate;

return if(_Validate.Support.fIntegerInRange((integer)st,1900,(integer)(CurrentYear[1..4])),1,0);

end;