IMPORT SALT39,STD;
EXPORT hygiene(dataset(layout_FILE) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orig_transaction_id_cnt := COUNT(GROUP,h.orig_transaction_id <> (TYPEOF(h.orig_transaction_id))'');
    populated_orig_transaction_id_pcnt := AVE(GROUP,IF(h.orig_transaction_id = (TYPEOF(h.orig_transaction_id))'',0,100));
    maxlength_orig_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_id)));
    avelength_orig_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_transaction_id)),h.orig_transaction_id<>(typeof(h.orig_transaction_id))'');
    populated_orig_dateadded_cnt := COUNT(GROUP,h.orig_dateadded <> (TYPEOF(h.orig_dateadded))'');
    populated_orig_dateadded_pcnt := AVE(GROUP,IF(h.orig_dateadded = (TYPEOF(h.orig_dateadded))'',0,100));
    maxlength_orig_dateadded := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dateadded)));
    avelength_orig_dateadded := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dateadded)),h.orig_dateadded<>(typeof(h.orig_dateadded))'');
    populated_orig_billingid_cnt := COUNT(GROUP,h.orig_billingid <> (TYPEOF(h.orig_billingid))'');
    populated_orig_billingid_pcnt := AVE(GROUP,IF(h.orig_billingid = (TYPEOF(h.orig_billingid))'',0,100));
    maxlength_orig_billingid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_billingid)));
    avelength_orig_billingid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_billingid)),h.orig_billingid<>(typeof(h.orig_billingid))'');
    populated_orig_function_name_cnt := COUNT(GROUP,h.orig_function_name <> (TYPEOF(h.orig_function_name))'');
    populated_orig_function_name_pcnt := AVE(GROUP,IF(h.orig_function_name = (TYPEOF(h.orig_function_name))'',0,100));
    maxlength_orig_function_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_function_name)));
    avelength_orig_function_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_function_name)),h.orig_function_name<>(typeof(h.orig_function_name))'');
    populated_orig_adl_cnt := COUNT(GROUP,h.orig_adl <> (TYPEOF(h.orig_adl))'');
    populated_orig_adl_pcnt := AVE(GROUP,IF(h.orig_adl = (TYPEOF(h.orig_adl))'',0,100));
    maxlength_orig_adl := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_adl)));
    avelength_orig_adl := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_adl)),h.orig_adl<>(typeof(h.orig_adl))'');
    populated_orig_fname_cnt := COUNT(GROUP,h.orig_fname <> (TYPEOF(h.orig_fname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_lname_cnt := COUNT(GROUP,h.orig_lname <> (TYPEOF(h.orig_lname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_mname_cnt := COUNT(GROUP,h.orig_mname <> (TYPEOF(h.orig_mname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_ssn_cnt := COUNT(GROUP,h.orig_ssn <> (TYPEOF(h.orig_ssn))'');
    populated_orig_ssn_pcnt := AVE(GROUP,IF(h.orig_ssn = (TYPEOF(h.orig_ssn))'',0,100));
    maxlength_orig_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn)));
    avelength_orig_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_ssn)),h.orig_ssn<>(typeof(h.orig_ssn))'');
    populated_orig_address_cnt := COUNT(GROUP,h.orig_address <> (TYPEOF(h.orig_address))'');
    populated_orig_address_pcnt := AVE(GROUP,IF(h.orig_address = (TYPEOF(h.orig_address))'',0,100));
    maxlength_orig_address := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address)));
    avelength_orig_address := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_address)),h.orig_address<>(typeof(h.orig_address))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_cnt := COUNT(GROUP,h.orig_zip <> (TYPEOF(h.orig_zip))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_phone_cnt := COUNT(GROUP,h.orig_phone <> (TYPEOF(h.orig_phone))'');
    populated_orig_phone_pcnt := AVE(GROUP,IF(h.orig_phone = (TYPEOF(h.orig_phone))'',0,100));
    maxlength_orig_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_phone)));
    avelength_orig_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_phone)),h.orig_phone<>(typeof(h.orig_phone))'');
    populated_orig_dob_cnt := COUNT(GROUP,h.orig_dob <> (TYPEOF(h.orig_dob))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_dln_cnt := COUNT(GROUP,h.orig_dln <> (TYPEOF(h.orig_dln))'');
    populated_orig_dln_pcnt := AVE(GROUP,IF(h.orig_dln = (TYPEOF(h.orig_dln))'',0,100));
    maxlength_orig_dln := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dln)));
    avelength_orig_dln := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dln)),h.orig_dln<>(typeof(h.orig_dln))'');
    populated_orig_dln_st_cnt := COUNT(GROUP,h.orig_dln_st <> (TYPEOF(h.orig_dln_st))'');
    populated_orig_dln_st_pcnt := AVE(GROUP,IF(h.orig_dln_st = (TYPEOF(h.orig_dln_st))'',0,100));
    maxlength_orig_dln_st := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dln_st)));
    avelength_orig_dln_st := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dln_st)),h.orig_dln_st<>(typeof(h.orig_dln_st))'');
    populated_orig_glb_cnt := COUNT(GROUP,h.orig_glb <> (TYPEOF(h.orig_glb))'');
    populated_orig_glb_pcnt := AVE(GROUP,IF(h.orig_glb = (TYPEOF(h.orig_glb))'',0,100));
    maxlength_orig_glb := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_glb)));
    avelength_orig_glb := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_glb)),h.orig_glb<>(typeof(h.orig_glb))'');
    populated_orig_dppa_cnt := COUNT(GROUP,h.orig_dppa <> (TYPEOF(h.orig_dppa))'');
    populated_orig_dppa_pcnt := AVE(GROUP,IF(h.orig_dppa = (TYPEOF(h.orig_dppa))'',0,100));
    maxlength_orig_dppa := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dppa)));
    avelength_orig_dppa := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_dppa)),h.orig_dppa<>(typeof(h.orig_dppa))'');
    populated_orig_fcra_cnt := COUNT(GROUP,h.orig_fcra <> (TYPEOF(h.orig_fcra))'');
    populated_orig_fcra_pcnt := AVE(GROUP,IF(h.orig_fcra = (TYPEOF(h.orig_fcra))'',0,100));
    maxlength_orig_fcra := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fcra)));
    avelength_orig_fcra := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.orig_fcra)),h.orig_fcra<>(typeof(h.orig_fcra))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_transaction_id_pcnt *   0.00 / 100 + T.Populated_orig_dateadded_pcnt *   0.00 / 100 + T.Populated_orig_billingid_pcnt *   0.00 / 100 + T.Populated_orig_function_name_pcnt *   0.00 / 100 + T.Populated_orig_adl_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_ssn_pcnt *   0.00 / 100 + T.Populated_orig_address_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_phone_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_dln_pcnt *   0.00 / 100 + T.Populated_orig_dln_st_pcnt *   0.00 / 100 + T.Populated_orig_glb_pcnt *   0.00 / 100 + T.Populated_orig_dppa_pcnt *   0.00 / 100 + T.Populated_orig_fcra_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'orig_transaction_id','orig_dateadded','orig_billingid','orig_function_name','orig_adl','orig_fname','orig_lname','orig_mname','orig_ssn','orig_address','orig_city','orig_state','orig_zip','orig_phone','orig_dob','orig_dln','orig_dln_st','orig_glb','orig_dppa','orig_fcra');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_transaction_id_pcnt,le.populated_orig_dateadded_pcnt,le.populated_orig_billingid_pcnt,le.populated_orig_function_name_pcnt,le.populated_orig_adl_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_ssn_pcnt,le.populated_orig_address_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_phone_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_dln_pcnt,le.populated_orig_dln_st_pcnt,le.populated_orig_glb_pcnt,le.populated_orig_dppa_pcnt,le.populated_orig_fcra_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_transaction_id,le.maxlength_orig_dateadded,le.maxlength_orig_billingid,le.maxlength_orig_function_name,le.maxlength_orig_adl,le.maxlength_orig_fname,le.maxlength_orig_lname,le.maxlength_orig_mname,le.maxlength_orig_ssn,le.maxlength_orig_address,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_phone,le.maxlength_orig_dob,le.maxlength_orig_dln,le.maxlength_orig_dln_st,le.maxlength_orig_glb,le.maxlength_orig_dppa,le.maxlength_orig_fcra);
  SELF.avelength := CHOOSE(C,le.avelength_orig_transaction_id,le.avelength_orig_dateadded,le.avelength_orig_billingid,le.avelength_orig_function_name,le.avelength_orig_adl,le.avelength_orig_fname,le.avelength_orig_lname,le.avelength_orig_mname,le.avelength_orig_ssn,le.avelength_orig_address,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_phone,le.avelength_orig_dob,le.avelength_orig_dln,le.avelength_orig_dln_st,le.avelength_orig_glb,le.avelength_orig_dppa,le.avelength_orig_fcra);
