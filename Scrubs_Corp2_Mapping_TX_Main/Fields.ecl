IMPORT ut,SALT34;
IMPORT Scrubs,Scrubs_Corp2_Mapping_TX_Main; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_date','invalid_optional_date','invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_charter','invalid_mandatory','invalid_name_type_cd','invalid_status_cd','invalid_orig_org_structure_cd','invalid_bus_type_cd','invalid_alphablankperiod');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_date' => 1,'invalid_optional_date' => 2,'invalid_corp_key' => 3,'invalid_corp_vendor' => 4,'invalid_state_origin' => 5,'invalid_charter' => 6,'invalid_mandatory' => 7,'invalid_name_type_cd' => 8,'invalid_status_cd' => 9,'invalid_orig_org_structure_cd' => 10,'invalid_bus_type_cd' => 11,'invalid_alphablankperiod' => 12,0);
 
EXPORT MakeFT_invalid_date(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT34.HygieneErrors.NotLength('8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_optional_date(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_optional_date(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_optional_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT34.HygieneErrors.NotLength('0,1,8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_key(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) >= 4 AND LENGTH(TRIM(s)) <= 13));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789-'),SALT34.HygieneErrors.NotLength('4..13'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['48']);
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('48'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_origin(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['TX']);
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('TX'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1 AND LENGTH(TRIM(s)) <= 10));
EXPORT InValidMessageFT_invalid_charter(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.NotLength('1..10'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type_cd(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type_cd(SALT34.StrType s,SALT34.StrType recordOrigin) := WHICH(~Scrubs_Corp2_Mapping_TX_Main.Functions.invalid_name_type_code(s,recordOrigin)>0);
EXPORT InValidMessageFT_invalid_name_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Corp2_Mapping_TX_Main.Functions.invalid_name_type_code'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_status_cd(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_status_cd(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN set_valid_status_cd);
EXPORT InValidMessageFT_invalid_status_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('set_valid_status_cd'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_org_structure_cd(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_org_structure_cd(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN set_valid_structure_cd);
EXPORT InValidMessageFT_invalid_orig_org_structure_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('set_valid_structure_cd'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bus_type_cd(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bus_type_cd(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN set_valid_bus_type_cd);
EXPORT InValidMessageFT_invalid_bus_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('set_valid_bus_type_cd'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphablankperiod(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' .ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphablankperiod(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' .ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphablankperiod(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' .ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_process_date','corp_filing_date','corp_status_date','corp_inc_date','corp_forgn_date','corp_ra_resign_date','corp_merger_date','corp_merger_effective_date','corp_name_reservation_date','corp_name_reservation_expiration_date','corp_name_status_date','corp_key','corp_orig_sos_charter_nbr','corp_vendor','corp_state_origin','corp_inc_state','corp_legal_name','corp_forgn_state_desc','cont_country','corp_agent_country','recordorigin','corp_ln_name_type_cd','corp_status_cd','corp_name_status_cd','corp_orig_org_structure_cd','corp_orig_bus_type_cd');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'dt_vendor_first_reported' => 0,'dt_vendor_last_reported' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'corp_ra_dt_first_seen' => 4,'corp_ra_dt_last_seen' => 5,'corp_process_date' => 6,'corp_filing_date' => 7,'corp_status_date' => 8,'corp_inc_date' => 9,'corp_forgn_date' => 10,'corp_ra_resign_date' => 11,'corp_merger_date' => 12,'corp_merger_effective_date' => 13,'corp_name_reservation_date' => 14,'corp_name_reservation_expiration_date' => 15,'corp_name_status_date' => 16,'corp_key' => 17,'corp_orig_sos_charter_nbr' => 18,'corp_vendor' => 19,'corp_state_origin' => 20,'corp_inc_state' => 21,'corp_legal_name' => 22,'corp_forgn_state_desc' => 23,'cont_country' => 24,'corp_agent_country' => 25,'recordorigin' => 26,'corp_ln_name_type_cd' => 27,'corp_status_cd' => 28,'corp_name_status_cd' => 29,'corp_orig_org_structure_cd' => 30,'corp_orig_bus_type_cd' => 31,0);
 
//Individual field level validation
 
EXPORT Make_dt_vendor_first_reported(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_first_seen(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_first_seen(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_last_seen(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_last_seen(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_ra_dt_first_seen(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_ra_dt_first_seen(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_ra_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_ra_dt_last_seen(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_ra_dt_last_seen(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_ra_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_process_date(SALT34.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_process_date(SALT34.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_filing_date(SALT34.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_filing_date(SALT34.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_status_date(SALT34.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_status_date(SALT34.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_status_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_inc_date(SALT34.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_inc_date(SALT34.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_inc_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_forgn_date(SALT34.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_forgn_date(SALT34.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_forgn_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_ra_resign_date(SALT34.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_ra_resign_date(SALT34.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_ra_resign_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_merger_date(SALT34.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_merger_date(SALT34.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_merger_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_merger_effective_date(SALT34.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_merger_effective_date(SALT34.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_merger_effective_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_name_reservation_date(SALT34.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_name_reservation_date(SALT34.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_name_reservation_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_name_reservation_expiration_date(SALT34.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_name_reservation_expiration_date(SALT34.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_name_reservation_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_name_status_date(SALT34.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_name_status_date(SALT34.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_name_status_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_key(SALT34.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT34.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_orig_sos_charter_nbr(SALT34.StrType s0) := MakeFT_invalid_charter(s0);
EXPORT InValid_corp_orig_sos_charter_nbr(SALT34.StrType s) := InValidFT_invalid_charter(s);
EXPORT InValidMessage_corp_orig_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter(wh);
 
EXPORT Make_corp_vendor(SALT34.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT34.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_state_origin(SALT34.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT34.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_inc_state(SALT34.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_inc_state(SALT34.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_inc_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_legal_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_legal_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corp_forgn_state_desc(SALT34.StrType s0) := MakeFT_invalid_alphablankperiod(s0);
EXPORT InValid_corp_forgn_state_desc(SALT34.StrType s) := InValidFT_invalid_alphablankperiod(s);
EXPORT InValidMessage_corp_forgn_state_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablankperiod(wh);
 
EXPORT Make_cont_country(SALT34.StrType s0) := MakeFT_invalid_alphablankperiod(s0);
EXPORT InValid_cont_country(SALT34.StrType s) := InValidFT_invalid_alphablankperiod(s);
EXPORT InValidMessage_cont_country(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablankperiod(wh);
 
EXPORT Make_corp_agent_country(SALT34.StrType s0) := MakeFT_invalid_alphablankperiod(s0);
EXPORT InValid_corp_agent_country(SALT34.StrType s) := InValidFT_invalid_alphablankperiod(s);
EXPORT InValidMessage_corp_agent_country(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablankperiod(wh);
 
EXPORT Make_recordorigin(SALT34.StrType s0) := s0;
EXPORT InValid_recordorigin(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_recordorigin(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_ln_name_type_cd(SALT34.StrType s0) := MakeFT_invalid_name_type_cd(s0);
EXPORT InValid_corp_ln_name_type_cd(SALT34.StrType s,SALT34.StrType recordOrigin) := InValidFT_invalid_name_type_cd(s,recordOrigin);
EXPORT InValidMessage_corp_ln_name_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type_cd(wh);
 
EXPORT Make_corp_status_cd(SALT34.StrType s0) := MakeFT_invalid_status_cd(s0);
EXPORT InValid_corp_status_cd(SALT34.StrType s) := InValidFT_invalid_status_cd(s);
EXPORT InValidMessage_corp_status_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_status_cd(wh);
 
EXPORT Make_corp_name_status_cd(SALT34.StrType s0) := MakeFT_invalid_status_cd(s0);
EXPORT InValid_corp_name_status_cd(SALT34.StrType s) := InValidFT_invalid_status_cd(s);
EXPORT InValidMessage_corp_name_status_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_status_cd(wh);
 
EXPORT Make_corp_orig_org_structure_cd(SALT34.StrType s0) := MakeFT_invalid_orig_org_structure_cd(s0);
EXPORT InValid_corp_orig_org_structure_cd(SALT34.StrType s) := InValidFT_invalid_orig_org_structure_cd(s);
EXPORT InValidMessage_corp_orig_org_structure_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_org_structure_cd(wh);
 
EXPORT Make_corp_orig_bus_type_cd(SALT34.StrType s0) := MakeFT_invalid_bus_type_cd(s0);
EXPORT InValid_corp_orig_bus_type_cd(SALT34.StrType s) := InValidFT_invalid_bus_type_cd(s);
EXPORT InValidMessage_corp_orig_bus_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_bus_type_cd(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_Corp2_Mapping_TX_Main;
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
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_corp_ra_dt_first_seen;
    BOOLEAN Diff_corp_ra_dt_last_seen;
    BOOLEAN Diff_corp_process_date;
    BOOLEAN Diff_corp_filing_date;
    BOOLEAN Diff_corp_status_date;
    BOOLEAN Diff_corp_inc_date;
    BOOLEAN Diff_corp_forgn_date;
    BOOLEAN Diff_corp_ra_resign_date;
    BOOLEAN Diff_corp_merger_date;
    BOOLEAN Diff_corp_merger_effective_date;
    BOOLEAN Diff_corp_name_reservation_date;
    BOOLEAN Diff_corp_name_reservation_expiration_date;
    BOOLEAN Diff_corp_name_status_date;
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_corp_orig_sos_charter_nbr;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_inc_state;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_corp_forgn_state_desc;
    BOOLEAN Diff_cont_country;
    BOOLEAN Diff_corp_agent_country;
    BOOLEAN Diff_recordorigin;
    BOOLEAN Diff_corp_ln_name_type_cd;
    BOOLEAN Diff_corp_status_cd;
    BOOLEAN Diff_corp_name_status_cd;
    BOOLEAN Diff_corp_orig_org_structure_cd;
    BOOLEAN Diff_corp_orig_bus_type_cd;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_corp_ra_dt_first_seen := le.corp_ra_dt_first_seen <> ri.corp_ra_dt_first_seen;
    SELF.Diff_corp_ra_dt_last_seen := le.corp_ra_dt_last_seen <> ri.corp_ra_dt_last_seen;
    SELF.Diff_corp_process_date := le.corp_process_date <> ri.corp_process_date;
    SELF.Diff_corp_filing_date := le.corp_filing_date <> ri.corp_filing_date;
    SELF.Diff_corp_status_date := le.corp_status_date <> ri.corp_status_date;
    SELF.Diff_corp_inc_date := le.corp_inc_date <> ri.corp_inc_date;
    SELF.Diff_corp_forgn_date := le.corp_forgn_date <> ri.corp_forgn_date;
    SELF.Diff_corp_ra_resign_date := le.corp_ra_resign_date <> ri.corp_ra_resign_date;
    SELF.Diff_corp_merger_date := le.corp_merger_date <> ri.corp_merger_date;
    SELF.Diff_corp_merger_effective_date := le.corp_merger_effective_date <> ri.corp_merger_effective_date;
    SELF.Diff_corp_name_reservation_date := le.corp_name_reservation_date <> ri.corp_name_reservation_date;
    SELF.Diff_corp_name_reservation_expiration_date := le.corp_name_reservation_expiration_date <> ri.corp_name_reservation_expiration_date;
    SELF.Diff_corp_name_status_date := le.corp_name_status_date <> ri.corp_name_status_date;
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_orig_sos_charter_nbr := le.corp_orig_sos_charter_nbr <> ri.corp_orig_sos_charter_nbr;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_inc_state := le.corp_inc_state <> ri.corp_inc_state;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_corp_forgn_state_desc := le.corp_forgn_state_desc <> ri.corp_forgn_state_desc;
    SELF.Diff_cont_country := le.cont_country <> ri.cont_country;
    SELF.Diff_corp_agent_country := le.corp_agent_country <> ri.corp_agent_country;
    SELF.Diff_recordorigin := le.recordorigin <> ri.recordorigin;
    SELF.Diff_corp_ln_name_type_cd := le.corp_ln_name_type_cd <> ri.corp_ln_name_type_cd;
    SELF.Diff_corp_status_cd := le.corp_status_cd <> ri.corp_status_cd;
    SELF.Diff_corp_name_status_cd := le.corp_name_status_cd <> ri.corp_name_status_cd;
    SELF.Diff_corp_orig_org_structure_cd := le.corp_orig_org_structure_cd <> ri.corp_orig_org_structure_cd;
    SELF.Diff_corp_orig_bus_type_cd := le.corp_orig_bus_type_cd <> ri.corp_orig_bus_type_cd;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_first_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_last_seen,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_filing_date,1,0)+ IF( SELF.Diff_corp_status_date,1,0)+ IF( SELF.Diff_corp_inc_date,1,0)+ IF( SELF.Diff_corp_forgn_date,1,0)+ IF( SELF.Diff_corp_ra_resign_date,1,0)+ IF( SELF.Diff_corp_merger_date,1,0)+ IF( SELF.Diff_corp_merger_effective_date,1,0)+ IF( SELF.Diff_corp_name_reservation_date,1,0)+ IF( SELF.Diff_corp_name_reservation_expiration_date,1,0)+ IF( SELF.Diff_corp_name_status_date,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_orig_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_inc_state,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_corp_forgn_state_desc,1,0)+ IF( SELF.Diff_cont_country,1,0)+ IF( SELF.Diff_corp_agent_country,1,0)+ IF( SELF.Diff_recordorigin,1,0)+ IF( SELF.Diff_corp_ln_name_type_cd,1,0)+ IF( SELF.Diff_corp_status_cd,1,0)+ IF( SELF.Diff_corp_name_status_cd,1,0)+ IF( SELF.Diff_corp_orig_org_structure_cd,1,0)+ IF( SELF.Diff_corp_orig_bus_type_cd,1,0);
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
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_corp_ra_dt_first_seen := COUNT(GROUP,%Closest%.Diff_corp_ra_dt_first_seen);
    Count_Diff_corp_ra_dt_last_seen := COUNT(GROUP,%Closest%.Diff_corp_ra_dt_last_seen);
    Count_Diff_corp_process_date := COUNT(GROUP,%Closest%.Diff_corp_process_date);
    Count_Diff_corp_filing_date := COUNT(GROUP,%Closest%.Diff_corp_filing_date);
    Count_Diff_corp_status_date := COUNT(GROUP,%Closest%.Diff_corp_status_date);
    Count_Diff_corp_inc_date := COUNT(GROUP,%Closest%.Diff_corp_inc_date);
    Count_Diff_corp_forgn_date := COUNT(GROUP,%Closest%.Diff_corp_forgn_date);
    Count_Diff_corp_ra_resign_date := COUNT(GROUP,%Closest%.Diff_corp_ra_resign_date);
    Count_Diff_corp_merger_date := COUNT(GROUP,%Closest%.Diff_corp_merger_date);
    Count_Diff_corp_merger_effective_date := COUNT(GROUP,%Closest%.Diff_corp_merger_effective_date);
    Count_Diff_corp_name_reservation_date := COUNT(GROUP,%Closest%.Diff_corp_name_reservation_date);
    Count_Diff_corp_name_reservation_expiration_date := COUNT(GROUP,%Closest%.Diff_corp_name_reservation_expiration_date);
    Count_Diff_corp_name_status_date := COUNT(GROUP,%Closest%.Diff_corp_name_status_date);
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_corp_orig_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_orig_sos_charter_nbr);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_inc_state := COUNT(GROUP,%Closest%.Diff_corp_inc_state);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_corp_forgn_state_desc := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_desc);
    Count_Diff_cont_country := COUNT(GROUP,%Closest%.Diff_cont_country);
    Count_Diff_corp_agent_country := COUNT(GROUP,%Closest%.Diff_corp_agent_country);
    Count_Diff_recordorigin := COUNT(GROUP,%Closest%.Diff_recordorigin);
    Count_Diff_corp_ln_name_type_cd := COUNT(GROUP,%Closest%.Diff_corp_ln_name_type_cd);
    Count_Diff_corp_status_cd := COUNT(GROUP,%Closest%.Diff_corp_status_cd);
    Count_Diff_corp_name_status_cd := COUNT(GROUP,%Closest%.Diff_corp_name_status_cd);
    Count_Diff_corp_orig_org_structure_cd := COUNT(GROUP,%Closest%.Diff_corp_orig_org_structure_cd);
    Count_Diff_corp_orig_bus_type_cd := COUNT(GROUP,%Closest%.Diff_corp_orig_bus_type_cd);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
