EXPORT STRING Map_Range_100 (STRING x) := FUNCTION
RETURN MAP(  (integer)x < -1 => '<(-1)',
						 (integer)x = -1 => '-1',
						 (integer)x = 0  => '000',
						 (integer)x between 001  and 100  => '001-100',
             (integer)x between 101 and 200  => '101-200',
             (integer)x between 201 and 300  => '201-300',
             (integer)x between 301 and 400  => '301-400',
             (integer)x between 401 and 500  => '401-500',
             (integer)x between 501 and 600  => '501-600',
             (integer)x between 601 and 700  => '601-700',
             (integer)x between 701 and 800  => '701-800',
             (integer)x between 801 and 900  => '801-900',
             (integer)x between 901 and 1000 => '901-1000',
             (integer)x > 1000 => '> 1000',
						 'UNDEFINED' );
END;	