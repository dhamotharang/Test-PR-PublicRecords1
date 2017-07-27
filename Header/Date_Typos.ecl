//Not not equal day or month
month_day_nneq(integer2 l,integer2 r) := l<2 or r<2 or l=r;

//Function to determine if left dob is a typo of right dob
export date_typos(integer4 l, integer4 r) := l div 10000=r div 10000 and
						(((l%10000) div 100 =(r%10000) div 100 and abs(l%100-r%100)<=10) or 
						  l%100=r%100 and abs((l%10000) div 100-(r%10000) div 100)<=3 or
						  month_day_nneq((l%10000) div 100,r%100) and month_day_nneq((r%10000) div 100,l%100)) or
						 (abs(l div 10000-r div 10000)<=3 and
						  month_day_nneq((l%10000) div 100,(r%10000) div 100) and month_day_nneq(l%100,r%100));