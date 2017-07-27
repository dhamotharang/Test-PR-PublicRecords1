export qstring10 fixPrimRange(string pr) := 
	map(pr[1..5] = '00000' => pr[6..10],
		pr[1..4] = '0000'  => pr[5..10],
		pr[1..3] = '000'   => pr[4..10],
		pr[1..2] = '00'    => pr[3..10],
		pr[1]    = '0'     => pr[2..10],
		pr);