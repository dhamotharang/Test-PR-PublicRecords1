export bviScore(INTEGER1 p, INTEGER1 b, BOOLEAN OFAC) := FUNCTION

vi := CASE(p,
		0 => MAP(b IN [0,1] => '00',
			    b = 2 => '20',
			    b = 3 => '30',
			    b = 4 => '40',
			    b IN [5,6] => '50',
			    ''),
		
		1 => MAP(b IN [0,1] => '00',
			    b = 2 => '20',
			    b = 3 => '30',
			    b = 4 => '40',
			    b IN [5,6] => '50',
			    ''),
			    
		2 => MAP(b IN [0,1] => '10',
			    b IN [2,3] => '20',
			    b = 4 => '30',
			    b = 5 => '40',
			    b = 6 => '50',
			    ''),
			    
		3 => MAP(b IN [0,1,2] => '20',
			    b IN [3,4] => '40',
			    b IN [5,6] => '50',
			    ''),
		4 => MAP(b IN [0,1,2,3] => '30',
			    b = 4 => '40',
			    b IN [5,6] => '50',
			    ''),
		5 => MAP(b IN [0,1,2,3,4] => '40',
			    b IN [5,6] => '50',
			    ''),
		6 => MAP(b IN [0,1,2,3,4,5,6] => '50',''),
		'');

// if ofac hit (reasoncode 32), override the score to a 10
bvi := if(ofac, '10', vi);						
RETURN (bvi);

end;