IMPORT Address,ut,did_add,business_header_ss,header_slimsort,VehLic,didville,driversv2,idl_header,STD;

EXPORT map_basefile_inquiry(STRING filedate) := FUNCTION

	d := InFile_NtlAccidents_Alpharetta.cmbnd_ntl_inq(first_name_1 + middle_name_1 + last_name_1 + vin != '');
	vina := VehLic.File_VINA;
	dvina := DISTRIBUTE(vina,HASH32(vin_input));
	uvina := DEDUP(SORT(dvina, vin_input, -((UNSIGNED) model_year), LOCAL), vin_input, LOCAL):PERSIST('~thor_data400::persist::natAcc_inq_vina');

////////////////////////////////////////////////////////////////////////////
//Clean names AND addresses then append vina info
///////////////////////////////////////////////////////////////////////////
//Prep address fields for clean address macro to accept
	temp_layout := RECORD
	 d;
	 STRING temp_addr1 := '';
	 STRING temp_addr2 := '';
	END;

	temp_layout trecs(d L) := TRANSFORM
	 SELF.temp_addr1 := L.HOUSE_NBR+' '+L.STREET+' '+L.APT_NBR;
	 SELF.temp_addr2 := IF(L.CITY+' '+L.STATE+' '+L.ZIP5 != '', 
	                       L.CITY+' '+L.STATE+' '+L.ZIP5, 
												 L.inc_CITY+' '+L.STATE_ABBR);
	 SELF := L;
	END;
  precs := PROJECT(d, trecs(LEFT));

	PrecsBlankAddr := precs(temp_addr1 = '' AND temp_addr2 = ''); 
	PrecsNBlankAddr := precs(~(temp_addr1 = '' AND temp_addr2 = '')); 

	//Clean address
	Address.MAC_Address_Clean(PrecsNBlankAddr, temp_addr1, temp_addr2, TRUE, appndAddr);	
	cleanAddr := appndAddr + PROJECT(PrecsBlankAddr, TRANSFORM({appndAddr}, SELF.clean := '', SELF := LEFT));	

	//Parse appended 182 byte clean address field
	Layout_CRU_inquiries trecs2(cleanAddr L, uvina R) := TRANSFORM
	 SELF.dt_first_seen := mod_Utilities.ConvertSlashedMDYtoCYMD(L.loss_date[1..10]);
	 SELF.dt_last_seen := IF(L.Last_Changed<>'', L.Last_Changed, SELF.dt_first_seen);
	 SELF.dob_1 := mod_Utilities.ConvertSlashedMDYtoCYMD(TRIM(l.dob_1, LEFT, RIGHT)[1..10]); 
	 SELF.report_code := L.service_id;
	 SELF.report_category := Tables_NtlAccidentsInquiry.ReportCategory(L.Service_ID);
	 SELF.report_code_desc := Tables_NtlAccidentsInquiry.ReportCodeDesc(L.Service_ID);	
		/* Input address is the address where the loss occurred AND should not be assumed to be the address of any of the involved parties.  
		Most values are cross streets. EX: 'Yamato AND Congress' or 'Winn Dixie P Lot'
		SELF.prim_range 					:= L.clean[1..10]; 
		SELF.predir 							:= L.clean[11..12];					   
		SELF.prim_name 						:= L.clean[13..40];
		SELF.suffix 							:= L.clean[41..44];
		SELF.postdir 							:= L.clean[45..46];
		SELF.unit_desig 					:= L.clean[47..56];
		SELF.sec_range 						:= L.clean[57..64];
		*/
	 SELF.p_city_name := L.clean[65..89];
	 SELF.v_city_name := L.clean[90..114];
	 SELF.st := IF(L.clean[115..116]='', ziplib.ZipToState2(L.clean[117..121]), L.clean[115..116]);
	 SELF.z5 := '';//the only zip info provided is contained in the order version table AND must be labeled as inquiry data 
	 SELF.z4 := '';//the only zip info provided is contained in the order version table AND must be labeled as inquiry data 
	 SELF.cart := L.clean[126..129];
	 SELF.cr_sort_sz := L.clean[130];
	 SELF.lot := L.clean[131..134];
	 SELF.lot_order := L.clean[135];
	 SELF.dpbc := L.clean[136..137];
	 SELF.chk_digit := L.clean[138];
	 SELF.rec_type := L.clean[139..140];
	 SELF.county_code := L.clean[141..145];
	 SELF.geo_lat := L.clean[146..155];
	 SELF.geo_long := L.clean[156..166];
	 SELF.msa := L.clean[167..170];
	 SELF.geo_blk := L.clean[171..177];
	 SELF.geo_match := L.clean[178];
	 SELF.err_stat := L.clean[179..182];

	 //Clean the names of all involved parties -- (party file is already normalized) -- get middle names from order file
 	 CleanName1 := Address.CleanPersonFML73(STD.Str.CleanSpaces(L.FIRST_NAME_1 + ' ' + L.MIDDLE_NAME_1 + ' ' + L.LAST_NAME_1));
	 CleanName2 := Address.CleanPersonFML73(STD.Str.CleanSpaces(L.FIRST_NAME_2 + ' ' + L.MIDDLE_NAME_2 + ' ' + L.LAST_NAME_2));
	 CleanName3 := Address.CleanPersonFML73(STD.Str.CleanSpaces(L.FIRST_NAME_3 + ' ' + L.MIDDLE_NAME_3 + ' ' + L.LAST_NAME_3));

	 SELF.orig_fname := L.FIRST_NAME_1;
	 SELF.orig_lname := L.LAST_NAME_1;
	 SELF.orig_mname := L.MIDDLE_NAME_1; 
	 SELF.orig_fname2 := L.FIRST_NAME_2;
	 SELF.orig_lname2 := L.LAST_NAME_2;
	 SELF.orig_mname2 := L.MIDDLE_NAME_2;
	 SELF.orig_fname3 := L.FIRST_NAME_3;
	 SELF.orig_lname3 := L.LAST_NAME_3;
	 SELF.orig_mname3 := L.MIDDLE_NAME_3;
	 //Parse 73 byte clean name field
	 SELF.title := CleanName1[1..5];
	 SELF.fname := IF(CleanName1[6..25]='UNKNOWN', '', CleanName1[6..25]);
	 SELF.mname := IF(CleanName1[26..45]='UNKNOWN', '', CleanName1[26..45]); 
	 SELF.lname := IF(CleanName1[46..65]='UNKNOWN', '', CleanName1[46..65]);
	 SELF.name_suffix := CleanName1[66..70];
	 SELF.name_score := CleanName1[71..73];
	 //Parse 73 byte clean name field
	 SELF.title2 := CleanName2[1..5];
	 SELF.fname2 := IF(CleanName2[6..25]='UNKNOWN', '', CleanName2[6..25]);
	 SELF.mname2 := IF(CleanName2[26..45]='UNKNOWN', '', CleanName2[26..45]); 
	 SELF.lname2 := IF(CleanName2[46..65]='UNKNOWN', '', CleanName2[46..65]);
	 SELF.name_suffix2 := CleanName2[66..70];
	 SELF.name_score2 := CleanName2[71..73];
	 //Parse 73 byte clean name field
	 SELF.title3 := CleanName3[1..5];
 	 SELF.fname3 := IF(CleanName3[6..25]='UNKNOWN', '', CleanName3[6..25]);
	 SELF.mname3 := IF(CleanName3[26..45]='UNKNOWN', '', CleanName3[26..45]); 
	 SELF.lname3 := IF(CleanName3[46..65]='UNKNOWN', '', CleanName3[46..65]);
	 SELF.name_suffix3 := CleanName3[66..70];
	 SELF.name_score3 := CleanName3[71..73];

	 // populated by Vina File
	 SELF.vehicle_seg := MAP(L.vin = R.vin_input => R.variable_segment, '');	
	 SELF.vehicle_seg_type := MAP(L.vin = R.vin_input => R.veh_type, '');	
	 SELF.model_year := MAP(L.vin = R.vin_input => R.model_year, '');	
	 SELF.body_style_code := MAP(L.vin = R.vin_input => R.vina_body_style, '');	
	 SELF.engine_size := MAP(L.vin = R.vin_input => R.engine_size, '');	
	 SELF.fuel_code := MAP(L.vin = R.vin_input => R.fuel_code, '');	
	 SELF.number_of_driving_wheels := MAP(L.vin = R.vin_input => R.vp_tilt_wheel, '');	
	 SELF.steering_type := MAP(L.vin = R.vin_input => R.vp_power_steering, '');		
	 SELF.vina_series := MAP(L.vin = R.vin_input => R.vina_series, '');	
	 SELF.vina_model := MAP(L.vin = R.vin_input => R.vina_model, '');	
	 SELF.vina_make := MAP(L.vin = R.vin_input => R.make_description, '');	
	 SELF.vina_body_style := MAP(L.vin = R.vin_input => R.vina_body_style, '');		
	 SELF.make_description := MAP(L.vin = R.vin_input => R.make_description, L.vehmake);			
	 SELF.model_description	:= MAP(L.vin = R.vin_input => R.model_description, L.vehmodel);		
	 SELF.series_description := MAP(L.vin = R.vin_input => R.series_description, '');	
	 SELF.car_cylinders := MAP(L.vin = R.vin_input => R.number_of_cylinders, '');
	 SELF.vehicle_status := IF(R.vin_input !='', 'V', '');	
	 SELF.vehicle_incident_id	:= IF(L.vehicle_incident_id != '', L.vehicle_incident_id , 'OID' + L.order_id);
	 SELF := L;
	END;
  jrecs := JOIN(DISTRIBUTE(cleanAddr(vin != ''),HASH32(vin)), uvina,
					      LEFT.vin = RIGHT.vin_input,
					      trecs2(LEFT,RIGHT),LEFT OUTER,LOCAL);

	////////////////////////////////////////////////////////////////////////////
	//Clean names AND addresses of records without a vin (flows have been split 
	//for faster processing time.  Vin is populated 60+% 
	///////////////////////////////////////////////////////////////////////////
	Layout_CRU_inquiries trecs3(cleanAddr L) := TRANSFORM
   SELF.dt_first_seen := mod_Utilities.ConvertSlashedMDYtoCYMD(L.loss_date[1..10]);
	 SELF.dt_last_seen	:= MAP(L.Last_Changed = '00000000' OR L.Last_Changed = '' => SELF.dt_first_seen, L.Last_Changed);
	 SELF.dob_1 := mod_Utilities.ConvertSlashedMDYtoCYMD(TRIM(l.dob_1,LEFT,RIGHT)[1..10]); 
	 SELF.report_code := L.service_id;
	 SELF.report_category := Tables_NtlAccidentsInquiry.ReportCategory(L.Service_ID);
	 SELF.report_code_desc	:= Tables_NtlAccidentsInquiry.ReportCodeDesc(L.Service_ID);	
		/* Input address is the address where the loss occurred AND should not be assumed to be the address of any of the involved parties.  
		Most values are cross streets. EX: 'Yamato AND Congress' OR 'Winn Dixie P Lot'
		SELF.prim_range 					:= L.clean[1..10]; 
		SELF.predir 							:= L.clean[11..12];					   
		SELF.prim_name            := L.clean[13..40];
		SELF.suffix 							:= L.clean[41..44];
		SELF.postdir 							:= L.clean[45..46];
		SELF.unit_desig 					:= L.clean[47..56];
		SELF.sec_range := L.clean[57..64];
		*/
	 SELF.p_city_name := L.clean[65..89];
	 SELF.v_city_name := L.clean[90..114];
	 SELF.st := IF(L.clean[115..116]='', ziplib.ZipToState2(L.clean[117..121]), L.clean[115..116]);
	 SELF.z5 := '';//the only zip info provided is contained in the order version table AND must be labeled as inquiry data 
	 SELF.z4 := '';//the only zip info provided is contained in the order version table AND must be labeled as inquiry data 
	 SELF.cart := L.clean[126..129];
	 SELF.cr_sort_sz := L.clean[130];
	 SELF.lot := L.clean[131..134];
	 SELF.lot_order := L.clean[135];
	 SELF.dpbc := L.clean[136..137];
	 SELF.chk_digit := L.clean[138];
	 SELF.rec_type := L.clean[139..140];
	 SELF.county_code := L.clean[141..145];
	 SELF.geo_lat := L.clean[146..155];
	 SELF.geo_long := L.clean[156..166];
	 SELF.msa := L.clean[167..170];
	 SELF.geo_blk := L.clean[171..177];
	 SELF.geo_match := L.clean[178];
	 SELF.err_stat := L.clean[179..182];

	 //Clean the names of all involved parties -- (party file is already normalized) -- get middle names from order file
	 CleanName1 := Address.CleanPersonFML73(STD.Str.CleanSpaces(L.FIRST_NAME_1 + ' ' + L.MIDDLE_NAME_1 + ' ' + L.LAST_NAME_1));
	 CleanName2 := Address.CleanPersonFML73(STD.Str.CleanSpaces(L.FIRST_NAME_2 + ' ' + L.MIDDLE_NAME_2 + ' ' + L.LAST_NAME_2));
	 CleanName3 := Address.CleanPersonFML73(STD.Str.CleanSpaces(L.FIRST_NAME_3 + ' ' + L.MIDDLE_NAME_3 + ' ' + L.LAST_NAME_3));

	 SELF.orig_fname :=L.FIRST_NAME_1;
	 SELF.orig_lname :=L.LAST_NAME_1;
	 SELF.orig_mname :=L.MIDDLE_NAME_1; 
	 SELF.orig_fname2 :=L.FIRST_NAME_2;
	 SELF.orig_lname2 :=L.LAST_NAME_2;
	 SELF.orig_mname2 :=L.MIDDLE_NAME_2;
	 SELF.orig_fname3 :=L.FIRST_NAME_3;
	 SELF.orig_lname3 :=L.LAST_NAME_3;
	 SELF.orig_mname3 :=L.MIDDLE_NAME_3;
	 //Parse 73 byte clean name field
	 SELF.title := CleanName1[1..5];
	 SELF.fname := IF(CleanName1[6..25]='UNKNOWN', '', CleanName1[6..25]);
	 SELF.mname := IF(CleanName1[26..45]='UNKNOWN', '', CleanName1[26..45]); 
	 SELF.lname := IF(CleanName1[46..65]='UNKNOWN', '', CleanName1[46..65]);
	 SELF.name_suffix := CleanName1[66..70];
	 SELF.name_score := CleanName1[71..73];
	 //Parse 73 byte clean name field
	 SELF.title2 := CleanName2[1..5];
	 SELF.fname2 := IF(CleanName2[6..25]='UNKNOWN', '', CleanName2[6..25]);
	 SELF.mname2 := IF(CleanName2[26..45]='UNKNOWN', '', CleanName2[26..45]); 
	 SELF.lname2 := IF(CleanName2[46..65]='UNKNOWN', '', CleanName2[46..65]);
	 SELF.name_suffix2 := CleanName2[66..70];
	 SELF.name_score2 := CleanName2[71..73];
	 //Parse 73 byte clean name field
	 SELF.title3 := CleanName3[1..5];
	 SELF.fname3 := IF(CleanName3[6..25]='UNKNOWN','', CleanName3[6..25]);
	 SELF.mname3 := IF(CleanName3[26..45]='UNKNOWN','', CleanName3[26..45]); 
	 SELF.lname3 := IF(CleanName3[46..65]='UNKNOWN','', CleanName3[46..65]);
	 SELF.name_suffix3 := CleanName3[66..70];
	 SELF.name_score3 := CleanName3[71..73];
	 SELF.vehicle_status := '';
	 SELF.vehicle_incident_id := IF(L.vehicle_incident_id != '', L.vehicle_incident_id , 'OID' + L.order_id);	
	 SELF := L;
	 SELF := [];
	END;
  precs2 := PROJECT(cleanAddr(vin = ''),trecs3(LEFT));
					
	cmbndRecs := jrecs + precs2 :PERSIST('~thor_data400::persist::natAcc_inq_clean');
	
	/////////////////////////////////////////////////////////////////////////////
	//Pad ssn_1 before passing through the ADL macro
	temp_ssn_1_layout := RECORD 
	 STRING temp_ssn_1 := '';
	 cmbndRecs;
	END;

	temp_ssn_1_layout padssn_1(cmbndRecs L) := TRANSFORM
	 SELF.temp_ssn_1 := MAP(LENGTH(L.ssn_1) = 7 => '00' + L.ssn_1
							           ,LENGTH(L.ssn_1) = 8 => '0' + L.ssn_1
							           ,L.ssn_1);
	 SELF := L;
	END;
  p_ssn_1 := PROJECT(cmbndRecs, padssn_1(LEFT));

	////////////////////////////////////////////////////////////////////////////////////////
	// Pass records to Name Flip Macro to enhance linking
	////////////////////////////////////////////////////////////////////////////////////////
	ut.mac_flipnames(p_ssn_1, fname, mname, lname, did_prep);
	
	/////////////////////////////////////////////////////////////////////////////
	//append DID 
	did_matchset := ['A','D','S','Z','G','4'];
	did_add.MAC_Match_Flex(did_prep, did_matchset, temp_ssn_1, dob_1, fname, mname
	                       ,lname, name_suffix, prim_range, prim_name, sec_range
												 , zip5, st, nophone, did, did_prep, TRUE, did_score, 75, did_recs);
	/////////////////////////////////////////////////////////////////////////////
	// Return to original layout 
	cmbndRecs tr(did_recs L) := TRANSFORM
	 SELF := L;
	END;
  p_recs := PROJECT(did_recs, tr(LEFT));

	/////////////////////////////////////////////////////////////////////////////
	//population stats show business name field to be 0%				   

	//append bdid
	//bdid_matchset := ['A'];
	//business_header_ss.MAC_match_FLEX(did_recs,bdid_matchset,business_name,
					//prim_range,prim_name,z5,sec_range,st,foo,foo,
					//bdid,did_recs,true,bdid_score,
					//bdid_recs);
	////////////////////////////////////////////////////////////////////////////////////////////////////
	//Append DID using lfname AND dl match --bug # 48839
	////////////////////////////////////////////////////////////////////////////////////////////////////
	natInq_noDID:= p_recs(did=0 AND DRIVERS_LICENSE != '');
	natInq_allothers:= p_recs(did!=0 OR DRIVERS_LICENSE = '');
	//splitting streams above to reduce skewing AND process run time.
  dlf := driversv2.File_DL(did!=0 AND REGEXFIND('[1-9]', dl_number) AND LENGTH(lname)>1 AND dl_number !='1111111');
  //create dl/DID table
	slim_dl := RECORD
	 dlf.lname;
	 dlf.fname;
	 dlf.mname;
	 dlf.dl_number;
	 dlf.orig_state;
	 dlf.did;
	END;
  tbl_dls := TABLE(dlf, slim_dl, lname, fname, mname, dl_number, orig_state, did, FEW) :PERSIST('~thor_200::persist::tbl_dl_ntl');

	natInq_noDID getDID(natInq_noDID L, tbl_dls R) :=TRANSFORM
	 SELF.did := MAP(L.DRIVERS_LICENSE = R.dl_number 
			             AND ut.NNEQ(L.drivers_license_st,R.orig_state) 
			             AND (REGEXFIND(REGEXREPLACE(' +',r.lname,' ')
					                       ,REGEXREPLACE(' +',l.fname+' '+l.mname+' '+l.lname,' ')) OR 
					             REGEXFIND(TRIM(r.lname,ALL)
						                    ,REGEXREPLACE(' +',l.fname+' '+l.mname+' '+l.lname,' ')))
			             => R.did,L.did);		
	 SELF := L;
	END;
	appndDID := JOIN(natInq_noDID, DEDUP(tbl_dls, dl_number, lname, ALL),
			             LEFT.DRIVERS_LICENSE = RIGHT.dl_number AND
				           ut.NNEQ(LEFT.drivers_license_st, RIGHT.orig_state) AND
			            (REGEXFIND(REGEXREPLACE(' +', RIGHT.lname, ' ')
					                                ,REGEXREPLACE(' +', LEFT.fname + ' ' + LEFT.mname + ' ' + LEFT.lname,' ')) OR 
					                  REGEXFIND(TRIM(RIGHT.lname,all)
						                          ,REGEXREPLACE(' +', LEFT.fname + ' ' + LEFT.mname + ' ' + LEFT.lname, ' '))),
			                                    getDID(LEFT, RIGHT), LEFT OUTER, HASH);

	appndDID getDID2(appndDID L, tbl_dls R) :=TRANSFORM
   SELF.did := MAP(L.did = 0 AND L.DRIVERS_LICENSE = R.dl_number AND ut.NNEQ(L.drivers_license_st, R.orig_state)
			             AND ut.NNEQ((STRING)L.mname[1], (STRING)R.mname[1])
			             AND (REGEXFIND(REGEXREPLACE(' +', r.fname, ' ')
					                       ,REGEXREPLACE(' +', l.fname + ' ' + l.mname + ' ' + l.lname, ' ')) OR 
					                        REGEXFIND(TRIM(r.fname,ALL)
						                               ,REGEXREPLACE(' +', l.fname + ' ' + l.mname + ' ' + l.lname, ' ')))
			             => R.did, L.did);
	 SELF := L;
  END;
	
	appndDID2 := JOIN(appndDID, DEDUP(tbl_dls, dl_number, fname, ALL),
			              LEFT.did = 0 AND 
			              LEFT.DRIVERS_LICENSE = RIGHT.dl_number AND
				            ut.NNEQ(LEFT.drivers_license_st,RIGHT.orig_state) AND
			              ut.NNEQ((STRING)LEFT.mname[1],(STRING)RIGHT.mname[1]) AND 
			              (REGEXFIND(REGEXREPLACE(' +', RIGHT.fname, ' ')
					                    ,REGEXREPLACE(' +', LEFT.fname + ' ' + LEFT.mname + ' ' + LEFT.lname, ' ')) OR 
					                     REGEXFIND(TRIM(RIGHT.fname,ALL)
						                            ,REGEXREPLACE(' +', LEFT.fname + ' ' + LEFT.mname + ' ' + LEFT.lname, ' '))),
			              getDID2(LEFT,RIGHT), LEFT OUTER, HASH);

  natInq_all := appndDID2 + natInq_allothers :PERSIST('~thor_data400::persist::ecrash_ntlinq_did');								
	
	sfShuffle := SEQUENTIAL(fileservices.RemoveOwnedSubFiles('~thor_data400::base::ntlcrash_inquiry_delete',TRUE),
		                      fileservices.addsuperfile('~thor_data400::base::ntlcrash_inquiry_delete','~thor_data400::base::ntlcrash_inquiry_grandfather',0,TRUE),
		                      fileservices.startsuperfiletransaction(),
		                      fileservices.clearsuperfile('~thor_data400::base::ntlcrash_inquiry_grandfather'),
		                      fileservices.addsuperfile('~thor_data400::base::ntlcrash_inquiry_grandfather','~thor_data400::base::ntlcrash_inquiry_father',0,TRUE),
		                      fileservices.clearsuperfile('~thor_data400::base::ntlcrash_inquiry_father'),
		                      fileservices.addsuperfile('~thor_data400::base::ntlcrash_inquiry_father','~thor_data400::base::ntlcrash_inquiry',0,TRUE),
		                      fileservices.clearsuperfile('~thor_data400::base::ntlcrash_inquiry'),
		                      fileservices.addsuperfile('~thor_data400::base::ntlcrash_inquiry','~thor_data400::base::alpharetta::national_accidents_inquiry_'+filedate),
		                      fileservices.finishsuperfiletransaction()
		                      );
		
	RETURN
	SEQUENTIAL(OUTPUT(DEDUP(natInq_all, RECORD, ALL),,'~thor_data400::base::alpharetta::national_accidents_inquiry_'+filedate, OVERWRITE, __COMPRESSED__)
	          ,sfShuffle);
END;