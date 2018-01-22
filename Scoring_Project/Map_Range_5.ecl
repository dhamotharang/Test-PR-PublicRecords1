EXPORT Map_Range_5(STRING x) := FUNCTION
RETURN MAP(  (integer)x < -1 => '<(-1)',
						 (integer)x = -1 => '-1',
						 (integer)x = 0 => '00',
						 (integer)x between 01  and 05  => '01-05',
             (integer)x between 06 and 10  => '06-10',
             (integer)x between 11 and 15  => '11-15',
             (integer)x between 16 and 20  => '16-20',
             (integer)x between 21 and 25  => '21-25',
             (integer)x between 26 and 30  => '26-30',
             (integer)x between 31 and 35  => '31-35',
             (integer)x between 36 and 40  => '36-40',
             (integer)x between 41 and 45  => '41-45',
             (integer)x between 46 and 50 => '46-50',
             (integer)x > 50 => '>50',
						 'UNDEFINED' );
END;	