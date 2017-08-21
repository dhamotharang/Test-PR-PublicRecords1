//Misc by Date 20070620 by John J. Bulten
//Date coverage requested by Lori including FL accidents, foreclosures, domains, Form 5500, and lobbyists
//Additional date coverage requested by Lori including SOR, firearms, Fone, and WP
//SOR: W20070801-144638, W20070814-172221, W20070815-112011, W20070914-135850

output(table(FLAccidents.BaseFile_FLCrash0,{accident_date,count(group)},accident_date),all);
output(table(Property.File_Foreclosure,{recording_date,count(group)},recording_date),all);
output(table(domains.File_Whois_Base,{create_date,count(group)},create_date),all);
output(table(irs5500.File_In,{admin_signed_date,count(group)},admin_signed_date),all);
output(table(irs5500.File_In,{spons_signed_date,count(group)},spons_signed_date),all);
output(table(lobbyists.Joined_Lobbyists,{process_date,count(group)},process_date),all);
output(table(lobbyists.Joined_Lobbyists_2005,{process_date,count(group)},process_date),all);
output(table(lobbyists.Joined_Lobbyists_2006,{process_date,count(group)},process_date),all);

output(table(sexoffender.file_main,{reg_date_1,reg_date_1_type,count(group)},reg_date_1,reg_date_1_type),all);
output(table(sexoffender.file_main,{reg_date_1[1..4],reg_date_1_type,count(group)},reg_date_1[1..4],reg_date_1_type),all);
output(table(sexoffender.file_main,{orig_state_code,reg_date_1_type,count(group)},orig_state_code,reg_date_1_type),all);
output(table(sexoffender.file_main,{orig_state_code,reg_date_1,reg_date_1_type,count(group)},orig_state_code,reg_date_1,reg_date_1_type),all);
output(table(sexoffender.file_main,{reg_date_1[1..4],reg_date_1_type,orig_state_code,count(group)},reg_date_1[1..4],reg_date_1_type,orig_state_code),all);

dDev := join(sexoffender.File_Main,sexoffender.File_Offenses,left.seisint_primary_key=right.seisint_primary_key);
output(choosen(dDev(orig_state_code='VT'),all));

output(table(distribute(targus.File_consumer_base,hash(pubdate)),{pubdate,count(group)},pubdate),all);
/*output(table(distribute(targus.File_consumer_base,hash(validation_date)),{validation_date,count(group)},validation_date),all);
output(table(distribute(targus.File_consumer_base,hash(dt_first_seen)),{dt_first_seen,count(group)},dt_first_seen),all);
output(table(targus.File_consumer_base,{dt_last_seen,count(group)},dt_last_seen),all);
output(table(targus.File_consumer_base,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported),all);
output(table(targus.File_consumer_base,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported),all);
output(table(targus.File_consumer_in,{pubdate,count(group)},pubdate),all);
output(table(distribute(targus.File_consumer_in,hash(validation_date)),{validation_date,count(group)},validation_date),all);
output(table(distribute(targus.File_targus_key_building,hash(pubdate)),{pubdate,count(group)},pubdate),all);
output(table(distribute(targus.File_targus_key_building,hash(validation_date)),{validation_date,count(group)},validation_date),all);
output(table(targus.File_targus_key_building,{dt_first_seen,count(group)},dt_first_seen),all);
output(table(targus.File_targus_key_building,{dt_last_seen,count(group)},dt_last_seen),all);
output(table(targus.File_targus_key_building,{dt_vendor_first_reported,count(group)},dt_vendor_first_reported),all);
output(table(targus.File_targus_key_building,{dt_vendor_last_reported,count(group)},dt_vendor_last_reported),all);
*/
output(table(atf.file_firearms_explosives_base,{date_first_seen,count(group)},date_first_seen));
/*output(table(atf.file_firearms_explosives_base,{date_last_seen,count(group)},date_last_seen));
*/