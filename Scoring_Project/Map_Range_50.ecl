EXPORT Map_Range_50 (STRING x) := FUNCTION
RETURN MAP(  (integer)x < -1 => '<(-1)',
						 (integer)x = -1 => '-1',
						 (integer)x = 0 => '000',
						 (integer)x between 01  and 50  => '001-050',
             (integer)x between 51 and 100   => '051-100',
             (integer)x between 101 and 150  => '101-150',
             (integer)x between 151 and 200  => '151-200',
             (integer)x between 201 and 250  => '201-250',
             (integer)x between 251 and 300  => '251-300',
             (integer)x between 301 and 350  => '301-350',
             (integer)x between 351 and 400  => '351-400',
             (integer)x between 401 and 450  => '401-450',
             (integer)x between 451 and 500  => '451-500',
             (integer)x > 500 => '> 500',
						 'UNDEFINED' );
END;			