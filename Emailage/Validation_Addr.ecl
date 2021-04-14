addr := $.AllFiles.dsaddress;

//Actual=384,001,084 ,Expected=non-zero
output(count(addr(Allowed_for_GLB=true and Allowed_for_nonGLB=true)), named('addr_both_glb_and_nonglb_true'));
//Actual=162,542,511,Expected=non-zero
output(count(addr(Allowed_for_GLB=true and Allowed_for_nonGLB=false)), named('addr_glb_only_true'));
//Actual=0,Expected=zero
output(count(addr(Allowed_for_GLB=false and Allowed_for_nonGLB=true)), named('addr_nonglb_only_true'));

//Actual=18,245,786,Expected=zero
output(count(addr(
	    Allowed_for_nonGLB=true
	and Address_Date_First_Seen_for_nonGLB = 0
	and Address_Date_Last_Seen_for_nonGLB = 0))
,named('nonglb_dates_zero'));
// addr(
// 	    Allowed_for_nonGLB=true
// 	and Address_Date_First_Seen_for_nonGLB = 0
// 	and Address_Date_Last_Seen_for_nonGLB = 0);

//Actual=0,Expected=zero
output(count(addr(
	    Allowed_for_GLB=true
	and Address_Date_First_Seen_for_GLB = 0
	and Address_Date_Last_Seen_for_GLB  = 0))
,named('glb_dates_zero'));

// addr(
// 	    Allowed_for_GLB=true
// 	and Address_Date_First_Seen_for_GLB = 0
// 	and Address_Date_Last_Seen_for_GLB  = 0);


