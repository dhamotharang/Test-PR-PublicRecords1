//W20080118-134512 20080905-151310 20080904-121128 Prop Assess by County
t5 := table(LN_PropertyV2.File_Assessment,{fips_code,recording_date});
dt5 := '20080904';
output(table(t5(recording_date between '18990102' and dt5/*,fips_code='48135'*/),{fips_code,min(group,recording_date),max(group,recording_date),count(group)},fips_code),all);