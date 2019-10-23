IMPORT SALT311,STD;
EXPORT OH_Direct_hygiene(dataset(OH_Direct_layout_VehicleV2) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.source_code))'', MAX(GROUP,h.source_code));
    NumberOfRecords := COUNT(GROUP);
    populated_categorycode_cnt := COUNT(GROUP,h.categorycode <> (TYPEOF(h.categorycode))'');
    populated_categorycode_pcnt := AVE(GROUP,IF(h.categorycode = (TYPEOF(h.categorycode))'',0,100));
    maxlength_categorycode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.categorycode)));
    avelength_categorycode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.categorycode)),h.categorycode<>(typeof(h.categorycode))'');
    populated_vin_cnt := COUNT(GROUP,h.vin <> (TYPEOF(h.vin))'');
    populated_vin_pcnt := AVE(GROUP,IF(h.vin = (TYPEOF(h.vin))'',0,100));
    maxlength_vin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vin)));
    avelength_vin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vin)),h.vin<>(typeof(h.vin))'');
    populated_modelyr_cnt := COUNT(GROUP,h.modelyr <> (TYPEOF(h.modelyr))'');
    populated_modelyr_pcnt := AVE(GROUP,IF(h.modelyr = (TYPEOF(h.modelyr))'',0,100));
    maxlength_modelyr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.modelyr)));
    avelength_modelyr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.modelyr)),h.modelyr<>(typeof(h.modelyr))'');
    populated_titlenum_cnt := COUNT(GROUP,h.titlenum <> (TYPEOF(h.titlenum))'');
    populated_titlenum_pcnt := AVE(GROUP,IF(h.titlenum = (TYPEOF(h.titlenum))'',0,100));
    maxlength_titlenum := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.titlenum)));
    avelength_titlenum := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.titlenum)),h.titlenum<>(typeof(h.titlenum))'');
    populated_ownercode_cnt := COUNT(GROUP,h.ownercode <> (TYPEOF(h.ownercode))'');
    populated_ownercode_pcnt := AVE(GROUP,IF(h.ownercode = (TYPEOF(h.ownercode))'',0,100));
    maxlength_ownercode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownercode)));
    avelength_ownercode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownercode)),h.ownercode<>(typeof(h.ownercode))'');
    populated_grossweight_cnt := COUNT(GROUP,h.grossweight <> (TYPEOF(h.grossweight))'');
    populated_grossweight_pcnt := AVE(GROUP,IF(h.grossweight = (TYPEOF(h.grossweight))'',0,100));
    maxlength_grossweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.grossweight)));
    avelength_grossweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.grossweight)),h.grossweight<>(typeof(h.grossweight))'');
    populated_ownername_cnt := COUNT(GROUP,h.ownername <> (TYPEOF(h.ownername))'');
    populated_ownername_pcnt := AVE(GROUP,IF(h.ownername = (TYPEOF(h.ownername))'',0,100));
    maxlength_ownername := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownername)));
    avelength_ownername := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownername)),h.ownername<>(typeof(h.ownername))'');
    populated_ownerstreetaddress_cnt := COUNT(GROUP,h.ownerstreetaddress <> (TYPEOF(h.ownerstreetaddress))'');
    populated_ownerstreetaddress_pcnt := AVE(GROUP,IF(h.ownerstreetaddress = (TYPEOF(h.ownerstreetaddress))'',0,100));
    maxlength_ownerstreetaddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownerstreetaddress)));
    avelength_ownerstreetaddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownerstreetaddress)),h.ownerstreetaddress<>(typeof(h.ownerstreetaddress))'');
    populated_ownercity_cnt := COUNT(GROUP,h.ownercity <> (TYPEOF(h.ownercity))'');
    populated_ownercity_pcnt := AVE(GROUP,IF(h.ownercity = (TYPEOF(h.ownercity))'',0,100));
    maxlength_ownercity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownercity)));
    avelength_ownercity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownercity)),h.ownercity<>(typeof(h.ownercity))'');
    populated_ownerstate_cnt := COUNT(GROUP,h.ownerstate <> (TYPEOF(h.ownerstate))'');
    populated_ownerstate_pcnt := AVE(GROUP,IF(h.ownerstate = (TYPEOF(h.ownerstate))'',0,100));
    maxlength_ownerstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownerstate)));
    avelength_ownerstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownerstate)),h.ownerstate<>(typeof(h.ownerstate))'');
    populated_ownerzip_cnt := COUNT(GROUP,h.ownerzip <> (TYPEOF(h.ownerzip))'');
    populated_ownerzip_pcnt := AVE(GROUP,IF(h.ownerzip = (TYPEOF(h.ownerzip))'',0,100));
    maxlength_ownerzip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownerzip)));
    avelength_ownerzip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ownerzip)),h.ownerzip<>(typeof(h.ownerzip))'');
    populated_countynumber_cnt := COUNT(GROUP,h.countynumber <> (TYPEOF(h.countynumber))'');
    populated_countynumber_pcnt := AVE(GROUP,IF(h.countynumber = (TYPEOF(h.countynumber))'',0,100));
    maxlength_countynumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.countynumber)));
    avelength_countynumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.countynumber)),h.countynumber<>(typeof(h.countynumber))'');
    populated_vehiclepurchasedt_cnt := COUNT(GROUP,h.vehiclepurchasedt <> (TYPEOF(h.vehiclepurchasedt))'');
    populated_vehiclepurchasedt_pcnt := AVE(GROUP,IF(h.vehiclepurchasedt = (TYPEOF(h.vehiclepurchasedt))'',0,100));
    maxlength_vehiclepurchasedt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehiclepurchasedt)));
    avelength_vehiclepurchasedt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehiclepurchasedt)),h.vehiclepurchasedt<>(typeof(h.vehiclepurchasedt))'');
    populated_vehicletaxweight_cnt := COUNT(GROUP,h.vehicletaxweight <> (TYPEOF(h.vehicletaxweight))'');
    populated_vehicletaxweight_pcnt := AVE(GROUP,IF(h.vehicletaxweight = (TYPEOF(h.vehicletaxweight))'',0,100));
    maxlength_vehicletaxweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicletaxweight)));
    avelength_vehicletaxweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicletaxweight)),h.vehicletaxweight<>(typeof(h.vehicletaxweight))'');
    populated_vehicletaxcode_cnt := COUNT(GROUP,h.vehicletaxcode <> (TYPEOF(h.vehicletaxcode))'');
    populated_vehicletaxcode_pcnt := AVE(GROUP,IF(h.vehicletaxcode = (TYPEOF(h.vehicletaxcode))'',0,100));
    maxlength_vehicletaxcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicletaxcode)));
    avelength_vehicletaxcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicletaxcode)),h.vehicletaxcode<>(typeof(h.vehicletaxcode))'');
    populated_vehicleunladdenweight_cnt := COUNT(GROUP,h.vehicleunladdenweight <> (TYPEOF(h.vehicleunladdenweight))'');
    populated_vehicleunladdenweight_pcnt := AVE(GROUP,IF(h.vehicleunladdenweight = (TYPEOF(h.vehicleunladdenweight))'',0,100));
    maxlength_vehicleunladdenweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicleunladdenweight)));
    avelength_vehicleunladdenweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicleunladdenweight)),h.vehicleunladdenweight<>(typeof(h.vehicleunladdenweight))'');
    populated_additionalownername_cnt := COUNT(GROUP,h.additionalownername <> (TYPEOF(h.additionalownername))'');
    populated_additionalownername_pcnt := AVE(GROUP,IF(h.additionalownername = (TYPEOF(h.additionalownername))'',0,100));
    maxlength_additionalownername := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.additionalownername)));
    avelength_additionalownername := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.additionalownername)),h.additionalownername<>(typeof(h.additionalownername))'');
    populated_registrationissuedt_cnt := COUNT(GROUP,h.registrationissuedt <> (TYPEOF(h.registrationissuedt))'');
    populated_registrationissuedt_pcnt := AVE(GROUP,IF(h.registrationissuedt = (TYPEOF(h.registrationissuedt))'',0,100));
    maxlength_registrationissuedt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrationissuedt)));
    avelength_registrationissuedt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.registrationissuedt)),h.registrationissuedt<>(typeof(h.registrationissuedt))'');
    populated_vehiclemake_cnt := COUNT(GROUP,h.vehiclemake <> (TYPEOF(h.vehiclemake))'');
    populated_vehiclemake_pcnt := AVE(GROUP,IF(h.vehiclemake = (TYPEOF(h.vehiclemake))'',0,100));
    maxlength_vehiclemake := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehiclemake)));
    avelength_vehiclemake := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehiclemake)),h.vehiclemake<>(typeof(h.vehiclemake))'');
    populated_vehicletype_cnt := COUNT(GROUP,h.vehicletype <> (TYPEOF(h.vehicletype))'');
    populated_vehicletype_pcnt := AVE(GROUP,IF(h.vehicletype = (TYPEOF(h.vehicletype))'',0,100));
    maxlength_vehicletype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicletype)));
    avelength_vehicletype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicletype)),h.vehicletype<>(typeof(h.vehicletype))'');
    populated_vehicleexpdt_cnt := COUNT(GROUP,h.vehicleexpdt <> (TYPEOF(h.vehicleexpdt))'');
    populated_vehicleexpdt_pcnt := AVE(GROUP,IF(h.vehicleexpdt = (TYPEOF(h.vehicleexpdt))'',0,100));
    maxlength_vehicleexpdt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicleexpdt)));
    avelength_vehicleexpdt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vehicleexpdt)),h.vehicleexpdt<>(typeof(h.vehicleexpdt))'');
    populated_previousplatenum_cnt := COUNT(GROUP,h.previousplatenum <> (TYPEOF(h.previousplatenum))'');
    populated_previousplatenum_pcnt := AVE(GROUP,IF(h.previousplatenum = (TYPEOF(h.previousplatenum))'',0,100));
    maxlength_previousplatenum := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.previousplatenum)));
    avelength_previousplatenum := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.previousplatenum)),h.previousplatenum<>(typeof(h.previousplatenum))'');
    populated_platenum_cnt := COUNT(GROUP,h.platenum <> (TYPEOF(h.platenum))'');
    populated_platenum_pcnt := AVE(GROUP,IF(h.platenum = (TYPEOF(h.platenum))'',0,100));
    maxlength_platenum := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.platenum)));
    avelength_platenum := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.platenum)),h.platenum<>(typeof(h.platenum))'');
    populated_processdate_cnt := COUNT(GROUP,h.processdate <> (TYPEOF(h.processdate))'');
    populated_processdate_pcnt := AVE(GROUP,IF(h.processdate = (TYPEOF(h.processdate))'',0,100));
    maxlength_processdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.processdate)));
    avelength_processdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.processdate)),h.processdate<>(typeof(h.processdate))'');
    populated_source_code_cnt := COUNT(GROUP,h.source_code <> (TYPEOF(h.source_code))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_state_origin_cnt := COUNT(GROUP,h.state_origin <> (TYPEOF(h.state_origin))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_append_ownernametypeind_cnt := COUNT(GROUP,h.append_ownernametypeind <> (TYPEOF(h.append_ownernametypeind))'');
    populated_append_ownernametypeind_pcnt := AVE(GROUP,IF(h.append_ownernametypeind = (TYPEOF(h.append_ownernametypeind))'',0,100));
    maxlength_append_ownernametypeind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_ownernametypeind)));
    avelength_append_ownernametypeind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_ownernametypeind)),h.append_ownernametypeind<>(typeof(h.append_ownernametypeind))'');
    populated_append_addlownernametypeind_cnt := COUNT(GROUP,h.append_addlownernametypeind <> (TYPEOF(h.append_addlownernametypeind))'');
    populated_append_addlownernametypeind_pcnt := AVE(GROUP,IF(h.append_addlownernametypeind = (TYPEOF(h.append_addlownernametypeind))'',0,100));
    maxlength_append_addlownernametypeind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_addlownernametypeind)));
    avelength_append_addlownernametypeind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_addlownernametypeind)),h.append_addlownernametypeind<>(typeof(h.append_addlownernametypeind))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source_code,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_categorycode_pcnt *   0.00 / 100 + T.Populated_vin_pcnt *   0.00 / 100 + T.Populated_modelyr_pcnt *   0.00 / 100 + T.Populated_titlenum_pcnt *   0.00 / 100 + T.Populated_ownercode_pcnt *   0.00 / 100 + T.Populated_grossweight_pcnt *   0.00 / 100 + T.Populated_ownername_pcnt *   0.00 / 100 + T.Populated_ownerstreetaddress_pcnt *   0.00 / 100 + T.Populated_ownercity_pcnt *   0.00 / 100 + T.Populated_ownerstate_pcnt *   0.00 / 100 + T.Populated_ownerzip_pcnt *   0.00 / 100 + T.Populated_countynumber_pcnt *   0.00 / 100 + T.Populated_vehiclepurchasedt_pcnt *   0.00 / 100 + T.Populated_vehicletaxweight_pcnt *   0.00 / 100 + T.Populated_vehicletaxcode_pcnt *   0.00 / 100 + T.Populated_vehicleunladdenweight_pcnt *   0.00 / 100 + T.Populated_additionalownername_pcnt *   0.00 / 100 + T.Populated_registrationissuedt_pcnt *   0.00 / 100 + T.Populated_vehiclemake_pcnt *   0.00 / 100 + T.Populated_vehicletype_pcnt *   0.00 / 100 + T.Populated_vehicleexpdt_pcnt *   0.00 / 100 + T.Populated_previousplatenum_pcnt *   0.00 / 100 + T.Populated_platenum_pcnt *   0.00 / 100 + T.Populated_processdate_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_append_ownernametypeind_pcnt *   0.00 / 100 + T.Populated_append_addlownernametypeind_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;

EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING source_code1;
    STRING source_code2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source_code1 := le.Source;
    SELF.source_code2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_categorycode_pcnt*ri.Populated_categorycode_pcnt *   0.00 / 10000 + le.Populated_vin_pcnt*ri.Populated_vin_pcnt *   0.00 / 10000 + le.Populated_modelyr_pcnt*ri.Populated_modelyr_pcnt *   0.00 / 10000 + le.Populated_titlenum_pcnt*ri.Populated_titlenum_pcnt *   0.00 / 10000 + le.Populated_ownercode_pcnt*ri.Populated_ownercode_pcnt *   0.00 / 10000 + le.Populated_grossweight_pcnt*ri.Populated_grossweight_pcnt *   0.00 / 10000 + le.Populated_ownername_pcnt*ri.Populated_ownername_pcnt *   0.00 / 10000 + le.Populated_ownerstreetaddress_pcnt*ri.Populated_ownerstreetaddress_pcnt *   0.00 / 10000 + le.Populated_ownercity_pcnt*ri.Populated_ownercity_pcnt *   0.00 / 10000 + le.Populated_ownerstate_pcnt*ri.Populated_ownerstate_pcnt *   0.00 / 10000 + le.Populated_ownerzip_pcnt*ri.Populated_ownerzip_pcnt *   0.00 / 10000 + le.Populated_countynumber_pcnt*ri.Populated_countynumber_pcnt *   0.00 / 10000 + le.Populated_vehiclepurchasedt_pcnt*ri.Populated_vehiclepurchasedt_pcnt *   0.00 / 10000 + le.Populated_vehicletaxweight_pcnt*ri.Populated_vehicletaxweight_pcnt *   0.00 / 10000 + le.Populated_vehicletaxcode_pcnt*ri.Populated_vehicletaxcode_pcnt *   0.00 / 10000 + le.Populated_vehicleunladdenweight_pcnt*ri.Populated_vehicleunladdenweight_pcnt *   0.00 / 10000 + le.Populated_additionalownername_pcnt*ri.Populated_additionalownername_pcnt *   0.00 / 10000 + le.Populated_registrationissuedt_pcnt*ri.Populated_registrationissuedt_pcnt *   0.00 / 10000 + le.Populated_vehiclemake_pcnt*ri.Populated_vehiclemake_pcnt *   0.00 / 10000 + le.Populated_vehicletype_pcnt*ri.Populated_vehicletype_pcnt *   0.00 / 10000 + le.Populated_vehicleexpdt_pcnt*ri.Populated_vehicleexpdt_pcnt *   0.00 / 10000 + le.Populated_previousplatenum_pcnt*ri.Populated_previousplatenum_pcnt *   0.00 / 10000 + le.Populated_platenum_pcnt*ri.Populated_platenum_pcnt *   0.00 / 10000 + le.Populated_processdate_pcnt*ri.Populated_processdate_pcnt *   0.00 / 10000 + le.Populated_source_code_pcnt*ri.Populated_source_code_pcnt *   0.00 / 10000 + le.Populated_state_origin_pcnt*ri.Populated_state_origin_pcnt *   0.00 / 10000 + le.Populated_append_ownernametypeind_pcnt*ri.Populated_append_ownernametypeind_pcnt *   0.00 / 10000 + le.Populated_append_addlownernametypeind_pcnt*ri.Populated_append_addlownernametypeind_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'categorycode','vin','modelyr','titlenum','ownercode','grossweight','ownername','ownerstreetaddress','ownercity','ownerstate','ownerzip','countynumber','vehiclepurchasedt','vehicletaxweight','vehicletaxcode','vehicleunladdenweight','additionalownername','registrationissuedt','vehiclemake','vehicletype','vehicleexpdt','previousplatenum','platenum','processdate','source_code','state_origin','append_ownernametypeind','append_addlownernametypeind');
  SELF.populated_pcnt := CHOOSE(C,le.populated_categorycode_pcnt,le.populated_vin_pcnt,le.populated_modelyr_pcnt,le.populated_titlenum_pcnt,le.populated_ownercode_pcnt,le.populated_grossweight_pcnt,le.populated_ownername_pcnt,le.populated_ownerstreetaddress_pcnt,le.populated_ownercity_pcnt,le.populated_ownerstate_pcnt,le.populated_ownerzip_pcnt,le.populated_countynumber_pcnt,le.populated_vehiclepurchasedt_pcnt,le.populated_vehicletaxweight_pcnt,le.populated_vehicletaxcode_pcnt,le.populated_vehicleunladdenweight_pcnt,le.populated_additionalownername_pcnt,le.populated_registrationissuedt_pcnt,le.populated_vehiclemake_pcnt,le.populated_vehicletype_pcnt,le.populated_vehicleexpdt_pcnt,le.populated_previousplatenum_pcnt,le.populated_platenum_pcnt,le.populated_processdate_pcnt,le.populated_source_code_pcnt,le.populated_state_origin_pcnt,le.populated_append_ownernametypeind_pcnt,le.populated_append_addlownernametypeind_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_categorycode,le.maxlength_vin,le.maxlength_modelyr,le.maxlength_titlenum,le.maxlength_ownercode,le.maxlength_grossweight,le.maxlength_ownername,le.maxlength_ownerstreetaddress,le.maxlength_ownercity,le.maxlength_ownerstate,le.maxlength_ownerzip,le.maxlength_countynumber,le.maxlength_vehiclepurchasedt,le.maxlength_vehicletaxweight,le.maxlength_vehicletaxcode,le.maxlength_vehicleunladdenweight,le.maxlength_additionalownername,le.maxlength_registrationissuedt,le.maxlength_vehiclemake,le.maxlength_vehicletype,le.maxlength_vehicleexpdt,le.maxlength_previousplatenum,le.maxlength_platenum,le.maxlength_processdate,le.maxlength_source_code,le.maxlength_state_origin,le.maxlength_append_ownernametypeind,le.maxlength_append_addlownernametypeind);
  SELF.avelength := CHOOSE(C,le.avelength_categorycode,le.avelength_vin,le.avelength_modelyr,le.avelength_titlenum,le.avelength_ownercode,le.avelength_grossweight,le.avelength_ownername,le.avelength_ownerstreetaddress,le.avelength_ownercity,le.avelength_ownerstate,le.avelength_ownerzip,le.avelength_countynumber,le.avelength_vehiclepurchasedt,le.avelength_vehicletaxweight,le.avelength_vehicletaxcode,le.avelength_vehicleunladdenweight,le.avelength_additionalownername,le.avelength_registrationissuedt,le.avelength_vehiclemake,le.avelength_vehicletype,le.avelength_vehicleexpdt,le.avelength_previousplatenum,le.avelength_platenum,le.avelength_processdate,le.avelength_source_code,le.avelength_state_origin,le.avelength_append_ownernametypeind,le.avelength_append_addlownernametypeind);
