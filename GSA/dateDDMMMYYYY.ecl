export dateDDMMMYYYY(string dateIN) := function

searchPat := '^([[:digit:]]{1,2})-([[:alpha:]]{3})-([[:digit:]]{4})$';

trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end;

dtdd  := REGEXFIND(searchPat, dateIN, 1);
dtmm  := trimUpper(REGEXFIND(searchPat, dateIN, 2));
dtyy  := REGEXFIND(searchPat, dateIN, 3);
 
month := case(dtmm,
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

result := if(REGEXFIND(searchPat,dateIN),
		     dtyy + month + newDay,
			 '');

return result;

end;


