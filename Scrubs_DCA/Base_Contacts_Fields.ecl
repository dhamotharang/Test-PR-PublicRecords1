IMPORT ut,SALT34;
IMPORT Scrubs_DCA; // Import modules for FieldTypes attribute definitions
EXPORT Base_Contacts_Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_rid','invalid_numeric','invalid_bdid','invalid_pastdate','invalid_numeric_or_blank','invalid_record_type','invalid_file_type','invalid_phone');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_rid' => 2,'invalid_numeric' => 3,'invalid_bdid' => 4,'invalid_pastdate' => 5,'invalid_numeric_or_blank' => 6,'invalid_record_type' => 7,'invalid_file_type' => 8,'invalid_phone' => 9,0);
 
EXPORT MakeFT_invalid_mandatory(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rid(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rid(SALT34.StrType s) := WHICH(~Scrubs_DCA.Functions.fn_rid(s)>0);
EXPORT InValidMessageFT_invalid_rid(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DCA.Functions.fn_rid'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT34.StrType s) := WHICH(~Scrubs_DCA.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DCA.Functions.fn_numeric'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bdid(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bdid(SALT34.StrType s) := WHICH(~Scrubs_DCA.Functions.fn_bdid(s)>0);
EXPORT InValidMessageFT_invalid_bdid(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DCA.Functions.fn_bdid'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT34.StrType s) := WHICH(~Scrubs_DCA.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DCA.Functions.fn_past_yyyymmdd'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_blank(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_blank(SALT34.StrType s) := WHICH(~Scrubs_DCA.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DCA.Functions.fn_numeric_or_blank'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['4','5']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('4|5'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_file_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['PRIVCO','INT','PRV','PUB']);
EXPORT InValidMessageFT_invalid_file_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('PRIVCO|INT|PRV|PUB'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT34.StrType s) := WHICH(~Scrubs_DCA.Functions.fn_verify_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DCA.Functions.fn_verify_phone'),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'rid','did','bdid','powid','proxid','seleid','orgid','ultid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','physical_rawaid','physical_aceaid','mailing_rawaid','mailing_aceaid','record_type','file_type','lncagid','lncaghid','lncaiid','rawfields_enterprise_num','rawfields_name','rawfields_executive_name','rawfields_executive_title','rawfields_executive_code','clean_name_title','clean_name_lname','physical_address_prim_name','physical_address_p_city_name','physical_address_v_city_name','physical_address_st','physical_address_zip','mailing_address_prim_name','mailing_address_p_city_name','mailing_address_v_city_name','mailing_address_st','mailing_address_zip','clean_phones_phone','clean_phones_fax','clean_phones_telex');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'rid' => 0,'did' => 1,'bdid' => 2,'powid' => 3,'proxid' => 4,'seleid' => 5,'orgid' => 6,'ultid' => 7,'date_first_seen' => 8,'date_last_seen' => 9,'date_vendor_first_reported' => 10,'date_vendor_last_reported' => 11,'physical_rawaid' => 12,'physical_aceaid' => 13,'mailing_rawaid' => 14,'mailing_aceaid' => 15,'record_type' => 16,'file_type' => 17,'lncagid' => 18,'lncaghid' => 19,'lncaiid' => 20,'rawfields_enterprise_num' => 21,'rawfields_name' => 22,'rawfields_executive_name' => 23,'rawfields_executive_title' => 24,'rawfields_executive_code' => 25,'clean_name_title' => 26,'clean_name_lname' => 27,'physical_address_prim_name' => 28,'physical_address_p_city_name' => 29,'physical_address_v_city_name' => 30,'physical_address_st' => 31,'physical_address_zip' => 32,'mailing_address_prim_name' => 33,'mailing_address_p_city_name' => 34,'mailing_address_v_city_name' => 35,'mailing_address_st' => 36,'mailing_address_zip' => 37,'clean_phones_phone' => 38,'clean_phones_fax' => 39,'clean_phones_telex' => 40,0);
 
//Individual field level validation
 
EXPORT Make_rid(SALT34.StrType s0) := MakeFT_invalid_rid(s0);
EXPORT InValid_rid(SALT34.StrType s) := InValidFT_invalid_rid(s);
EXPORT InValidMessage_rid(UNSIGNED1 wh) := InValidMessageFT_invalid_rid(wh);
 
EXPORT Make_did(SALT34.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_did(SALT34.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bdid(SALT34.StrType s0) := MakeFT_invalid_bdid(s0);
EXPORT InValid_bdid(SALT34.StrType s) := InValidFT_invalid_bdid(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_bdid(wh);
 
EXPORT Make_powid(SALT34.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_powid(SALT34.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_proxid(SALT34.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_proxid(SALT34.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_seleid(SALT34.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_seleid(SALT34.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_orgid(SALT34.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_orgid(SALT34.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ultid(SALT34.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ultid(SALT34.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_date_first_seen(SALT34.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_first_seen(SALT34.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_date_last_seen(SALT34.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_last_seen(SALT34.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_date_vendor_first_reported(SALT34.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_vendor_first_reported(SALT34.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_date_vendor_last_reported(SALT34.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_vendor_last_reported(SALT34.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_physical_rawaid(SALT34.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_physical_rawaid(SALT34.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_physical_rawaid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_physical_aceaid(SALT34.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_physical_aceaid(SALT34.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_physical_aceaid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_mailing_rawaid(SALT34.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_mailing_rawaid(SALT34.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_mailing_rawaid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_mailing_aceaid(SALT34.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_mailing_aceaid(SALT34.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_mailing_aceaid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_record_type(SALT34.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT34.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_file_type(SALT34.StrType s0) := MakeFT_invalid_file_type(s0);
EXPORT InValid_file_type(SALT34.StrType s) := InValidFT_invalid_file_type(s);
EXPORT InValidMessage_file_type(UNSIGNED1 wh) := InValidMessageFT_invalid_file_type(wh);
 
EXPORT Make_lncagid(SALT34.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_lncagid(SALT34.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_lncagid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_lncaghid(SALT34.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_lncaghid(SALT34.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_lncaghid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_lncaiid(SALT34.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_lncaiid(SALT34.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_lncaiid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_rawfields_enterprise_num(SALT34.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_rawfields_enterprise_num(SALT34.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_rawfields_enterprise_num(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_rawfields_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_rawfields_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_rawfields_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_rawfields_executive_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_rawfields_executive_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_rawfields_executive_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_rawfields_executive_title(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_rawfields_executive_title(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_rawfields_executive_title(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_rawfields_executive_code(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_rawfields_executive_code(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_rawfields_executive_code(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_name_title(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_name_title(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_name_title(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_name_lname(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_name_lname(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_name_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_physical_address_prim_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_physical_address_prim_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_physical_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_physical_address_p_city_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_physical_address_p_city_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_physical_address_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_physical_address_v_city_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_physical_address_v_city_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_physical_address_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_physical_address_st(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_physical_address_st(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_physical_address_st(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_physical_address_zip(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_physical_address_zip(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_physical_address_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mailing_address_prim_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mailing_address_prim_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mailing_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mailing_address_p_city_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mailing_address_p_city_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mailing_address_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mailing_address_v_city_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mailing_address_v_city_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mailing_address_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mailing_address_st(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mailing_address_st(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mailing_address_st(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mailing_address_zip(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mailing_address_zip(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mailing_address_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_phones_phone(SALT34.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_clean_phones_phone(SALT34.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_clean_phones_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_clean_phones_fax(SALT34.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_clean_phones_fax(SALT34.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_clean_phones_fax(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_clean_phones_telex(SALT34.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_clean_phones_telex(SALT34.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_clean_phones_telex(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_DCA;
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
    BOOLEAN Diff_rid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_date_vendor_first_reported;
    BOOLEAN Diff_date_vendor_last_reported;
    BOOLEAN Diff_physical_rawaid;
    BOOLEAN Diff_physical_aceaid;
    BOOLEAN Diff_mailing_rawaid;
    BOOLEAN Diff_mailing_aceaid;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_file_type;
    BOOLEAN Diff_lncagid;
    BOOLEAN Diff_lncaghid;
    BOOLEAN Diff_lncaiid;
    BOOLEAN Diff_rawfields_enterprise_num;
    BOOLEAN Diff_rawfields_name;
    BOOLEAN Diff_rawfields_executive_name;
    BOOLEAN Diff_rawfields_executive_title;
    BOOLEAN Diff_rawfields_executive_code;
    BOOLEAN Diff_clean_name_title;
    BOOLEAN Diff_clean_name_lname;
    BOOLEAN Diff_physical_address_prim_name;
    BOOLEAN Diff_physical_address_p_city_name;
    BOOLEAN Diff_physical_address_v_city_name;
    BOOLEAN Diff_physical_address_st;
    BOOLEAN Diff_physical_address_zip;
    BOOLEAN Diff_mailing_address_prim_name;
    BOOLEAN Diff_mailing_address_p_city_name;
    BOOLEAN Diff_mailing_address_v_city_name;
    BOOLEAN Diff_mailing_address_st;
    BOOLEAN Diff_mailing_address_zip;
    BOOLEAN Diff_clean_phones_phone;
    BOOLEAN Diff_clean_phones_fax;
    BOOLEAN Diff_clean_phones_telex;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_rid := le.rid <> ri.rid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_date_vendor_first_reported := le.date_vendor_first_reported <> ri.date_vendor_first_reported;
    SELF.Diff_date_vendor_last_reported := le.date_vendor_last_reported <> ri.date_vendor_last_reported;
    SELF.Diff_physical_rawaid := le.physical_rawaid <> ri.physical_rawaid;
    SELF.Diff_physical_aceaid := le.physical_aceaid <> ri.physical_aceaid;
    SELF.Diff_mailing_rawaid := le.mailing_rawaid <> ri.mailing_rawaid;
    SELF.Diff_mailing_aceaid := le.mailing_aceaid <> ri.mailing_aceaid;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_file_type := le.file_type <> ri.file_type;
    SELF.Diff_lncagid := le.lncagid <> ri.lncagid;
    SELF.Diff_lncaghid := le.lncaghid <> ri.lncaghid;
    SELF.Diff_lncaiid := le.lncaiid <> ri.lncaiid;
    SELF.Diff_rawfields_enterprise_num := le.rawfields_enterprise_num <> ri.rawfields_enterprise_num;
    SELF.Diff_rawfields_name := le.rawfields_name <> ri.rawfields_name;
    SELF.Diff_rawfields_executive_name := le.rawfields_executive_name <> ri.rawfields_executive_name;
    SELF.Diff_rawfields_executive_title := le.rawfields_executive_title <> ri.rawfields_executive_title;
    SELF.Diff_rawfields_executive_code := le.rawfields_executive_code <> ri.rawfields_executive_code;
    SELF.Diff_clean_name_title := le.clean_name_title <> ri.clean_name_title;
    SELF.Diff_clean_name_lname := le.clean_name_lname <> ri.clean_name_lname;
    SELF.Diff_physical_address_prim_name := le.physical_address_prim_name <> ri.physical_address_prim_name;
    SELF.Diff_physical_address_p_city_name := le.physical_address_p_city_name <> ri.physical_address_p_city_name;
    SELF.Diff_physical_address_v_city_name := le.physical_address_v_city_name <> ri.physical_address_v_city_name;
    SELF.Diff_physical_address_st := le.physical_address_st <> ri.physical_address_st;
    SELF.Diff_physical_address_zip := le.physical_address_zip <> ri.physical_address_zip;
    SELF.Diff_mailing_address_prim_name := le.mailing_address_prim_name <> ri.mailing_address_prim_name;
    SELF.Diff_mailing_address_p_city_name := le.mailing_address_p_city_name <> ri.mailing_address_p_city_name;
    SELF.Diff_mailing_address_v_city_name := le.mailing_address_v_city_name <> ri.mailing_address_v_city_name;
    SELF.Diff_mailing_address_st := le.mailing_address_st <> ri.mailing_address_st;
    SELF.Diff_mailing_address_zip := le.mailing_address_zip <> ri.mailing_address_zip;
    SELF.Diff_clean_phones_phone := le.clean_phones_phone <> ri.clean_phones_phone;
    SELF.Diff_clean_phones_fax := le.clean_phones_fax <> ri.clean_phones_fax;
    SELF.Diff_clean_phones_telex := le.clean_phones_telex <> ri.clean_phones_telex;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_rid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_date_vendor_first_reported,1,0)+ IF( SELF.Diff_date_vendor_last_reported,1,0)+ IF( SELF.Diff_physical_rawaid,1,0)+ IF( SELF.Diff_physical_aceaid,1,0)+ IF( SELF.Diff_mailing_rawaid,1,0)+ IF( SELF.Diff_mailing_aceaid,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_file_type,1,0)+ IF( SELF.Diff_lncagid,1,0)+ IF( SELF.Diff_lncaghid,1,0)+ IF( SELF.Diff_lncaiid,1,0)+ IF( SELF.Diff_rawfields_enterprise_num,1,0)+ IF( SELF.Diff_rawfields_name,1,0)+ IF( SELF.Diff_rawfields_executive_name,1,0)+ IF( SELF.Diff_rawfields_executive_title,1,0)+ IF( SELF.Diff_rawfields_executive_code,1,0)+ IF( SELF.Diff_clean_name_title,1,0)+ IF( SELF.Diff_clean_name_lname,1,0)+ IF( SELF.Diff_physical_address_prim_name,1,0)+ IF( SELF.Diff_physical_address_p_city_name,1,0)+ IF( SELF.Diff_physical_address_v_city_name,1,0)+ IF( SELF.Diff_physical_address_st,1,0)+ IF( SELF.Diff_physical_address_zip,1,0)+ IF( SELF.Diff_mailing_address_prim_name,1,0)+ IF( SELF.Diff_mailing_address_p_city_name,1,0)+ IF( SELF.Diff_mailing_address_v_city_name,1,0)+ IF( SELF.Diff_mailing_address_st,1,0)+ IF( SELF.Diff_mailing_address_zip,1,0)+ IF( SELF.Diff_clean_phones_phone,1,0)+ IF( SELF.Diff_clean_phones_fax,1,0)+ IF( SELF.Diff_clean_phones_telex,1,0);
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
    Count_Diff_rid := COUNT(GROUP,%Closest%.Diff_rid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_date_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_first_reported);
    Count_Diff_date_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_date_vendor_last_reported);
    Count_Diff_physical_rawaid := COUNT(GROUP,%Closest%.Diff_physical_rawaid);
    Count_Diff_physical_aceaid := COUNT(GROUP,%Closest%.Diff_physical_aceaid);
    Count_Diff_mailing_rawaid := COUNT(GROUP,%Closest%.Diff_mailing_rawaid);
    Count_Diff_mailing_aceaid := COUNT(GROUP,%Closest%.Diff_mailing_aceaid);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_file_type := COUNT(GROUP,%Closest%.Diff_file_type);
    Count_Diff_lncagid := COUNT(GROUP,%Closest%.Diff_lncagid);
    Count_Diff_lncaghid := COUNT(GROUP,%Closest%.Diff_lncaghid);
    Count_Diff_lncaiid := COUNT(GROUP,%Closest%.Diff_lncaiid);
    Count_Diff_rawfields_enterprise_num := COUNT(GROUP,%Closest%.Diff_rawfields_enterprise_num);
    Count_Diff_rawfields_name := COUNT(GROUP,%Closest%.Diff_rawfields_name);
    Count_Diff_rawfields_executive_name := COUNT(GROUP,%Closest%.Diff_rawfields_executive_name);
    Count_Diff_rawfields_executive_title := COUNT(GROUP,%Closest%.Diff_rawfields_executive_title);
    Count_Diff_rawfields_executive_code := COUNT(GROUP,%Closest%.Diff_rawfields_executive_code);
    Count_Diff_clean_name_title := COUNT(GROUP,%Closest%.Diff_clean_name_title);
    Count_Diff_clean_name_lname := COUNT(GROUP,%Closest%.Diff_clean_name_lname);
    Count_Diff_physical_address_prim_name := COUNT(GROUP,%Closest%.Diff_physical_address_prim_name);
    Count_Diff_physical_address_p_city_name := COUNT(GROUP,%Closest%.Diff_physical_address_p_city_name);
    Count_Diff_physical_address_v_city_name := COUNT(GROUP,%Closest%.Diff_physical_address_v_city_name);
    Count_Diff_physical_address_st := COUNT(GROUP,%Closest%.Diff_physical_address_st);
    Count_Diff_physical_address_zip := COUNT(GROUP,%Closest%.Diff_physical_address_zip);
    Count_Diff_mailing_address_prim_name := COUNT(GROUP,%Closest%.Diff_mailing_address_prim_name);
    Count_Diff_mailing_address_p_city_name := COUNT(GROUP,%Closest%.Diff_mailing_address_p_city_name);
    Count_Diff_mailing_address_v_city_name := COUNT(GROUP,%Closest%.Diff_mailing_address_v_city_name);
    Count_Diff_mailing_address_st := COUNT(GROUP,%Closest%.Diff_mailing_address_st);
    Count_Diff_mailing_address_zip := COUNT(GROUP,%Closest%.Diff_mailing_address_zip);
    Count_Diff_clean_phones_phone := COUNT(GROUP,%Closest%.Diff_clean_phones_phone);
    Count_Diff_clean_phones_fax := COUNT(GROUP,%Closest%.Diff_clean_phones_fax);
    Count_Diff_clean_phones_telex := COUNT(GROUP,%Closest%.Diff_clean_phones_telex);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
