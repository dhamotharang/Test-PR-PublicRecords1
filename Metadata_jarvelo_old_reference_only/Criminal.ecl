export Criminal := 'todo';

dDev	:=	CrimSrch.file_court_offenses(vendor='29');

rDev
 :=
  record
	dDev.vendor;
	dDev.off_date;
	dDev.arr_date;
	dDev.appeal_date;
	unsigned8	Total	:=	count(group);
  end;

dDevTable	:=	table(dDev,rDev,vendor,off_date,arr_date,appeal_date,few);

output(sort(dDevTable,vendor,off_date,arr_date,appeal_date),all,named('Dev'));