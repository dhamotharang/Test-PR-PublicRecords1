import _Validate;

////////////////////////////////////////////////////////////////////////////////
///// Fix the invalid date values and returns the date value in ccyymmdd format
////////////////////////////////////////////////////////////////////////////////

export string8 fFixDate(string indate) := function
	outdate := _Validate.date.fCorrectedDateString(trim(indate,left,right));
	return(if (trim(outdate,left,right) <> '', outdate, ''));
end;		
		