import autokey, sexoffender, doxie, fair_isaac, codes, did_add, didville, VehLic, minibuild, ut, VehicleCodes, header_slimsort, watchdog, vehicle_wildcard, doxie_files,RoxieKeyBuild, dops,DOPSGrowthCheck;

export Proc_Build_SO_Search_Keys(string filedate) := function

pre1 := ut.SF_MaintBuilding('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate);
pre2 := ut.SF_MaintBuilding('~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate);
pre3 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::UtilityHeader_Building')>0,
output('Nothing added to Base::UtilityHeader_Building'),
           fileservices.addsuperfile('~thor_data400::Base::UtilityHeader_Building',
		                           '~thor_data400::Base::Utility_File',,true));

util_populated := fileservices.getsuperfilesubcount('~thor_data400::Base::UtilityHeader_Building')>0 : stored('utilcheck');



chk_build := output('Checking sex offender building files...') : success(sequential(if(util_populated,output('Util already populated'),output('Util not populated')),parallel(pre1,pre2,pre3)));

//chk_build := parallel(pre1, pre2);

//Build keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_DID(),'',
				'~thor_data400::key::sexoffender::'+filedate+'::did'+ doxie_build.buildstate,key_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_SPK_Enh(),'',	 
				'~thor_data400::key::sexoffender::'+filedate+'::enh'+ doxie_build.buildstate,key_enh);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_sexoffender_offenses(),'',
				'~thor_data400::key::sexoffender::'+filedate+'::offenses_'+doxie_build.buildstate,key_off);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_SPK(),'',	
				'~thor_data400::key::sexoffender::'+filedate+'::spk'+ doxie_build.buildstate,key_spk);

//Disable FCRA Keys - Bugzilla #78618
//Build fcra-versions of the keys
/*
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_DID (true),'',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::did',key_did_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_SPK_Enh (true),'',	 
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::enh',key_enh_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.key_sexoffender_offenses (true),'',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::offenses',key_off_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(sexoffender.Key_SexOffender_SPK (true),'',	
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::spk',key_spk_fcra);
*/
						
//Move to built			
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_did'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::'+filedate+'::did'+ doxie_build.buildstate,mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_enh'+ doxie_build.buildstate,	 
				'~thor_data400::key::sexoffender::'+filedate+'::enh'+ doxie_build.buildstate,mv_enh);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_offenses_'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::'+filedate+'::offenses_'+doxie_build.buildstate,mv_off);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_spk'+ doxie_build.buildstate,
				'~thor_data400::key::sexoffender::'+filedate+'::spk'+ doxie_build.buildstate,mv_spk);

/*
//Move fcra-versions to built			
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::did',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::did',mv_did_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::enh',	 
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::enh',mv_enh_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::offenses',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::offenses',mv_off_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender::fcra::spk',
				'~thor_data400::key::sexoffender::fcra::'+filedate+'::spk',mv_spk_fcra);
*/

f := file_SO_Enh_keybuilding;

xl :=
RECORD
	f;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('SEX'))| ut.bit_set(0,0);
	real lat;
	real long;
END;
xl xpand(f le,integer cntr) := 
TRANSFORM 
	SELF.did := cntr + autokey.did_adder('SEX'); 
	self.lat := (real)(ziplib.ZipToGeo21(le.alt_zip)[1..9]),
	self.long := (real)(ziplib.ZipToGeo21(le.alt_zip)[11..]),
	SELF := le; 
END;
DS := PROJECT(f,xpand(LEFT,COUNTER)) : PERSIST('persist::sex_offender_enh_fdids');

f_zip_type_base := project(DS,transform(SexOffender.layout_zip_type_key,
                                        self.alt_zip := (INTEGER4)left.alt_zip,
																				self.yob := (UNSIGNED2)(left.dob[1..4]),
                                        self.dob := (INTEGER4)left.dob, 
																				self := left))(alt_zip<>0);

