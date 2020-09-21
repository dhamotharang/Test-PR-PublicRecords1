IMPORT SALT311;
IMPORT Scrubs,Scrubs_Oshair; // Import modules for FieldTypes attribute definitions
EXPORT Inspection_Raw_Fields := MODULE
 
EXPORT NumFields := 35;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','invalid_numeric_blank','invalid_state','invalid_state_flag','invalid_owner_type','invalid_adv_notice','invalid_safety_hlth','invalid_insp_type','invalid_insp_scope','invalid_why_no_insp','invalid_union_status','invalid_X_blank','invalid_host_est_key','invalid_date_dashes','invalid_year','invalid_mandatory','invalid_sic','invalid_naics');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'invalid_numeric_blank' => 2,'invalid_state' => 3,'invalid_state_flag' => 4,'invalid_owner_type' => 5,'invalid_adv_notice' => 6,'invalid_safety_hlth' => 7,'invalid_insp_type' => 8,'invalid_insp_scope' => 9,'invalid_why_no_insp' => 10,'invalid_union_status' => 11,'invalid_X_blank' => 12,'invalid_host_est_key' => 13,'invalid_date_dashes' => 14,'invalid_year' => 15,'invalid_mandatory' => 16,'invalid_sic' => 17,'invalid_naics' => 18,0);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_blank(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_numeric_or_blank'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_flag(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_state_flag(s)>0);
EXPORT InValidMessageFT_invalid_state_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_state_flag'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_owner_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_owner_type(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_owner_type(s)>0);
EXPORT InValidMessageFT_invalid_owner_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_owner_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_adv_notice(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_adv_notice(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_adv_notice(s)>0);
EXPORT InValidMessageFT_invalid_adv_notice(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_adv_notice'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_safety_hlth(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_safety_hlth(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_safety_hlth(s)>0);
EXPORT InValidMessageFT_invalid_safety_hlth(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_safety_hlth'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_insp_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_insp_type(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_insp_type(s)>0);
EXPORT InValidMessageFT_invalid_insp_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_insp_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_insp_scope(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_insp_scope(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_insp_scope(s)>0);
EXPORT InValidMessageFT_invalid_insp_scope(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_insp_scope'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_why_no_insp(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_why_no_insp(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_why_no_insp(s)>0);
EXPORT InValidMessageFT_invalid_why_no_insp(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_why_no_insp'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_union_status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_union_status(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_union_status(s)>0);
EXPORT InValidMessageFT_invalid_union_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_union_status'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_X_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_X_blank(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_X_blank(s)>0);
EXPORT InValidMessageFT_invalid_X_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_X_blank'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_host_est_key(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_host_est_key(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_host_est_key(s)>0);
EXPORT InValidMessageFT_invalid_host_est_key(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_host_est_key'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_dashes(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date_dashes(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_date_time(s,'FUTURE')>0);
EXPORT InValidMessageFT_invalid_date_dashes(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_date_time'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_year(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_year(SALT311.StrType s) := WHICH(~Scrubs_Oshair.Functions.fn_dt_yy(s)>0);
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Oshair.Functions.fn_dt_yy'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_valid_SicCode(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_valid_SicCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_naics(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_naics(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_validate_NAICSCode(s)>0);
EXPORT InValidMessageFT_invalid_naics(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_validate_NAICSCode'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'activity_nr','reporting_id','state_flag','site_state','site_zip','owner_type','owner_code','adv_notice','safety_hlth','sic_code','naics_code','insp_type','insp_scope','why_no_insp','union_status','safety_manuf','safety_const','safety_marit','health_manuf','health_const','health_marit','migrant','mail_state','mail_zip','host_est_key','nr_in_estab','open_date','case_mod_date','close_conf_date','close_case_date','open_year','case_mod_year','close_conf_year','close_case_year','estab_name');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'activity_nr','reporting_id','state_flag','site_state','site_zip','owner_type','owner_code','adv_notice','safety_hlth','sic_code','naics_code','insp_type','insp_scope','why_no_insp','union_status','safety_manuf','safety_const','safety_marit','health_manuf','health_const','health_marit','migrant','mail_state','mail_zip','host_est_key','nr_in_estab','open_date','case_mod_date','close_conf_date','close_case_date','open_year','case_mod_year','close_conf_year','close_case_year','estab_name');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'activity_nr' => 0,'reporting_id' => 1,'state_flag' => 2,'site_state' => 3,'site_zip' => 4,'owner_type' => 5,'owner_code' => 6,'adv_notice' => 7,'safety_hlth' => 8,'sic_code' => 9,'naics_code' => 10,'insp_type' => 11,'insp_scope' => 12,'why_no_insp' => 13,'union_status' => 14,'safety_manuf' => 15,'safety_const' => 16,'safety_marit' => 17,'health_manuf' => 18,'health_const' => 19,'health_marit' => 20,'migrant' => 21,'mail_state' => 22,'mail_zip' => 23,'host_est_key' => 24,'nr_in_estab' => 25,'open_date' => 26,'case_mod_date' => 27,'close_conf_date' => 28,'close_case_date' => 29,'open_year' => 30,'case_mod_year' => 31,'close_conf_year' => 32,'close_case_year' => 33,'estab_name' => 34,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_activity_nr(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_activity_nr(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_activity_nr(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_reporting_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_reporting_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_reporting_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_state_flag(SALT311.StrType s0) := MakeFT_invalid_state_flag(s0);
EXPORT InValid_state_flag(SALT311.StrType s) := InValidFT_invalid_state_flag(s);
EXPORT InValidMessage_state_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_state_flag(wh);
 
EXPORT Make_site_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_site_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_site_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_site_zip(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_site_zip(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_site_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_owner_type(SALT311.StrType s0) := MakeFT_invalid_owner_type(s0);
EXPORT InValid_owner_type(SALT311.StrType s) := InValidFT_invalid_owner_type(s);
EXPORT InValidMessage_owner_type(UNSIGNED1 wh) := InValidMessageFT_invalid_owner_type(wh);
 
EXPORT Make_owner_code(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_owner_code(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_owner_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_adv_notice(SALT311.StrType s0) := MakeFT_invalid_adv_notice(s0);
EXPORT InValid_adv_notice(SALT311.StrType s) := InValidFT_invalid_adv_notice(s);
EXPORT InValidMessage_adv_notice(UNSIGNED1 wh) := InValidMessageFT_invalid_adv_notice(wh);
 
EXPORT Make_safety_hlth(SALT311.StrType s0) := MakeFT_invalid_safety_hlth(s0);
EXPORT InValid_safety_hlth(SALT311.StrType s) := InValidFT_invalid_safety_hlth(s);
EXPORT InValidMessage_safety_hlth(UNSIGNED1 wh) := InValidMessageFT_invalid_safety_hlth(wh);
 
EXPORT Make_sic_code(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic_code(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_naics_code(SALT311.StrType s0) := MakeFT_invalid_naics(s0);
EXPORT InValid_naics_code(SALT311.StrType s) := InValidFT_invalid_naics(s);
EXPORT InValidMessage_naics_code(UNSIGNED1 wh) := InValidMessageFT_invalid_naics(wh);
 
EXPORT Make_insp_type(SALT311.StrType s0) := MakeFT_invalid_insp_type(s0);
EXPORT InValid_insp_type(SALT311.StrType s) := InValidFT_invalid_insp_type(s);
EXPORT InValidMessage_insp_type(UNSIGNED1 wh) := InValidMessageFT_invalid_insp_type(wh);
 
EXPORT Make_insp_scope(SALT311.StrType s0) := MakeFT_invalid_insp_scope(s0);
EXPORT InValid_insp_scope(SALT311.StrType s) := InValidFT_invalid_insp_scope(s);
EXPORT InValidMessage_insp_scope(UNSIGNED1 wh) := InValidMessageFT_invalid_insp_scope(wh);
 
EXPORT Make_why_no_insp(SALT311.StrType s0) := MakeFT_invalid_why_no_insp(s0);
EXPORT InValid_why_no_insp(SALT311.StrType s) := InValidFT_invalid_why_no_insp(s);
EXPORT InValidMessage_why_no_insp(UNSIGNED1 wh) := InValidMessageFT_invalid_why_no_insp(wh);
 
EXPORT Make_union_status(SALT311.StrType s0) := MakeFT_invalid_union_status(s0);
EXPORT InValid_union_status(SALT311.StrType s) := InValidFT_invalid_union_status(s);
EXPORT InValidMessage_union_status(UNSIGNED1 wh) := InValidMessageFT_invalid_union_status(wh);
 
EXPORT Make_safety_manuf(SALT311.StrType s0) := MakeFT_invalid_X_blank(s0);
EXPORT InValid_safety_manuf(SALT311.StrType s) := InValidFT_invalid_X_blank(s);
EXPORT InValidMessage_safety_manuf(UNSIGNED1 wh) := InValidMessageFT_invalid_X_blank(wh);
 
EXPORT Make_safety_const(SALT311.StrType s0) := MakeFT_invalid_X_blank(s0);
EXPORT InValid_safety_const(SALT311.StrType s) := InValidFT_invalid_X_blank(s);
EXPORT InValidMessage_safety_const(UNSIGNED1 wh) := InValidMessageFT_invalid_X_blank(wh);
 
EXPORT Make_safety_marit(SALT311.StrType s0) := MakeFT_invalid_X_blank(s0);
EXPORT InValid_safety_marit(SALT311.StrType s) := InValidFT_invalid_X_blank(s);
EXPORT InValidMessage_safety_marit(UNSIGNED1 wh) := InValidMessageFT_invalid_X_blank(wh);
 
EXPORT Make_health_manuf(SALT311.StrType s0) := MakeFT_invalid_X_blank(s0);
EXPORT InValid_health_manuf(SALT311.StrType s) := InValidFT_invalid_X_blank(s);
EXPORT InValidMessage_health_manuf(UNSIGNED1 wh) := InValidMessageFT_invalid_X_blank(wh);
 
EXPORT Make_health_const(SALT311.StrType s0) := MakeFT_invalid_X_blank(s0);
EXPORT InValid_health_const(SALT311.StrType s) := InValidFT_invalid_X_blank(s);
EXPORT InValidMessage_health_const(UNSIGNED1 wh) := InValidMessageFT_invalid_X_blank(wh);
 
EXPORT Make_health_marit(SALT311.StrType s0) := MakeFT_invalid_X_blank(s0);
EXPORT InValid_health_marit(SALT311.StrType s) := InValidFT_invalid_X_blank(s);
EXPORT InValidMessage_health_marit(UNSIGNED1 wh) := InValidMessageFT_invalid_X_blank(wh);
 
EXPORT Make_migrant(SALT311.StrType s0) := MakeFT_invalid_X_blank(s0);
EXPORT InValid_migrant(SALT311.StrType s) := InValidFT_invalid_X_blank(s);
EXPORT InValidMessage_migrant(UNSIGNED1 wh) := InValidMessageFT_invalid_X_blank(wh);
 
EXPORT Make_mail_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_mail_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_mail_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_mail_zip(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_mail_zip(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_mail_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_host_est_key(SALT311.StrType s0) := MakeFT_invalid_host_est_key(s0);
EXPORT InValid_host_est_key(SALT311.StrType s) := InValidFT_invalid_host_est_key(s);
EXPORT InValidMessage_host_est_key(UNSIGNED1 wh) := InValidMessageFT_invalid_host_est_key(wh);
 
EXPORT Make_nr_in_estab(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_nr_in_estab(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_nr_in_estab(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_open_date(SALT311.StrType s0) := MakeFT_invalid_date_dashes(s0);
EXPORT InValid_open_date(SALT311.StrType s) := InValidFT_invalid_date_dashes(s);
EXPORT InValidMessage_open_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_dashes(wh);
 
EXPORT Make_case_mod_date(SALT311.StrType s0) := MakeFT_invalid_date_dashes(s0);
EXPORT InValid_case_mod_date(SALT311.StrType s) := InValidFT_invalid_date_dashes(s);
EXPORT InValidMessage_case_mod_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_dashes(wh);
 
EXPORT Make_close_conf_date(SALT311.StrType s0) := MakeFT_invalid_date_dashes(s0);
EXPORT InValid_close_conf_date(SALT311.StrType s) := InValidFT_invalid_date_dashes(s);
EXPORT InValidMessage_close_conf_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_dashes(wh);
 
EXPORT Make_close_case_date(SALT311.StrType s0) := MakeFT_invalid_date_dashes(s0);
EXPORT InValid_close_case_date(SALT311.StrType s) := InValidFT_invalid_date_dashes(s);
EXPORT InValidMessage_close_case_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_dashes(wh);
 
EXPORT Make_open_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_open_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_open_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_case_mod_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_case_mod_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_case_mod_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_close_conf_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_close_conf_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_close_conf_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_close_case_year(SALT311.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_close_case_year(SALT311.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_close_case_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_estab_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_estab_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_estab_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_OSHAIR;
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
    BOOLEAN Diff_activity_nr;
    BOOLEAN Diff_reporting_id;
    BOOLEAN Diff_state_flag;
    BOOLEAN Diff_site_state;
    BOOLEAN Diff_site_zip;
    BOOLEAN Diff_owner_type;
    BOOLEAN Diff_owner_code;
    BOOLEAN Diff_adv_notice;
    BOOLEAN Diff_safety_hlth;
    BOOLEAN Diff_sic_code;
    BOOLEAN Diff_naics_code;
    BOOLEAN Diff_insp_type;
    BOOLEAN Diff_insp_scope;
    BOOLEAN Diff_why_no_insp;
    BOOLEAN Diff_union_status;
    BOOLEAN Diff_safety_manuf;
    BOOLEAN Diff_safety_const;
    BOOLEAN Diff_safety_marit;
    BOOLEAN Diff_health_manuf;
    BOOLEAN Diff_health_const;
    BOOLEAN Diff_health_marit;
    BOOLEAN Diff_migrant;
    BOOLEAN Diff_mail_state;
    BOOLEAN Diff_mail_zip;
    BOOLEAN Diff_host_est_key;
    BOOLEAN Diff_nr_in_estab;
    BOOLEAN Diff_open_date;
    BOOLEAN Diff_case_mod_date;
    BOOLEAN Diff_close_conf_date;
    BOOLEAN Diff_close_case_date;
    BOOLEAN Diff_open_year;
    BOOLEAN Diff_case_mod_year;
    BOOLEAN Diff_close_conf_year;
    BOOLEAN Diff_close_case_year;
    BOOLEAN Diff_estab_name;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_activity_nr := le.activity_nr <> ri.activity_nr;
    SELF.Diff_reporting_id := le.reporting_id <> ri.reporting_id;
    SELF.Diff_state_flag := le.state_flag <> ri.state_flag;
    SELF.Diff_site_state := le.site_state <> ri.site_state;
    SELF.Diff_site_zip := le.site_zip <> ri.site_zip;
    SELF.Diff_owner_type := le.owner_type <> ri.owner_type;
    SELF.Diff_owner_code := le.owner_code <> ri.owner_code;
    SELF.Diff_adv_notice := le.adv_notice <> ri.adv_notice;
    SELF.Diff_safety_hlth := le.safety_hlth <> ri.safety_hlth;
    SELF.Diff_sic_code := le.sic_code <> ri.sic_code;
    SELF.Diff_naics_code := le.naics_code <> ri.naics_code;
    SELF.Diff_insp_type := le.insp_type <> ri.insp_type;
    SELF.Diff_insp_scope := le.insp_scope <> ri.insp_scope;
    SELF.Diff_why_no_insp := le.why_no_insp <> ri.why_no_insp;
    SELF.Diff_union_status := le.union_status <> ri.union_status;
    SELF.Diff_safety_manuf := le.safety_manuf <> ri.safety_manuf;
    SELF.Diff_safety_const := le.safety_const <> ri.safety_const;
    SELF.Diff_safety_marit := le.safety_marit <> ri.safety_marit;
    SELF.Diff_health_manuf := le.health_manuf <> ri.health_manuf;
    SELF.Diff_health_const := le.health_const <> ri.health_const;
    SELF.Diff_health_marit := le.health_marit <> ri.health_marit;
    SELF.Diff_migrant := le.migrant <> ri.migrant;
    SELF.Diff_mail_state := le.mail_state <> ri.mail_state;
    SELF.Diff_mail_zip := le.mail_zip <> ri.mail_zip;
    SELF.Diff_host_est_key := le.host_est_key <> ri.host_est_key;
    SELF.Diff_nr_in_estab := le.nr_in_estab <> ri.nr_in_estab;
    SELF.Diff_open_date := le.open_date <> ri.open_date;
    SELF.Diff_case_mod_date := le.case_mod_date <> ri.case_mod_date;
    SELF.Diff_close_conf_date := le.close_conf_date <> ri.close_conf_date;
    SELF.Diff_close_case_date := le.close_case_date <> ri.close_case_date;
    SELF.Diff_open_year := le.open_year <> ri.open_year;
    SELF.Diff_case_mod_year := le.case_mod_year <> ri.case_mod_year;
    SELF.Diff_close_conf_year := le.close_conf_year <> ri.close_conf_year;
    SELF.Diff_close_case_year := le.close_case_year <> ri.close_case_year;
    SELF.Diff_estab_name := le.estab_name <> ri.estab_name;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_activity_nr,1,0)+ IF( SELF.Diff_reporting_id,1,0)+ IF( SELF.Diff_state_flag,1,0)+ IF( SELF.Diff_site_state,1,0)+ IF( SELF.Diff_site_zip,1,0)+ IF( SELF.Diff_owner_type,1,0)+ IF( SELF.Diff_owner_code,1,0)+ IF( SELF.Diff_adv_notice,1,0)+ IF( SELF.Diff_safety_hlth,1,0)+ IF( SELF.Diff_sic_code,1,0)+ IF( SELF.Diff_naics_code,1,0)+ IF( SELF.Diff_insp_type,1,0)+ IF( SELF.Diff_insp_scope,1,0)+ IF( SELF.Diff_why_no_insp,1,0)+ IF( SELF.Diff_union_status,1,0)+ IF( SELF.Diff_safety_manuf,1,0)+ IF( SELF.Diff_safety_const,1,0)+ IF( SELF.Diff_safety_marit,1,0)+ IF( SELF.Diff_health_manuf,1,0)+ IF( SELF.Diff_health_const,1,0)+ IF( SELF.Diff_health_marit,1,0)+ IF( SELF.Diff_migrant,1,0)+ IF( SELF.Diff_mail_state,1,0)+ IF( SELF.Diff_mail_zip,1,0)+ IF( SELF.Diff_host_est_key,1,0)+ IF( SELF.Diff_nr_in_estab,1,0)+ IF( SELF.Diff_open_date,1,0)+ IF( SELF.Diff_case_mod_date,1,0)+ IF( SELF.Diff_close_conf_date,1,0)+ IF( SELF.Diff_close_case_date,1,0)+ IF( SELF.Diff_open_year,1,0)+ IF( SELF.Diff_case_mod_year,1,0)+ IF( SELF.Diff_close_conf_year,1,0)+ IF( SELF.Diff_close_case_year,1,0)+ IF( SELF.Diff_estab_name,1,0);
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
    Count_Diff_activity_nr := COUNT(GROUP,%Closest%.Diff_activity_nr);
    Count_Diff_reporting_id := COUNT(GROUP,%Closest%.Diff_reporting_id);
    Count_Diff_state_flag := COUNT(GROUP,%Closest%.Diff_state_flag);
    Count_Diff_site_state := COUNT(GROUP,%Closest%.Diff_site_state);
    Count_Diff_site_zip := COUNT(GROUP,%Closest%.Diff_site_zip);
    Count_Diff_owner_type := COUNT(GROUP,%Closest%.Diff_owner_type);
    Count_Diff_owner_code := COUNT(GROUP,%Closest%.Diff_owner_code);
    Count_Diff_adv_notice := COUNT(GROUP,%Closest%.Diff_adv_notice);
    Count_Diff_safety_hlth := COUNT(GROUP,%Closest%.Diff_safety_hlth);
    Count_Diff_sic_code := COUNT(GROUP,%Closest%.Diff_sic_code);
    Count_Diff_naics_code := COUNT(GROUP,%Closest%.Diff_naics_code);
    Count_Diff_insp_type := COUNT(GROUP,%Closest%.Diff_insp_type);
    Count_Diff_insp_scope := COUNT(GROUP,%Closest%.Diff_insp_scope);
    Count_Diff_why_no_insp := COUNT(GROUP,%Closest%.Diff_why_no_insp);
    Count_Diff_union_status := COUNT(GROUP,%Closest%.Diff_union_status);
    Count_Diff_safety_manuf := COUNT(GROUP,%Closest%.Diff_safety_manuf);
    Count_Diff_safety_const := COUNT(GROUP,%Closest%.Diff_safety_const);
    Count_Diff_safety_marit := COUNT(GROUP,%Closest%.Diff_safety_marit);
    Count_Diff_health_manuf := COUNT(GROUP,%Closest%.Diff_health_manuf);
    Count_Diff_health_const := COUNT(GROUP,%Closest%.Diff_health_const);
    Count_Diff_health_marit := COUNT(GROUP,%Closest%.Diff_health_marit);
    Count_Diff_migrant := COUNT(GROUP,%Closest%.Diff_migrant);
    Count_Diff_mail_state := COUNT(GROUP,%Closest%.Diff_mail_state);
    Count_Diff_mail_zip := COUNT(GROUP,%Closest%.Diff_mail_zip);
    Count_Diff_host_est_key := COUNT(GROUP,%Closest%.Diff_host_est_key);
    Count_Diff_nr_in_estab := COUNT(GROUP,%Closest%.Diff_nr_in_estab);
    Count_Diff_open_date := COUNT(GROUP,%Closest%.Diff_open_date);
    Count_Diff_case_mod_date := COUNT(GROUP,%Closest%.Diff_case_mod_date);
    Count_Diff_close_conf_date := COUNT(GROUP,%Closest%.Diff_close_conf_date);
    Count_Diff_close_case_date := COUNT(GROUP,%Closest%.Diff_close_case_date);
    Count_Diff_open_year := COUNT(GROUP,%Closest%.Diff_open_year);
    Count_Diff_case_mod_year := COUNT(GROUP,%Closest%.Diff_case_mod_year);
    Count_Diff_close_conf_year := COUNT(GROUP,%Closest%.Diff_close_conf_year);
    Count_Diff_close_case_year := COUNT(GROUP,%Closest%.Diff_close_case_year);
    Count_Diff_estab_name := COUNT(GROUP,%Closest%.Diff_estab_name);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
