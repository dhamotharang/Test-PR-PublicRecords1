export DOB_Match_Score(integer dob1, integer dob2) := 
MAP(dob1 < 10000000 or dob2 < 10000000 or
     dob1=0 or dob2=0 => 255,  //invalid or missing date
	 dob1=dob2=>100,           //perfect match
	 (dob1 DIV 100)=(dob2 DIV 100) and     //one date has yyyymm01 or yyyymm00
	   (dob1%100<=1 or dob2%100<=1)=>80, 
	 (dob1 DIV 100)=(dob2 DIV 100)=>60,	   //same month different days
	 (dob1 DIV 10000)=(dob2 DIV 10000) and (dob1%10000=100 or //one date has yyyy0101 or yyyy0100 or yyyy0000
	   dob1%10000=101 or dob1%10000=0 or 
	   dob2%10000=100 or dob2%10000=101 or dob2%10000=0)=>40, 
	 dob1 DIV 10000=dob2 DIV 10000=>20,0);  //same year different month and day