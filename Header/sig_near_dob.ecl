import ut,did_add;

getyear(integer y) := y DIV 10000;
getmonth(integer m) := (m div 100) % 100;
getday(integer d) := d % 100;

eq(integer l, integer r) := l=r or l<=1 or r<=1;
eq_no_round(integer l, integer r) := l=r ;

mmdd(integer yyyymmdd) := yyyymmdd % 10000;

greater_year(integer l, integer r) := IF(getyear(l)>getyear(r),l,r);
greater_month(integer l, integer r) := IF(mmdd(l)>mmdd(r),l,r);
greater_day(integer l, integer r) := IF(getday(l)>getday(r),l,r);

lesser_year(integer l, integer r) := IF(getyear(l)<getyear(r),l,r);
lesser_month(integer l, integer r) := IF(mmdd(l)<mmdd(r),l,r);
lesser_day(integer l, integer r) := IF(getday(l)<getday(r),l,r);

export sig_near_dob(integer l, integer r) :=	l<>0
											and
											(
												// Standard	 - plus or minus eight years appart
												(	abs(ut.mob(l)-ut.mob(r))<900
												and eq_no_round(getmonth(l), getmonth(r))
												and	(eq_no_round(getday(l), getday(r))	OR	eq(getday(l), getday(r)))	)
												OR
												// Extended
												(	getyear(l)=getyear(r)
												and	getmonth(greater_month(l,r))=getmonth(lesser_month(l,r))+1
												and	getday(greater_month(l,r)) <= 1)
												OR
												// Extended 2
												(
														(getyear(l)=getyear(r)
												or	getyear(greater_year(l,r))=getyear(lesser_year(l,r))+1)
												and	((getmonth(greater_year(l,r))=0 and getday(greater_year(l,r))=0)
												or	(getmonth(greater_year(l,r))=1 and getday(greater_year(l,r))=1))
												)
											)
											;