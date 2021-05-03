IMPORT SALT311,STD;
EXPORT addresshistory_hygiene(dataset(addresshistory_layout_crim) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.vendor))'', MAX(GROUP,h.vendor));
    NumberOfRecords := COUNT(GROUP);
    populated_recordid_cnt := COUNT(GROUP,h.recordid <> (TYPEOF(h.recordid))'');
    populated_recordid_pcnt := AVE(GROUP,IF(h.recordid = (TYPEOF(h.recordid))'',0,100));
    maxlength_recordid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordid)));
    avelength_recordid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recordid)),h.recordid<>(typeof(h.recordid))'');
    populated_statecode_cnt := COUNT(GROUP,h.statecode <> (TYPEOF(h.statecode))'');
    populated_statecode_pcnt := AVE(GROUP,IF(h.statecode = (TYPEOF(h.statecode))'',0,100));
    maxlength_statecode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statecode)));
    avelength_statecode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statecode)),h.statecode<>(typeof(h.statecode))'');
    populated_street_cnt := COUNT(GROUP,h.street <> (TYPEOF(h.street))'');
    populated_street_pcnt := AVE(GROUP,IF(h.street = (TYPEOF(h.street))'',0,100));
    maxlength_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street)));
    avelength_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street)),h.street<>(typeof(h.street))'');
    populated_unit_cnt := COUNT(GROUP,h.unit <> (TYPEOF(h.unit))'');
    populated_unit_pcnt := AVE(GROUP,IF(h.unit = (TYPEOF(h.unit))'',0,100));
    maxlength_unit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit)));
    avelength_unit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit)),h.unit<>(typeof(h.unit))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_cnt := COUNT(GROUP,h.orig_zip <> (TYPEOF(h.orig_zip))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_addresstype_cnt := COUNT(GROUP,h.addresstype <> (TYPEOF(h.addresstype))'');
    populated_addresstype_pcnt := AVE(GROUP,IF(h.addresstype = (TYPEOF(h.addresstype))'',0,100));
    maxlength_addresstype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresstype)));
    avelength_addresstype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresstype)),h.addresstype<>(typeof(h.addresstype))'');
    populated_sourcename_cnt := COUNT(GROUP,h.sourcename <> (TYPEOF(h.sourcename))'');
    populated_sourcename_pcnt := AVE(GROUP,IF(h.sourcename = (TYPEOF(h.sourcename))'',0,100));
    maxlength_sourcename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourcename)));
    avelength_sourcename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourcename)),h.sourcename<>(typeof(h.sourcename))'');
    populated_sourceid_cnt := COUNT(GROUP,h.sourceid <> (TYPEOF(h.sourceid))'');
    populated_sourceid_pcnt := AVE(GROUP,IF(h.sourceid = (TYPEOF(h.sourceid))'',0,100));
    maxlength_sourceid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourceid)));
    avelength_sourceid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sourceid)),h.sourceid<>(typeof(h.sourceid))'');
    populated_vendor_cnt := COUNT(GROUP,h.vendor <> (TYPEOF(h.vendor))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recordid_pcnt *   0.00 / 100 + T.Populated_statecode_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_unit_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_addresstype_pcnt *   0.00 / 100 + T.Populated_sourcename_pcnt *   0.00 / 100 + T.Populated_sourceid_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING vendor1;
    STRING vendor2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.vendor1 := le.Source;
    SELF.vendor2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_recordid_pcnt*ri.Populated_recordid_pcnt *   0.00 / 10000 + le.Populated_statecode_pcnt*ri.Populated_statecode_pcnt *   0.00 / 10000 + le.Populated_street_pcnt*ri.Populated_street_pcnt *   0.00 / 10000 + le.Populated_unit_pcnt*ri.Populated_unit_pcnt *   0.00 / 10000 + le.Populated_city_pcnt*ri.Populated_city_pcnt *   0.00 / 10000 + le.Populated_orig_state_pcnt*ri.Populated_orig_state_pcnt *   0.00 / 10000 + le.Populated_orig_zip_pcnt*ri.Populated_orig_zip_pcnt *   0.00 / 10000 + le.Populated_addresstype_pcnt*ri.Populated_addresstype_pcnt *   0.00 / 10000 + le.Populated_sourcename_pcnt*ri.Populated_sourcename_pcnt *   0.00 / 10000 + le.Populated_sourceid_pcnt*ri.Populated_sourceid_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'recordid','statecode','street','unit','city','orig_state','orig_zip','addresstype','sourcename','sourceid','vendor');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recordid_pcnt,le.populated_statecode_pcnt,le.populated_street_pcnt,le.populated_unit_pcnt,le.populated_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_addresstype_pcnt,le.populated_sourcename_pcnt,le.populated_sourceid_pcnt,le.populated_vendor_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recordid,le.maxlength_statecode,le.maxlength_street,le.maxlength_unit,le.maxlength_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_addresstype,le.maxlength_sourcename,le.maxlength_sourceid,le.maxlength_vendor);
  SELF.avelength := CHOOSE(C,le.avelength_recordid,le.avelength_statecode,le.avelength_street,le.avelength_unit,le.avelength_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_addresstype,le.avelength_sourcename,le.avelength_sourceid,le.avelength_vendor);
