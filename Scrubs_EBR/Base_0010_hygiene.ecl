IMPORT SALT311,STD;
EXPORT Base_0010_hygiene(dataset(Base_0010_layout_EBR) h) := MODULE
 
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
    populated_orig_extract_date_mdy_cnt := COUNT(GROUP,h.orig_extract_date_mdy <> (TYPEOF(h.orig_extract_date_mdy))'');
    populated_orig_extract_date_mdy_pcnt := AVE(GROUP,IF(h.orig_extract_date_mdy = (TYPEOF(h.orig_extract_date_mdy))'',0,100));
    maxlength_orig_extract_date_mdy := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_extract_date_mdy)));
    avelength_orig_extract_date_mdy := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_extract_date_mdy)),h.orig_extract_date_mdy<>(typeof(h.orig_extract_date_mdy))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_phone_number_cnt := COUNT(GROUP,h.phone_number <> (TYPEOF(h.phone_number))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_sic_code_cnt := COUNT(GROUP,h.sic_code <> (TYPEOF(h.sic_code))'');
    populated_sic_code_pcnt := AVE(GROUP,IF(h.sic_code = (TYPEOF(h.sic_code))'',0,100));
    maxlength_sic_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_code)));
    avelength_sic_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_code)),h.sic_code<>(typeof(h.sic_code))'');
    populated_business_desc_cnt := COUNT(GROUP,h.business_desc <> (TYPEOF(h.business_desc))'');
    populated_business_desc_pcnt := AVE(GROUP,IF(h.business_desc = (TYPEOF(h.business_desc))'',0,100));
    maxlength_business_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_desc)));
    avelength_business_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_desc)),h.business_desc<>(typeof(h.business_desc))'');
    populated_extract_date_cnt := COUNT(GROUP,h.extract_date <> (TYPEOF(h.extract_date))'');
    populated_extract_date_pcnt := AVE(GROUP,IF(h.extract_date = (TYPEOF(h.extract_date))'',0,100));
    maxlength_extract_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.extract_date)));
    avelength_extract_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.extract_date)),h.extract_date<>(typeof(h.extract_date))'');
    populated_file_estab_date_cnt := COUNT(GROUP,h.file_estab_date <> (TYPEOF(h.file_estab_date))'');
    populated_file_estab_date_pcnt := AVE(GROUP,IF(h.file_estab_date = (TYPEOF(h.file_estab_date))'',0,100));
    maxlength_file_estab_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_estab_date)));
    avelength_file_estab_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_estab_date)),h.file_estab_date<>(typeof(h.file_estab_date))'');
    populated_prep_addr_line1_cnt := COUNT(GROUP,h.prep_addr_line1 <> (TYPEOF(h.prep_addr_line1))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_last_line_cnt := COUNT(GROUP,h.prep_addr_last_line <> (TYPEOF(h.prep_addr_last_line))'');
    populated_prep_addr_last_line_pcnt := AVE(GROUP,IF(h.prep_addr_last_line = (TYPEOF(h.prep_addr_last_line))'',0,100));
    maxlength_prep_addr_last_line := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_last_line)));
    avelength_prep_addr_last_line := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_addr_last_line)),h.prep_addr_last_line<>(typeof(h.prep_addr_last_line))'');
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_clean_address_prim_name_cnt := COUNT(GROUP,h.clean_address_prim_name <> (TYPEOF(h.clean_address_prim_name))'');
    populated_clean_address_prim_name_pcnt := AVE(GROUP,IF(h.clean_address_prim_name = (TYPEOF(h.clean_address_prim_name))'',0,100));
    maxlength_clean_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_prim_name)));
    avelength_clean_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_prim_name)),h.clean_address_prim_name<>(typeof(h.clean_address_prim_name))'');
    populated_clean_address_p_city_name_cnt := COUNT(GROUP,h.clean_address_p_city_name <> (TYPEOF(h.clean_address_p_city_name))'');
    populated_clean_address_p_city_name_pcnt := AVE(GROUP,IF(h.clean_address_p_city_name = (TYPEOF(h.clean_address_p_city_name))'',0,100));
    maxlength_clean_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_p_city_name)));
    avelength_clean_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_p_city_name)),h.clean_address_p_city_name<>(typeof(h.clean_address_p_city_name))'');
    populated_clean_address_v_city_name_cnt := COUNT(GROUP,h.clean_address_v_city_name <> (TYPEOF(h.clean_address_v_city_name))'');
    populated_clean_address_v_city_name_pcnt := AVE(GROUP,IF(h.clean_address_v_city_name = (TYPEOF(h.clean_address_v_city_name))'',0,100));
    maxlength_clean_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_v_city_name)));
    avelength_clean_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_v_city_name)),h.clean_address_v_city_name<>(typeof(h.clean_address_v_city_name))'');
    populated_clean_address_st_cnt := COUNT(GROUP,h.clean_address_st <> (TYPEOF(h.clean_address_st))'');
    populated_clean_address_st_pcnt := AVE(GROUP,IF(h.clean_address_st = (TYPEOF(h.clean_address_st))'',0,100));
    maxlength_clean_address_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_st)));
    avelength_clean_address_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_st)),h.clean_address_st<>(typeof(h.clean_address_st))'');
    populated_clean_address_zip_cnt := COUNT(GROUP,h.clean_address_zip <> (TYPEOF(h.clean_address_zip))'');
    populated_clean_address_zip_pcnt := AVE(GROUP,IF(h.clean_address_zip = (TYPEOF(h.clean_address_zip))'',0,100));
    maxlength_clean_address_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_zip)));
    avelength_clean_address_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_address_zip)),h.clean_address_zip<>(typeof(h.clean_address_zip))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_process_date_first_seen_pcnt *   0.00 / 100 + T.Populated_process_date_last_seen_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_orig_extract_date_mdy_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_sic_code_pcnt *   0.00 / 100 + T.Populated_business_desc_pcnt *   0.00 / 100 + T.Populated_extract_date_pcnt *   0.00 / 100 + T.Populated_file_estab_date_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_last_line_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_clean_address_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_address_st_pcnt *   0.00 / 100 + T.Populated_clean_address_zip_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','orig_extract_date_mdy','company_name','phone_number','sic_code','business_desc','extract_date','file_estab_date','prep_addr_line1','prep_addr_last_line','source_rec_id','clean_address_prim_name','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_process_date_first_seen_pcnt,le.populated_process_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_process_date_pcnt,le.populated_file_number_pcnt,le.populated_orig_extract_date_mdy_pcnt,le.populated_company_name_pcnt,le.populated_phone_number_pcnt,le.populated_sic_code_pcnt,le.populated_business_desc_pcnt,le.populated_extract_date_pcnt,le.populated_file_estab_date_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_last_line_pcnt,le.populated_source_rec_id_pcnt,le.populated_clean_address_prim_name_pcnt,le.populated_clean_address_p_city_name_pcnt,le.populated_clean_address_v_city_name_pcnt,le.populated_clean_address_st_pcnt,le.populated_clean_address_zip_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_process_date_first_seen,le.maxlength_process_date_last_seen,le.maxlength_record_type,le.maxlength_process_date,le.maxlength_file_number,le.maxlength_orig_extract_date_mdy,le.maxlength_company_name,le.maxlength_phone_number,le.maxlength_sic_code,le.maxlength_business_desc,le.maxlength_extract_date,le.maxlength_file_estab_date,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_last_line,le.maxlength_source_rec_id,le.maxlength_clean_address_prim_name,le.maxlength_clean_address_p_city_name,le.maxlength_clean_address_v_city_name,le.maxlength_clean_address_st,le.maxlength_clean_address_zip);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_process_date_first_seen,le.avelength_process_date_last_seen,le.avelength_record_type,le.avelength_process_date,le.avelength_file_number,le.avelength_orig_extract_date_mdy,le.avelength_company_name,le.avelength_phone_number,le.avelength_sic_code,le.avelength_business_desc,le.avelength_extract_date,le.avelength_file_estab_date,le.avelength_prep_addr_line1,le.avelength_prep_addr_last_line,le.avelength_source_rec_id,le.avelength_clean_address_prim_name,le.avelength_clean_address_p_city_name,le.avelength_clean_address_v_city_name,le.avelength_clean_address_st,le.avelength_clean_address_zip);
