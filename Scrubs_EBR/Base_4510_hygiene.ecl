IMPORT SALT311,STD;
EXPORT Base_4510_hygiene(dataset(Base_4510_layout_EBR) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_process_date_first_seen_cnt := COUNT(GROUP,h.process_date_first_seen <> (TYPEOF(h.process_date_first_seen))'');
    populated_process_date_first_seen_pcnt := AVE(GROUP,IF(h.process_date_first_seen = (TYPEOF(h.process_date_first_seen))'',0,100));
    maxlength_process_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date_first_seen)));
    avelength_process_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date_first_seen)),h.process_date_first_seen<>(typeof(h.process_date_first_seen))'');
    populated_process_date_last_seen_cnt := COUNT(GROUP,h.process_date_last_seen <> (TYPEOF(h.process_date_last_seen))'');
    populated_process_date_last_seen_pcnt := AVE(GROUP,IF(h.process_date_last_seen = (TYPEOF(h.process_date_last_seen))'',0,100));
    maxlength_process_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date_last_seen)));
    avelength_process_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date_last_seen)),h.process_date_last_seen<>(typeof(h.process_date_last_seen))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_file_number_cnt := COUNT(GROUP,h.file_number <> (TYPEOF(h.file_number))'');
    populated_file_number_pcnt := AVE(GROUP,IF(h.file_number = (TYPEOF(h.file_number))'',0,100));
    maxlength_file_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_number)));
    avelength_file_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_number)),h.file_number<>(typeof(h.file_number))'');
    populated_segment_code_cnt := COUNT(GROUP,h.segment_code <> (TYPEOF(h.segment_code))'');
    populated_segment_code_pcnt := AVE(GROUP,IF(h.segment_code = (TYPEOF(h.segment_code))'',0,100));
    maxlength_segment_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_code)));
    avelength_segment_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.segment_code)),h.segment_code<>(typeof(h.segment_code))'');
    populated_sequence_number_cnt := COUNT(GROUP,h.sequence_number <> (TYPEOF(h.sequence_number))'');
    populated_sequence_number_pcnt := AVE(GROUP,IF(h.sequence_number = (TYPEOF(h.sequence_number))'',0,100));
    maxlength_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_number)));
    avelength_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_number)),h.sequence_number<>(typeof(h.sequence_number))'');
    populated_orig_date_filed_yymmdd_cnt := COUNT(GROUP,h.orig_date_filed_yymmdd <> (TYPEOF(h.orig_date_filed_yymmdd))'');
    populated_orig_date_filed_yymmdd_pcnt := AVE(GROUP,IF(h.orig_date_filed_yymmdd = (TYPEOF(h.orig_date_filed_yymmdd))'',0,100));
    maxlength_orig_date_filed_yymmdd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_date_filed_yymmdd)));
    avelength_orig_date_filed_yymmdd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_date_filed_yymmdd)),h.orig_date_filed_yymmdd<>(typeof(h.orig_date_filed_yymmdd))'');
    populated_type_code_cnt := COUNT(GROUP,h.type_code <> (TYPEOF(h.type_code))'');
    populated_type_code_pcnt := AVE(GROUP,IF(h.type_code = (TYPEOF(h.type_code))'',0,100));
    maxlength_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_code)));
    avelength_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_code)),h.type_code<>(typeof(h.type_code))'');
    populated_type_desc_cnt := COUNT(GROUP,h.type_desc <> (TYPEOF(h.type_desc))'');
    populated_type_desc_pcnt := AVE(GROUP,IF(h.type_desc = (TYPEOF(h.type_desc))'',0,100));
    maxlength_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_desc)));
    avelength_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type_desc)),h.type_desc<>(typeof(h.type_desc))'');
    populated_action_code_cnt := COUNT(GROUP,h.action_code <> (TYPEOF(h.action_code))'');
    populated_action_code_pcnt := AVE(GROUP,IF(h.action_code = (TYPEOF(h.action_code))'',0,100));
    maxlength_action_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.action_code)));
    avelength_action_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.action_code)),h.action_code<>(typeof(h.action_code))'');
    populated_action_desc_cnt := COUNT(GROUP,h.action_desc <> (TYPEOF(h.action_desc))'');
    populated_action_desc_pcnt := AVE(GROUP,IF(h.action_desc = (TYPEOF(h.action_desc))'',0,100));
    maxlength_action_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.action_desc)));
    avelength_action_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.action_desc)),h.action_desc<>(typeof(h.action_desc))'');
    populated_document_number_cnt := COUNT(GROUP,h.document_number <> (TYPEOF(h.document_number))'');
    populated_document_number_pcnt := AVE(GROUP,IF(h.document_number = (TYPEOF(h.document_number))'',0,100));
    maxlength_document_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.document_number)));
    avelength_document_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.document_number)),h.document_number<>(typeof(h.document_number))'');
    populated_filing_location_cnt := COUNT(GROUP,h.filing_location <> (TYPEOF(h.filing_location))'');
    populated_filing_location_pcnt := AVE(GROUP,IF(h.filing_location = (TYPEOF(h.filing_location))'',0,100));
    maxlength_filing_location := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_location)));
    avelength_filing_location := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_location)),h.filing_location<>(typeof(h.filing_location))'');
    populated_coll_code1_cnt := COUNT(GROUP,h.coll_code1 <> (TYPEOF(h.coll_code1))'');
    populated_coll_code1_pcnt := AVE(GROUP,IF(h.coll_code1 = (TYPEOF(h.coll_code1))'',0,100));
    maxlength_coll_code1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code1)));
    avelength_coll_code1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code1)),h.coll_code1<>(typeof(h.coll_code1))'');
    populated_coll_desc1_cnt := COUNT(GROUP,h.coll_desc1 <> (TYPEOF(h.coll_desc1))'');
    populated_coll_desc1_pcnt := AVE(GROUP,IF(h.coll_desc1 = (TYPEOF(h.coll_desc1))'',0,100));
    maxlength_coll_desc1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc1)));
    avelength_coll_desc1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc1)),h.coll_desc1<>(typeof(h.coll_desc1))'');
    populated_coll_code2_cnt := COUNT(GROUP,h.coll_code2 <> (TYPEOF(h.coll_code2))'');
    populated_coll_code2_pcnt := AVE(GROUP,IF(h.coll_code2 = (TYPEOF(h.coll_code2))'',0,100));
    maxlength_coll_code2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code2)));
    avelength_coll_code2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code2)),h.coll_code2<>(typeof(h.coll_code2))'');
    populated_coll_desc2_cnt := COUNT(GROUP,h.coll_desc2 <> (TYPEOF(h.coll_desc2))'');
    populated_coll_desc2_pcnt := AVE(GROUP,IF(h.coll_desc2 = (TYPEOF(h.coll_desc2))'',0,100));
    maxlength_coll_desc2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc2)));
    avelength_coll_desc2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc2)),h.coll_desc2<>(typeof(h.coll_desc2))'');
    populated_coll_code3_cnt := COUNT(GROUP,h.coll_code3 <> (TYPEOF(h.coll_code3))'');
    populated_coll_code3_pcnt := AVE(GROUP,IF(h.coll_code3 = (TYPEOF(h.coll_code3))'',0,100));
    maxlength_coll_code3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code3)));
    avelength_coll_code3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code3)),h.coll_code3<>(typeof(h.coll_code3))'');
    populated_coll_desc3_cnt := COUNT(GROUP,h.coll_desc3 <> (TYPEOF(h.coll_desc3))'');
    populated_coll_desc3_pcnt := AVE(GROUP,IF(h.coll_desc3 = (TYPEOF(h.coll_desc3))'',0,100));
    maxlength_coll_desc3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc3)));
    avelength_coll_desc3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc3)),h.coll_desc3<>(typeof(h.coll_desc3))'');
    populated_coll_code4_cnt := COUNT(GROUP,h.coll_code4 <> (TYPEOF(h.coll_code4))'');
    populated_coll_code4_pcnt := AVE(GROUP,IF(h.coll_code4 = (TYPEOF(h.coll_code4))'',0,100));
    maxlength_coll_code4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code4)));
    avelength_coll_code4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code4)),h.coll_code4<>(typeof(h.coll_code4))'');
    populated_coll_desc4_cnt := COUNT(GROUP,h.coll_desc4 <> (TYPEOF(h.coll_desc4))'');
    populated_coll_desc4_pcnt := AVE(GROUP,IF(h.coll_desc4 = (TYPEOF(h.coll_desc4))'',0,100));
    maxlength_coll_desc4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc4)));
    avelength_coll_desc4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc4)),h.coll_desc4<>(typeof(h.coll_desc4))'');
    populated_coll_code5_cnt := COUNT(GROUP,h.coll_code5 <> (TYPEOF(h.coll_code5))'');
    populated_coll_code5_pcnt := AVE(GROUP,IF(h.coll_code5 = (TYPEOF(h.coll_code5))'',0,100));
    maxlength_coll_code5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code5)));
    avelength_coll_code5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code5)),h.coll_code5<>(typeof(h.coll_code5))'');
    populated_coll_desc5_cnt := COUNT(GROUP,h.coll_desc5 <> (TYPEOF(h.coll_desc5))'');
    populated_coll_desc5_pcnt := AVE(GROUP,IF(h.coll_desc5 = (TYPEOF(h.coll_desc5))'',0,100));
    maxlength_coll_desc5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc5)));
    avelength_coll_desc5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc5)),h.coll_desc5<>(typeof(h.coll_desc5))'');
    populated_coll_code6_cnt := COUNT(GROUP,h.coll_code6 <> (TYPEOF(h.coll_code6))'');
    populated_coll_code6_pcnt := AVE(GROUP,IF(h.coll_code6 = (TYPEOF(h.coll_code6))'',0,100));
    maxlength_coll_code6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code6)));
    avelength_coll_code6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_code6)),h.coll_code6<>(typeof(h.coll_code6))'');
    populated_coll_desc6_cnt := COUNT(GROUP,h.coll_desc6 <> (TYPEOF(h.coll_desc6))'');
    populated_coll_desc6_pcnt := AVE(GROUP,IF(h.coll_desc6 = (TYPEOF(h.coll_desc6))'',0,100));
    maxlength_coll_desc6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc6)));
    avelength_coll_desc6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coll_desc6)),h.coll_desc6<>(typeof(h.coll_desc6))'');
    populated_orig_file_state_code_cnt := COUNT(GROUP,h.orig_file_state_code <> (TYPEOF(h.orig_file_state_code))'');
    populated_orig_file_state_code_pcnt := AVE(GROUP,IF(h.orig_file_state_code = (TYPEOF(h.orig_file_state_code))'',0,100));
    maxlength_orig_file_state_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_file_state_code)));
    avelength_orig_file_state_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_file_state_code)),h.orig_file_state_code<>(typeof(h.orig_file_state_code))'');
    populated_orig_file_state_desc_cnt := COUNT(GROUP,h.orig_file_state_desc <> (TYPEOF(h.orig_file_state_desc))'');
    populated_orig_file_state_desc_pcnt := AVE(GROUP,IF(h.orig_file_state_desc = (TYPEOF(h.orig_file_state_desc))'',0,100));
    maxlength_orig_file_state_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_file_state_desc)));
    avelength_orig_file_state_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_file_state_desc)),h.orig_file_state_desc<>(typeof(h.orig_file_state_desc))'');
    populated_orig_file_number_cnt := COUNT(GROUP,h.orig_file_number <> (TYPEOF(h.orig_file_number))'');
    populated_orig_file_number_pcnt := AVE(GROUP,IF(h.orig_file_number = (TYPEOF(h.orig_file_number))'',0,100));
    maxlength_orig_file_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_file_number)));
    avelength_orig_file_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_file_number)),h.orig_file_number<>(typeof(h.orig_file_number))'');
    populated_date_filed_cnt := COUNT(GROUP,h.date_filed <> (TYPEOF(h.date_filed))'');
    populated_date_filed_pcnt := AVE(GROUP,IF(h.date_filed = (TYPEOF(h.date_filed))'',0,100));
    maxlength_date_filed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_filed)));
    avelength_date_filed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_filed)),h.date_filed<>(typeof(h.date_filed))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_process_date_first_seen_pcnt *   0.00 / 100 + T.Populated_process_date_last_seen_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_segment_code_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_orig_date_filed_yymmdd_pcnt *   0.00 / 100 + T.Populated_type_code_pcnt *   0.00 / 100 + T.Populated_type_desc_pcnt *   0.00 / 100 + T.Populated_action_code_pcnt *   0.00 / 100 + T.Populated_action_desc_pcnt *   0.00 / 100 + T.Populated_document_number_pcnt *   0.00 / 100 + T.Populated_filing_location_pcnt *   0.00 / 100 + T.Populated_coll_code1_pcnt *   0.00 / 100 + T.Populated_coll_desc1_pcnt *   0.00 / 100 + T.Populated_coll_code2_pcnt *   0.00 / 100 + T.Populated_coll_desc2_pcnt *   0.00 / 100 + T.Populated_coll_code3_pcnt *   0.00 / 100 + T.Populated_coll_desc3_pcnt *   0.00 / 100 + T.Populated_coll_code4_pcnt *   0.00 / 100 + T.Populated_coll_desc4_pcnt *   0.00 / 100 + T.Populated_coll_code5_pcnt *   0.00 / 100 + T.Populated_coll_desc5_pcnt *   0.00 / 100 + T.Populated_coll_code6_pcnt *   0.00 / 100 + T.Populated_coll_desc6_pcnt *   0.00 / 100 + T.Populated_orig_file_state_code_pcnt *   0.00 / 100 + T.Populated_orig_file_state_desc_pcnt *   0.00 / 100 + T.Populated_orig_file_number_pcnt *   0.00 / 100 + T.Populated_date_filed_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','orig_date_filed_yymmdd','type_code','type_desc','action_code','action_desc','document_number','filing_location','coll_code1','coll_desc1','coll_code2','coll_desc2','coll_code3','coll_desc3','coll_code4','coll_desc4','coll_code5','coll_desc5','coll_code6','coll_desc6','orig_file_state_code','orig_file_state_desc','orig_file_number','date_filed');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_process_date_first_seen_pcnt,le.populated_process_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_process_date_pcnt,le.populated_file_number_pcnt,le.populated_segment_code_pcnt,le.populated_sequence_number_pcnt,le.populated_orig_date_filed_yymmdd_pcnt,le.populated_type_code_pcnt,le.populated_type_desc_pcnt,le.populated_action_code_pcnt,le.populated_action_desc_pcnt,le.populated_document_number_pcnt,le.populated_filing_location_pcnt,le.populated_coll_code1_pcnt,le.populated_coll_desc1_pcnt,le.populated_coll_code2_pcnt,le.populated_coll_desc2_pcnt,le.populated_coll_code3_pcnt,le.populated_coll_desc3_pcnt,le.populated_coll_code4_pcnt,le.populated_coll_desc4_pcnt,le.populated_coll_code5_pcnt,le.populated_coll_desc5_pcnt,le.populated_coll_code6_pcnt,le.populated_coll_desc6_pcnt,le.populated_orig_file_state_code_pcnt,le.populated_orig_file_state_desc_pcnt,le.populated_orig_file_number_pcnt,le.populated_date_filed_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_process_date_first_seen,le.maxlength_process_date_last_seen,le.maxlength_record_type,le.maxlength_process_date,le.maxlength_file_number,le.maxlength_segment_code,le.maxlength_sequence_number,le.maxlength_orig_date_filed_yymmdd,le.maxlength_type_code,le.maxlength_type_desc,le.maxlength_action_code,le.maxlength_action_desc,le.maxlength_document_number,le.maxlength_filing_location,le.maxlength_coll_code1,le.maxlength_coll_desc1,le.maxlength_coll_code2,le.maxlength_coll_desc2,le.maxlength_coll_code3,le.maxlength_coll_desc3,le.maxlength_coll_code4,le.maxlength_coll_desc4,le.maxlength_coll_code5,le.maxlength_coll_desc5,le.maxlength_coll_code6,le.maxlength_coll_desc6,le.maxlength_orig_file_state_code,le.maxlength_orig_file_state_desc,le.maxlength_orig_file_number,le.maxlength_date_filed);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_process_date_first_seen,le.avelength_process_date_last_seen,le.avelength_record_type,le.avelength_process_date,le.avelength_file_number,le.avelength_segment_code,le.avelength_sequence_number,le.avelength_orig_date_filed_yymmdd,le.avelength_type_code,le.avelength_type_desc,le.avelength_action_code,le.avelength_action_desc,le.avelength_document_number,le.avelength_filing_location,le.avelength_coll_code1,le.avelength_coll_desc1,le.avelength_coll_code2,le.avelength_coll_desc2,le.avelength_coll_code3,le.avelength_coll_desc3,le.avelength_coll_code4,le.avelength_coll_desc4,le.avelength_coll_code5,le.avelength_coll_desc5,le.avelength_coll_code6,le.avelength_coll_desc6,le.avelength_orig_file_state_code,le.avelength_orig_file_state_desc,le.avelength_orig_file_number,le.avelength_date_filed);
