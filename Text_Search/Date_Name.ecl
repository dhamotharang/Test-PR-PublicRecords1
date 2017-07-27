IMPORT Lib_StringLib;

EXPORT Date_Name := MODULE
	EXPORT SET OF STRING NameSet := [
		'JAN', 'JANUARY', 'FEB', 'FEBRUARY', 'MAR', 'MARCH', 'APR', 'APRIL',
		'MAY', 'JUN', 'JUNE', 'JUL', 'JULY', 'AUG', 'AUGUST', 'SEP', 'SEPTEMBER',
		'OCT', 'OCTOBER', 'NOV', 'NOVEMBER', 'DEC', 'DECEMBER'];
		
	EXPORT isMonth(STRING n) := StringLib.StringToUpperCase(n) IN NameSet;
	
	EXPORT STRING2 mm(STRING n) := CASE(StringLib.StringToUpperCase(n),
						'JAN'		=> '01', 	'JANUARY'			=> '01', 
						'FEB'		=> '02', 	'FEBRUARY'		=> '02', 
						'MAR'		=> '03', 	'MARCH'				=> '03', 
						'APR'		=> '04', 	'APRIL'				=> '04',
						'MAY'		=> '05', 
						'JUN'		=> '06', 	'JUNE'				=> '06', 
						'JUL'		=> '07', 	'JULY'				=> '07', 
						'AUG'		=> '08', 	'AUGUST'			=> '08', 
						'SEP'		=> '09', 	'SEPTEMBER'		=> '09',
						'OCT'		=> '10', 	'OCTOBER'			=> '10', 
						'NOV'		=> '11', 	'NOVEMBER'		=> '11', 
						'DEC'		=> '12', 	'DECEMBER'		=> '12',
						'00');

	EXPORT STRING2 m(STRING n) := CASE(StringLib.StringToUpperCase(n),
						'JAN'		=> '1', 	'JANUARY'			=> '1',
						'FEB'		=> '2', 	'FEBRUARY'		=> '2',
						'MAR'		=> '3', 	'MARCH'				=> '3',
						'APR'		=> '4', 	'APRIL'				=> '4',
						'MAY'		=> '5',
						'JUN'		=> '6', 	'JUNE'				=> '6',
						'JUL'		=> '7', 	'JULY'				=> '7',
						'AUG'		=> '8', 	'AUGUST'			=> '8',
						'SEP'		=> '9', 	'SEPTEMBER'		=> '9',
						'OCT'		=> '10', 	'OCTOBER'			=> '10',
						'NOV'		=> '11', 	'NOVEMBER'		=> '11',
						'DEC'		=> '12', 	'DECEMBER'		=> '12',
						'0');
END;