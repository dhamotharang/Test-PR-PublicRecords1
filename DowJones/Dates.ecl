import ut;
EXPORT Dates := MODULE

// convert DJ date format to XG date format
export string StdDate(string djDate) := ut.ConvertDate(djDate, '%d-%B-%Y', '%m/%d/%Y');


// convert date pieces to XG date format
shared string2 MonthNameToNum(string Month) := CASE(Month,
	'Jan' => '01',
	'Feb' => '02',
	'Mar' => '03',
	'Apr' => '04',
	'May' => '05',
	'Jun' => '06',
	'Jul' => '07',
	'Aug' => '08',
	'Sep' => '09',
	'Oct' => '10',
	'Nov' => '11',
	'Dec' => '12',
	'00');
	
export PiecesToXG(string Year,string Month,string Day) := 
		MAP(
				Month = '' => Year + '/00/00',
				Day = '' => Year + '/' + MonthNameToNum(Month) + '/00',
				 ut.ConvertDate(Day+'-'+Month+'-'+Year, '%d-%B-%Y', '%Y/%m/%d')
		);
		
export PiecesToXGSimple(string Year,string Month,string Day) := 
		MAP(
				Month = '' => Year,
				Day = '' => Year + '/' + MonthNameToNum(Month),
				 ut.ConvertDate(Day+'-'+Month+'-'+Year, '%d-%B-%Y', '%Y/%m/%d')
		);
		
export PiecesToString(string Year,string Month,string Day) := 
		TRIM(MAP(
				Month = '' => Year,
				Day = '' => Month + ' ' + Year,
				Day+' '+Month+' '+Year)
			,LEFT,RIGHT);

END;