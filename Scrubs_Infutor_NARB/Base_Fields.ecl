IMPORT ut,SALT34;
IMPORT Scrubs_Infutor_NARB; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_pastdate8','invalid_record_type','invalid_numeric','invalid_st','invalid_zip5','invalid_alphanum_specials','invalid_phone','invalid_rcid','invalid_sic','invalid_url','invalid_address_type_code','invalid_norm_type','invalid_email');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_pastdate8' => 2,'invalid_record_type' => 3,'invalid_numeric' => 4,'invalid_st' => 5,'invalid_zip5' => 6,'invalid_alphanum_specials' => 7,'invalid_phone' => 8,'invalid_rcid' => 9,'invalid_sic' => 10,'invalid_url' => 11,'invalid_address_type_code' => 12,'invalid_norm_type' => 13,'invalid_email' => 14,0);
 
EXPORT MakeFT_invalid_mandatory(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT34.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_past_yyyymmdd'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('C|H'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT34.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_numeric'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT34.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_verify_state'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT34.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_numeric'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum_specials(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanum_specials(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº'))));
EXPORT InValidMessageFT_invalid_alphanum_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT34.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_verify_optional_phone'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rcid(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rcid(SALT34.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_rcid(s)>0);
EXPORT InValidMessageFT_invalid_rcid(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_rcid'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT34.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_sic(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_sic'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_url(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_url(SALT34.StrType s) := WHICH(~Scrubs_Infutor_NARB.Functions.fn_url(s)>0);
EXPORT InValidMessageFT_invalid_url(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Infutor_NARB.Functions.fn_url'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_type_code(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_type_code(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['F','G','H','P','R','S',' ']);
EXPORT InValidMessageFT_invalid_address_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('F|G|H|P|R|S| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_norm_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_norm_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['B','P','T']);
EXPORT InValidMessageFT_invalid_norm_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('B|P|T'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' 0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'rcid','powid','proxid','seleid','orgid','ultid','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','pid','address_type_code','url','sic1','sic2','sic3','sic4','sic5','incorporation_state','email','contact_title','normcompany_type','clean_company_name','clean_phone','fname','lname','prim_range','p_city_name','v_city_name','st','zip','prep_address_line1','prep_address_line_last');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'rcid' => 0,'powid' => 1,'proxid' => 2,'seleid' => 3,'orgid' => 4,'ultid' => 5,'did' => 6,'dt_first_seen' => 7,'dt_last_seen' => 8,'dt_vendor_first_reported' => 9,'dt_vendor_last_reported' => 10,'process_date' => 11,'record_type' => 12,'pid' => 13,'address_type_code' => 14,'url' => 15,'sic1' => 16,'sic2' => 17,'sic3' => 18,'sic4' => 19,'sic5' => 20,'incorporation_state' => 21,'email' => 22,'contact_title' => 23,'normcompany_type' => 24,'clean_company_name' => 25,'clean_phone' => 26,'fname' => 27,'lname' => 28,'prim_range' => 29,'p_city_name' => 30,'v_city_name' => 31,'st' => 32,'zip' => 33,'prep_address_line1' => 34,'prep_address_line_last' => 35,0);
 
//Individual field level validation
 
EXPORT Make_rcid(SALT34.StrType s0) := MakeFT_invalid_rcid(s0);
EXPORT InValid_rcid(SALT34.StrType s) := InValidFT_invalid_rcid(s);
EXPORT InValidMessage_rcid(UNSIGNED1 wh) := InValidMessageFT_invalid_rcid(wh);
 
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
 
EXPORT Make_process_date(SALT34.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_process_date(SALT34.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_record_type(SALT34.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT34.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_pid(SALT34.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_pid(SALT34.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_pid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_address_type_code(SALT34.StrType s0) := MakeFT_invalid_address_type_code(s0);
EXPORT InValid_address_type_code(SALT34.StrType s) := InValidFT_invalid_address_type_code(s);
EXPORT InValidMessage_address_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_address_type_code(wh);
 
EXPORT Make_url(SALT34.StrType s0) := MakeFT_invalid_url(s0);
EXPORT InValid_url(SALT34.StrType s) := InValidFT_invalid_url(s);
EXPORT InValidMessage_url(UNSIGNED1 wh) := InValidMessageFT_invalid_url(wh);
 
EXPORT Make_sic1(SALT34.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic1(SALT34.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic1(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic2(SALT34.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic2(SALT34.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic3(SALT34.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic3(SALT34.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic3(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic4(SALT34.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic4(SALT34.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic5(SALT34.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic5(SALT34.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic5(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_incorporation_state(SALT34.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_incorporation_state(SALT34.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_incorporation_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_email(SALT34.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT34.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_contact_title(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_contact_title(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_contact_title(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_normcompany_type(SALT34.StrType s0) := MakeFT_invalid_norm_type(s0);
EXPORT InValid_normcompany_type(SALT34.StrType s) := InValidFT_invalid_norm_type(s);
EXPORT InValidMessage_normcompany_type(UNSIGNED1 wh) := InValidMessageFT_invalid_norm_type(wh);
 
EXPORT Make_clean_company_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_company_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_phone(SALT34.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_clean_phone(SALT34.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_fname(SALT34.StrType s0) := MakeFT_invalid_alphanum_specials(s0);
EXPORT InValid_fname(SALT34.StrType s) := InValidFT_invalid_alphanum_specials(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_specials(wh);
 
EXPORT Make_lname(SALT34.StrType s0) := MakeFT_invalid_alphanum_specials(s0);
EXPORT InValid_lname(SALT34.StrType s) := InValidFT_invalid_alphanum_specials(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_specials(wh);
 
EXPORT Make_prim_range(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prim_range(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_p_city_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_p_city_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_v_city_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_v_city_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_st(SALT34.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_st(SALT34.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_zip(SALT34.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zip(SALT34.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_prep_address_line1(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_address_line1(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_address_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_address_line_last(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_address_line_last(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_address_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_Infutor_NARB;
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
    BOOLEAN Diff_rcid;
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
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_pid;
    BOOLEAN Diff_address_type_code;
    BOOLEAN Diff_url;
    BOOLEAN Diff_sic1;
    BOOLEAN Diff_sic2;
    BOOLEAN Diff_sic3;
    BOOLEAN Diff_sic4;
    BOOLEAN Diff_sic5;
    BOOLEAN Diff_incorporation_state;
    BOOLEAN Diff_email;
    BOOLEAN Diff_contact_title;
    BOOLEAN Diff_normcompany_type;
    BOOLEAN Diff_clean_company_name;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_prep_address_line1;
    BOOLEAN Diff_prep_address_line_last;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_rcid := le.rcid <> ri.rcid;
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
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_pid := le.pid <> ri.pid;
    SELF.Diff_address_type_code := le.address_type_code <> ri.address_type_code;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_sic1 := le.sic1 <> ri.sic1;
    SELF.Diff_sic2 := le.sic2 <> ri.sic2;
    SELF.Diff_sic3 := le.sic3 <> ri.sic3;
    SELF.Diff_sic4 := le.sic4 <> ri.sic4;
    SELF.Diff_sic5 := le.sic5 <> ri.sic5;
    SELF.Diff_incorporation_state := le.incorporation_state <> ri.incorporation_state;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_contact_title := le.contact_title <> ri.contact_title;
    SELF.Diff_normcompany_type := le.normcompany_type <> ri.normcompany_type;
    SELF.Diff_clean_company_name := le.clean_company_name <> ri.clean_company_name;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_prep_address_line1 := le.prep_address_line1 <> ri.prep_address_line1;
    SELF.Diff_prep_address_line_last := le.prep_address_line_last <> ri.prep_address_line_last;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_rcid,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_pid,1,0)+ IF( SELF.Diff_address_type_code,1,0)+ IF( SELF.Diff_url,1,0)+ IF( SELF.Diff_sic1,1,0)+ IF( SELF.Diff_sic2,1,0)+ IF( SELF.Diff_sic3,1,0)+ IF( SELF.Diff_sic4,1,0)+ IF( SELF.Diff_sic5,1,0)+ IF( SELF.Diff_incorporation_state,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_contact_title,1,0)+ IF( SELF.Diff_normcompany_type,1,0)+ IF( SELF.Diff_clean_company_name,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_prep_address_line1,1,0)+ IF( SELF.Diff_prep_address_line_last,1,0);
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
    Count_Diff_rcid := COUNT(GROUP,%Closest%.Diff_rcid);
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
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_pid := COUNT(GROUP,%Closest%.Diff_pid);
    Count_Diff_address_type_code := COUNT(GROUP,%Closest%.Diff_address_type_code);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_sic1 := COUNT(GROUP,%Closest%.Diff_sic1);
    Count_Diff_sic2 := COUNT(GROUP,%Closest%.Diff_sic2);
    Count_Diff_sic3 := COUNT(GROUP,%Closest%.Diff_sic3);
    Count_Diff_sic4 := COUNT(GROUP,%Closest%.Diff_sic4);
    Count_Diff_sic5 := COUNT(GROUP,%Closest%.Diff_sic5);
    Count_Diff_incorporation_state := COUNT(GROUP,%Closest%.Diff_incorporation_state);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_contact_title := COUNT(GROUP,%Closest%.Diff_contact_title);
    Count_Diff_normcompany_type := COUNT(GROUP,%Closest%.Diff_normcompany_type);
    Count_Diff_clean_company_name := COUNT(GROUP,%Closest%.Diff_clean_company_name);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_prep_address_line1 := COUNT(GROUP,%Closest%.Diff_prep_address_line1);
    Count_Diff_prep_address_line_last := COUNT(GROUP,%Closest%.Diff_prep_address_line_last);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