END;
EXPORT invSummary := NORMALIZE(summary0, 28, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.source_code;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.categorycode),TRIM((SALT311.StrType)le.vin),TRIM((SALT311.StrType)le.modelyr),TRIM((SALT311.StrType)le.titlenum),TRIM((SALT311.StrType)le.ownercode),TRIM((SALT311.StrType)le.grossweight),TRIM((SALT311.StrType)le.ownername),TRIM((SALT311.StrType)le.ownerstreetaddress),TRIM((SALT311.StrType)le.ownercity),TRIM((SALT311.StrType)le.ownerstate),TRIM((SALT311.StrType)le.ownerzip),TRIM((SALT311.StrType)le.countynumber),TRIM((SALT311.StrType)le.vehiclepurchasedt),TRIM((SALT311.StrType)le.vehicletaxweight),TRIM((SALT311.StrType)le.vehicletaxcode),TRIM((SALT311.StrType)le.vehicleunladdenweight),TRIM((SALT311.StrType)le.additionalownername),TRIM((SALT311.StrType)le.registrationissuedt),TRIM((SALT311.StrType)le.vehiclemake),TRIM((SALT311.StrType)le.vehicletype),TRIM((SALT311.StrType)le.vehicleexpdt),TRIM((SALT311.StrType)le.previousplatenum),TRIM((SALT311.StrType)le.platenum),TRIM((SALT311.StrType)le.processdate),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.append_ownernametypeind),TRIM((SALT311.StrType)le.append_addlownernametypeind)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,28,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 28);
  SELF.FldNo2 := 1 + (C % 28);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.categorycode),TRIM((SALT311.StrType)le.vin),TRIM((SALT311.StrType)le.modelyr),TRIM((SALT311.StrType)le.titlenum),TRIM((SALT311.StrType)le.ownercode),TRIM((SALT311.StrType)le.grossweight),TRIM((SALT311.StrType)le.ownername),TRIM((SALT311.StrType)le.ownerstreetaddress),TRIM((SALT311.StrType)le.ownercity),TRIM((SALT311.StrType)le.ownerstate),TRIM((SALT311.StrType)le.ownerzip),TRIM((SALT311.StrType)le.countynumber),TRIM((SALT311.StrType)le.vehiclepurchasedt),TRIM((SALT311.StrType)le.vehicletaxweight),TRIM((SALT311.StrType)le.vehicletaxcode),TRIM((SALT311.StrType)le.vehicleunladdenweight),TRIM((SALT311.StrType)le.additionalownername),TRIM((SALT311.StrType)le.registrationissuedt),TRIM((SALT311.StrType)le.vehiclemake),TRIM((SALT311.StrType)le.vehicletype),TRIM((SALT311.StrType)le.vehicleexpdt),TRIM((SALT311.StrType)le.previousplatenum),TRIM((SALT311.StrType)le.platenum),TRIM((SALT311.StrType)le.processdate),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.append_ownernametypeind),TRIM((SALT311.StrType)le.append_addlownernametypeind)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.categorycode),TRIM((SALT311.StrType)le.vin),TRIM((SALT311.StrType)le.modelyr),TRIM((SALT311.StrType)le.titlenum),TRIM((SALT311.StrType)le.ownercode),TRIM((SALT311.StrType)le.grossweight),TRIM((SALT311.StrType)le.ownername),TRIM((SALT311.StrType)le.ownerstreetaddress),TRIM((SALT311.StrType)le.ownercity),TRIM((SALT311.StrType)le.ownerstate),TRIM((SALT311.StrType)le.ownerzip),TRIM((SALT311.StrType)le.countynumber),TRIM((SALT311.StrType)le.vehiclepurchasedt),TRIM((SALT311.StrType)le.vehicletaxweight),TRIM((SALT311.StrType)le.vehicletaxcode),TRIM((SALT311.StrType)le.vehicleunladdenweight),TRIM((SALT311.StrType)le.additionalownername),TRIM((SALT311.StrType)le.registrationissuedt),TRIM((SALT311.StrType)le.vehiclemake),TRIM((SALT311.StrType)le.vehicletype),TRIM((SALT311.StrType)le.vehicleexpdt),TRIM((SALT311.StrType)le.previousplatenum),TRIM((SALT311.StrType)le.platenum),TRIM((SALT311.StrType)le.processdate),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.append_ownernametypeind),TRIM((SALT311.StrType)le.append_addlownernametypeind)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),28*28,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'categorycode'}
      ,{2,'vin'}
      ,{3,'modelyr'}
      ,{4,'titlenum'}
      ,{5,'ownercode'}
      ,{6,'grossweight'}
      ,{7,'ownername'}
      ,{8,'ownerstreetaddress'}
      ,{9,'ownercity'}
      ,{10,'ownerstate'}
      ,{11,'ownerzip'}
      ,{12,'countynumber'}
      ,{13,'vehiclepurchasedt'}
      ,{14,'vehicletaxweight'}
      ,{15,'vehicletaxcode'}
      ,{16,'vehicleunladdenweight'}
      ,{17,'additionalownername'}
      ,{18,'registrationissuedt'}
      ,{19,'vehiclemake'}
      ,{20,'vehicletype'}
      ,{21,'vehicleexpdt'}
      ,{22,'previousplatenum'}
      ,{23,'platenum'}
      ,{24,'processdate'}
      ,{25,'source_code'}
      ,{26,'state_origin'}
      ,{27,'append_ownernametypeind'}
      ,{28,'append_addlownernametypeind'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source_code) source_code; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    OH_Direct_Fields.InValid_categorycode((SALT311.StrType)le.categorycode),
    OH_Direct_Fields.InValid_vin((SALT311.StrType)le.vin),
    OH_Direct_Fields.InValid_modelyr((SALT311.StrType)le.modelyr),
    OH_Direct_Fields.InValid_titlenum((SALT311.StrType)le.titlenum),
    OH_Direct_Fields.InValid_ownercode((SALT311.StrType)le.ownercode),
    OH_Direct_Fields.InValid_grossweight((SALT311.StrType)le.grossweight),
    OH_Direct_Fields.InValid_ownername((SALT311.StrType)le.ownername),
    OH_Direct_Fields.InValid_ownerstreetaddress((SALT311.StrType)le.ownerstreetaddress),
    OH_Direct_Fields.InValid_ownercity((SALT311.StrType)le.ownercity),
    OH_Direct_Fields.InValid_ownerstate((SALT311.StrType)le.ownerstate),
    OH_Direct_Fields.InValid_ownerzip((SALT311.StrType)le.ownerzip),
    OH_Direct_Fields.InValid_countynumber((SALT311.StrType)le.countynumber),
    OH_Direct_Fields.InValid_vehiclepurchasedt((SALT311.StrType)le.vehiclepurchasedt),
    OH_Direct_Fields.InValid_vehicletaxweight((SALT311.StrType)le.vehicletaxweight),
    OH_Direct_Fields.InValid_vehicletaxcode((SALT311.StrType)le.vehicletaxcode),
    OH_Direct_Fields.InValid_vehicleunladdenweight((SALT311.StrType)le.vehicleunladdenweight),
    OH_Direct_Fields.InValid_additionalownername((SALT311.StrType)le.additionalownername),
    OH_Direct_Fields.InValid_registrationissuedt((SALT311.StrType)le.registrationissuedt),
    OH_Direct_Fields.InValid_vehiclemake((SALT311.StrType)le.vehiclemake),
    OH_Direct_Fields.InValid_vehicletype((SALT311.StrType)le.vehicletype),
    OH_Direct_Fields.InValid_vehicleexpdt((SALT311.StrType)le.vehicleexpdt),
    OH_Direct_Fields.InValid_previousplatenum((SALT311.StrType)le.previousplatenum),
    OH_Direct_Fields.InValid_platenum((SALT311.StrType)le.platenum),
    OH_Direct_Fields.InValid_processdate((SALT311.StrType)le.processdate),
    OH_Direct_Fields.InValid_source_code((SALT311.StrType)le.source_code),
    OH_Direct_Fields.InValid_state_origin((SALT311.StrType)le.state_origin),
    OH_Direct_Fields.InValid_append_ownernametypeind((SALT311.StrType)le.append_ownernametypeind),
    OH_Direct_Fields.InValid_append_addlownernametypeind((SALT311.StrType)le.append_addlownernametypeind),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source_code := le.source_code;
