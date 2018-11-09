import sexoffender, doxie_build, images, orbit_report;

export Mac_SO_Spray(sourceIP,M_file,O_file,MP_file,filedate,group_name ='\'thor400_44\'',email_target='\' \'') := 
macro
#uniquename(spray_main)
#uniquename(spray_offense)
#uniquename(spray_image_map)
#uniquename(super_main)
#uniquename(super_offense)
#uniquename(super_image_map)
#uniquename(recordsizeMain)
#uniquename(recordsizeOffense)
#uniquename(build_SO)
#uniquename(build_IMG)
#uniquename(build_IMG_V2)
#uniquename(build_img_all)
#uniquename(build_img_all_V2)
#uniquename(build_img_base)
#uniquename(build_img_base_V2)
#uniquename(build_main_delimited)
#uniquename(build_offenses_delimited)
#uniquename(build_delimited_files)
#uniquename(super_main_delimited)
#uniquename(super_offenses_delimited)

#workunit('name','SexOffender Build ' + filedate);

%recordsizeMain% :=18899;
%recordsizeOffense% :=1524;

%spray_main% := FileServices.SprayFixed(sourceIP
                                       ,M_file
									   ,%recordsizeMain%
									   ,group_name
									   ,'~thor_data400::in::sex_pred_2_'+filedate 
									   ,-1
									   ,,
									   ,true
									   ,true);
%spray_offense% := FileServices.SprayFixed(sourceIP
                                          ,O_file
										  ,%recordsizeOffense%
										  ,group_name
										  ,'~thor_data400::in::sex_pred_search_'+filedate 
										  ,-1
										  ,,
										  ,true
										  ,true);
%spray_image_map% := FileServices.SprayVariable(sourceIP
                                               ,MP_file
											   ,,,,
											   ,group_name
											   ,'~thor_data400::in::sexoffender_imagemapping'+filedate
											   ,-1
											   ,,
											   ,true
											   ,true);

// Move main superfiles
%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  '~thor_data400::in::so_accurintpublic_delete',
				                            '~thor_data400::in::so_accurintpublic_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::in::so_accurintpublic_grandfather'),
				FileServices.AddSuperFile(  '~thor_data400::in::so_accurintpublic_grandfather',
				                            '~thor_data400::in::so_accurintpublic_father',, true),
				FileServices.ClearSuperFile('~thor_data400::in::so_accurintpublic_father'),
				FileServices.AddSuperFile(  '~thor_data400::in::so_accurintpublic_father', 
				                            '~thor_data400::in::so_accurintpublic',, true),
				FileServices.ClearSuperFile('~thor_data400::in::so_accurintpublic'),
				FileServices.AddSuperFile(  '~thor_data400::in::so_accurintpublic', 
				                            '~thor_data400::in::sex_pred_2_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::in::so_accurintpublic_delete',false));

// Move search superfiles
%super_offense% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  '~thor_data400::in::so_accurint_searchpublic_delete',
				                            '~thor_data400::in::so_accurint_searchpublic_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::in::so_accurint_searchpublic_grandfather'),
				FileServices.AddSuperFile(  '~thor_data400::in::so_accurint_searchpublic_grandfather',
				                            '~thor_data400::in::so_accurint_searchpublic_father',, true),
				FileServices.ClearSuperFile('~thor_data400::in::so_accurint_searchpublic_father'),
				FileServices.AddSuperFile(  '~thor_data400::in::so_accurint_searchpublic_father',
				                            '~thor_data400::in::so_accurint_searchpublic',, true),
				FileServices.ClearSuperFile('~thor_data400::in::so_accurint_searchpublic'),
				FileServices.AddSuperFile(  '~thor_data400::in::so_accurint_searchpublic', 
				                            '~thor_data400::in::sex_pred_search_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::in::so_accurint_searchpublic_delete',false));

