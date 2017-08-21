//W20080402-093457 20081022-125502-133018 Crim by Source Date jjb and Tammy Gibson
//Some content was formerly at "Metadata.BWR_CrimCourt_by_Source_Cty"

d1:=18010101;
d2:=20081022;

offenderFile := distribute(dataset('~thor_data400::base::crim_offender2_did_' + Crim_Common.Version_Development,Crim_Common.Layout_Moxie_Crim_Offender2,flat),hash(offender_key));
offensesFile := distribute(dataset('~thor_data400::base::court_offenses_' + Crim_Common.Version_Development,Crim_Common.Layout_Moxie_Court_Offenses,flat),hash(offender_key));

t1:=table(offenderFile,{offender_key,state_origin,source_file,dt1:=(integer8)case_filing_dt,ace_fips_st,ace_fips_county});
t2:=table(offensesFile,{offender_key,state_origin,source_file,dt2:=(integer8)arr_date,dt3:=(integer8)arr_disp_date,dt4:=(integer8)off_date});
t3:=table(offensesFile,{offender_key,state_origin,source_file,dt5:=(integer8)process_date});

t0:=dedup(join(t1,t2,left.offender_key=right.offender_key));

//Best date
output(sort(table(t0,
  {state_origin,source_file,ace_fips_county,count(group),
   min(group,map((dt1>d1 and dt1<d2)=>dt1,(dt2>d1 and dt2<d2)=>dt2,(dt3>d1 and dt3<d2)=>dt3,(dt4>d1 and dt4<d2)=>dt4,d2)),
   max(group,map((dt1>d1 and dt1<d2)=>dt1,(dt2>d1 and dt2<d2)=>dt2,(dt3>d1 and dt3<d2)=>dt3,(dt4>d1 and dt4<d2)=>dt4,d1))},
  state_origin,source_file,ace_fips_county,few),state_origin,source_file,ace_fips_county),all);
  
//Process date: currently yields skew error
//output(table(t3,{state_origin,source_file,min(group,dt5),max(group,dt5),count(group)},state_origin,source_file),all);