END;
EXPORT invSummary := NORMALIZE(summary0, 11, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.unit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.vendor)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,11,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 11);
  SELF.FldNo2 := 1 + (C % 11);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.unit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.vendor)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.recordid),TRIM((SALT311.StrType)le.statecode),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.unit),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.sourcename),TRIM((SALT311.StrType)le.sourceid),TRIM((SALT311.StrType)le.vendor)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),11*11,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'recordid'}
      ,{2,'statecode'}
      ,{3,'street'}
      ,{4,'unit'}
      ,{5,'city'}
      ,{6,'orig_state'}
      ,{7,'orig_zip'}
      ,{8,'addresstype'}
      ,{9,'sourcename'}
      ,{10,'sourceid'}
      ,{11,'vendor'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.vendor) vendor; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    addresshistory_Fields.InValid_recordid((SALT311.StrType)le.recordid),
    addresshistory_Fields.InValid_statecode((SALT311.StrType)le.statecode),
    addresshistory_Fields.InValid_street((SALT311.StrType)le.street),
    addresshistory_Fields.InValid_unit((SALT311.StrType)le.unit),
    addresshistory_Fields.InValid_city((SALT311.StrType)le.city),
    addresshistory_Fields.InValid_orig_state((SALT311.StrType)le.orig_state),
    addresshistory_Fields.InValid_orig_zip((SALT311.StrType)le.orig_zip),
    addresshistory_Fields.InValid_addresstype((SALT311.StrType)le.addresstype),
    addresshistory_Fields.InValid_sourcename((SALT311.StrType)le.sourcename),
    addresshistory_Fields.InValid_sourceid((SALT311.StrType)le.sourceid),
    addresshistory_Fields.InValid_vendor((SALT311.StrType)le.vendor),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,11,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := addresshistory_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Record_ID','Invalid_State','Unknown','Unknown','Invalid_City','Unknown','Invalid_ZIP','Unknown','Unknown','Invalid_Source_ID','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,addresshistory_Fields.InValidMessage_recordid(TotalErrors.ErrorNum),addresshistory_Fields.InValidMessage_statecode(TotalErrors.ErrorNum),addresshistory_Fields.InValidMessage_street(TotalErrors.ErrorNum),addresshistory_Fields.InValidMessage_unit(TotalErrors.ErrorNum),addresshistory_Fields.InValidMessage_city(TotalErrors.ErrorNum),addresshistory_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),addresshistory_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),addresshistory_Fields.InValidMessage_addresstype(TotalErrors.ErrorNum),addresshistory_Fields.InValidMessage_sourcename(TotalErrors.ErrorNum),addresshistory_Fields.InValidMessage_sourceid(TotalErrors.ErrorNum),addresshistory_Fields.InValidMessage_vendor(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Crim, addresshistory_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
