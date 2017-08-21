//W20071207-101501 20080118-133506 20080220-151015 20080904-121128 Prop DM by County
t1 := table(LN_PropertyV2.File_Deed,{lnfi:=ln_fares_id[2],document_type_code,fips_code,recording_date});
dt1 := '20080904';
output(table(t1(recording_date between '15010101' and dt1),{lnfi,fips_code,min(group,recording_date),max(group,recording_date),count(group)},lnfi,fips_code),all); 
output(table(t1(recording_date[5..8]+recording_date[1..4] between '15010101' and dt1),{lnfi,fips_code,min(group,recording_date[5..8]+recording_date[1..4]),max(group,recording_date[5..8]+recording_date[1..4]),count(group)},lnfi,fips_code),all); 
output(table(t1(recording_date[4..7]+'0'+recording_date[1..3] between '15010101' and dt1),{lnfi,fips_code,min(group,recording_date[4..7]+'0'+recording_date[1..3]),count(group),max(group,recording_date[4..7]+'0'+recording_date[1..3]),count(group)},lnfi,fips_code),all); 

//W20071207-101501 20080904-121128 Prop DM by Doctype
output(table(t1,{document_type_code,count(group)},document_type_code),all);