// Move image superfiles
%super_image_map% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  '~thor_data400::in::sexoffender_imagemapping_delete',
				                            '~thor_data400::in::sexoffender_imagemapping_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::in::sexoffender_imagemapping_grandfather'),
				FileServices.AddSuperFile(  '~thor_data400::in::sexoffender_imagemapping_grandfather',
				                            '~thor_data400::in::sexoffender_imagemapping_father',, true),
				FileServices.ClearSuperFile('~thor_data400::in::sexoffender_imagemapping_father'),
				FileServices.AddSuperFile(  '~thor_data400::in::sexoffender_imagemapping_father',
				                            '~thor_data400::in::sexoffender_imagemapping',, true),
				FileServices.ClearSuperFile('~thor_data400::in::sexoffender_imagemapping'),
				FileServices.AddSuperFile(  '~thor_data400::in::sexoffender_imagemapping', 
				                            '~thor_data400::in::sexoffender_imagemapping'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::in::sexoffender_imagemapping_delete',true));

%build_SO% 						:= hygenics_soff.Proc_Build_SO_Search(filedate);
%build_img_base% 			:= images.proc_build_base(filedate);
%build_img_base_v2% 	:= images_v2.proc_build_IMG_base(filedate);
%build_IMG% 					:= images.proc_build_keys(filedate);
%build_IMG_v2% 				:= images_v2.proc_build_keys(filedate);
%build_img_all% 			:= images.proc_build_all(filedate);
%build_img_all_v2% 		:= images_v2.proc_build_all(filedate);

// Do STRATA stats work

crossMain := dataset('~thor_data400::persist::hd::sex_Offender_crossmain', hygenics_soff.layout_out_main_cross, flat);

Hygenics_SOff.Out_File_Main_Stats_Population(Hygenics_SOff.MainFile
                      ,Hygenics_SOff.OffenseFile
										  ,Images.File_Images
										  ,crossMain
										  ,filedate
										  ,strata_output)
											
find_IN_recs	:= hygenics_soff.Check_Upload_Date(filedate);

// Do ORBIT Dayton Report
orbit_report.sexp_stats(getretval);

/////////////////////////////////////////////////
// Generate Delimited data files for US Search //
/////////////////////////////////////////////////
	oldMainLayout := RECORD
		unsigned8 did;
		unsigned1 score;
		string9 ssn_appended;
		unsigned1 ssn_perms;
		string8 dt_first_reported;
		string8 dt_last_reported;
		string30 orig_state;
		string2 orig_state_code;
		string16 seisint_primary_key;
		string2 vendor_code;
		string20 source_file;
		string2 record_type;
		string50 name_orig;
		string30 lname;
		string30 fname;
		string20 mname;
		string20 name_suffix;
		string1 name_type;
		string50 offender_status;
		string40 offender_category;
		string10 risk_level_code;
		string50 risk_description;
		string50 police_agency;
		string35 police_agency_contact_name;
		string55 police_agency_address_1;
		string35 police_agency_address_2;
		string10 police_agency_phone;
		string25 registration_type;
		string8 reg_date_1;
		string28 reg_date_1_type;
		string8 reg_date_2;
		string28 reg_date_2_type;
		string8 reg_date_3;
		string28 reg_date_3_type;
		string125 registration_address_1;
		string45 registration_address_2;
		string35 registration_address_3;
		string35 registration_address_4;
		string35 registration_address_5;
		string35 registration_county;
		string55 employer;
		string55 employer_address_1;
		string35 employer_address_2;
		string35 employer_address_3;
		string35 employer_address_4;
		string35 employer_address_5;
		string35 employer_county;
		string55 school;
		string55 school_address_1;
		string35 school_address_2;
		string35 school_address_3;
		string35 school_address_4;
		string35 school_address_5;
		string35 school_county;
		string30 offender_id;
		string30 doc_number;
		string30 sor_number;
		string30 st_id_number;
		string30 fbi_number;
		string30 ncic_number;
		string9 ssn;
		string8 dob;
		string8 dob_aka;
		string3 age;
		string30 race;
		string30 ethnicity;
		string10 sex;
		string40 hair_color;
		string40 eye_color;
		string3 height;
		string3 weight;
		string20 skin_tone;
		string30 build_type;
		string200 scars_marks_tattoos;
		string6 shoe_size;
		string1 corrective_lense_flag;
		string140 addl_comments_1;
		string140 addl_comments_2;
		string30 orig_dl_number;
		string2 orig_dl_state;
		string4 orig_veh_year_1;
		string40 orig_veh_color_1;
		string40 orig_veh_make_model_1;
		string40 orig_veh_plate_1;
		string2 orig_veh_state_1;
		string4 orig_veh_year_2;
		string40 orig_veh_color_2;
		string40 orig_veh_make_model_2;
		string40 orig_veh_plate_2;
		string2 orig_veh_state_2;
		string150 image_link;
		string8 image_date;
		string6 addr_dt_last_seen;
		qstring10 prim_range;
		string2 predir;
		qstring28 prim_name;
		qstring4 addr_suffix;
		string2 postdir;
		qstring10 unit_desig;
		qstring8 sec_range;
		qstring25 p_city_name;
		qstring25 v_city_name;
		string2 st;
		qstring5 zip5;
		qstring4 zip4;
		unsigned1 clean_errors;
	 END;

	oldMainLayout oldTran(Hygenics_SOff.MainFile l):= transform
	 self := l;
	end; 

ds_main_project := project(Hygenics_SOff.MainFile, oldTran(left));

%build_main_delimited% :=output(ds_main_project
							    ,
							    ,'~thor_data400::base::Sex_Offender_Main_Delimited_'+filedate
							    ,overwrite
							    ,csv(SEPARATOR('|'), TERMINATOR('\n')));

	oldOffenseLayout := RECORD,maxlength(200000)
		string16 seisint_primary_key;
		string80 conviction_jurisdiction;
		string8 conviction_date;
		string30 court;
		string25 court_case_number;
		string8 offense_date;
		string20 offense_code_or_statute;
		string320 offense_description;
		string180 offense_description_2;
		string1 victim_minor;
		string3 victim_age;
		string10 victim_gender;
		string30 victim_relationship;
		string180 sentence_description;
		string180 sentence_description_2;
	 END;
								
	oldOffenseLayout oldOff(Hygenics_SOff.OffenseFile l):= transform
	 self := l;
	end; 

ds_offense_project := project(Hygenics_SOff.OffenseFile, oldOff(left));

%build_offenses_delimited% :=output(ds_offense_project
								    ,
								    ,'~thor_data400::base::Sex_Offender_Offenses_Delimited_'+filedate
								    ,overwrite
								    ,csv(SEPARATOR('|'), TERMINATOR('\n')));

// Move delimited main superfiles
%super_main_delimited% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  '~thor_data400::base::sex_offender_main_delimited_delete',
				                            '~thor_data400::base::sex_offender_main_delimited_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::base::sex_offender_main_delimited_grandfather'),
				FileServices.AddSuperFile(  '~thor_data400::base::sex_offender_main_delimited_grandfather',
				                            '~thor_data400::base::sex_offender_main_delimited_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::sex_offender_main_delimited_father'),
				FileServices.AddSuperFile(  '~thor_data400::base::sex_offender_main_delimited_father', 
				                            '~thor_data400::base::sex_offender_main_delimited',, true),
				FileServices.ClearSuperFile('~thor_data400::base::sex_offender_main_delimited'),
				FileServices.AddSuperFile(  '~thor_data400::base::sex_offender_main_delimited', 
				                            '~thor_data400::base::sex_offender_main_delimited_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::sex_offender_main_delimited_delete',true));