END;
EXPORT invSummary := NORMALIZE(summary0, 28, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.orig_extract_date_mdy),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.business_desc),TRIM((SALT311.StrType)le.extract_date),TRIM((SALT311.StrType)le.file_estab_date),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_last_line),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,28,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 28);
  SELF.FldNo2 := 1 + (C % 28);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.orig_extract_date_mdy),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.business_desc),TRIM((SALT311.StrType)le.extract_date),TRIM((SALT311.StrType)le.file_estab_date),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_last_line),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.orig_extract_date_mdy),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.sic_code),TRIM((SALT311.StrType)le.business_desc),TRIM((SALT311.StrType)le.extract_date),TRIM((SALT311.StrType)le.file_estab_date),TRIM((SALT311.StrType)le.prep_addr_line1),TRIM((SALT311.StrType)le.prep_addr_last_line),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),TRIM((SALT311.StrType)le.clean_address_prim_name),TRIM((SALT311.StrType)le.clean_address_p_city_name),TRIM((SALT311.StrType)le.clean_address_v_city_name),TRIM((SALT311.StrType)le.clean_address_st),TRIM((SALT311.StrType)le.clean_address_zip)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),28*28,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{14,'orig_extract_date_mdy'}
      ,{15,'company_name'}
      ,{16,'phone_number'}
      ,{17,'sic_code'}
      ,{18,'business_desc'}
      ,{19,'extract_date'}
      ,{20,'file_estab_date'}
      ,{21,'prep_addr_line1'}
      ,{22,'prep_addr_last_line'}
      ,{23,'source_rec_id'}
      ,{24,'clean_address_prim_name'}
      ,{25,'clean_address_p_city_name'}
      ,{26,'clean_address_v_city_name'}
      ,{27,'clean_address_st'}
      ,{28,'clean_address_zip'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_0010_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_0010_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_0010_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_0010_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_0010_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_0010_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_0010_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Base_0010_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Base_0010_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen),
    Base_0010_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen),
    Base_0010_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_0010_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_0010_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Base_0010_Fields.InValid_orig_extract_date_mdy((SALT311.StrType)le.orig_extract_date_mdy),
    Base_0010_Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Base_0010_Fields.InValid_phone_number((SALT311.StrType)le.phone_number),
    Base_0010_Fields.InValid_sic_code((SALT311.StrType)le.sic_code),
    Base_0010_Fields.InValid_business_desc((SALT311.StrType)le.business_desc),
    Base_0010_Fields.InValid_extract_date((SALT311.StrType)le.extract_date),
    Base_0010_Fields.InValid_file_estab_date((SALT311.StrType)le.file_estab_date),
    Base_0010_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1),
    Base_0010_Fields.InValid_prep_addr_last_line((SALT311.StrType)le.prep_addr_last_line),
    Base_0010_Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id),
    Base_0010_Fields.InValid_clean_address_prim_name((SALT311.StrType)le.clean_address_prim_name),
    Base_0010_Fields.InValid_clean_address_p_city_name((SALT311.StrType)le.clean_address_p_city_name),
    Base_0010_Fields.InValid_clean_address_v_city_name((SALT311.StrType)le.clean_address_v_city_name),
    Base_0010_Fields.InValid_clean_address_st((SALT311.StrType)le.clean_address_st),
    Base_0010_Fields.InValid_clean_address_zip((SALT311.StrType)le.clean_address_zip),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,28,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_0010_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_bdid','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_pastdate_slashes','invalid_mandatory','invalid_phone','invalid_sic','invalid_mandatory','invalid_pastdate','invalid_ccyymm','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_0010_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_process_date_first_seen(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_process_date_last_seen(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_orig_extract_date_mdy(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_sic_code(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_business_desc(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_extract_date(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_file_estab_date(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_prep_addr_last_line(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_clean_address_prim_name(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_clean_address_p_city_name(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_clean_address_v_city_name(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_clean_address_st(TotalErrors.ErrorNum),Base_0010_Fields.InValidMessage_clean_address_zip(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_0010_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