idx_zip_type := index(f_zip_type_base,{alt_zip, alt_type, yob, dob}, {did},
                      '~thor_data400::key::sexoffender_zip_type_'+ doxie_build.buildstate);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(idx_zip_type,'',
					'~thor_data400::key::sexoffender::'+filedate+'::zip_type_'+ doxie_build.buildstate,key_zip_type);
					
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_zip_type_'+ doxie_build.buildstate,
                                      '~thor_data400::key::sexoffender::'+filedate+'::zip_type_'+ doxie_build.buildstate,mv_zip_type);					
					
AutoKey.MAC_Build_version(DS,fname,mname,lname,
						ssn,
						dob,
						police_agency_phone,
						alt_prim_name, alt_prim_range, alt_st, alt_city_name, alt_zip, alt_sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						did,
						'~thor_data400::key::so_enh'+doxie_build.buildstate,
						'~thor_data400::key::sexoffender::'+filedate+'::enh'+doxie_build.buildstate,outaction1,false) // Diffing originally true

ds_orig := project(ds(alt_type='S'),
                   transform({ds},
		                   self.alt_st := if(left.alt_st='',left.orig_state_code, left.alt_st);
					    self := left)) : PERSIST('persist::sex_offender_fdids');

AutoKey.MAC_Build_version(ds_orig,fname,mname,lname,
						ssn,
						dob,
						police_agency_phone,
						alt_prim_name, alt_prim_range, alt_st, alt_city_name, alt_zip, alt_sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						did,
						'~thor_data400::key::so_'+doxie_build.buildstate,
						'~thor_data400::key::sexoffender::'+filedate+'::'+doxie_build.buildstate,outaction2,false) // Diffing originally true

in_common := project(ds,transform(SexOffender.Layout_fdid,self := left));

i := index(in_common,{did},{seisint_primary_key, lat, long},'~thor_data400::key::sexoffender_fdid'+ doxie_build.buildstate);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(i,'',
					'~thor_data400::key::sexoffender::'+filedate+'::fdid_'+ doxie_build.buildstate,key_fdid); // Diffing originally true
					
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sexoffender_fdid_'+ doxie_build.buildstate,'~thor_data400::key::sexoffender::'+filedate+'::fdid_'+ doxie_build.buildstate,mv_fdid);

