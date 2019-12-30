IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_CFPB) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
    populated_global_src_id_cnt := COUNT(GROUP,h.global_src_id <> (TYPEOF(h.global_src_id))'');
    populated_global_src_id_pcnt := AVE(GROUP,IF(h.global_src_id = (TYPEOF(h.global_src_id))'',0,100));
    maxlength_global_src_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_src_id)));
    avelength_global_src_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_src_id)),h.global_src_id<>(typeof(h.global_src_id))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_is_latest_cnt := COUNT(GROUP,h.is_latest <> (TYPEOF(h.is_latest))'');
    populated_is_latest_pcnt := AVE(GROUP,IF(h.is_latest = (TYPEOF(h.is_latest))'',0,100));
    maxlength_is_latest := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_latest)));
    avelength_is_latest := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_latest)),h.is_latest<>(typeof(h.is_latest))'');
    populated_seqno_cnt := COUNT(GROUP,h.seqno <> (TYPEOF(h.seqno))'');
    populated_seqno_pcnt := AVE(GROUP,IF(h.seqno = (TYPEOF(h.seqno))'',0,100));
    maxlength_seqno := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seqno)));
    avelength_seqno := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seqno)),h.seqno<>(typeof(h.seqno))'');
    populated_geoid10_blkgrp_cnt := COUNT(GROUP,h.geoid10_blkgrp <> (TYPEOF(h.geoid10_blkgrp))'');
    populated_geoid10_blkgrp_pcnt := AVE(GROUP,IF(h.geoid10_blkgrp = (TYPEOF(h.geoid10_blkgrp))'',0,100));
    maxlength_geoid10_blkgrp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geoid10_blkgrp)));
    avelength_geoid10_blkgrp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geoid10_blkgrp)),h.geoid10_blkgrp<>(typeof(h.geoid10_blkgrp))'');
    populated_state_fips10_cnt := COUNT(GROUP,h.state_fips10 <> (TYPEOF(h.state_fips10))'');
    populated_state_fips10_pcnt := AVE(GROUP,IF(h.state_fips10 = (TYPEOF(h.state_fips10))'',0,100));
    maxlength_state_fips10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_fips10)));
    avelength_state_fips10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_fips10)),h.state_fips10<>(typeof(h.state_fips10))'');
    populated_county_fips10_cnt := COUNT(GROUP,h.county_fips10 <> (TYPEOF(h.county_fips10))'');
    populated_county_fips10_pcnt := AVE(GROUP,IF(h.county_fips10 = (TYPEOF(h.county_fips10))'',0,100));
    maxlength_county_fips10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_fips10)));
    avelength_county_fips10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_fips10)),h.county_fips10<>(typeof(h.county_fips10))'');
    populated_tract_fips10_cnt := COUNT(GROUP,h.tract_fips10 <> (TYPEOF(h.tract_fips10))'');
    populated_tract_fips10_pcnt := AVE(GROUP,IF(h.tract_fips10 = (TYPEOF(h.tract_fips10))'',0,100));
    maxlength_tract_fips10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tract_fips10)));
    avelength_tract_fips10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tract_fips10)),h.tract_fips10<>(typeof(h.tract_fips10))'');
    populated_blkgrp_fips10_cnt := COUNT(GROUP,h.blkgrp_fips10 <> (TYPEOF(h.blkgrp_fips10))'');
    populated_blkgrp_fips10_pcnt := AVE(GROUP,IF(h.blkgrp_fips10 = (TYPEOF(h.blkgrp_fips10))'',0,100));
    maxlength_blkgrp_fips10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.blkgrp_fips10)));
    avelength_blkgrp_fips10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.blkgrp_fips10)),h.blkgrp_fips10<>(typeof(h.blkgrp_fips10))'');
    populated_total_pop_cnt := COUNT(GROUP,h.total_pop <> (TYPEOF(h.total_pop))'');
    populated_total_pop_pcnt := AVE(GROUP,IF(h.total_pop = (TYPEOF(h.total_pop))'',0,100));
    maxlength_total_pop := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_pop)));
    avelength_total_pop := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_pop)),h.total_pop<>(typeof(h.total_pop))'');
    populated_hispanic_total_cnt := COUNT(GROUP,h.hispanic_total <> (TYPEOF(h.hispanic_total))'');
    populated_hispanic_total_pcnt := AVE(GROUP,IF(h.hispanic_total = (TYPEOF(h.hispanic_total))'',0,100));
    maxlength_hispanic_total := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hispanic_total)));
    avelength_hispanic_total := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hispanic_total)),h.hispanic_total<>(typeof(h.hispanic_total))'');
    populated_non_hispanic_total_cnt := COUNT(GROUP,h.non_hispanic_total <> (TYPEOF(h.non_hispanic_total))'');
    populated_non_hispanic_total_pcnt := AVE(GROUP,IF(h.non_hispanic_total = (TYPEOF(h.non_hispanic_total))'',0,100));
    maxlength_non_hispanic_total := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.non_hispanic_total)));
    avelength_non_hispanic_total := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.non_hispanic_total)),h.non_hispanic_total<>(typeof(h.non_hispanic_total))'');
    populated_nh_white_alone_cnt := COUNT(GROUP,h.nh_white_alone <> (TYPEOF(h.nh_white_alone))'');
    populated_nh_white_alone_pcnt := AVE(GROUP,IF(h.nh_white_alone = (TYPEOF(h.nh_white_alone))'',0,100));
    maxlength_nh_white_alone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_white_alone)));
    avelength_nh_white_alone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_white_alone)),h.nh_white_alone<>(typeof(h.nh_white_alone))'');
    populated_nh_black_alone_cnt := COUNT(GROUP,h.nh_black_alone <> (TYPEOF(h.nh_black_alone))'');
    populated_nh_black_alone_pcnt := AVE(GROUP,IF(h.nh_black_alone = (TYPEOF(h.nh_black_alone))'',0,100));
    maxlength_nh_black_alone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_black_alone)));
    avelength_nh_black_alone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_black_alone)),h.nh_black_alone<>(typeof(h.nh_black_alone))'');
    populated_nh_aian_alone_cnt := COUNT(GROUP,h.nh_aian_alone <> (TYPEOF(h.nh_aian_alone))'');
    populated_nh_aian_alone_pcnt := AVE(GROUP,IF(h.nh_aian_alone = (TYPEOF(h.nh_aian_alone))'',0,100));
    maxlength_nh_aian_alone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_aian_alone)));
    avelength_nh_aian_alone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_aian_alone)),h.nh_aian_alone<>(typeof(h.nh_aian_alone))'');
    populated_nh_api_alone_cnt := COUNT(GROUP,h.nh_api_alone <> (TYPEOF(h.nh_api_alone))'');
    populated_nh_api_alone_pcnt := AVE(GROUP,IF(h.nh_api_alone = (TYPEOF(h.nh_api_alone))'',0,100));
    maxlength_nh_api_alone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_api_alone)));
    avelength_nh_api_alone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_api_alone)),h.nh_api_alone<>(typeof(h.nh_api_alone))'');
    populated_nh_other_alone_cnt := COUNT(GROUP,h.nh_other_alone <> (TYPEOF(h.nh_other_alone))'');
    populated_nh_other_alone_pcnt := AVE(GROUP,IF(h.nh_other_alone = (TYPEOF(h.nh_other_alone))'',0,100));
    maxlength_nh_other_alone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_other_alone)));
    avelength_nh_other_alone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_other_alone)),h.nh_other_alone<>(typeof(h.nh_other_alone))'');
    populated_nh_mult_total_cnt := COUNT(GROUP,h.nh_mult_total <> (TYPEOF(h.nh_mult_total))'');
    populated_nh_mult_total_pcnt := AVE(GROUP,IF(h.nh_mult_total = (TYPEOF(h.nh_mult_total))'',0,100));
    maxlength_nh_mult_total := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_mult_total)));
    avelength_nh_mult_total := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_mult_total)),h.nh_mult_total<>(typeof(h.nh_mult_total))'');
    populated_nh_white_other_cnt := COUNT(GROUP,h.nh_white_other <> (TYPEOF(h.nh_white_other))'');
    populated_nh_white_other_pcnt := AVE(GROUP,IF(h.nh_white_other = (TYPEOF(h.nh_white_other))'',0,100));
    maxlength_nh_white_other := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_white_other)));
    avelength_nh_white_other := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_white_other)),h.nh_white_other<>(typeof(h.nh_white_other))'');
    populated_nh_black_other_cnt := COUNT(GROUP,h.nh_black_other <> (TYPEOF(h.nh_black_other))'');
    populated_nh_black_other_pcnt := AVE(GROUP,IF(h.nh_black_other = (TYPEOF(h.nh_black_other))'',0,100));
    maxlength_nh_black_other := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_black_other)));
    avelength_nh_black_other := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_black_other)),h.nh_black_other<>(typeof(h.nh_black_other))'');
    populated_nh_aian_other_cnt := COUNT(GROUP,h.nh_aian_other <> (TYPEOF(h.nh_aian_other))'');
    populated_nh_aian_other_pcnt := AVE(GROUP,IF(h.nh_aian_other = (TYPEOF(h.nh_aian_other))'',0,100));
    maxlength_nh_aian_other := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_aian_other)));
    avelength_nh_aian_other := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_aian_other)),h.nh_aian_other<>(typeof(h.nh_aian_other))'');
    populated_nh_asian_hpi_cnt := COUNT(GROUP,h.nh_asian_hpi <> (TYPEOF(h.nh_asian_hpi))'');
    populated_nh_asian_hpi_pcnt := AVE(GROUP,IF(h.nh_asian_hpi = (TYPEOF(h.nh_asian_hpi))'',0,100));
    maxlength_nh_asian_hpi := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_asian_hpi)));
    avelength_nh_asian_hpi := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_asian_hpi)),h.nh_asian_hpi<>(typeof(h.nh_asian_hpi))'');
    populated_nh_api_other_cnt := COUNT(GROUP,h.nh_api_other <> (TYPEOF(h.nh_api_other))'');
    populated_nh_api_other_pcnt := AVE(GROUP,IF(h.nh_api_other = (TYPEOF(h.nh_api_other))'',0,100));
    maxlength_nh_api_other := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_api_other)));
    avelength_nh_api_other := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_api_other)),h.nh_api_other<>(typeof(h.nh_api_other))'');
    populated_nh_asian_hpi_other_cnt := COUNT(GROUP,h.nh_asian_hpi_other <> (TYPEOF(h.nh_asian_hpi_other))'');
    populated_nh_asian_hpi_other_pcnt := AVE(GROUP,IF(h.nh_asian_hpi_other = (TYPEOF(h.nh_asian_hpi_other))'',0,100));
    maxlength_nh_asian_hpi_other := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_asian_hpi_other)));
    avelength_nh_asian_hpi_other := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nh_asian_hpi_other)),h.nh_asian_hpi_other<>(typeof(h.nh_asian_hpi_other))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_record_sid_pcnt *   0.00 / 100 + T.Populated_global_src_id_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_is_latest_pcnt *   0.00 / 100 + T.Populated_seqno_pcnt *   0.00 / 100 + T.Populated_geoid10_blkgrp_pcnt *   0.00 / 100 + T.Populated_state_fips10_pcnt *   0.00 / 100 + T.Populated_county_fips10_pcnt *   0.00 / 100 + T.Populated_tract_fips10_pcnt *   0.00 / 100 + T.Populated_blkgrp_fips10_pcnt *   0.00 / 100 + T.Populated_total_pop_pcnt *   0.00 / 100 + T.Populated_hispanic_total_pcnt *   0.00 / 100 + T.Populated_non_hispanic_total_pcnt *   0.00 / 100 + T.Populated_nh_white_alone_pcnt *   0.00 / 100 + T.Populated_nh_black_alone_pcnt *   0.00 / 100 + T.Populated_nh_aian_alone_pcnt *   0.00 / 100 + T.Populated_nh_api_alone_pcnt *   0.00 / 100 + T.Populated_nh_other_alone_pcnt *   0.00 / 100 + T.Populated_nh_mult_total_pcnt *   0.00 / 100 + T.Populated_nh_white_other_pcnt *   0.00 / 100 + T.Populated_nh_black_other_pcnt *   0.00 / 100 + T.Populated_nh_aian_other_pcnt *   0.00 / 100 + T.Populated_nh_asian_hpi_pcnt *   0.00 / 100 + T.Populated_nh_api_other_pcnt *   0.00 / 100 + T.Populated_nh_asian_hpi_other_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'record_sid','global_src_id','dt_vendor_first_reported','dt_vendor_last_reported','is_latest','seqno','geoid10_blkgrp','state_fips10','county_fips10','tract_fips10','blkgrp_fips10','total_pop','hispanic_total','non_hispanic_total','nh_white_alone','nh_black_alone','nh_aian_alone','nh_api_alone','nh_other_alone','nh_mult_total','nh_white_other','nh_black_other','nh_aian_other','nh_asian_hpi','nh_api_other','nh_asian_hpi_other');
  SELF.populated_pcnt := CHOOSE(C,le.populated_record_sid_pcnt,le.populated_global_src_id_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_is_latest_pcnt,le.populated_seqno_pcnt,le.populated_geoid10_blkgrp_pcnt,le.populated_state_fips10_pcnt,le.populated_county_fips10_pcnt,le.populated_tract_fips10_pcnt,le.populated_blkgrp_fips10_pcnt,le.populated_total_pop_pcnt,le.populated_hispanic_total_pcnt,le.populated_non_hispanic_total_pcnt,le.populated_nh_white_alone_pcnt,le.populated_nh_black_alone_pcnt,le.populated_nh_aian_alone_pcnt,le.populated_nh_api_alone_pcnt,le.populated_nh_other_alone_pcnt,le.populated_nh_mult_total_pcnt,le.populated_nh_white_other_pcnt,le.populated_nh_black_other_pcnt,le.populated_nh_aian_other_pcnt,le.populated_nh_asian_hpi_pcnt,le.populated_nh_api_other_pcnt,le.populated_nh_asian_hpi_other_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_record_sid,le.maxlength_global_src_id,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_is_latest,le.maxlength_seqno,le.maxlength_geoid10_blkgrp,le.maxlength_state_fips10,le.maxlength_county_fips10,le.maxlength_tract_fips10,le.maxlength_blkgrp_fips10,le.maxlength_total_pop,le.maxlength_hispanic_total,le.maxlength_non_hispanic_total,le.maxlength_nh_white_alone,le.maxlength_nh_black_alone,le.maxlength_nh_aian_alone,le.maxlength_nh_api_alone,le.maxlength_nh_other_alone,le.maxlength_nh_mult_total,le.maxlength_nh_white_other,le.maxlength_nh_black_other,le.maxlength_nh_aian_other,le.maxlength_nh_asian_hpi,le.maxlength_nh_api_other,le.maxlength_nh_asian_hpi_other);
  SELF.avelength := CHOOSE(C,le.avelength_record_sid,le.avelength_global_src_id,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_is_latest,le.avelength_seqno,le.avelength_geoid10_blkgrp,le.avelength_state_fips10,le.avelength_county_fips10,le.avelength_tract_fips10,le.avelength_blkgrp_fips10,le.avelength_total_pop,le.avelength_hispanic_total,le.avelength_non_hispanic_total,le.avelength_nh_white_alone,le.avelength_nh_black_alone,le.avelength_nh_aian_alone,le.avelength_nh_api_alone,le.avelength_nh_other_alone,le.avelength_nh_mult_total,le.avelength_nh_white_other,le.avelength_nh_black_other,le.avelength_nh_aian_other,le.avelength_nh_asian_hpi,le.avelength_nh_api_other,le.avelength_nh_asian_hpi_other);
