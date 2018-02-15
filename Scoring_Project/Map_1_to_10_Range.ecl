EXPORT Map_1_to_10_Range (STRING x) := FUNCTION
RETURN MAP(  (integer)x < -1 => '<(-1)',
						 (integer)x = -1 => '-1',
						 (integer)x = 0 => '0',
						 (integer)x = 1 => '1',
						 (integer)x = 2 => '2',
						 (integer)x = 3 => '3',
						 (integer)x = 4 => '4',
						 (integer)x = 5 => '5',
						 (integer)x = 6 => '6',
						 (integer)x = 7 => '7',
						 (integer)x = 8 => '8',
						 (integer)x = 9 => '9',
						 (integer)x = 10 => '10',
             (integer)x > 10 => '> 10',
						 'UNDEFINED' );
END;