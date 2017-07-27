export INTEGER2 date_quality(integer4 date) := 
	MAP(date < 10000000 => 0,
	    date % 10000 = 101 => 3,
	    date % 100 > 1 => 6,
	    date % 100 = 1 => 5,
	    date % 1000 > 100 => 4,
	    date % 10000 = 1100 => 4,
	    date % 10000 = 1000 => 4,  
	    date % 1000 = 100 => 3,2);