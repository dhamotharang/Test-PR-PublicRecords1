//edited from MVR.ecl by John J. Bulten 20070518
//W20070622-102425 Jason's business rules (minimal year/1960)
//W20070626-115518 Tony's business rules (threshold/20/50/35/20)
//W20080227-092133 results C-H (1-6), J-N (8-12); -093808 results I, A, B (1-3)
//W20080421-092435 MVR by State Type
//W20080605-170502 all results
//W20080919-132304 20080917-171700 results C-E (Effective date), O-R (Hand breakdown)
//W20081006-163431 results A-N (1-14)

d1:=15010101; //Min
d2:=20080919; //Max
d3:=19600101; //Threshold for Jason
thr1:=20; thr2:=50; thr3:=35; thr4:=20; //Thresholds for Tony

statelist := [
'AK','AL','AR','AZ','CA','CO','CT','DE','FL','GA',
'HI','IA','ID','IL','IN','KS','KY','LA','MA','MD',
'ME','MI','MN','MO','MS','MT','NC','ND','NE','NH',
'NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC',
'SD','TN','TX','UT','VA','VT','WA','WI','WV','WY',
'AA','AE','AP','AS','CM','CZ','DC','FM','GU','MH',
'MP','PI','PR','PW','TT','UM','VI','AB','BC','MB',
'NB','NL','NS','NT','NU','ON','PE','QC','SK','YT',
'CB','GL','LB','NF','PQ','QU','YK'];

dDev := VehicleV2.file_vehicleV2_party(orig_state in statelist);
//output(table(dDev(orig_state='NC'),{vehicle_type,count(group)},vehicle_type));

rDev1 := record
  dDev.orig_state;
  dDev.source_code;
  integer4 Year1:=(integer4)dDev.reg_earliest_effective_date DIV 10000;
  min(group,dDev.reg_earliest_effective_date);
  max(group,dDev.reg_earliest_effective_date);
  cnt6:=count(group);
end;

rDev2 := record
  dDev.orig_state;
  dDev.source_code;
  integer4 Year1:=(integer4)dDev.ttl_earliest_issue_date DIV 10000;
  min(group,dDev.ttl_earliest_issue_date);
  max(group,dDev.ttl_earliest_issue_date);
  cnt6:=count(group);
end;

rDev3 := record
  dDev.orig_state;
  dDev.source_code;
  integer4 Year1:=(integer4)dDev.reg_first_date DIV 10000;
  min(group,dDev.reg_first_date);
  max(group,dDev.reg_first_date);
  cnt6:=count(group);
end;

rDev4 := record
  dDev.orig_state;
  dDev.source_code;
  integer4 Year1:=(integer4)dDev.ttl_previous_issue_date DIV 10000;
  min(group,dDev.ttl_previous_issue_date);
  max(group,dDev.ttl_previous_issue_date);
  cnt6:=count(group);
end;

dDev1:=dDev //Outlier exclusion
  (not(reg_earliest_effective_date='19010101'),
   not(orig_state='FL' and source_code='AE' and reg_earliest_effective_date='17960211'),
   not(orig_state='ME' and source_code='DI' and (integer)reg_earliest_effective_date<19100000),
   not(orig_state='OH' and source_code='DI' and reg_earliest_effective_date='19000000'),
   not(orig_state='OK' and source_code='AE' and (reg_earliest_effective_date='19001110'
                                                 or reg_earliest_effective_date='19011118')),
   not(orig_state='TX' and source_code='DI' and (integer)reg_earliest_effective_date DIV 10000=1901));

dDev2:=dDev //Outlier exclusion
  (not(orig_state='CT' and source_code='AE' and ttl_earliest_issue_date='19110111'),
   not(orig_state='LA' and source_code='AE' and ttl_earliest_issue_date='19111111'),
   not(orig_state='MT' and source_code='DI' and (integer)ttl_earliest_issue_date DIV 10000=1901),
   not(orig_state='NM' and source_code='DI' and ttl_earliest_issue_date='19010101'),
   not(orig_state='OK' and source_code='AE' and (integer)ttl_earliest_issue_date DIV 10000=1919));

dDev3:=dDev //Outlier exclusion
  (not(orig_state='MA' and source_code='AE' and reg_first_date='19000317'),
   not(orig_state='MI' and source_code='AE' and reg_first_date='19000601'),
   not(orig_state='ND' and source_code='AE' and reg_first_date='19010101'),
   not(orig_state='NM' and source_code='AE' and reg_first_date='19010101'));

dDev4:=dDev //Outlier exclusion
  (not(orig_state='FL' and source_code='DI' and ttl_previous_issue_date<='19010101'),
   not(orig_state='NM' and source_code='DI' and ttl_previous_issue_date='19010101'));

//Curr reg min Jason
output(sort(table(dDev1((integer)reg_earliest_effective_date>=d3),{orig_state,source_code,min(group,dDev.reg_earliest_effective_date),count(group),'A'},orig_state,source_code,few),orig_state,source_code),all);

