export Watercraft_Title_Issue := 'todo';

dDev	:=	Watercraft.file_base_main_prod(state_origin='DE');

rDev
 :=
  record
	dDev.state_origin;
	dDev.title_issue_date;
	unsigned8	Total	:=	count(group);
  end;

dDevTable	:=	table(dDev,rDev,state_origin,title_issue_date,few);

output(sort(dDevTable,state_origin,title_issue_date),all,named('Dev'));