export DL_Filter_Vendor := 'todo';

dDev	:=	Drivers.File_DL(orig_state='ID' AND source_code = 'AX');

rDev
 :=
  record
	dDev.orig_state;
	dDev.lic_issue_date;
	unsigned8	Total	:=	count(group);
  end
 ;

dDevTable	:=	table(dDev,rDev,orig_state,lic_issue_date,few);

output(sort(dDevTable,orig_state,lic_issue_date),all,named('Dev'));

