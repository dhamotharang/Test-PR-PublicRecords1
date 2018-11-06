IMPORT SALT38,STD;
IMPORT Scrubs_Credit_Unions; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 34;
  EXPORT NumRulesFromFieldType := 34;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 34;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_Credit_Unions)
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 raw_aid_Invalid;
    UNSIGNED1 ace_aid_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 charter_Invalid;
    UNSIGNED1 cycle_date_Invalid;
    UNSIGNED1 join_number_Invalid;
    UNSIGNED1 siteid_Invalid;
    UNSIGNED1 cu_name_Invalid;
    UNSIGNED1 sitetypename_Invalid;
    UNSIGNED1 mainoffice_Invalid;
    UNSIGNED1 addrtype_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 statename_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 assets_Invalid;
    UNSIGNED1 loans_Invalid;
    UNSIGNED1 networthratio_Invalid;
    UNSIGNED1 perc_sharegrowth_Invalid;
    UNSIGNED1 perc_loangrowth_Invalid;
    UNSIGNED1 loantoassetsratio_Invalid;
    UNSIGNED1 investassetsratio_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_Credit_Unions)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Layout_Credit_Unions) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.powid_Invalid := Base_Fields.InValid_powid((SALT38.StrType)le.powid);
    SELF.proxid_Invalid := Base_Fields.InValid_proxid((SALT38.StrType)le.proxid);
    SELF.seleid_Invalid := Base_Fields.InValid_seleid((SALT38.StrType)le.seleid);
    SELF.orgid_Invalid := Base_Fields.InValid_orgid((SALT38.StrType)le.orgid);
    SELF.ultid_Invalid := Base_Fields.InValid_ultid((SALT38.StrType)le.ultid);
    SELF.source_rec_id_Invalid := Base_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id);
    SELF.bdid_Invalid := Base_Fields.InValid_bdid((SALT38.StrType)le.bdid);
    SELF.record_type_Invalid := Base_Fields.InValid_record_type((SALT38.StrType)le.record_type);
    SELF.raw_aid_Invalid := Base_Fields.InValid_raw_aid((SALT38.StrType)le.raw_aid);
    SELF.ace_aid_Invalid := Base_Fields.InValid_ace_aid((SALT38.StrType)le.ace_aid);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported);
    SELF.charter_Invalid := Base_Fields.InValid_charter((SALT38.StrType)le.charter);
    SELF.cycle_date_Invalid := Base_Fields.InValid_cycle_date((SALT38.StrType)le.cycle_date);
    SELF.join_number_Invalid := Base_Fields.InValid_join_number((SALT38.StrType)le.join_number);
    SELF.siteid_Invalid := Base_Fields.InValid_siteid((SALT38.StrType)le.siteid);
    SELF.cu_name_Invalid := Base_Fields.InValid_cu_name((SALT38.StrType)le.cu_name);
    SELF.sitetypename_Invalid := Base_Fields.InValid_sitetypename((SALT38.StrType)le.sitetypename);
    SELF.mainoffice_Invalid := Base_Fields.InValid_mainoffice((SALT38.StrType)le.mainoffice);
    SELF.addrtype_Invalid := Base_Fields.InValid_addrtype((SALT38.StrType)le.addrtype);
    SELF.state_Invalid := Base_Fields.InValid_state((SALT38.StrType)le.state);
    SELF.statename_Invalid := Base_Fields.InValid_statename((SALT38.StrType)le.statename);
    SELF.zip_code_Invalid := Base_Fields.InValid_zip_code((SALT38.StrType)le.zip_code);
    SELF.country_Invalid := Base_Fields.InValid_country((SALT38.StrType)le.country);
    SELF.phone_Invalid := Base_Fields.InValid_phone((SALT38.StrType)le.phone);
    SELF.assets_Invalid := Base_Fields.InValid_assets((SALT38.StrType)le.assets);
    SELF.loans_Invalid := Base_Fields.InValid_loans((SALT38.StrType)le.loans);
    SELF.networthratio_Invalid := Base_Fields.InValid_networthratio((SALT38.StrType)le.networthratio);
    SELF.perc_sharegrowth_Invalid := Base_Fields.InValid_perc_sharegrowth((SALT38.StrType)le.perc_sharegrowth);
    SELF.perc_loangrowth_Invalid := Base_Fields.InValid_perc_loangrowth((SALT38.StrType)le.perc_loangrowth);
    SELF.loantoassetsratio_Invalid := Base_Fields.InValid_loantoassetsratio((SALT38.StrType)le.loantoassetsratio);
    SELF.investassetsratio_Invalid := Base_Fields.InValid_investassetsratio((SALT38.StrType)le.investassetsratio);
    SELF.prep_addr_line1_Invalid := Base_Fields.InValid_prep_addr_line1((SALT38.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Base_Fields.InValid_prep_addr_line_last((SALT38.StrType)le.prep_addr_line_last);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_Credit_Unions);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.powid_Invalid << 0 ) + ( le.proxid_Invalid << 1 ) + ( le.seleid_Invalid << 2 ) + ( le.orgid_Invalid << 3 ) + ( le.ultid_Invalid << 4 ) + ( le.source_rec_id_Invalid << 5 ) + ( le.bdid_Invalid << 6 ) + ( le.record_type_Invalid << 7 ) + ( le.raw_aid_Invalid << 8 ) + ( le.ace_aid_Invalid << 9 ) + ( le.dt_vendor_first_reported_Invalid << 10 ) + ( le.dt_vendor_last_reported_Invalid << 11 ) + ( le.charter_Invalid << 12 ) + ( le.cycle_date_Invalid << 13 ) + ( le.join_number_Invalid << 14 ) + ( le.siteid_Invalid << 15 ) + ( le.cu_name_Invalid << 16 ) + ( le.sitetypename_Invalid << 17 ) + ( le.mainoffice_Invalid << 18 ) + ( le.addrtype_Invalid << 19 ) + ( le.state_Invalid << 20 ) + ( le.statename_Invalid << 21 ) + ( le.zip_code_Invalid << 22 ) + ( le.country_Invalid << 23 ) + ( le.phone_Invalid << 24 ) + ( le.assets_Invalid << 25 ) + ( le.loans_Invalid << 26 ) + ( le.networthratio_Invalid << 27 ) + ( le.perc_sharegrowth_Invalid << 28 ) + ( le.perc_loangrowth_Invalid << 29 ) + ( le.loantoassetsratio_Invalid << 30 ) + ( le.investassetsratio_Invalid << 31 ) + ( le.prep_addr_line1_Invalid << 32 ) + ( le.prep_addr_line_last_Invalid << 33 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_Credit_Unions);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.powid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.raw_aid_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.ace_aid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.charter_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.cycle_date_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.join_number_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.siteid_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.cu_name_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.sitetypename_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.mainoffice_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.addrtype_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.statename_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.country_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.assets_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.loans_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.networthratio_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.perc_sharegrowth_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.perc_loangrowth_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.loantoassetsratio_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.investassetsratio_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    powid_CUSTOM_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    proxid_CUSTOM_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    seleid_CUSTOM_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    orgid_CUSTOM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    ultid_CUSTOM_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    source_rec_id_CUSTOM_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    raw_aid_CUSTOM_ErrorCount := COUNT(GROUP,h.raw_aid_Invalid=1);
    ace_aid_CUSTOM_ErrorCount := COUNT(GROUP,h.ace_aid_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    charter_CUSTOM_ErrorCount := COUNT(GROUP,h.charter_Invalid=1);
    cycle_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cycle_date_Invalid=1);
    join_number_CUSTOM_ErrorCount := COUNT(GROUP,h.join_number_Invalid=1);
    siteid_CUSTOM_ErrorCount := COUNT(GROUP,h.siteid_Invalid=1);
    cu_name_LENGTHS_ErrorCount := COUNT(GROUP,h.cu_name_Invalid=1);
    sitetypename_ENUM_ErrorCount := COUNT(GROUP,h.sitetypename_Invalid=1);
    mainoffice_ENUM_ErrorCount := COUNT(GROUP,h.mainoffice_Invalid=1);
    addrtype_ENUM_ErrorCount := COUNT(GROUP,h.addrtype_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    statename_CUSTOM_ErrorCount := COUNT(GROUP,h.statename_Invalid=1);
    zip_code_ALLOW_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    country_CUSTOM_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    assets_ALLOW_ErrorCount := COUNT(GROUP,h.assets_Invalid=1);
    loans_ALLOW_ErrorCount := COUNT(GROUP,h.loans_Invalid=1);
    networthratio_ALLOW_ErrorCount := COUNT(GROUP,h.networthratio_Invalid=1);
    perc_sharegrowth_ALLOW_ErrorCount := COUNT(GROUP,h.perc_sharegrowth_Invalid=1);
    perc_loangrowth_ALLOW_ErrorCount := COUNT(GROUP,h.perc_loangrowth_Invalid=1);
    loantoassetsratio_ALLOW_ErrorCount := COUNT(GROUP,h.loantoassetsratio_Invalid=1);
    investassetsratio_ALLOW_ErrorCount := COUNT(GROUP,h.investassetsratio_Invalid=1);
    prep_addr_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr_line_last_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.powid_Invalid > 0 OR h.proxid_Invalid > 0 OR h.seleid_Invalid > 0 OR h.orgid_Invalid > 0 OR h.ultid_Invalid > 0 OR h.source_rec_id_Invalid > 0 OR h.bdid_Invalid > 0 OR h.record_type_Invalid > 0 OR h.raw_aid_Invalid > 0 OR h.ace_aid_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.charter_Invalid > 0 OR h.cycle_date_Invalid > 0 OR h.join_number_Invalid > 0 OR h.siteid_Invalid > 0 OR h.cu_name_Invalid > 0 OR h.sitetypename_Invalid > 0 OR h.mainoffice_Invalid > 0 OR h.addrtype_Invalid > 0 OR h.state_Invalid > 0 OR h.statename_Invalid > 0 OR h.zip_code_Invalid > 0 OR h.country_Invalid > 0 OR h.phone_Invalid > 0 OR h.assets_Invalid > 0 OR h.loans_Invalid > 0 OR h.networthratio_Invalid > 0 OR h.perc_sharegrowth_Invalid > 0 OR h.perc_loangrowth_Invalid > 0 OR h.loantoassetsratio_Invalid > 0 OR h.investassetsratio_Invalid > 0 OR h.prep_addr_line1_Invalid > 0 OR h.prep_addr_line_last_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.powid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.raw_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ace_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.charter_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cycle_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.join_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siteid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cu_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sitetypename_ENUM_ErrorCount > 0, 1, 0) + IF(le.mainoffice_ENUM_ErrorCount > 0, 1, 0) + IF(le.addrtype_ENUM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.statename_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assets_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loans_ALLOW_ErrorCount > 0, 1, 0) + IF(le.networthratio_ALLOW_ErrorCount > 0, 1, 0) + IF(le.perc_sharegrowth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.perc_loangrowth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loantoassetsratio_ALLOW_ErrorCount > 0, 1, 0) + IF(le.investassetsratio_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.powid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.raw_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ace_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.charter_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cycle_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.join_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siteid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cu_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sitetypename_ENUM_ErrorCount > 0, 1, 0) + IF(le.mainoffice_ENUM_ErrorCount > 0, 1, 0) + IF(le.addrtype_ENUM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.statename_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assets_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loans_ALLOW_ErrorCount > 0, 1, 0) + IF(le.networthratio_ALLOW_ErrorCount > 0, 1, 0) + IF(le.perc_sharegrowth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.perc_loangrowth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.loantoassetsratio_ALLOW_ErrorCount > 0, 1, 0) + IF(le.investassetsratio_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.source_rec_id_Invalid,le.bdid_Invalid,le.record_type_Invalid,le.raw_aid_Invalid,le.ace_aid_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.charter_Invalid,le.cycle_date_Invalid,le.join_number_Invalid,le.siteid_Invalid,le.cu_name_Invalid,le.sitetypename_Invalid,le.mainoffice_Invalid,le.addrtype_Invalid,le.state_Invalid,le.statename_Invalid,le.zip_code_Invalid,le.country_Invalid,le.phone_Invalid,le.assets_Invalid,le.loans_Invalid,le.networthratio_Invalid,le.perc_sharegrowth_Invalid,le.perc_loangrowth_Invalid,le.loantoassetsratio_Invalid,le.investassetsratio_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_powid(le.powid_Invalid),Base_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),Base_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Fields.InvalidMessage_raw_aid(le.raw_aid_Invalid),Base_Fields.InvalidMessage_ace_aid(le.ace_aid_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_charter(le.charter_Invalid),Base_Fields.InvalidMessage_cycle_date(le.cycle_date_Invalid),Base_Fields.InvalidMessage_join_number(le.join_number_Invalid),Base_Fields.InvalidMessage_siteid(le.siteid_Invalid),Base_Fields.InvalidMessage_cu_name(le.cu_name_Invalid),Base_Fields.InvalidMessage_sitetypename(le.sitetypename_Invalid),Base_Fields.InvalidMessage_mainoffice(le.mainoffice_Invalid),Base_Fields.InvalidMessage_addrtype(le.addrtype_Invalid),Base_Fields.InvalidMessage_state(le.state_Invalid),Base_Fields.InvalidMessage_statename(le.statename_Invalid),Base_Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Base_Fields.InvalidMessage_country(le.country_Invalid),Base_Fields.InvalidMessage_phone(le.phone_Invalid),Base_Fields.InvalidMessage_assets(le.assets_Invalid),Base_Fields.InvalidMessage_loans(le.loans_Invalid),Base_Fields.InvalidMessage_networthratio(le.networthratio_Invalid),Base_Fields.InvalidMessage_perc_sharegrowth(le.perc_sharegrowth_Invalid),Base_Fields.InvalidMessage_perc_loangrowth(le.perc_loangrowth_Invalid),Base_Fields.InvalidMessage_loantoassetsratio(le.loantoassetsratio_Invalid),Base_Fields.InvalidMessage_investassetsratio(le.investassetsratio_Invalid),Base_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Base_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.powid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.raw_aid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ace_aid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.charter_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cycle_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.join_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.siteid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cu_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.sitetypename_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.mainoffice_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.addrtype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.statename_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assets_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.loans_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.networthratio_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.perc_sharegrowth_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.perc_loangrowth_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.loantoassetsratio_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.investassetsratio_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'powid','proxid','seleid','orgid','ultid','source_rec_id','bdid','record_type','raw_aid','ace_aid','dt_vendor_first_reported','dt_vendor_last_reported','charter','cycle_date','join_number','siteid','cu_name','sitetypename','mainoffice','addrtype','state','statename','zip_code','country','phone','assets','loans','networthratio','perc_sharegrowth','perc_loangrowth','loantoassetsratio','investassetsratio','prep_addr_line1','prep_addr_line_last','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_source_rec_id','invalid_bdid','invalid_record_type','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_past_date','invalid_past_date','invalid_charter','invalid_cycle_date','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_mandatory','invalid_sitetypename','invalid_mainoffice','invalid_address_type_code','invalid_st_code','invalid_st_name','invalid_zip_code','invalid_country','invalid_numeric_or_blank','invalid_financial_num','invalid_financial_num','invalid_financial_num','invalid_financial_num','invalid_financial_num','invalid_financial_num','invalid_financial_num','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.powid,(SALT38.StrType)le.proxid,(SALT38.StrType)le.seleid,(SALT38.StrType)le.orgid,(SALT38.StrType)le.ultid,(SALT38.StrType)le.source_rec_id,(SALT38.StrType)le.bdid,(SALT38.StrType)le.record_type,(SALT38.StrType)le.raw_aid,(SALT38.StrType)le.ace_aid,(SALT38.StrType)le.dt_vendor_first_reported,(SALT38.StrType)le.dt_vendor_last_reported,(SALT38.StrType)le.charter,(SALT38.StrType)le.cycle_date,(SALT38.StrType)le.join_number,(SALT38.StrType)le.siteid,(SALT38.StrType)le.cu_name,(SALT38.StrType)le.sitetypename,(SALT38.StrType)le.mainoffice,(SALT38.StrType)le.addrtype,(SALT38.StrType)le.state,(SALT38.StrType)le.statename,(SALT38.StrType)le.zip_code,(SALT38.StrType)le.country,(SALT38.StrType)le.phone,(SALT38.StrType)le.assets,(SALT38.StrType)le.loans,(SALT38.StrType)le.networthratio,(SALT38.StrType)le.perc_sharegrowth,(SALT38.StrType)le.perc_loangrowth,(SALT38.StrType)le.loantoassetsratio,(SALT38.StrType)le.investassetsratio,(SALT38.StrType)le.prep_addr_line1,(SALT38.StrType)le.prep_addr_line_last,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,34,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_Credit_Unions) prevDS = DATASET([], Base_Layout_Credit_Unions), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'powid:invalid_numeric:CUSTOM'
          ,'proxid:invalid_numeric:CUSTOM'
          ,'seleid:invalid_numeric:CUSTOM'
          ,'orgid:invalid_numeric:CUSTOM'
          ,'ultid:invalid_numeric:CUSTOM'
          ,'source_rec_id:invalid_source_rec_id:CUSTOM'
          ,'bdid:invalid_bdid:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'raw_aid:invalid_numeric_or_blank:CUSTOM'
          ,'ace_aid:invalid_numeric_or_blank:CUSTOM'
          ,'dt_vendor_first_reported:invalid_past_date:CUSTOM'
          ,'dt_vendor_last_reported:invalid_past_date:CUSTOM'
          ,'charter:invalid_charter:CUSTOM'
          ,'cycle_date:invalid_cycle_date:CUSTOM'
          ,'join_number:invalid_numeric_or_blank:CUSTOM'
          ,'siteid:invalid_numeric_or_blank:CUSTOM'
          ,'cu_name:invalid_mandatory:LENGTHS'
          ,'sitetypename:invalid_sitetypename:ENUM'
          ,'mainoffice:invalid_mainoffice:ENUM'
          ,'addrtype:invalid_address_type_code:ENUM'
          ,'state:invalid_st_code:CUSTOM'
          ,'statename:invalid_st_name:CUSTOM'
          ,'zip_code:invalid_zip_code:ALLOW'
          ,'country:invalid_country:CUSTOM'
          ,'phone:invalid_numeric_or_blank:CUSTOM'
          ,'assets:invalid_financial_num:ALLOW'
          ,'loans:invalid_financial_num:ALLOW'
          ,'networthratio:invalid_financial_num:ALLOW'
          ,'perc_sharegrowth:invalid_financial_num:ALLOW'
          ,'perc_loangrowth:invalid_financial_num:ALLOW'
          ,'loantoassetsratio:invalid_financial_num:ALLOW'
          ,'investassetsratio:invalid_financial_num:ALLOW'
          ,'prep_addr_line1:invalid_mandatory:LENGTHS'
          ,'prep_addr_line_last:invalid_mandatory:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_powid(1)
          ,Base_Fields.InvalidMessage_proxid(1)
          ,Base_Fields.InvalidMessage_seleid(1)
          ,Base_Fields.InvalidMessage_orgid(1)
          ,Base_Fields.InvalidMessage_ultid(1)
          ,Base_Fields.InvalidMessage_source_rec_id(1)
          ,Base_Fields.InvalidMessage_bdid(1)
          ,Base_Fields.InvalidMessage_record_type(1)
          ,Base_Fields.InvalidMessage_raw_aid(1)
          ,Base_Fields.InvalidMessage_ace_aid(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_charter(1)
          ,Base_Fields.InvalidMessage_cycle_date(1)
          ,Base_Fields.InvalidMessage_join_number(1)
          ,Base_Fields.InvalidMessage_siteid(1)
          ,Base_Fields.InvalidMessage_cu_name(1)
          ,Base_Fields.InvalidMessage_sitetypename(1)
          ,Base_Fields.InvalidMessage_mainoffice(1)
          ,Base_Fields.InvalidMessage_addrtype(1)
          ,Base_Fields.InvalidMessage_state(1)
          ,Base_Fields.InvalidMessage_statename(1)
          ,Base_Fields.InvalidMessage_zip_code(1)
          ,Base_Fields.InvalidMessage_country(1)
          ,Base_Fields.InvalidMessage_phone(1)
          ,Base_Fields.InvalidMessage_assets(1)
          ,Base_Fields.InvalidMessage_loans(1)
          ,Base_Fields.InvalidMessage_networthratio(1)
          ,Base_Fields.InvalidMessage_perc_sharegrowth(1)
          ,Base_Fields.InvalidMessage_perc_loangrowth(1)
          ,Base_Fields.InvalidMessage_loantoassetsratio(1)
          ,Base_Fields.InvalidMessage_investassetsratio(1)
          ,Base_Fields.InvalidMessage_prep_addr_line1(1)
          ,Base_Fields.InvalidMessage_prep_addr_line_last(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.powid_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.raw_aid_CUSTOM_ErrorCount
          ,le.ace_aid_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.charter_CUSTOM_ErrorCount
          ,le.cycle_date_CUSTOM_ErrorCount
          ,le.join_number_CUSTOM_ErrorCount
          ,le.siteid_CUSTOM_ErrorCount
          ,le.cu_name_LENGTHS_ErrorCount
          ,le.sitetypename_ENUM_ErrorCount
          ,le.mainoffice_ENUM_ErrorCount
          ,le.addrtype_ENUM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.statename_CUSTOM_ErrorCount
          ,le.zip_code_ALLOW_ErrorCount
          ,le.country_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.assets_ALLOW_ErrorCount
          ,le.loans_ALLOW_ErrorCount
          ,le.networthratio_ALLOW_ErrorCount
          ,le.perc_sharegrowth_ALLOW_ErrorCount
          ,le.perc_loangrowth_ALLOW_ErrorCount
          ,le.loantoassetsratio_ALLOW_ErrorCount
          ,le.investassetsratio_ALLOW_ErrorCount
          ,le.prep_addr_line1_LENGTHS_ErrorCount
          ,le.prep_addr_line_last_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.powid_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.raw_aid_CUSTOM_ErrorCount
          ,le.ace_aid_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.charter_CUSTOM_ErrorCount
          ,le.cycle_date_CUSTOM_ErrorCount
          ,le.join_number_CUSTOM_ErrorCount
          ,le.siteid_CUSTOM_ErrorCount
          ,le.cu_name_LENGTHS_ErrorCount
          ,le.sitetypename_ENUM_ErrorCount
          ,le.mainoffice_ENUM_ErrorCount
          ,le.addrtype_ENUM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.statename_CUSTOM_ErrorCount
          ,le.zip_code_ALLOW_ErrorCount
          ,le.country_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.assets_ALLOW_ErrorCount
          ,le.loans_ALLOW_ErrorCount
          ,le.networthratio_ALLOW_ErrorCount
          ,le.perc_sharegrowth_ALLOW_ErrorCount
          ,le.perc_loangrowth_ALLOW_ErrorCount
          ,le.loantoassetsratio_ALLOW_ErrorCount
          ,le.investassetsratio_ALLOW_ErrorCount
          ,le.prep_addr_line1_LENGTHS_ErrorCount
          ,le.prep_addr_line_last_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_Credit_Unions));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_aid:' + getFieldTypeText(h.raw_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_aid:' + getFieldTypeText(h.ace_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'charter:' + getFieldTypeText(h.charter) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cycle_date:' + getFieldTypeText(h.cycle_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'join_number:' + getFieldTypeText(h.join_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siteid:' + getFieldTypeText(h.siteid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cu_name:' + getFieldTypeText(h.cu_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sitename:' + getFieldTypeText(h.sitename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sitetypename:' + getFieldTypeText(h.sitetypename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mainoffice:' + getFieldTypeText(h.mainoffice) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addrtype:' + getFieldTypeText(h.addrtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statename:' + getFieldTypeText(h.statename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countyname:' + getFieldTypeText(h.countyname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country:' + getFieldTypeText(h.country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_name:' + getFieldTypeText(h.contact_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assets:' + getFieldTypeText(h.assets) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loans:' + getFieldTypeText(h.loans) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'networthratio:' + getFieldTypeText(h.networthratio) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'perc_sharegrowth:' + getFieldTypeText(h.perc_sharegrowth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'perc_loangrowth:' + getFieldTypeText(h.perc_loangrowth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loantoassetsratio:' + getFieldTypeText(h.loantoassetsratio) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'investassetsratio:' + getFieldTypeText(h.investassetsratio) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nummem:' + getFieldTypeText(h.nummem) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'numfull:' + getFieldTypeText(h.numfull) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_state:' + getFieldTypeText(h.fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line1:' + getFieldTypeText(h.prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line_last:' + getFieldTypeText(h.prep_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_powid_cnt
          ,le.populated_proxid_cnt
          ,le.populated_seleid_cnt
          ,le.populated_orgid_cnt
          ,le.populated_ultid_cnt
          ,le.populated_source_rec_id_cnt
          ,le.populated_bdid_cnt
          ,le.populated_record_type_cnt
          ,le.populated_raw_aid_cnt
          ,le.populated_ace_aid_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_charter_cnt
          ,le.populated_cycle_date_cnt
          ,le.populated_join_number_cnt
          ,le.populated_siteid_cnt
          ,le.populated_cu_name_cnt
          ,le.populated_sitename_cnt
          ,le.populated_sitetypename_cnt
          ,le.populated_mainoffice_cnt
          ,le.populated_addrtype_cnt
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_statename_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_countyname_cnt
          ,le.populated_country_cnt
          ,le.populated_phone_cnt
          ,le.populated_contact_name_cnt
          ,le.populated_assets_cnt
          ,le.populated_loans_cnt
          ,le.populated_networthratio_cnt
          ,le.populated_perc_sharegrowth_cnt
          ,le.populated_perc_loangrowth_cnt
          ,le.populated_loantoassetsratio_cnt
          ,le.populated_investassetsratio_cnt
          ,le.populated_nummem_cnt
          ,le.populated_numfull_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_fips_state_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_prep_addr_line1_cnt
          ,le.populated_prep_addr_line_last_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_powid_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_source_rec_id_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_raw_aid_pcnt
          ,le.populated_ace_aid_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_charter_pcnt
          ,le.populated_cycle_date_pcnt
          ,le.populated_join_number_pcnt
          ,le.populated_siteid_pcnt
          ,le.populated_cu_name_pcnt
          ,le.populated_sitename_pcnt
          ,le.populated_sitetypename_pcnt
          ,le.populated_mainoffice_pcnt
          ,le.populated_addrtype_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_statename_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_countyname_pcnt
          ,le.populated_country_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_contact_name_pcnt
          ,le.populated_assets_pcnt
          ,le.populated_loans_pcnt
          ,le.populated_networthratio_pcnt
          ,le.populated_perc_sharegrowth_pcnt
          ,le.populated_perc_loangrowth_pcnt
          ,le.populated_loantoassetsratio_pcnt
          ,le.populated_investassetsratio_pcnt
          ,le.populated_nummem_pcnt
          ,le.populated_numfull_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_fips_state_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_prep_addr_line1_pcnt
          ,le.populated_prep_addr_line_last_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,75,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_Credit_Unions));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),75,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_Credit_Unions) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Credit_Unions, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
