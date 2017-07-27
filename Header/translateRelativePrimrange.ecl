export string25 translateRelativePrimrange(integer2 pr) := 
map(pr = -1 	=> 'By SSN',
    pr = -2 	=> 'By Shared Associates',
    pr = -3 	=> 'By Address',   					//see Header.Relatives_By_Address, line 15
		pr >  0 	=> 'By Address',
		pr = -4 	=> 'By Business',
		pr = -5 	=> 'By Property',
		pr = -6 	=> 'By Vehicle',
		'');
