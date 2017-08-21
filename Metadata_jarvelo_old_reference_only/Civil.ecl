export Civil := 'todo';

dDev := civil_court.File_Moxie_Party_Prod(vendor='06');

rDev
:=
  record
	dDev.vendor;
	dDev.dt_first_reported;
	dDev.dt_last_reported;
  unsigned8 Total := count(group);
  end;

dDevTable	:=	table(dDev,rDev,vendor,dt_first_reported,dt_last_reported,few);
output(sort(dDevTable,vendor,dt_first_reported,dt_last_reported),all,named('Dev'));

parallel(
output(sortDevTable(vendor='AL'),all),
output(sortDevTable(vendor='KY'),all),
output(sortDevTable(vendor='MA'),all),
output(sortDevTable(vendor='MD'),all),
output(sortDevTable(vendor='ME'),all),
output(sortDevTable(vendor='MN'),all),
output(sortDevTable(vendor='MS'),all),
output(sortDevTable(vendor='MT'),all),
output(sortDevTable(vendor='NC'),all),
output(sortDevTable(vendor='ND'),all),
output(sortDevTable(vendor='NE'),all),
output(sortDevTable(vendor='NH'),all),
output(sortDevTable(vendor='NM'),all),
output(sortDevTable(vendor='NV'),all),
output(sortDevTable(vendor='OH'),all),
output(sortDevTable(vendor='OK'),all),
output(sortDevTable(vendor='OR'),all),
output(sortDevTable(vendor='SC'),all),
output(sortDevTable(vendor='SD'),all),
output(sortDevTable(vendor='TX'),all),
output(sortDevTable(vendor='UT'),all),
output(sortDevTable(vendor='VT'),all),
output(sortDevTable(vendor='WI'),all),
output(sortDevTable(vendor='WY'),all),
output(sortDevTable(vendor='LA'),all),
output(sortDevTable(vendor='MI'),all),
output(sortDevTable(vendor='MO'),all),
output(sortDevTable(vendor='NJ'),all),
output(sortDevTable(vendor='NY'),all),
output(sortDevTable(vendor='PA'),all),
output(sortDevTable(vendor='TN'),all),
output(sortDevTable(vendor='VA'),all),
output(sortDevTable(vendor='WA'),all)
);