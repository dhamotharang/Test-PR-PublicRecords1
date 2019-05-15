IMPORT SALT37;
EXPORT Base_Business_hygiene(dataset(Base_Business_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_bus_name_pcnt := AVE(GROUP,IF(h.bus_name = (TYPEOF(h.bus_name))'',0,100));
    maxlength_bus_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.bus_name)));
    avelength_bus_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.bus_name)),h.bus_name<>(typeof(h.bus_name))'');
    populated_filing_jurisdiction_pcnt := AVE(GROUP,IF(h.filing_jurisdiction = (TYPEOF(h.filing_jurisdiction))'',0,100));
    maxlength_filing_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_jurisdiction)));
    avelength_filing_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_jurisdiction)),h.filing_jurisdiction<>(typeof(h.filing_jurisdiction))'');
    populated_filing_date_pcnt := AVE(GROUP,IF(h.filing_date = (TYPEOF(h.filing_date))'',0,100));
    maxlength_filing_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_date)));
    avelength_filing_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_date)),h.filing_date<>(typeof(h.filing_date))'');
    populated_filing_number_pcnt := AVE(GROUP,IF(h.filing_number = (TYPEOF(h.filing_number))'',0,100));
    maxlength_filing_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_number)));
    avelength_filing_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_number)),h.filing_number<>(typeof(h.filing_number))'');
    populated_filing_type_pcnt := AVE(GROUP,IF(h.filing_type = (TYPEOF(h.filing_type))'',0,100));
    maxlength_filing_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_type)));
    avelength_filing_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_type)),h.filing_type<>(typeof(h.filing_type))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_bus_name_pcnt *   0.00 / 100 + T.Populated_filing_jurisdiction_pcnt *   0.00 / 100 + T.Populated_filing_date_pcnt *   0.00 / 100 + T.Populated_filing_number_pcnt *   0.00 / 100 + T.Populated_filing_type_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'bus_name','filing_jurisdiction','filing_date','filing_number','filing_type','prep_addr_line1','prep_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_bus_name_pcnt,le.populated_filing_jurisdiction_pcnt,le.populated_filing_date_pcnt,le.populated_filing_number_pcnt,le.populated_filing_type_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_bus_name,le.maxlength_filing_jurisdiction,le.maxlength_filing_date,le.maxlength_filing_number,le.maxlength_filing_type,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_bus_name,le.avelength_filing_jurisdiction,le.avelength_filing_date,le.avelength_filing_number,le.avelength_filing_type,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 7, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.bus_name),TRIM((SALT37.StrType)le.filing_jurisdiction),TRIM((SALT37.StrType)le.filing_date),TRIM((SALT37.StrType)le.filing_number),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,7,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 7);
  SELF.FldNo2 := 1 + (C % 7);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.bus_name),TRIM((SALT37.StrType)le.filing_jurisdiction),TRIM((SALT37.StrType)le.filing_date),TRIM((SALT37.StrType)le.filing_number),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.bus_name),TRIM((SALT37.StrType)le.filing_jurisdiction),TRIM((SALT37.StrType)le.filing_date),TRIM((SALT37.StrType)le.filing_number),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),7*7,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'bus_name'}
      ,{2,'filing_jurisdiction'}
      ,{3,'filing_date'}
      ,{4,'filing_number'}
      ,{5,'filing_type'}
      ,{6,'prep_addr_line1'}
      ,{7,'prep_addr_line_last'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Business_Fields.InValid_bus_name((SALT37.StrType)le.bus_name),
    Base_Business_Fields.InValid_filing_jurisdiction((SALT37.StrType)le.filing_jurisdiction),
    Base_Business_Fields.InValid_filing_date((SALT37.StrType)le.filing_date),
    Base_Business_Fields.InValid_filing_number((SALT37.StrType)le.filing_number),
    Base_Business_Fields.InValid_filing_type((SALT37.StrType)le.filing_type),
    Base_Business_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1),
    Base_Business_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,7,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Business_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Business_Fields.InValidMessage_bus_name(TotalErrors.ErrorNum),Base_Business_Fields.InValidMessage_filing_jurisdiction(TotalErrors.ErrorNum),Base_Business_Fields.InValidMessage_filing_date(TotalErrors.ErrorNum),Base_Business_Fields.InValidMessage_filing_number(TotalErrors.ErrorNum),Base_Business_Fields.InValidMessage_filing_type(TotalErrors.ErrorNum),Base_Business_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_Business_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
