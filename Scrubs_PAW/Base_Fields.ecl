IMPORT SALT311;
IMPORT Scrubs,Scrubs_PAW; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 36;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_county','invalid_dead_flag','invalid_direction','invalid_from_hdr','invalid_geo','invalid_glb','invalid_mandatory','invalid_msa','invalid_name','invalid_numeric','invalid_numeric_or_blank','invalid_phone','invalid_phone_flag','invalid_record_type','invalid_reformated_date','invalid_st','invalid_zip5','invalid_zip4');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_county' => 1,'invalid_dead_flag' => 2,'invalid_direction' => 3,'invalid_from_hdr' => 4,'invalid_geo' => 5,'invalid_glb' => 6,'invalid_mandatory' => 7,'invalid_msa' => 8,'invalid_name' => 9,'invalid_numeric' => 10,'invalid_numeric_or_blank' => 11,'invalid_phone' => 12,'invalid_phone_flag' => 13,'invalid_record_type' => 14,'invalid_reformated_date' => 15,'invalid_st' => 16,'invalid_zip5' => 17,'invalid_zip4' => 18,0);
 
EXPORT MakeFT_invalid_county(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_county(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric_optional(s,3)>0);
EXPORT InValidMessageFT_invalid_county(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dead_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dead_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1']);
EXPORT InValidMessageFT_invalid_dead_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_direction(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['E','N','S','W','NE','NW','SE','SW','']);
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('E|N|S|W|NE|NW|SE|SW|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_from_hdr(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_from_hdr(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N']);
EXPORT InValidMessageFT_invalid_from_hdr(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_geo_coord(s)>0);
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_geo_coord'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_glb(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_glb(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N']);
EXPORT InValidMessageFT_invalid_glb(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_msa(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_msa(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric_optional(s,4)>0);
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(~Scrubs_PAW.Functions.fn_invalid_name(s)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_PAW.Functions.fn_invalid_name'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_blank(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric_optional(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_PAW.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_PAW.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y','N']);
EXPORT InValidMessageFT_invalid_phone_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y|N'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|H'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_reformated_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_reformated_date(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_valid_GeneralDate(s)>0);
EXPORT InValidMessageFT_invalid_reformated_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_valid_GeneralDate'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_Valid_StateAbbrev'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_valid_zip(s)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_valid_zip'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT311.StrType s) := WHICH(~Scrubs_PAW.Functions.fn_verify_zip4(s)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_PAW.Functions.fn_verify_zip4'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'contact_id','company_phone','company_name','active_phone_flag','source_count','source','record_type','record_sid','global_sid','GLB','lname','fname','dt_last_seen','dt_first_seen','RawAid','zip','state','bdid','zip4','geo_long','geo_lat','county','company_zip','company_state','Company_RawAid','company_zip4','msa','did','ssn','phone','predir','company_predir','company_postdir','postdir','from_hdr','dead_flag');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'contact_id','company_phone','company_name','active_phone_flag','source_count','source','record_type','record_sid','global_sid','GLB','lname','fname','dt_last_seen','dt_first_seen','RawAid','zip','state','bdid','zip4','geo_long','geo_lat','county','company_zip','company_state','Company_RawAid','company_zip4','msa','did','ssn','phone','predir','company_predir','company_postdir','postdir','from_hdr','dead_flag');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'contact_id' => 0,'company_phone' => 1,'company_name' => 2,'active_phone_flag' => 3,'source_count' => 4,'source' => 5,'record_type' => 6,'record_sid' => 7,'global_sid' => 8,'GLB' => 9,'lname' => 10,'fname' => 11,'dt_last_seen' => 12,'dt_first_seen' => 13,'RawAid' => 14,'zip' => 15,'state' => 16,'bdid' => 17,'zip4' => 18,'geo_long' => 19,'geo_lat' => 20,'county' => 21,'company_zip' => 22,'company_state' => 23,'Company_RawAid' => 24,'company_zip4' => 25,'msa' => 26,'did' => 27,'ssn' => 28,'phone' => 29,'predir' => 30,'company_predir' => 31,'company_postdir' => 32,'postdir' => 33,'from_hdr' => 34,'dead_flag' => 35,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['LENGTHS'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_contact_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_contact_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_contact_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_company_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_company_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_active_phone_flag(SALT311.StrType s0) := MakeFT_invalid_phone_flag(s0);
EXPORT InValid_active_phone_flag(SALT311.StrType s) := InValidFT_invalid_phone_flag(s);
EXPORT InValidMessage_active_phone_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_phone_flag(wh);
 
EXPORT Make_source_count(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_source_count(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_source_count(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_source(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_source(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_record_sid(SALT311.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_record_sid(SALT311.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_record_sid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_global_sid(SALT311.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_global_sid(SALT311.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_global_sid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_GLB(SALT311.StrType s0) := MakeFT_invalid_glb(s0);
EXPORT InValid_GLB(SALT311.StrType s) := InValidFT_invalid_glb(s);
EXPORT InValidMessage_GLB(UNSIGNED1 wh) := InValidMessageFT_invalid_glb(wh);
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_invalid_reformated_date(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_invalid_reformated_date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_reformated_date(wh);
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_invalid_reformated_date(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_invalid_reformated_date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_reformated_date(wh);
 
EXPORT Make_RawAid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_RawAid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_RawAid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_bdid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_bdid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_geo_long(SALT311.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_long(SALT311.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_geo_lat(SALT311.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_lat(SALT311.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_invalid_county(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_invalid_county(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_county(wh);
 
EXPORT Make_company_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_company_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_company_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_company_state(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_company_state(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_company_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_Company_RawAid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_Company_RawAid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_Company_RawAid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_company_zip4(SALT311.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_company_zip4(SALT311.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_company_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_msa(SALT311.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_msa(SALT311.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_did(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_ssn(SALT311.StrType s0) := MakeFT_invalid_numeric_or_blank(s0);
EXPORT InValid_ssn(SALT311.StrType s) := InValidFT_invalid_numeric_or_blank(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_blank(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_predir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_predir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_company_predir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_company_predir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_company_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_company_postdir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_company_postdir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_company_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_postdir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_postdir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_from_hdr(SALT311.StrType s0) := MakeFT_invalid_from_hdr(s0);
EXPORT InValid_from_hdr(SALT311.StrType s) := InValidFT_invalid_from_hdr(s);
EXPORT InValidMessage_from_hdr(UNSIGNED1 wh) := InValidMessageFT_invalid_from_hdr(wh);
 
EXPORT Make_dead_flag(SALT311.StrType s0) := MakeFT_invalid_dead_flag(s0);
EXPORT InValid_dead_flag(SALT311.StrType s) := InValidFT_invalid_dead_flag(s);
EXPORT InValidMessage_dead_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_dead_flag(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_PAW;
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
    BOOLEAN Diff_contact_id;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_active_phone_flag;
    BOOLEAN Diff_source_count;
    BOOLEAN Diff_source;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_record_sid;
    BOOLEAN Diff_global_sid;
    BOOLEAN Diff_GLB;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_RawAid;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_state;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_county;
    BOOLEAN Diff_company_zip;
    BOOLEAN Diff_company_state;
    BOOLEAN Diff_Company_RawAid;
    BOOLEAN Diff_company_zip4;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_did;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_company_predir;
    BOOLEAN Diff_company_postdir;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_from_hdr;
    BOOLEAN Diff_dead_flag;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_contact_id := le.contact_id <> ri.contact_id;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_active_phone_flag := le.active_phone_flag <> ri.active_phone_flag;
    SELF.Diff_source_count := le.source_count <> ri.source_count;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_record_sid := le.record_sid <> ri.record_sid;
    SELF.Diff_global_sid := le.global_sid <> ri.global_sid;
    SELF.Diff_GLB := le.GLB <> ri.GLB;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_RawAid := le.RawAid <> ri.RawAid;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_company_zip := le.company_zip <> ri.company_zip;
    SELF.Diff_company_state := le.company_state <> ri.company_state;
    SELF.Diff_Company_RawAid := le.Company_RawAid <> ri.Company_RawAid;
    SELF.Diff_company_zip4 := le.company_zip4 <> ri.company_zip4;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_company_predir := le.company_predir <> ri.company_predir;
    SELF.Diff_company_postdir := le.company_postdir <> ri.company_postdir;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_from_hdr := le.from_hdr <> ri.from_hdr;
    SELF.Diff_dead_flag := le.dead_flag <> ri.dead_flag;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_contact_id,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_active_phone_flag,1,0)+ IF( SELF.Diff_source_count,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_record_sid,1,0)+ IF( SELF.Diff_global_sid,1,0)+ IF( SELF.Diff_GLB,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_RawAid,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_company_zip,1,0)+ IF( SELF.Diff_company_state,1,0)+ IF( SELF.Diff_Company_RawAid,1,0)+ IF( SELF.Diff_company_zip4,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_company_predir,1,0)+ IF( SELF.Diff_company_postdir,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_from_hdr,1,0)+ IF( SELF.Diff_dead_flag,1,0);
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
    Count_Diff_contact_id := COUNT(GROUP,%Closest%.Diff_contact_id);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_active_phone_flag := COUNT(GROUP,%Closest%.Diff_active_phone_flag);
    Count_Diff_source_count := COUNT(GROUP,%Closest%.Diff_source_count);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_record_sid := COUNT(GROUP,%Closest%.Diff_record_sid);
    Count_Diff_global_sid := COUNT(GROUP,%Closest%.Diff_global_sid);
    Count_Diff_GLB := COUNT(GROUP,%Closest%.Diff_GLB);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_RawAid := COUNT(GROUP,%Closest%.Diff_RawAid);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_company_zip := COUNT(GROUP,%Closest%.Diff_company_zip);
    Count_Diff_company_state := COUNT(GROUP,%Closest%.Diff_company_state);
    Count_Diff_Company_RawAid := COUNT(GROUP,%Closest%.Diff_Company_RawAid);
    Count_Diff_company_zip4 := COUNT(GROUP,%Closest%.Diff_company_zip4);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_company_predir := COUNT(GROUP,%Closest%.Diff_company_predir);
    Count_Diff_company_postdir := COUNT(GROUP,%Closest%.Diff_company_postdir);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_from_hdr := COUNT(GROUP,%Closest%.Diff_from_hdr);
    Count_Diff_dead_flag := COUNT(GROUP,%Closest%.Diff_dead_flag);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
