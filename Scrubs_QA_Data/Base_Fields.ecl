IMPORT ut,SALT34;
IMPORT Scrubs_QA_Data; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_pastdate8','invalid_date_time','invalid_record_type','invalid_numeric','invalid_numeric_or_blank','invalid_db_match','invalid_home_business','invalid_st','invalid_zip5','invalid_person_type','invalid_alphanum_specials','invalid_phone','invalid_nametype','invalid_src_rid');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_pastdate8' => 2,'invalid_date_time' => 3,'invalid_record_type' => 4,'invalid_numeric' => 5,'invalid_numeric_or_blank' => 6,'invalid_db_match' => 7,'invalid_home_business' => 8,'invalid_st' => 9,'invalid_zip5' => 10,'invalid_person_type' => 11,'invalid_alphanum_specials' => 12,'invalid_phone' => 13,'invalid_nametype' => 14,'invalid_src_rid' => 15,0);
 
EXPORT MakeFT_invalid_mandatory(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT34.StrType s) := WHICH(~Scrubs_QA_Data.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_QA_Data.Functions.fn_past_yyyymmdd'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_time(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date_time(SALT34.StrType s) := WHICH(~Scrubs_QA_Data.Functions.fn_date_time(s)>0);
EXPORT InValidMessageFT_invalid_date_time(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_QA_Data.Functions.fn_date_time'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('C|H'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT34.StrType s) := WHICH(~Scrubs_QA_Data.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_QA_Data.Functions.fn_numeric'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_blank(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_blank(SALT34.StrType s) := WHICH(~Scrubs_QA_Data.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_QA_Data.Functions.fn_numeric_or_blank'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_db_match(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_db_match(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['I','B','L',' ']);
EXPORT InValidMessageFT_invalid_db_match(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('I|B|L| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_business(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_business(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['Y','N',' ']);
EXPORT InValidMessageFT_invalid_home_business(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('Y|N| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT34.StrType s) := WHICH(~Scrubs_QA_Data.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_QA_Data.Functions.fn_verify_state'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT34.StrType s) := WHICH(~Scrubs_QA_Data.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_QA_Data.Functions.fn_numeric'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_person_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_person_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['AC','AP','TC','TP',' ']);
EXPORT InValidMessageFT_invalid_person_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('AC|AP|TC|TP| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum_specials(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanum_specials(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº'))));
EXPORT InValidMessageFT_invalid_alphanum_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT34.StrType s) := WHICH(~Scrubs_QA_Data.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_QA_Data.Functions.fn_verify_optional_phone'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_nametype(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_nametype(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['B',' ']);
EXPORT InValidMessageFT_invalid_nametype(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('B| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_src_rid(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_src_rid(SALT34.StrType s) := WHICH(~Scrubs_QA_Data.Functions.fn_src_rid(s)>0);
EXPORT InValidMessageFT_invalid_src_rid(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_QA_Data.Functions.fn_src_rid'),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawtrans_masteraddressid','rawtrans_date','rawtrans_category','rawaddr_databasematchcode','rawaddr_homebusinessflag','rawaddr_masteraddressid','prep_trans_line1','prep_trans_line_last','prep_addr_line1','prep_addr_line_last','trans_address_prim_name','trans_address_p_city_name','trans_address_v_city_name','trans_address_st','trans_address_zip','addr_address_prim_name','addr_address_p_city_name','addr_address_v_city_name','addr_address_st','addr_address_zip','clean_person_type','clean_person_name_fname','clean_person_name_lname','clean_phone','clean_company','nametype','source_rec_id');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'did' => 5,'dt_first_seen' => 6,'dt_last_seen' => 7,'dt_vendor_first_reported' => 8,'dt_vendor_last_reported' => 9,'record_type' => 10,'rawtrans_masteraddressid' => 11,'rawtrans_date' => 12,'rawtrans_category' => 13,'rawaddr_databasematchcode' => 14,'rawaddr_homebusinessflag' => 15,'rawaddr_masteraddressid' => 16,'prep_trans_line1' => 17,'prep_trans_line_last' => 18,'prep_addr_line1' => 19,'prep_addr_line_last' => 20,'trans_address_prim_name' => 21,'trans_address_p_city_name' => 22,'trans_address_v_city_name' => 23,'trans_address_st' => 24,'trans_address_zip' => 25,'addr_address_prim_name' => 26,'addr_address_p_city_name' => 27,'addr_address_v_city_name' => 28,'addr_address_st' => 29,'addr_address_zip' => 30,'clean_person_type' => 31,'clean_person_name_fname' => 32,'clean_person_name_lname' => 33,'clean_phone' => 34,'clean_company' => 35,'nametype' => 36,'source_rec_id' => 37,0);
 
//Individual field level validation
 
EXPORT Make_powid(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_powid(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_proxid(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_proxid(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_seleid(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_seleid(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orgid(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orgid(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_ultid(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_ultid(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_did(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_did(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_dt_first_seen(SALT34.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_first_seen(SALT34.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_dt_last_seen(SALT34.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_last_seen(SALT34.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT34.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_first_reported(SALT34.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT34.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_dt_vendor_last_reported(SALT34.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_record_type(SALT34.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT34.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_rawtrans_masteraddressid(SALT34.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_rawtrans_masteraddressid(SALT34.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_rawtrans_masteraddressid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_rawtrans_date(SALT34.StrType s0) := MakeFT_invalid_date_time(s0);
EXPORT InValid_rawtrans_date(SALT34.StrType s) := InValidFT_invalid_date_time(s);
EXPORT InValidMessage_rawtrans_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_time(wh);
 
EXPORT Make_rawtrans_category(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_rawtrans_category(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_rawtrans_category(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_rawaddr_databasematchcode(SALT34.StrType s0) := MakeFT_invalid_db_match(s0);
EXPORT InValid_rawaddr_databasematchcode(SALT34.StrType s) := InValidFT_invalid_db_match(s);
EXPORT InValidMessage_rawaddr_databasematchcode(UNSIGNED1 wh) := InValidMessageFT_invalid_db_match(wh);
 
EXPORT Make_rawaddr_homebusinessflag(SALT34.StrType s0) := MakeFT_invalid_home_business(s0);
EXPORT InValid_rawaddr_homebusinessflag(SALT34.StrType s) := InValidFT_invalid_home_business(s);
EXPORT InValidMessage_rawaddr_homebusinessflag(UNSIGNED1 wh) := InValidMessageFT_invalid_home_business(wh);
 
EXPORT Make_rawaddr_masteraddressid(SALT34.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_rawaddr_masteraddressid(SALT34.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_rawaddr_masteraddressid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_prep_trans_line1(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_trans_line1(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_trans_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_trans_line_last(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_trans_line_last(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_trans_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line1(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_trans_address_prim_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_trans_address_prim_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_trans_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_trans_address_p_city_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_trans_address_p_city_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_trans_address_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_trans_address_v_city_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_trans_address_v_city_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_trans_address_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_trans_address_st(SALT34.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_trans_address_st(SALT34.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_trans_address_st(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_trans_address_zip(SALT34.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_trans_address_zip(SALT34.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_trans_address_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_addr_address_prim_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_addr_address_prim_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_addr_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_addr_address_p_city_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_addr_address_p_city_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_addr_address_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_addr_address_v_city_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_addr_address_v_city_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_addr_address_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_addr_address_st(SALT34.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_addr_address_st(SALT34.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_addr_address_st(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_addr_address_zip(SALT34.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_addr_address_zip(SALT34.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_addr_address_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_clean_person_type(SALT34.StrType s0) := MakeFT_invalid_person_type(s0);
EXPORT InValid_clean_person_type(SALT34.StrType s) := InValidFT_invalid_person_type(s);
EXPORT InValidMessage_clean_person_type(UNSIGNED1 wh) := InValidMessageFT_invalid_person_type(wh);
 
EXPORT Make_clean_person_name_fname(SALT34.StrType s0) := MakeFT_invalid_alphanum_specials(s0);
EXPORT InValid_clean_person_name_fname(SALT34.StrType s) := InValidFT_invalid_alphanum_specials(s);
EXPORT InValidMessage_clean_person_name_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_specials(wh);
 
EXPORT Make_clean_person_name_lname(SALT34.StrType s0) := MakeFT_invalid_alphanum_specials(s0);
EXPORT InValid_clean_person_name_lname(SALT34.StrType s) := InValidFT_invalid_alphanum_specials(s);
EXPORT InValidMessage_clean_person_name_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_specials(wh);
 
EXPORT Make_clean_phone(SALT34.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_clean_phone(SALT34.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_clean_company(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_company(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_company(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_nametype(SALT34.StrType s0) := MakeFT_invalid_nametype(s0);
EXPORT InValid_nametype(SALT34.StrType s) := InValidFT_invalid_nametype(s);
EXPORT InValidMessage_nametype(UNSIGNED1 wh) := InValidMessageFT_invalid_nametype(wh);
 
EXPORT Make_source_rec_id(SALT34.StrType s0) := MakeFT_invalid_src_rid(s0);
EXPORT InValid_source_rec_id(SALT34.StrType s) := InValidFT_invalid_src_rid(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_invalid_src_rid(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_QA_Data;
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
    BOOLEAN Diff_powid;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_rawtrans_masteraddressid;
    BOOLEAN Diff_rawtrans_date;
    BOOLEAN Diff_rawtrans_category;
    BOOLEAN Diff_rawaddr_databasematchcode;
    BOOLEAN Diff_rawaddr_homebusinessflag;
    BOOLEAN Diff_rawaddr_masteraddressid;
    BOOLEAN Diff_prep_trans_line1;
    BOOLEAN Diff_prep_trans_line_last;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
    BOOLEAN Diff_trans_address_prim_name;
    BOOLEAN Diff_trans_address_p_city_name;
    BOOLEAN Diff_trans_address_v_city_name;
    BOOLEAN Diff_trans_address_st;
    BOOLEAN Diff_trans_address_zip;
    BOOLEAN Diff_addr_address_prim_name;
    BOOLEAN Diff_addr_address_p_city_name;
    BOOLEAN Diff_addr_address_v_city_name;
    BOOLEAN Diff_addr_address_st;
    BOOLEAN Diff_addr_address_zip;
    BOOLEAN Diff_clean_person_type;
    BOOLEAN Diff_clean_person_name_fname;
    BOOLEAN Diff_clean_person_name_lname;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_clean_company;
    BOOLEAN Diff_nametype;
    BOOLEAN Diff_source_rec_id;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_rawtrans_masteraddressid := le.rawtrans_masteraddressid <> ri.rawtrans_masteraddressid;
    SELF.Diff_rawtrans_date := le.rawtrans_date <> ri.rawtrans_date;
    SELF.Diff_rawtrans_category := le.rawtrans_category <> ri.rawtrans_category;
    SELF.Diff_rawaddr_databasematchcode := le.rawaddr_databasematchcode <> ri.rawaddr_databasematchcode;
    SELF.Diff_rawaddr_homebusinessflag := le.rawaddr_homebusinessflag <> ri.rawaddr_homebusinessflag;
    SELF.Diff_rawaddr_masteraddressid := le.rawaddr_masteraddressid <> ri.rawaddr_masteraddressid;
    SELF.Diff_prep_trans_line1 := le.prep_trans_line1 <> ri.prep_trans_line1;
    SELF.Diff_prep_trans_line_last := le.prep_trans_line_last <> ri.prep_trans_line_last;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
    SELF.Diff_trans_address_prim_name := le.trans_address_prim_name <> ri.trans_address_prim_name;
    SELF.Diff_trans_address_p_city_name := le.trans_address_p_city_name <> ri.trans_address_p_city_name;
    SELF.Diff_trans_address_v_city_name := le.trans_address_v_city_name <> ri.trans_address_v_city_name;
    SELF.Diff_trans_address_st := le.trans_address_st <> ri.trans_address_st;
    SELF.Diff_trans_address_zip := le.trans_address_zip <> ri.trans_address_zip;
    SELF.Diff_addr_address_prim_name := le.addr_address_prim_name <> ri.addr_address_prim_name;
    SELF.Diff_addr_address_p_city_name := le.addr_address_p_city_name <> ri.addr_address_p_city_name;
    SELF.Diff_addr_address_v_city_name := le.addr_address_v_city_name <> ri.addr_address_v_city_name;
    SELF.Diff_addr_address_st := le.addr_address_st <> ri.addr_address_st;
    SELF.Diff_addr_address_zip := le.addr_address_zip <> ri.addr_address_zip;
    SELF.Diff_clean_person_type := le.clean_person_type <> ri.clean_person_type;
    SELF.Diff_clean_person_name_fname := le.clean_person_name_fname <> ri.clean_person_name_fname;
    SELF.Diff_clean_person_name_lname := le.clean_person_name_lname <> ri.clean_person_name_lname;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_clean_company := le.clean_company <> ri.clean_company;
    SELF.Diff_nametype := le.nametype <> ri.nametype;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_rawtrans_masteraddressid,1,0)+ IF( SELF.Diff_rawtrans_date,1,0)+ IF( SELF.Diff_rawtrans_category,1,0)+ IF( SELF.Diff_rawaddr_databasematchcode,1,0)+ IF( SELF.Diff_rawaddr_homebusinessflag,1,0)+ IF( SELF.Diff_rawaddr_masteraddressid,1,0)+ IF( SELF.Diff_prep_trans_line1,1,0)+ IF( SELF.Diff_prep_trans_line_last,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0)+ IF( SELF.Diff_trans_address_prim_name,1,0)+ IF( SELF.Diff_trans_address_p_city_name,1,0)+ IF( SELF.Diff_trans_address_v_city_name,1,0)+ IF( SELF.Diff_trans_address_st,1,0)+ IF( SELF.Diff_trans_address_zip,1,0)+ IF( SELF.Diff_addr_address_prim_name,1,0)+ IF( SELF.Diff_addr_address_p_city_name,1,0)+ IF( SELF.Diff_addr_address_v_city_name,1,0)+ IF( SELF.Diff_addr_address_st,1,0)+ IF( SELF.Diff_addr_address_zip,1,0)+ IF( SELF.Diff_clean_person_type,1,0)+ IF( SELF.Diff_clean_person_name_fname,1,0)+ IF( SELF.Diff_clean_person_name_lname,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_clean_company,1,0)+ IF( SELF.Diff_nametype,1,0)+ IF( SELF.Diff_source_rec_id,1,0);
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
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_rawtrans_masteraddressid := COUNT(GROUP,%Closest%.Diff_rawtrans_masteraddressid);
    Count_Diff_rawtrans_date := COUNT(GROUP,%Closest%.Diff_rawtrans_date);
    Count_Diff_rawtrans_category := COUNT(GROUP,%Closest%.Diff_rawtrans_category);
    Count_Diff_rawaddr_databasematchcode := COUNT(GROUP,%Closest%.Diff_rawaddr_databasematchcode);
    Count_Diff_rawaddr_homebusinessflag := COUNT(GROUP,%Closest%.Diff_rawaddr_homebusinessflag);
    Count_Diff_rawaddr_masteraddressid := COUNT(GROUP,%Closest%.Diff_rawaddr_masteraddressid);
    Count_Diff_prep_trans_line1 := COUNT(GROUP,%Closest%.Diff_prep_trans_line1);
    Count_Diff_prep_trans_line_last := COUNT(GROUP,%Closest%.Diff_prep_trans_line_last);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
    Count_Diff_trans_address_prim_name := COUNT(GROUP,%Closest%.Diff_trans_address_prim_name);
    Count_Diff_trans_address_p_city_name := COUNT(GROUP,%Closest%.Diff_trans_address_p_city_name);
    Count_Diff_trans_address_v_city_name := COUNT(GROUP,%Closest%.Diff_trans_address_v_city_name);
    Count_Diff_trans_address_st := COUNT(GROUP,%Closest%.Diff_trans_address_st);
    Count_Diff_trans_address_zip := COUNT(GROUP,%Closest%.Diff_trans_address_zip);
    Count_Diff_addr_address_prim_name := COUNT(GROUP,%Closest%.Diff_addr_address_prim_name);
    Count_Diff_addr_address_p_city_name := COUNT(GROUP,%Closest%.Diff_addr_address_p_city_name);
    Count_Diff_addr_address_v_city_name := COUNT(GROUP,%Closest%.Diff_addr_address_v_city_name);
    Count_Diff_addr_address_st := COUNT(GROUP,%Closest%.Diff_addr_address_st);
    Count_Diff_addr_address_zip := COUNT(GROUP,%Closest%.Diff_addr_address_zip);
    Count_Diff_clean_person_type := COUNT(GROUP,%Closest%.Diff_clean_person_type);
    Count_Diff_clean_person_name_fname := COUNT(GROUP,%Closest%.Diff_clean_person_name_fname);
    Count_Diff_clean_person_name_lname := COUNT(GROUP,%Closest%.Diff_clean_person_name_lname);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_clean_company := COUNT(GROUP,%Closest%.Diff_clean_company);
    Count_Diff_nametype := COUNT(GROUP,%Closest%.Diff_nametype);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
