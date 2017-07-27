export boolean isMatchablePhone(unsigned6 p) := 
	p > 999999999 and  //not zero and has at least 10 digits
	p % 10000000 > 0 and //does not end in 0000000
	((string10)p)[1..3] <> '111' and	//old rule
	((string10)p) not in Business_Header.Frequent_Phones; //old rule