// Move delimited search superfiles
%super_offenses_delimited% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  '~thor_data400::base::sex_offender_offenses_delimited_delete',
				                            '~thor_data400::base::sex_offender_offenses_delimited_grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::base::sex_offender_offenses_delimited_grandfather'),
				FileServices.AddSuperFile(  '~thor_data400::base::sex_offender_offenses_delimited_grandfather',
				                            '~thor_data400::base::sex_offender_offenses_delimited_father',, true),
				FileServices.ClearSuperFile('~thor_data400::base::sex_offender_offenses_delimited_father'),
				FileServices.AddSuperFile(  '~thor_data400::base::sex_offender_offenses_delimited_father',
				                            '~thor_data400::base::sex_offender_offenses_delimited',, true),
				FileServices.ClearSuperFile('~thor_data400::base::sex_offender_offenses_delimited'),
				FileServices.AddSuperFile(  '~thor_data400::base::sex_offender_offenses_delimited', 
				                            '~thor_data400::base::sex_offender_offenses_delimited_'+filedate), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::base::sex_offender_offenses_delimited_delete',true));


#uniquename(do_super)
%do_super% := sequential(parallel(%spray_main%
                                   ,%spray_offense%
								   ,%spray_image_map%)
                         ,parallel(%super_main%
						           ,%super_offense%
								   ,%super_image_map%));
						  
#uniquename(do_delimited)
%do_delimited% := sequential(parallel(%build_main_delimited%
                                       ,%build_offenses_delimited%)
							 ,parallel(%super_main_delimited%
							           ,%super_offenses_delimited%));
sequential(%do_super%,
		   %build_SO%
		   ,%build_img_base%
			 ,%build_img_base_v2%
		   ,%build_IMG%
			 ,%build_IMG_v2%
		   ,%build_img_all%
			 ,%build_img_all_v2%
		   //,%do_delimited%
		   ,strata_output
			 ,find_IN_recs
			 ,getretval);

ENDMACRO;