post1 := ut.SF_MaintBuilt('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate);
post2 := ut.SF_MaintBuilt('~thor_data400::base::sex_offender_Offenses'+ doxie_build.buildstate);
post3 := if(util_populated, output('Dont clear utility super'),fileservices.clearsuperfile('~thor_data400::Base::UtilityHeader_Building'));

//Add Growth and Persistence Checks for FCRA keys
GetDops := dops.GetDeployedDatasets('P', 'B', 'F');
OnlySexOffender:=GetDops(datasetname='FCRA_SexOffenderKey');
father_filedate := OnlySexOffender[1].buildversion;																		
set of string InputSet_SexOffender_Off := ['sspk','seisint_primary_key','conviction_jurisdiction','conviction_date','court','court_case_number','offense_date','offense_code_or_statute','offense_description','offense_description_2','offense_category','victim_minor','victim_age','victim_gender','victim_relationship','sentence_description','sentence_description_2','arrest_date','arrest_warrant','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offense_persistent_id'];
set of string InputSet_SexOffender_SPK := ['sspk','did','score','ssn_appended','ssn_perms','dt_first_reported','dt_last_reported','orig_state','orig_state_code','seisint_primary_key','vendor_code','source_file','record_type','name_orig','lname','fname','mname','name_suffix','name_type','nid','ntype','nindicator','intnet_email_address_1','intnet_email_address_2','intnet_email_address_3','intnet_email_address_4','intnet_email_address_5','intnet_instant_message_addr_1','intnet_instant_message_addr_2','intnet_instant_message_addr_3','intnet_instant_message_addr_4','intnet_instant_message_addr_5','intnet_user_name_1','intnet_user_name_1_url','intnet_user_name_2','intnet_user_name_2_url','intnet_user_name_3','intnet_user_name_3_url','intnet_user_name_4','intnet_user_name_4_url','intnet_user_name_5','intnet_user_name_5_url','offender_status','offender_category','risk_level_code','risk_description','police_agency','police_agency_contact_name','police_agency_address_1','police_agency_address_2','police_agency_phone','registration_type','reg_date_1','reg_date_1_type','reg_date_2','reg_date_2_type','reg_date_3','reg_date_3_type','registration_address_1','registration_address_2','registration_address_3','registration_address_4','registration_address_5','registration_county','registration_home_phone','registration_cell_phone','other_registration_address_1','other_registration_address_2','other_registration_address_3','other_registration_address_4','other_registration_address_5','other_registration_county','other_registration_phone','temp_lodge_address_1','temp_lodge_address_2','temp_lodge_address_3','temp_lodge_address_4','temp_lodge_address_5','temp_lodge_county','temp_lodge_phone','employer','employer_address_1','employer_address_2','employer_address_3','employer_address_4','employer_address_5','employer_county','employer_phone','employer_comments','professional_licenses_1','professional_licenses_2','professional_licenses_3','professional_licenses_4','professional_licenses_5','school','school_address_1','school_address_2','school_address_3','school_address_4','school_address_5','school_county','school_phone','school_comments','offender_id','doc_number','sor_number','st_id_number','fbi_number','ncic_number','ssn','dob','dob_aka','age','dna','race','ethnicity','sex','hair_color','eye_color','height','weight','skin_tone','build_type','scars_marks_tattoos','shoe_size','corrective_lense_flag','addl_comments_1','addl_comments_2','orig_dl_number','orig_dl_state','orig_dl_link','orig_dl_date','passport_type','passport_code','passport_number','passport_first_name','passport_given_name','passport_nationality','passport_dob','passport_place_of_birth','passport_sex','passport_issue_date','passport_authority','passport_expiration_date','passport_endorsement','passport_link','passport_date','orig_veh_year_1','orig_veh_color_1','orig_veh_make_model_1','orig_veh_plate_1','orig_registration_number_1','orig_veh_state_1','orig_veh_location_1','orig_veh_year_2','orig_veh_color_2','orig_veh_make_model_2','orig_veh_plate_2','orig_registration_number_2','orig_veh_state_2','orig_veh_location_2','orig_veh_year_3','orig_veh_color_3','orig_veh_make_model_3','orig_veh_plate_3','orig_registration_number_3','orig_veh_state_3','orig_veh_location_3','orig_veh_year_4','orig_veh_color_4','orig_veh_make_model_4','orig_veh_plate_4','orig_registration_number_4','orig_veh_state_4','orig_veh_location_4','orig_veh_year_5','orig_veh_color_5','orig_veh_make_model_5','orig_veh_plate_5','orig_registration_number_5','orig_veh_state_5','orig_veh_location_5','fingerprint_link','fingerprint_date','palmprint_link','palmprint_date','image_link','image_date','addr_dt_last_seen','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','clean_errors','rawaid','curr_incar_flag','curr_parole_flag','curr_probation_flag','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offender_persistent_id'];
set of string Persistent_ID_SexOffender_Off := ['seisint_primary_key','conviction_date','offense_date','offense_code_or_statute','court_case_number','victim_gender','victim_age','offense_description','sentence_description','conviction_jurisdiction','Court','Offense_category','Arrest_date'];	
set of string Persistent_ID_SexOffender_SDK := ['seisint_primary_key','nid','dob','dob_aka','race','height','sex','weight','eye_color','hair_color','scars_marks_tattoos','registration_address_1','registration_address_2','offender_id'];	
DeltaCommands:=sequential(
DOPSGrowthCheck.CalculateStats('FCRA_SexOffenderKey','SexOffender.key_sexoffender_offenses(true)', 'key_SexOffender_Offenses_FCRA','~thor_data400::key::sexoffender::fcra::'+filedate+'::offenses_public','sspk','offense_persistent_id','','','','',filedate,father_filedate, false, true),DOPSGrowthCheck.CalculateStats('FCRA_SexOffenderKey','SexOffender.Key_SexOffender_SPK(true)', 'key_SexOffender_SPK_FCRA','~thor_data400::key::sexoffender::fcra::'+filedate+'::spkpublic','sspk','offender_persistent_id','','','','',filedate,father_filedate, false, true)
,DOPSGrowthCheck.DeltaCommand('~thor_data400::key::sexoffender::fcra::'+filedate+'::offenses_public', '~thor_data400::key::sexoffender::fcra::'+father_filedate+'::offenses_public', 'FCRA_SexOffenderKey', 'key_SexOffender_Offenses_FCRA', 'SexOffender.key_sexoffender_offenses (true)', 'offense_persistent_id', filedate, father_filedate, InputSet_SexOffender_Off, false, true),DOPSGrowthCheck.DeltaCommand('~thor_data400::key::sexoffender::fcra::'+filedate+'::spkpublic', '~thor_data400::key::sexoffender::fcra::'+father_filedate+'::spkpublic', 'FCRA_SexOffenderKey', 'key_SexOffender_SPK_FCRA', 'SexOffender.Key_SexOffender_SPK (true)', 'offender_persistent_id', filedate, father_filedate, InputSet_SexOffender_SPK, false, true)
,DOPSGrowthCheck.ChangesByField('~thor_data400::key::sexoffender::fcra::'+filedate+'::offenses_public', '~thor_data400::key::sexoffender::fcra::'+father_filedate+'::offenses_public','FCRA_SexOffenderKey','key_SexOffender_Offenses_FCRA','SexOffender.key_sexoffender_offenses (true)','offense_persistent_id','',filedate,father_filedate, false, true),DOPSGrowthCheck.ChangesByField('~thor_data400::key::sexoffender::fcra::'+filedate+'::spkpublic', '~thor_data400::key::sexoffender::fcra::'+father_filedate+'::spkpublic','FCRA_SexOffenderKey','key_SexOffender_SPK_FCRA','SexOffender.Key_SexOffender_SPK (true)','offender_persistent_id','',filedate,father_filedate, false, true)
,DOPSGrowthCheck.PersistenceCheck('~thor_data400::key::sexoffender::fcra::'+filedate+'::offenses_public', '~thor_data400::key::sexoffender::fcra::'+father_filedate+'::offenses_public',  'FCRA_SexOffenderKey',  'key_SexOffender_Offenses_FCRA',  'SexOffender.key_sexoffender_offenses (true)',  'offense_persistent_id',  Persistent_ID_SexOffender_Off,  Persistent_ID_SexOffender_Off,  filedate,  father_filedate, false ,  true),DOPSGrowthCheck.PersistenceCheck('~thor_data400::key::sexoffender::fcra::'+filedate+'::spkpublic', '~thor_data400::key::sexoffender::fcra::'+father_filedate+'::spkpublic',  'FCRA_SexOffenderKey',  'key_SexOffender_SPK_FCRA',  'SexOffender.Key_SexOffender_SPK (true)',  'offender_persistent_id',  Persistent_ID_SexOffender_SDK,  Persistent_ID_SexOffender_SDK,  filedate,  father_filedate, false ,  true)
);

return sequential(chk_build,
  parallel(key_did,key_enh,key_spk,key_off/*,key_did_fcra,key_enh_fcra,key_spk_fcra,key_off_fcra*/),
  parallel(mv_did,mv_enh,mv_spk,mv_off/*,mv_did_fcra,mv_enh_fcra,mv_spk_fcra,mv_off_fcra*/),
  outaction1,outaction2,key_fdid,mv_fdid,key_zip_type,mv_zip_type,parallel(post1,post2,post3),DeltaCommands);

end;