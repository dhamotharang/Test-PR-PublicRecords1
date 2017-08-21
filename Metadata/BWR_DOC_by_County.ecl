//DOC by County by John J. Bulten 20070615 20070820 W20080130-104303 W20080211-124415 W20080603-202448

t1 := table(Corrections.AllOffenses,{county_of_origin,orig_state},county_of_origin,orig_state);
t2 := table(Corrections.File_Offenses_In_Accurint,{cty_conv,off_date},cty_conv,off_date);

d1:='19010101';
d2:='20080603';

output(table(t1,
  {county_of_origin,orig_state,count(group)},county_of_origin,orig_state),all);

output(table(Corrections.AllOffenses/*(orig_state='KY')*/,
  {county_of_origin,min(group,if(off_date<>'',off_date,d2)),max(group,off_date),count(group)},county_of_origin),all);
output(table(Corrections.File_Offenses_In_Accurint/*(vendor='KY')*/,
  {cty_conv,min(group,if(off_date<>'',off_date,d2)),max(group,off_date),count(group)},cty_conv),all);
output(table(Corrections.AllOffenses/*(orig_state='KY')*/,
  {county_of_origin,off_date/*[1..4]*/,count(group)},county_of_origin,off_date/*[1..4]*/),all);
output(table(Corrections.File_Offenses_In_Accurint/*(vendor='KY')*/,
  {cty_conv,off_date/*[1..4]*/,count(group)},cty_conv,off_date/*[1..4]*/),all);