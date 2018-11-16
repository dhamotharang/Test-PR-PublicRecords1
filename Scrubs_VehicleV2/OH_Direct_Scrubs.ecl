IMPORT SALT311,STD;
EXPORT OH_Direct_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 53;
  EXPORT NumRulesFromFieldType := 53;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 28;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(OH_Direct_Layout_VehicleV2)
    UNSIGNED1 categorycode_Invalid;
    UNSIGNED1 vin_Invalid;
    UNSIGNED1 modelyr_Invalid;
    UNSIGNED1 titlenum_Invalid;
    UNSIGNED1 ownercode_Invalid;
    UNSIGNED1 grossweight_Invalid;
    UNSIGNED1 ownername_Invalid;
    UNSIGNED1 ownerstreetaddress_Invalid;
    UNSIGNED1 ownercity_Invalid;
    UNSIGNED1 ownerstate_Invalid;
    UNSIGNED1 ownerzip_Invalid;
    UNSIGNED1 countynumber_Invalid;
    UNSIGNED1 vehiclepurchasedt_Invalid;
    UNSIGNED1 vehicletaxweight_Invalid;
    UNSIGNED1 vehicletaxcode_Invalid;
    UNSIGNED1 vehicleunladdenweight_Invalid;
    UNSIGNED1 additionalownername_Invalid;
    UNSIGNED1 registrationissuedt_Invalid;
    UNSIGNED1 vehiclemake_Invalid;
    UNSIGNED1 vehicletype_Invalid;
    UNSIGNED1 vehicleexpdt_Invalid;
    UNSIGNED1 previousplatenum_Invalid;
    UNSIGNED1 platenum_Invalid;
    UNSIGNED1 processdate_Invalid;
    UNSIGNED1 source_code_Invalid;
    UNSIGNED1 state_origin_Invalid;
    UNSIGNED1 append_ownernametypeind_Invalid;
    UNSIGNED1 append_addlownernametypeind_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(OH_Direct_Layout_VehicleV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(OH_Direct_Layout_VehicleV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.categorycode_Invalid := OH_Direct_Fields.InValid_categorycode((SALT311.StrType)le.categorycode);
    SELF.vin_Invalid := OH_Direct_Fields.InValid_vin((SALT311.StrType)le.vin);
    SELF.modelyr_Invalid := OH_Direct_Fields.InValid_modelyr((SALT311.StrType)le.modelyr);
    SELF.titlenum_Invalid := OH_Direct_Fields.InValid_titlenum((SALT311.StrType)le.titlenum);
    SELF.ownercode_Invalid := OH_Direct_Fields.InValid_ownercode((SALT311.StrType)le.ownercode);
    SELF.grossweight_Invalid := OH_Direct_Fields.InValid_grossweight((SALT311.StrType)le.grossweight);
    SELF.ownername_Invalid := OH_Direct_Fields.InValid_ownername((SALT311.StrType)le.ownername);
    SELF.ownerstreetaddress_Invalid := OH_Direct_Fields.InValid_ownerstreetaddress((SALT311.StrType)le.ownerstreetaddress);
    SELF.ownercity_Invalid := OH_Direct_Fields.InValid_ownercity((SALT311.StrType)le.ownercity);
    SELF.ownerstate_Invalid := OH_Direct_Fields.InValid_ownerstate((SALT311.StrType)le.ownerstate);
    SELF.ownerzip_Invalid := OH_Direct_Fields.InValid_ownerzip((SALT311.StrType)le.ownerzip);
    SELF.countynumber_Invalid := OH_Direct_Fields.InValid_countynumber((SALT311.StrType)le.countynumber);
    SELF.vehiclepurchasedt_Invalid := OH_Direct_Fields.InValid_vehiclepurchasedt((SALT311.StrType)le.vehiclepurchasedt);
    SELF.vehicletaxweight_Invalid := OH_Direct_Fields.InValid_vehicletaxweight((SALT311.StrType)le.vehicletaxweight);
    SELF.vehicletaxcode_Invalid := OH_Direct_Fields.InValid_vehicletaxcode((SALT311.StrType)le.vehicletaxcode);
    SELF.vehicleunladdenweight_Invalid := OH_Direct_Fields.InValid_vehicleunladdenweight((SALT311.StrType)le.vehicleunladdenweight);
    SELF.additionalownername_Invalid := OH_Direct_Fields.InValid_additionalownername((SALT311.StrType)le.additionalownername);
    SELF.registrationissuedt_Invalid := OH_Direct_Fields.InValid_registrationissuedt((SALT311.StrType)le.registrationissuedt);
    SELF.vehiclemake_Invalid := OH_Direct_Fields.InValid_vehiclemake((SALT311.StrType)le.vehiclemake);
    SELF.vehicletype_Invalid := OH_Direct_Fields.InValid_vehicletype((SALT311.StrType)le.vehicletype);
    SELF.vehicleexpdt_Invalid := OH_Direct_Fields.InValid_vehicleexpdt((SALT311.StrType)le.vehicleexpdt);
    SELF.previousplatenum_Invalid := OH_Direct_Fields.InValid_previousplatenum((SALT311.StrType)le.previousplatenum);
    SELF.platenum_Invalid := OH_Direct_Fields.InValid_platenum((SALT311.StrType)le.platenum);
    SELF.processdate_Invalid := OH_Direct_Fields.InValid_processdate((SALT311.StrType)le.processdate);
    SELF.source_code_Invalid := OH_Direct_Fields.InValid_source_code((SALT311.StrType)le.source_code);
    SELF.state_origin_Invalid := OH_Direct_Fields.InValid_state_origin((SALT311.StrType)le.state_origin);
    SELF.append_ownernametypeind_Invalid := OH_Direct_Fields.InValid_append_ownernametypeind((SALT311.StrType)le.append_ownernametypeind);
    SELF.append_addlownernametypeind_Invalid := OH_Direct_Fields.InValid_append_addlownernametypeind((SALT311.StrType)le.append_addlownernametypeind);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),OH_Direct_Layout_VehicleV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.categorycode_Invalid << 0 ) + ( le.vin_Invalid << 2 ) + ( le.modelyr_Invalid << 3 ) + ( le.titlenum_Invalid << 5 ) + ( le.ownercode_Invalid << 6 ) + ( le.grossweight_Invalid << 8 ) + ( le.ownername_Invalid << 10 ) + ( le.ownerstreetaddress_Invalid << 12 ) + ( le.ownercity_Invalid << 14 ) + ( le.ownerstate_Invalid << 16 ) + ( le.ownerzip_Invalid << 18 ) + ( le.countynumber_Invalid << 20 ) + ( le.vehiclepurchasedt_Invalid << 22 ) + ( le.vehicletaxweight_Invalid << 24 ) + ( le.vehicletaxcode_Invalid << 26 ) + ( le.vehicleunladdenweight_Invalid << 28 ) + ( le.additionalownername_Invalid << 30 ) + ( le.registrationissuedt_Invalid << 32 ) + ( le.vehiclemake_Invalid << 34 ) + ( le.vehicletype_Invalid << 35 ) + ( le.vehicleexpdt_Invalid << 37 ) + ( le.previousplatenum_Invalid << 39 ) + ( le.platenum_Invalid << 41 ) + ( le.processdate_Invalid << 43 ) + ( le.source_code_Invalid << 45 ) + ( le.state_origin_Invalid << 47 ) + ( le.append_ownernametypeind_Invalid << 49 ) + ( le.append_addlownernametypeind_Invalid << 51 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,OH_Direct_Layout_VehicleV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.categorycode_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.vin_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.modelyr_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.titlenum_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.ownercode_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.grossweight_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.ownername_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.ownerstreetaddress_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.ownercity_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.ownerstate_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.ownerzip_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.countynumber_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.vehiclepurchasedt_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.vehicletaxweight_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.vehicletaxcode_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.vehicleunladdenweight_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.additionalownername_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.registrationissuedt_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.vehiclemake_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.vehicletype_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.vehicleexpdt_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.previousplatenum_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.platenum_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.processdate_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.source_code_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.state_origin_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.append_ownernametypeind_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.append_addlownernametypeind_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.source_code) source_code := IF(Glob, '', h.source_code);
    TotalCnt := COUNT(GROUP); // Number of records in total
    categorycode_ENUM_ErrorCount := COUNT(GROUP,h.categorycode_Invalid=1);
    categorycode_LENGTHS_ErrorCount := COUNT(GROUP,h.categorycode_Invalid=2);
    categorycode_Total_ErrorCount := COUNT(GROUP,h.categorycode_Invalid>0);
    vin_ALLOW_ErrorCount := COUNT(GROUP,h.vin_Invalid=1);
    modelyr_ALLOW_ErrorCount := COUNT(GROUP,h.modelyr_Invalid=1);
    modelyr_LENGTHS_ErrorCount := COUNT(GROUP,h.modelyr_Invalid=2);
    modelyr_Total_ErrorCount := COUNT(GROUP,h.modelyr_Invalid>0);
    titlenum_ALLOW_ErrorCount := COUNT(GROUP,h.titlenum_Invalid=1);
    ownercode_ENUM_ErrorCount := COUNT(GROUP,h.ownercode_Invalid=1);
    ownercode_LENGTHS_ErrorCount := COUNT(GROUP,h.ownercode_Invalid=2);
    ownercode_Total_ErrorCount := COUNT(GROUP,h.ownercode_Invalid>0);
    grossweight_ALLOW_ErrorCount := COUNT(GROUP,h.grossweight_Invalid=1);
    grossweight_LENGTHS_ErrorCount := COUNT(GROUP,h.grossweight_Invalid=2);
    grossweight_Total_ErrorCount := COUNT(GROUP,h.grossweight_Invalid>0);
    ownername_CAPS_ErrorCount := COUNT(GROUP,h.ownername_Invalid=1);
    ownername_ALLOW_ErrorCount := COUNT(GROUP,h.ownername_Invalid=2);
    ownername_Total_ErrorCount := COUNT(GROUP,h.ownername_Invalid>0);
    ownerstreetaddress_CAPS_ErrorCount := COUNT(GROUP,h.ownerstreetaddress_Invalid=1);
    ownerstreetaddress_ALLOW_ErrorCount := COUNT(GROUP,h.ownerstreetaddress_Invalid=2);
    ownerstreetaddress_Total_ErrorCount := COUNT(GROUP,h.ownerstreetaddress_Invalid>0);
    ownercity_CAPS_ErrorCount := COUNT(GROUP,h.ownercity_Invalid=1);
    ownercity_ALLOW_ErrorCount := COUNT(GROUP,h.ownercity_Invalid=2);
    ownercity_Total_ErrorCount := COUNT(GROUP,h.ownercity_Invalid>0);
    ownerstate_ENUM_ErrorCount := COUNT(GROUP,h.ownerstate_Invalid=1);
    ownerstate_LENGTHS_ErrorCount := COUNT(GROUP,h.ownerstate_Invalid=2);
    ownerstate_Total_ErrorCount := COUNT(GROUP,h.ownerstate_Invalid>0);
    ownerzip_ALLOW_ErrorCount := COUNT(GROUP,h.ownerzip_Invalid=1);
    ownerzip_LENGTHS_ErrorCount := COUNT(GROUP,h.ownerzip_Invalid=2);
    ownerzip_Total_ErrorCount := COUNT(GROUP,h.ownerzip_Invalid>0);
    countynumber_ALLOW_ErrorCount := COUNT(GROUP,h.countynumber_Invalid=1);
    countynumber_LENGTHS_ErrorCount := COUNT(GROUP,h.countynumber_Invalid=2);
    countynumber_Total_ErrorCount := COUNT(GROUP,h.countynumber_Invalid>0);
    vehiclepurchasedt_ALLOW_ErrorCount := COUNT(GROUP,h.vehiclepurchasedt_Invalid=1);
    vehiclepurchasedt_LENGTHS_ErrorCount := COUNT(GROUP,h.vehiclepurchasedt_Invalid=2);
    vehiclepurchasedt_Total_ErrorCount := COUNT(GROUP,h.vehiclepurchasedt_Invalid>0);
    vehicletaxweight_ALLOW_ErrorCount := COUNT(GROUP,h.vehicletaxweight_Invalid=1);
    vehicletaxweight_LENGTHS_ErrorCount := COUNT(GROUP,h.vehicletaxweight_Invalid=2);
    vehicletaxweight_Total_ErrorCount := COUNT(GROUP,h.vehicletaxweight_Invalid>0);
    vehicletaxcode_ENUM_ErrorCount := COUNT(GROUP,h.vehicletaxcode_Invalid=1);
    vehicletaxcode_LENGTHS_ErrorCount := COUNT(GROUP,h.vehicletaxcode_Invalid=2);
    vehicletaxcode_Total_ErrorCount := COUNT(GROUP,h.vehicletaxcode_Invalid>0);
    vehicleunladdenweight_ALLOW_ErrorCount := COUNT(GROUP,h.vehicleunladdenweight_Invalid=1);
    vehicleunladdenweight_LENGTHS_ErrorCount := COUNT(GROUP,h.vehicleunladdenweight_Invalid=2);
    vehicleunladdenweight_Total_ErrorCount := COUNT(GROUP,h.vehicleunladdenweight_Invalid>0);
    additionalownername_CAPS_ErrorCount := COUNT(GROUP,h.additionalownername_Invalid=1);
    additionalownername_ALLOW_ErrorCount := COUNT(GROUP,h.additionalownername_Invalid=2);
    additionalownername_Total_ErrorCount := COUNT(GROUP,h.additionalownername_Invalid>0);
    registrationissuedt_ALLOW_ErrorCount := COUNT(GROUP,h.registrationissuedt_Invalid=1);
    registrationissuedt_LENGTHS_ErrorCount := COUNT(GROUP,h.registrationissuedt_Invalid=2);
    registrationissuedt_Total_ErrorCount := COUNT(GROUP,h.registrationissuedt_Invalid>0);
    vehiclemake_ALLOW_ErrorCount := COUNT(GROUP,h.vehiclemake_Invalid=1);
    vehicletype_CAPS_ErrorCount := COUNT(GROUP,h.vehicletype_Invalid=1);
    vehicletype_ALLOW_ErrorCount := COUNT(GROUP,h.vehicletype_Invalid=2);
    vehicletype_Total_ErrorCount := COUNT(GROUP,h.vehicletype_Invalid>0);
    vehicleexpdt_ALLOW_ErrorCount := COUNT(GROUP,h.vehicleexpdt_Invalid=1);
    vehicleexpdt_LENGTHS_ErrorCount := COUNT(GROUP,h.vehicleexpdt_Invalid=2);
    vehicleexpdt_Total_ErrorCount := COUNT(GROUP,h.vehicleexpdt_Invalid>0);
    previousplatenum_CAPS_ErrorCount := COUNT(GROUP,h.previousplatenum_Invalid=1);
    previousplatenum_ALLOW_ErrorCount := COUNT(GROUP,h.previousplatenum_Invalid=2);
    previousplatenum_Total_ErrorCount := COUNT(GROUP,h.previousplatenum_Invalid>0);
    platenum_CAPS_ErrorCount := COUNT(GROUP,h.platenum_Invalid=1);
    platenum_ALLOW_ErrorCount := COUNT(GROUP,h.platenum_Invalid=2);
    platenum_Total_ErrorCount := COUNT(GROUP,h.platenum_Invalid>0);
    processdate_ALLOW_ErrorCount := COUNT(GROUP,h.processdate_Invalid=1);
    processdate_LENGTHS_ErrorCount := COUNT(GROUP,h.processdate_Invalid=2);
    processdate_Total_ErrorCount := COUNT(GROUP,h.processdate_Invalid>0);
    source_code_ENUM_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    source_code_LENGTHS_ErrorCount := COUNT(GROUP,h.source_code_Invalid=2);
    source_code_Total_ErrorCount := COUNT(GROUP,h.source_code_Invalid>0);
    state_origin_ENUM_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    state_origin_LENGTHS_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=2);
    state_origin_Total_ErrorCount := COUNT(GROUP,h.state_origin_Invalid>0);
    append_ownernametypeind_ENUM_ErrorCount := COUNT(GROUP,h.append_ownernametypeind_Invalid=1);
    append_ownernametypeind_LENGTHS_ErrorCount := COUNT(GROUP,h.append_ownernametypeind_Invalid=2);
    append_ownernametypeind_Total_ErrorCount := COUNT(GROUP,h.append_ownernametypeind_Invalid>0);
    append_addlownernametypeind_ENUM_ErrorCount := COUNT(GROUP,h.append_addlownernametypeind_Invalid=1);
    append_addlownernametypeind_LENGTHS_ErrorCount := COUNT(GROUP,h.append_addlownernametypeind_Invalid=2);
    append_addlownernametypeind_Total_ErrorCount := COUNT(GROUP,h.append_addlownernametypeind_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.categorycode_Invalid > 0 OR h.vin_Invalid > 0 OR h.modelyr_Invalid > 0 OR h.titlenum_Invalid > 0 OR h.ownercode_Invalid > 0 OR h.grossweight_Invalid > 0 OR h.ownername_Invalid > 0 OR h.ownerstreetaddress_Invalid > 0 OR h.ownercity_Invalid > 0 OR h.ownerstate_Invalid > 0 OR h.ownerzip_Invalid > 0 OR h.countynumber_Invalid > 0 OR h.vehiclepurchasedt_Invalid > 0 OR h.vehicletaxweight_Invalid > 0 OR h.vehicletaxcode_Invalid > 0 OR h.vehicleunladdenweight_Invalid > 0 OR h.additionalownername_Invalid > 0 OR h.registrationissuedt_Invalid > 0 OR h.vehiclemake_Invalid > 0 OR h.vehicletype_Invalid > 0 OR h.vehicleexpdt_Invalid > 0 OR h.previousplatenum_Invalid > 0 OR h.platenum_Invalid > 0 OR h.processdate_Invalid > 0 OR h.source_code_Invalid > 0 OR h.state_origin_Invalid > 0 OR h.append_ownernametypeind_Invalid > 0 OR h.append_addlownernametypeind_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,source_code,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.categorycode_Total_ErrorCount > 0, 1, 0) + IF(le.vin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.modelyr_Total_ErrorCount > 0, 1, 0) + IF(le.titlenum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ownercode_Total_ErrorCount > 0, 1, 0) + IF(le.grossweight_Total_ErrorCount > 0, 1, 0) + IF(le.ownername_Total_ErrorCount > 0, 1, 0) + IF(le.ownerstreetaddress_Total_ErrorCount > 0, 1, 0) + IF(le.ownercity_Total_ErrorCount > 0, 1, 0) + IF(le.ownerstate_Total_ErrorCount > 0, 1, 0) + IF(le.ownerzip_Total_ErrorCount > 0, 1, 0) + IF(le.countynumber_Total_ErrorCount > 0, 1, 0) + IF(le.vehiclepurchasedt_Total_ErrorCount > 0, 1, 0) + IF(le.vehicletaxweight_Total_ErrorCount > 0, 1, 0) + IF(le.vehicletaxcode_Total_ErrorCount > 0, 1, 0) + IF(le.vehicleunladdenweight_Total_ErrorCount > 0, 1, 0) + IF(le.additionalownername_Total_ErrorCount > 0, 1, 0) + IF(le.registrationissuedt_Total_ErrorCount > 0, 1, 0) + IF(le.vehiclemake_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vehicletype_Total_ErrorCount > 0, 1, 0) + IF(le.vehicleexpdt_Total_ErrorCount > 0, 1, 0) + IF(le.previousplatenum_Total_ErrorCount > 0, 1, 0) + IF(le.platenum_Total_ErrorCount > 0, 1, 0) + IF(le.processdate_Total_ErrorCount > 0, 1, 0) + IF(le.source_code_Total_ErrorCount > 0, 1, 0) + IF(le.state_origin_Total_ErrorCount > 0, 1, 0) + IF(le.append_ownernametypeind_Total_ErrorCount > 0, 1, 0) + IF(le.append_addlownernametypeind_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.categorycode_ENUM_ErrorCount > 0, 1, 0) + IF(le.categorycode_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.modelyr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.modelyr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.titlenum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ownercode_ENUM_ErrorCount > 0, 1, 0) + IF(le.ownercode_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.grossweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.grossweight_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ownername_CAPS_ErrorCount > 0, 1, 0) + IF(le.ownername_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ownerstreetaddress_CAPS_ErrorCount > 0, 1, 0) + IF(le.ownerstreetaddress_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ownercity_CAPS_ErrorCount > 0, 1, 0) + IF(le.ownercity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ownerstate_ENUM_ErrorCount > 0, 1, 0) + IF(le.ownerstate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ownerzip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ownerzip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.countynumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.countynumber_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vehiclepurchasedt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vehiclepurchasedt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vehicletaxweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vehicletaxweight_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vehicletaxcode_ENUM_ErrorCount > 0, 1, 0) + IF(le.vehicletaxcode_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vehicleunladdenweight_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vehicleunladdenweight_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.additionalownername_CAPS_ErrorCount > 0, 1, 0) + IF(le.additionalownername_ALLOW_ErrorCount > 0, 1, 0) + IF(le.registrationissuedt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.registrationissuedt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vehiclemake_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vehicletype_CAPS_ErrorCount > 0, 1, 0) + IF(le.vehicletype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vehicleexpdt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vehicleexpdt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.previousplatenum_CAPS_ErrorCount > 0, 1, 0) + IF(le.previousplatenum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.platenum_CAPS_ErrorCount > 0, 1, 0) + IF(le.platenum_ALLOW_ErrorCount > 0, 1, 0) + IF(le.processdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.processdate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.source_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.source_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.state_origin_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.append_ownernametypeind_ENUM_ErrorCount > 0, 1, 0) + IF(le.append_ownernametypeind_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.append_addlownernametypeind_ENUM_ErrorCount > 0, 1, 0) + IF(le.append_addlownernametypeind_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.categorycode_Invalid,le.vin_Invalid,le.modelyr_Invalid,le.titlenum_Invalid,le.ownercode_Invalid,le.grossweight_Invalid,le.ownername_Invalid,le.ownerstreetaddress_Invalid,le.ownercity_Invalid,le.ownerstate_Invalid,le.ownerzip_Invalid,le.countynumber_Invalid,le.vehiclepurchasedt_Invalid,le.vehicletaxweight_Invalid,le.vehicletaxcode_Invalid,le.vehicleunladdenweight_Invalid,le.additionalownername_Invalid,le.registrationissuedt_Invalid,le.vehiclemake_Invalid,le.vehicletype_Invalid,le.vehicleexpdt_Invalid,le.previousplatenum_Invalid,le.platenum_Invalid,le.processdate_Invalid,le.source_code_Invalid,le.state_origin_Invalid,le.append_ownernametypeind_Invalid,le.append_addlownernametypeind_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,OH_Direct_Fields.InvalidMessage_categorycode(le.categorycode_Invalid),OH_Direct_Fields.InvalidMessage_vin(le.vin_Invalid),OH_Direct_Fields.InvalidMessage_modelyr(le.modelyr_Invalid),OH_Direct_Fields.InvalidMessage_titlenum(le.titlenum_Invalid),OH_Direct_Fields.InvalidMessage_ownercode(le.ownercode_Invalid),OH_Direct_Fields.InvalidMessage_grossweight(le.grossweight_Invalid),OH_Direct_Fields.InvalidMessage_ownername(le.ownername_Invalid),OH_Direct_Fields.InvalidMessage_ownerstreetaddress(le.ownerstreetaddress_Invalid),OH_Direct_Fields.InvalidMessage_ownercity(le.ownercity_Invalid),OH_Direct_Fields.InvalidMessage_ownerstate(le.ownerstate_Invalid),OH_Direct_Fields.InvalidMessage_ownerzip(le.ownerzip_Invalid),OH_Direct_Fields.InvalidMessage_countynumber(le.countynumber_Invalid),OH_Direct_Fields.InvalidMessage_vehiclepurchasedt(le.vehiclepurchasedt_Invalid),OH_Direct_Fields.InvalidMessage_vehicletaxweight(le.vehicletaxweight_Invalid),OH_Direct_Fields.InvalidMessage_vehicletaxcode(le.vehicletaxcode_Invalid),OH_Direct_Fields.InvalidMessage_vehicleunladdenweight(le.vehicleunladdenweight_Invalid),OH_Direct_Fields.InvalidMessage_additionalownername(le.additionalownername_Invalid),OH_Direct_Fields.InvalidMessage_registrationissuedt(le.registrationissuedt_Invalid),OH_Direct_Fields.InvalidMessage_vehiclemake(le.vehiclemake_Invalid),OH_Direct_Fields.InvalidMessage_vehicletype(le.vehicletype_Invalid),OH_Direct_Fields.InvalidMessage_vehicleexpdt(le.vehicleexpdt_Invalid),OH_Direct_Fields.InvalidMessage_previousplatenum(le.previousplatenum_Invalid),OH_Direct_Fields.InvalidMessage_platenum(le.platenum_Invalid),OH_Direct_Fields.InvalidMessage_processdate(le.processdate_Invalid),OH_Direct_Fields.InvalidMessage_source_code(le.source_code_Invalid),OH_Direct_Fields.InvalidMessage_state_origin(le.state_origin_Invalid),OH_Direct_Fields.InvalidMessage_append_ownernametypeind(le.append_ownernametypeind_Invalid),OH_Direct_Fields.InvalidMessage_append_addlownernametypeind(le.append_addlownernametypeind_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.categorycode_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.modelyr_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.titlenum_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ownercode_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.grossweight_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ownername_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.ownerstreetaddress_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.ownercity_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.ownerstate_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ownerzip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.countynumber_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vehiclepurchasedt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vehicletaxweight_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vehicletaxcode_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vehicleunladdenweight_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.additionalownername_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.registrationissuedt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vehiclemake_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vehicletype_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.vehicleexpdt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.previousplatenum_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.platenum_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.processdate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.append_ownernametypeind_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.append_addlownernametypeind_Invalid,'ENUM','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'categorycode','vin','modelyr','titlenum','ownercode','grossweight','ownername','ownerstreetaddress','ownercity','ownerstate','ownerzip','countynumber','vehiclepurchasedt','vehicletaxweight','vehicletaxcode','vehicleunladdenweight','additionalownername','registrationissuedt','vehiclemake','vehicletype','vehicleexpdt','previousplatenum','platenum','processdate','source_code','state_origin','append_ownernametypeind','append_addlownernametypeind','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_categorycode','invalid_vin','invalid_year','invalid_titlenum','invalid_ownercode','invalid_weight','invalid_alpha','invalid_alpha','invalid_only_alpha','invalid_state','invalid_zip','invalid_countycode','invalid_date','invalid_weight','invalid_vehicletaxcode','invalid_weight','invalid_alpha','invalid_date','invalid_vehiclemake','invalid_alphanumeric','invalid_date','invalid_alphanumeric','invalid_alphanumeric','invalid_date','invalid_source_code','invalid_state','invalid_append_ownernametypeind','invalid_append_ownernametypeind','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.categorycode,(SALT311.StrType)le.vin,(SALT311.StrType)le.modelyr,(SALT311.StrType)le.titlenum,(SALT311.StrType)le.ownercode,(SALT311.StrType)le.grossweight,(SALT311.StrType)le.ownername,(SALT311.StrType)le.ownerstreetaddress,(SALT311.StrType)le.ownercity,(SALT311.StrType)le.ownerstate,(SALT311.StrType)le.ownerzip,(SALT311.StrType)le.countynumber,(SALT311.StrType)le.vehiclepurchasedt,(SALT311.StrType)le.vehicletaxweight,(SALT311.StrType)le.vehicletaxcode,(SALT311.StrType)le.vehicleunladdenweight,(SALT311.StrType)le.additionalownername,(SALT311.StrType)le.registrationissuedt,(SALT311.StrType)le.vehiclemake,(SALT311.StrType)le.vehicletype,(SALT311.StrType)le.vehicleexpdt,(SALT311.StrType)le.previousplatenum,(SALT311.StrType)le.platenum,(SALT311.StrType)le.processdate,(SALT311.StrType)le.source_code,(SALT311.StrType)le.state_origin,(SALT311.StrType)le.append_ownernametypeind,(SALT311.StrType)le.append_addlownernametypeind,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,28,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(OH_Direct_Layout_VehicleV2) prevDS = DATASET([], OH_Direct_Layout_VehicleV2)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_code;
      SELF.ruledesc := CHOOSE(c
          ,'categorycode:invalid_categorycode:ENUM','categorycode:invalid_categorycode:LENGTHS'
          ,'vin:invalid_vin:ALLOW'
          ,'modelyr:invalid_year:ALLOW','modelyr:invalid_year:LENGTHS'
          ,'titlenum:invalid_titlenum:ALLOW'
          ,'ownercode:invalid_ownercode:ENUM','ownercode:invalid_ownercode:LENGTHS'
          ,'grossweight:invalid_weight:ALLOW','grossweight:invalid_weight:LENGTHS'
          ,'ownername:invalid_alpha:CAPS','ownername:invalid_alpha:ALLOW'
          ,'ownerstreetaddress:invalid_alpha:CAPS','ownerstreetaddress:invalid_alpha:ALLOW'
          ,'ownercity:invalid_only_alpha:CAPS','ownercity:invalid_only_alpha:ALLOW'
          ,'ownerstate:invalid_state:ENUM','ownerstate:invalid_state:LENGTHS'
          ,'ownerzip:invalid_zip:ALLOW','ownerzip:invalid_zip:LENGTHS'
          ,'countynumber:invalid_countycode:ALLOW','countynumber:invalid_countycode:LENGTHS'
          ,'vehiclepurchasedt:invalid_date:ALLOW','vehiclepurchasedt:invalid_date:LENGTHS'
          ,'vehicletaxweight:invalid_weight:ALLOW','vehicletaxweight:invalid_weight:LENGTHS'
          ,'vehicletaxcode:invalid_vehicletaxcode:ENUM','vehicletaxcode:invalid_vehicletaxcode:LENGTHS'
          ,'vehicleunladdenweight:invalid_weight:ALLOW','vehicleunladdenweight:invalid_weight:LENGTHS'
          ,'additionalownername:invalid_alpha:CAPS','additionalownername:invalid_alpha:ALLOW'
          ,'registrationissuedt:invalid_date:ALLOW','registrationissuedt:invalid_date:LENGTHS'
          ,'vehiclemake:invalid_vehiclemake:ALLOW'
          ,'vehicletype:invalid_alphanumeric:CAPS','vehicletype:invalid_alphanumeric:ALLOW'
          ,'vehicleexpdt:invalid_date:ALLOW','vehicleexpdt:invalid_date:LENGTHS'
          ,'previousplatenum:invalid_alphanumeric:CAPS','previousplatenum:invalid_alphanumeric:ALLOW'
          ,'platenum:invalid_alphanumeric:CAPS','platenum:invalid_alphanumeric:ALLOW'
          ,'processdate:invalid_date:ALLOW','processdate:invalid_date:LENGTHS'
          ,'source_code:invalid_source_code:ENUM','source_code:invalid_source_code:LENGTHS'
          ,'state_origin:invalid_state:ENUM','state_origin:invalid_state:LENGTHS'
          ,'append_ownernametypeind:invalid_append_ownernametypeind:ENUM','append_ownernametypeind:invalid_append_ownernametypeind:LENGTHS'
          ,'append_addlownernametypeind:invalid_append_ownernametypeind:ENUM','append_addlownernametypeind:invalid_append_ownernametypeind:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,OH_Direct_Fields.InvalidMessage_categorycode(1),OH_Direct_Fields.InvalidMessage_categorycode(2)
          ,OH_Direct_Fields.InvalidMessage_vin(1)
          ,OH_Direct_Fields.InvalidMessage_modelyr(1),OH_Direct_Fields.InvalidMessage_modelyr(2)
          ,OH_Direct_Fields.InvalidMessage_titlenum(1)
          ,OH_Direct_Fields.InvalidMessage_ownercode(1),OH_Direct_Fields.InvalidMessage_ownercode(2)
          ,OH_Direct_Fields.InvalidMessage_grossweight(1),OH_Direct_Fields.InvalidMessage_grossweight(2)
          ,OH_Direct_Fields.InvalidMessage_ownername(1),OH_Direct_Fields.InvalidMessage_ownername(2)
          ,OH_Direct_Fields.InvalidMessage_ownerstreetaddress(1),OH_Direct_Fields.InvalidMessage_ownerstreetaddress(2)
          ,OH_Direct_Fields.InvalidMessage_ownercity(1),OH_Direct_Fields.InvalidMessage_ownercity(2)
          ,OH_Direct_Fields.InvalidMessage_ownerstate(1),OH_Direct_Fields.InvalidMessage_ownerstate(2)
          ,OH_Direct_Fields.InvalidMessage_ownerzip(1),OH_Direct_Fields.InvalidMessage_ownerzip(2)
          ,OH_Direct_Fields.InvalidMessage_countynumber(1),OH_Direct_Fields.InvalidMessage_countynumber(2)
          ,OH_Direct_Fields.InvalidMessage_vehiclepurchasedt(1),OH_Direct_Fields.InvalidMessage_vehiclepurchasedt(2)
          ,OH_Direct_Fields.InvalidMessage_vehicletaxweight(1),OH_Direct_Fields.InvalidMessage_vehicletaxweight(2)
          ,OH_Direct_Fields.InvalidMessage_vehicletaxcode(1),OH_Direct_Fields.InvalidMessage_vehicletaxcode(2)
          ,OH_Direct_Fields.InvalidMessage_vehicleunladdenweight(1),OH_Direct_Fields.InvalidMessage_vehicleunladdenweight(2)
          ,OH_Direct_Fields.InvalidMessage_additionalownername(1),OH_Direct_Fields.InvalidMessage_additionalownername(2)
          ,OH_Direct_Fields.InvalidMessage_registrationissuedt(1),OH_Direct_Fields.InvalidMessage_registrationissuedt(2)
          ,OH_Direct_Fields.InvalidMessage_vehiclemake(1)
          ,OH_Direct_Fields.InvalidMessage_vehicletype(1),OH_Direct_Fields.InvalidMessage_vehicletype(2)
          ,OH_Direct_Fields.InvalidMessage_vehicleexpdt(1),OH_Direct_Fields.InvalidMessage_vehicleexpdt(2)
          ,OH_Direct_Fields.InvalidMessage_previousplatenum(1),OH_Direct_Fields.InvalidMessage_previousplatenum(2)
          ,OH_Direct_Fields.InvalidMessage_platenum(1),OH_Direct_Fields.InvalidMessage_platenum(2)
          ,OH_Direct_Fields.InvalidMessage_processdate(1),OH_Direct_Fields.InvalidMessage_processdate(2)
          ,OH_Direct_Fields.InvalidMessage_source_code(1),OH_Direct_Fields.InvalidMessage_source_code(2)
          ,OH_Direct_Fields.InvalidMessage_state_origin(1),OH_Direct_Fields.InvalidMessage_state_origin(2)
          ,OH_Direct_Fields.InvalidMessage_append_ownernametypeind(1),OH_Direct_Fields.InvalidMessage_append_ownernametypeind(2)
          ,OH_Direct_Fields.InvalidMessage_append_addlownernametypeind(1),OH_Direct_Fields.InvalidMessage_append_addlownernametypeind(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.categorycode_ENUM_ErrorCount,le.categorycode_LENGTHS_ErrorCount
          ,le.vin_ALLOW_ErrorCount
          ,le.modelyr_ALLOW_ErrorCount,le.modelyr_LENGTHS_ErrorCount
          ,le.titlenum_ALLOW_ErrorCount
          ,le.ownercode_ENUM_ErrorCount,le.ownercode_LENGTHS_ErrorCount
          ,le.grossweight_ALLOW_ErrorCount,le.grossweight_LENGTHS_ErrorCount
          ,le.ownername_CAPS_ErrorCount,le.ownername_ALLOW_ErrorCount
          ,le.ownerstreetaddress_CAPS_ErrorCount,le.ownerstreetaddress_ALLOW_ErrorCount
          ,le.ownercity_CAPS_ErrorCount,le.ownercity_ALLOW_ErrorCount
          ,le.ownerstate_ENUM_ErrorCount,le.ownerstate_LENGTHS_ErrorCount
          ,le.ownerzip_ALLOW_ErrorCount,le.ownerzip_LENGTHS_ErrorCount
          ,le.countynumber_ALLOW_ErrorCount,le.countynumber_LENGTHS_ErrorCount
          ,le.vehiclepurchasedt_ALLOW_ErrorCount,le.vehiclepurchasedt_LENGTHS_ErrorCount
          ,le.vehicletaxweight_ALLOW_ErrorCount,le.vehicletaxweight_LENGTHS_ErrorCount
          ,le.vehicletaxcode_ENUM_ErrorCount,le.vehicletaxcode_LENGTHS_ErrorCount
          ,le.vehicleunladdenweight_ALLOW_ErrorCount,le.vehicleunladdenweight_LENGTHS_ErrorCount
          ,le.additionalownername_CAPS_ErrorCount,le.additionalownername_ALLOW_ErrorCount
          ,le.registrationissuedt_ALLOW_ErrorCount,le.registrationissuedt_LENGTHS_ErrorCount
          ,le.vehiclemake_ALLOW_ErrorCount
          ,le.vehicletype_CAPS_ErrorCount,le.vehicletype_ALLOW_ErrorCount
          ,le.vehicleexpdt_ALLOW_ErrorCount,le.vehicleexpdt_LENGTHS_ErrorCount
          ,le.previousplatenum_CAPS_ErrorCount,le.previousplatenum_ALLOW_ErrorCount
          ,le.platenum_CAPS_ErrorCount,le.platenum_ALLOW_ErrorCount
          ,le.processdate_ALLOW_ErrorCount,le.processdate_LENGTHS_ErrorCount
          ,le.source_code_ENUM_ErrorCount,le.source_code_LENGTHS_ErrorCount
          ,le.state_origin_ENUM_ErrorCount,le.state_origin_LENGTHS_ErrorCount
          ,le.append_ownernametypeind_ENUM_ErrorCount,le.append_ownernametypeind_LENGTHS_ErrorCount
          ,le.append_addlownernametypeind_ENUM_ErrorCount,le.append_addlownernametypeind_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.categorycode_ENUM_ErrorCount,le.categorycode_LENGTHS_ErrorCount
          ,le.vin_ALLOW_ErrorCount
          ,le.modelyr_ALLOW_ErrorCount,le.modelyr_LENGTHS_ErrorCount
          ,le.titlenum_ALLOW_ErrorCount
          ,le.ownercode_ENUM_ErrorCount,le.ownercode_LENGTHS_ErrorCount
          ,le.grossweight_ALLOW_ErrorCount,le.grossweight_LENGTHS_ErrorCount
          ,le.ownername_CAPS_ErrorCount,le.ownername_ALLOW_ErrorCount
          ,le.ownerstreetaddress_CAPS_ErrorCount,le.ownerstreetaddress_ALLOW_ErrorCount
          ,le.ownercity_CAPS_ErrorCount,le.ownercity_ALLOW_ErrorCount
          ,le.ownerstate_ENUM_ErrorCount,le.ownerstate_LENGTHS_ErrorCount
          ,le.ownerzip_ALLOW_ErrorCount,le.ownerzip_LENGTHS_ErrorCount
          ,le.countynumber_ALLOW_ErrorCount,le.countynumber_LENGTHS_ErrorCount
          ,le.vehiclepurchasedt_ALLOW_ErrorCount,le.vehiclepurchasedt_LENGTHS_ErrorCount
          ,le.vehicletaxweight_ALLOW_ErrorCount,le.vehicletaxweight_LENGTHS_ErrorCount
          ,le.vehicletaxcode_ENUM_ErrorCount,le.vehicletaxcode_LENGTHS_ErrorCount
          ,le.vehicleunladdenweight_ALLOW_ErrorCount,le.vehicleunladdenweight_LENGTHS_ErrorCount
          ,le.additionalownername_CAPS_ErrorCount,le.additionalownername_ALLOW_ErrorCount
          ,le.registrationissuedt_ALLOW_ErrorCount,le.registrationissuedt_LENGTHS_ErrorCount
          ,le.vehiclemake_ALLOW_ErrorCount
          ,le.vehicletype_CAPS_ErrorCount,le.vehicletype_ALLOW_ErrorCount
          ,le.vehicleexpdt_ALLOW_ErrorCount,le.vehicleexpdt_LENGTHS_ErrorCount
          ,le.previousplatenum_CAPS_ErrorCount,le.previousplatenum_ALLOW_ErrorCount
          ,le.platenum_CAPS_ErrorCount,le.platenum_ALLOW_ErrorCount
          ,le.processdate_ALLOW_ErrorCount,le.processdate_LENGTHS_ErrorCount
          ,le.source_code_ENUM_ErrorCount,le.source_code_LENGTHS_ErrorCount
          ,le.state_origin_ENUM_ErrorCount,le.state_origin_LENGTHS_ErrorCount
          ,le.append_ownernametypeind_ENUM_ErrorCount,le.append_ownernametypeind_LENGTHS_ErrorCount
          ,le.append_addlownernametypeind_ENUM_ErrorCount,le.append_addlownernametypeind_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);

    // field population stats
    mod_hygiene := OH_Direct_hygiene(PROJECT(h, OH_Direct_Layout_VehicleV2));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'categorycode:' + getFieldTypeText(h.categorycode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vin:' + getFieldTypeText(h.vin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'modelyr:' + getFieldTypeText(h.modelyr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'titlenum:' + getFieldTypeText(h.titlenum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownercode:' + getFieldTypeText(h.ownercode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'grossweight:' + getFieldTypeText(h.grossweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownername:' + getFieldTypeText(h.ownername) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownerstreetaddress:' + getFieldTypeText(h.ownerstreetaddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownercity:' + getFieldTypeText(h.ownercity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownerstate:' + getFieldTypeText(h.ownerstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownerzip:' + getFieldTypeText(h.ownerzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countynumber:' + getFieldTypeText(h.countynumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vehiclepurchasedt:' + getFieldTypeText(h.vehiclepurchasedt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vehicletaxweight:' + getFieldTypeText(h.vehicletaxweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vehicletaxcode:' + getFieldTypeText(h.vehicletaxcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vehicleunladdenweight:' + getFieldTypeText(h.vehicleunladdenweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'additionalownername:' + getFieldTypeText(h.additionalownername) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'registrationissuedt:' + getFieldTypeText(h.registrationissuedt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vehiclemake:' + getFieldTypeText(h.vehiclemake) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vehicletype:' + getFieldTypeText(h.vehicletype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vehicleexpdt:' + getFieldTypeText(h.vehicleexpdt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'previousplatenum:' + getFieldTypeText(h.previousplatenum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'platenum:' + getFieldTypeText(h.platenum) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'processdate:' + getFieldTypeText(h.processdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_code:' + getFieldTypeText(h.source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_origin:' + getFieldTypeText(h.state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_ownernametypeind:' + getFieldTypeText(h.append_ownernametypeind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_addlownernametypeind:' + getFieldTypeText(h.append_addlownernametypeind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_categorycode_cnt
          ,le.populated_vin_cnt
          ,le.populated_modelyr_cnt
          ,le.populated_titlenum_cnt
          ,le.populated_ownercode_cnt
          ,le.populated_grossweight_cnt
          ,le.populated_ownername_cnt
          ,le.populated_ownerstreetaddress_cnt
          ,le.populated_ownercity_cnt
          ,le.populated_ownerstate_cnt
          ,le.populated_ownerzip_cnt
          ,le.populated_countynumber_cnt
          ,le.populated_vehiclepurchasedt_cnt
          ,le.populated_vehicletaxweight_cnt
          ,le.populated_vehicletaxcode_cnt
          ,le.populated_vehicleunladdenweight_cnt
          ,le.populated_additionalownername_cnt
          ,le.populated_registrationissuedt_cnt
          ,le.populated_vehiclemake_cnt
          ,le.populated_vehicletype_cnt
          ,le.populated_vehicleexpdt_cnt
          ,le.populated_previousplatenum_cnt
          ,le.populated_platenum_cnt
          ,le.populated_processdate_cnt
          ,le.populated_source_code_cnt
          ,le.populated_state_origin_cnt
          ,le.populated_append_ownernametypeind_cnt
          ,le.populated_append_addlownernametypeind_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_categorycode_pcnt
          ,le.populated_vin_pcnt
          ,le.populated_modelyr_pcnt
          ,le.populated_titlenum_pcnt
          ,le.populated_ownercode_pcnt
          ,le.populated_grossweight_pcnt
          ,le.populated_ownername_pcnt
          ,le.populated_ownerstreetaddress_pcnt
          ,le.populated_ownercity_pcnt
          ,le.populated_ownerstate_pcnt
          ,le.populated_ownerzip_pcnt
          ,le.populated_countynumber_pcnt
          ,le.populated_vehiclepurchasedt_pcnt
          ,le.populated_vehicletaxweight_pcnt
          ,le.populated_vehicletaxcode_pcnt
          ,le.populated_vehicleunladdenweight_pcnt
          ,le.populated_additionalownername_pcnt
          ,le.populated_registrationissuedt_pcnt
          ,le.populated_vehiclemake_pcnt
          ,le.populated_vehicletype_pcnt
          ,le.populated_vehicleexpdt_pcnt
          ,le.populated_previousplatenum_pcnt
          ,le.populated_platenum_pcnt
          ,le.populated_processdate_pcnt
          ,le.populated_source_code_pcnt
          ,le.populated_state_origin_pcnt
          ,le.populated_append_ownernametypeind_pcnt
          ,le.populated_append_addlownernametypeind_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,28,xNormHygieneStats(LEFT,COUNTER,'POP'));

  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));

    mod_Delta := OH_Direct_Delta(prevDS, PROJECT(h, OH_Direct_Layout_VehicleV2));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),28,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(OH_Direct_Layout_VehicleV2) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_VehicleV2, OH_Direct_Fields, 'RECORDOF(scrubsSummaryOverall)', 'source_code');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));

  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);

  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, source_code, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));

  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
