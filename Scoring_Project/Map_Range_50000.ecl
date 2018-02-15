EXPORT STRING Map_Range_50000 (STRING x) := FUNCTION
RETURN MAP(  (integer)x < -1 => '<(-1)',
						 (integer)x = -1 => '-1',
						 (integer)x = 0 => '00000',
						 (integer)x between 00001  and 50000  => '00001-50000',
             (integer)x between 50001 and 100000  => '50001-100000',
             (integer)x between 100001 and 150000  => '100001-150000',
             (integer)x between 150001 and 200000  => '150001-200000',
             (integer)x between 200001 and 250000  => '200001-250000',
             (integer)x > 250000 => '> 250000',
						 'UNDEFINED' );
END;

