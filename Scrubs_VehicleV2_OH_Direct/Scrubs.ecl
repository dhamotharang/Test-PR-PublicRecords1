IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Profile_VehicleV2_OH_Direct)
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
  EXPORT  Bitmap_Layout := RECORD(Layout_Profile_VehicleV2_OH_Direct)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_Profile_VehicleV2_OH_Direct) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.categorycode_Invalid := Fields.InValid_categorycode((SALT30.StrType)le.categorycode);
    SELF.vin_Invalid := Fields.InValid_vin((SALT30.StrType)le.vin);
    SELF.modelyr_Invalid := Fields.InValid_modelyr((SALT30.StrType)le.modelyr);
    SELF.titlenum_Invalid := Fields.InValid_titlenum((SALT30.StrType)le.titlenum);
    SELF.ownercode_Invalid := Fields.InValid_ownercode((SALT30.StrType)le.ownercode);
    SELF.grossweight_Invalid := Fields.InValid_grossweight((SALT30.StrType)le.grossweight);
    SELF.ownername_Invalid := Fields.InValid_ownername((SALT30.StrType)le.ownername);
    SELF.ownerstreetaddress_Invalid := Fields.InValid_ownerstreetaddress((SALT30.StrType)le.ownerstreetaddress);
    SELF.ownercity_Invalid := Fields.InValid_ownercity((SALT30.StrType)le.ownercity);
    SELF.ownerstate_Invalid := Fields.InValid_ownerstate((SALT30.StrType)le.ownerstate);
    SELF.ownerzip_Invalid := Fields.InValid_ownerzip((SALT30.StrType)le.ownerzip);
    SELF.countynumber_Invalid := Fields.InValid_countynumber((SALT30.StrType)le.countynumber);
    SELF.vehiclepurchasedt_Invalid := Fields.InValid_vehiclepurchasedt((SALT30.StrType)le.vehiclepurchasedt);
    SELF.vehicletaxweight_Invalid := Fields.InValid_vehicletaxweight((SALT30.StrType)le.vehicletaxweight);
    SELF.vehicletaxcode_Invalid := Fields.InValid_vehicletaxcode((SALT30.StrType)le.vehicletaxcode);
    SELF.vehicleunladdenweight_Invalid := Fields.InValid_vehicleunladdenweight((SALT30.StrType)le.vehicleunladdenweight);
    SELF.additionalownername_Invalid := Fields.InValid_additionalownername((SALT30.StrType)le.additionalownername);
    SELF.registrationissuedt_Invalid := Fields.InValid_registrationissuedt((SALT30.StrType)le.registrationissuedt);
    SELF.vehiclemake_Invalid := Fields.InValid_vehiclemake((SALT30.StrType)le.vehiclemake);
    SELF.vehicletype_Invalid := Fields.InValid_vehicletype((SALT30.StrType)le.vehicletype);
    SELF.vehicleexpdt_Invalid := Fields.InValid_vehicleexpdt((SALT30.StrType)le.vehicleexpdt);
    SELF.previousplatenum_Invalid := Fields.InValid_previousplatenum((SALT30.StrType)le.previousplatenum);
    SELF.platenum_Invalid := Fields.InValid_platenum((SALT30.StrType)le.platenum);
    SELF.processdate_Invalid := Fields.InValid_processdate((SALT30.StrType)le.processdate);
    SELF.source_code_Invalid := Fields.InValid_source_code((SALT30.StrType)le.source_code);
    SELF.state_origin_Invalid := Fields.InValid_state_origin((SALT30.StrType)le.state_origin);
    SELF.append_ownernametypeind_Invalid := Fields.InValid_append_ownernametypeind((SALT30.StrType)le.append_ownernametypeind);
    SELF.append_addlownernametypeind_Invalid := Fields.InValid_append_addlownernametypeind((SALT30.StrType)le.append_addlownernametypeind);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.categorycode_Invalid << 0 ) + ( le.vin_Invalid << 2 ) + ( le.modelyr_Invalid << 3 ) + ( le.titlenum_Invalid << 5 ) + ( le.ownercode_Invalid << 6 ) + ( le.grossweight_Invalid << 8 ) + ( le.ownername_Invalid << 10 ) + ( le.ownerstreetaddress_Invalid << 12 ) + ( le.ownercity_Invalid << 14 ) + ( le.ownerstate_Invalid << 16 ) + ( le.ownerzip_Invalid << 18 ) + ( le.countynumber_Invalid << 20 ) + ( le.vehiclepurchasedt_Invalid << 22 ) + ( le.vehicletaxweight_Invalid << 24 ) + ( le.vehicletaxcode_Invalid << 26 ) + ( le.vehicleunladdenweight_Invalid << 28 ) + ( le.additionalownername_Invalid << 30 ) + ( le.registrationissuedt_Invalid << 32 ) + ( le.vehiclemake_Invalid << 34 ) + ( le.vehicletype_Invalid << 35 ) + ( le.vehicleexpdt_Invalid << 37 ) + ( le.previousplatenum_Invalid << 39 ) + ( le.platenum_Invalid << 41 ) + ( le.processdate_Invalid << 43 ) + ( le.source_code_Invalid << 45 ) + ( le.state_origin_Invalid << 47 ) + ( le.append_ownernametypeind_Invalid << 49 ) + ( le.append_addlownernametypeind_Invalid << 51 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Profile_VehicleV2_OH_Direct);
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
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source_code;
    TotalCnt := COUNT(GROUP); // Number of records in total
    categorycode_ENUM_ErrorCount := COUNT(GROUP,h.categorycode_Invalid=1);
    categorycode_LENGTH_ErrorCount := COUNT(GROUP,h.categorycode_Invalid=2);
    categorycode_Total_ErrorCount := COUNT(GROUP,h.categorycode_Invalid>0);
    vin_ALLOW_ErrorCount := COUNT(GROUP,h.vin_Invalid=1);
    modelyr_ALLOW_ErrorCount := COUNT(GROUP,h.modelyr_Invalid=1);
    modelyr_LENGTH_ErrorCount := COUNT(GROUP,h.modelyr_Invalid=2);
    modelyr_Total_ErrorCount := COUNT(GROUP,h.modelyr_Invalid>0);
    titlenum_ALLOW_ErrorCount := COUNT(GROUP,h.titlenum_Invalid=1);
    ownercode_ENUM_ErrorCount := COUNT(GROUP,h.ownercode_Invalid=1);
    ownercode_LENGTH_ErrorCount := COUNT(GROUP,h.ownercode_Invalid=2);
    ownercode_Total_ErrorCount := COUNT(GROUP,h.ownercode_Invalid>0);
    grossweight_ALLOW_ErrorCount := COUNT(GROUP,h.grossweight_Invalid=1);
    grossweight_LENGTH_ErrorCount := COUNT(GROUP,h.grossweight_Invalid=2);
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
    ownerstate_LENGTH_ErrorCount := COUNT(GROUP,h.ownerstate_Invalid=2);
    ownerstate_Total_ErrorCount := COUNT(GROUP,h.ownerstate_Invalid>0);
    ownerzip_ALLOW_ErrorCount := COUNT(GROUP,h.ownerzip_Invalid=1);
    ownerzip_LENGTH_ErrorCount := COUNT(GROUP,h.ownerzip_Invalid=2);
    ownerzip_Total_ErrorCount := COUNT(GROUP,h.ownerzip_Invalid>0);
    countynumber_ALLOW_ErrorCount := COUNT(GROUP,h.countynumber_Invalid=1);
    countynumber_LENGTH_ErrorCount := COUNT(GROUP,h.countynumber_Invalid=2);
    countynumber_Total_ErrorCount := COUNT(GROUP,h.countynumber_Invalid>0);
    vehiclepurchasedt_ALLOW_ErrorCount := COUNT(GROUP,h.vehiclepurchasedt_Invalid=1);
    vehiclepurchasedt_LENGTH_ErrorCount := COUNT(GROUP,h.vehiclepurchasedt_Invalid=2);
    vehiclepurchasedt_Total_ErrorCount := COUNT(GROUP,h.vehiclepurchasedt_Invalid>0);
    vehicletaxweight_ALLOW_ErrorCount := COUNT(GROUP,h.vehicletaxweight_Invalid=1);
    vehicletaxweight_LENGTH_ErrorCount := COUNT(GROUP,h.vehicletaxweight_Invalid=2);
    vehicletaxweight_Total_ErrorCount := COUNT(GROUP,h.vehicletaxweight_Invalid>0);
    vehicletaxcode_ENUM_ErrorCount := COUNT(GROUP,h.vehicletaxcode_Invalid=1);
    vehicletaxcode_LENGTH_ErrorCount := COUNT(GROUP,h.vehicletaxcode_Invalid=2);
    vehicletaxcode_Total_ErrorCount := COUNT(GROUP,h.vehicletaxcode_Invalid>0);
    vehicleunladdenweight_ALLOW_ErrorCount := COUNT(GROUP,h.vehicleunladdenweight_Invalid=1);
    vehicleunladdenweight_LENGTH_ErrorCount := COUNT(GROUP,h.vehicleunladdenweight_Invalid=2);
    vehicleunladdenweight_Total_ErrorCount := COUNT(GROUP,h.vehicleunladdenweight_Invalid>0);
    additionalownername_CAPS_ErrorCount := COUNT(GROUP,h.additionalownername_Invalid=1);
    additionalownername_ALLOW_ErrorCount := COUNT(GROUP,h.additionalownername_Invalid=2);
    additionalownername_Total_ErrorCount := COUNT(GROUP,h.additionalownername_Invalid>0);
    registrationissuedt_ALLOW_ErrorCount := COUNT(GROUP,h.registrationissuedt_Invalid=1);
    registrationissuedt_LENGTH_ErrorCount := COUNT(GROUP,h.registrationissuedt_Invalid=2);
    registrationissuedt_Total_ErrorCount := COUNT(GROUP,h.registrationissuedt_Invalid>0);
    vehiclemake_ALLOW_ErrorCount := COUNT(GROUP,h.vehiclemake_Invalid=1);
    vehicletype_CAPS_ErrorCount := COUNT(GROUP,h.vehicletype_Invalid=1);
    vehicletype_ALLOW_ErrorCount := COUNT(GROUP,h.vehicletype_Invalid=2);
    vehicletype_Total_ErrorCount := COUNT(GROUP,h.vehicletype_Invalid>0);
    vehicleexpdt_ALLOW_ErrorCount := COUNT(GROUP,h.vehicleexpdt_Invalid=1);
    vehicleexpdt_LENGTH_ErrorCount := COUNT(GROUP,h.vehicleexpdt_Invalid=2);
    vehicleexpdt_Total_ErrorCount := COUNT(GROUP,h.vehicleexpdt_Invalid>0);
    previousplatenum_CAPS_ErrorCount := COUNT(GROUP,h.previousplatenum_Invalid=1);
    previousplatenum_ALLOW_ErrorCount := COUNT(GROUP,h.previousplatenum_Invalid=2);
    previousplatenum_Total_ErrorCount := COUNT(GROUP,h.previousplatenum_Invalid>0);
    platenum_CAPS_ErrorCount := COUNT(GROUP,h.platenum_Invalid=1);
    platenum_ALLOW_ErrorCount := COUNT(GROUP,h.platenum_Invalid=2);
    platenum_Total_ErrorCount := COUNT(GROUP,h.platenum_Invalid>0);
    processdate_ALLOW_ErrorCount := COUNT(GROUP,h.processdate_Invalid=1);
    processdate_LENGTH_ErrorCount := COUNT(GROUP,h.processdate_Invalid=2);
    processdate_Total_ErrorCount := COUNT(GROUP,h.processdate_Invalid>0);
    source_code_ENUM_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    source_code_LENGTH_ErrorCount := COUNT(GROUP,h.source_code_Invalid=2);
    source_code_Total_ErrorCount := COUNT(GROUP,h.source_code_Invalid>0);
    state_origin_ENUM_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    state_origin_LENGTH_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=2);
    state_origin_Total_ErrorCount := COUNT(GROUP,h.state_origin_Invalid>0);
    append_ownernametypeind_ENUM_ErrorCount := COUNT(GROUP,h.append_ownernametypeind_Invalid=1);
    append_ownernametypeind_LENGTH_ErrorCount := COUNT(GROUP,h.append_ownernametypeind_Invalid=2);
    append_ownernametypeind_Total_ErrorCount := COUNT(GROUP,h.append_ownernametypeind_Invalid>0);
    append_addlownernametypeind_ENUM_ErrorCount := COUNT(GROUP,h.append_addlownernametypeind_Invalid=1);
    append_addlownernametypeind_LENGTH_ErrorCount := COUNT(GROUP,h.append_addlownernametypeind_Invalid=2);
    append_addlownernametypeind_Total_ErrorCount := COUNT(GROUP,h.append_addlownernametypeind_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,source_code,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.source_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.categorycode_Invalid,le.vin_Invalid,le.modelyr_Invalid,le.titlenum_Invalid,le.ownercode_Invalid,le.grossweight_Invalid,le.ownername_Invalid,le.ownerstreetaddress_Invalid,le.ownercity_Invalid,le.ownerstate_Invalid,le.ownerzip_Invalid,le.countynumber_Invalid,le.vehiclepurchasedt_Invalid,le.vehicletaxweight_Invalid,le.vehicletaxcode_Invalid,le.vehicleunladdenweight_Invalid,le.additionalownername_Invalid,le.registrationissuedt_Invalid,le.vehiclemake_Invalid,le.vehicletype_Invalid,le.vehicleexpdt_Invalid,le.previousplatenum_Invalid,le.platenum_Invalid,le.processdate_Invalid,le.source_code_Invalid,le.state_origin_Invalid,le.append_ownernametypeind_Invalid,le.append_addlownernametypeind_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_categorycode(le.categorycode_Invalid),Fields.InvalidMessage_vin(le.vin_Invalid),Fields.InvalidMessage_modelyr(le.modelyr_Invalid),Fields.InvalidMessage_titlenum(le.titlenum_Invalid),Fields.InvalidMessage_ownercode(le.ownercode_Invalid),Fields.InvalidMessage_grossweight(le.grossweight_Invalid),Fields.InvalidMessage_ownername(le.ownername_Invalid),Fields.InvalidMessage_ownerstreetaddress(le.ownerstreetaddress_Invalid),Fields.InvalidMessage_ownercity(le.ownercity_Invalid),Fields.InvalidMessage_ownerstate(le.ownerstate_Invalid),Fields.InvalidMessage_ownerzip(le.ownerzip_Invalid),Fields.InvalidMessage_countynumber(le.countynumber_Invalid),Fields.InvalidMessage_vehiclepurchasedt(le.vehiclepurchasedt_Invalid),Fields.InvalidMessage_vehicletaxweight(le.vehicletaxweight_Invalid),Fields.InvalidMessage_vehicletaxcode(le.vehicletaxcode_Invalid),Fields.InvalidMessage_vehicleunladdenweight(le.vehicleunladdenweight_Invalid),Fields.InvalidMessage_additionalownername(le.additionalownername_Invalid),Fields.InvalidMessage_registrationissuedt(le.registrationissuedt_Invalid),Fields.InvalidMessage_vehiclemake(le.vehiclemake_Invalid),Fields.InvalidMessage_vehicletype(le.vehicletype_Invalid),Fields.InvalidMessage_vehicleexpdt(le.vehicleexpdt_Invalid),Fields.InvalidMessage_previousplatenum(le.previousplatenum_Invalid),Fields.InvalidMessage_platenum(le.platenum_Invalid),Fields.InvalidMessage_processdate(le.processdate_Invalid),Fields.InvalidMessage_source_code(le.source_code_Invalid),Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Fields.InvalidMessage_append_ownernametypeind(le.append_ownernametypeind_Invalid),Fields.InvalidMessage_append_addlownernametypeind(le.append_addlownernametypeind_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.categorycode_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.vin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.modelyr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.titlenum_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ownercode_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.grossweight_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ownername_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.ownerstreetaddress_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.ownercity_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.ownerstate_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ownerzip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.countynumber_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.vehiclepurchasedt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.vehicletaxweight_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.vehicletaxcode_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.vehicleunladdenweight_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.additionalownername_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.registrationissuedt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.vehiclemake_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vehicletype_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.vehicleexpdt_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.previousplatenum_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.platenum_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.processdate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.append_ownernametypeind_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.append_addlownernametypeind_Invalid,'ENUM','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'categorycode','vin','modelyr','titlenum','ownercode','grossweight','ownername','ownerstreetaddress','ownercity','ownerstate','ownerzip','countynumber','vehiclepurchasedt','vehicletaxweight','vehicletaxcode','vehicleunladdenweight','additionalownername','registrationissuedt','vehiclemake','vehicletype','vehicleexpdt','previousplatenum','platenum','processdate','source_code','state_origin','append_ownernametypeind','append_addlownernametypeind','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_categorycode','invalid_vin','invalid_year','invalid_titlenum','invalid_ownercode','invalid_weight','invalid_alpha','invalid_alpha','invalid_only_alpha','invalid_state','invalid_zip','invalid_countycode','invalid_date','invalid_weight','invalid_vehicletaxcode','invalid_weight','invalid_alpha','invalid_date','invalid_vehiclemake','invalid_alphanumeric','invalid_date','invalid_alphanumeric','invalid_alphanumeric','invalid_date','invalid_source_code','invalid_state','invalid_append_ownernametypeind','invalid_append_ownernametypeind','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.categorycode,(SALT30.StrType)le.vin,(SALT30.StrType)le.modelyr,(SALT30.StrType)le.titlenum,(SALT30.StrType)le.ownercode,(SALT30.StrType)le.grossweight,(SALT30.StrType)le.ownername,(SALT30.StrType)le.ownerstreetaddress,(SALT30.StrType)le.ownercity,(SALT30.StrType)le.ownerstate,(SALT30.StrType)le.ownerzip,(SALT30.StrType)le.countynumber,(SALT30.StrType)le.vehiclepurchasedt,(SALT30.StrType)le.vehicletaxweight,(SALT30.StrType)le.vehicletaxcode,(SALT30.StrType)le.vehicleunladdenweight,(SALT30.StrType)le.additionalownername,(SALT30.StrType)le.registrationissuedt,(SALT30.StrType)le.vehiclemake,(SALT30.StrType)le.vehicletype,(SALT30.StrType)le.vehicleexpdt,(SALT30.StrType)le.previousplatenum,(SALT30.StrType)le.platenum,(SALT30.StrType)le.processdate,(SALT30.StrType)le.source_code,(SALT30.StrType)le.state_origin,(SALT30.StrType)le.append_ownernametypeind,(SALT30.StrType)le.append_addlownernametypeind,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,28,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_code;
      SELF.ruledesc := CHOOSE(c
          ,'categorycode:invalid_categorycode:ENUM','categorycode:invalid_categorycode:LENGTH'
          ,'vin:invalid_vin:ALLOW'
          ,'modelyr:invalid_year:ALLOW','modelyr:invalid_year:LENGTH'
          ,'titlenum:invalid_titlenum:ALLOW'
          ,'ownercode:invalid_ownercode:ENUM','ownercode:invalid_ownercode:LENGTH'
          ,'grossweight:invalid_weight:ALLOW','grossweight:invalid_weight:LENGTH'
          ,'ownername:invalid_alpha:CAPS','ownername:invalid_alpha:ALLOW'
          ,'ownerstreetaddress:invalid_alpha:CAPS','ownerstreetaddress:invalid_alpha:ALLOW'
          ,'ownercity:invalid_only_alpha:CAPS','ownercity:invalid_only_alpha:ALLOW'
          ,'ownerstate:invalid_state:ENUM','ownerstate:invalid_state:LENGTH'
          ,'ownerzip:invalid_zip:ALLOW','ownerzip:invalid_zip:LENGTH'
          ,'countynumber:invalid_countycode:ALLOW','countynumber:invalid_countycode:LENGTH'
          ,'vehiclepurchasedt:invalid_date:ALLOW','vehiclepurchasedt:invalid_date:LENGTH'
          ,'vehicletaxweight:invalid_weight:ALLOW','vehicletaxweight:invalid_weight:LENGTH'
          ,'vehicletaxcode:invalid_vehicletaxcode:ENUM','vehicletaxcode:invalid_vehicletaxcode:LENGTH'
          ,'vehicleunladdenweight:invalid_weight:ALLOW','vehicleunladdenweight:invalid_weight:LENGTH'
          ,'additionalownername:invalid_alpha:CAPS','additionalownername:invalid_alpha:ALLOW'
          ,'registrationissuedt:invalid_date:ALLOW','registrationissuedt:invalid_date:LENGTH'
          ,'vehiclemake:invalid_vehiclemake:ALLOW'
          ,'vehicletype:invalid_alphanumeric:CAPS','vehicletype:invalid_alphanumeric:ALLOW'
          ,'vehicleexpdt:invalid_date:ALLOW','vehicleexpdt:invalid_date:LENGTH'
          ,'previousplatenum:invalid_alphanumeric:CAPS','previousplatenum:invalid_alphanumeric:ALLOW'
          ,'platenum:invalid_alphanumeric:CAPS','platenum:invalid_alphanumeric:ALLOW'
          ,'processdate:invalid_date:ALLOW','processdate:invalid_date:LENGTH'
          ,'source_code:invalid_source_code:ENUM','source_code:invalid_source_code:LENGTH'
          ,'state_origin:invalid_state:ENUM','state_origin:invalid_state:LENGTH'
          ,'append_ownernametypeind:invalid_append_ownernametypeind:ENUM','append_ownernametypeind:invalid_append_ownernametypeind:LENGTH'
          ,'append_addlownernametypeind:invalid_append_ownernametypeind:ENUM','append_addlownernametypeind:invalid_append_ownernametypeind:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.categorycode_ENUM_ErrorCount,le.categorycode_LENGTH_ErrorCount
          ,le.vin_ALLOW_ErrorCount
          ,le.modelyr_ALLOW_ErrorCount,le.modelyr_LENGTH_ErrorCount
          ,le.titlenum_ALLOW_ErrorCount
          ,le.ownercode_ENUM_ErrorCount,le.ownercode_LENGTH_ErrorCount
          ,le.grossweight_ALLOW_ErrorCount,le.grossweight_LENGTH_ErrorCount
          ,le.ownername_CAPS_ErrorCount,le.ownername_ALLOW_ErrorCount
          ,le.ownerstreetaddress_CAPS_ErrorCount,le.ownerstreetaddress_ALLOW_ErrorCount
          ,le.ownercity_CAPS_ErrorCount,le.ownercity_ALLOW_ErrorCount
          ,le.ownerstate_ENUM_ErrorCount,le.ownerstate_LENGTH_ErrorCount
          ,le.ownerzip_ALLOW_ErrorCount,le.ownerzip_LENGTH_ErrorCount
          ,le.countynumber_ALLOW_ErrorCount,le.countynumber_LENGTH_ErrorCount
          ,le.vehiclepurchasedt_ALLOW_ErrorCount,le.vehiclepurchasedt_LENGTH_ErrorCount
          ,le.vehicletaxweight_ALLOW_ErrorCount,le.vehicletaxweight_LENGTH_ErrorCount
          ,le.vehicletaxcode_ENUM_ErrorCount,le.vehicletaxcode_LENGTH_ErrorCount
          ,le.vehicleunladdenweight_ALLOW_ErrorCount,le.vehicleunladdenweight_LENGTH_ErrorCount
          ,le.additionalownername_CAPS_ErrorCount,le.additionalownername_ALLOW_ErrorCount
          ,le.registrationissuedt_ALLOW_ErrorCount,le.registrationissuedt_LENGTH_ErrorCount
          ,le.vehiclemake_ALLOW_ErrorCount
          ,le.vehicletype_CAPS_ErrorCount,le.vehicletype_ALLOW_ErrorCount
          ,le.vehicleexpdt_ALLOW_ErrorCount,le.vehicleexpdt_LENGTH_ErrorCount
          ,le.previousplatenum_CAPS_ErrorCount,le.previousplatenum_ALLOW_ErrorCount
          ,le.platenum_CAPS_ErrorCount,le.platenum_ALLOW_ErrorCount
          ,le.processdate_ALLOW_ErrorCount,le.processdate_LENGTH_ErrorCount
          ,le.source_code_ENUM_ErrorCount,le.source_code_LENGTH_ErrorCount
          ,le.state_origin_ENUM_ErrorCount,le.state_origin_LENGTH_ErrorCount
          ,le.append_ownernametypeind_ENUM_ErrorCount,le.append_ownernametypeind_LENGTH_ErrorCount
          ,le.append_addlownernametypeind_ENUM_ErrorCount,le.append_addlownernametypeind_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.categorycode_ENUM_ErrorCount,le.categorycode_LENGTH_ErrorCount
          ,le.vin_ALLOW_ErrorCount
          ,le.modelyr_ALLOW_ErrorCount,le.modelyr_LENGTH_ErrorCount
          ,le.titlenum_ALLOW_ErrorCount
          ,le.ownercode_ENUM_ErrorCount,le.ownercode_LENGTH_ErrorCount
          ,le.grossweight_ALLOW_ErrorCount,le.grossweight_LENGTH_ErrorCount
          ,le.ownername_CAPS_ErrorCount,le.ownername_ALLOW_ErrorCount
          ,le.ownerstreetaddress_CAPS_ErrorCount,le.ownerstreetaddress_ALLOW_ErrorCount
          ,le.ownercity_CAPS_ErrorCount,le.ownercity_ALLOW_ErrorCount
          ,le.ownerstate_ENUM_ErrorCount,le.ownerstate_LENGTH_ErrorCount
          ,le.ownerzip_ALLOW_ErrorCount,le.ownerzip_LENGTH_ErrorCount
          ,le.countynumber_ALLOW_ErrorCount,le.countynumber_LENGTH_ErrorCount
          ,le.vehiclepurchasedt_ALLOW_ErrorCount,le.vehiclepurchasedt_LENGTH_ErrorCount
          ,le.vehicletaxweight_ALLOW_ErrorCount,le.vehicletaxweight_LENGTH_ErrorCount
          ,le.vehicletaxcode_ENUM_ErrorCount,le.vehicletaxcode_LENGTH_ErrorCount
          ,le.vehicleunladdenweight_ALLOW_ErrorCount,le.vehicleunladdenweight_LENGTH_ErrorCount
          ,le.additionalownername_CAPS_ErrorCount,le.additionalownername_ALLOW_ErrorCount
          ,le.registrationissuedt_ALLOW_ErrorCount,le.registrationissuedt_LENGTH_ErrorCount
          ,le.vehiclemake_ALLOW_ErrorCount
          ,le.vehicletype_CAPS_ErrorCount,le.vehicletype_ALLOW_ErrorCount
          ,le.vehicleexpdt_ALLOW_ErrorCount,le.vehicleexpdt_LENGTH_ErrorCount
          ,le.previousplatenum_CAPS_ErrorCount,le.previousplatenum_ALLOW_ErrorCount
          ,le.platenum_CAPS_ErrorCount,le.platenum_ALLOW_ErrorCount
          ,le.processdate_ALLOW_ErrorCount,le.processdate_LENGTH_ErrorCount
          ,le.source_code_ENUM_ErrorCount,le.source_code_LENGTH_ErrorCount
          ,le.state_origin_ENUM_ErrorCount,le.state_origin_LENGTH_ErrorCount
          ,le.append_ownernametypeind_ENUM_ErrorCount,le.append_ownernametypeind_LENGTH_ErrorCount
          ,le.append_addlownernametypeind_ENUM_ErrorCount,le.append_addlownernametypeind_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,53,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
