string2 translate_p1(string1 p1) := case(p1,
	'A' => '10',
	'B' => '11',
	'C' => '12',
	'D' => '13',
	'E' => '14',
	'F' => '15',
	'G' => '16',
	'H' => '17',
	'I' => '18',
	'J' => '19',
	'K' => '20',
	'L' => '21',
	'M' => '22',
	'N' => '23',
	'P' => '24',
	'Q' => '25',
	'R' => '26',
	'S' => '27',
	'T' => '28',
	'U' => '29',
	'V' => '30',
	'W' => '31',
	'X' => '32',
	'Y' => '33',
	'Z' => '34',
	' ' + p1);

string6 tp(string5 p) := translate_p1(p[1]) + p[2..5];
export string6 translate_price(string5 p) := 
	if((integer)tp(p) = 99999, 
	   '',
		tp(p));