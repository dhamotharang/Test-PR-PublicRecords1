IMPORT SALT311,STD;
EXPORT Base_5610_hygiene(dataset(Base_5610_layout_EBR) h) := MODULE
 
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
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
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
    populated_officer_title_cnt := COUNT(GROUP,h.officer_title <> (TYPEOF(h.officer_title))'');
    populated_officer_title_pcnt := AVE(GROUP,IF(h.officer_title = (TYPEOF(h.officer_title))'',0,100));
    maxlength_officer_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officer_title)));
    avelength_officer_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officer_title)),h.officer_title<>(typeof(h.officer_title))'');
    populated_officer_first_name_cnt := COUNT(GROUP,h.officer_first_name <> (TYPEOF(h.officer_first_name))'');
    populated_officer_first_name_pcnt := AVE(GROUP,IF(h.officer_first_name = (TYPEOF(h.officer_first_name))'',0,100));
    maxlength_officer_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officer_first_name)));
    avelength_officer_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officer_first_name)),h.officer_first_name<>(typeof(h.officer_first_name))'');
    populated_officer_m_i_cnt := COUNT(GROUP,h.officer_m_i <> (TYPEOF(h.officer_m_i))'');
    populated_officer_m_i_pcnt := AVE(GROUP,IF(h.officer_m_i = (TYPEOF(h.officer_m_i))'',0,100));
    maxlength_officer_m_i := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officer_m_i)));
    avelength_officer_m_i := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officer_m_i)),h.officer_m_i<>(typeof(h.officer_m_i))'');
    populated_officer_last_name_cnt := COUNT(GROUP,h.officer_last_name <> (TYPEOF(h.officer_last_name))'');
    populated_officer_last_name_pcnt := AVE(GROUP,IF(h.officer_last_name = (TYPEOF(h.officer_last_name))'',0,100));
    maxlength_officer_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.officer_last_name)));
    avelength_officer_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.officer_last_name)),h.officer_last_name<>(typeof(h.officer_last_name))'');
    populated_clean_officer_name_title_cnt := COUNT(GROUP,h.clean_officer_name_title <> (TYPEOF(h.clean_officer_name_title))'');
    populated_clean_officer_name_title_pcnt := AVE(GROUP,IF(h.clean_officer_name_title = (TYPEOF(h.clean_officer_name_title))'',0,100));
    maxlength_clean_officer_name_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_officer_name_title)));
    avelength_clean_officer_name_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_officer_name_title)),h.clean_officer_name_title<>(typeof(h.clean_officer_name_title))'');
    populated_clean_officer_name_fname_cnt := COUNT(GROUP,h.clean_officer_name_fname <> (TYPEOF(h.clean_officer_name_fname))'');
    populated_clean_officer_name_fname_pcnt := AVE(GROUP,IF(h.clean_officer_name_fname = (TYPEOF(h.clean_officer_name_fname))'',0,100));
    maxlength_clean_officer_name_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_officer_name_fname)));
    avelength_clean_officer_name_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_officer_name_fname)),h.clean_officer_name_fname<>(typeof(h.clean_officer_name_fname))'');
    populated_clean_officer_name_mname_cnt := COUNT(GROUP,h.clean_officer_name_mname <> (TYPEOF(h.clean_officer_name_mname))'');
    populated_clean_officer_name_mname_pcnt := AVE(GROUP,IF(h.clean_officer_name_mname = (TYPEOF(h.clean_officer_name_mname))'',0,100));
    maxlength_clean_officer_name_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_officer_name_mname)));
    avelength_clean_officer_name_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_officer_name_mname)),h.clean_officer_name_mname<>(typeof(h.clean_officer_name_mname))'');
    populated_clean_officer_name_lname_cnt := COUNT(GROUP,h.clean_officer_name_lname <> (TYPEOF(h.clean_officer_name_lname))'');
    populated_clean_officer_name_lname_pcnt := AVE(GROUP,IF(h.clean_officer_name_lname = (TYPEOF(h.clean_officer_name_lname))'',0,100));
    maxlength_clean_officer_name_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_officer_name_lname)));
    avelength_clean_officer_name_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_officer_name_lname)),h.clean_officer_name_lname<>(typeof(h.clean_officer_name_lname))'');
    populated_clean_officer_name_name_suffix_cnt := COUNT(GROUP,h.clean_officer_name_name_suffix <> (TYPEOF(h.clean_officer_name_name_suffix))'');
    populated_clean_officer_name_name_suffix_pcnt := AVE(GROUP,IF(h.clean_officer_name_name_suffix = (TYPEOF(h.clean_officer_name_name_suffix))'',0,100));
    maxlength_clean_officer_name_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_officer_name_name_suffix)));
    avelength_clean_officer_name_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_officer_name_name_suffix)),h.clean_officer_name_name_suffix<>(typeof(h.clean_officer_name_name_suffix))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_process_date_first_seen_pcnt *   0.00 / 100 + T.Populated_process_date_last_seen_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_segment_code_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_officer_title_pcnt *   0.00 / 100 + T.Populated_officer_first_name_pcnt *   0.00 / 100 + T.Populated_officer_m_i_pcnt *   0.00 / 100 + T.Populated_officer_last_name_pcnt *   0.00 / 100 + T.Populated_clean_officer_name_title_pcnt *   0.00 / 100 + T.Populated_clean_officer_name_fname_pcnt *   0.00 / 100 + T.Populated_clean_officer_name_mname_pcnt *   0.00 / 100 + T.Populated_clean_officer_name_lname_pcnt *   0.00 / 100 + T.Populated_clean_officer_name_name_suffix_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','did','ssn','process_date','file_number','segment_code','sequence_number','officer_title','officer_first_name','officer_m_i','officer_last_name','clean_officer_name_title','clean_officer_name_fname','clean_officer_name_mname','clean_officer_name_lname','clean_officer_name_name_suffix');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_process_date_first_seen_pcnt,le.populated_process_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_did_pcnt,le.populated_ssn_pcnt,le.populated_process_date_pcnt,le.populated_file_number_pcnt,le.populated_segment_code_pcnt,le.populated_sequence_number_pcnt,le.populated_officer_title_pcnt,le.populated_officer_first_name_pcnt,le.populated_officer_m_i_pcnt,le.populated_officer_last_name_pcnt,le.populated_clean_officer_name_title_pcnt,le.populated_clean_officer_name_fname_pcnt,le.populated_clean_officer_name_mname_pcnt,le.populated_clean_officer_name_lname_pcnt,le.populated_clean_officer_name_name_suffix_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_process_date_first_seen,le.maxlength_process_date_last_seen,le.maxlength_record_type,le.maxlength_did,le.maxlength_ssn,le.maxlength_process_date,le.maxlength_file_number,le.maxlength_segment_code,le.maxlength_sequence_number,le.maxlength_officer_title,le.maxlength_officer_first_name,le.maxlength_officer_m_i,le.maxlength_officer_last_name,le.maxlength_clean_officer_name_title,le.maxlength_clean_officer_name_fname,le.maxlength_clean_officer_name_mname,le.maxlength_clean_officer_name_lname,le.maxlength_clean_officer_name_name_suffix);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_process_date_first_seen,le.avelength_process_date_last_seen,le.avelength_record_type,le.avelength_did,le.avelength_ssn,le.avelength_process_date,le.avelength_file_number,le.avelength_segment_code,le.avelength_sequence_number,le.avelength_officer_title,le.avelength_officer_first_name,le.avelength_officer_m_i,le.avelength_officer_last_name,le.avelength_clean_officer_name_title,le.avelength_clean_officer_name_fname,le.avelength_clean_officer_name_mname,le.avelength_clean_officer_name_lname,le.avelength_clean_officer_name_name_suffix);