END;
Errors := NORMALIZE(h,28,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source_code;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source_code,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source_code;
  FieldNme := OH_Direct_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_categorycode','invalid_vin','invalid_year','invalid_titlenum','invalid_ownercode','invalid_weight','invalid_alpha','invalid_alpha','invalid_only_alpha','invalid_state','invalid_zip','invalid_countycode','invalid_date','invalid_weight','invalid_vehicletaxcode','invalid_weight','invalid_alpha','invalid_date','invalid_vehiclemake','invalid_alphanumeric','invalid_date','invalid_alphanumeric','invalid_alphanumeric','invalid_date','invalid_source_code','invalid_state','invalid_append_ownernametypeind','invalid_append_ownernametypeind');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,OH_Direct_Fields.InValidMessage_categorycode(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_vin(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_modelyr(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_titlenum(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_ownercode(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_grossweight(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_ownername(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_ownerstreetaddress(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_ownercity(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_ownerstate(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_ownerzip(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_countynumber(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_vehiclepurchasedt(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_vehicletaxweight(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_vehicletaxcode(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_vehicleunladdenweight(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_additionalownername(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_registrationissuedt(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_vehiclemake(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_vehicletype(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_vehicleexpdt(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_previousplatenum(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_platenum(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_processdate(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_source_code(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_append_ownernametypeind(TotalErrors.ErrorNum),OH_Direct_Fields.InValidMessage_append_addlownernametypeind(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source_code=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_VehicleV2, OH_Direct_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));

  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));

  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
