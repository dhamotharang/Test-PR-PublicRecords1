EXPORT Map_Range_12_to_100 (STRING x) := FUNCTION
RETURN MAP(  (integer)x < -1 => '<(-1)',
						 (integer)x = -1 => '-1',
						 (integer)x = 0  => '000',
						 (integer)x between 001  and 012  => '001-012',
             (integer)x between 013 and 024  => '013-024',
             (integer)x between 025 and 036  => '025-036',
             (integer)x between 037 and 048  => '037-048',
             (integer)x between 049 and 060  => '049-060',
             (integer)x between 061 and 072  => '061-072',
             (integer)x between 073 and 084  => '073-084',
             (integer)x between 085 and 096  => '085-096',
             (integer)x between 097 and 100  => '097-100',
             (integer)x > 100 => '> 100',
						 'UNDEFINED' );
END;	