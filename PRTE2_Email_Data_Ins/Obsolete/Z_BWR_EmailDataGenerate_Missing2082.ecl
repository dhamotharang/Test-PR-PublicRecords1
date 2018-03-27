//------------------------------------------------------------
//Generate Email Data from Nancy Missing MHDR
//------------------------------------------------------------

IMPORT PRTE2_X_DataCleanse, PRTE2_Email_Obsolete, Address, _control, ut;

foreign_alpha_dev := '~foreign::' + _control.IPAddress.adataland_dali + '::';

MHDR_nancy_missing_recs 		:= foreign_alpha_dev+'thor::base::customertest_cleanse::nancy_missing_recs_mhdrlayout';
mergedHeader	:= DATASET(MHDR_nancy_missing_recs, PRTE2_X_Ins_DataCleanse.Layouts.Layout_Merged_IHDR_BHDR, THOR);

PRTE2_Email_Obsolete._layouts.base xEmailData(mergedHeader L):= TRANSFORM 
  //generate email   
	domainIndicator := L.zip[5];
  SELF.append_domain_type   := MAP( domainIndicator IN ['0','3','4','5','7','8'] =>  'FREE',
	                                  domainIndicator IN ['1','2','6','9'] => 'ISP',
																		'');
																		
	SELF.append_domain_root   := MAP( domainIndicator = '0' => 'GMAIL',    
                                    domainIndicator = '1' => 'AOL',
                                    domainIndicator = '2' => 'COMCAST',
                                    domainIndicator = '3' => 'OUTLOOK',
                                    domainIndicator = '4' => 'MAIL',
                                    domainIndicator = '5' => 'YAHOO',
                                    domainIndicator = '6' => 'ATT',
                                    domainIndicator = '7' => 'HOTMAIL',
                                    domainIndicator = '8' => 'INBOX',
                                    domainIndicator = '9' => 'VERIZON',
																		'');
																		
	SELF.append_domain_ext    := MAP( domainIndicator IN ['0','1','3','4','5','7','8'] =>  '.WEB',
	                                  domainIndicator IN ['2','6','9'] => '.WEB',
																		'');
																		
	SELF.append_domain        := TRIM(SELF.append_domain_root) + TRIM(SELF.append_domain_ext);
	SELF.append_email_username:= TRIM(L.fname) + TRIM(L.lname) + IF(L.fb_dob = '00000000', L.zip[1..4], L.fb_dob[5..8]);
												 ;
	SELF.clean_email          := TRIM(SELF.append_email_username) + '@' +TRIM(SELF.append_domain);
	// SELF.clean_email          := IF(L.fb_dob = '00000000',
                                  // TRIM(SELF.append_email_username) + L.zip[1..4] + '@' + TRIM(SELF.append_domain),
                                  // TRIM(SELF.append_email_username) + L.fb_dob[5..8] + '@' + TRIM(SELF.append_domain));
												 

  //hard copied from 12 sample records. 
  SELF.append_is_tld_state        := 0;
  SELF.append_is_tld_generic      := 1;
  SELF.append_is_tld_country      := 0;
  SELF.append_is_valid_domain_ext := 1;
	
  SELF.email_src                  := 'M1';
  SELF.rec_src_all                := 16;
  SELF.email_src_all              := 16;
  SELF.email_src_num              := 1;
  SELF.num_email_per_did          := 2;
  SELF.num_did_per_email          := 1;

  //copy from the header 
  SELF.orig_first_name            := L.fname;
  SELF.orig_last_name             := L.lname;
  SELF.orig_address               := Address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name,
                                                                 L.suffix, L.postdir, L.unit_desig, L.sec_range); 
  SELF.orig_city                  := L.city_name;
  SELF.orig_state                 := L.st;
  SELF.orig_zip                   := L.zip;
  SELF.orig_zip4                  := L.zip4;

  SELF.orig_email                 := SELF.clean_email;
	
  SELF.orig_ip                    := '108.118.49.70';          
  SELF.orig_site                  := 'PUBDIRECT';       

  // SELF.did                       := L.did;
  SELF.did_score                 := 90;                  
  SELF.clean_name.title          := L.title;                 
  SELF.clean_name.fname          := L.fname;
  SELF.clean_name.mname          := L.mname;
  SELF.clean_name.lname          := L.lname;
  SELF.clean_name.name_suffix    := L.name_suffix;
  SELF.clean_name.name_score     := '99';
  SELF.clean_address.prim_range  := L.prim_range;
  SELF.clean_address.predir      := L.predir;
  SELF.clean_address.prim_name   := L.prim_name;
  SELF.clean_address.addr_suffix := L.suffix;
  SELF.clean_address.postdir     := L.postdir;
  SELF.clean_address.unit_desig  := L.unit_desig;
  SELF.clean_address.sec_range   := L.sec_range;
  SELF.clean_address.p_city_name := L.p_city_name;
  SELF.clean_address.v_city_name := L.v_city_name;
  SELF.clean_address.st          := L.st;
  SELF.clean_address.zip         := L.zip;
  SELF.clean_address.zip4        := L.zip4;
  SELF.clean_address.cart        := L.cart;
  SELF.clean_address.cr_sort_sz  := L.cr_sort_sz;
  SELF.clean_address.lot         := L.lot;
  SELF.clean_address.lot_order   := L.lot_order;
  SELF.clean_address.dbpc        := L.dbpc;
  SELF.clean_address.chk_digit   := L.chk_digit ;
  SELF.clean_address.rec_type    := L.rec_type;
  SELF.clean_address.county      := L.county;
  SELF.clean_address.geo_lat     := L.geo_lat;
  SELF.clean_address.geo_long    := L.geo_long;
  SELF.clean_address.msa         := L.msa;
  SELF.clean_address.geo_blk     := L.geo_blk;
  SELF.clean_address.geo_match   := L.geo_match;
  SELF.clean_address.err_stat    := L.err_stat;
  SELF.append_rawaid             := L.rawaid;              
  SELF.best_ssn                  := L.ssn;
  SELF.best_dob                  := (unsigned4) L.fb_dob;      
  SELF.date_first_seen           := (string8) L.dt_first_seen;      
  SELF.date_last_seen            := (string8) L.dt_last_seen;
  SELF.date_vendor_first_reported:= (string8) L.dt_vendor_first_reported; 
  SELF.date_vendor_last_reported := (string8) L.dt_nonglb_last_seen;
  SELF.current_rec   := 1; 
	
  SELF.email_rec_key := PRTE2_Email_Obsolete._functions.Email_rec_key(SELF.clean_email,
																						                 SELF.clean_address.prim_range,
																						                 SELF.clean_address.prim_name, 
																						                 SELF.clean_address.sec_range, 
																						                 SELF.clean_address.zip,
																					                	 SELF.Clean_Name.lname, 
																						                 SELF.Clean_Name.fname);
  SELF :=  L;
	SELF :=  [];
	
END;

emailData   := PROJECT(mergedHeader, xEmailData(left));
emailDS     := DEDUP(SORT(emailData,record), record);
emailResult := SORT(emailDS, did);
COUNT(emailResult);
// OUTPUT(emailResult);

OUTPUT(emailResult,,'~prte::ct::base::email_alpha_generated::email_data_addNancyMissing', OVERWRITE); //2082 

