import sexoffender, doxie_build, codes, didville, did_add, header_slimsort, watchdog, ut, _control, header, idl_header,Std;

// 'local'
// 'hash'
// 'remote'
did_how := 'local';

//#stored('did_add_force','roxi'); // remove or set to 'thor' to put recs through thor
#stored('did_add_force','thor'); // remove or set to 'thor' to put recs through thor

df_original := Hygenics_SOff.Mapping_Accurint_Person_As_Common;

//Add FlipFlop Macro///////////////////
ut.mac_flipnames(df_original, fname, mname, lname, df_orig);

	Layout_seq := record
		unsigned seq;
		df_orig;
	end;
	
ut.MAC_Sequence_Records_NewRec(df_orig, Layout_seq, seq, df)

addSPK_layout :=record
	string60 seisint_primary_key;
	didville.Layout_Did_InBatch;
end;

addSPK_layout prep_for_did(df l) := transform
	 
	 self.phone10 := '';
		self.suffix := l.name_suffix;
		self.z5 := l.zip5;
//		self.dob := if((unsigned)l.dob > 0,l.dob,l.age);
		self := l;
	end;
	
to_did := project(df, prep_for_did(LEFT));

	didoutrec := record
		to_did;
		unsigned6	did;
		unsigned1 score;
		string9	ssn_added;
	end;

#if(did_how = 'remote')
DID_Add.Mac_Match_Fast_Roxie(to_did, remote_out,'','BEST_SSN','ALL',true,true)

	didoutrec did_ssn_remote(remote_out l) := transform
		self.ssn_added := l.best_ssn;
		self := l;	
	end;

did_ssn_added := project(remote_out,did_ssn_remote(LEFT));
#end

#if(did_how = 'local')
#uniquename(matchset)
matchset := ['A', 'D', 'S', '4', 'G', 'Z'];
DID_Add.MAC_Match_Fast(to_did,matchset,local_out,false,true)

	didoutrec did_ssn_local(local_out l) := transform
		self.ssn_added := l.best_ssn;
		self.score := l.did_score;
		self := l;
	end;

did_ssn_added := project(local_out,did_ssn_local(LEFT));
#end

#if(did_how = 'hash')
did_add.mac_match_hash_roxie(to_did, hash_out)

	didoutrec did_ssn_hash(hash_out l) := transform
		self.ssn_added := '';
		self.score := 0;
		self := l;
	end;

did_ssn_added := project(hash_out,did_ssn_hash(left));


#end

typeof(df_orig) appendDID_SSN(did_ssn_added l, df r) := transform
	#if(did_how = 'remote')
		self.did          := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8), intformat(0,12,1), intformat(l.did,12,1));
		self.score        := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8), intformat(0,3,1), intformat(l.score,3,1));
		self.ssn_appended := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8),'',l.ssn_added);
	#end
	#if(did_how = 'local')
		self.did          := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8), intformat(0,12,1), intformat(l.did,12,1));
		self.score        := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8), intformat(0,3,1), intformat(l.score,3,1));
		self.ssn_appended := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8),'',l.ssn_added);
	#end
	#if(did_how = 'hash')
		self.did := intformat(l.did,12,1);
		self.score := intformat(l.score,3,1);
	#end
	
	self := r;
end;

full_df := JOIN(did_ssn_added, df, LEFT.seq = RIGHT.seq, appendDID_SSN(LEFT, RIGHT), right outer);

	full_df joinds(full_df l, full_df r) := transform
	  self := r; 
	end;

