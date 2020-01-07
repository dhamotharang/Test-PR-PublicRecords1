IMPORT ut,SALT35;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT35.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'EMAIL_FMT','SSN_FMT','WORDBAG','NAME','WORDSTR','CORPKEY_FMT','CITY','fld_contact','zip5','hasZip4','alpha_st','number','multiword','Noblanks','number09','number9','alpha02');
EXPORT FieldTypeNum(SALT35.StrType fn) := CASE(fn,'EMAIL_FMT' => 1,'SSN_FMT' => 2,'WORDBAG' => 3,'NAME' => 4,'WORDSTR' => 5,'CORPKEY_FMT' => 6,'CITY' => 7,'fld_contact' => 8,'zip5' => 9,'hasZip4' => 10,'alpha_st' => 11,'number' => 12,'multiword' => 13,'Noblanks' => 14,'number09' => 15,'number9' => 16,'alpha02' => 17,0);
 
EXPORT MakeFT_EMAIL_FMT(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_+%@.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_EMAIL_FMT(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_+%@.'))),~Email_Pattern(s),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 6 AND LENGTH(TRIM(s)) <= 60));
EXPORT InValidMessageFT_EMAIL_FMT(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_+%@.'),SALT35.HygieneErrors.CustomFail('Email_Pattern'),SALT35.HygieneErrors.NotLength('0,6..60'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_SSN_FMT(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'X0123456789\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_SSN_FMT(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'X0123456789\''))),~SSN_Pattern(s));
EXPORT InValidMessageFT_SSN_FMT(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('X0123456789\''),SALT35.HygieneErrors.CustomFail('SSN_Pattern'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_WORDBAG(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '); // Only allow valid symbols
  s2 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_WORDBAG(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_NAME(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NAME(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'))));
EXPORT InValidMessageFT_NAME(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_WORDSTR(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_WORDSTR(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))));
EXPORT InValidMessageFT_WORDSTR(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_CORPKEY_FMT(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_CORPKEY_FMT(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))),~CorpKey_Pattern(s),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4 AND LENGTH(TRIM(s)) <= 30));
EXPORT InValidMessageFT_CORPKEY_FMT(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT35.HygieneErrors.CustomFail('CorpKey_Pattern'),SALT35.HygieneErrors.NotLength('0,4..30'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_CITY(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '); // Only allow valid symbols
  s2 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_CITY(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 3));
EXPORT InValidMessageFT_CITY(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '),SALT35.HygieneErrors.NotLength('0,3..'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_fld_contact(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'TF'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_fld_contact(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'TF'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_fld_contact(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('TF'),SALT35.HygieneErrors.NotLength('0,1'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_zip5(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_zip5(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,5'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_hasZip4(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_hasZip4(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_hasZip4(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_alpha_st(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alpha_st(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_alpha_st(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.NotLength('0,2'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_number(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_multiword(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s2 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s1,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_multiword(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_multiword(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_Noblanks(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Noblanks(SALT35.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Noblanks(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotLength('1..'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_number09(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number09(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_number09(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,9'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_number9(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number9(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 9));
EXPORT InValidMessageFT_number9(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0..9'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_alpha02(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alpha02(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_alpha02(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.NotLength('0,2'),SALT35.HygieneErrors.Good);
 
EXPORT SALT35.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'source','source_record_id','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen_company_name','dt_last_seen_company_name','dt_first_seen_company_address','dt_last_seen_company_address','dt_first_seen_contact','dt_last_seen_contact','isContact','iscorp','cnp_hasnumber','cnp_name','cnp_number','cnp_btype','cnp_lowv','cnp_translated','cnp_classid','company_aceaid','corp_legal_name','dba_name','active_duns_number','hist_duns_number','active_enterprise_number','hist_enterprise_number','ebr_file_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','global_sid','record_sid','employee_count_org_raw','employee_count_org_derived','revenue_org_raw','revenue_org_derived','employee_count_local_raw','employee_count_local_derived','revenue_local_raw','revenue_local_derived','locid','source_docid','title','fname','mname','lname','name_suffix','name_score','company_name','company_name_type_raw','company_name_type_derived','company_rawaid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','company_bdid','company_address_type_raw','company_fein','best_fein_indicator','company_phone','phone_type','phone_score','company_org_structure_raw','company_incorporation_date','company_sic_code1','company_sic_code2','company_sic_code3','company_sic_code4','company_sic_code5','company_naics_code1','company_naics_code2','company_naics_code3','company_naics_code4','company_naics_code5','company_ticker','company_ticker_exchange','company_foreign_domestic','company_url','company_inc_state','company_charter_number','company_filing_date','company_status_date','company_foreign_date','event_filing_date','company_name_status_raw','company_status_raw','vl_id','current','contact_did','contact_type_raw','contact_job_title_raw','contact_ssn','contact_dob','contact_status_raw','contact_email','contact_email_username','contact_email_domain','contact_phone','from_hdr','company_department','company_address_type_derived','company_org_structure_derived','company_name_status_derived','company_status_derived','contact_type_derived','contact_job_title_derived','contact_status_derived');
EXPORT FieldNum(SALT35.StrType fn) := CASE(fn,'source' => 0,'source_record_id' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'dt_vendor_first_reported' => 4,'dt_vendor_last_reported' => 5,'dt_first_seen_company_name' => 6,'dt_last_seen_company_name' => 7,'dt_first_seen_company_address' => 8,'dt_last_seen_company_address' => 9,'dt_first_seen_contact' => 10,'dt_last_seen_contact' => 11,'isContact' => 12,'iscorp' => 13,'cnp_hasnumber' => 14,'cnp_name' => 15,'cnp_number' => 16,'cnp_btype' => 17,'cnp_lowv' => 18,'cnp_translated' => 19,'cnp_classid' => 20,'company_aceaid' => 21,'corp_legal_name' => 22,'dba_name' => 23,'active_duns_number' => 24,'hist_duns_number' => 25,'active_enterprise_number' => 26,'hist_enterprise_number' => 27,'ebr_file_number' => 28,'active_domestic_corp_key' => 29,'hist_domestic_corp_key' => 30,'foreign_corp_key' => 31,'unk_corp_key' => 32,'global_sid' => 33,'record_sid' => 34,'employee_count_org_raw' => 35,'employee_count_org_derived' => 36,'revenue_org_raw' => 37,'revenue_org_derived' => 38,'employee_count_local_raw' => 39,'employee_count_local_derived' => 40,'revenue_local_raw' => 41,'revenue_local_derived' => 42,'locid' => 43,'source_docid' => 44,'title' => 45,'fname' => 46,'mname' => 47,'lname' => 48,'name_suffix' => 49,'name_score' => 50,'company_name' => 51,'company_name_type_raw' => 52,'company_name_type_derived' => 53,'company_rawaid' => 54,'prim_range' => 55,'predir' => 56,'prim_name' => 57,'addr_suffix' => 58,'postdir' => 59,'unit_desig' => 60,'sec_range' => 61,'p_city_name' => 62,'v_city_name' => 63,'st' => 64,'zip' => 65,'zip4' => 66,'cart' => 67,'cr_sort_sz' => 68,'lot' => 69,'lot_order' => 70,'dbpc' => 71,'chk_digit' => 72,'rec_type' => 73,'fips_state' => 74,'fips_county' => 75,'geo_lat' => 76,'geo_long' => 77,'msa' => 78,'geo_blk' => 79,'geo_match' => 80,'err_stat' => 81,'company_bdid' => 82,'company_address_type_raw' => 83,'company_fein' => 84,'best_fein_indicator' => 85,'company_phone' => 86,'phone_type' => 87,'phone_score' => 88,'company_org_structure_raw' => 89,'company_incorporation_date' => 90,'company_sic_code1' => 91,'company_sic_code2' => 92,'company_sic_code3' => 93,'company_sic_code4' => 94,'company_sic_code5' => 95,'company_naics_code1' => 96,'company_naics_code2' => 97,'company_naics_code3' => 98,'company_naics_code4' => 99,'company_naics_code5' => 100,'company_ticker' => 101,'company_ticker_exchange' => 102,'company_foreign_domestic' => 103,'company_url' => 104,'company_inc_state' => 105,'company_charter_number' => 106,'company_filing_date' => 107,'company_status_date' => 108,'company_foreign_date' => 109,'event_filing_date' => 110,'company_name_status_raw' => 111,'company_status_raw' => 112,'vl_id' => 113,'current' => 114,'contact_did' => 115,'contact_type_raw' => 116,'contact_job_title_raw' => 117,'contact_ssn' => 118,'contact_dob' => 119,'contact_status_raw' => 120,'contact_email' => 121,'contact_email_username' => 122,'contact_email_domain' => 123,'contact_phone' => 124,'from_hdr' => 125,'company_department' => 126,'company_address_type_derived' => 127,'company_org_structure_derived' => 128,'company_name_status_derived' => 129,'company_status_derived' => 130,'contact_type_derived' => 131,'contact_job_title_derived' => 132,'contact_status_derived' => 133,0);
 
//Individual field level validation
 
EXPORT Make_source(SALT35.StrType s0) := s0;
EXPORT InValid_source(SALT35.StrType s) := 0;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
 
EXPORT Make_source_record_id(SALT35.StrType s0) := s0;
EXPORT InValid_source_record_id(SALT35.StrType s) := 0;
EXPORT InValidMessage_source_record_id(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT35.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT35.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_first_reported(SALT35.StrType s0) := s0;
EXPORT InValid_dt_vendor_first_reported(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_last_reported(SALT35.StrType s0) := s0;
EXPORT InValid_dt_vendor_last_reported(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen_company_name(SALT35.StrType s0) := s0;
EXPORT InValid_dt_first_seen_company_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen_company_name(SALT35.StrType s0) := s0;
EXPORT InValid_dt_last_seen_company_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen_company_address(SALT35.StrType s0) := s0;
EXPORT InValid_dt_first_seen_company_address(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen_company_address(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen_company_address(SALT35.StrType s0) := s0;
EXPORT InValid_dt_last_seen_company_address(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen_company_address(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen_contact(SALT35.StrType s0) := s0;
EXPORT InValid_dt_first_seen_contact(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen_contact(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen_contact(SALT35.StrType s0) := s0;
EXPORT InValid_dt_last_seen_contact(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen_contact(UNSIGNED1 wh) := '';
 
EXPORT Make_isContact(SALT35.StrType s0) := MakeFT_fld_contact(s0);
EXPORT InValid_isContact(SALT35.StrType s) := InValidFT_fld_contact(s);
EXPORT InValidMessage_isContact(UNSIGNED1 wh) := InValidMessageFT_fld_contact(wh);
 
EXPORT Make_iscorp(SALT35.StrType s0) := s0;
EXPORT InValid_iscorp(SALT35.StrType s) := 0;
EXPORT InValidMessage_iscorp(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_hasnumber(SALT35.StrType s0) := s0;
EXPORT InValid_cnp_hasnumber(SALT35.StrType s) := 0;
EXPORT InValidMessage_cnp_hasnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_name(SALT35.StrType s0) := s0;
EXPORT InValid_cnp_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_number(SALT35.StrType s0) := s0;
EXPORT InValid_cnp_number(SALT35.StrType s) := 0;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_btype(SALT35.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT35.StrType s) := 0;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_lowv(SALT35.StrType s0) := s0;
EXPORT InValid_cnp_lowv(SALT35.StrType s) := 0;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_translated(SALT35.StrType s0) := s0;
EXPORT InValid_cnp_translated(SALT35.StrType s) := 0;
EXPORT InValidMessage_cnp_translated(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_classid(SALT35.StrType s0) := s0;
EXPORT InValid_cnp_classid(SALT35.StrType s) := 0;
EXPORT InValidMessage_cnp_classid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_aceaid(SALT35.StrType s0) := s0;
EXPORT InValid_company_aceaid(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_aceaid(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_legal_name(SALT35.StrType s0) := s0;
EXPORT InValid_corp_legal_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := '';
 
EXPORT Make_dba_name(SALT35.StrType s0) := s0;
EXPORT InValid_dba_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_dba_name(UNSIGNED1 wh) := '';
 
EXPORT Make_active_duns_number(SALT35.StrType s0) := MakeFT_number09(s0);
EXPORT InValid_active_duns_number(SALT35.StrType s) := InValidFT_number09(s);
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := InValidMessageFT_number09(wh);
 
EXPORT Make_hist_duns_number(SALT35.StrType s0) := s0;
EXPORT InValid_hist_duns_number(SALT35.StrType s) := 0;
EXPORT InValidMessage_hist_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_enterprise_number(SALT35.StrType s0) := MakeFT_number9(s0);
EXPORT InValid_active_enterprise_number(SALT35.StrType s) := InValidFT_number9(s);
EXPORT InValidMessage_active_enterprise_number(UNSIGNED1 wh) := InValidMessageFT_number9(wh);
 
EXPORT Make_hist_enterprise_number(SALT35.StrType s0) := s0;
EXPORT InValid_hist_enterprise_number(SALT35.StrType s) := 0;
EXPORT InValidMessage_hist_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_ebr_file_number(SALT35.StrType s0) := MakeFT_number09(s0);
EXPORT InValid_ebr_file_number(SALT35.StrType s) := InValidFT_number09(s);
EXPORT InValidMessage_ebr_file_number(UNSIGNED1 wh) := InValidMessageFT_number09(wh);
 
EXPORT Make_active_domestic_corp_key(SALT35.StrType s0) := MakeFT_CORPKEY_FMT(s0);
EXPORT InValid_active_domestic_corp_key(SALT35.StrType s) := InValidFT_CORPKEY_FMT(s);
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := InValidMessageFT_CORPKEY_FMT(wh);
 
EXPORT Make_hist_domestic_corp_key(SALT35.StrType s0) := s0;
EXPORT InValid_hist_domestic_corp_key(SALT35.StrType s) := 0;
EXPORT InValidMessage_hist_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_corp_key(SALT35.StrType s0) := MakeFT_CORPKEY_FMT(s0);
EXPORT InValid_foreign_corp_key(SALT35.StrType s) := InValidFT_CORPKEY_FMT(s);
EXPORT InValidMessage_foreign_corp_key(UNSIGNED1 wh) := InValidMessageFT_CORPKEY_FMT(wh);
 
EXPORT Make_unk_corp_key(SALT35.StrType s0) := s0;
EXPORT InValid_unk_corp_key(SALT35.StrType s) := 0;
EXPORT InValidMessage_unk_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_global_sid(SALT35.StrType s0) := s0;
EXPORT InValid_global_sid(SALT35.StrType s) := 0;
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_record_sid(SALT35.StrType s0) := s0;
EXPORT InValid_record_sid(SALT35.StrType s) := 0;
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := '';
 
EXPORT Make_employee_count_org_raw(SALT35.StrType s0) := s0;
EXPORT InValid_employee_count_org_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_employee_count_org_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_employee_count_org_derived(SALT35.StrType s0) := s0;
EXPORT InValid_employee_count_org_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_employee_count_org_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_revenue_org_raw(SALT35.StrType s0) := s0;
EXPORT InValid_revenue_org_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_revenue_org_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_revenue_org_derived(SALT35.StrType s0) := s0;
EXPORT InValid_revenue_org_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_revenue_org_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_employee_count_local_raw(SALT35.StrType s0) := s0;
EXPORT InValid_employee_count_local_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_employee_count_local_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_employee_count_local_derived(SALT35.StrType s0) := s0;
EXPORT InValid_employee_count_local_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_employee_count_local_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_revenue_local_raw(SALT35.StrType s0) := s0;
EXPORT InValid_revenue_local_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_revenue_local_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_revenue_local_derived(SALT35.StrType s0) := s0;
EXPORT InValid_revenue_local_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_revenue_local_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_locid(SALT35.StrType s0) := s0;
EXPORT InValid_locid(SALT35.StrType s) := 0;
EXPORT InValidMessage_locid(UNSIGNED1 wh) := '';
 
EXPORT Make_source_docid(SALT35.StrType s0) := s0;
EXPORT InValid_source_docid(SALT35.StrType s) := 0;
EXPORT InValidMessage_source_docid(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT35.StrType s0) := s0;
EXPORT InValid_title(SALT35.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT35.StrType s0) := MakeFT_NAME(s0);
EXPORT InValid_fname(SALT35.StrType s) := InValidFT_NAME(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_NAME(wh);
 
EXPORT Make_mname(SALT35.StrType s0) := MakeFT_NAME(s0);
EXPORT InValid_mname(SALT35.StrType s) := InValidFT_NAME(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_NAME(wh);
 
EXPORT Make_lname(SALT35.StrType s0) := MakeFT_NAME(s0);
EXPORT InValid_lname(SALT35.StrType s) := InValidFT_NAME(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_NAME(wh);
 
EXPORT Make_name_suffix(SALT35.StrType s0) := MakeFT_WORDSTR(s0);
EXPORT InValid_name_suffix(SALT35.StrType s) := InValidFT_WORDSTR(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_WORDSTR(wh);
 
EXPORT Make_name_score(SALT35.StrType s0) := s0;
EXPORT InValid_name_score(SALT35.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT35.StrType s0) := MakeFT_Noblanks(s0);
EXPORT InValid_company_name(SALT35.StrType s) := InValidFT_Noblanks(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_Noblanks(wh);
 
EXPORT Make_company_name_type_raw(SALT35.StrType s0) := s0;
EXPORT InValid_company_name_type_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_name_type_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_type_derived(SALT35.StrType s0) := s0;
EXPORT InValid_company_name_type_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_name_type_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_company_rawaid(SALT35.StrType s0) := s0;
EXPORT InValid_company_rawaid(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_rawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT35.StrType s0) := s0;
EXPORT InValid_prim_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT35.StrType s0) := s0;
EXPORT InValid_predir(SALT35.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT35.StrType s0) := s0;
EXPORT InValid_prim_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT35.StrType s0) := s0;
EXPORT InValid_postdir(SALT35.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT35.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT35.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT35.StrType s0) := s0;
EXPORT InValid_sec_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT35.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT35.StrType s0) := MakeFT_CITY(s0);
EXPORT InValid_v_city_name(SALT35.StrType s) := InValidFT_CITY(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_CITY(wh);
 
EXPORT Make_st(SALT35.StrType s0) := MakeFT_alpha_st(s0);
EXPORT InValid_st(SALT35.StrType s) := InValidFT_alpha_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha_st(wh);
 
EXPORT Make_zip(SALT35.StrType s0) := MakeFT_zip5(s0);
EXPORT InValid_zip(SALT35.StrType s) := InValidFT_zip5(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip5(wh);
 
EXPORT Make_zip4(SALT35.StrType s0) := MakeFT_hasZip4(s0);
EXPORT InValid_zip4(SALT35.StrType s) := InValidFT_hasZip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_hasZip4(wh);
 
EXPORT Make_cart(SALT35.StrType s0) := s0;
EXPORT InValid_cart(SALT35.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT35.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT35.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT35.StrType s0) := s0;
EXPORT InValid_lot(SALT35.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT35.StrType s0) := s0;
EXPORT InValid_lot_order(SALT35.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dbpc(SALT35.StrType s0) := s0;
EXPORT InValid_dbpc(SALT35.StrType s) := 0;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT35.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT35.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT35.StrType s0) := s0;
EXPORT InValid_rec_type(SALT35.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_state(SALT35.StrType s0) := s0;
EXPORT InValid_fips_state(SALT35.StrType s) := 0;
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_county(SALT35.StrType s0) := s0;
EXPORT InValid_fips_county(SALT35.StrType s) := 0;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT35.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT35.StrType s0) := s0;
EXPORT InValid_geo_long(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT35.StrType s0) := s0;
EXPORT InValid_msa(SALT35.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT35.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT35.StrType s0) := s0;
EXPORT InValid_geo_match(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT35.StrType s0) := s0;
EXPORT InValid_err_stat(SALT35.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_company_bdid(SALT35.StrType s0) := s0;
EXPORT InValid_company_bdid(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_address_type_raw(SALT35.StrType s0) := s0;
EXPORT InValid_company_address_type_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_address_type_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_company_fein(SALT35.StrType s0) := MakeFT_number(s0);
EXPORT InValid_company_fein(SALT35.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_best_fein_indicator(SALT35.StrType s0) := s0;
EXPORT InValid_best_fein_indicator(SALT35.StrType s) := 0;
EXPORT InValidMessage_best_fein_indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_company_phone(SALT35.StrType s0) := MakeFT_number(s0);
EXPORT InValid_company_phone(SALT35.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_phone_type(SALT35.StrType s0) := s0;
EXPORT InValid_phone_type(SALT35.StrType s) := 0;
EXPORT InValidMessage_phone_type(UNSIGNED1 wh) := '';
 
EXPORT Make_phone_score(SALT35.StrType s0) := s0;
EXPORT InValid_phone_score(SALT35.StrType s) := 0;
EXPORT InValidMessage_phone_score(UNSIGNED1 wh) := '';
 
EXPORT Make_company_org_structure_raw(SALT35.StrType s0) := s0;
EXPORT InValid_company_org_structure_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_org_structure_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_company_incorporation_date(SALT35.StrType s0) := s0;
EXPORT InValid_company_incorporation_date(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_incorporation_date(UNSIGNED1 wh) := '';
 
EXPORT Make_company_sic_code1(SALT35.StrType s0) := s0;
EXPORT InValid_company_sic_code1(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_sic_code1(UNSIGNED1 wh) := '';
 
EXPORT Make_company_sic_code2(SALT35.StrType s0) := s0;
EXPORT InValid_company_sic_code2(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_sic_code2(UNSIGNED1 wh) := '';
 
EXPORT Make_company_sic_code3(SALT35.StrType s0) := s0;
EXPORT InValid_company_sic_code3(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_sic_code3(UNSIGNED1 wh) := '';
 
EXPORT Make_company_sic_code4(SALT35.StrType s0) := s0;
EXPORT InValid_company_sic_code4(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_sic_code4(UNSIGNED1 wh) := '';
 
EXPORT Make_company_sic_code5(SALT35.StrType s0) := s0;
EXPORT InValid_company_sic_code5(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_sic_code5(UNSIGNED1 wh) := '';
 
EXPORT Make_company_naics_code1(SALT35.StrType s0) := s0;
EXPORT InValid_company_naics_code1(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_naics_code1(UNSIGNED1 wh) := '';
 
EXPORT Make_company_naics_code2(SALT35.StrType s0) := s0;
EXPORT InValid_company_naics_code2(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_naics_code2(UNSIGNED1 wh) := '';
 
EXPORT Make_company_naics_code3(SALT35.StrType s0) := s0;
EXPORT InValid_company_naics_code3(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_naics_code3(UNSIGNED1 wh) := '';
 
EXPORT Make_company_naics_code4(SALT35.StrType s0) := s0;
EXPORT InValid_company_naics_code4(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_naics_code4(UNSIGNED1 wh) := '';
 
EXPORT Make_company_naics_code5(SALT35.StrType s0) := s0;
EXPORT InValid_company_naics_code5(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_naics_code5(UNSIGNED1 wh) := '';
 
EXPORT Make_company_ticker(SALT35.StrType s0) := s0;
EXPORT InValid_company_ticker(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_ticker(UNSIGNED1 wh) := '';
 
EXPORT Make_company_ticker_exchange(SALT35.StrType s0) := s0;
EXPORT InValid_company_ticker_exchange(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_ticker_exchange(UNSIGNED1 wh) := '';
 
EXPORT Make_company_foreign_domestic(SALT35.StrType s0) := s0;
EXPORT InValid_company_foreign_domestic(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_foreign_domestic(UNSIGNED1 wh) := '';
 
EXPORT Make_company_url(SALT35.StrType s0) := s0;
EXPORT InValid_company_url(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_url(UNSIGNED1 wh) := '';
 
EXPORT Make_company_inc_state(SALT35.StrType s0) := MakeFT_alpha02(s0);
EXPORT InValid_company_inc_state(SALT35.StrType s) := InValidFT_alpha02(s);
EXPORT InValidMessage_company_inc_state(UNSIGNED1 wh) := InValidMessageFT_alpha02(wh);
 
EXPORT Make_company_charter_number(SALT35.StrType s0) := MakeFT_NAME(s0);
EXPORT InValid_company_charter_number(SALT35.StrType s) := InValidFT_NAME(s);
EXPORT InValidMessage_company_charter_number(UNSIGNED1 wh) := InValidMessageFT_NAME(wh);
 
EXPORT Make_company_filing_date(SALT35.StrType s0) := s0;
EXPORT InValid_company_filing_date(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_filing_date(UNSIGNED1 wh) := '';
 
EXPORT Make_company_status_date(SALT35.StrType s0) := s0;
EXPORT InValid_company_status_date(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_status_date(UNSIGNED1 wh) := '';
 
EXPORT Make_company_foreign_date(SALT35.StrType s0) := s0;
EXPORT InValid_company_foreign_date(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_foreign_date(UNSIGNED1 wh) := '';
 
EXPORT Make_event_filing_date(SALT35.StrType s0) := s0;
EXPORT InValid_event_filing_date(SALT35.StrType s) := 0;
EXPORT InValidMessage_event_filing_date(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_status_raw(SALT35.StrType s0) := s0;
EXPORT InValid_company_name_status_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_name_status_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_company_status_raw(SALT35.StrType s0) := s0;
EXPORT InValid_company_status_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_status_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_vl_id(SALT35.StrType s0) := s0;
EXPORT InValid_vl_id(SALT35.StrType s) := 0;
EXPORT InValidMessage_vl_id(UNSIGNED1 wh) := '';
 
EXPORT Make_current(SALT35.StrType s0) := s0;
EXPORT InValid_current(SALT35.StrType s) := 0;
EXPORT InValidMessage_current(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_did(SALT35.StrType s0) := s0;
EXPORT InValid_contact_did(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_did(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_type_raw(SALT35.StrType s0) := s0;
EXPORT InValid_contact_type_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_type_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_job_title_raw(SALT35.StrType s0) := s0;
EXPORT InValid_contact_job_title_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_job_title_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_ssn(SALT35.StrType s0) := MakeFT_SSN_FMT(s0);
EXPORT InValid_contact_ssn(SALT35.StrType s) := InValidFT_SSN_FMT(s);
EXPORT InValidMessage_contact_ssn(UNSIGNED1 wh) := InValidMessageFT_SSN_FMT(wh);
 
EXPORT Make_contact_dob(SALT35.StrType s0) := s0;
EXPORT InValid_contact_dob(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_status_raw(SALT35.StrType s0) := s0;
EXPORT InValid_contact_status_raw(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_status_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_email(SALT35.StrType s0) := MakeFT_EMAIL_FMT(s0);
EXPORT InValid_contact_email(SALT35.StrType s) := InValidFT_EMAIL_FMT(s);
EXPORT InValidMessage_contact_email(UNSIGNED1 wh) := InValidMessageFT_EMAIL_FMT(wh);
 
EXPORT Make_contact_email_username(SALT35.StrType s0) := s0;
EXPORT InValid_contact_email_username(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_email_username(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_email_domain(SALT35.StrType s0) := s0;
EXPORT InValid_contact_email_domain(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_email_domain(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_phone(SALT35.StrType s0) := s0;
EXPORT InValid_contact_phone(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_from_hdr(SALT35.StrType s0) := s0;
EXPORT InValid_from_hdr(SALT35.StrType s) := 0;
EXPORT InValidMessage_from_hdr(UNSIGNED1 wh) := '';
 
EXPORT Make_company_department(SALT35.StrType s0) := s0;
EXPORT InValid_company_department(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_department(UNSIGNED1 wh) := '';
 
EXPORT Make_company_address_type_derived(SALT35.StrType s0) := s0;
EXPORT InValid_company_address_type_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_address_type_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_company_org_structure_derived(SALT35.StrType s0) := s0;
EXPORT InValid_company_org_structure_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_org_structure_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_status_derived(SALT35.StrType s0) := s0;
EXPORT InValid_company_name_status_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_name_status_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_company_status_derived(SALT35.StrType s0) := s0;
EXPORT InValid_company_status_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_status_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_type_derived(SALT35.StrType s0) := s0;
EXPORT InValid_contact_type_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_type_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_job_title_derived(SALT35.StrType s0) := s0;
EXPORT InValid_contact_job_title_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_job_title_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_status_derived(SALT35.StrType s0) := s0;
EXPORT InValid_contact_status_derived(SALT35.StrType s) := 0;
EXPORT InValidMessage_contact_status_derived(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT35,BIPV2_Ingest;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_source;
    BOOLEAN Diff_source_record_id;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_first_seen_company_name;
    BOOLEAN Diff_dt_last_seen_company_name;
    BOOLEAN Diff_dt_first_seen_company_address;
    BOOLEAN Diff_dt_last_seen_company_address;
    BOOLEAN Diff_dt_first_seen_contact;
    BOOLEAN Diff_dt_last_seen_contact;
    BOOLEAN Diff_isContact;
    BOOLEAN Diff_iscorp;
    BOOLEAN Diff_cnp_hasnumber;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_cnp_number;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_cnp_translated;
    BOOLEAN Diff_cnp_classid;
    BOOLEAN Diff_company_aceaid;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_dba_name;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_hist_duns_number;
    BOOLEAN Diff_active_enterprise_number;
    BOOLEAN Diff_hist_enterprise_number;
    BOOLEAN Diff_ebr_file_number;
    BOOLEAN Diff_active_domestic_corp_key;
    BOOLEAN Diff_hist_domestic_corp_key;
    BOOLEAN Diff_foreign_corp_key;
    BOOLEAN Diff_unk_corp_key;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_record_sid;
    BOOLEAN Diff_employee_count_org_raw;
    BOOLEAN Diff_employee_count_org_derived;
    BOOLEAN Diff_revenue_org_raw;
    BOOLEAN Diff_revenue_org_derived;
    BOOLEAN Diff_employee_count_local_raw;
    BOOLEAN Diff_employee_count_local_derived;
    BOOLEAN Diff_revenue_local_raw;
    BOOLEAN Diff_revenue_local_derived;
    BOOLEAN Diff_locid;
    BOOLEAN Diff_source_docid;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_company_name_type_raw;
    BOOLEAN Diff_company_name_type_derived;
    BOOLEAN Diff_company_rawaid;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_company_bdid;
    BOOLEAN Diff_company_address_type_raw;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_best_fein_indicator;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_phone_type;
    BOOLEAN Diff_phone_score;
    BOOLEAN Diff_company_org_structure_raw;
    BOOLEAN Diff_company_incorporation_date;
    BOOLEAN Diff_company_sic_code1;
    BOOLEAN Diff_company_sic_code2;
    BOOLEAN Diff_company_sic_code3;
    BOOLEAN Diff_company_sic_code4;
    BOOLEAN Diff_company_sic_code5;
    BOOLEAN Diff_company_naics_code1;
    BOOLEAN Diff_company_naics_code2;
    BOOLEAN Diff_company_naics_code3;
    BOOLEAN Diff_company_naics_code4;
    BOOLEAN Diff_company_naics_code5;
    BOOLEAN Diff_company_ticker;
    BOOLEAN Diff_company_ticker_exchange;
    BOOLEAN Diff_company_foreign_domestic;
    BOOLEAN Diff_company_url;
    BOOLEAN Diff_company_inc_state;
    BOOLEAN Diff_company_charter_number;
    BOOLEAN Diff_company_filing_date;
    BOOLEAN Diff_company_status_date;
    BOOLEAN Diff_company_foreign_date;
    BOOLEAN Diff_event_filing_date;
    BOOLEAN Diff_company_name_status_raw;
    BOOLEAN Diff_company_status_raw;
    BOOLEAN Diff_vl_id;
    BOOLEAN Diff_current;
    BOOLEAN Diff_contact_did;
    BOOLEAN Diff_contact_type_raw;
    BOOLEAN Diff_contact_job_title_raw;
    BOOLEAN Diff_contact_ssn;
    BOOLEAN Diff_contact_dob;
    BOOLEAN Diff_contact_status_raw;
    BOOLEAN Diff_contact_email;
    BOOLEAN Diff_contact_email_username;
    BOOLEAN Diff_contact_email_domain;
    BOOLEAN Diff_contact_phone;
    BOOLEAN Diff_from_hdr;
    BOOLEAN Diff_company_department;
    BOOLEAN Diff_company_address_type_derived;
    BOOLEAN Diff_company_org_structure_derived;
    BOOLEAN Diff_company_name_status_derived;
    BOOLEAN Diff_company_status_derived;
    BOOLEAN Diff_contact_type_derived;
    BOOLEAN Diff_contact_job_title_derived;
    BOOLEAN Diff_contact_status_derived;
    SALT35.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT35.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_source_record_id := le.source_record_id <> ri.source_record_id;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_first_seen_company_name := le.dt_first_seen_company_name <> ri.dt_first_seen_company_name;
    SELF.Diff_dt_last_seen_company_name := le.dt_last_seen_company_name <> ri.dt_last_seen_company_name;
    SELF.Diff_dt_first_seen_company_address := le.dt_first_seen_company_address <> ri.dt_first_seen_company_address;
    SELF.Diff_dt_last_seen_company_address := le.dt_last_seen_company_address <> ri.dt_last_seen_company_address;
    SELF.Diff_dt_first_seen_contact := le.dt_first_seen_contact <> ri.dt_first_seen_contact;
    SELF.Diff_dt_last_seen_contact := le.dt_last_seen_contact <> ri.dt_last_seen_contact;
    SELF.Diff_isContact := le.isContact <> ri.isContact;
    SELF.Diff_iscorp := le.iscorp <> ri.iscorp;
    SELF.Diff_cnp_hasnumber := le.cnp_hasnumber <> ri.cnp_hasnumber;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_cnp_translated := le.cnp_translated <> ri.cnp_translated;
    SELF.Diff_cnp_classid := le.cnp_classid <> ri.cnp_classid;
    SELF.Diff_company_aceaid := le.company_aceaid <> ri.company_aceaid;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_dba_name := le.dba_name <> ri.dba_name;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_hist_duns_number := le.hist_duns_number <> ri.hist_duns_number;
    SELF.Diff_active_enterprise_number := le.active_enterprise_number <> ri.active_enterprise_number;
    SELF.Diff_hist_enterprise_number := le.hist_enterprise_number <> ri.hist_enterprise_number;
    SELF.Diff_ebr_file_number := le.ebr_file_number <> ri.ebr_file_number;
    SELF.Diff_active_domestic_corp_key := le.active_domestic_corp_key <> ri.active_domestic_corp_key;
    SELF.Diff_hist_domestic_corp_key := le.hist_domestic_corp_key <> ri.hist_domestic_corp_key;
    SELF.Diff_foreign_corp_key := le.foreign_corp_key <> ri.foreign_corp_key;
    SELF.Diff_unk_corp_key := le.unk_corp_key <> ri.unk_corp_key;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Diff_employee_count_org_raw := le.employee_count_org_raw <> ri.employee_count_org_raw;
    SELF.Diff_employee_count_org_derived := le.employee_count_org_derived <> ri.employee_count_org_derived;
    SELF.Diff_revenue_org_raw := le.revenue_org_raw <> ri.revenue_org_raw;
    SELF.Diff_revenue_org_derived := le.revenue_org_derived <> ri.revenue_org_derived;
    SELF.Diff_employee_count_local_raw := le.employee_count_local_raw <> ri.employee_count_local_raw;
    SELF.Diff_employee_count_local_derived := le.employee_count_local_derived <> ri.employee_count_local_derived;
    SELF.Diff_revenue_local_raw := le.revenue_local_raw <> ri.revenue_local_raw;
    SELF.Diff_revenue_local_derived := le.revenue_local_derived <> ri.revenue_local_derived;
    SELF.Diff_locid := le.locid <> ri.locid;
    SELF.Diff_source_docid := le.source_docid <> ri.source_docid;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_company_name_type_raw := le.company_name_type_raw <> ri.company_name_type_raw;
    SELF.Diff_company_name_type_derived := le.company_name_type_derived <> ri.company_name_type_derived;
    SELF.Diff_company_rawaid := le.company_rawaid <> ri.company_rawaid;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_company_bdid := le.company_bdid <> ri.company_bdid;
    SELF.Diff_company_address_type_raw := le.company_address_type_raw <> ri.company_address_type_raw;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_best_fein_indicator := le.best_fein_indicator <> ri.best_fein_indicator;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_phone_type := le.phone_type <> ri.phone_type;
    SELF.Diff_phone_score := le.phone_score <> ri.phone_score;
    SELF.Diff_company_org_structure_raw := le.company_org_structure_raw <> ri.company_org_structure_raw;
    SELF.Diff_company_incorporation_date := le.company_incorporation_date <> ri.company_incorporation_date;
    SELF.Diff_company_sic_code1 := le.company_sic_code1 <> ri.company_sic_code1;
    SELF.Diff_company_sic_code2 := le.company_sic_code2 <> ri.company_sic_code2;
    SELF.Diff_company_sic_code3 := le.company_sic_code3 <> ri.company_sic_code3;
    SELF.Diff_company_sic_code4 := le.company_sic_code4 <> ri.company_sic_code4;
    SELF.Diff_company_sic_code5 := le.company_sic_code5 <> ri.company_sic_code5;
    SELF.Diff_company_naics_code1 := le.company_naics_code1 <> ri.company_naics_code1;
    SELF.Diff_company_naics_code2 := le.company_naics_code2 <> ri.company_naics_code2;
    SELF.Diff_company_naics_code3 := le.company_naics_code3 <> ri.company_naics_code3;
    SELF.Diff_company_naics_code4 := le.company_naics_code4 <> ri.company_naics_code4;
    SELF.Diff_company_naics_code5 := le.company_naics_code5 <> ri.company_naics_code5;
    SELF.Diff_company_ticker := le.company_ticker <> ri.company_ticker;
    SELF.Diff_company_ticker_exchange := le.company_ticker_exchange <> ri.company_ticker_exchange;
    SELF.Diff_company_foreign_domestic := le.company_foreign_domestic <> ri.company_foreign_domestic;
    SELF.Diff_company_url := le.company_url <> ri.company_url;
    SELF.Diff_company_inc_state := le.company_inc_state <> ri.company_inc_state;
    SELF.Diff_company_charter_number := le.company_charter_number <> ri.company_charter_number;
    SELF.Diff_company_filing_date := le.company_filing_date <> ri.company_filing_date;
    SELF.Diff_company_status_date := le.company_status_date <> ri.company_status_date;
    SELF.Diff_company_foreign_date := le.company_foreign_date <> ri.company_foreign_date;
    SELF.Diff_event_filing_date := le.event_filing_date <> ri.event_filing_date;
    SELF.Diff_company_name_status_raw := le.company_name_status_raw <> ri.company_name_status_raw;
    SELF.Diff_company_status_raw := le.company_status_raw <> ri.company_status_raw;
    SELF.Diff_vl_id := le.vl_id <> ri.vl_id;
    SELF.Diff_current := le.current <> ri.current;
    SELF.Diff_contact_did := le.contact_did <> ri.contact_did;
    SELF.Diff_contact_type_raw := le.contact_type_raw <> ri.contact_type_raw;
    SELF.Diff_contact_job_title_raw := le.contact_job_title_raw <> ri.contact_job_title_raw;
    SELF.Diff_contact_ssn := le.contact_ssn <> ri.contact_ssn;
    SELF.Diff_contact_dob := le.contact_dob <> ri.contact_dob;
    SELF.Diff_contact_status_raw := le.contact_status_raw <> ri.contact_status_raw;
    SELF.Diff_contact_email := le.contact_email <> ri.contact_email;
    SELF.Diff_contact_email_username := le.contact_email_username <> ri.contact_email_username;
    SELF.Diff_contact_email_domain := le.contact_email_domain <> ri.contact_email_domain;
    SELF.Diff_contact_phone := le.contact_phone <> ri.contact_phone;
    SELF.Diff_from_hdr := le.from_hdr <> ri.from_hdr;
    SELF.Diff_company_department := le.company_department <> ri.company_department;
    SELF.Diff_company_address_type_derived := le.company_address_type_derived <> ri.company_address_type_derived;
    SELF.Diff_company_org_structure_derived := le.company_org_structure_derived <> ri.company_org_structure_derived;
    SELF.Diff_company_name_status_derived := le.company_name_status_derived <> ri.company_name_status_derived;
    SELF.Diff_company_status_derived := le.company_status_derived <> ri.company_status_derived;
    SELF.Diff_contact_type_derived := le.contact_type_derived <> ri.contact_type_derived;
    SELF.Diff_contact_job_title_derived := le.contact_job_title_derived <> ri.contact_job_title_derived;
    SELF.Diff_contact_status_derived := le.contact_status_derived <> ri.contact_status_derived;
    SELF.Val := (SALT35.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_source_record_id,1,0)+ IF( SELF.Diff_isContact,1,0)+ IF( SELF.Diff_iscorp,1,0)+ IF( SELF.Diff_cnp_hasnumber,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_translated,1,0)+ IF( SELF.Diff_cnp_classid,1,0)+ IF( SELF.Diff_company_aceaid,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_dba_name,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_hist_duns_number,1,0)+ IF( SELF.Diff_active_enterprise_number,1,0)+ IF( SELF.Diff_hist_enterprise_number,1,0)+ IF( SELF.Diff_ebr_file_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_hist_domestic_corp_key,1,0)+ IF( SELF.Diff_foreign_corp_key,1,0)+ IF( SELF.Diff_unk_corp_key,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_record_sid,1,0)+ IF( SELF.Diff_employee_count_org_raw,1,0)+ IF( SELF.Diff_employee_count_org_derived,1,0)+ IF( SELF.Diff_revenue_org_raw,1,0)+ IF( SELF.Diff_revenue_org_derived,1,0)+ IF( SELF.Diff_employee_count_local_raw,1,0)+ IF( SELF.Diff_employee_count_local_derived,1,0)+ IF( SELF.Diff_revenue_local_raw,1,0)+ IF( SELF.Diff_revenue_local_derived,1,0)+ IF( SELF.Diff_locid,1,0)+ IF( SELF.Diff_source_docid,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_company_name_type_raw,1,0)+ IF( SELF.Diff_company_name_type_derived,1,0)+ IF( SELF.Diff_company_rawaid,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_company_bdid,1,0)+ IF( SELF.Diff_company_address_type_raw,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_best_fein_indicator,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_phone_type,1,0)+ IF( SELF.Diff_phone_score,1,0)+ IF( SELF.Diff_company_org_structure_raw,1,0)+ IF( SELF.Diff_company_incorporation_date,1,0)+ IF( SELF.Diff_company_sic_code1,1,0)+ IF( SELF.Diff_company_sic_code2,1,0)+ IF( SELF.Diff_company_sic_code3,1,0)+ IF( SELF.Diff_company_sic_code4,1,0)+ IF( SELF.Diff_company_sic_code5,1,0)+ IF( SELF.Diff_company_naics_code1,1,0)+ IF( SELF.Diff_company_naics_code2,1,0)+ IF( SELF.Diff_company_naics_code3,1,0)+ IF( SELF.Diff_company_naics_code4,1,0)+ IF( SELF.Diff_company_naics_code5,1,0)+ IF( SELF.Diff_company_ticker,1,0)+ IF( SELF.Diff_company_ticker_exchange,1,0)+ IF( SELF.Diff_company_foreign_domestic,1,0)+ IF( SELF.Diff_company_url,1,0)+ IF( SELF.Diff_company_inc_state,1,0)+ IF( SELF.Diff_company_charter_number,1,0)+ IF( SELF.Diff_company_filing_date,1,0)+ IF( SELF.Diff_company_status_date,1,0)+ IF( SELF.Diff_company_foreign_date,1,0)+ IF( SELF.Diff_event_filing_date,1,0)+ IF( SELF.Diff_company_name_status_raw,1,0)+ IF( SELF.Diff_company_status_raw,1,0)+ IF( SELF.Diff_vl_id,1,0)+ IF( SELF.Diff_current,1,0)+ IF( SELF.Diff_contact_did,1,0)+ IF( SELF.Diff_contact_type_raw,1,0)+ IF( SELF.Diff_contact_job_title_raw,1,0)+ IF( SELF.Diff_contact_ssn,1,0)+ IF( SELF.Diff_contact_dob,1,0)+ IF( SELF.Diff_contact_status_raw,1,0)+ IF( SELF.Diff_contact_email,1,0)+ IF( SELF.Diff_contact_email_username,1,0)+ IF( SELF.Diff_contact_email_domain,1,0)+ IF( SELF.Diff_contact_phone,1,0)+ IF( SELF.Diff_from_hdr,1,0)+ IF( SELF.Diff_company_department,1,0)+ IF( SELF.Diff_company_address_type_derived,1,0)+ IF( SELF.Diff_company_org_structure_derived,1,0)+ IF( SELF.Diff_company_name_status_derived,1,0)+ IF( SELF.Diff_company_status_derived,1,0)+ IF( SELF.Diff_contact_type_derived,1,0)+ IF( SELF.Diff_contact_job_title_derived,1,0)+ IF( SELF.Diff_contact_status_derived,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_source_record_id := COUNT(GROUP,%Closest%.Diff_source_record_id);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_first_seen_company_name := COUNT(GROUP,%Closest%.Diff_dt_first_seen_company_name);
    Count_Diff_dt_last_seen_company_name := COUNT(GROUP,%Closest%.Diff_dt_last_seen_company_name);
    Count_Diff_dt_first_seen_company_address := COUNT(GROUP,%Closest%.Diff_dt_first_seen_company_address);
    Count_Diff_dt_last_seen_company_address := COUNT(GROUP,%Closest%.Diff_dt_last_seen_company_address);
    Count_Diff_dt_first_seen_contact := COUNT(GROUP,%Closest%.Diff_dt_first_seen_contact);
    Count_Diff_dt_last_seen_contact := COUNT(GROUP,%Closest%.Diff_dt_last_seen_contact);
    Count_Diff_isContact := COUNT(GROUP,%Closest%.Diff_isContact);
    Count_Diff_iscorp := COUNT(GROUP,%Closest%.Diff_iscorp);
    Count_Diff_cnp_hasnumber := COUNT(GROUP,%Closest%.Diff_cnp_hasnumber);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_cnp_number := COUNT(GROUP,%Closest%.Diff_cnp_number);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_cnp_translated := COUNT(GROUP,%Closest%.Diff_cnp_translated);
    Count_Diff_cnp_classid := COUNT(GROUP,%Closest%.Diff_cnp_classid);
    Count_Diff_company_aceaid := COUNT(GROUP,%Closest%.Diff_company_aceaid);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_dba_name := COUNT(GROUP,%Closest%.Diff_dba_name);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_hist_duns_number := COUNT(GROUP,%Closest%.Diff_hist_duns_number);
    Count_Diff_active_enterprise_number := COUNT(GROUP,%Closest%.Diff_active_enterprise_number);
    Count_Diff_hist_enterprise_number := COUNT(GROUP,%Closest%.Diff_hist_enterprise_number);
    Count_Diff_ebr_file_number := COUNT(GROUP,%Closest%.Diff_ebr_file_number);
    Count_Diff_active_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_active_domestic_corp_key);
    Count_Diff_hist_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_hist_domestic_corp_key);
    Count_Diff_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_foreign_corp_key);
    Count_Diff_unk_corp_key := COUNT(GROUP,%Closest%.Diff_unk_corp_key);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
    Count_Diff_employee_count_org_raw := COUNT(GROUP,%Closest%.Diff_employee_count_org_raw);
    Count_Diff_employee_count_org_derived := COUNT(GROUP,%Closest%.Diff_employee_count_org_derived);
    Count_Diff_revenue_org_raw := COUNT(GROUP,%Closest%.Diff_revenue_org_raw);
    Count_Diff_revenue_org_derived := COUNT(GROUP,%Closest%.Diff_revenue_org_derived);
    Count_Diff_employee_count_local_raw := COUNT(GROUP,%Closest%.Diff_employee_count_local_raw);
    Count_Diff_employee_count_local_derived := COUNT(GROUP,%Closest%.Diff_employee_count_local_derived);
    Count_Diff_revenue_local_raw := COUNT(GROUP,%Closest%.Diff_revenue_local_raw);
    Count_Diff_revenue_local_derived := COUNT(GROUP,%Closest%.Diff_revenue_local_derived);
    Count_Diff_locid := COUNT(GROUP,%Closest%.Diff_locid);
    Count_Diff_source_docid := COUNT(GROUP,%Closest%.Diff_source_docid);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_company_name_type_raw := COUNT(GROUP,%Closest%.Diff_company_name_type_raw);
    Count_Diff_company_name_type_derived := COUNT(GROUP,%Closest%.Diff_company_name_type_derived);
    Count_Diff_company_rawaid := COUNT(GROUP,%Closest%.Diff_company_rawaid);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_company_bdid := COUNT(GROUP,%Closest%.Diff_company_bdid);
    Count_Diff_company_address_type_raw := COUNT(GROUP,%Closest%.Diff_company_address_type_raw);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_best_fein_indicator := COUNT(GROUP,%Closest%.Diff_best_fein_indicator);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_phone_type := COUNT(GROUP,%Closest%.Diff_phone_type);
    Count_Diff_phone_score := COUNT(GROUP,%Closest%.Diff_phone_score);
    Count_Diff_company_org_structure_raw := COUNT(GROUP,%Closest%.Diff_company_org_structure_raw);
    Count_Diff_company_incorporation_date := COUNT(GROUP,%Closest%.Diff_company_incorporation_date);
    Count_Diff_company_sic_code1 := COUNT(GROUP,%Closest%.Diff_company_sic_code1);
    Count_Diff_company_sic_code2 := COUNT(GROUP,%Closest%.Diff_company_sic_code2);
    Count_Diff_company_sic_code3 := COUNT(GROUP,%Closest%.Diff_company_sic_code3);
    Count_Diff_company_sic_code4 := COUNT(GROUP,%Closest%.Diff_company_sic_code4);
    Count_Diff_company_sic_code5 := COUNT(GROUP,%Closest%.Diff_company_sic_code5);
    Count_Diff_company_naics_code1 := COUNT(GROUP,%Closest%.Diff_company_naics_code1);
    Count_Diff_company_naics_code2 := COUNT(GROUP,%Closest%.Diff_company_naics_code2);
    Count_Diff_company_naics_code3 := COUNT(GROUP,%Closest%.Diff_company_naics_code3);
    Count_Diff_company_naics_code4 := COUNT(GROUP,%Closest%.Diff_company_naics_code4);
    Count_Diff_company_naics_code5 := COUNT(GROUP,%Closest%.Diff_company_naics_code5);
    Count_Diff_company_ticker := COUNT(GROUP,%Closest%.Diff_company_ticker);
    Count_Diff_company_ticker_exchange := COUNT(GROUP,%Closest%.Diff_company_ticker_exchange);
    Count_Diff_company_foreign_domestic := COUNT(GROUP,%Closest%.Diff_company_foreign_domestic);
    Count_Diff_company_url := COUNT(GROUP,%Closest%.Diff_company_url);
    Count_Diff_company_inc_state := COUNT(GROUP,%Closest%.Diff_company_inc_state);
    Count_Diff_company_charter_number := COUNT(GROUP,%Closest%.Diff_company_charter_number);
    Count_Diff_company_filing_date := COUNT(GROUP,%Closest%.Diff_company_filing_date);
    Count_Diff_company_status_date := COUNT(GROUP,%Closest%.Diff_company_status_date);
    Count_Diff_company_foreign_date := COUNT(GROUP,%Closest%.Diff_company_foreign_date);
    Count_Diff_event_filing_date := COUNT(GROUP,%Closest%.Diff_event_filing_date);
    Count_Diff_company_name_status_raw := COUNT(GROUP,%Closest%.Diff_company_name_status_raw);
    Count_Diff_company_status_raw := COUNT(GROUP,%Closest%.Diff_company_status_raw);
    Count_Diff_vl_id := COUNT(GROUP,%Closest%.Diff_vl_id);
    Count_Diff_current := COUNT(GROUP,%Closest%.Diff_current);
    Count_Diff_contact_did := COUNT(GROUP,%Closest%.Diff_contact_did);
    Count_Diff_contact_type_raw := COUNT(GROUP,%Closest%.Diff_contact_type_raw);
    Count_Diff_contact_job_title_raw := COUNT(GROUP,%Closest%.Diff_contact_job_title_raw);
    Count_Diff_contact_ssn := COUNT(GROUP,%Closest%.Diff_contact_ssn);
    Count_Diff_contact_dob := COUNT(GROUP,%Closest%.Diff_contact_dob);
    Count_Diff_contact_status_raw := COUNT(GROUP,%Closest%.Diff_contact_status_raw);
    Count_Diff_contact_email := COUNT(GROUP,%Closest%.Diff_contact_email);
    Count_Diff_contact_email_username := COUNT(GROUP,%Closest%.Diff_contact_email_username);
    Count_Diff_contact_email_domain := COUNT(GROUP,%Closest%.Diff_contact_email_domain);
    Count_Diff_contact_phone := COUNT(GROUP,%Closest%.Diff_contact_phone);
    Count_Diff_from_hdr := COUNT(GROUP,%Closest%.Diff_from_hdr);
    Count_Diff_company_department := COUNT(GROUP,%Closest%.Diff_company_department);
    Count_Diff_company_address_type_derived := COUNT(GROUP,%Closest%.Diff_company_address_type_derived);
    Count_Diff_company_org_structure_derived := COUNT(GROUP,%Closest%.Diff_company_org_structure_derived);
    Count_Diff_company_name_status_derived := COUNT(GROUP,%Closest%.Diff_company_name_status_derived);
    Count_Diff_company_status_derived := COUNT(GROUP,%Closest%.Diff_company_status_derived);
    Count_Diff_contact_type_derived := COUNT(GROUP,%Closest%.Diff_contact_type_derived);
    Count_Diff_contact_job_title_derived := COUNT(GROUP,%Closest%.Diff_contact_job_title_derived);
    Count_Diff_contact_status_derived := COUNT(GROUP,%Closest%.Diff_contact_status_derived);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rcid,DOTid}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.DOTid);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.DOTid=(UNSIGNED)f.rcid);
      UNSIGNED DOTid_null0 := COUNT(GROUP,(UNSIGNED)f.DOTid=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT35.MOD_ClusterStats.Counts(f,rcid);
  EXPORT DOTid_Clusters := SALT35.MOD_ClusterStats.Counts(f,DOTid);
  EXPORT IdCounts := DATASET([{'rcid_Cnt', SUM(rcid_Clusters,NumberOfClusters)},{'DOTid_Cnt', SUM(DOTid_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)DOTid=(UNSIGNED)rcid); // Get the bases
  EXPORT DOTid_Unbased := JOIN(f(DOTid<>0),bases,LEFT.DOTid=RIGHT.DOTid,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rcid<>0,DOTid<>0),{rcid,DOTid},rcid,DOTid,MERGE);
  EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.DOTid>RIGHT.DOTid,TRANSFORM({SALT35.UIDType DOTid1,SALT35.UIDType rcid,SALT35.UIDType DOTid2},SELF.DOTid1:=LEFT.DOTid,SELF.DOTid2:=RIGHT.DOTid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent];
      INTEGER DOTid_unbased0 := IdCounts[2].Cnt-Basic0.rcid_atparent-IF(Basic0.DOTid_null0>0,1,0);
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT35.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
