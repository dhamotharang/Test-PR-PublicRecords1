IMPORT SALT311,STD;
EXPORT Base_5600_hygiene(dataset(Base_5600_layout_EBR) h) := MODULE
 
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
    populated_sic_1_code_cnt := COUNT(GROUP,h.sic_1_code <> (TYPEOF(h.sic_1_code))'');
    populated_sic_1_code_pcnt := AVE(GROUP,IF(h.sic_1_code = (TYPEOF(h.sic_1_code))'',0,100));
    maxlength_sic_1_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_1_code)));
    avelength_sic_1_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_1_code)),h.sic_1_code<>(typeof(h.sic_1_code))'');
    populated_sic_1_desc_cnt := COUNT(GROUP,h.sic_1_desc <> (TYPEOF(h.sic_1_desc))'');
    populated_sic_1_desc_pcnt := AVE(GROUP,IF(h.sic_1_desc = (TYPEOF(h.sic_1_desc))'',0,100));
    maxlength_sic_1_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_1_desc)));
    avelength_sic_1_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_1_desc)),h.sic_1_desc<>(typeof(h.sic_1_desc))'');
    populated_sic_2_code_cnt := COUNT(GROUP,h.sic_2_code <> (TYPEOF(h.sic_2_code))'');
    populated_sic_2_code_pcnt := AVE(GROUP,IF(h.sic_2_code = (TYPEOF(h.sic_2_code))'',0,100));
    maxlength_sic_2_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_2_code)));
    avelength_sic_2_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_2_code)),h.sic_2_code<>(typeof(h.sic_2_code))'');
    populated_sic_2_desc_cnt := COUNT(GROUP,h.sic_2_desc <> (TYPEOF(h.sic_2_desc))'');
    populated_sic_2_desc_pcnt := AVE(GROUP,IF(h.sic_2_desc = (TYPEOF(h.sic_2_desc))'',0,100));
    maxlength_sic_2_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_2_desc)));
    avelength_sic_2_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_2_desc)),h.sic_2_desc<>(typeof(h.sic_2_desc))'');
    populated_sic_3_code_cnt := COUNT(GROUP,h.sic_3_code <> (TYPEOF(h.sic_3_code))'');
    populated_sic_3_code_pcnt := AVE(GROUP,IF(h.sic_3_code = (TYPEOF(h.sic_3_code))'',0,100));
    maxlength_sic_3_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_3_code)));
    avelength_sic_3_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_3_code)),h.sic_3_code<>(typeof(h.sic_3_code))'');
    populated_sic_3_desc_cnt := COUNT(GROUP,h.sic_3_desc <> (TYPEOF(h.sic_3_desc))'');
    populated_sic_3_desc_pcnt := AVE(GROUP,IF(h.sic_3_desc = (TYPEOF(h.sic_3_desc))'',0,100));
    maxlength_sic_3_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_3_desc)));
    avelength_sic_3_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_3_desc)),h.sic_3_desc<>(typeof(h.sic_3_desc))'');
    populated_sic_4_code_cnt := COUNT(GROUP,h.sic_4_code <> (TYPEOF(h.sic_4_code))'');
    populated_sic_4_code_pcnt := AVE(GROUP,IF(h.sic_4_code = (TYPEOF(h.sic_4_code))'',0,100));
    maxlength_sic_4_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_4_code)));
    avelength_sic_4_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_4_code)),h.sic_4_code<>(typeof(h.sic_4_code))'');
    populated_sic_4_desc_cnt := COUNT(GROUP,h.sic_4_desc <> (TYPEOF(h.sic_4_desc))'');
    populated_sic_4_desc_pcnt := AVE(GROUP,IF(h.sic_4_desc = (TYPEOF(h.sic_4_desc))'',0,100));
    maxlength_sic_4_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_4_desc)));
    avelength_sic_4_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_4_desc)),h.sic_4_desc<>(typeof(h.sic_4_desc))'');
    populated_yrs_in_bus_actual_cnt := COUNT(GROUP,h.yrs_in_bus_actual <> (TYPEOF(h.yrs_in_bus_actual))'');
    populated_yrs_in_bus_actual_pcnt := AVE(GROUP,IF(h.yrs_in_bus_actual = (TYPEOF(h.yrs_in_bus_actual))'',0,100));
    maxlength_yrs_in_bus_actual := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.yrs_in_bus_actual)));
    avelength_yrs_in_bus_actual := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.yrs_in_bus_actual)),h.yrs_in_bus_actual<>(typeof(h.yrs_in_bus_actual))'');
    populated_sales_actual_cnt := COUNT(GROUP,h.sales_actual <> (TYPEOF(h.sales_actual))'');
    populated_sales_actual_pcnt := AVE(GROUP,IF(h.sales_actual = (TYPEOF(h.sales_actual))'',0,100));
    maxlength_sales_actual := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_actual)));
    avelength_sales_actual := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sales_actual)),h.sales_actual<>(typeof(h.sales_actual))'');
    populated_empl_size_actual_cnt := COUNT(GROUP,h.empl_size_actual <> (TYPEOF(h.empl_size_actual))'');
    populated_empl_size_actual_pcnt := AVE(GROUP,IF(h.empl_size_actual = (TYPEOF(h.empl_size_actual))'',0,100));
    maxlength_empl_size_actual := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empl_size_actual)));
    avelength_empl_size_actual := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empl_size_actual)),h.empl_size_actual<>(typeof(h.empl_size_actual))'');
    populated_bus_type_code_cnt := COUNT(GROUP,h.bus_type_code <> (TYPEOF(h.bus_type_code))'');
    populated_bus_type_code_pcnt := AVE(GROUP,IF(h.bus_type_code = (TYPEOF(h.bus_type_code))'',0,100));
    maxlength_bus_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_type_code)));
    avelength_bus_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_type_code)),h.bus_type_code<>(typeof(h.bus_type_code))'');
    populated_bus_type_desc_cnt := COUNT(GROUP,h.bus_type_desc <> (TYPEOF(h.bus_type_desc))'');
    populated_bus_type_desc_pcnt := AVE(GROUP,IF(h.bus_type_desc = (TYPEOF(h.bus_type_desc))'',0,100));
    maxlength_bus_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_type_desc)));
    avelength_bus_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bus_type_desc)),h.bus_type_desc<>(typeof(h.bus_type_desc))'');
    populated_owner_type_code_cnt := COUNT(GROUP,h.owner_type_code <> (TYPEOF(h.owner_type_code))'');
    populated_owner_type_code_pcnt := AVE(GROUP,IF(h.owner_type_code = (TYPEOF(h.owner_type_code))'',0,100));
    maxlength_owner_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_type_code)));
    avelength_owner_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_type_code)),h.owner_type_code<>(typeof(h.owner_type_code))'');
    populated_owner_type_desc_cnt := COUNT(GROUP,h.owner_type_desc <> (TYPEOF(h.owner_type_desc))'');
    populated_owner_type_desc_pcnt := AVE(GROUP,IF(h.owner_type_desc = (TYPEOF(h.owner_type_desc))'',0,100));
    maxlength_owner_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_type_desc)));
    avelength_owner_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_type_desc)),h.owner_type_desc<>(typeof(h.owner_type_desc))'');
    populated_location_code_cnt := COUNT(GROUP,h.location_code <> (TYPEOF(h.location_code))'');
    populated_location_code_pcnt := AVE(GROUP,IF(h.location_code = (TYPEOF(h.location_code))'',0,100));
    maxlength_location_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_code)));
    avelength_location_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_code)),h.location_code<>(typeof(h.location_code))'');
    populated_location_desc_cnt := COUNT(GROUP,h.location_desc <> (TYPEOF(h.location_desc))'');
    populated_location_desc_pcnt := AVE(GROUP,IF(h.location_desc = (TYPEOF(h.location_desc))'',0,100));
    maxlength_location_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_desc)));
    avelength_location_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_desc)),h.location_desc<>(typeof(h.location_desc))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_process_date_first_seen_pcnt *   0.00 / 100 + T.Populated_process_date_last_seen_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_segment_code_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_sic_1_code_pcnt *   0.00 / 100 + T.Populated_sic_1_desc_pcnt *   0.00 / 100 + T.Populated_sic_2_code_pcnt *   0.00 / 100 + T.Populated_sic_2_desc_pcnt *   0.00 / 100 + T.Populated_sic_3_code_pcnt *   0.00 / 100 + T.Populated_sic_3_desc_pcnt *   0.00 / 100 + T.Populated_sic_4_code_pcnt *   0.00 / 100 + T.Populated_sic_4_desc_pcnt *   0.00 / 100 + T.Populated_yrs_in_bus_actual_pcnt *   0.00 / 100 + T.Populated_sales_actual_pcnt *   0.00 / 100 + T.Populated_empl_size_actual_pcnt *   0.00 / 100 + T.Populated_bus_type_code_pcnt *   0.00 / 100 + T.Populated_bus_type_desc_pcnt *   0.00 / 100 + T.Populated_owner_type_code_pcnt *   0.00 / 100 + T.Populated_owner_type_desc_pcnt *   0.00 / 100 + T.Populated_location_code_pcnt *   0.00 / 100 + T.Populated_location_desc_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','sic_1_code','sic_1_desc','sic_2_code','sic_2_desc','sic_3_code','sic_3_desc','sic_4_code','sic_4_desc','yrs_in_bus_actual','sales_actual','empl_size_actual','bus_type_code','bus_type_desc','owner_type_code','owner_type_desc','location_code','location_desc');
  SELF.populated_pcnt := CHOOSE(C,le.populated_powid_pcnt,le.populated_proxid_pcnt,le.populated_seleid_pcnt,le.populated_orgid_pcnt,le.populated_ultid_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_process_date_first_seen_pcnt,le.populated_process_date_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_process_date_pcnt,le.populated_file_number_pcnt,le.populated_segment_code_pcnt,le.populated_sequence_number_pcnt,le.populated_sic_1_code_pcnt,le.populated_sic_1_desc_pcnt,le.populated_sic_2_code_pcnt,le.populated_sic_2_desc_pcnt,le.populated_sic_3_code_pcnt,le.populated_sic_3_desc_pcnt,le.populated_sic_4_code_pcnt,le.populated_sic_4_desc_pcnt,le.populated_yrs_in_bus_actual_pcnt,le.populated_sales_actual_pcnt,le.populated_empl_size_actual_pcnt,le.populated_bus_type_code_pcnt,le.populated_bus_type_desc_pcnt,le.populated_owner_type_code_pcnt,le.populated_owner_type_desc_pcnt,le.populated_location_code_pcnt,le.populated_location_desc_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_powid,le.maxlength_proxid,le.maxlength_seleid,le.maxlength_orgid,le.maxlength_ultid,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_process_date_first_seen,le.maxlength_process_date_last_seen,le.maxlength_record_type,le.maxlength_process_date,le.maxlength_file_number,le.maxlength_segment_code,le.maxlength_sequence_number,le.maxlength_sic_1_code,le.maxlength_sic_1_desc,le.maxlength_sic_2_code,le.maxlength_sic_2_desc,le.maxlength_sic_3_code,le.maxlength_sic_3_desc,le.maxlength_sic_4_code,le.maxlength_sic_4_desc,le.maxlength_yrs_in_bus_actual,le.maxlength_sales_actual,le.maxlength_empl_size_actual,le.maxlength_bus_type_code,le.maxlength_bus_type_desc,le.maxlength_owner_type_code,le.maxlength_owner_type_desc,le.maxlength_location_code,le.maxlength_location_desc);
  SELF.avelength := CHOOSE(C,le.avelength_powid,le.avelength_proxid,le.avelength_seleid,le.avelength_orgid,le.avelength_ultid,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_process_date_first_seen,le.avelength_process_date_last_seen,le.avelength_record_type,le.avelength_process_date,le.avelength_file_number,le.avelength_segment_code,le.avelength_sequence_number,le.avelength_sic_1_code,le.avelength_sic_1_desc,le.avelength_sic_2_code,le.avelength_sic_2_desc,le.avelength_sic_3_code,le.avelength_sic_3_desc,le.avelength_sic_4_code,le.avelength_sic_4_desc,le.avelength_yrs_in_bus_actual,le.avelength_sales_actual,le.avelength_empl_size_actual,le.avelength_bus_type_code,le.avelength_bus_type_desc,le.avelength_owner_type_code,le.avelength_owner_type_desc,le.avelength_location_code,le.avelength_location_desc);
