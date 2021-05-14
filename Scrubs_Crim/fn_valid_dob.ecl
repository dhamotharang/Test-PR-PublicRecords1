

import _validate,ut,std;
EXPORT fn_valid_dob(string st, string dt_type = '') := function
current := 
st in ['','W0004','W0003'] or 
(unsigned) st = 0 or 
(st[..4] = '0000' or
st[5..8] >= '0101') or 
(_validate.date.fCorrectedDateString(st) <> '' and 
_validate.date.fCorrectedDateString(st) > '18000101' and 
_validate.date.fCorrectedDateString(st) <= (String)Std.Date.Today());
return (unsigned)current;

end;