//Title min Jason
output(sort(table(dDev2((integer)ttl_earliest_issue_date>=d3),{orig_state,source_code,min(group,dDev.ttl_earliest_issue_date),count(group),'B'},orig_state,source_code,few),orig_state,source_code),all);

//Curr reg
output(sort(table(dDev1((integer)reg_earliest_effective_date>d1),{orig_state,source_code,min(group,dDev.reg_earliest_effective_date),count(group),'C'},orig_state,source_code,few),orig_state,source_code),all);
td1:=sort(table(dDev1((integer)reg_earliest_effective_date BETWEEN d1 AND d2),rDev1,
                orig_state,source_code,(integer4)dDev.reg_earliest_effective_date DIV 10000,few),orig_state,source_code,Year1);
output(sort(table(td1(cnt6>=thr1),{orig_state,source_code,min(group,Year1),count(group),'D'},orig_state,source_code),orig_state,source_code),all);
output(sort(table(dDev1((integer)reg_earliest_effective_date<d2),{orig_state,source_code,max(group,dDev.reg_earliest_effective_date),count(group),'E'},orig_state,source_code,few),orig_state,source_code),all);

//Title
output(sort(table(dDev2((integer)ttl_earliest_issue_date>d1),{orig_state,source_code,min(group,dDev.ttl_earliest_issue_date),count(group),'F'},orig_state,source_code,few),orig_state,source_code),all);
td2:=sort(table(dDev2((integer)ttl_earliest_issue_date BETWEEN d1 AND d2),rDev2,
                orig_state,source_code,(integer4)dDev.ttl_earliest_issue_date DIV 10000,few),orig_state,source_code,Year1);
output(sort(table(td2(cnt6>=thr2),{orig_state,source_code,min(group,Year1),count(group),'G'},orig_state,source_code),orig_state,source_code),all);
output(sort(table(dDev2((integer)ttl_earliest_issue_date<d2),{orig_state,source_code,max(group,dDev.ttl_earliest_issue_date),count(group),'H'},orig_state,source_code,few),orig_state,source_code),all);

//Orig reg
output(sort(table(dDev3((integer)reg_first_date>d1),{orig_state,source_code,min(group,dDev.reg_first_date),count(group),'I'},orig_state,source_code,few),orig_state,source_code),all);
td3:=sort(table(dDev3((integer)reg_first_date BETWEEN d1 AND d2),rDev3,
                orig_state,source_code,(integer4)dDev.reg_first_date DIV 10000,few),orig_state,source_code,Year1);
output(sort(table(td3(cnt6>=thr3),{orig_state,source_code,min(group,Year1),count(group),'J'},orig_state,source_code),orig_state,source_code),all);
output(sort(table(dDev3((integer)reg_first_date<d2),{orig_state,source_code,max(group,dDev.reg_first_date),count(group),'K'},orig_state,source_code,few),orig_state,source_code),all);

//Plate
output(sort(table(dDev4((integer)ttl_previous_issue_date>d1),{orig_state,source_code,min(group,dDev.ttl_previous_issue_date),count(group),'L'},orig_state,source_code,few),orig_state,source_code),all);
td4:=sort(table(dDev4((integer)ttl_previous_issue_date BETWEEN d1 AND d2),rDev4,
                orig_state,source_code,(integer4)dDev.ttl_previous_issue_date DIV 10000,few),orig_state,source_code,Year1);
output(sort(table(td4(cnt6>=thr4),{orig_state,source_code,min(group,Year1),count(group),'M'},orig_state,source_code),orig_state,source_code),all);				   
output(sort(table(dDev4((integer)ttl_previous_issue_date<d2),{orig_state,source_code,max(group,dDev.ttl_previous_issue_date),count(group),'N'},orig_state,source_code,few),orig_state,source_code),all);

//Breakdown by year for analysis by hand
output(sort(table(dDev((integer)reg_earliest_effective_date BETWEEN d1 AND d2),rDev1,
                   orig_state,source_code,(integer4)dDev.reg_earliest_effective_date DIV 10000,few),orig_state,source_code,Year1),all);
output(sort(table(dDev((integer)ttl_earliest_issue_date BETWEEN d1 AND d2),rDev2,
                   orig_state,source_code,(integer4)dDev.ttl_earliest_issue_date DIV 10000,few),orig_state,source_code,Year1),all);
output(sort(table(dDev((integer)reg_first_date BETWEEN d1 AND d2),rDev3,
                   orig_state,source_code,(integer4)dDev.reg_first_date DIV 10000,few),orig_state,source_code,Year1),all);
output(sort(table(dDev((integer)ttl_previous_issue_date BETWEEN d1 AND d2),rDev4,
                   orig_state,source_code,(integer4)dDev.ttl_previous_issue_date DIV 10000,few),orig_state,source_code,Year1),all);