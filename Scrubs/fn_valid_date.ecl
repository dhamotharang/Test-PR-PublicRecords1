import _validate,ut,std;
EXPORT fn_valid_date(string st, string dt_type = '') := function
current := st = '' or (unsigned) st = 0 or (_validate.date.fCorrectedDateString(st) <> '' and _validate.date.fCorrectedDateString(st) > '18000101' and _validate.date.fCorrectedDateString(st) <= (String)Std.Date.Today());
future := st = '' or (unsigned) st = 0 or (_validate.date.fCorrectedDateString(st) <> '' and _validate.date.fCorrectedDateString(st) > '18000101');

return if(dt_type = '', (unsigned)current, (unsigned) future);

end;