END;
EXPORT invSummary := NORMALIZE(summary0, 26, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.ssn <> 0,TRIM((SALT311.StrType)le.ssn), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.officer_title),TRIM((SALT311.StrType)le.officer_first_name),TRIM((SALT311.StrType)le.officer_m_i),TRIM((SALT311.StrType)le.officer_last_name),TRIM((SALT311.StrType)le.clean_officer_name_title),TRIM((SALT311.StrType)le.clean_officer_name_fname),TRIM((SALT311.StrType)le.clean_officer_name_mname),TRIM((SALT311.StrType)le.clean_officer_name_lname),TRIM((SALT311.StrType)le.clean_officer_name_name_suffix)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,26,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 26);
  SELF.FldNo2 := 1 + (C % 26);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.ssn <> 0,TRIM((SALT311.StrType)le.ssn), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.officer_title),TRIM((SALT311.StrType)le.officer_first_name),TRIM((SALT311.StrType)le.officer_m_i),TRIM((SALT311.StrType)le.officer_last_name),TRIM((SALT311.StrType)le.clean_officer_name_title),TRIM((SALT311.StrType)le.clean_officer_name_fname),TRIM((SALT311.StrType)le.clean_officer_name_mname),TRIM((SALT311.StrType)le.clean_officer_name_lname),TRIM((SALT311.StrType)le.clean_officer_name_name_suffix)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.ssn <> 0,TRIM((SALT311.StrType)le.ssn), ''),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.officer_title),TRIM((SALT311.StrType)le.officer_first_name),TRIM((SALT311.StrType)le.officer_m_i),TRIM((SALT311.StrType)le.officer_last_name),TRIM((SALT311.StrType)le.clean_officer_name_title),TRIM((SALT311.StrType)le.clean_officer_name_fname),TRIM((SALT311.StrType)le.clean_officer_name_mname),TRIM((SALT311.StrType)le.clean_officer_name_lname),TRIM((SALT311.StrType)le.clean_officer_name_name_suffix)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),26*26,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{12,'did'}
      ,{13,'ssn'}
      ,{14,'process_date'}
      ,{15,'file_number'}
      ,{16,'segment_code'}
      ,{17,'sequence_number'}
      ,{18,'officer_title'}
      ,{19,'officer_first_name'}
      ,{20,'officer_m_i'}
      ,{21,'officer_last_name'}
      ,{22,'clean_officer_name_title'}
      ,{23,'clean_officer_name_fname'}
      ,{24,'clean_officer_name_mname'}
      ,{25,'clean_officer_name_lname'}
      ,{26,'clean_officer_name_name_suffix'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_5610_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_5610_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_5610_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_5610_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_5610_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_5610_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_5610_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Base_5610_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Base_5610_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen),
    Base_5610_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen),
    Base_5610_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_5610_Fields.InValid_did((SALT311.StrType)le.did),
    Base_5610_Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Base_5610_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_5610_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Base_5610_Fields.InValid_segment_code((SALT311.StrType)le.segment_code),
    Base_5610_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    Base_5610_Fields.InValid_officer_title((SALT311.StrType)le.officer_title),
    Base_5610_Fields.InValid_officer_first_name((SALT311.StrType)le.officer_first_name),
    Base_5610_Fields.InValid_officer_m_i((SALT311.StrType)le.officer_m_i),
    Base_5610_Fields.InValid_officer_last_name((SALT311.StrType)le.officer_last_name),
    Base_5610_Fields.InValid_clean_officer_name_title((SALT311.StrType)le.clean_officer_name_title),
    Base_5610_Fields.InValid_clean_officer_name_fname((SALT311.StrType)le.clean_officer_name_fname),
    Base_5610_Fields.InValid_clean_officer_name_mname((SALT311.StrType)le.clean_officer_name_mname),
    Base_5610_Fields.InValid_clean_officer_name_lname((SALT311.StrType)le.clean_officer_name_lname),
    Base_5610_Fields.InValid_clean_officer_name_name_suffix((SALT311.StrType)le.clean_officer_name_name_suffix),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,26,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_5610_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_numeric','invalid_numeric_or_allzeros','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_5610_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_process_date_first_seen(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_process_date_last_seen(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_segment_code(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_officer_title(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_officer_first_name(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_officer_m_i(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_officer_last_name(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_clean_officer_name_title(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_clean_officer_name_fname(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_clean_officer_name_mname(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_clean_officer_name_lname(TotalErrors.ErrorNum),Base_5610_Fields.InValidMessage_clean_officer_name_name_suffix(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_5610_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
