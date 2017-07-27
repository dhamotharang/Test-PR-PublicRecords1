string2 getDD(integer8 day, boolean isleap) := 
	map(day > if(isleap, 335, 334) => intformat(day % if(isleap, 335, 334),2,1),
		day > if(isleap, 305, 304) => intformat(day % if(isleap, 305, 304),2,1),
		day > if(isleap, 274, 273) => intformat(day % if(isleap, 274, 273),2,1),
		day > if(isleap, 244, 243) => intformat(day % if(isleap, 244, 243),2,1),
		day > if(isleap, 213, 212) => intformat(day % if(isleap, 213, 212),2,1),
		day > if(isleap, 182, 181) => intformat(day % if(isleap, 182, 181),2,1),
		day > if(isleap, 152, 151) => intformat(day % if(isleap, 152, 151),2,1),
		day > if(isleap, 121, 120) => intformat(day % if(isleap, 121, 120),2,1),
		day > if(isleap, 91, 90) => intformat(day % if(isleap, 91, 90),2,1),
		day > if(isleap, 60, 59) => intformat(day % if(isleap, 60, 59),2,1),
		day > 31 => intformat(day % 31,2,1), intformat(day,2,1));

string2 getMM(integer8 day, boolean isleap) := 
	map(day > if(isleap, 335, 334) => '12',
		day > if(isleap, 305, 304) => '11',
		day > if(isleap, 274, 273) => '10',
		day > if(isleap, 244, 243) => '09',
		day > if(isleap, 213, 212) => '08',
		day > if(isleap, 182, 181) => '07',
		day > if(isleap, 152, 151) => '06',
		day > if(isleap, 121, 120) => '05',
		day > if(isleap, 91, 90) => '04',
		day > if(isleap, 60, 59) => '03',
		day > 31 => '02', 
		day > 0 => '01',
		'00');

string4 getMMDD(integer8 day, boolean isleap):= 
	getMM(day, isleap) + getDD(day, isleap);
	
export string8 unDoJulian(integer8 j) := 
	if( j < 1800000, '',
	   (string4)(j div 1000) + //year
	   getMMDD(j % 1000, ut.LeapYear(j div 1000)));