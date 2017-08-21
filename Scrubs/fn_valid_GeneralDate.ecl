import _validate,ut;
EXPORT fn_valid_GeneralDate(string st) :=function
yyyymmdd := st = '' or (unsigned) st = 0 or _validate.date.fIsValid(st);
return (unsigned)yyyymmdd;
end;