IMPORT SALT38,STD;
EXPORT incident_hygiene(dataset(incident_layout_SANCTNKeys) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_batch_number_cnt := COUNT(GROUP,h.batch_number <> (TYPEOF(h.batch_number))'');
    populated_batch_number_pcnt := AVE(GROUP,IF(h.batch_number = (TYPEOF(h.batch_number))'',0,100));
    maxlength_batch_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.batch_number)));
    avelength_batch_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.batch_number)),h.batch_number<>(typeof(h.batch_number))'');
    populated_incident_number_cnt := COUNT(GROUP,h.incident_number <> (TYPEOF(h.incident_number))'');
    populated_incident_number_pcnt := AVE(GROUP,IF(h.incident_number = (TYPEOF(h.incident_number))'',0,100));
    maxlength_incident_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_number)));
    avelength_incident_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_number)),h.incident_number<>(typeof(h.incident_number))'');
    populated_party_number_cnt := COUNT(GROUP,h.party_number <> (TYPEOF(h.party_number))'');
    populated_party_number_pcnt := AVE(GROUP,IF(h.party_number = (TYPEOF(h.party_number))'',0,100));
    maxlength_party_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_number)));
    avelength_party_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_number)),h.party_number<>(typeof(h.party_number))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_order_number_cnt := COUNT(GROUP,h.order_number <> (TYPEOF(h.order_number))'');
    populated_order_number_pcnt := AVE(GROUP,IF(h.order_number = (TYPEOF(h.order_number))'',0,100));
    maxlength_order_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.order_number)));
    avelength_order_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.order_number)),h.order_number<>(typeof(h.order_number))'');
    populated_ag_code_cnt := COUNT(GROUP,h.ag_code <> (TYPEOF(h.ag_code))'');
    populated_ag_code_pcnt := AVE(GROUP,IF(h.ag_code = (TYPEOF(h.ag_code))'',0,100));
    maxlength_ag_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ag_code)));
    avelength_ag_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ag_code)),h.ag_code<>(typeof(h.ag_code))'');
    populated_case_number_cnt := COUNT(GROUP,h.case_number <> (TYPEOF(h.case_number))'');
    populated_case_number_pcnt := AVE(GROUP,IF(h.case_number = (TYPEOF(h.case_number))'',0,100));
    maxlength_case_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.case_number)));
    avelength_case_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.case_number)),h.case_number<>(typeof(h.case_number))'');
    populated_incident_date_cnt := COUNT(GROUP,h.incident_date <> (TYPEOF(h.incident_date))'');
    populated_incident_date_pcnt := AVE(GROUP,IF(h.incident_date = (TYPEOF(h.incident_date))'',0,100));
    maxlength_incident_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_date)));
    avelength_incident_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_date)),h.incident_date<>(typeof(h.incident_date))'');
    populated_jurisdiction_cnt := COUNT(GROUP,h.jurisdiction <> (TYPEOF(h.jurisdiction))'');
    populated_jurisdiction_pcnt := AVE(GROUP,IF(h.jurisdiction = (TYPEOF(h.jurisdiction))'',0,100));
    maxlength_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.jurisdiction)));
    avelength_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.jurisdiction)),h.jurisdiction<>(typeof(h.jurisdiction))'');
    populated_source_document_cnt := COUNT(GROUP,h.source_document <> (TYPEOF(h.source_document))'');
    populated_source_document_pcnt := AVE(GROUP,IF(h.source_document = (TYPEOF(h.source_document))'',0,100));
    maxlength_source_document := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_document)));
    avelength_source_document := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_document)),h.source_document<>(typeof(h.source_document))'');
    populated_additional_info_cnt := COUNT(GROUP,h.additional_info <> (TYPEOF(h.additional_info))'');
    populated_additional_info_pcnt := AVE(GROUP,IF(h.additional_info = (TYPEOF(h.additional_info))'',0,100));
    maxlength_additional_info := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.additional_info)));
    avelength_additional_info := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.additional_info)),h.additional_info<>(typeof(h.additional_info))'');
    populated_agency_cnt := COUNT(GROUP,h.agency <> (TYPEOF(h.agency))'');
    populated_agency_pcnt := AVE(GROUP,IF(h.agency = (TYPEOF(h.agency))'',0,100));
    maxlength_agency := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.agency)));
    avelength_agency := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.agency)),h.agency<>(typeof(h.agency))'');
    populated_alleged_amount_cnt := COUNT(GROUP,h.alleged_amount <> (TYPEOF(h.alleged_amount))'');
    populated_alleged_amount_pcnt := AVE(GROUP,IF(h.alleged_amount = (TYPEOF(h.alleged_amount))'',0,100));
    maxlength_alleged_amount := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.alleged_amount)));
    avelength_alleged_amount := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.alleged_amount)),h.alleged_amount<>(typeof(h.alleged_amount))'');
    populated_estimated_loss_cnt := COUNT(GROUP,h.estimated_loss <> (TYPEOF(h.estimated_loss))'');
    populated_estimated_loss_pcnt := AVE(GROUP,IF(h.estimated_loss = (TYPEOF(h.estimated_loss))'',0,100));
    maxlength_estimated_loss := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.estimated_loss)));
    avelength_estimated_loss := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.estimated_loss)),h.estimated_loss<>(typeof(h.estimated_loss))'');
    populated_fcr_date_cnt := COUNT(GROUP,h.fcr_date <> (TYPEOF(h.fcr_date))'');
    populated_fcr_date_pcnt := AVE(GROUP,IF(h.fcr_date = (TYPEOF(h.fcr_date))'',0,100));
    maxlength_fcr_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fcr_date)));
    avelength_fcr_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fcr_date)),h.fcr_date<>(typeof(h.fcr_date))'');
    populated_ok_for_fcr_cnt := COUNT(GROUP,h.ok_for_fcr <> (TYPEOF(h.ok_for_fcr))'');
    populated_ok_for_fcr_pcnt := AVE(GROUP,IF(h.ok_for_fcr = (TYPEOF(h.ok_for_fcr))'',0,100));
    maxlength_ok_for_fcr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ok_for_fcr)));
    avelength_ok_for_fcr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ok_for_fcr)),h.ok_for_fcr<>(typeof(h.ok_for_fcr))'');
    populated_modified_date_cnt := COUNT(GROUP,h.modified_date <> (TYPEOF(h.modified_date))'');
    populated_modified_date_pcnt := AVE(GROUP,IF(h.modified_date = (TYPEOF(h.modified_date))'',0,100));
    maxlength_modified_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.modified_date)));
    avelength_modified_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.modified_date)),h.modified_date<>(typeof(h.modified_date))'');
    populated_load_date_cnt := COUNT(GROUP,h.load_date <> (TYPEOF(h.load_date))'');
    populated_load_date_pcnt := AVE(GROUP,IF(h.load_date = (TYPEOF(h.load_date))'',0,100));
    maxlength_load_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.load_date)));
    avelength_load_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.load_date)),h.load_date<>(typeof(h.load_date))'');
    populated_incident_text_cnt := COUNT(GROUP,h.incident_text <> (TYPEOF(h.incident_text))'');
    populated_incident_text_pcnt := AVE(GROUP,IF(h.incident_text = (TYPEOF(h.incident_text))'',0,100));
    maxlength_incident_text := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_text)));
    avelength_incident_text := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_text)),h.incident_text<>(typeof(h.incident_text))'');
    populated_incident_date_clean_cnt := COUNT(GROUP,h.incident_date_clean <> (TYPEOF(h.incident_date_clean))'');
    populated_incident_date_clean_pcnt := AVE(GROUP,IF(h.incident_date_clean = (TYPEOF(h.incident_date_clean))'',0,100));
    maxlength_incident_date_clean := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_date_clean)));
    avelength_incident_date_clean := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_date_clean)),h.incident_date_clean<>(typeof(h.incident_date_clean))'');
    populated_fcr_date_clean_cnt := COUNT(GROUP,h.fcr_date_clean <> (TYPEOF(h.fcr_date_clean))'');
    populated_fcr_date_clean_pcnt := AVE(GROUP,IF(h.fcr_date_clean = (TYPEOF(h.fcr_date_clean))'',0,100));
    maxlength_fcr_date_clean := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fcr_date_clean)));
    avelength_fcr_date_clean := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fcr_date_clean)),h.fcr_date_clean<>(typeof(h.fcr_date_clean))'');
    populated_cln_modified_date_cnt := COUNT(GROUP,h.cln_modified_date <> (TYPEOF(h.cln_modified_date))'');
    populated_cln_modified_date_pcnt := AVE(GROUP,IF(h.cln_modified_date = (TYPEOF(h.cln_modified_date))'',0,100));
    maxlength_cln_modified_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_modified_date)));
    avelength_cln_modified_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_modified_date)),h.cln_modified_date<>(typeof(h.cln_modified_date))'');
    populated_cln_load_date_cnt := COUNT(GROUP,h.cln_load_date <> (TYPEOF(h.cln_load_date))'');
    populated_cln_load_date_pcnt := AVE(GROUP,IF(h.cln_load_date = (TYPEOF(h.cln_load_date))'',0,100));
    maxlength_cln_load_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_load_date)));
    avelength_cln_load_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_load_date)),h.cln_load_date<>(typeof(h.cln_load_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_batch_number_pcnt *   0.00 / 100 + T.Populated_incident_number_pcnt *   0.00 / 100 + T.Populated_party_number_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_order_number_pcnt *   0.00 / 100 + T.Populated_ag_code_pcnt *   0.00 / 100 + T.Populated_case_number_pcnt *   0.00 / 100 + T.Populated_incident_date_pcnt *   0.00 / 100 + T.Populated_jurisdiction_pcnt *   0.00 / 100 + T.Populated_source_document_pcnt *   0.00 / 100 + T.Populated_additional_info_pcnt *   0.00 / 100 + T.Populated_agency_pcnt *   0.00 / 100 + T.Populated_alleged_amount_pcnt *   0.00 / 100 + T.Populated_estimated_loss_pcnt *   0.00 / 100 + T.Populated_fcr_date_pcnt *   0.00 / 100 + T.Populated_ok_for_fcr_pcnt *   0.00 / 100 + T.Populated_modified_date_pcnt *   0.00 / 100 + T.Populated_load_date_pcnt *   0.00 / 100 + T.Populated_incident_text_pcnt *   0.00 / 100 + T.Populated_incident_date_clean_pcnt *   0.00 / 100 + T.Populated_fcr_date_clean_pcnt *   0.00 / 100 + T.Populated_cln_modified_date_pcnt *   0.00 / 100 + T.Populated_cln_load_date_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'batch_number','incident_number','party_number','record_type','order_number','ag_code','case_number','incident_date','jurisdiction','source_document','additional_info','agency','alleged_amount','estimated_loss','fcr_date','ok_for_fcr','modified_date','load_date','incident_text','incident_date_clean','fcr_date_clean','cln_modified_date','cln_load_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_batch_number_pcnt,le.populated_incident_number_pcnt,le.populated_party_number_pcnt,le.populated_record_type_pcnt,le.populated_order_number_pcnt,le.populated_ag_code_pcnt,le.populated_case_number_pcnt,le.populated_incident_date_pcnt,le.populated_jurisdiction_pcnt,le.populated_source_document_pcnt,le.populated_additional_info_pcnt,le.populated_agency_pcnt,le.populated_alleged_amount_pcnt,le.populated_estimated_loss_pcnt,le.populated_fcr_date_pcnt,le.populated_ok_for_fcr_pcnt,le.populated_modified_date_pcnt,le.populated_load_date_pcnt,le.populated_incident_text_pcnt,le.populated_incident_date_clean_pcnt,le.populated_fcr_date_clean_pcnt,le.populated_cln_modified_date_pcnt,le.populated_cln_load_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_batch_number,le.maxlength_incident_number,le.maxlength_party_number,le.maxlength_record_type,le.maxlength_order_number,le.maxlength_ag_code,le.maxlength_case_number,le.maxlength_incident_date,le.maxlength_jurisdiction,le.maxlength_source_document,le.maxlength_additional_info,le.maxlength_agency,le.maxlength_alleged_amount,le.maxlength_estimated_loss,le.maxlength_fcr_date,le.maxlength_ok_for_fcr,le.maxlength_modified_date,le.maxlength_load_date,le.maxlength_incident_text,le.maxlength_incident_date_clean,le.maxlength_fcr_date_clean,le.maxlength_cln_modified_date,le.maxlength_cln_load_date);
  SELF.avelength := CHOOSE(C,le.avelength_batch_number,le.avelength_incident_number,le.avelength_party_number,le.avelength_record_type,le.avelength_order_number,le.avelength_ag_code,le.avelength_case_number,le.avelength_incident_date,le.avelength_jurisdiction,le.avelength_source_document,le.avelength_additional_info,le.avelength_agency,le.avelength_alleged_amount,le.avelength_estimated_loss,le.avelength_fcr_date,le.avelength_ok_for_fcr,le.avelength_modified_date,le.avelength_load_date,le.avelength_incident_text,le.avelength_incident_date_clean,le.avelength_fcr_date_clean,le.avelength_cln_modified_date,le.avelength_cln_load_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 23, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.ag_code),TRIM((SALT38.StrType)le.case_number),TRIM((SALT38.StrType)le.incident_date),TRIM((SALT38.StrType)le.jurisdiction),TRIM((SALT38.StrType)le.source_document),TRIM((SALT38.StrType)le.additional_info),TRIM((SALT38.StrType)le.agency),TRIM((SALT38.StrType)le.alleged_amount),TRIM((SALT38.StrType)le.estimated_loss),TRIM((SALT38.StrType)le.fcr_date),TRIM((SALT38.StrType)le.ok_for_fcr),TRIM((SALT38.StrType)le.modified_date),TRIM((SALT38.StrType)le.load_date),TRIM((SALT38.StrType)le.incident_text),TRIM((SALT38.StrType)le.incident_date_clean),TRIM((SALT38.StrType)le.fcr_date_clean),TRIM((SALT38.StrType)le.cln_modified_date),TRIM((SALT38.StrType)le.cln_load_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,23,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 23);
  SELF.FldNo2 := 1 + (C % 23);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.ag_code),TRIM((SALT38.StrType)le.case_number),TRIM((SALT38.StrType)le.incident_date),TRIM((SALT38.StrType)le.jurisdiction),TRIM((SALT38.StrType)le.source_document),TRIM((SALT38.StrType)le.additional_info),TRIM((SALT38.StrType)le.agency),TRIM((SALT38.StrType)le.alleged_amount),TRIM((SALT38.StrType)le.estimated_loss),TRIM((SALT38.StrType)le.fcr_date),TRIM((SALT38.StrType)le.ok_for_fcr),TRIM((SALT38.StrType)le.modified_date),TRIM((SALT38.StrType)le.load_date),TRIM((SALT38.StrType)le.incident_text),TRIM((SALT38.StrType)le.incident_date_clean),TRIM((SALT38.StrType)le.fcr_date_clean),TRIM((SALT38.StrType)le.cln_modified_date),TRIM((SALT38.StrType)le.cln_load_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.ag_code),TRIM((SALT38.StrType)le.case_number),TRIM((SALT38.StrType)le.incident_date),TRIM((SALT38.StrType)le.jurisdiction),TRIM((SALT38.StrType)le.source_document),TRIM((SALT38.StrType)le.additional_info),TRIM((SALT38.StrType)le.agency),TRIM((SALT38.StrType)le.alleged_amount),TRIM((SALT38.StrType)le.estimated_loss),TRIM((SALT38.StrType)le.fcr_date),TRIM((SALT38.StrType)le.ok_for_fcr),TRIM((SALT38.StrType)le.modified_date),TRIM((SALT38.StrType)le.load_date),TRIM((SALT38.StrType)le.incident_text),TRIM((SALT38.StrType)le.incident_date_clean),TRIM((SALT38.StrType)le.fcr_date_clean),TRIM((SALT38.StrType)le.cln_modified_date),TRIM((SALT38.StrType)le.cln_load_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),23*23,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'batch_number'}
      ,{2,'incident_number'}
      ,{3,'party_number'}
      ,{4,'record_type'}
      ,{5,'order_number'}
      ,{6,'ag_code'}
      ,{7,'case_number'}
      ,{8,'incident_date'}
      ,{9,'jurisdiction'}
      ,{10,'source_document'}
      ,{11,'additional_info'}
      ,{12,'agency'}
      ,{13,'alleged_amount'}
      ,{14,'estimated_loss'}
      ,{15,'fcr_date'}
      ,{16,'ok_for_fcr'}
      ,{17,'modified_date'}
      ,{18,'load_date'}
      ,{19,'incident_text'}
      ,{20,'incident_date_clean'}
      ,{21,'fcr_date_clean'}
      ,{22,'cln_modified_date'}
      ,{23,'cln_load_date'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    incident_Fields.InValid_batch_number((SALT38.StrType)le.batch_number),
    incident_Fields.InValid_incident_number((SALT38.StrType)le.incident_number),
    incident_Fields.InValid_party_number((SALT38.StrType)le.party_number),
    incident_Fields.InValid_record_type((SALT38.StrType)le.record_type),
    incident_Fields.InValid_order_number((SALT38.StrType)le.order_number),
    incident_Fields.InValid_ag_code((SALT38.StrType)le.ag_code),
    incident_Fields.InValid_case_number((SALT38.StrType)le.case_number),
    incident_Fields.InValid_incident_date((SALT38.StrType)le.incident_date),
    incident_Fields.InValid_jurisdiction((SALT38.StrType)le.jurisdiction),
    incident_Fields.InValid_source_document((SALT38.StrType)le.source_document),
    incident_Fields.InValid_additional_info((SALT38.StrType)le.additional_info),
    incident_Fields.InValid_agency((SALT38.StrType)le.agency),
    incident_Fields.InValid_alleged_amount((SALT38.StrType)le.alleged_amount),
    incident_Fields.InValid_estimated_loss((SALT38.StrType)le.estimated_loss),
    incident_Fields.InValid_fcr_date((SALT38.StrType)le.fcr_date),
    incident_Fields.InValid_ok_for_fcr((SALT38.StrType)le.ok_for_fcr),
    incident_Fields.InValid_modified_date((SALT38.StrType)le.modified_date),
    incident_Fields.InValid_load_date((SALT38.StrType)le.load_date),
    incident_Fields.InValid_incident_text((SALT38.StrType)le.incident_text),
    incident_Fields.InValid_incident_date_clean((SALT38.StrType)le.incident_date_clean),
    incident_Fields.InValid_fcr_date_clean((SALT38.StrType)le.fcr_date_clean),
    incident_Fields.InValid_cln_modified_date((SALT38.StrType)le.cln_modified_date),
    incident_Fields.InValid_cln_load_date((SALT38.StrType)le.cln_load_date),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,23,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := incident_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Batch','Invalid_Num','Invalid_Num','Unknown','Invalid_Num','Unknown','Unknown','Invalid_Date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Date','Unknown','Invalid_Date','Invalid_Date','Unknown','Invalid_CleanDate','Invalid_CleanDate','Invalid_CleanDate','Invalid_CleanDate');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,incident_Fields.InValidMessage_batch_number(TotalErrors.ErrorNum),incident_Fields.InValidMessage_incident_number(TotalErrors.ErrorNum),incident_Fields.InValidMessage_party_number(TotalErrors.ErrorNum),incident_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),incident_Fields.InValidMessage_order_number(TotalErrors.ErrorNum),incident_Fields.InValidMessage_ag_code(TotalErrors.ErrorNum),incident_Fields.InValidMessage_case_number(TotalErrors.ErrorNum),incident_Fields.InValidMessage_incident_date(TotalErrors.ErrorNum),incident_Fields.InValidMessage_jurisdiction(TotalErrors.ErrorNum),incident_Fields.InValidMessage_source_document(TotalErrors.ErrorNum),incident_Fields.InValidMessage_additional_info(TotalErrors.ErrorNum),incident_Fields.InValidMessage_agency(TotalErrors.ErrorNum),incident_Fields.InValidMessage_alleged_amount(TotalErrors.ErrorNum),incident_Fields.InValidMessage_estimated_loss(TotalErrors.ErrorNum),incident_Fields.InValidMessage_fcr_date(TotalErrors.ErrorNum),incident_Fields.InValidMessage_ok_for_fcr(TotalErrors.ErrorNum),incident_Fields.InValidMessage_modified_date(TotalErrors.ErrorNum),incident_Fields.InValidMessage_load_date(TotalErrors.ErrorNum),incident_Fields.InValidMessage_incident_text(TotalErrors.ErrorNum),incident_Fields.InValidMessage_incident_date_clean(TotalErrors.ErrorNum),incident_Fields.InValidMessage_fcr_date_clean(TotalErrors.ErrorNum),incident_Fields.InValidMessage_cln_modified_date(TotalErrors.ErrorNum),incident_Fields.InValidMessage_cln_load_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SANCTNKeys, incident_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
