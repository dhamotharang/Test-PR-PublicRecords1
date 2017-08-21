/* phone */
/* avm */

/* people */
/*
perhdr :=enth(header.File_Headers(st='MI' and city_name<>''),100);
output(dedup(sort(perhdr,st,city_name,lname,fname,did),st,city_name,lname,fname,did),{st,city_name,lname,fname,mname,ssn,did},named('Person_header'));
pawx := enth(paw.Key_Payload(bus_addr.st='MI' and length(trim(company_name))>20),100);
output(dedup(pawx,bus_addr.st,bus_addr.p_city_name,company_name,bdid,person_name.lname,person_name.fname,person_name.mname,did,all),{bus_addr.st,bus_addr.p_city_name,company_name,bdid,person_name.lname,person_name.fname,person_name.mname,did},named('PAW'));
*/

/* business */
/*
bushdr := sample(pull(business_header.Key_BH_Best(state='MI' and city<>'' and length(trim(company_name))>20)),100);
output(dedup(sort(bushdr,state,city,company_name,bdid),state,city,company_name,bdid),{state,city,company_name,bdid},named('Business_Header'));
buscont := sample(pull(business_header.Key_Business_Contacts_FP(state='MI' and city<>'' and fname<>'' and length(trim(company_name))>20 )),100);
output(dedup(sort(buscont,state,city,lname,fname,mname,did,company_name,bdid),state,city,lname,fname,mname,did,company_name,bdid),{state,city,lname,fname,mname,ssn,did,company_name,bdid},named('Business_Contact'));
corpx := sample(pull(corp2.Key_Corp2_AutoKeyPayload(business_state='MI' and length(trim(company_name))>20)),100);
output(corpx,{business_state,business_city,company_name,fein,bdid,person_lname,person_fname,person_mname,person_ssn,person_did},named('Corp_and_Contacts'));
*/

//uccp ivanmille
//uccb ?

/* assets */

//propp	ivanmille
//propb ivanmille

//deedp ivanmille
//deedb ivanmille

//mvrp ivanmille
//mvrb ivanmille

//wcp ivanmille
//wcb ivanmille

//aircraft := pull(faa.key_faa_AutoKeyPayload);
//aircraftp := aircraft(did_out<>0);
//aircraftb := aircraft(bdid_out<>0 and length(trim(compname))>20);
//output(aircraftp,{st,v_city_name,lname,fname,mname,best_ssn,did_out},named('Aircraft_person'));
//output(dedup(sort(aircraftb,st,bdid_out),st,bdid_out),{st,v_city_name,compname,bdid_out},named('Aircraft_business'));

/* license */
//dl ivanmille

//proflicense := pull(prof_licensev2.Key_ProfLic_Payload);
//proflicensex := proflicense(bdid<>0 and length(trim(cname))>20);
//output(dedup(sort(proflicensex,addr.st,addr.v_city_name,did,bdid),addr.st,addr.v_city_name,did,bdid),{addr.st,addr.v_city_name,name.lname,name.fname,name.mname,best_ssn,did,cname,bdid},named('Professional_license_both'));

//pilot := pull(faa.key_airmen_did);
//output(dedup(sort(pilot,st,v_city_name,lname,fname),st,v_city_name,lname,fname),{st,v_city_name,lname,fname,mname,best_ssn,did},named('Pilots'));

//key_prep_hunters_did := index(
//	emerges.file_hunters_keybuild((integer)did_out != 0),
//	{UNSIGNED8 did := (UNSIGNED8) did_out}, {emerges.file_hunters_keybuild},
//	'~thor_data400::key::hunters_doxie_did' + '_QA');
//huntfish := pull(key_prep_hunters_did);
//output(dedup(sort(huntfish,st,city_name,lname,did),st,city_name,lname,did),{st,city_name,lname,fname,mname,best_ssn,did_out},named('Hunting_Fishing'));


//key_prep_ccw_did := index(
//	emerges.file_ccw_keybuild((integer)did_out != 0),
//	{UNSIGNED8 did := (UNSIGNED8) did_out}, {emerges.file_ccw_keybuild},
//	'~thor_data400::key::ccw_doxie_did' + '_QA');
//ccw := pull(key_prep_ccw_did);
//output(dedup(sort(ccw(st<>''),st,city_name,lname,did),st,city_name,lname,did),{st,city_name,lname,fname,mname,best_ssn,did_out},named('Concealed_Weapons'));

//voter ivanmille

//key_prep_atf_records := index(atf.file_firearms_explosives_keybase,
//	{UNSIGNED8 fpos := __fpos}, {atf.file_firearms_explosives_keybase},
//	'~thor_data400::key::atf_firearms_records' + '_qa');
//atfx := pull(key_prep_atf_records);
//output(dedup(sort(atfx,did_out),did_out),{premise_st,premise_v_city_name,license1_lname,license1_fname,license1_mname,best_ssn,did_out},named('ATF'));

//deax := pull(dea.Key_dea_payload);
//deap := deax((integer) did<>0 and  (integer) bdid=0);
//deab := deax((integer) bdid<>0 and (integer) did=0 and length(trim(cname))>20);
//output(dedup(sort(deap, did), did),{st,v_city_name,lname,fname,mname,best_ssn,did},named('DEA'));
//xoutput(dedup(sort(deab,bdid),bdid),{st,v_city_name,cname,bdid},named('DEA_business')); // there aren't any - commented out

/* court */
/*
bkp := pull(bankruptcyv2.key_bankruptcy_search_full(fname<>'' and st<>'' and v_city_name<>'' and did not in ['','0']));
output(dedup(sort(bkp,st,v_city_name,lname,fname),st,v_city_name,lname,fname),{st,v_city_name,lname,fname,mname,app_ssn,did},named('Person_Bankruptcy'));
bkb := pull(bankruptcyv2.key_bankruptcy_search_full(cname<>'' and st<>'' and v_city_name<>'' and bdid not in ['','0']));
output(dedup(sort(bkb,st,v_city_name,cname),st,v_city_name,cname),{st,v_city_name,cname,app_tax_id,bdid},named('Business_Bankruptcy'));
*/
//crimp:= pull(doxie_files.Key_Offenders(st<>'' and v_city_name[1..5]<>'HAPPY'));
//output(dedup(sort(enth(crimp,100),st,v_city_name,lname,fname),st,v_city_name,lname,fname),{st,v_city_name,lname,fname,mname,ssn_appended,did},named('Crim_offender_records'));
//xcivilx

//flcrashp := pull(flaccidents.Key_FLCrash_Payload(did<>0 and fname<>''));
//output(dedup(sort(flcrashp,st,v_city_name,did),st,v_city_name,did),{st,v_city_name,lname,fname,mname,did},named('FL_accidents'));

patriotx := pull(patriot.key_patriot_file);
output(patriotx);
//patriotp
//patriotb

//sor

//xofrx

//marr_divorce 

//foreclosurep
//foreclosureb

//lienp ivanmille
//lienb

