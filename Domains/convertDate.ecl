get_month(string3 abbrv) := 
	case(stringlib.StringToUpperCase(abbrv),
		 'JAN' => 1,
		 'FEB' => 2, 
		 'MAR' => 3,
		 'APR' => 4,
		 'MAY' => 5,
		 'JUN' => 6,
         'JUL' => 7,
         'AUG' => 8,
         'SEP' => 9,
         'OCT' => 10,
         'NOV' => 11,
         'DEC' => 12,
		 0);

integer2 iday(string dob) := (integer2)(dob[1..2]);
integer2 imonth(string dob) := (integer2)get_month(dob[4..6]);
integer2 iyear(string dob)  := (integer2)(dob[8..11]);


export string8 convertDate(string dob) := 
	intformat(iyear(dob), 4, 1) +
	intformat(imonth(dob), 2, 1) +
	intformat(iday(dob), 2, 1);