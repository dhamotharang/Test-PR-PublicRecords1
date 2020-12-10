IMPORT Address,ut,did_add,business_header_ss,header_slimsort,VehLic,didville,driversv2,idl_header,std;

EXPORT Map_NtlAccidents_Alpharetta(string filedate) := FUNCTION

 d:= FLAccidents.InFile_NtlAccidents_Alpharetta.cmbnd_ntl_accidents;
 vina	:= VehLic.File_VINA;
 dvina := DISTRIBUTE(vina, HASH32(vin_input));
 uvina := DEDUP(SORT(dvina, vin_input, -((UNSIGNED) model_year), LOCAL), vin_input, LOCAL) :PERSIST('~thor_data400::persist::natAcc_vina');

////////////////////////////////////////////////////////////////////////////
//Clean names and addresses then append vina info
///////////////////////////////////////////////////////////////////////////
//Prep address fields for clean address macro to accept
 temp_layout2 := RECORD
  d;
  STRING temp_addr1 := '';
  STRING temp_addr2 := '';
 END;

 temp_layout2 trecsb(d L) := TRANSFORM
  SELF.temp_addr1 := L.HOUSE_NBR + ' ' + L.STREET + ' ' + L.APT_NBR;
  SELF.temp_addr2 := L.inc_CITY + ' ' + L.STATE_ABBR + ' ' + L.ZIP5;
  SELF.edit_agency_name := TRIM(REGEXREPLACE(';' , TRIM(L.edit_agency_name), ''));
  SELF := L;
 END;
 precs := PROJECT(d, trecsb(LEFT));

//Clean address
 Address.MAC_Address_Clean(precs, temp_addr1, temp_addr2, TRUE, appndAddr);	
 cleanAddr := appndAddr;	