string os(string i) := if (i = '','',trim(i) + ' ');

	Hygenics_SOff.Layout_Out_Main_CROSS produce_main(full_df L) := transform
	  self.orig_state 				:= L.orig_state;
	  self.vendor_code 				:= L.vendor_code;
	  self.source_file 				:= L.source_file;
	  self.name_type 				:= L.name_type;
	  self.dt_last_reported 		:= L.dt_last_reported;
	  self.dt_first_reported 		:= L.dt_first_reported;
	  self.src_upload_date 			:= L.src_upload_date;
	  self.seisint_primary_key 		:= l.seisint_primary_key;

											/*if(trim(l.offender_id,left,right) != '' and l.orig_state='NC',
											l.vendor_code + trim(regexreplace('-', regexreplace('WEB', trim(l.offender_id, left, right), 'W'), ''), left, right),									
											l.vendor_code + trim(l.offender_id,left,right));*/

	  self.registration_address_1 	:= os(L.prim_range) + os(L.predir) + os(L.prim_name) + os(L.addr_suffix) + L.postdir;
	  self.registration_address_2 	:= os(L.unit_desig) + L.sec_range;
	  self.registration_address_3 	:= trim(L.V_CITY_NAME) + ' ' + trim(L.ST) + ' ' + L.ZIP5;
	  self.registration_address_4 	:= '';
	  self.registration_address_5 	:= '';
	  self.name_orig 				:= (trim(L.FNAME) + ' ' + trim(L.MNAME) + ' ' + trim(L.LNAME) + ' ' + L.NAME_SUFFIX)[1..50];
	  self.dob 						:= L.dob;
	  self.lname 					:= L.LNAME;
	  self.fname 					:= L.FNAME;
	  self.mname 					:= L.MNAME;
	  self.name_suffix 				:= L.NAME_SUFFIX;
	  self.reg_date_1 				:= L.DATE_ADDRESS_ADDED;
	  self.registration_type 		:= L.RESIDENT_or_TEMP;
	  self.reg_date_1_type 			:= 'Date Added';
	  self.race 					:= L.race;
	  self.sex 						:= L.SEX;
	  self.eye_color 				:= L.EYE_COLOR;
	  self.weight 					:= L.WEIGHT;
	  self.height 					:= L.height;
	  self.hair_color 				:= L.HAIR_COLOR;
	  self.offender_status 			:= L.STATUS;
	  self.registration_county 		:= L.COUNTY;
	  self.did 						:= (INTEGER)L.did;
	  self.score 					:= (INTEGER)L.score;
	  self.ssn_appended 			:= L.ssn_appended;
	  self.addr_dt_last_seen 		:= '';
		self.nid												:= l.nid;
		self.ntype											:= l.ntype;
    self.nindicator									:= l.nindicator;
		self.offender_persistent_id			:= l.offender_persistent_id;
	  self 							:= L;
	end;

main1 := project(full_df,produce_main(LEFT));

	hdr := header.File_Headers;
		
	hdr_slim_rec := record
		hdr.did;
		hdr.dt_last_seen;
		hdr.prim_range;
		hdr.prim_name;
		hdr.sec_range;
		hdr.zip;
	end; 

hdr_slim_tbl := table(hdr, hdr_slim_rec)(prim_name<>'');
hdr_slim_tbl_dst := distribute(hdr_slim_tbl, hash(did));
hdr_slim_tbl_srt := sort(hdr_slim_tbl_dst, did, prim_range, prim_name, sec_range, zip, -dt_last_seen,local);
hdr_slim_tbl_dep := dedup(hdr_slim_tbl_srt, did, prim_range, prim_name, sec_range, zip, local);

main_dst := distribute(main1, hash(did)): persist('~thor_data400::Persist::hd::Sex_Offender_main_dst_test');

	Hygenics_SOff.Layout_Out_Main_CROSS get_addr_dt(main_dst l, hdr_slim_tbl_dep r) := transform
		 self.addr_dt_last_seen :=  if(l.prim_name = '',
										'',
									if(r.dt_last_seen > (unsigned3)l.reg_date_1[1..6] and (unsigned3)(STRING8)Std.Date.Today()[1..6] > r.dt_last_seen,
										(string6)r.dt_last_seen,
									if((unsigned3)(STRING8)Std.Date.Today()[1..6] > (unsigned3)l.reg_date_1[1..6],
										l.reg_date_1[1..6],
										''))); 
		self := l;
	end;

main2 := join(main_dst, hdr_slim_tbl_dep,
			left.did = right.did and 
			left.prim_range = right.prim_range and 
		    left.prim_name = right.prim_name and 
		    left.sec_range = right.sec_range and 
		    left.zip5 = right.zip, 
		    get_addr_dt(left, right),
		    left outer, local);

	Hygenics_SOff.Layout_Out_Main_CROSS getDecode(Hygenics_SOff.Layout_Out_Main_CROSS L) := transform
		self.orig_state_code 	:= L.orig_state;
		self.orig_state 		:= if(trim(l.orig_state, left, right) not in ['','GU'],
										codes.GENERAL.STATE_LONG(L.orig_state),
										'Guam');
		self := L;
	end;

main3 := project(main2, getDecode(LEFT));

