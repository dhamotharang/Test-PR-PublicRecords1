export dateMMMDDYYYY(string dateIN) := function

searchPat := '^([[:alpha:]]{3})\\s+([[:digit:]]{1,2})\\s+([[:digit:]]{4})\\s+([[:digit:]]{1,2}):([[:digit:]]{2})\\s*([[:alpha:]]{2})$';

trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end;

dtall := REGEXFIND(searchPat, dateIN, 0);
dtmm := trimUpper(REGEXFIND(searchPat, dateIN, 1));
dtdd := REGEXFIND(searchPat, dateIN, 2);
dtyy := REGEXFIND(searchPat, dateIN, 3);
dthr := REGEXFIND(searchPat, dateIN, 4);
dtmn := REGEXFIND(searchPat, dateIN, 5);
dtam := REGEXFIND(searchPat, dateIN, 6);
 
test := case(dtmm,
	 'JAN' => '01',
	 'FEB' => '02',
	 'MAR' => '03',
	 'APR' => '04',
	 'MAY' => '05',
	 'JUN' => '06',
	 'JUL' => '07',
	 'AUG' => '08',
	 'SEP' => '09',
	 'OCT' => '10',
	 'NOV' => '11',
	 'DEC' => '12',
	 '');
	 
newDay := (string)INTFORMAT((integer)dtdd,2,1);
newHr := (string)INTFORMAT((integer)dthr,2,1);

time := if(dtam='PM' and dthr<>'12',
			(string)((integer)dthr + 12),
			newHr);

result := dtyy + test + newDay + time + dtmn;

return result;

end;


