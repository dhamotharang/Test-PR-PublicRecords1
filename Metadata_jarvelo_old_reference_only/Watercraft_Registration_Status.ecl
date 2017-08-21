export Watercraft_Registration_Status := 'todo';

dDev	:=	Watercraft.file_base_main_prod(state_origin='DE');

rDev
 :=
  record
	dDev.state_origin;
	dDev.registration_status_date;
	unsigned8	Total	:=	count(group);
  end;

dDevTable	:=	table(dDev,rDev,state_origin,registration_status_date,few);

output(sort(dDevTable,state_origin,registration_status_date),all,named('Dev'));