// Bring in original, unmodified primary records
input_uncleaned := Hygenics_SOff.File_Accurint_In;

// Provide mapping for all blank columns
	Hygenics_SOff.Layout_Out_Main_CROSS jAddMissingData(main3 L, input_uncleaned R) := transform
		self.addl_comments_1            := R.addl_comments_1;
		self.addl_comments_2            := R.addl_comments_2;
		self.corrective_lense_flag      := R.corrective_lense_flag;
		self.dob_aka                    := R.dob_aka;
		self.employer_address_1         := R.employer_address_1;
		self.employer_address_2         := R.employer_address_2;
		self.employer_address_3         := R.employer_address_3;
		self.employer_address_4         := R.employer_address_4;
		self.employer_address_5         := R.employer_address_5;
		self.employer_county            := R.employer_county;
		self.name_orig                  := R.name_orig;
		self.offender_status            := R.offender_status;
		self.orig_dl_number             := R.orig_dl_number;
		self.orig_dl_state              := R.orig_dl_state;
		self.orig_veh_color_1           := R.orig_veh_color_1;
		self.orig_veh_color_2           := R.orig_veh_color_2;
		self.orig_veh_make_model_1      := R.orig_veh_make_model_1;
		self.orig_veh_make_model_2      := R.orig_veh_make_model_2;
		self.orig_veh_plate_1           := R.orig_veh_plate_1;
		self.orig_veh_plate_2           := R.orig_veh_plate_2;
		self.orig_veh_state_1           := R.orig_veh_state_1;
		self.orig_veh_state_2           := R.orig_veh_state_2;
		self.orig_veh_year_1            := R.orig_veh_year_1;
		self.orig_veh_year_2            := R.orig_veh_year_2;
		self.police_agency              := R.police_agency;
		self.police_agency_address_1    := R.police_agency_address_1;
		self.police_agency_address_2    := R.police_agency_address_2;
		self.police_agency_contact_name := R.police_agency_contact_name;
		self.police_agency_phone        := R.police_agency_phone;
		self.reg_date_1                 := R.reg_date_1;
		self.reg_date_1_type            := R.reg_date_1_type;
		self.reg_date_2                 := R.reg_date_2;
		self.reg_date_2_type            := R.reg_date_2_type;
		self.reg_date_3                 := R.reg_date_3;
		self.reg_date_3_type            := R.reg_date_3_type;
		self.registration_address_1     := R.registration_address_1;
		self.registration_address_2     := R.registration_address_2;
		self.registration_address_3     := R.registration_address_3;
		self.registration_address_4     := R.registration_address_4;
		self.registration_address_5     := R.registration_address_5;
		self.registration_county        := R.registration_county;
		self.registration_type          := R.registration_type;
		self.school                     := R.school;
		self.school_address_1           := R.school_address_1;
		self.school_address_2           := R.school_address_2;
		self.school_address_3           := R.school_address_3;
		self.school_address_4           := R.school_address_4;
		self.school_address_5           := R.school_address_5;
		self.school_county              := R.school_county;
		self.shoe_size                  := R.shoe_size;
		self                            := L;
	end;

// Join the data modified up until this point with the original input primary records
ds_fixed_data 	:= join(distribute(main3          ,hash32(trim(seisint_primary_key,left,right)))
                     ,distribute(input_uncleaned,hash32(trim(seisint_primary_key,left,right)))
                     ,trim(LEFT.seisint_primary_key,left,right) = trim(RIGHT.seisint_primary_key,left,right)
					 ,jAddMissingData(left,right)
					 ,local) : persist('~thor_data400::Persist::hd::Sex_Offender_ds_fixed_data');
					 
ds_fixed_d2		:= ds_fixed_data(seisint_primary_key <> '' and name_type <> '0');
ds_fixed_data2 	:= sort(distribute(ds_fixed_d2, hash(seisint_primary_key)), seisint_primary_key, local);

//Fix: Orig DID <> AKA DID ///////////////////////////////////////////////////////////////////

//Orig Name Has DID
orig_d 		:= ds_fixed_data(name_type='0' and did<>0);
orig_did	:= sort(distribute(orig_d, hash(seisint_primary_key)), seisint_primary_key,local);

//Orig Name Has No DID
orig_no_did	:= ds_fixed_data(name_type='0' and did=0);
//orig_no_did	:= sort(distribute(orig_no_d, hash(seisint_primary_key)), seisint_primary_key, local);

