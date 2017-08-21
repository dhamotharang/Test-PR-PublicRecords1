export Watercraft_Registration_Renewal := 'todo';

dDev	:=	Watercraft.file_base_main_prod(state_origin='DE');

rDev
 :=
  record
	dDev.state_origin;
	dDev.registration_renewal_date;
	unsigned8	Total	:=	count(group);
  end;

dDevTable	:=	table(dDev,rDev,state_origin,registration_renewal_date,few);

output(sort(dDevTable,state_origin,registration_renewal_date),all,named('Dev'));