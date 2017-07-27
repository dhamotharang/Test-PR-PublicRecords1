export FirstNonBlank(pick, t1, t2, t3, t4, a1, a2, a3, a4) := 
MACRO
	CHOOSE(if(pick != 0, pick,
		  MAP(t1 != '' => 1, t2 != '' => 2, t3 != '' => 3, 4)),
		  
		  
		  a1, a2, a3, a4)

ENDMACRO;