//Parse appended 182 byte clean address field
 Layout_NtlAccidents_Alpharetta.clean trecs2b(cleanAddr L, uvina R) := TRANSFORM
  SELF.dt_first_seen := mod_Utilities.ConvertSlashedMDYtoCYMD(L.loss_date[1..10]);
  SELF.dt_last_seen := IF(L.Last_Changed <> '', L.Last_Changed, SELF.dt_first_seen);
  SELF.POLICY_EXP_DATE := mod_Utilities.ConvertSlashedMDYtoCYMD(L.POLICY_EXP_DATE[1..10]);
  SELF.report_code := L.service_id;
  SELF.report_category := Tables_NtlAccidentsInquiry.ReportCategory(L.Service_ID);
  SELF.report_code_desc	 := Tables_NtlAccidentsInquiry.ReportCodeDesc(L.Service_ID);	
  /* Input address is the address where the loss occurred and should not be assumed to be the address of any of the involved parties.  
  Most values are cross streets. EX: 'Yamato and Congress' or 'Winn Dixie P Lot'
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
  SELF.z5 := '';//the only zip info provided is contained in the order version table and must be labeled as inquiry data 
  SELF.z4 := '';//the only zip info provided is contained in the order version table and must be labeled as inquiry data 
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
  SELF.geo_matcH := L.clean[178];
  SELF.err_stat := L.clean[179..182];
//Clean the names of all involved parties -- (party file is already normalized) -- get middle names from order file
  CleanName := MAP(L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1 => Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME + ' ' + L.MIDDLE_NAME_1 + ' ' + L.LAST_NAME))
									,L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_2 + L.FIRST_NAME_2 => Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME + ' ' + L.MIDDLE_NAME_2 + ' ' + L.LAST_NAME))
									,L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_3 + L.FIRST_NAME_3 => Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME + ' ' + L.MIDDLE_NAME_3 + ' ' + L.LAST_NAME))
									,'');

  SELF.orig_fname := MAP(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1 => L.FIRST_NAME
												,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_2 + L.FIRST_NAME_2 => L.FIRST_NAME
												,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_3 + L.FIRST_NAME_3 => L.FIRST_NAME
											  ,''); 
  SELF.orig_lname := MAP(L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1 => L.LAST_NAME
											  ,L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_2 + L.FIRST_NAME_2 =>L.LAST_NAME
											  ,L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_3 + L.FIRST_NAME_3 => L.LAST_NAME
											  ,''); 
  SELF.orig_mname := '';
//Parse 73 byte clean name field
  SELF.title := CleanName[1..5];
  SELF.fname := IF(CleanName[6..25]='UNKNOWN', '', CleanName[6..25]);
  SELF.mname := ''; //the only middle name info provided is contained in the order version table AND must be labeled as inquiry data 
  SELF.lname := IF(CleanName[46..65]='UNKNOWN', '', CleanName[46..65]);
  SELF.name_suffix := CleanName[66..70];
  SELF.name_score := CleanName[71..73];
// Populate Inquiry fields, these fields contain data pulled from the order version table AND must be labeled accordingly
  SELF.inquiry_ssn := L.inquiry_ssn;
  SELF.inquiry_dob := L.inquiry_dob;
  SELF.inquiry_mname := IF(CleanName[26..45]='UNKNOWN','',CleanName[26..45]);
  SELF.inquiry_zip5 := L.clean[117..121];
  SELF.inquiry_zip4 := L.clean[122..125];
// populated by Vina File
	SELF.vehicle_seg := MAP(L.vehvin = R.vin_input => R.variable_segment, '');	
	SELF.vehicle_seg_type	:= MAP(L.vehvin = R.vin_input => R.veh_type, '');	
	SELF.model_year := MAP(L.vehvin = R.vin_input => R.model_year, '');	
	SELF.body_style_code := MAP(L.vehvin = R.vin_input => R.vina_body_style, '');	
	SELF.engine_size := MAP(L.vehvin = R.vin_input => R.engine_size, '');	
	SELF.fuel_code := MAP(L.vehvin = R.vin_input => R.fuel_code, '');	
	SELF.number_of_driving_wheels := MAP(L.vehvin = R.vin_input => R.vp_tilt_wheel, '');	
	SELF.steering_type := MAP(L.vehvin = R.vin_input => R.vp_power_steering, '');		
	SELF.vina_series := MAP(L.vehvin = R.vin_input => R.vina_series, '');	
	SELF.vina_model := MAP(L.vehvin = R.vin_input => R.vina_model, '');	
	SELF.vina_make := MAP(L.vehvin = R.vin_input => R.make_description, '');	
	SELF.vina_body_style := MAP(L.vehvin = R.vin_input => R.vina_body_style, '');		
	SELF.make_description := MAP(L.vehvin = R.vin_input => R.make_description, L.vehmake);			
	SELF.model_description := MAP(L.vehvin = R.vin_input => R.model_description, L.vehmodel);		
	SELF.series_description := MAP(L.vehvin = R.vin_input => R.series_description, '');	
	SELF.car_cylinders := MAP(L.vehvin = R.vin_input => R.number_of_cylinders, '');	
	SELF := L;
 END;
 jrecs := JOIN(DISTRIBUTE(cleanAddr(vehvin!=''),HASH32(vehvin)), uvina,
				       LEFT.vehvin = RIGHT.vin_input,
				       trecs2b(LEFT,RIGHT), LEFT OUTER, LOCAL);

////////////////////////////////////////////////////////////////////////////
//Clean names AND addresses of records without a vin (flows have been split 
//for faster processing time.  Vin is populated 60+% 
///////////////////////////////////////////////////////////////////////////
 FLAccidents.Layout_NtlAccidents_Alpharetta.clean trecs3b(cleanAddr L) := TRANSFORM
  SELF.dt_first_seen := mod_Utilities.ConvertSlashedMDYtoCYMD(L.loss_date[1..10]);
  SELF.dt_last_seen := MAP(L.Last_Changed = '00000000' OR L.Last_Changed ='' => SELF.dt_first_seen,L.Last_Changed);
  SELF.report_code := L.service_id;
  SELF.report_category :=Tables_NtlAccidentsInquiry.ReportCategory(L.Service_ID);
  SELF.report_code_desc := Tables_NtlAccidentsInquiry.ReportCodeDesc(L.Service_ID);	
	/* Input address is the address where the loss occurred AND should not be assumed to be the address of any of the involved parties.  
	Most values are cross streets. EX: 'Yamato AND Congress' OR 'Winn Dixie P Lot'
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
	CleanName := MAP(L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1 => Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME + ' ' + L.MIDDLE_NAME_1 + ' ' + L.LAST_NAME))
									,L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_2 + L.FIRST_NAME_2 => Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME + ' ' + L.MIDDLE_NAME_2 + ' ' + L.LAST_NAME))
									,L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_3 + L.FIRST_NAME_3 => Address.CleanPersonFML73(stringlib.stringcleanspaces(L.FIRST_NAME + ' ' + L.MIDDLE_NAME_3 + ' ' + L.LAST_NAME))
									,'');
  SELF.orig_fname := MAP(L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1 => L.FIRST_NAME
												,L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_2 + L.FIRST_NAME_2 => L.FIRST_NAME
												,L.LAST_NAME + L.FIRST_NAME = L.LAST_NAME_3 + L.FIRST_NAME_3 => L.FIRST_NAME
												,''); 
	SELF.orig_lname := MAP(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1 => L.LAST_NAME
												,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_2+L.FIRST_NAME_2 =>L.LAST_NAME
												,L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_3+L.FIRST_NAME_3 => L.LAST_NAME
												,''); 
	SELF.orig_mname := '';
//Parse 73 byte clean name field
	SELF.title := CleanName[1..5];
	SELF.fname := CleanName[6..25];
	SELF.mname := ''; //the only middle name info provided is contained in the order version table AND must be labeled as inquiry data 
	SELF.lname := CleanName[46..65];
	SELF.name_suffix := CleanName[66..70];
	SELF.name_score := CleanName[71..73];

// Populate Inquiry fields, these fields contain data pulled from the order version table AND must be labeled accordingly
	SELF.inquiry_ssn := L.inquiry_ssn;
	SELF.inquiry_dob := L.inquiry_dob;
	SELF.inquiry_mname := IF(CleanName[26..45]='UNKNOWN', '', CleanName[26..45]);
	SELF.inquiry_zip5 := L.clean[117..121];
	SELF.inquiry_zip4 := L.clean[122..125];
	SELF := L;
	SELF := [];
 END;
 precs2 := PROJECT(cleanAddr(vehvin=''),trecs3b(LEFT));
				
 cmbndRecs := jrecs+precs2 :PERSIST('~thor_data400::persist::natAcc_clean');
/////////////////////////////////////////////////////////////////////////////
//Pad SSN  AND combine dob AND inquiry dob before passing through the ADL macro
 temp_ssn_layout := RECORD 
  STRING temp_ssn := '';
  STRING temp_dob := '';
  cmbndRecs;
 END;

 temp_ssn_layout padSSN(cmbndRecs L) := TRANSFORM
  SELF.temp_ssn := MAP(LENGTH(L.inquiry_ssn) = 7 => '00'+L.inquiry_ssn
					            ,LENGTH(L.inquiry_ssn) = 8 => '0' +L.inquiry_ssn
					            ,L.inquiry_ssn);
  SELF.temp_dob := IF(L.dob != '', L.dob,L.inquiry_dob);
  SELF := L;
 END;
 p_ssn := PROJECT(cmbndRecs,padSSN(LEFT));

////////////////////////////////////////////////////////////////////////////////////////
// Pass records to Name Flip Macro to enhance linking
////////////////////////////////////////////////////////////////////////////////////////
 ut.mac_flipnames(p_ssn,fname,inquiry_mname,lname,p_ssn_did_prep);

/////////////////////////////////////////////////////////////////////////////
//append DID 
 did_matchset := ['A','D','S','Z','G','4'];
 did_add.MAC_Match_Flex(p_ssn_did_prep, did_matchset,
                        temp_ssn, temp_dob, fname, inquiry_mname, lname, name_suffix,
				                prim_range, prim_name, sec_range, inquiry_zip5, st, nophone,
				                did, p_ssn_did_prep, TRUE, did_score, 75, did_recs);
/////////////////////////////////////////////////////////////////////////////
// Return to original layout 
 cmbndRecs tr(did_recs L) := TRANSFORM
  SELF := L;
 END;
 p_recs := PROJECT(did_recs,tr(LEFT));

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
 natAcc_noDID:= p_recs(did=0 AND pty_DRIVERS_LICENSE != '');
 natAcc_allothers:= p_recs(did!=0 OR pty_DRIVERS_LICENSE = '');
 //splitting streams above to reduce skewing AND process run time.
 
 dlf := driversv2.File_DL(did!=0 AND REGEXFIND('[1-9]',dl_number) AND LENGTH(lname)>1 AND dl_number !='1111111');
 //create dl/DID table
 slim_dl := RECORD
  dlf.lname;
  dlf.fname;
  dlf.mname;
  dlf.dl_number;
  dlf.orig_state;
  dlf.did;
 END;
 tbl_dls := TABLE(dlf, slim_dl, lname, fname, mname, dl_number, orig_state, did, FEW):PERSIST('~thor_200::persist::tbl_dl_ntl');
 
 natAcc_noDID getDID(natAcc_noDID L, tbl_dls R) := TRANSFORM
  SELF.did := MAP(L.pty_DRIVERS_LICENSE = R.dl_number 
                  AND ut.NNEQ(L.drivers_license_st, R.orig_state) 
                  AND (REGEXFIND(REGEXREPLACE(' +', r.lname, ' ')
                                ,REGEXREPLACE(' +', l.fname + ' ' + l.inquiry_mname + ' ' + l.lname, ' ')) OR 
                       REGEXFIND(TRIM(r.lname,ALL)
                                ,REGEXREPLACE(' +', l.fname + ' ' + l.inquiry_mname + ' ' + l.lname, ' ')))
                  => R.did, L.did);
   SELF := L;
  END;
  appndDID := JOIN(natAcc_noDID, DEDUP(tbl_dls, dl_number, lname, ALL),
                   LEFT.pty_DRIVERS_LICENSE = RIGHT.dl_number AND
                   ut.NNEQ(LEFT.drivers_license_st,RIGHT.orig_state) AND
                   (REGEXFIND(REGEXREPLACE(' +',RIGHT.lname,' ')
                                          ,REGEXREPLACE(' +',LEFT.fname+' '+LEFT.inquiry_mname+' '+LEFT.lname,' ')) OR 
                              REGEXFIND(TRIM(RIGHT.lname,all)
                                        ,REGEXREPLACE(' +',LEFT.fname+' '+LEFT.inquiry_mname+' '+LEFT.lname,' '))),
                    getDID(LEFT,RIGHT), LEFT OUTER, HASH);

  appndDID getDID2(appndDID L, tbl_dls R) :=TRANSFORM
   SELF.did := MAP(L.did = 0 
                   AND L.pty_DRIVERS_LICENSE = R.dl_number 
                   AND ut.NNEQ(L.drivers_license_st,R.orig_state)
                   AND ut.NNEQ((STRING)L.mname[1],(STRING)R.mname[1])
                   AND (REGEXFIND(REGEXREPLACE(' +',r.fname,' ')
                                              ,REGEXREPLACE(' +',l.fname+' '+l.inquiry_mname+' '+l.lname,' ')) OR 
                                 REGEXFIND(TRIM(r.fname,all)
                                           ,REGEXREPLACE(' +',l.fname+' '+l.inquiry_mname+' '+l.lname,' ')))
                  => R.did,L.did);
  SELF := L;
 END;
    
 appndDID2 := JOIN(appndDID,DEDUP(tbl_dls,dl_number,fname,all),
                   LEFT.did = 0 AND 
                   LEFT.pty_DRIVERS_LICENSE = RIGHT.dl_number AND
                   ut.NNEQ(LEFT.drivers_license_st,RIGHT.orig_state) AND
                   ut.NNEQ((STRING)LEFT.mname[1],(STRING)RIGHT.mname[1]) AND
                   (Std.Str.Find(REGEXREPLACE(' +', LEFT.fname + ' ' + LEFT.inquiry_mname + ' ' + LEFT.lname, ' '),
										                     REGEXREPLACE(' +', RIGHT.fname, ' ') , 1) <> 0 OR 
                    Std.Str.Find(REGEXREPLACE(' +', LEFT.fname + ' ' + LEFT.inquiry_mname + ' ' + LEFT.lname, ' '),
										                     TRIM(RIGHT.fname,ALL), 1) <> 0
                   ),
    getDID2(LEFT,RIGHT),LEFT outer,HASH);

 natAcc_all := appndDID2 + natAcc_allothers : PERSIST('~thor_data400::persist::ntlcrash_did');						
 sfShuffle := SEQUENTIAL(
												 fileservices.startsuperfiletransaction(),
												 fileservices.addsuperfile('~thor_data400::base::ntlcrash_delete','~thor_data400::base::ntlcrash_grandfather',0,TRUE),
												 fileservices.RemoveOwnedSubFiles('~thor_data400::base::ntlcrash_delete',TRUE),
												 fileservices.clearsuperfile('~thor_data400::base::ntlcrash_grandfather'),
												 fileservices.addsuperfile('~thor_data400::base::ntlcrash_grandfather','~thor_data400::base::ntlcrash_father',0,TRUE),
												 fileservices.clearsuperfile('~thor_data400::base::ntlcrash_father'),
												 fileservices.addsuperfile('~thor_data400::base::ntlcrash_father','~thor_data400::base::ntlcrash',0,TRUE),
												 fileservices.clearsuperfile('~thor_data400::base::ntlcrash'),
												 fileservices.addsuperfile('~thor_data400::base::ntlcrash','~thor_data400::base::alpharetta::national_accidents_'+filedate),
												 fileservices.finishsuperfiletransaction()
												 );
	
	RETURN SEQUENTIAL(
	                  OUTPUT(DEDUP(natAcc_all, RECORD, ALL),,'~thor_data400::base::alpharetta::national_accidents_'+filedate,OVERWRITE,__COMPRESSED__)
	                  ,sfShuffle);
END;