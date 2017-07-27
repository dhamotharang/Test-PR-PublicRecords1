//this attribute is accompanied by checking two input DOBs have >=13 yrs difference
ccyy(integer4 dt) := dt div 10000;
mm(integer4 dt) := (dt % 10000) div 100;
dd(integer4 dt) := dt % 100;

//1. cc match, yy first digit typo or reverse, mm match, dd null
//2. mmdd not null, match
export dob_similar(integer4 l, integer4 r) := 
                    ccyy(l) div 100 = ccyy(r) div 100 and     
                    (abs(ccyy(l) - ccyy(r)) in [20, 30, 40, 50, 60, 70, 80, 90] or 
		          (ccyy(l) % 10) = (ccyy(r) % 100) div 10 and 
		          (ccyy(r) % 10) = (ccyy(l) % 100) div 10) and 
                    mm(l) = mm(r) and mm(l) > 1 and (dd(l) <=1 or dd(r) <=1) or  
                    mm(l) = mm(r) and mm(l) > 1 and dd(l) = dd(r) and dd(l) > 1;         
