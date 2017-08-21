export UCC_Filings := 'todo';

dDev := UCC.File_UCC_Filing_Events_Temp;


rDev
:=
  record
dDev.file_state;
dDev.filing_date;
unsigned8 Total := count(group);
  end;

dDevTable := table(dDev,rDev,file_state,filing_date,few);
sortDevTable := sort(dDevTable,file_state,filing_date);

parallel(
output(sortDevTable(file_state='AL'),all),
output(sortDevTable(file_state='KY'),all),
output(sortDevTable(file_state='MA'),all),
output(sortDevTable(file_state='MD'),all),
output(sortDevTable(file_state='ME'),all),
output(sortDevTable(file_state='MN'),all),
output(sortDevTable(file_state='MS'),all),
output(sortDevTable(file_state='MT'),all),
output(sortDevTable(file_state='NC'),all),
output(sortDevTable(file_state='ND'),all),
output(sortDevTable(file_state='NE'),all),
output(sortDevTable(file_state='NH'),all),
output(sortDevTable(file_state='NM'),all),
output(sortDevTable(file_state='NV'),all),
output(sortDevTable(file_state='OH'),all),
output(sortDevTable(file_state='OK'),all),
output(sortDevTable(file_state='OR'),all),
output(sortDevTable(file_state='SC'),all),
output(sortDevTable(file_state='SD'),all),
output(sortDevTable(file_state='TX'),all),
output(sortDevTable(file_state='UT'),all),
output(sortDevTable(file_state='VT'),all),
output(sortDevTable(file_state='WI'),all),
output(sortDevTable(file_state='WY'),all),
output(sortDevTable(file_state='LA'),all),
output(sortDevTable(file_state='MI'),all),
output(sortDevTable(file_state='MO'),all),
output(sortDevTable(file_state='NJ'),all),
output(sortDevTable(file_state='NY'),all),
output(sortDevTable(file_state='PA'),all),
output(sortDevTable(file_state='TN'),all),
output(sortDevTable(file_state='VA'),all),
output(sortDevTable(file_state='WA'),all)
);