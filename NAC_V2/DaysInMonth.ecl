import	_Validate;

EXPORT string2 DaysInMonth(string yyyymm) := 
	IntFormat(_Validate.Date.fDaysInMonth((integer)yyyymm[1..4],(integer)yyyymm[5..6]),2,1);
