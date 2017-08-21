ds_offender := doc.map_doc_ri_offender;
ds_offenses := doc.map_doc_ri_offenses;
ds_punishment := doc.map_doc_ri_punishment;

rPopulationStats_offender_race
 :=
record
race_desc	:= ds_offender.race_desc;
CountGroup                                  := count(group); 
end;
tStats_offender_race := table(ds_offender,rPopulationStats_offender_race,race_desc,few);
output(choosen(sort(tStats_offender_race,race_desc),1000));


rPopulationStats_offenses_off_date
 :=
  record
off_date := ds_offenses.off_date[1..6];
CountGroup                                       := count(group); 
end;
tStats_offenses_off_date := table(ds_offenses,rPopulationStats_offenses_off_date,off_date[1..6],few);
output(choosen(sort(tStats_offenses_off_date,off_date),1000));

rPopulationStats_offenses_inc_adm_dt
 :=
  record
inc_adm_dt := ds_offenses.inc_adm_dt[1..6];
CountGroup                                       := count(group); 
//off_desc_1_AveNonBlank := AVE(group,if(ds_offenses.off_desc_1<>'',100,0));
end;
tStats_offenses_inc_adm_dt := table(ds_offenses,rPopulationStats_offenses_inc_adm_dt,inc_adm_dt[1..6],few);
output(choosen(sort(tStats_offenses_inc_adm_dt,inc_adm_dt),1000));

rPopulationStats_offenses_off_desc_1
 :=
  record
off_desc_1 := ds_offenses.off_desc_1;
CountGroup                                       := count(group); 
end;
tStats_offenses_off_desc_1 := table(ds_offenses,rPopulationStats_offenses_off_desc_1,off_desc_1,few);
output(choosen(sort(tStats_offenses_off_desc_1,off_desc_1),1000));


rPopulationStats_punishment_punishment_type
 :=
  record
  punishment_type := ds_punishment.punishment_type;
CountGroup                                       := count(group); 
end;
tStats_punishment_punishment_type := table(ds_punishment,rPopulationStats_punishment_punishment_type,punishment_type,few);
output(choosen(sort(tStats_punishment_punishment_type,punishment_type),1000));

rPopulationStats_punishment_latest_adm_dt
 :=
  record
  latest_adm_dt := ds_punishment.latest_adm_dt[1..6];
CountGroup                                       := count(group); 
end;
tStats_punishment_latest_adm_dt := table(ds_punishment,rPopulationStats_punishment_latest_adm_dt,latest_adm_dt[1..6],few);
output(choosen(sort(tStats_punishment_latest_adm_dt,latest_adm_dt),1000));

rPopulationStats_punishment_sch_rel_dt
 :=
  record
  sch_rel_dt := ds_punishment.sch_rel_dt[1..6];
CountGroup                                       := count(group); 
end;
tStats_punishment_sch_rel_dt := table(ds_punishment,rPopulationStats_punishment_sch_rel_dt,sch_rel_dt[1..6],few);
output(choosen(sort(tStats_punishment_sch_rel_dt,sch_rel_dt),1000));
