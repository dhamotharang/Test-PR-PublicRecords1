// Crim by State Date W20071231-173927
// Crim by County Date 
// Crim FL by Date W20071231-174137
// Crim Clark WA by Name W20080605-160154

t1:=distribute(table(CrimSrch.File_Court_Offenses,{state_origin,source_file,offender_key}),hash32(offender_key));
d1:='18010101';
d2:='20080603';
//output(choosen(table(t1,{state_origin,source_file,count(group)},state_origin,source_file,unsorted),all));
/*output(table(CrimSrch.File_Court_Offenses,
  {state_origin,
   min(group,if(arr_date<d1,d2,arr_date)),
   max(group,arr_date),
   count(group)},
  state_origin,all));
*//*output(table(CrimSrch.File_Court_Offenses,
  {state_origin,source_file,
   min(group,if(arr_date<'18000101','20080324',arr_date)),
   max(group,arr_date),
   count(group)},
  state_origin,source_file,all));
*//*output(table(CrimSrch.File_Court_Offenses(state_origin='FL'),
  {arr_date,
   count(group)},
  arr_date),all);
*//*output(table(t1,
  {state_origin,source_file,
   count(group)},
  state_origin,source_file,all));
*///output(choosen(Crim_Common.File_In_Court_Offender(state_origin='WA',source_file='(CV)WA-ClarkCtyArr  ',orig_lname='WILLIAMS',orig_fname='DAVID'),2000));
//output(table(CrimSrch.File_Court_Offenses,{source_file,count(group)},source_file),all);