END;
EXPORT invSummary := NORMALIZE(summary0, 20, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_dateadded),TRIM((SALT39.StrType)le.orig_billingid),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_adl),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_dln),TRIM((SALT39.StrType)le.orig_dln_st),TRIM((SALT39.StrType)le.orig_glb),TRIM((SALT39.StrType)le.orig_dppa),TRIM((SALT39.StrType)le.orig_fcra)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,20,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 20);
  SELF.FldNo2 := 1 + (C % 20);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_dateadded),TRIM((SALT39.StrType)le.orig_billingid),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_adl),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_dln),TRIM((SALT39.StrType)le.orig_dln_st),TRIM((SALT39.StrType)le.orig_glb),TRIM((SALT39.StrType)le.orig_dppa),TRIM((SALT39.StrType)le.orig_fcra)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.orig_transaction_id),TRIM((SALT39.StrType)le.orig_dateadded),TRIM((SALT39.StrType)le.orig_billingid),TRIM((SALT39.StrType)le.orig_function_name),TRIM((SALT39.StrType)le.orig_adl),TRIM((SALT39.StrType)le.orig_fname),TRIM((SALT39.StrType)le.orig_lname),TRIM((SALT39.StrType)le.orig_mname),TRIM((SALT39.StrType)le.orig_ssn),TRIM((SALT39.StrType)le.orig_address),TRIM((SALT39.StrType)le.orig_city),TRIM((SALT39.StrType)le.orig_state),TRIM((SALT39.StrType)le.orig_zip),TRIM((SALT39.StrType)le.orig_phone),TRIM((SALT39.StrType)le.orig_dob),TRIM((SALT39.StrType)le.orig_dln),TRIM((SALT39.StrType)le.orig_dln_st),TRIM((SALT39.StrType)le.orig_glb),TRIM((SALT39.StrType)le.orig_dppa),TRIM((SALT39.StrType)le.orig_fcra)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),20*20,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orig_transaction_id'}
      ,{2,'orig_dateadded'}
      ,{3,'orig_billingid'}
      ,{4,'orig_function_name'}
      ,{5,'orig_adl'}
      ,{6,'orig_fname'}
      ,{7,'orig_lname'}
      ,{8,'orig_mname'}
      ,{9,'orig_ssn'}
      ,{10,'orig_address'}
      ,{11,'orig_city'}
      ,{12,'orig_state'}
      ,{13,'orig_zip'}
      ,{14,'orig_phone'}
      ,{15,'orig_dob'}
      ,{16,'orig_dln'}
      ,{17,'orig_dln_st'}
      ,{18,'orig_glb'}
      ,{19,'orig_dppa'}
      ,{20,'orig_fcra'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_orig_transaction_id((SALT39.StrType)le.orig_transaction_id),
    Fields.InValid_orig_dateadded((SALT39.StrType)le.orig_dateadded),
    Fields.InValid_orig_billingid((SALT39.StrType)le.orig_billingid),
    Fields.InValid_orig_function_name((SALT39.StrType)le.orig_function_name),
    Fields.InValid_orig_adl((SALT39.StrType)le.orig_adl),
    Fields.InValid_orig_fname((SALT39.StrType)le.orig_fname),
    Fields.InValid_orig_lname((SALT39.StrType)le.orig_lname),
    Fields.InValid_orig_mname((SALT39.StrType)le.orig_mname),
    Fields.InValid_orig_ssn((SALT39.StrType)le.orig_ssn),
    Fields.InValid_orig_address((SALT39.StrType)le.orig_address),
    Fields.InValid_orig_city((SALT39.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT39.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT39.StrType)le.orig_zip),
    Fields.InValid_orig_phone((SALT39.StrType)le.orig_phone),
    Fields.InValid_orig_dob((SALT39.StrType)le.orig_dob),
    Fields.InValid_orig_dln((SALT39.StrType)le.orig_dln),
    Fields.InValid_orig_dln_st((SALT39.StrType)le.orig_dln_st),
    Fields.InValid_orig_glb((SALT39.StrType)le.orig_glb),
    Fields.InValid_orig_dppa((SALT39.StrType)le.orig_dppa),
    Fields.InValid_orig_fcra((SALT39.StrType)le.orig_fcra),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,20,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'orig_transaction_id','orig_dateadded','orig_billingid','orig_function_name','orig_adl','orig_fname','orig_lname','orig_mname','orig_ssn','orig_address','orig_city','orig_state','orig_zip','orig_phone','orig_dob','orig_dln','orig_dln_st','orig_glb','orig_dppa','orig_fcra');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_orig_transaction_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dateadded(TotalErrors.ErrorNum),Fields.InValidMessage_orig_billingid(TotalErrors.ErrorNum),Fields.InValidMessage_orig_function_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_adl(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_phone(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dln(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dln_st(TotalErrors.ErrorNum),Fields.InValidMessage_orig_glb(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dppa(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fcra(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_Nfcra_IDM, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