aka_name 		:= ds_fixed_data(name_type<>'0');
//aka_name 	:= sort(distribute(aka_n, hash(seisint_primary_key)), seisint_primary_key, local);

ds1_filt 		:= ds_fixed_data(seisint_primary_key <> '' and name_type = '0');
ds1_filter	:= sort(distribute(ds1_filt, hash(seisint_primary_key)), seisint_primary_key, local);

	ds1_filter joinds2(ds1_filter l, ds1_filter r) := transform
	  self.did := l.did;
	  self.score := l.score;
	  self.ssn_appended := l.ssn_appended;
	  self := r; 
	end;

//Orig Name Has DID - Populate Orig DID to the AKAs
join_ds2 := join(ds1_filter, ds_fixed_data2,      
			           trim(left.seisint_primary_key) = trim(right.seisint_primary_key),
			           joinds2(left,right), local);

fix_f 		:= orig_did + orig_no_did + join_ds2 ;
fix_file 	:= dedup(sort(fix_f, record), record);

Hygenics_SOff.Layout_Out_Main_CROSS tr_set_flags(fix_file L) := TRANSFORM 

	registration_address_search_string 	:= 'INCARCERATED';
	offender_status_search_string 		:= ['CONFINED','CONFINEMENT','CURRENTLY INCARCERATED','IN CUSTODY',
											'IN CUSTODY ;COMPLIANT','INCARCERATED','JAIL','INCARCERATED REGISTERED','INCARCERATED']; 
	set_curr_incar_flag 				:= if(L.registration_address_1 = registration_address_search_string 
											or L.offender_status in offender_status_search_string,
											'Y',
											'');

		SELF.curr_incar_flag 					:= set_curr_incar_flag;
		SELF.curr_parole_flag 				:= '';
		SELF.curr_probation_flag 			:= '';
		//FCRA flags////////////////////////////////////////
		self.fcra_conviction_flag 		:= 'Y';
		self.fcra_traffic_flag				:= 'N';
		self.fcra_date								:= l.dt_last_reported;
		self.fcra_date_type						:= 'R';
		self.conviction_override_date := l.dt_last_reported;
		self.conviction_override_date_type := 'L';
		self.offense_score						:= 'S';
		SELF 							:= L;
	END;    

ds_fixed_data_flagged := PROJECT(fix_file,tr_set_flags(LEFT));

//Suppress Records///////////////////////////////////////////////////////
// Bug: 80123. DID = 2074179303	score = 75	ssn append = 178546978
	
	//Bugzilla #80123
	//Bugzilla Bug #202131
	ds_fixed_data_flagged removeInfo(ds_fixed_data_flagged l):= transform
		self.ssn_appended	:= if((l.ssn_appended='353561176' and l.did=2275932305) or 
									(l.ssn_appended='567086017' and l.did=637548399) or
									(l.ssn_appended='282920169' and l.did=166338675767) or
									(l.ssn_appended='228677764' and l.did=173327970243) or
									(l.ssn_appended='178546978' and l.did=2074179303) or
									(l.ssn_appended='196364565' and l.did=93428187) or
									(l.ssn_appended=''          and l.did=107007223771) or
									(l.ssn_appended='046561828' and l.did=66048309) or
									(l.ssn_appended='132663291' and l.did=2640241816) or
									(l.ssn_appended='623211738' and l.did=122113244666)or
									(l.ssn_appended='542089805' and l.did=2166694879),
								'',
								l.ssn_appended);
		self.did			:= if((l.ssn_appended='353561176' and l.did=2275932305) or 
									(l.ssn_appended='567086017' and l.did=637548399) or
									(l.ssn_appended='282920169' and l.did=166338675767) or
									(l.ssn_appended='228677764' and l.did=173327970243) or
									(l.ssn_appended='178546978' and l.did=2074179303) or
									(l.ssn_appended='196364565' and l.did=93428187) or
									(l.ssn_appended=''          and l.did=107007223771) or
									(l.ssn_appended='046561828' and l.did=66048309) or
									(l.ssn_appended='132663291' and l.did=2640241816) or
									(l.ssn_appended='623211738' and l.did=122113244666) or
									(l.ssn_appended='542089805' and l.did=2166694879),
								0,
								l.did);
		self.score			:= if((l.ssn_appended='353561176' and l.did=2275932305) or 
									(l.ssn_appended='567086017' and l.did=637548399) or
									(l.ssn_appended='282920169' and l.did=166338675767) or
									(l.ssn_appended='228677764' and l.did=173327970243) or
									(l.ssn_appended='178546978' and l.did=2074179303) or
									(l.ssn_appended='196364565' and l.did=93428187) or
									(l.ssn_appended=''          and l.did=107007223771) or
									(l.ssn_appended='046561828' and l.did=66048309) or
									(l.ssn_appended='132663291' and l.did=2640241816) or
									(l.ssn_appended='623211738' and l.did=122113244666) or
									(l.ssn_appended='542089805' and l.did=2166694879),
								0,
								l.score);
		
