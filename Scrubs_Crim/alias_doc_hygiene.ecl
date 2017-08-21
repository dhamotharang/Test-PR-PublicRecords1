IMPORT ut,SALT33;
EXPORT alias_doc_hygiene(dataset(alias_doc_layout_crim) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.vendor);    NumberOfRecords := COUNT(GROUP);
    populated_recordid_pcnt := AVE(GROUP,IF(h.recordid = (TYPEOF(h.recordid))'',0,100));
    maxlength_recordid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.recordid)));
    avelength_recordid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.recordid)),h.recordid<>(typeof(h.recordid))'');
    populated_statecode_pcnt := AVE(GROUP,IF(h.statecode = (TYPEOF(h.statecode))'',0,100));
    maxlength_statecode := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.statecode)));
    avelength_statecode := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.statecode)),h.statecode<>(typeof(h.statecode))'');
    populated_akaname_pcnt := AVE(GROUP,IF(h.akaname = (TYPEOF(h.akaname))'',0,100));
    maxlength_akaname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.akaname)));
    avelength_akaname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.akaname)),h.akaname<>(typeof(h.akaname))'');
    populated_akalastname_pcnt := AVE(GROUP,IF(h.akalastname = (TYPEOF(h.akalastname))'',0,100));
    maxlength_akalastname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.akalastname)));
    avelength_akalastname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.akalastname)),h.akalastname<>(typeof(h.akalastname))'');
    populated_akafirstname_pcnt := AVE(GROUP,IF(h.akafirstname = (TYPEOF(h.akafirstname))'',0,100));
    maxlength_akafirstname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.akafirstname)));
    avelength_akafirstname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.akafirstname)),h.akafirstname<>(typeof(h.akafirstname))'');
    populated_akamiddlename_pcnt := AVE(GROUP,IF(h.akamiddlename = (TYPEOF(h.akamiddlename))'',0,100));
    maxlength_akamiddlename := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.akamiddlename)));
    avelength_akamiddlename := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.akamiddlename)),h.akamiddlename<>(typeof(h.akamiddlename))'');
    populated_akasuffix_pcnt := AVE(GROUP,IF(h.akasuffix = (TYPEOF(h.akasuffix))'',0,100));
    maxlength_akasuffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.akasuffix)));
    avelength_akasuffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.akasuffix)),h.akasuffix<>(typeof(h.akasuffix))'');
    populated_akadob_pcnt := AVE(GROUP,IF(h.akadob = (TYPEOF(h.akadob))'',0,100));
    maxlength_akadob := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.akadob)));
    avelength_akadob := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.akadob)),h.akadob<>(typeof(h.akadob))'');
    populated_sourcename_pcnt := AVE(GROUP,IF(h.sourcename = (TYPEOF(h.sourcename))'',0,100));
    maxlength_sourcename := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcename)));
    avelength_sourcename := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sourcename)),h.sourcename<>(typeof(h.sourcename))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recordid_pcnt *   0.00 / 100 + T.Populated_statecode_pcnt *   0.00 / 100 + T.Populated_akaname_pcnt *   0.00 / 100 + T.Populated_akalastname_pcnt *   0.00 / 100 + T.Populated_akafirstname_pcnt *   0.00 / 100 + T.Populated_akamiddlename_pcnt *   0.00 / 100 + T.Populated_akasuffix_pcnt *   0.00 / 100 + T.Populated_akadob_pcnt *   0.00 / 100 + T.Populated_sourcename_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING vendor1;
    STRING vendor2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.vendor1 := le.Source;
    SELF.vendor2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_recordid_pcnt*ri.Populated_recordid_pcnt *   0.00 / 10000 + le.Populated_statecode_pcnt*ri.Populated_statecode_pcnt *   0.00 / 10000 + le.Populated_akaname_pcnt*ri.Populated_akaname_pcnt *   0.00 / 10000 + le.Populated_akalastname_pcnt*ri.Populated_akalastname_pcnt *   0.00 / 10000 + le.Populated_akafirstname_pcnt*ri.Populated_akafirstname_pcnt *   0.00 / 10000 + le.Populated_akamiddlename_pcnt*ri.Populated_akamiddlename_pcnt *   0.00 / 10000 + le.Populated_akasuffix_pcnt*ri.Populated_akasuffix_pcnt *   0.00 / 10000 + le.Populated_akadob_pcnt*ri.Populated_akadob_pcnt *   0.00 / 10000 + le.Populated_sourcename_pcnt*ri.Populated_sourcename_pcnt *   0.00 / 10000 + le.Populated_vendor_pcnt*ri.Populated_vendor_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'recordid','statecode','akaname','akalastname','akafirstname','akamiddlename','akasuffix','akadob','sourcename','vendor');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recordid_pcnt,le.populated_statecode_pcnt,le.populated_akaname_pcnt,le.populated_akalastname_pcnt,le.populated_akafirstname_pcnt,le.populated_akamiddlename_pcnt,le.populated_akasuffix_pcnt,le.populated_akadob_pcnt,le.populated_sourcename_pcnt,le.populated_vendor_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recordid,le.maxlength_statecode,le.maxlength_akaname,le.maxlength_akalastname,le.maxlength_akafirstname,le.maxlength_akamiddlename,le.maxlength_akasuffix,le.maxlength_akadob,le.maxlength_sourcename,le.maxlength_vendor);
  SELF.avelength := CHOOSE(C,le.avelength_recordid,le.avelength_statecode,le.avelength_akaname,le.avelength_akalastname,le.avelength_akafirstname,le.avelength_akamiddlename,le.avelength_akasuffix,le.avelength_akadob,le.avelength_sourcename,le.avelength_vendor);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.akaname),TRIM((SALT33.StrType)le.akalastname),TRIM((SALT33.StrType)le.akafirstname),TRIM((SALT33.StrType)le.akamiddlename),TRIM((SALT33.StrType)le.akasuffix),TRIM((SALT33.StrType)le.akadob),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.vendor)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.akaname),TRIM((SALT33.StrType)le.akalastname),TRIM((SALT33.StrType)le.akafirstname),TRIM((SALT33.StrType)le.akamiddlename),TRIM((SALT33.StrType)le.akasuffix),TRIM((SALT33.StrType)le.akadob),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.vendor)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.recordid),TRIM((SALT33.StrType)le.statecode),TRIM((SALT33.StrType)le.akaname),TRIM((SALT33.StrType)le.akalastname),TRIM((SALT33.StrType)le.akafirstname),TRIM((SALT33.StrType)le.akamiddlename),TRIM((SALT33.StrType)le.akasuffix),TRIM((SALT33.StrType)le.akadob),TRIM((SALT33.StrType)le.sourcename),TRIM((SALT33.StrType)le.vendor)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'recordid'}
      ,{2,'statecode'}
      ,{3,'akaname'}
      ,{4,'akalastname'}
      ,{5,'akafirstname'}
      ,{6,'akamiddlename'}
      ,{7,'akasuffix'}
      ,{8,'akadob'}
      ,{9,'sourcename'}
      ,{10,'vendor'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.vendor) vendor; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    alias_doc_Fields.InValid_recordid((SALT33.StrType)le.recordid),
    alias_doc_Fields.InValid_statecode((SALT33.StrType)le.statecode),
    alias_doc_Fields.InValid_akaname((SALT33.StrType)le.akaname),
    alias_doc_Fields.InValid_akalastname((SALT33.StrType)le.akalastname),
    alias_doc_Fields.InValid_akafirstname((SALT33.StrType)le.akafirstname),
    alias_doc_Fields.InValid_akamiddlename((SALT33.StrType)le.akamiddlename),
    alias_doc_Fields.InValid_akasuffix((SALT33.StrType)le.akasuffix),
    alias_doc_Fields.InValid_akadob((SALT33.StrType)le.akadob),
    alias_doc_Fields.InValid_sourcename((SALT33.StrType)le.sourcename),
    alias_doc_Fields.InValid_vendor((SALT33.StrType)le.vendor),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor := le.vendor;
END;
Errors := NORMALIZE(h,10,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor;
  FieldNme := alias_doc_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Record_ID','Invalid_State','AKA_Search','AKA_Search','AKA_Search','AKA_Search','Unknown','Invalid_Date','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,alias_doc_Fields.InValidMessage_recordid(TotalErrors.ErrorNum),alias_doc_Fields.InValidMessage_statecode(TotalErrors.ErrorNum),alias_doc_Fields.InValidMessage_akaname(TotalErrors.ErrorNum),alias_doc_Fields.InValidMessage_akalastname(TotalErrors.ErrorNum),alias_doc_Fields.InValidMessage_akafirstname(TotalErrors.ErrorNum),alias_doc_Fields.InValidMessage_akamiddlename(TotalErrors.ErrorNum),alias_doc_Fields.InValidMessage_akasuffix(TotalErrors.ErrorNum),alias_doc_Fields.InValidMessage_akadob(TotalErrors.ErrorNum),alias_doc_Fields.InValidMessage_sourcename(TotalErrors.ErrorNum),alias_doc_Fields.InValidMessage_vendor(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
