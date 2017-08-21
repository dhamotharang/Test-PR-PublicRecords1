// Arrests by County Date by jjb W20080118-142643 W20080603-184256

d1:=18010101;
d2:=20080603;

t1:=table(Crim_Common.File_In_Arrest_Offender,{offender_key,state_origin,source_file,dt1:=(integer8)case_filing_dt,ace_fips_st,ace_fips_county});
t2:=table(Crim_Common.File_In_Arrest_Offenses,{offender_key,state_origin,source_file,dt2:=(integer8)arr_date,dt3:=(integer8)arr_disp_date,dt4:=(integer8)off_date});

t0:=dedup(join(t1,t2,left.offender_key=right.offender_key));

output(table(t0,
  {state_origin,source_file,count(group),
   min(group,map(dt1>d1 and dt1<d2=>dt1,dt2>d1 and dt2<d2=>dt2,dt3>d1 and dt3<d2=>dt3,dt4>d1 and dt3<d2=>dt4,d2)),
   max(group,map(dt1>d1 and dt1<d2=>dt1,dt2>d1 and dt2<d2=>dt2,dt3>d1 and dt3<d2=>dt3,dt4>d1 and dt3<d2=>dt4,d1))},
  state_origin,source_file),all);