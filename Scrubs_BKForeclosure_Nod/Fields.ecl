IMPORT SALT311;
IMPORT Scrubs_BKForeclosure_Nod; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 82;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_number','invalid_alpha','invalid_AlphaNum','invalid_apn','invalid_zip','invalid_date','invalid_phone','invalid_amount','invalid_mers','invalid_document_code','invalid_state','invalid_case','invalid_name','Invalid_NodSourceCode');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_number' => 1,'invalid_alpha' => 2,'invalid_AlphaNum' => 3,'invalid_apn' => 4,'invalid_zip' => 5,'invalid_date' => 6,'invalid_phone' => 7,'invalid_amount' => 8,'invalid_mers' => 9,'invalid_document_code' => 10,'invalid_state' => 11,'invalid_case' => 12,'invalid_name' => 13,'Invalid_NodSourceCode' => 14,0);
 
EXPORT MakeFT_invalid_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' <>{}[]-^=!+&,()#.;/'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=!+&,()#.;/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' <>{}[]-^=!+&,()#.;/'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' <>{}[]-^=!+&,()#.;/'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -.'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -.',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -.'))));
EXPORT InValidMessageFT_invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -.'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_apn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,;.:|`~/+#'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -,;.:|`~/+#',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_apn(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,;.:|`~/+#'))));
EXPORT InValidMessageFT_invalid_apn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,;.:|`~/+#'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,4,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,4,8,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,7,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_amount(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_amount(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_amount(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mers(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_mers(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_invalid_mers(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_document_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_document_code(SALT311.StrType s) := WHICH(~Scrubs_BKForeclosure_Nod.fn_valid_codes(s,'B7','DOCUMENT_TYPE')>0);
EXPORT InValidMessageFT_invalid_document_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_BKForeclosure_Nod.fn_valid_codes'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\''))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\''),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_case(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' {}-&,.():+#/'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' {}-&,.():+#/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_case(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' {}-&,.():+#/'))));
EXPORT InValidMessageFT_invalid_case(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' {}-&,.():+#/'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -&,.():\'#+;"\\/*@'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -&,.():\'#+;"\\/*@',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -&,.():\'#+;"\\/*@'))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -&,.():\'#+;"\\/*@'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_NodSourceCode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_NodSourceCode(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['P','S']);
EXPORT InValidMessageFT_Invalid_NodSourceCode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('P|S'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'foreclosure_id','ln_filedate','bk_infile_type','src_county','src_state','fips_cd','doc_type','recording_dt','recording_doc_num','book_number','page_number','loan_number','trustee_sale_number','case_number','orig_contract_date','unpaid_balance','past_due_amt','as_of_dt','contact_fname','contact_lname','attention_to','contact_mail_full_addr','contact_mail_unit','contact_mail_city','contact_mail_state','contact_mail_zip5','contact_mail_zip4','contact_telephone','due_date','trustee_fname','trustee_lname','trustee_mail_full_addr','trustee_mail_unit','trustee_mail_city','trustee_mail_state','trustee_mail_zip5','trustee_mail_zip4','trustee_telephone','borrower1_fname','borrower1_lname','borrower1_id_cd','borrower2_fname','borrower2_lname','borrower2_id_cd','orig_lender_name','orig_lender_type','curr_lender_name','curr_lender_type','mers_indicator','loan_recording_date','loan_doc_num','loan_book','loan_page','orig_loan_amt','legal_lot_num','legal_block','legal_subdivision_name','legal_brief_desc','auction_date','auction_time','auction_location','auction_min_bid_amt','trustee_mail_careof','property_addr_cd','auction_city','original_nod_recording_date','original_nod_doc_num','original_nod_book','original_nod_page','nod_apn','property_full_addr','prop_addr_unit_type','prop_addr_unit_no','prop_addr_city','prop_addr_state','prop_addr_zip5','prop_addr_zip4','apn','sam_pid','deed_pid','lps_internal_pid','nod_source');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'foreclosure_id','ln_filedate','bk_infile_type','src_county','src_state','fips_cd','doc_type','recording_dt','recording_doc_num','book_number','page_number','loan_number','trustee_sale_number','case_number','orig_contract_date','unpaid_balance','past_due_amt','as_of_dt','contact_fname','contact_lname','attention_to','contact_mail_full_addr','contact_mail_unit','contact_mail_city','contact_mail_state','contact_mail_zip5','contact_mail_zip4','contact_telephone','due_date','trustee_fname','trustee_lname','trustee_mail_full_addr','trustee_mail_unit','trustee_mail_city','trustee_mail_state','trustee_mail_zip5','trustee_mail_zip4','trustee_telephone','borrower1_fname','borrower1_lname','borrower1_id_cd','borrower2_fname','borrower2_lname','borrower2_id_cd','orig_lender_name','orig_lender_type','curr_lender_name','curr_lender_type','mers_indicator','loan_recording_date','loan_doc_num','loan_book','loan_page','orig_loan_amt','legal_lot_num','legal_block','legal_subdivision_name','legal_brief_desc','auction_date','auction_time','auction_location','auction_min_bid_amt','trustee_mail_careof','property_addr_cd','auction_city','original_nod_recording_date','original_nod_doc_num','original_nod_book','original_nod_page','nod_apn','property_full_addr','prop_addr_unit_type','prop_addr_unit_no','prop_addr_city','prop_addr_state','prop_addr_zip5','prop_addr_zip4','apn','sam_pid','deed_pid','lps_internal_pid','nod_source');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'foreclosure_id' => 0,'ln_filedate' => 1,'bk_infile_type' => 2,'src_county' => 3,'src_state' => 4,'fips_cd' => 5,'doc_type' => 6,'recording_dt' => 7,'recording_doc_num' => 8,'book_number' => 9,'page_number' => 10,'loan_number' => 11,'trustee_sale_number' => 12,'case_number' => 13,'orig_contract_date' => 14,'unpaid_balance' => 15,'past_due_amt' => 16,'as_of_dt' => 17,'contact_fname' => 18,'contact_lname' => 19,'attention_to' => 20,'contact_mail_full_addr' => 21,'contact_mail_unit' => 22,'contact_mail_city' => 23,'contact_mail_state' => 24,'contact_mail_zip5' => 25,'contact_mail_zip4' => 26,'contact_telephone' => 27,'due_date' => 28,'trustee_fname' => 29,'trustee_lname' => 30,'trustee_mail_full_addr' => 31,'trustee_mail_unit' => 32,'trustee_mail_city' => 33,'trustee_mail_state' => 34,'trustee_mail_zip5' => 35,'trustee_mail_zip4' => 36,'trustee_telephone' => 37,'borrower1_fname' => 38,'borrower1_lname' => 39,'borrower1_id_cd' => 40,'borrower2_fname' => 41,'borrower2_lname' => 42,'borrower2_id_cd' => 43,'orig_lender_name' => 44,'orig_lender_type' => 45,'curr_lender_name' => 46,'curr_lender_type' => 47,'mers_indicator' => 48,'loan_recording_date' => 49,'loan_doc_num' => 50,'loan_book' => 51,'loan_page' => 52,'orig_loan_amt' => 53,'legal_lot_num' => 54,'legal_block' => 55,'legal_subdivision_name' => 56,'legal_brief_desc' => 57,'auction_date' => 58,'auction_time' => 59,'auction_location' => 60,'auction_min_bid_amt' => 61,'trustee_mail_careof' => 62,'property_addr_cd' => 63,'auction_city' => 64,'original_nod_recording_date' => 65,'original_nod_doc_num' => 66,'original_nod_book' => 67,'original_nod_page' => 68,'nod_apn' => 69,'property_full_addr' => 70,'prop_addr_unit_type' => 71,'prop_addr_unit_no' => 72,'prop_addr_city' => 73,'prop_addr_state' => 74,'prop_addr_zip5' => 75,'prop_addr_zip4' => 76,'apn' => 77,'sam_pid' => 78,'deed_pid' => 79,'lps_internal_pid' => 80,'nod_source' => 81,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW'],['CUSTOM'],['ALLOW','LENGTHS'],[],[],[],[],[],['ALLOW'],['ALLOW','LENGTHS'],[],[],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],[],['ALLOW'],[],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],['ALLOW'],[],[],[],['ALLOW'],['ALLOW','LENGTHS'],[],[],[],['ALLOW'],[],[],['ALLOW'],[],['ALLOW','LENGTHS'],[],[],[],[],[],[],['ALLOW','LENGTHS'],[],[],[],[],['ALLOW'],[],[],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],[],[],[],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_foreclosure_id(SALT311.StrType s0) := s0;
EXPORT InValid_foreclosure_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_foreclosure_id(UNSIGNED1 wh) := '';
 
EXPORT Make_ln_filedate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ln_filedate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ln_filedate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_bk_infile_type(SALT311.StrType s0) := s0;
EXPORT InValid_bk_infile_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_bk_infile_type(UNSIGNED1 wh) := '';
 
EXPORT Make_src_county(SALT311.StrType s0) := s0;
EXPORT InValid_src_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_src_county(UNSIGNED1 wh) := '';
 
EXPORT Make_src_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_src_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_src_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_fips_cd(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_fips_cd(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_fips_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
 
EXPORT Make_doc_type(SALT311.StrType s0) := MakeFT_invalid_document_code(s0);
EXPORT InValid_doc_type(SALT311.StrType s) := InValidFT_invalid_document_code(s);
EXPORT InValidMessage_doc_type(UNSIGNED1 wh) := InValidMessageFT_invalid_document_code(wh);
 
EXPORT Make_recording_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_recording_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_recording_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_recording_doc_num(SALT311.StrType s0) := s0;
EXPORT InValid_recording_doc_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_recording_doc_num(UNSIGNED1 wh) := '';
 
EXPORT Make_book_number(SALT311.StrType s0) := s0;
EXPORT InValid_book_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_book_number(UNSIGNED1 wh) := '';
 
EXPORT Make_page_number(SALT311.StrType s0) := s0;
EXPORT InValid_page_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_page_number(UNSIGNED1 wh) := '';
 
EXPORT Make_loan_number(SALT311.StrType s0) := s0;
EXPORT InValid_loan_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_loan_number(UNSIGNED1 wh) := '';
 
EXPORT Make_trustee_sale_number(SALT311.StrType s0) := s0;
EXPORT InValid_trustee_sale_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_trustee_sale_number(UNSIGNED1 wh) := '';
 
EXPORT Make_case_number(SALT311.StrType s0) := MakeFT_invalid_case(s0);
EXPORT InValid_case_number(SALT311.StrType s) := InValidFT_invalid_case(s);
EXPORT InValidMessage_case_number(UNSIGNED1 wh) := InValidMessageFT_invalid_case(wh);
 
EXPORT Make_orig_contract_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_orig_contract_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_orig_contract_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_unpaid_balance(SALT311.StrType s0) := s0;
EXPORT InValid_unpaid_balance(SALT311.StrType s) := 0;
EXPORT InValidMessage_unpaid_balance(UNSIGNED1 wh) := '';
 
EXPORT Make_past_due_amt(SALT311.StrType s0) := s0;
EXPORT InValid_past_due_amt(SALT311.StrType s) := 0;
EXPORT InValidMessage_past_due_amt(UNSIGNED1 wh) := '';
 
EXPORT Make_as_of_dt(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_as_of_dt(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_as_of_dt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_contact_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_contact_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_contact_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_contact_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_contact_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_contact_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_attention_to(SALT311.StrType s0) := s0;
EXPORT InValid_attention_to(SALT311.StrType s) := 0;
EXPORT InValidMessage_attention_to(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_mail_full_addr(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_contact_mail_full_addr(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_contact_mail_full_addr(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_contact_mail_unit(SALT311.StrType s0) := s0;
EXPORT InValid_contact_mail_unit(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_mail_unit(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_mail_city(SALT311.StrType s0) := MakeFT_invalid_AlphaNum(s0);
EXPORT InValid_contact_mail_city(SALT311.StrType s) := InValidFT_invalid_AlphaNum(s);
EXPORT InValidMessage_contact_mail_city(UNSIGNED1 wh) := InValidMessageFT_invalid_AlphaNum(wh);
 
EXPORT Make_contact_mail_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_contact_mail_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_contact_mail_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_contact_mail_zip5(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_contact_mail_zip5(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_contact_mail_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_contact_mail_zip4(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_contact_mail_zip4(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_contact_mail_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_contact_telephone(SALT311.StrType s0) := s0;
EXPORT InValid_contact_telephone(SALT311.StrType s) := 0;
EXPORT InValidMessage_contact_telephone(UNSIGNED1 wh) := '';
 
EXPORT Make_due_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_due_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_due_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_trustee_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_trustee_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_trustee_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_trustee_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_trustee_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_trustee_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_trustee_mail_full_addr(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_trustee_mail_full_addr(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_trustee_mail_full_addr(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_trustee_mail_unit(SALT311.StrType s0) := s0;
EXPORT InValid_trustee_mail_unit(SALT311.StrType s) := 0;
EXPORT InValidMessage_trustee_mail_unit(UNSIGNED1 wh) := '';
 
EXPORT Make_trustee_mail_city(SALT311.StrType s0) := MakeFT_invalid_AlphaNum(s0);
EXPORT InValid_trustee_mail_city(SALT311.StrType s) := InValidFT_invalid_AlphaNum(s);
EXPORT InValidMessage_trustee_mail_city(UNSIGNED1 wh) := InValidMessageFT_invalid_AlphaNum(wh);
 
EXPORT Make_trustee_mail_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_trustee_mail_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_trustee_mail_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_trustee_mail_zip5(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_trustee_mail_zip5(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_trustee_mail_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_trustee_mail_zip4(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_trustee_mail_zip4(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_trustee_mail_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_trustee_telephone(SALT311.StrType s0) := s0;
EXPORT InValid_trustee_telephone(SALT311.StrType s) := 0;
EXPORT InValidMessage_trustee_telephone(UNSIGNED1 wh) := '';
 
EXPORT Make_borrower1_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_borrower1_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_borrower1_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_borrower1_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_borrower1_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_borrower1_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_borrower1_id_cd(SALT311.StrType s0) := s0;
EXPORT InValid_borrower1_id_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_borrower1_id_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_borrower2_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_borrower2_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_borrower2_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_borrower2_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_borrower2_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_borrower2_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_borrower2_id_cd(SALT311.StrType s0) := s0;
EXPORT InValid_borrower2_id_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_borrower2_id_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_lender_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_orig_lender_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_orig_lender_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_orig_lender_type(SALT311.StrType s0) := s0;
EXPORT InValid_orig_lender_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_lender_type(UNSIGNED1 wh) := '';
 
EXPORT Make_curr_lender_name(SALT311.StrType s0) := s0;
EXPORT InValid_curr_lender_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_curr_lender_name(UNSIGNED1 wh) := '';
 
EXPORT Make_curr_lender_type(SALT311.StrType s0) := s0;
EXPORT InValid_curr_lender_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_curr_lender_type(UNSIGNED1 wh) := '';
 
EXPORT Make_mers_indicator(SALT311.StrType s0) := MakeFT_invalid_mers(s0);
EXPORT InValid_mers_indicator(SALT311.StrType s) := InValidFT_invalid_mers(s);
EXPORT InValidMessage_mers_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_mers(wh);
 
EXPORT Make_loan_recording_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_loan_recording_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_loan_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_loan_doc_num(SALT311.StrType s0) := s0;
EXPORT InValid_loan_doc_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_loan_doc_num(UNSIGNED1 wh) := '';
 
EXPORT Make_loan_book(SALT311.StrType s0) := s0;
EXPORT InValid_loan_book(SALT311.StrType s) := 0;
EXPORT InValidMessage_loan_book(UNSIGNED1 wh) := '';
 
EXPORT Make_loan_page(SALT311.StrType s0) := s0;
EXPORT InValid_loan_page(SALT311.StrType s) := 0;
EXPORT InValidMessage_loan_page(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_loan_amt(SALT311.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_orig_loan_amt(SALT311.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_orig_loan_amt(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_legal_lot_num(SALT311.StrType s0) := s0;
EXPORT InValid_legal_lot_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_lot_num(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_block(SALT311.StrType s0) := s0;
EXPORT InValid_legal_block(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_block(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_subdivision_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_legal_subdivision_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_legal_subdivision_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_legal_brief_desc(SALT311.StrType s0) := s0;
EXPORT InValid_legal_brief_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_legal_brief_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_auction_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_auction_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_auction_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_auction_time(SALT311.StrType s0) := s0;
EXPORT InValid_auction_time(SALT311.StrType s) := 0;
EXPORT InValidMessage_auction_time(UNSIGNED1 wh) := '';
 
EXPORT Make_auction_location(SALT311.StrType s0) := s0;
EXPORT InValid_auction_location(SALT311.StrType s) := 0;
EXPORT InValidMessage_auction_location(UNSIGNED1 wh) := '';
 
EXPORT Make_auction_min_bid_amt(SALT311.StrType s0) := s0;
EXPORT InValid_auction_min_bid_amt(SALT311.StrType s) := 0;
EXPORT InValidMessage_auction_min_bid_amt(UNSIGNED1 wh) := '';
 
EXPORT Make_trustee_mail_careof(SALT311.StrType s0) := s0;
EXPORT InValid_trustee_mail_careof(SALT311.StrType s) := 0;
EXPORT InValidMessage_trustee_mail_careof(UNSIGNED1 wh) := '';
 
EXPORT Make_property_addr_cd(SALT311.StrType s0) := s0;
EXPORT InValid_property_addr_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_property_addr_cd(UNSIGNED1 wh) := '';
 
EXPORT Make_auction_city(SALT311.StrType s0) := s0;
EXPORT InValid_auction_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_auction_city(UNSIGNED1 wh) := '';
 
EXPORT Make_original_nod_recording_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_original_nod_recording_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_original_nod_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_original_nod_doc_num(SALT311.StrType s0) := s0;
EXPORT InValid_original_nod_doc_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_original_nod_doc_num(UNSIGNED1 wh) := '';
 
EXPORT Make_original_nod_book(SALT311.StrType s0) := s0;
EXPORT InValid_original_nod_book(SALT311.StrType s) := 0;
EXPORT InValidMessage_original_nod_book(UNSIGNED1 wh) := '';
 
EXPORT Make_original_nod_page(SALT311.StrType s0) := s0;
EXPORT InValid_original_nod_page(SALT311.StrType s) := 0;
EXPORT InValidMessage_original_nod_page(UNSIGNED1 wh) := '';
 
EXPORT Make_nod_apn(SALT311.StrType s0) := s0;
EXPORT InValid_nod_apn(SALT311.StrType s) := 0;
EXPORT InValidMessage_nod_apn(UNSIGNED1 wh) := '';
 
EXPORT Make_property_full_addr(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_property_full_addr(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_property_full_addr(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_prop_addr_unit_type(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_unit_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_unit_type(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_unit_no(SALT311.StrType s0) := s0;
EXPORT InValid_prop_addr_unit_no(SALT311.StrType s) := 0;
EXPORT InValidMessage_prop_addr_unit_no(UNSIGNED1 wh) := '';
 
EXPORT Make_prop_addr_city(SALT311.StrType s0) := MakeFT_invalid_AlphaNum(s0);
EXPORT InValid_prop_addr_city(SALT311.StrType s) := InValidFT_invalid_AlphaNum(s);
EXPORT InValidMessage_prop_addr_city(UNSIGNED1 wh) := InValidMessageFT_invalid_AlphaNum(wh);
 
EXPORT Make_prop_addr_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_prop_addr_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_prop_addr_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_prop_addr_zip5(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_prop_addr_zip5(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_prop_addr_zip5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_prop_addr_zip4(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_prop_addr_zip4(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_prop_addr_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_apn(SALT311.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_apn(SALT311.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_apn(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_sam_pid(SALT311.StrType s0) := s0;
EXPORT InValid_sam_pid(SALT311.StrType s) := 0;
EXPORT InValidMessage_sam_pid(UNSIGNED1 wh) := '';
 
EXPORT Make_deed_pid(SALT311.StrType s0) := s0;
EXPORT InValid_deed_pid(SALT311.StrType s) := 0;
EXPORT InValidMessage_deed_pid(UNSIGNED1 wh) := '';
 
EXPORT Make_lps_internal_pid(SALT311.StrType s0) := s0;
EXPORT InValid_lps_internal_pid(SALT311.StrType s) := 0;
EXPORT InValidMessage_lps_internal_pid(UNSIGNED1 wh) := '';
 
EXPORT Make_nod_source(SALT311.StrType s0) := MakeFT_Invalid_NodSourceCode(s0);
EXPORT InValid_nod_source(SALT311.StrType s) := InValidFT_Invalid_NodSourceCode(s);
EXPORT InValidMessage_nod_source(UNSIGNED1 wh) := InValidMessageFT_Invalid_NodSourceCode(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_BKForeclosure_Nod;
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
    BOOLEAN Diff_foreclosure_id;
    BOOLEAN Diff_ln_filedate;
    BOOLEAN Diff_bk_infile_type;
    BOOLEAN Diff_src_county;
    BOOLEAN Diff_src_state;
    BOOLEAN Diff_fips_cd;
    BOOLEAN Diff_doc_type;
    BOOLEAN Diff_recording_dt;
    BOOLEAN Diff_recording_doc_num;
    BOOLEAN Diff_book_number;
    BOOLEAN Diff_page_number;
    BOOLEAN Diff_loan_number;
    BOOLEAN Diff_trustee_sale_number;
    BOOLEAN Diff_case_number;
    BOOLEAN Diff_orig_contract_date;
    BOOLEAN Diff_unpaid_balance;
    BOOLEAN Diff_past_due_amt;
    BOOLEAN Diff_as_of_dt;
    BOOLEAN Diff_contact_fname;
    BOOLEAN Diff_contact_lname;
    BOOLEAN Diff_attention_to;
    BOOLEAN Diff_contact_mail_full_addr;
    BOOLEAN Diff_contact_mail_unit;
    BOOLEAN Diff_contact_mail_city;
    BOOLEAN Diff_contact_mail_state;
    BOOLEAN Diff_contact_mail_zip5;
    BOOLEAN Diff_contact_mail_zip4;
    BOOLEAN Diff_contact_telephone;
    BOOLEAN Diff_due_date;
    BOOLEAN Diff_trustee_fname;
    BOOLEAN Diff_trustee_lname;
    BOOLEAN Diff_trustee_mail_full_addr;
    BOOLEAN Diff_trustee_mail_unit;
    BOOLEAN Diff_trustee_mail_city;
    BOOLEAN Diff_trustee_mail_state;
    BOOLEAN Diff_trustee_mail_zip5;
    BOOLEAN Diff_trustee_mail_zip4;
    BOOLEAN Diff_trustee_telephone;
    BOOLEAN Diff_borrower1_fname;
    BOOLEAN Diff_borrower1_lname;
    BOOLEAN Diff_borrower1_id_cd;
    BOOLEAN Diff_borrower2_fname;
    BOOLEAN Diff_borrower2_lname;
    BOOLEAN Diff_borrower2_id_cd;
    BOOLEAN Diff_orig_lender_name;
    BOOLEAN Diff_orig_lender_type;
    BOOLEAN Diff_curr_lender_name;
    BOOLEAN Diff_curr_lender_type;
    BOOLEAN Diff_mers_indicator;
    BOOLEAN Diff_loan_recording_date;
    BOOLEAN Diff_loan_doc_num;
    BOOLEAN Diff_loan_book;
    BOOLEAN Diff_loan_page;
    BOOLEAN Diff_orig_loan_amt;
    BOOLEAN Diff_legal_lot_num;
    BOOLEAN Diff_legal_block;
    BOOLEAN Diff_legal_subdivision_name;
    BOOLEAN Diff_legal_brief_desc;
    BOOLEAN Diff_auction_date;
    BOOLEAN Diff_auction_time;
    BOOLEAN Diff_auction_location;
    BOOLEAN Diff_auction_min_bid_amt;
    BOOLEAN Diff_trustee_mail_careof;
    BOOLEAN Diff_property_addr_cd;
    BOOLEAN Diff_auction_city;
    BOOLEAN Diff_original_nod_recording_date;
    BOOLEAN Diff_original_nod_doc_num;
    BOOLEAN Diff_original_nod_book;
    BOOLEAN Diff_original_nod_page;
    BOOLEAN Diff_nod_apn;
    BOOLEAN Diff_property_full_addr;
    BOOLEAN Diff_prop_addr_unit_type;
    BOOLEAN Diff_prop_addr_unit_no;
    BOOLEAN Diff_prop_addr_city;
    BOOLEAN Diff_prop_addr_state;
    BOOLEAN Diff_prop_addr_zip5;
    BOOLEAN Diff_prop_addr_zip4;
    BOOLEAN Diff_apn;
    BOOLEAN Diff_sam_pid;
    BOOLEAN Diff_deed_pid;
    BOOLEAN Diff_lps_internal_pid;
    BOOLEAN Diff_nod_source;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_foreclosure_id := le.foreclosure_id <> ri.foreclosure_id;
    SELF.Diff_ln_filedate := le.ln_filedate <> ri.ln_filedate;
    SELF.Diff_bk_infile_type := le.bk_infile_type <> ri.bk_infile_type;
    SELF.Diff_src_county := le.src_county <> ri.src_county;
    SELF.Diff_src_state := le.src_state <> ri.src_state;
    SELF.Diff_fips_cd := le.fips_cd <> ri.fips_cd;
    SELF.Diff_doc_type := le.doc_type <> ri.doc_type;
    SELF.Diff_recording_dt := le.recording_dt <> ri.recording_dt;
    SELF.Diff_recording_doc_num := le.recording_doc_num <> ri.recording_doc_num;
    SELF.Diff_book_number := le.book_number <> ri.book_number;
    SELF.Diff_page_number := le.page_number <> ri.page_number;
    SELF.Diff_loan_number := le.loan_number <> ri.loan_number;
    SELF.Diff_trustee_sale_number := le.trustee_sale_number <> ri.trustee_sale_number;
    SELF.Diff_case_number := le.case_number <> ri.case_number;
    SELF.Diff_orig_contract_date := le.orig_contract_date <> ri.orig_contract_date;
    SELF.Diff_unpaid_balance := le.unpaid_balance <> ri.unpaid_balance;
    SELF.Diff_past_due_amt := le.past_due_amt <> ri.past_due_amt;
    SELF.Diff_as_of_dt := le.as_of_dt <> ri.as_of_dt;
    SELF.Diff_contact_fname := le.contact_fname <> ri.contact_fname;
    SELF.Diff_contact_lname := le.contact_lname <> ri.contact_lname;
    SELF.Diff_attention_to := le.attention_to <> ri.attention_to;
    SELF.Diff_contact_mail_full_addr := le.contact_mail_full_addr <> ri.contact_mail_full_addr;
    SELF.Diff_contact_mail_unit := le.contact_mail_unit <> ri.contact_mail_unit;
    SELF.Diff_contact_mail_city := le.contact_mail_city <> ri.contact_mail_city;
    SELF.Diff_contact_mail_state := le.contact_mail_state <> ri.contact_mail_state;
    SELF.Diff_contact_mail_zip5 := le.contact_mail_zip5 <> ri.contact_mail_zip5;
    SELF.Diff_contact_mail_zip4 := le.contact_mail_zip4 <> ri.contact_mail_zip4;
    SELF.Diff_contact_telephone := le.contact_telephone <> ri.contact_telephone;
    SELF.Diff_due_date := le.due_date <> ri.due_date;
    SELF.Diff_trustee_fname := le.trustee_fname <> ri.trustee_fname;
    SELF.Diff_trustee_lname := le.trustee_lname <> ri.trustee_lname;
    SELF.Diff_trustee_mail_full_addr := le.trustee_mail_full_addr <> ri.trustee_mail_full_addr;
    SELF.Diff_trustee_mail_unit := le.trustee_mail_unit <> ri.trustee_mail_unit;
    SELF.Diff_trustee_mail_city := le.trustee_mail_city <> ri.trustee_mail_city;
    SELF.Diff_trustee_mail_state := le.trustee_mail_state <> ri.trustee_mail_state;
    SELF.Diff_trustee_mail_zip5 := le.trustee_mail_zip5 <> ri.trustee_mail_zip5;
    SELF.Diff_trustee_mail_zip4 := le.trustee_mail_zip4 <> ri.trustee_mail_zip4;
    SELF.Diff_trustee_telephone := le.trustee_telephone <> ri.trustee_telephone;
    SELF.Diff_borrower1_fname := le.borrower1_fname <> ri.borrower1_fname;
    SELF.Diff_borrower1_lname := le.borrower1_lname <> ri.borrower1_lname;
    SELF.Diff_borrower1_id_cd := le.borrower1_id_cd <> ri.borrower1_id_cd;
    SELF.Diff_borrower2_fname := le.borrower2_fname <> ri.borrower2_fname;
    SELF.Diff_borrower2_lname := le.borrower2_lname <> ri.borrower2_lname;
    SELF.Diff_borrower2_id_cd := le.borrower2_id_cd <> ri.borrower2_id_cd;
    SELF.Diff_orig_lender_name := le.orig_lender_name <> ri.orig_lender_name;
    SELF.Diff_orig_lender_type := le.orig_lender_type <> ri.orig_lender_type;
    SELF.Diff_curr_lender_name := le.curr_lender_name <> ri.curr_lender_name;
    SELF.Diff_curr_lender_type := le.curr_lender_type <> ri.curr_lender_type;
    SELF.Diff_mers_indicator := le.mers_indicator <> ri.mers_indicator;
    SELF.Diff_loan_recording_date := le.loan_recording_date <> ri.loan_recording_date;
    SELF.Diff_loan_doc_num := le.loan_doc_num <> ri.loan_doc_num;
    SELF.Diff_loan_book := le.loan_book <> ri.loan_book;
    SELF.Diff_loan_page := le.loan_page <> ri.loan_page;
    SELF.Diff_orig_loan_amt := le.orig_loan_amt <> ri.orig_loan_amt;
    SELF.Diff_legal_lot_num := le.legal_lot_num <> ri.legal_lot_num;
    SELF.Diff_legal_block := le.legal_block <> ri.legal_block;
    SELF.Diff_legal_subdivision_name := le.legal_subdivision_name <> ri.legal_subdivision_name;
    SELF.Diff_legal_brief_desc := le.legal_brief_desc <> ri.legal_brief_desc;
    SELF.Diff_auction_date := le.auction_date <> ri.auction_date;
    SELF.Diff_auction_time := le.auction_time <> ri.auction_time;
    SELF.Diff_auction_location := le.auction_location <> ri.auction_location;
    SELF.Diff_auction_min_bid_amt := le.auction_min_bid_amt <> ri.auction_min_bid_amt;
    SELF.Diff_trustee_mail_careof := le.trustee_mail_careof <> ri.trustee_mail_careof;
    SELF.Diff_property_addr_cd := le.property_addr_cd <> ri.property_addr_cd;
    SELF.Diff_auction_city := le.auction_city <> ri.auction_city;
    SELF.Diff_original_nod_recording_date := le.original_nod_recording_date <> ri.original_nod_recording_date;
    SELF.Diff_original_nod_doc_num := le.original_nod_doc_num <> ri.original_nod_doc_num;
    SELF.Diff_original_nod_book := le.original_nod_book <> ri.original_nod_book;
    SELF.Diff_original_nod_page := le.original_nod_page <> ri.original_nod_page;
    SELF.Diff_nod_apn := le.nod_apn <> ri.nod_apn;
    SELF.Diff_property_full_addr := le.property_full_addr <> ri.property_full_addr;
    SELF.Diff_prop_addr_unit_type := le.prop_addr_unit_type <> ri.prop_addr_unit_type;
    SELF.Diff_prop_addr_unit_no := le.prop_addr_unit_no <> ri.prop_addr_unit_no;
    SELF.Diff_prop_addr_city := le.prop_addr_city <> ri.prop_addr_city;
    SELF.Diff_prop_addr_state := le.prop_addr_state <> ri.prop_addr_state;
    SELF.Diff_prop_addr_zip5 := le.prop_addr_zip5 <> ri.prop_addr_zip5;
    SELF.Diff_prop_addr_zip4 := le.prop_addr_zip4 <> ri.prop_addr_zip4;
    SELF.Diff_apn := le.apn <> ri.apn;
    SELF.Diff_sam_pid := le.sam_pid <> ri.sam_pid;
    SELF.Diff_deed_pid := le.deed_pid <> ri.deed_pid;
    SELF.Diff_lps_internal_pid := le.lps_internal_pid <> ri.lps_internal_pid;
    SELF.Diff_nod_source := le.nod_source <> ri.nod_source;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_foreclosure_id,1,0)+ IF( SELF.Diff_ln_filedate,1,0)+ IF( SELF.Diff_bk_infile_type,1,0)+ IF( SELF.Diff_src_county,1,0)+ IF( SELF.Diff_src_state,1,0)+ IF( SELF.Diff_fips_cd,1,0)+ IF( SELF.Diff_doc_type,1,0)+ IF( SELF.Diff_recording_dt,1,0)+ IF( SELF.Diff_recording_doc_num,1,0)+ IF( SELF.Diff_book_number,1,0)+ IF( SELF.Diff_page_number,1,0)+ IF( SELF.Diff_loan_number,1,0)+ IF( SELF.Diff_trustee_sale_number,1,0)+ IF( SELF.Diff_case_number,1,0)+ IF( SELF.Diff_orig_contract_date,1,0)+ IF( SELF.Diff_unpaid_balance,1,0)+ IF( SELF.Diff_past_due_amt,1,0)+ IF( SELF.Diff_as_of_dt,1,0)+ IF( SELF.Diff_contact_fname,1,0)+ IF( SELF.Diff_contact_lname,1,0)+ IF( SELF.Diff_attention_to,1,0)+ IF( SELF.Diff_contact_mail_full_addr,1,0)+ IF( SELF.Diff_contact_mail_unit,1,0)+ IF( SELF.Diff_contact_mail_city,1,0)+ IF( SELF.Diff_contact_mail_state,1,0)+ IF( SELF.Diff_contact_mail_zip5,1,0)+ IF( SELF.Diff_contact_mail_zip4,1,0)+ IF( SELF.Diff_contact_telephone,1,0)+ IF( SELF.Diff_due_date,1,0)+ IF( SELF.Diff_trustee_fname,1,0)+ IF( SELF.Diff_trustee_lname,1,0)+ IF( SELF.Diff_trustee_mail_full_addr,1,0)+ IF( SELF.Diff_trustee_mail_unit,1,0)+ IF( SELF.Diff_trustee_mail_city,1,0)+ IF( SELF.Diff_trustee_mail_state,1,0)+ IF( SELF.Diff_trustee_mail_zip5,1,0)+ IF( SELF.Diff_trustee_mail_zip4,1,0)+ IF( SELF.Diff_trustee_telephone,1,0)+ IF( SELF.Diff_borrower1_fname,1,0)+ IF( SELF.Diff_borrower1_lname,1,0)+ IF( SELF.Diff_borrower1_id_cd,1,0)+ IF( SELF.Diff_borrower2_fname,1,0)+ IF( SELF.Diff_borrower2_lname,1,0)+ IF( SELF.Diff_borrower2_id_cd,1,0)+ IF( SELF.Diff_orig_lender_name,1,0)+ IF( SELF.Diff_orig_lender_type,1,0)+ IF( SELF.Diff_curr_lender_name,1,0)+ IF( SELF.Diff_curr_lender_type,1,0)+ IF( SELF.Diff_mers_indicator,1,0)+ IF( SELF.Diff_loan_recording_date,1,0)+ IF( SELF.Diff_loan_doc_num,1,0)+ IF( SELF.Diff_loan_book,1,0)+ IF( SELF.Diff_loan_page,1,0)+ IF( SELF.Diff_orig_loan_amt,1,0)+ IF( SELF.Diff_legal_lot_num,1,0)+ IF( SELF.Diff_legal_block,1,0)+ IF( SELF.Diff_legal_subdivision_name,1,0)+ IF( SELF.Diff_legal_brief_desc,1,0)+ IF( SELF.Diff_auction_date,1,0)+ IF( SELF.Diff_auction_time,1,0)+ IF( SELF.Diff_auction_location,1,0)+ IF( SELF.Diff_auction_min_bid_amt,1,0)+ IF( SELF.Diff_trustee_mail_careof,1,0)+ IF( SELF.Diff_property_addr_cd,1,0)+ IF( SELF.Diff_auction_city,1,0)+ IF( SELF.Diff_original_nod_recording_date,1,0)+ IF( SELF.Diff_original_nod_doc_num,1,0)+ IF( SELF.Diff_original_nod_book,1,0)+ IF( SELF.Diff_original_nod_page,1,0)+ IF( SELF.Diff_nod_apn,1,0)+ IF( SELF.Diff_property_full_addr,1,0)+ IF( SELF.Diff_prop_addr_unit_type,1,0)+ IF( SELF.Diff_prop_addr_unit_no,1,0)+ IF( SELF.Diff_prop_addr_city,1,0)+ IF( SELF.Diff_prop_addr_state,1,0)+ IF( SELF.Diff_prop_addr_zip5,1,0)+ IF( SELF.Diff_prop_addr_zip4,1,0)+ IF( SELF.Diff_apn,1,0)+ IF( SELF.Diff_sam_pid,1,0)+ IF( SELF.Diff_deed_pid,1,0)+ IF( SELF.Diff_lps_internal_pid,1,0)+ IF( SELF.Diff_nod_source,1,0);
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
    Count_Diff_foreclosure_id := COUNT(GROUP,%Closest%.Diff_foreclosure_id);
    Count_Diff_ln_filedate := COUNT(GROUP,%Closest%.Diff_ln_filedate);
    Count_Diff_bk_infile_type := COUNT(GROUP,%Closest%.Diff_bk_infile_type);
    Count_Diff_src_county := COUNT(GROUP,%Closest%.Diff_src_county);
    Count_Diff_src_state := COUNT(GROUP,%Closest%.Diff_src_state);
    Count_Diff_fips_cd := COUNT(GROUP,%Closest%.Diff_fips_cd);
    Count_Diff_doc_type := COUNT(GROUP,%Closest%.Diff_doc_type);
    Count_Diff_recording_dt := COUNT(GROUP,%Closest%.Diff_recording_dt);
    Count_Diff_recording_doc_num := COUNT(GROUP,%Closest%.Diff_recording_doc_num);
    Count_Diff_book_number := COUNT(GROUP,%Closest%.Diff_book_number);
    Count_Diff_page_number := COUNT(GROUP,%Closest%.Diff_page_number);
    Count_Diff_loan_number := COUNT(GROUP,%Closest%.Diff_loan_number);
    Count_Diff_trustee_sale_number := COUNT(GROUP,%Closest%.Diff_trustee_sale_number);
    Count_Diff_case_number := COUNT(GROUP,%Closest%.Diff_case_number);
    Count_Diff_orig_contract_date := COUNT(GROUP,%Closest%.Diff_orig_contract_date);
    Count_Diff_unpaid_balance := COUNT(GROUP,%Closest%.Diff_unpaid_balance);
    Count_Diff_past_due_amt := COUNT(GROUP,%Closest%.Diff_past_due_amt);
    Count_Diff_as_of_dt := COUNT(GROUP,%Closest%.Diff_as_of_dt);
    Count_Diff_contact_fname := COUNT(GROUP,%Closest%.Diff_contact_fname);
    Count_Diff_contact_lname := COUNT(GROUP,%Closest%.Diff_contact_lname);
    Count_Diff_attention_to := COUNT(GROUP,%Closest%.Diff_attention_to);
    Count_Diff_contact_mail_full_addr := COUNT(GROUP,%Closest%.Diff_contact_mail_full_addr);
    Count_Diff_contact_mail_unit := COUNT(GROUP,%Closest%.Diff_contact_mail_unit);
    Count_Diff_contact_mail_city := COUNT(GROUP,%Closest%.Diff_contact_mail_city);
    Count_Diff_contact_mail_state := COUNT(GROUP,%Closest%.Diff_contact_mail_state);
    Count_Diff_contact_mail_zip5 := COUNT(GROUP,%Closest%.Diff_contact_mail_zip5);
    Count_Diff_contact_mail_zip4 := COUNT(GROUP,%Closest%.Diff_contact_mail_zip4);
    Count_Diff_contact_telephone := COUNT(GROUP,%Closest%.Diff_contact_telephone);
    Count_Diff_due_date := COUNT(GROUP,%Closest%.Diff_due_date);
    Count_Diff_trustee_fname := COUNT(GROUP,%Closest%.Diff_trustee_fname);
    Count_Diff_trustee_lname := COUNT(GROUP,%Closest%.Diff_trustee_lname);
    Count_Diff_trustee_mail_full_addr := COUNT(GROUP,%Closest%.Diff_trustee_mail_full_addr);
    Count_Diff_trustee_mail_unit := COUNT(GROUP,%Closest%.Diff_trustee_mail_unit);
    Count_Diff_trustee_mail_city := COUNT(GROUP,%Closest%.Diff_trustee_mail_city);
    Count_Diff_trustee_mail_state := COUNT(GROUP,%Closest%.Diff_trustee_mail_state);
    Count_Diff_trustee_mail_zip5 := COUNT(GROUP,%Closest%.Diff_trustee_mail_zip5);
    Count_Diff_trustee_mail_zip4 := COUNT(GROUP,%Closest%.Diff_trustee_mail_zip4);
    Count_Diff_trustee_telephone := COUNT(GROUP,%Closest%.Diff_trustee_telephone);
    Count_Diff_borrower1_fname := COUNT(GROUP,%Closest%.Diff_borrower1_fname);
    Count_Diff_borrower1_lname := COUNT(GROUP,%Closest%.Diff_borrower1_lname);
    Count_Diff_borrower1_id_cd := COUNT(GROUP,%Closest%.Diff_borrower1_id_cd);
    Count_Diff_borrower2_fname := COUNT(GROUP,%Closest%.Diff_borrower2_fname);
    Count_Diff_borrower2_lname := COUNT(GROUP,%Closest%.Diff_borrower2_lname);
    Count_Diff_borrower2_id_cd := COUNT(GROUP,%Closest%.Diff_borrower2_id_cd);
    Count_Diff_orig_lender_name := COUNT(GROUP,%Closest%.Diff_orig_lender_name);
    Count_Diff_orig_lender_type := COUNT(GROUP,%Closest%.Diff_orig_lender_type);
    Count_Diff_curr_lender_name := COUNT(GROUP,%Closest%.Diff_curr_lender_name);
    Count_Diff_curr_lender_type := COUNT(GROUP,%Closest%.Diff_curr_lender_type);
    Count_Diff_mers_indicator := COUNT(GROUP,%Closest%.Diff_mers_indicator);
    Count_Diff_loan_recording_date := COUNT(GROUP,%Closest%.Diff_loan_recording_date);
    Count_Diff_loan_doc_num := COUNT(GROUP,%Closest%.Diff_loan_doc_num);
    Count_Diff_loan_book := COUNT(GROUP,%Closest%.Diff_loan_book);
    Count_Diff_loan_page := COUNT(GROUP,%Closest%.Diff_loan_page);
    Count_Diff_orig_loan_amt := COUNT(GROUP,%Closest%.Diff_orig_loan_amt);
    Count_Diff_legal_lot_num := COUNT(GROUP,%Closest%.Diff_legal_lot_num);
    Count_Diff_legal_block := COUNT(GROUP,%Closest%.Diff_legal_block);
    Count_Diff_legal_subdivision_name := COUNT(GROUP,%Closest%.Diff_legal_subdivision_name);
    Count_Diff_legal_brief_desc := COUNT(GROUP,%Closest%.Diff_legal_brief_desc);
    Count_Diff_auction_date := COUNT(GROUP,%Closest%.Diff_auction_date);
    Count_Diff_auction_time := COUNT(GROUP,%Closest%.Diff_auction_time);
    Count_Diff_auction_location := COUNT(GROUP,%Closest%.Diff_auction_location);
    Count_Diff_auction_min_bid_amt := COUNT(GROUP,%Closest%.Diff_auction_min_bid_amt);
    Count_Diff_trustee_mail_careof := COUNT(GROUP,%Closest%.Diff_trustee_mail_careof);
    Count_Diff_property_addr_cd := COUNT(GROUP,%Closest%.Diff_property_addr_cd);
    Count_Diff_auction_city := COUNT(GROUP,%Closest%.Diff_auction_city);
    Count_Diff_original_nod_recording_date := COUNT(GROUP,%Closest%.Diff_original_nod_recording_date);
    Count_Diff_original_nod_doc_num := COUNT(GROUP,%Closest%.Diff_original_nod_doc_num);
    Count_Diff_original_nod_book := COUNT(GROUP,%Closest%.Diff_original_nod_book);
    Count_Diff_original_nod_page := COUNT(GROUP,%Closest%.Diff_original_nod_page);
    Count_Diff_nod_apn := COUNT(GROUP,%Closest%.Diff_nod_apn);
    Count_Diff_property_full_addr := COUNT(GROUP,%Closest%.Diff_property_full_addr);
    Count_Diff_prop_addr_unit_type := COUNT(GROUP,%Closest%.Diff_prop_addr_unit_type);
    Count_Diff_prop_addr_unit_no := COUNT(GROUP,%Closest%.Diff_prop_addr_unit_no);
    Count_Diff_prop_addr_city := COUNT(GROUP,%Closest%.Diff_prop_addr_city);
    Count_Diff_prop_addr_state := COUNT(GROUP,%Closest%.Diff_prop_addr_state);
    Count_Diff_prop_addr_zip5 := COUNT(GROUP,%Closest%.Diff_prop_addr_zip5);
    Count_Diff_prop_addr_zip4 := COUNT(GROUP,%Closest%.Diff_prop_addr_zip4);
    Count_Diff_apn := COUNT(GROUP,%Closest%.Diff_apn);
    Count_Diff_sam_pid := COUNT(GROUP,%Closest%.Diff_sam_pid);
    Count_Diff_deed_pid := COUNT(GROUP,%Closest%.Diff_deed_pid);
    Count_Diff_lps_internal_pid := COUNT(GROUP,%Closest%.Diff_lps_internal_pid);
    Count_Diff_nod_source := COUNT(GROUP,%Closest%.Diff_nod_source);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
