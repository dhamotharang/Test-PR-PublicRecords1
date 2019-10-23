IMPORT SALT39;
EXPORT Fields := MODULE
 
EXPORT NumFields := 40;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','ALPHA','NAME','NUMBER','WORDBAG');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'DEFAULT' => 1,'ALPHA' => 2,'NAME' => 3,'NUMBER' => 4,'WORDBAG' => 5,0);
 
EXPORT MakeFT_DEFAULT(SALT39.StrType s0) := FUNCTION
  s1 := if ( SALT39.StringFind('"\'',s0[1],1)>0 and SALT39.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT39.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT39.StringFind('"\'',s[1],1)<>0 and SALT39.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotLeft,SALT39.HygieneErrors.Inquotes('"\''),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_ALPHA(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ALPHA(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_NAME(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NAME(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'))));
EXPORT InValidMessageFT_NAME(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_NUMBER(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_WORDBAG(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_WORDBAG(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$ '),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orig_transaction_id','orig_function_name','orig_company_id','orig_login_id','orig_billing_code','orig_record_count','orig_fcra_purpose','orig_glb_purpose','orig_dppa_purpose','orig_ip_address','orig_reference_code','orig_login_history_id','orig_date_added','orig_price','orig_pricing_error_code','orig_free','orig_business_name','orig_name_first','orig_name_last','orig_ssn','orig_case_number','orig_address','orig_city','orig_state','orig_zip','orig_dob','orig_phone','orig_tmsid','orig_unique_id','orig_out_tmsid','orig_out_business_name','orig_out_first_name','orig_out_last_name','orig_out_ssn','orig_out_address','orig_out_city','orig_out_state','orig_out_zip','orig_out_case_number','orig_transaction_type');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'orig_transaction_id','orig_function_name','orig_company_id','orig_login_id','orig_billing_code','orig_record_count','orig_fcra_purpose','orig_glb_purpose','orig_dppa_purpose','orig_ip_address','orig_reference_code','orig_login_history_id','orig_date_added','orig_price','orig_pricing_error_code','orig_free','orig_business_name','orig_name_first','orig_name_last','orig_ssn','orig_case_number','orig_address','orig_city','orig_state','orig_zip','orig_dob','orig_phone','orig_tmsid','orig_unique_id','orig_out_tmsid','orig_out_business_name','orig_out_first_name','orig_out_last_name','orig_out_ssn','orig_out_address','orig_out_city','orig_out_state','orig_out_zip','orig_out_case_number','orig_transaction_type');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'orig_transaction_id' => 0,'orig_function_name' => 1,'orig_company_id' => 2,'orig_login_id' => 3,'orig_billing_code' => 4,'orig_record_count' => 5,'orig_fcra_purpose' => 6,'orig_glb_purpose' => 7,'orig_dppa_purpose' => 8,'orig_ip_address' => 9,'orig_reference_code' => 10,'orig_login_history_id' => 11,'orig_date_added' => 12,'orig_price' => 13,'orig_pricing_error_code' => 14,'orig_free' => 15,'orig_business_name' => 16,'orig_name_first' => 17,'orig_name_last' => 18,'orig_ssn' => 19,'orig_case_number' => 20,'orig_address' => 21,'orig_city' => 22,'orig_state' => 23,'orig_zip' => 24,'orig_dob' => 25,'orig_phone' => 26,'orig_tmsid' => 27,'orig_unique_id' => 28,'orig_out_tmsid' => 29,'orig_out_business_name' => 30,'orig_out_first_name' => 31,'orig_out_last_name' => 32,'orig_out_ssn' => 33,'orig_out_address' => 34,'orig_out_city' => 35,'orig_out_state' => 36,'orig_out_zip' => 37,'orig_out_case_number' => 38,'orig_transaction_type' => 39,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],['LEFTTRIM','QUOTES'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_orig_transaction_id(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_transaction_id(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_transaction_id(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_function_name(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_function_name(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_function_name(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_company_id(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_company_id(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_company_id(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_login_id(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_login_id(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_login_id(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_billing_code(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_billing_code(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_billing_code(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_record_count(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_record_count(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_record_count(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_fcra_purpose(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_fcra_purpose(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_fcra_purpose(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_glb_purpose(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_glb_purpose(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_glb_purpose(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_dppa_purpose(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_dppa_purpose(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_dppa_purpose(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_ip_address(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_ip_address(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_ip_address(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_reference_code(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_reference_code(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_reference_code(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_login_history_id(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_login_history_id(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_login_history_id(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_date_added(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_date_added(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_date_added(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_price(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_price(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_price(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_pricing_error_code(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_pricing_error_code(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_pricing_error_code(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_free(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_free(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_free(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_business_name(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_business_name(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_business_name(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_name_first(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_name_first(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_name_first(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_name_last(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_name_last(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_name_last(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_ssn(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_ssn(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_ssn(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_case_number(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_case_number(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_case_number(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_address(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_address(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_address(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_city(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_city(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_state(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_state(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_zip(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_zip(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_dob(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_dob(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_phone(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_phone(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_phone(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_tmsid(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_tmsid(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_tmsid(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_unique_id(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_unique_id(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_unique_id(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_out_tmsid(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_out_tmsid(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_out_tmsid(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_out_business_name(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_out_business_name(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_out_business_name(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_out_first_name(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_out_first_name(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_out_first_name(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_out_last_name(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_out_last_name(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_out_last_name(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_out_ssn(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_out_ssn(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_out_ssn(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_out_address(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_out_address(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_out_address(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_out_city(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_out_city(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_out_city(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_out_state(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_out_state(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_out_state(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_out_zip(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_out_zip(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_out_zip(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_out_case_number(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_out_case_number(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_out_case_number(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
EXPORT Make_orig_transaction_type(SALT39.StrType s0) := MakeFT_DEFAULT(s0);
EXPORT InValid_orig_transaction_type(SALT39.StrType s) := InValidFT_DEFAULT(s);
EXPORT InValidMessage_orig_transaction_type(UNSIGNED1 wh) := InValidMessageFT_DEFAULT(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Inql_Nfcra_Banko;
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
    BOOLEAN Diff_orig_transaction_id;
    BOOLEAN Diff_orig_function_name;
    BOOLEAN Diff_orig_company_id;
    BOOLEAN Diff_orig_login_id;
    BOOLEAN Diff_orig_billing_code;
    BOOLEAN Diff_orig_record_count;
    BOOLEAN Diff_orig_fcra_purpose;
    BOOLEAN Diff_orig_glb_purpose;
    BOOLEAN Diff_orig_dppa_purpose;
    BOOLEAN Diff_orig_ip_address;
    BOOLEAN Diff_orig_reference_code;
    BOOLEAN Diff_orig_login_history_id;
    BOOLEAN Diff_orig_date_added;
    BOOLEAN Diff_orig_price;
    BOOLEAN Diff_orig_pricing_error_code;
    BOOLEAN Diff_orig_free;
    BOOLEAN Diff_orig_business_name;
    BOOLEAN Diff_orig_name_first;
    BOOLEAN Diff_orig_name_last;
    BOOLEAN Diff_orig_ssn;
    BOOLEAN Diff_orig_case_number;
    BOOLEAN Diff_orig_address;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_phone;
    BOOLEAN Diff_orig_tmsid;
    BOOLEAN Diff_orig_unique_id;
    BOOLEAN Diff_orig_out_tmsid;
    BOOLEAN Diff_orig_out_business_name;
    BOOLEAN Diff_orig_out_first_name;
    BOOLEAN Diff_orig_out_last_name;
    BOOLEAN Diff_orig_out_ssn;
    BOOLEAN Diff_orig_out_address;
    BOOLEAN Diff_orig_out_city;
    BOOLEAN Diff_orig_out_state;
    BOOLEAN Diff_orig_out_zip;
    BOOLEAN Diff_orig_out_case_number;
    BOOLEAN Diff_orig_transaction_type;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orig_transaction_id := le.orig_transaction_id <> ri.orig_transaction_id;
    SELF.Diff_orig_function_name := le.orig_function_name <> ri.orig_function_name;
    SELF.Diff_orig_company_id := le.orig_company_id <> ri.orig_company_id;
    SELF.Diff_orig_login_id := le.orig_login_id <> ri.orig_login_id;
    SELF.Diff_orig_billing_code := le.orig_billing_code <> ri.orig_billing_code;
    SELF.Diff_orig_record_count := le.orig_record_count <> ri.orig_record_count;
    SELF.Diff_orig_fcra_purpose := le.orig_fcra_purpose <> ri.orig_fcra_purpose;
    SELF.Diff_orig_glb_purpose := le.orig_glb_purpose <> ri.orig_glb_purpose;
    SELF.Diff_orig_dppa_purpose := le.orig_dppa_purpose <> ri.orig_dppa_purpose;
    SELF.Diff_orig_ip_address := le.orig_ip_address <> ri.orig_ip_address;
    SELF.Diff_orig_reference_code := le.orig_reference_code <> ri.orig_reference_code;
    SELF.Diff_orig_login_history_id := le.orig_login_history_id <> ri.orig_login_history_id;
    SELF.Diff_orig_date_added := le.orig_date_added <> ri.orig_date_added;
    SELF.Diff_orig_price := le.orig_price <> ri.orig_price;
    SELF.Diff_orig_pricing_error_code := le.orig_pricing_error_code <> ri.orig_pricing_error_code;
    SELF.Diff_orig_free := le.orig_free <> ri.orig_free;
    SELF.Diff_orig_business_name := le.orig_business_name <> ri.orig_business_name;
    SELF.Diff_orig_name_first := le.orig_name_first <> ri.orig_name_first;
    SELF.Diff_orig_name_last := le.orig_name_last <> ri.orig_name_last;
    SELF.Diff_orig_ssn := le.orig_ssn <> ri.orig_ssn;
    SELF.Diff_orig_case_number := le.orig_case_number <> ri.orig_case_number;
    SELF.Diff_orig_address := le.orig_address <> ri.orig_address;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_phone := le.orig_phone <> ri.orig_phone;
    SELF.Diff_orig_tmsid := le.orig_tmsid <> ri.orig_tmsid;
    SELF.Diff_orig_unique_id := le.orig_unique_id <> ri.orig_unique_id;
    SELF.Diff_orig_out_tmsid := le.orig_out_tmsid <> ri.orig_out_tmsid;
    SELF.Diff_orig_out_business_name := le.orig_out_business_name <> ri.orig_out_business_name;
    SELF.Diff_orig_out_first_name := le.orig_out_first_name <> ri.orig_out_first_name;
    SELF.Diff_orig_out_last_name := le.orig_out_last_name <> ri.orig_out_last_name;
    SELF.Diff_orig_out_ssn := le.orig_out_ssn <> ri.orig_out_ssn;
    SELF.Diff_orig_out_address := le.orig_out_address <> ri.orig_out_address;
    SELF.Diff_orig_out_city := le.orig_out_city <> ri.orig_out_city;
    SELF.Diff_orig_out_state := le.orig_out_state <> ri.orig_out_state;
    SELF.Diff_orig_out_zip := le.orig_out_zip <> ri.orig_out_zip;
    SELF.Diff_orig_out_case_number := le.orig_out_case_number <> ri.orig_out_case_number;
    SELF.Diff_orig_transaction_type := le.orig_transaction_type <> ri.orig_transaction_type;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orig_transaction_id,1,0)+ IF( SELF.Diff_orig_function_name,1,0)+ IF( SELF.Diff_orig_company_id,1,0)+ IF( SELF.Diff_orig_login_id,1,0)+ IF( SELF.Diff_orig_billing_code,1,0)+ IF( SELF.Diff_orig_record_count,1,0)+ IF( SELF.Diff_orig_fcra_purpose,1,0)+ IF( SELF.Diff_orig_glb_purpose,1,0)+ IF( SELF.Diff_orig_dppa_purpose,1,0)+ IF( SELF.Diff_orig_ip_address,1,0)+ IF( SELF.Diff_orig_reference_code,1,0)+ IF( SELF.Diff_orig_login_history_id,1,0)+ IF( SELF.Diff_orig_date_added,1,0)+ IF( SELF.Diff_orig_price,1,0)+ IF( SELF.Diff_orig_pricing_error_code,1,0)+ IF( SELF.Diff_orig_free,1,0)+ IF( SELF.Diff_orig_business_name,1,0)+ IF( SELF.Diff_orig_name_first,1,0)+ IF( SELF.Diff_orig_name_last,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_orig_case_number,1,0)+ IF( SELF.Diff_orig_address,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_phone,1,0)+ IF( SELF.Diff_orig_tmsid,1,0)+ IF( SELF.Diff_orig_unique_id,1,0)+ IF( SELF.Diff_orig_out_tmsid,1,0)+ IF( SELF.Diff_orig_out_business_name,1,0)+ IF( SELF.Diff_orig_out_first_name,1,0)+ IF( SELF.Diff_orig_out_last_name,1,0)+ IF( SELF.Diff_orig_out_ssn,1,0)+ IF( SELF.Diff_orig_out_address,1,0)+ IF( SELF.Diff_orig_out_city,1,0)+ IF( SELF.Diff_orig_out_state,1,0)+ IF( SELF.Diff_orig_out_zip,1,0)+ IF( SELF.Diff_orig_out_case_number,1,0)+ IF( SELF.Diff_orig_transaction_type,1,0);
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
    Count_Diff_orig_transaction_id := COUNT(GROUP,%Closest%.Diff_orig_transaction_id);
    Count_Diff_orig_function_name := COUNT(GROUP,%Closest%.Diff_orig_function_name);
    Count_Diff_orig_company_id := COUNT(GROUP,%Closest%.Diff_orig_company_id);
    Count_Diff_orig_login_id := COUNT(GROUP,%Closest%.Diff_orig_login_id);
    Count_Diff_orig_billing_code := COUNT(GROUP,%Closest%.Diff_orig_billing_code);
    Count_Diff_orig_record_count := COUNT(GROUP,%Closest%.Diff_orig_record_count);
    Count_Diff_orig_fcra_purpose := COUNT(GROUP,%Closest%.Diff_orig_fcra_purpose);
    Count_Diff_orig_glb_purpose := COUNT(GROUP,%Closest%.Diff_orig_glb_purpose);
    Count_Diff_orig_dppa_purpose := COUNT(GROUP,%Closest%.Diff_orig_dppa_purpose);
    Count_Diff_orig_ip_address := COUNT(GROUP,%Closest%.Diff_orig_ip_address);
    Count_Diff_orig_reference_code := COUNT(GROUP,%Closest%.Diff_orig_reference_code);
    Count_Diff_orig_login_history_id := COUNT(GROUP,%Closest%.Diff_orig_login_history_id);
    Count_Diff_orig_date_added := COUNT(GROUP,%Closest%.Diff_orig_date_added);
    Count_Diff_orig_price := COUNT(GROUP,%Closest%.Diff_orig_price);
    Count_Diff_orig_pricing_error_code := COUNT(GROUP,%Closest%.Diff_orig_pricing_error_code);
    Count_Diff_orig_free := COUNT(GROUP,%Closest%.Diff_orig_free);
    Count_Diff_orig_business_name := COUNT(GROUP,%Closest%.Diff_orig_business_name);
    Count_Diff_orig_name_first := COUNT(GROUP,%Closest%.Diff_orig_name_first);
    Count_Diff_orig_name_last := COUNT(GROUP,%Closest%.Diff_orig_name_last);
    Count_Diff_orig_ssn := COUNT(GROUP,%Closest%.Diff_orig_ssn);
    Count_Diff_orig_case_number := COUNT(GROUP,%Closest%.Diff_orig_case_number);
    Count_Diff_orig_address := COUNT(GROUP,%Closest%.Diff_orig_address);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_phone := COUNT(GROUP,%Closest%.Diff_orig_phone);
    Count_Diff_orig_tmsid := COUNT(GROUP,%Closest%.Diff_orig_tmsid);
    Count_Diff_orig_unique_id := COUNT(GROUP,%Closest%.Diff_orig_unique_id);
    Count_Diff_orig_out_tmsid := COUNT(GROUP,%Closest%.Diff_orig_out_tmsid);
    Count_Diff_orig_out_business_name := COUNT(GROUP,%Closest%.Diff_orig_out_business_name);
    Count_Diff_orig_out_first_name := COUNT(GROUP,%Closest%.Diff_orig_out_first_name);
    Count_Diff_orig_out_last_name := COUNT(GROUP,%Closest%.Diff_orig_out_last_name);
    Count_Diff_orig_out_ssn := COUNT(GROUP,%Closest%.Diff_orig_out_ssn);
    Count_Diff_orig_out_address := COUNT(GROUP,%Closest%.Diff_orig_out_address);
    Count_Diff_orig_out_city := COUNT(GROUP,%Closest%.Diff_orig_out_city);
    Count_Diff_orig_out_state := COUNT(GROUP,%Closest%.Diff_orig_out_state);
    Count_Diff_orig_out_zip := COUNT(GROUP,%Closest%.Diff_orig_out_zip);
    Count_Diff_orig_out_case_number := COUNT(GROUP,%Closest%.Diff_orig_out_case_number);
    Count_Diff_orig_transaction_type := COUNT(GROUP,%Closest%.Diff_orig_transaction_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