//Add offender_persistent_id////////////////////////////////////////
		
		self.offender_persistent_id := hash64(trim(l.seisint_primary_key, left, right)+trim((string)l.nid, left, right)+trim(l.dob, left, right)+trim(l.dob_aka, left, right));
		self 				:= l;
	end;

	suppressed_records := project(ds_fixed_data_flagged, removeInfo(left)):persist('~thor_data400::Persist::hd::Sex_Offender_CROSSMain');
	
	output(suppressed_records,, '~thor_data400::in::hd::sex_offender_crossmain::wd',OVERWRITE, __COMPRESSED__ );


/////////////////////////////////////////////////////////////////////////////////////////////

//export BWR_Produce_MainFile := output(ds_fixed_data,,'out::sex_offender_main'+ doxie_build.buildstate + sexOffender.version,overwrite) : persist('~thor_data400::Persist::Sex_Offender_With_did_ssn','thor_dell400_2');

//CROSS OUTPUT
CROSSMain 	:= suppressed_records;

	sexoffender.Layout_Out_Main oldReform(crossMain l):= transform
		self 	:= l;
	end;

filter_needed_LNmain := project(CROSSMain, oldReform(left));

//LN OUTPUT
LNMain 		:= filter_needed_LNmain(~(trim(name_orig)='CAMPOS, OROSCO' and dob='19920813') AND
~(lname='CAMPOS' and fname='OROSCO' and mname='LEE') AND
~(lname='CAMPOS' and fname='OROSCO' and mname='L')) :persist('~thor_data400::Persist::hd::Sex_Offender_LNMain');


