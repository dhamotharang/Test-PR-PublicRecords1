export DL_Grouped := 'todo';

dDev	:=	Drivers.File_DL(orig_state='WY');

rDevWithYear
 :=
  record
	dDev.orig_state;
	unsigned2	lic_issue_year	:=	dDev.lic_issue_date div 10000;
  end
 ;

dDevWithYear	:=	table(dDev,rDevWithYear);

rDevTable
 :=
  record
	dDevWithYear.orig_state;
	dDevWithYear.lic_issue_year;
	unsigned8	Total	:=	count(group);
  end
 ;

dDevTable	:=	table(dDevWithYear,rDevTable,orig_state,lic_issue_year,few);

output(sort(dDevTable,orig_state,lic_issue_year),all,named('Dev'));