END;
EXPORT invSummary := NORMALIZE(summary0, 38, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.orig_date_filed_yymmdd),TRIM((SALT311.StrType)le.type_code),TRIM((SALT311.StrType)le.type_desc),TRIM((SALT311.StrType)le.action_code),TRIM((SALT311.StrType)le.action_desc),TRIM((SALT311.StrType)le.document_number),TRIM((SALT311.StrType)le.filing_location),TRIM((SALT311.StrType)le.coll_code1),TRIM((SALT311.StrType)le.coll_desc1),TRIM((SALT311.StrType)le.coll_code2),TRIM((SALT311.StrType)le.coll_desc2),TRIM((SALT311.StrType)le.coll_code3),TRIM((SALT311.StrType)le.coll_desc3),TRIM((SALT311.StrType)le.coll_code4),TRIM((SALT311.StrType)le.coll_desc4),TRIM((SALT311.StrType)le.coll_code5),TRIM((SALT311.StrType)le.coll_desc5),TRIM((SALT311.StrType)le.coll_code6),TRIM((SALT311.StrType)le.coll_desc6),TRIM((SALT311.StrType)le.orig_file_state_code),TRIM((SALT311.StrType)le.orig_file_state_desc),TRIM((SALT311.StrType)le.orig_file_number),TRIM((SALT311.StrType)le.date_filed)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,38,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 38);
  SELF.FldNo2 := 1 + (C % 38);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.orig_date_filed_yymmdd),TRIM((SALT311.StrType)le.type_code),TRIM((SALT311.StrType)le.type_desc),TRIM((SALT311.StrType)le.action_code),TRIM((SALT311.StrType)le.action_desc),TRIM((SALT311.StrType)le.document_number),TRIM((SALT311.StrType)le.filing_location),TRIM((SALT311.StrType)le.coll_code1),TRIM((SALT311.StrType)le.coll_desc1),TRIM((SALT311.StrType)le.coll_code2),TRIM((SALT311.StrType)le.coll_desc2),TRIM((SALT311.StrType)le.coll_code3),TRIM((SALT311.StrType)le.coll_desc3),TRIM((SALT311.StrType)le.coll_code4),TRIM((SALT311.StrType)le.coll_desc4),TRIM((SALT311.StrType)le.coll_code5),TRIM((SALT311.StrType)le.coll_desc5),TRIM((SALT311.StrType)le.coll_code6),TRIM((SALT311.StrType)le.coll_desc6),TRIM((SALT311.StrType)le.orig_file_state_code),TRIM((SALT311.StrType)le.orig_file_state_desc),TRIM((SALT311.StrType)le.orig_file_number),TRIM((SALT311.StrType)le.date_filed)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.orig_date_filed_yymmdd),TRIM((SALT311.StrType)le.type_code),TRIM((SALT311.StrType)le.type_desc),TRIM((SALT311.StrType)le.action_code),TRIM((SALT311.StrType)le.action_desc),TRIM((SALT311.StrType)le.document_number),TRIM((SALT311.StrType)le.filing_location),TRIM((SALT311.StrType)le.coll_code1),TRIM((SALT311.StrType)le.coll_desc1),TRIM((SALT311.StrType)le.coll_code2),TRIM((SALT311.StrType)le.coll_desc2),TRIM((SALT311.StrType)le.coll_code3),TRIM((SALT311.StrType)le.coll_desc3),TRIM((SALT311.StrType)le.coll_code4),TRIM((SALT311.StrType)le.coll_desc4),TRIM((SALT311.StrType)le.coll_code5),TRIM((SALT311.StrType)le.coll_desc5),TRIM((SALT311.StrType)le.coll_code6),TRIM((SALT311.StrType)le.coll_desc6),TRIM((SALT311.StrType)le.orig_file_state_code),TRIM((SALT311.StrType)le.orig_file_state_desc),TRIM((SALT311.StrType)le.orig_file_number),TRIM((SALT311.StrType)le.date_filed)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),38*38,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'powid'}
      ,{2,'proxid'}
      ,{3,'seleid'}
      ,{4,'orgid'}
      ,{5,'ultid'}
      ,{6,'bdid'}
      ,{7,'date_first_seen'}
      ,{8,'date_last_seen'}
      ,{9,'process_date_first_seen'}
      ,{10,'process_date_last_seen'}
      ,{11,'record_type'}
      ,{12,'process_date'}
      ,{13,'file_number'}
      ,{14,'segment_code'}
      ,{15,'sequence_number'}
      ,{16,'orig_date_filed_yymmdd'}
      ,{17,'type_code'}
      ,{18,'type_desc'}
      ,{19,'action_code'}
      ,{20,'action_desc'}
      ,{21,'document_number'}
      ,{22,'filing_location'}
      ,{23,'coll_code1'}
      ,{24,'coll_desc1'}
      ,{25,'coll_code2'}
      ,{26,'coll_desc2'}
      ,{27,'coll_code3'}
      ,{28,'coll_desc3'}
      ,{29,'coll_code4'}
      ,{30,'coll_desc4'}
      ,{31,'coll_code5'}
      ,{32,'coll_desc5'}
      ,{33,'coll_code6'}
      ,{34,'coll_desc6'}
      ,{35,'orig_file_state_code'}
      ,{36,'orig_file_state_desc'}
      ,{37,'orig_file_number'}
      ,{38,'date_filed'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_4510_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_4510_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_4510_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_4510_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_4510_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_4510_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_4510_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Base_4510_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Base_4510_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen),
    Base_4510_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen),
    Base_4510_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_4510_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_4510_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Base_4510_Fields.InValid_segment_code((SALT311.StrType)le.segment_code),
    Base_4510_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    Base_4510_Fields.InValid_orig_date_filed_yymmdd((SALT311.StrType)le.orig_date_filed_yymmdd),
    Base_4510_Fields.InValid_type_code((SALT311.StrType)le.type_code),
    Base_4510_Fields.InValid_type_desc((SALT311.StrType)le.type_desc),
    Base_4510_Fields.InValid_action_code((SALT311.StrType)le.action_code),
    Base_4510_Fields.InValid_action_desc((SALT311.StrType)le.action_desc),
    Base_4510_Fields.InValid_document_number((SALT311.StrType)le.document_number),
    Base_4510_Fields.InValid_filing_location((SALT311.StrType)le.filing_location),
    Base_4510_Fields.InValid_coll_code1((SALT311.StrType)le.coll_code1),
    Base_4510_Fields.InValid_coll_desc1((SALT311.StrType)le.coll_desc1),
    Base_4510_Fields.InValid_coll_code2((SALT311.StrType)le.coll_code2),
    Base_4510_Fields.InValid_coll_desc2((SALT311.StrType)le.coll_desc2),
    Base_4510_Fields.InValid_coll_code3((SALT311.StrType)le.coll_code3),
    Base_4510_Fields.InValid_coll_desc3((SALT311.StrType)le.coll_desc3),
    Base_4510_Fields.InValid_coll_code4((SALT311.StrType)le.coll_code4),
    Base_4510_Fields.InValid_coll_desc4((SALT311.StrType)le.coll_desc4),
    Base_4510_Fields.InValid_coll_code5((SALT311.StrType)le.coll_code5),
    Base_4510_Fields.InValid_coll_desc5((SALT311.StrType)le.coll_desc5),
    Base_4510_Fields.InValid_coll_code6((SALT311.StrType)le.coll_code6),
    Base_4510_Fields.InValid_coll_desc6((SALT311.StrType)le.coll_desc6),
    Base_4510_Fields.InValid_orig_file_state_code((SALT311.StrType)le.orig_file_state_code),
    Base_4510_Fields.InValid_orig_file_state_desc((SALT311.StrType)le.orig_file_state_desc),
    Base_4510_Fields.InValid_orig_file_number((SALT311.StrType)le.orig_file_number),
    Base_4510_Fields.InValid_date_filed((SALT311.StrType)le.date_filed),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,38,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_4510_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_dt_yymmdd','invalid_type_code','invalid_type_desc','invalid_action_code','invalid_action_desc','invalid_mandatory','invalid_mandatory','invalid_coll_code','invalid_coll_desc','invalid_coll_code','invalid_coll_desc','invalid_coll_code','invalid_coll_desc','invalid_coll_code','invalid_coll_desc','invalid_coll_code','invalid_coll_desc','invalid_coll_code','invalid_coll_desc','invalid_state','invalid_state_desc','invalid_mandatory','invalid_pastdate');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_4510_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_process_date_first_seen(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_process_date_last_seen(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_segment_code(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_orig_date_filed_yymmdd(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_type_code(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_type_desc(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_action_code(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_action_desc(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_document_number(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_filing_location(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_code1(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_desc1(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_code2(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_desc2(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_code3(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_desc3(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_code4(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_desc4(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_code5(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_desc5(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_code6(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_coll_desc6(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_orig_file_state_code(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_orig_file_state_desc(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_orig_file_number(TotalErrors.ErrorNum),Base_4510_Fields.InValidMessage_date_filed(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_4510_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
