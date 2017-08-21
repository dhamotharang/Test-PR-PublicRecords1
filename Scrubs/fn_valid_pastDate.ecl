// This custom scrub was created for the Corporation Re-corp Project. If it works for you, 
// then feel free to use it. Otherwise you must create your own version or modfy this one 
// to accomodate your needs without breaking this one. 
// This will send back a 1, valid date flag, if: 1) date is blank or zero 2) the date is a 
// valid past date greater than 16000101. Otherwise it returns a 0, invalid date flag. Thanks! 

import _validate,ut;
EXPORT fn_valid_pastDate(string st) :=function
yyyymmdd := map(st = '' => '1', 
								(unsigned) st = 0 => '1',
						    _validate.date.fIsValid(st) and _validate.date.fIsValid(st,_validate.date.rules.DateInPast) and (st) > '16000101' => '1',
								'0');
return (unsigned)yyyymmdd;
end;