sortedOffender :=  sort(distribute(LNMain(),HASH(seisint_primary_key,vendor_code,source_file)),
                           seisint_primary_key,  vendor_code ,   source_file ,	 offender_persistent_id,
                           did ,   score ,   ssn_appended ,   ssn_perms ,   dt_first_reported ,   dt_last_reported ,
                           orig_state ,   orig_state_code ,     
                           record_type ,  // name_type ,
													 StringLib.StringFilter(StringLib.StringToUpperCase(name_orig),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												   StringLib.StringFilter(StringLib.StringToUpperCase(lname+fname+mname+name_suffix),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
	                         nid,	 ntype,   nindicator,
                           intnet_email_address_1 ,	intnet_email_address_2 , intnet_email_address_3 , intnet_email_address_4 , intnet_email_address_5 ,		
                           intnet_instant_message_addr_1 , intnet_instant_message_addr_2 , intnet_instant_message_addr_3 , intnet_instant_message_addr_4 ,   intnet_instant_message_addr_5 ,
                           intnet_user_name_1 , intnet_user_name_1_url , intnet_user_name_2 , intnet_user_name_2_url , intnet_user_name_3 , intnet_user_name_3_url ,	
                           intnet_user_name_4 ,	intnet_user_name_4_url , intnet_user_name_5 , intnet_user_name_5_url ,	
                           offender_status , offender_category , risk_level_code , risk_description ,
                           police_agency , police_agency_contact_name , police_agency_address_1 , police_agency_address_2 , police_agency_phone ,
                           registration_type , reg_date_1 , reg_date_1_type , reg_date_2 , reg_date_2_type , reg_date_3 , reg_date_3_type ,
                           registration_address_1 , registration_address_2 , registration_address_3 , registration_address_4 , registration_address_5 , registration_county ,
                           registration_home_phone , registration_cell_phone , 
	                         other_registration_address_1 , other_registration_address_2 , other_registration_address_3 , other_registration_address_4 , other_registration_address_5 ,	
                           other_registration_county ,  other_registration_phone ,		  
                           temp_lodge_address_1 , temp_lodge_address_2 , temp_lodge_address_3 , temp_lodge_address_4 , temp_lodge_address_5 ,	temp_lodge_county ,	 temp_lodge_phone,				        
                           employer , employer_address_1 , employer_address_2 , employer_address_3 , employer_address_4 ,  employer_address_5 ,  employer_county ,  employer_phone ,  employer_comments ,			  
                           professional_licenses_1 , professional_licenses_2 , professional_licenses_3 , professional_licenses_4 , professional_licenses_5 ,	
                           school , school_address_1 ,  school_address_2 , school_address_3 , school_address_4 ,  school_address_5 ,
                           school_county , school_phone , school_comments ,
                           doc_number , sor_number , st_id_number , fbi_number , ncic_number , ssn , dob , dob_aka , age , dna , race , ethnicity , sex ,
                           hair_color , eye_color , height , weight ,  skin_tone ,  build_type ,  scars_marks_tattoos ,  shoe_size ,  corrective_lense_flag ,
                           addl_comments_1 , addl_comments_2 ,  orig_dl_number ,  orig_dl_state ,  orig_dl_link ,  orig_dl_date ,
	                         passport_type ,  passport_code ,  passport_number ,  passport_first_name ,	 passport_given_name ,  passport_nationality ,  passport_dob ,					
                           passport_place_of_birth ,  passport_sex , passport_issue_date ,	passport_authority ,  passport_expiration_date , passport_endorsement ,	 passport_link ,				      
                           passport_date ,				      
                           orig_veh_year_1 , orig_veh_color_1 ,  orig_veh_make_model_1 , orig_veh_plate_1 ,  orig_registration_number_1 ,  orig_veh_state_1 , orig_veh_location_1 ,			    
                           orig_veh_year_2 , orig_veh_color_2 ,  orig_veh_make_model_2 , orig_veh_plate_2 ,  orig_registration_number_2 ,  orig_veh_state_2 , orig_veh_location_2 ,			    
                           orig_veh_year_3 , orig_veh_color_3 ,  orig_veh_make_model_3 , orig_veh_plate_3 ,  orig_registration_number_3 ,  orig_veh_state_3 , orig_veh_location_3 ,			    
                           orig_veh_year_4 , orig_veh_color_4 ,  orig_veh_make_model_4 , orig_veh_plate_4 ,  orig_registration_number_4 ,	 orig_veh_state_4 , orig_veh_location_4 ,			    
                           orig_veh_year_5 , orig_veh_color_5 ,	 orig_veh_make_model_5 , orig_veh_plate_5 ,  orig_registration_number_5 ,	 orig_veh_state_5 ,	orig_veh_location_5 ,			    
                           fingerprint_link , fingerprint_date ,  palmprint_link ,  palmprint_date , image_link , image_date , addr_dt_last_seen ,  
													 prim_range ,predir ,prim_name ,addr_suffix ,postdir ,unit_desig ,sec_range ,p_city_name ,st ,zip5 ,													 
													 rawaid,
                           curr_incar_flag ,   curr_parole_flag ,   curr_probation_flag ,	 fcra_conviction_flag ,	 fcra_traffic_flag ,	 fcra_date ,	 fcra_date_type ,
	                         conviction_override_date ,	 conviction_override_date_type ,	 offense_score ,- offender_id ,local);
	 
dedupedOffender:= dedup(sortedOffender,
                           seisint_primary_key,  vendor_code ,   source_file ,	 offender_persistent_id,
                           did ,   score ,   ssn_appended ,   ssn_perms ,   dt_first_reported ,   dt_last_reported ,
                           orig_state ,   orig_state_code ,     
                           record_type ,  // name_type ,
													 StringLib.StringFilter(StringLib.StringToUpperCase(name_orig),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												   StringLib.StringFilter(StringLib.StringToUpperCase(lname+fname+mname+name_suffix),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
	                         nid,	 ntype,   nindicator,
                           intnet_email_address_1 ,	intnet_email_address_2 , intnet_email_address_3 , intnet_email_address_4 , intnet_email_address_5 ,		
                           intnet_instant_message_addr_1 , intnet_instant_message_addr_2 , intnet_instant_message_addr_3 , intnet_instant_message_addr_4 ,   intnet_instant_message_addr_5 ,
                           intnet_user_name_1 , intnet_user_name_1_url , intnet_user_name_2 , intnet_user_name_2_url , intnet_user_name_3 , intnet_user_name_3_url ,	
                           intnet_user_name_4 ,	intnet_user_name_4_url , intnet_user_name_5 , intnet_user_name_5_url ,	
                           offender_status , offender_category , risk_level_code , risk_description ,
                           police_agency , police_agency_contact_name , police_agency_address_1 , police_agency_address_2 , police_agency_phone ,
                           registration_type , reg_date_1 , reg_date_1_type , reg_date_2 , reg_date_2_type , reg_date_3 , reg_date_3_type ,
                           registration_address_1 , registration_address_2 , registration_address_3 , registration_address_4 , registration_address_5 , registration_county ,
                           registration_home_phone , registration_cell_phone , 
	                         other_registration_address_1 , other_registration_address_2 , other_registration_address_3 , other_registration_address_4 , other_registration_address_5 ,	
                           other_registration_county ,  other_registration_phone ,		  
                           temp_lodge_address_1 , temp_lodge_address_2 , temp_lodge_address_3 , temp_lodge_address_4 , temp_lodge_address_5 ,	temp_lodge_county ,	 temp_lodge_phone,				        
                           employer , employer_address_1 , employer_address_2 , employer_address_3 , employer_address_4 ,  employer_address_5 ,  employer_county ,  employer_phone ,  employer_comments ,			  
                           professional_licenses_1 , professional_licenses_2 , professional_licenses_3 , professional_licenses_4 , professional_licenses_5 ,	
                           school , school_address_1 ,  school_address_2 , school_address_3 , school_address_4 ,  school_address_5 ,
                           school_county , school_phone , school_comments ,// offender_id ,
                           doc_number , sor_number , st_id_number , fbi_number , ncic_number , ssn , dob , dob_aka , age , dna , race , ethnicity , sex ,
                           hair_color , eye_color , height , weight ,  skin_tone ,  build_type ,  scars_marks_tattoos ,  shoe_size ,  corrective_lense_flag ,
                           addl_comments_1 , addl_comments_2 ,  orig_dl_number ,  orig_dl_state ,  orig_dl_link ,  orig_dl_date ,
	                         passport_type ,  passport_code ,  passport_number ,  passport_first_name ,	 passport_given_name ,  passport_nationality ,  passport_dob ,					
                           passport_place_of_birth ,  passport_sex , passport_issue_date ,	passport_authority ,  passport_expiration_date , passport_endorsement ,	 passport_link ,				      
                           passport_date ,				      
                           orig_veh_year_1 , orig_veh_color_1 ,  orig_veh_make_model_1 , orig_veh_plate_1 ,  orig_registration_number_1 ,  orig_veh_state_1 , orig_veh_location_1 ,			    
                           orig_veh_year_2 , orig_veh_color_2 ,  orig_veh_make_model_2 , orig_veh_plate_2 ,  orig_registration_number_2 ,  orig_veh_state_2 , orig_veh_location_2 ,			    
                           orig_veh_year_3 , orig_veh_color_3 ,  orig_veh_make_model_3 , orig_veh_plate_3 ,  orig_registration_number_3 ,  orig_veh_state_3 , orig_veh_location_3 ,			    
                           orig_veh_year_4 , orig_veh_color_4 ,  orig_veh_make_model_4 , orig_veh_plate_4 ,  orig_registration_number_4 ,	 orig_veh_state_4 , orig_veh_location_4 ,			    
                           orig_veh_year_5 , orig_veh_color_5 ,	 orig_veh_make_model_5 , orig_veh_plate_5 ,  orig_registration_number_5 ,	 orig_veh_state_5 ,	orig_veh_location_5 ,			    
                           fingerprint_link , fingerprint_date ,  palmprint_link ,  palmprint_date , image_link , image_date ,
                           addr_dt_last_seen ,  prim_range ,predir ,prim_name ,addr_suffix ,postdir ,unit_desig ,sec_range ,p_city_name ,st ,zip5 ,  rawaid,
                           curr_incar_flag ,   curr_parole_flag ,   curr_probation_flag ,	 fcra_conviction_flag ,	 fcra_traffic_flag ,	 fcra_date ,	 fcra_date_type ,
	                         conviction_override_date ,	 conviction_override_date_type ,	 offense_score ,local): persist('Persist::Crim_offender_persistentID1');

export MainFile := dedupedOffender;