END;
EXPORT invSummary := NORMALIZE(summary0, 32, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.sic_1_code),TRIM((SALT311.StrType)le.sic_1_desc),TRIM((SALT311.StrType)le.sic_2_code),TRIM((SALT311.StrType)le.sic_2_desc),TRIM((SALT311.StrType)le.sic_3_code),TRIM((SALT311.StrType)le.sic_3_desc),TRIM((SALT311.StrType)le.sic_4_code),TRIM((SALT311.StrType)le.sic_4_desc),TRIM((SALT311.StrType)le.yrs_in_bus_actual),TRIM((SALT311.StrType)le.sales_actual),TRIM((SALT311.StrType)le.empl_size_actual),TRIM((SALT311.StrType)le.bus_type_code),TRIM((SALT311.StrType)le.bus_type_desc),TRIM((SALT311.StrType)le.owner_type_code),TRIM((SALT311.StrType)le.owner_type_desc),TRIM((SALT311.StrType)le.location_code),TRIM((SALT311.StrType)le.location_desc)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,32,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 32);
  SELF.FldNo2 := 1 + (C % 32);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.sic_1_code),TRIM((SALT311.StrType)le.sic_1_desc),TRIM((SALT311.StrType)le.sic_2_code),TRIM((SALT311.StrType)le.sic_2_desc),TRIM((SALT311.StrType)le.sic_3_code),TRIM((SALT311.StrType)le.sic_3_desc),TRIM((SALT311.StrType)le.sic_4_code),TRIM((SALT311.StrType)le.sic_4_desc),TRIM((SALT311.StrType)le.yrs_in_bus_actual),TRIM((SALT311.StrType)le.sales_actual),TRIM((SALT311.StrType)le.empl_size_actual),TRIM((SALT311.StrType)le.bus_type_code),TRIM((SALT311.StrType)le.bus_type_desc),TRIM((SALT311.StrType)le.owner_type_code),TRIM((SALT311.StrType)le.owner_type_desc),TRIM((SALT311.StrType)le.location_code),TRIM((SALT311.StrType)le.location_desc)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),IF (le.process_date_first_seen <> 0,TRIM((SALT311.StrType)le.process_date_first_seen), ''),IF (le.process_date_last_seen <> 0,TRIM((SALT311.StrType)le.process_date_last_seen), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.file_number),TRIM((SALT311.StrType)le.segment_code),TRIM((SALT311.StrType)le.sequence_number),TRIM((SALT311.StrType)le.sic_1_code),TRIM((SALT311.StrType)le.sic_1_desc),TRIM((SALT311.StrType)le.sic_2_code),TRIM((SALT311.StrType)le.sic_2_desc),TRIM((SALT311.StrType)le.sic_3_code),TRIM((SALT311.StrType)le.sic_3_desc),TRIM((SALT311.StrType)le.sic_4_code),TRIM((SALT311.StrType)le.sic_4_desc),TRIM((SALT311.StrType)le.yrs_in_bus_actual),TRIM((SALT311.StrType)le.sales_actual),TRIM((SALT311.StrType)le.empl_size_actual),TRIM((SALT311.StrType)le.bus_type_code),TRIM((SALT311.StrType)le.bus_type_desc),TRIM((SALT311.StrType)le.owner_type_code),TRIM((SALT311.StrType)le.owner_type_desc),TRIM((SALT311.StrType)le.location_code),TRIM((SALT311.StrType)le.location_desc)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),32*32,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
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
      ,{16,'sic_1_code'}
      ,{17,'sic_1_desc'}
      ,{18,'sic_2_code'}
      ,{19,'sic_2_desc'}
      ,{20,'sic_3_code'}
      ,{21,'sic_3_desc'}
      ,{22,'sic_4_code'}
      ,{23,'sic_4_desc'}
      ,{24,'yrs_in_bus_actual'}
      ,{25,'sales_actual'}
      ,{26,'empl_size_actual'}
      ,{27,'bus_type_code'}
      ,{28,'bus_type_desc'}
      ,{29,'owner_type_code'}
      ,{30,'owner_type_desc'}
      ,{31,'location_code'}
      ,{32,'location_desc'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_5600_Fields.InValid_powid((SALT311.StrType)le.powid),
    Base_5600_Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Base_5600_Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Base_5600_Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Base_5600_Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Base_5600_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_5600_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Base_5600_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Base_5600_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen),
    Base_5600_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen),
    Base_5600_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_5600_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_5600_Fields.InValid_file_number((SALT311.StrType)le.file_number),
    Base_5600_Fields.InValid_segment_code((SALT311.StrType)le.segment_code),
    Base_5600_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    Base_5600_Fields.InValid_sic_1_code((SALT311.StrType)le.sic_1_code),
    Base_5600_Fields.InValid_sic_1_desc((SALT311.StrType)le.sic_1_desc),
    Base_5600_Fields.InValid_sic_2_code((SALT311.StrType)le.sic_2_code),
    Base_5600_Fields.InValid_sic_2_desc((SALT311.StrType)le.sic_2_desc),
    Base_5600_Fields.InValid_sic_3_code((SALT311.StrType)le.sic_3_code),
    Base_5600_Fields.InValid_sic_3_desc((SALT311.StrType)le.sic_3_desc),
    Base_5600_Fields.InValid_sic_4_code((SALT311.StrType)le.sic_4_code),
    Base_5600_Fields.InValid_sic_4_desc((SALT311.StrType)le.sic_4_desc),
    Base_5600_Fields.InValid_yrs_in_bus_actual((SALT311.StrType)le.yrs_in_bus_actual),
    Base_5600_Fields.InValid_sales_actual((SALT311.StrType)le.sales_actual),
    Base_5600_Fields.InValid_empl_size_actual((SALT311.StrType)le.empl_size_actual),
    Base_5600_Fields.InValid_bus_type_code((SALT311.StrType)le.bus_type_code),
    Base_5600_Fields.InValid_bus_type_desc((SALT311.StrType)le.bus_type_desc),
    Base_5600_Fields.InValid_owner_type_code((SALT311.StrType)le.owner_type_code),
    Base_5600_Fields.InValid_owner_type_desc((SALT311.StrType)le.owner_type_desc),
    Base_5600_Fields.InValid_location_code((SALT311.StrType)le.location_code),
    Base_5600_Fields.InValid_location_desc((SALT311.StrType)le.location_desc),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,32,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_5600_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_sic_code','invalid_mandatory','invalid_sic_code','invalid_mandatory','invalid_sic_code','invalid_mandatory','invalid_sic_code','invalid_mandatory','invalid_numeric','invalid_sales','invalid_numeric_or_allzeros','invalid_bustyp_code','invalid_bustyp_desc','invalid_ownertyp_code','invalid_ownertyp_desc','invalid_location_code','invalid_location_desc');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_5600_Fields.InValidMessage_powid(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_process_date_first_seen(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_process_date_last_seen(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_segment_code(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_sic_1_code(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_sic_1_desc(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_sic_2_code(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_sic_2_desc(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_sic_3_code(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_sic_3_desc(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_sic_4_code(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_sic_4_desc(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_yrs_in_bus_actual(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_sales_actual(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_empl_size_actual(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_bus_type_code(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_bus_type_desc(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_owner_type_code(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_owner_type_desc(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_location_code(TotalErrors.ErrorNum),Base_5600_Fields.InValidMessage_location_desc(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_EBR, Base_5600_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
