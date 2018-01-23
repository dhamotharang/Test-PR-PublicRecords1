EXPORT STRING Map_Range_10 (STRING x) := FUNCTION
RETURN MAP(  (integer)x < -1 => '<(-1)',
						 (integer)x = -1 => '-1',
						 (integer)x = 0 => '00',
						 (integer)x between 01  and 10  => '01-10',
             (integer)x between 11 and 20  => '11-20',
             (integer)x between 21 and 30  => '21-30',
             (integer)x between 31 and 40  => '31-40',
             (integer)x between 41 and 50  => '41-50',
             (integer)x between 51 and 60  => '51-60',
             (integer)x between 61 and 70  => '61-70',
             (integer)x between 71 and 80  => '71-80',
             (integer)x between 81 and 90  => '81-90',
             (integer)x between 91 and 100 => '91-100',
             (integer)x > 100 => '> 100',
						 'UNDEFINED' );
END;			
