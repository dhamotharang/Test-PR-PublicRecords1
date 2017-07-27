import ut,did_add;

getmonth(integer m) := (m div 100) % 100;
getday(integer d) := d % 100;

eq(integer l, integer r) := l=r or l<=1 or r<=1;

export sig_near_dob(integer l, integer r) :=  l<>0 and 
										  ( abs(ut.mob(l)-ut.mob(r))<900 and 
											eq(getmonth(l), getmonth(r)) and 
											eq(getday(l), getday(r)) );