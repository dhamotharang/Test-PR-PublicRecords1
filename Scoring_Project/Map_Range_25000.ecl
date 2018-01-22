EXPORT Map_Range_25000(STRING x) := FUNCTION
RETURN MAP(  (integer)x < -1 => '<(-1)',
						 (integer)x = -1 => '-1',
						 (integer)x = 0 => '00000',
						 (integer)x between 00001 and 25000  => '00001-25000',
             (integer)x between 25001 and 50000  => '25001-50000',
             (integer)x between 50001 and 75000  => '50001-75000',
             (integer)x between 75001 and 100000 => '75001-100000',
             (integer)x > 100000 => '> 100000',
						 'UNDEFINED' );
END;