END;
EXPORT invSummary := NORMALIZE(summary0, 26, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),IF (le.global_src_id <> 0,TRIM((SALT311.StrType)le.global_src_id), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.is_latest),IF (le.seqno <> 0,TRIM((SALT311.StrType)le.seqno), ''),TRIM((SALT311.StrType)le.geoid10_blkgrp),TRIM((SALT311.StrType)le.state_fips10),TRIM((SALT311.StrType)le.county_fips10),TRIM((SALT311.StrType)le.tract_fips10),IF (le.blkgrp_fips10 <> 0,TRIM((SALT311.StrType)le.blkgrp_fips10), ''),IF (le.total_pop <> 0,TRIM((SALT311.StrType)le.total_pop), ''),IF (le.hispanic_total <> 0,TRIM((SALT311.StrType)le.hispanic_total), ''),IF (le.non_hispanic_total <> 0,TRIM((SALT311.StrType)le.non_hispanic_total), ''),IF (le.nh_white_alone <> 0,TRIM((SALT311.StrType)le.nh_white_alone), ''),IF (le.nh_black_alone <> 0,TRIM((SALT311.StrType)le.nh_black_alone), ''),IF (le.nh_aian_alone <> 0,TRIM((SALT311.StrType)le.nh_aian_alone), ''),IF (le.nh_api_alone <> 0,TRIM((SALT311.StrType)le.nh_api_alone), ''),IF (le.nh_other_alone <> 0,TRIM((SALT311.StrType)le.nh_other_alone), ''),IF (le.nh_mult_total <> 0,TRIM((SALT311.StrType)le.nh_mult_total), ''),IF (le.nh_white_other <> 0,TRIM((SALT311.StrType)le.nh_white_other), ''),IF (le.nh_black_other <> 0,TRIM((SALT311.StrType)le.nh_black_other), ''),IF (le.nh_aian_other <> 0,TRIM((SALT311.StrType)le.nh_aian_other), ''),IF (le.nh_asian_hpi <> 0,TRIM((SALT311.StrType)le.nh_asian_hpi), ''),IF (le.nh_api_other <> 0,TRIM((SALT311.StrType)le.nh_api_other), ''),IF (le.nh_asian_hpi_other <> 0,TRIM((SALT311.StrType)le.nh_asian_hpi_other), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,26,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 26);
  SELF.FldNo2 := 1 + (C % 26);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),IF (le.global_src_id <> 0,TRIM((SALT311.StrType)le.global_src_id), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.is_latest),IF (le.seqno <> 0,TRIM((SALT311.StrType)le.seqno), ''),TRIM((SALT311.StrType)le.geoid10_blkgrp),TRIM((SALT311.StrType)le.state_fips10),TRIM((SALT311.StrType)le.county_fips10),TRIM((SALT311.StrType)le.tract_fips10),IF (le.blkgrp_fips10 <> 0,TRIM((SALT311.StrType)le.blkgrp_fips10), ''),IF (le.total_pop <> 0,TRIM((SALT311.StrType)le.total_pop), ''),IF (le.hispanic_total <> 0,TRIM((SALT311.StrType)le.hispanic_total), ''),IF (le.non_hispanic_total <> 0,TRIM((SALT311.StrType)le.non_hispanic_total), ''),IF (le.nh_white_alone <> 0,TRIM((SALT311.StrType)le.nh_white_alone), ''),IF (le.nh_black_alone <> 0,TRIM((SALT311.StrType)le.nh_black_alone), ''),IF (le.nh_aian_alone <> 0,TRIM((SALT311.StrType)le.nh_aian_alone), ''),IF (le.nh_api_alone <> 0,TRIM((SALT311.StrType)le.nh_api_alone), ''),IF (le.nh_other_alone <> 0,TRIM((SALT311.StrType)le.nh_other_alone), ''),IF (le.nh_mult_total <> 0,TRIM((SALT311.StrType)le.nh_mult_total), ''),IF (le.nh_white_other <> 0,TRIM((SALT311.StrType)le.nh_white_other), ''),IF (le.nh_black_other <> 0,TRIM((SALT311.StrType)le.nh_black_other), ''),IF (le.nh_aian_other <> 0,TRIM((SALT311.StrType)le.nh_aian_other), ''),IF (le.nh_asian_hpi <> 0,TRIM((SALT311.StrType)le.nh_asian_hpi), ''),IF (le.nh_api_other <> 0,TRIM((SALT311.StrType)le.nh_api_other), ''),IF (le.nh_asian_hpi_other <> 0,TRIM((SALT311.StrType)le.nh_asian_hpi_other), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),IF (le.global_src_id <> 0,TRIM((SALT311.StrType)le.global_src_id), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.is_latest),IF (le.seqno <> 0,TRIM((SALT311.StrType)le.seqno), ''),TRIM((SALT311.StrType)le.geoid10_blkgrp),TRIM((SALT311.StrType)le.state_fips10),TRIM((SALT311.StrType)le.county_fips10),TRIM((SALT311.StrType)le.tract_fips10),IF (le.blkgrp_fips10 <> 0,TRIM((SALT311.StrType)le.blkgrp_fips10), ''),IF (le.total_pop <> 0,TRIM((SALT311.StrType)le.total_pop), ''),IF (le.hispanic_total <> 0,TRIM((SALT311.StrType)le.hispanic_total), ''),IF (le.non_hispanic_total <> 0,TRIM((SALT311.StrType)le.non_hispanic_total), ''),IF (le.nh_white_alone <> 0,TRIM((SALT311.StrType)le.nh_white_alone), ''),IF (le.nh_black_alone <> 0,TRIM((SALT311.StrType)le.nh_black_alone), ''),IF (le.nh_aian_alone <> 0,TRIM((SALT311.StrType)le.nh_aian_alone), ''),IF (le.nh_api_alone <> 0,TRIM((SALT311.StrType)le.nh_api_alone), ''),IF (le.nh_other_alone <> 0,TRIM((SALT311.StrType)le.nh_other_alone), ''),IF (le.nh_mult_total <> 0,TRIM((SALT311.StrType)le.nh_mult_total), ''),IF (le.nh_white_other <> 0,TRIM((SALT311.StrType)le.nh_white_other), ''),IF (le.nh_black_other <> 0,TRIM((SALT311.StrType)le.nh_black_other), ''),IF (le.nh_aian_other <> 0,TRIM((SALT311.StrType)le.nh_aian_other), ''),IF (le.nh_asian_hpi <> 0,TRIM((SALT311.StrType)le.nh_asian_hpi), ''),IF (le.nh_api_other <> 0,TRIM((SALT311.StrType)le.nh_api_other), ''),IF (le.nh_asian_hpi_other <> 0,TRIM((SALT311.StrType)le.nh_asian_hpi_other), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),26*26,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'record_sid'}
      ,{2,'global_src_id'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'is_latest'}
      ,{6,'seqno'}
      ,{7,'geoid10_blkgrp'}
      ,{8,'state_fips10'}
      ,{9,'county_fips10'}
      ,{10,'tract_fips10'}
      ,{11,'blkgrp_fips10'}
      ,{12,'total_pop'}
      ,{13,'hispanic_total'}
      ,{14,'non_hispanic_total'}
      ,{15,'nh_white_alone'}
      ,{16,'nh_black_alone'}
      ,{17,'nh_aian_alone'}
      ,{18,'nh_api_alone'}
      ,{19,'nh_other_alone'}
      ,{20,'nh_mult_total'}
      ,{21,'nh_white_other'}
      ,{22,'nh_black_other'}
      ,{23,'nh_aian_other'}
      ,{24,'nh_asian_hpi'}
      ,{25,'nh_api_other'}
      ,{26,'nh_asian_hpi_other'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
    Fields.InValid_global_src_id((SALT311.StrType)le.global_src_id),
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_is_latest((SALT311.StrType)le.is_latest),
    Fields.InValid_seqno((SALT311.StrType)le.seqno),
    Fields.InValid_geoid10_blkgrp((SALT311.StrType)le.geoid10_blkgrp),
    Fields.InValid_state_fips10((SALT311.StrType)le.state_fips10),
    Fields.InValid_county_fips10((SALT311.StrType)le.county_fips10),
    Fields.InValid_tract_fips10((SALT311.StrType)le.tract_fips10),
    Fields.InValid_blkgrp_fips10((SALT311.StrType)le.blkgrp_fips10),
    Fields.InValid_total_pop((SALT311.StrType)le.total_pop),
    Fields.InValid_hispanic_total((SALT311.StrType)le.hispanic_total),
    Fields.InValid_non_hispanic_total((SALT311.StrType)le.non_hispanic_total),
    Fields.InValid_nh_white_alone((SALT311.StrType)le.nh_white_alone),
    Fields.InValid_nh_black_alone((SALT311.StrType)le.nh_black_alone),
    Fields.InValid_nh_aian_alone((SALT311.StrType)le.nh_aian_alone),
    Fields.InValid_nh_api_alone((SALT311.StrType)le.nh_api_alone),
    Fields.InValid_nh_other_alone((SALT311.StrType)le.nh_other_alone),
    Fields.InValid_nh_mult_total((SALT311.StrType)le.nh_mult_total),
    Fields.InValid_nh_white_other((SALT311.StrType)le.nh_white_other),
    Fields.InValid_nh_black_other((SALT311.StrType)le.nh_black_other),
    Fields.InValid_nh_aian_other((SALT311.StrType)le.nh_aian_other),
    Fields.InValid_nh_asian_hpi((SALT311.StrType)le.nh_asian_hpi),
    Fields.InValid_nh_api_other((SALT311.StrType)le.nh_api_other),
    Fields.InValid_nh_asian_hpi_other((SALT311.StrType)le.nh_asian_hpi_other),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_id','invalid_id','invalid_date','invalid_date','Unknown','invalid_seqno','invalid_geoid10_blkgrp','invalid_state_fips10','invalid_county_fips10','invalid_tract_fips10','invalid_blkgrp_fips10','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_record_sid(TotalErrors.ErrorNum),Fields.InValidMessage_global_src_id(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_is_latest(TotalErrors.ErrorNum),Fields.InValidMessage_seqno(TotalErrors.ErrorNum),Fields.InValidMessage_geoid10_blkgrp(TotalErrors.ErrorNum),Fields.InValidMessage_state_fips10(TotalErrors.ErrorNum),Fields.InValidMessage_county_fips10(TotalErrors.ErrorNum),Fields.InValidMessage_tract_fips10(TotalErrors.ErrorNum),Fields.InValidMessage_blkgrp_fips10(TotalErrors.ErrorNum),Fields.InValidMessage_total_pop(TotalErrors.ErrorNum),Fields.InValidMessage_hispanic_total(TotalErrors.ErrorNum),Fields.InValidMessage_non_hispanic_total(TotalErrors.ErrorNum),Fields.InValidMessage_nh_white_alone(TotalErrors.ErrorNum),Fields.InValidMessage_nh_black_alone(TotalErrors.ErrorNum),Fields.InValidMessage_nh_aian_alone(TotalErrors.ErrorNum),Fields.InValidMessage_nh_api_alone(TotalErrors.ErrorNum),Fields.InValidMessage_nh_other_alone(TotalErrors.ErrorNum),Fields.InValidMessage_nh_mult_total(TotalErrors.ErrorNum),Fields.InValidMessage_nh_white_other(TotalErrors.ErrorNum),Fields.InValidMessage_nh_black_other(TotalErrors.ErrorNum),Fields.InValidMessage_nh_aian_other(TotalErrors.ErrorNum),Fields.InValidMessage_nh_asian_hpi(TotalErrors.ErrorNum),Fields.InValidMessage_nh_api_other(TotalErrors.ErrorNum),Fields.InValidMessage_nh_asian_hpi_other(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_CFPB, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
