export propagate_dob(integer4 low_dob, integer4 dob) :=
FUNCTION

RETURN

map( (low_dob % 10000 = 0 or low_dob % 10000 = 101 or low_dob % 10000 = 100)
						and low_dob div 10000 = dob div 10000 => dob,
					 (low_dob % 100 = 0 or low_dob % 100 = 1 )
						and low_dob div 100 = dob div 100 => dob,
					 low_dob = 0 => dob,
					 low_dob);
					 
END;