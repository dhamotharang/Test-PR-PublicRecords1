IMPORT ut,SALT31;
EXPORT AA_hygiene(dataset(AA_layout_Business_Credit) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_segment_identifier_pcnt := AVE(GROUP,IF(h.segment_identifier = (TYPEOF(h.segment_identifier))'',0,100));
    maxlength_segment_identifier := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.segment_identifier)));
    avelength_segment_identifier := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.segment_identifier)),h.segment_identifier<>(typeof(h.segment_identifier))'');
    populated_file_sequence_number_pcnt := AVE(GROUP,IF(h.file_sequence_number = (TYPEOF(h.file_sequence_number))'',0,100));
    maxlength_file_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.file_sequence_number)));
    avelength_file_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.file_sequence_number)),h.file_sequence_number<>(typeof(h.file_sequence_number))'');
    populated_sbfe_contributor_number_pcnt := AVE(GROUP,IF(h.sbfe_contributor_number = (TYPEOF(h.sbfe_contributor_number))'',0,100));
    maxlength_sbfe_contributor_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sbfe_contributor_number)));
    avelength_sbfe_contributor_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sbfe_contributor_number)),h.sbfe_contributor_number<>(typeof(h.sbfe_contributor_number))'');
    populated_extracted_date_pcnt := AVE(GROUP,IF(h.extracted_date = (TYPEOF(h.extracted_date))'',0,100));
    maxlength_extracted_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.extracted_date)));
    avelength_extracted_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.extracted_date)),h.extracted_date<>(typeof(h.extracted_date))'');
    populated_cycle_end_date_pcnt := AVE(GROUP,IF(h.cycle_end_date = (TYPEOF(h.cycle_end_date))'',0,100));
    maxlength_cycle_end_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cycle_end_date)));
    avelength_cycle_end_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cycle_end_date)),h.cycle_end_date<>(typeof(h.cycle_end_date))'');
    populated_cycle_number_pcnt := AVE(GROUP,IF(h.cycle_number = (TYPEOF(h.cycle_number))'',0,100));
    maxlength_cycle_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cycle_number)));
    avelength_cycle_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cycle_number)),h.cycle_number<>(typeof(h.cycle_number))'');
    populated_cycle_length_pcnt := AVE(GROUP,IF(h.cycle_length = (TYPEOF(h.cycle_length))'',0,100));
    maxlength_cycle_length := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cycle_length)));
    avelength_cycle_length := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cycle_length)),h.cycle_length<>(typeof(h.cycle_length))'');
    populated_file_correction_indicator_pcnt := AVE(GROUP,IF(h.file_correction_indicator = (TYPEOF(h.file_correction_indicator))'',0,100));
    maxlength_file_correction_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.file_correction_indicator)));
    avelength_file_correction_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.file_correction_indicator)),h.file_correction_indicator<>(typeof(h.file_correction_indicator))'');
    populated_overall_file_format_version_pcnt := AVE(GROUP,IF(h.overall_file_format_version = (TYPEOF(h.overall_file_format_version))'',0,100));
    maxlength_overall_file_format_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.overall_file_format_version)));
    avelength_overall_file_format_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.overall_file_format_version)),h.overall_file_format_version<>(typeof(h.overall_file_format_version))'');
    populated_major_aa_segment_version_pcnt := AVE(GROUP,IF(h.major_aa_segment_version = (TYPEOF(h.major_aa_segment_version))'',0,100));
    maxlength_major_aa_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_aa_segment_version)));
    avelength_major_aa_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_aa_segment_version)),h.major_aa_segment_version<>(typeof(h.major_aa_segment_version))'');
    populated_minor_aa_segment_version_pcnt := AVE(GROUP,IF(h.minor_aa_segment_version = (TYPEOF(h.minor_aa_segment_version))'',0,100));
    maxlength_minor_aa_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_aa_segment_version)));
    avelength_minor_aa_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_aa_segment_version)),h.minor_aa_segment_version<>(typeof(h.minor_aa_segment_version))'');
    populated_major_ab_segment_version_pcnt := AVE(GROUP,IF(h.major_ab_segment_version = (TYPEOF(h.major_ab_segment_version))'',0,100));
    maxlength_major_ab_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ab_segment_version)));
    avelength_major_ab_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ab_segment_version)),h.major_ab_segment_version<>(typeof(h.major_ab_segment_version))'');
    populated_minor_ab_segment_version_pcnt := AVE(GROUP,IF(h.minor_ab_segment_version = (TYPEOF(h.minor_ab_segment_version))'',0,100));
    maxlength_minor_ab_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ab_segment_version)));
    avelength_minor_ab_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ab_segment_version)),h.minor_ab_segment_version<>(typeof(h.minor_ab_segment_version))'');
    populated_major_ma_segment_version_pcnt := AVE(GROUP,IF(h.major_ma_segment_version = (TYPEOF(h.major_ma_segment_version))'',0,100));
    maxlength_major_ma_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ma_segment_version)));
    avelength_major_ma_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ma_segment_version)),h.major_ma_segment_version<>(typeof(h.major_ma_segment_version))'');
    populated_minor_ma_segment_version_pcnt := AVE(GROUP,IF(h.minor_ma_segment_version = (TYPEOF(h.minor_ma_segment_version))'',0,100));
    maxlength_minor_ma_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ma_segment_version)));
    avelength_minor_ma_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ma_segment_version)),h.minor_ma_segment_version<>(typeof(h.minor_ma_segment_version))'');
    populated_major_ad_segment_version_pcnt := AVE(GROUP,IF(h.major_ad_segment_version = (TYPEOF(h.major_ad_segment_version))'',0,100));
    maxlength_major_ad_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ad_segment_version)));
    avelength_major_ad_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ad_segment_version)),h.major_ad_segment_version<>(typeof(h.major_ad_segment_version))'');
    populated_minor_ad_segment_version_pcnt := AVE(GROUP,IF(h.minor_ad_segment_version = (TYPEOF(h.minor_ad_segment_version))'',0,100));
    maxlength_minor_ad_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ad_segment_version)));
    avelength_minor_ad_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ad_segment_version)),h.minor_ad_segment_version<>(typeof(h.minor_ad_segment_version))'');
    populated_major_pn_segment_version_pcnt := AVE(GROUP,IF(h.major_pn_segment_version = (TYPEOF(h.major_pn_segment_version))'',0,100));
    maxlength_major_pn_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_pn_segment_version)));
    avelength_major_pn_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_pn_segment_version)),h.major_pn_segment_version<>(typeof(h.major_pn_segment_version))'');
    populated_minor_pn_segment_version_pcnt := AVE(GROUP,IF(h.minor_pn_segment_version = (TYPEOF(h.minor_pn_segment_version))'',0,100));
    maxlength_minor_pn_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_pn_segment_version)));
    avelength_minor_pn_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_pn_segment_version)),h.minor_pn_segment_version<>(typeof(h.minor_pn_segment_version))'');
    populated_major_ti_segment_version_pcnt := AVE(GROUP,IF(h.major_ti_segment_version = (TYPEOF(h.major_ti_segment_version))'',0,100));
    maxlength_major_ti_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ti_segment_version)));
    avelength_major_ti_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ti_segment_version)),h.major_ti_segment_version<>(typeof(h.major_ti_segment_version))'');
    populated_minor_ti_segment_version_pcnt := AVE(GROUP,IF(h.minor_ti_segment_version = (TYPEOF(h.minor_ti_segment_version))'',0,100));
    maxlength_minor_ti_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ti_segment_version)));
    avelength_minor_ti_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ti_segment_version)),h.minor_ti_segment_version<>(typeof(h.minor_ti_segment_version))'');
    populated_major_is_segment_version_pcnt := AVE(GROUP,IF(h.major_is_segment_version = (TYPEOF(h.major_is_segment_version))'',0,100));
    maxlength_major_is_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_is_segment_version)));
    avelength_major_is_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_is_segment_version)),h.major_is_segment_version<>(typeof(h.major_is_segment_version))'');
    populated_minor_is_segment_version_pcnt := AVE(GROUP,IF(h.minor_is_segment_version = (TYPEOF(h.minor_is_segment_version))'',0,100));
    maxlength_minor_is_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_is_segment_version)));
    avelength_minor_is_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_is_segment_version)),h.minor_is_segment_version<>(typeof(h.minor_is_segment_version))'');
    populated_major_bs_segment_version_pcnt := AVE(GROUP,IF(h.major_bs_segment_version = (TYPEOF(h.major_bs_segment_version))'',0,100));
    maxlength_major_bs_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_bs_segment_version)));
    avelength_major_bs_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_bs_segment_version)),h.major_bs_segment_version<>(typeof(h.major_bs_segment_version))'');
    populated_minor_bs_segment_version_pcnt := AVE(GROUP,IF(h.minor_bs_segment_version = (TYPEOF(h.minor_bs_segment_version))'',0,100));
    maxlength_minor_bs_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_bs_segment_version)));
    avelength_minor_bs_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_bs_segment_version)),h.minor_bs_segment_version<>(typeof(h.minor_bs_segment_version))'');
    populated_major_bi_segment_version_pcnt := AVE(GROUP,IF(h.major_bi_segment_version = (TYPEOF(h.major_bi_segment_version))'',0,100));
    maxlength_major_bi_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_bi_segment_version)));
    avelength_major_bi_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_bi_segment_version)),h.major_bi_segment_version<>(typeof(h.major_bi_segment_version))'');
    populated_minor_bi_segment_version_pcnt := AVE(GROUP,IF(h.minor_bi_segment_version = (TYPEOF(h.minor_bi_segment_version))'',0,100));
    maxlength_minor_bi_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_bi_segment_version)));
    avelength_minor_bi_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_bi_segment_version)),h.minor_bi_segment_version<>(typeof(h.minor_bi_segment_version))'');
    populated_major_cl_segment_version_pcnt := AVE(GROUP,IF(h.major_cl_segment_version = (TYPEOF(h.major_cl_segment_version))'',0,100));
    maxlength_major_cl_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_cl_segment_version)));
    avelength_major_cl_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_cl_segment_version)),h.major_cl_segment_version<>(typeof(h.major_cl_segment_version))'');
    populated_minor_cl_segment_version_pcnt := AVE(GROUP,IF(h.minor_cl_segment_version = (TYPEOF(h.minor_cl_segment_version))'',0,100));
    maxlength_minor_cl_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_cl_segment_version)));
    avelength_minor_cl_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_cl_segment_version)),h.minor_cl_segment_version<>(typeof(h.minor_cl_segment_version))'');
    populated_major_ms_segment_version_pcnt := AVE(GROUP,IF(h.major_ms_segment_version = (TYPEOF(h.major_ms_segment_version))'',0,100));
    maxlength_major_ms_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ms_segment_version)));
    avelength_major_ms_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ms_segment_version)),h.major_ms_segment_version<>(typeof(h.major_ms_segment_version))'');
    populated_minor_ms_segment_version_pcnt := AVE(GROUP,IF(h.minor_ms_segment_version = (TYPEOF(h.minor_ms_segment_version))'',0,100));
    maxlength_minor_ms_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ms_segment_version)));
    avelength_minor_ms_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ms_segment_version)),h.minor_ms_segment_version<>(typeof(h.minor_ms_segment_version))'');
    populated_major_ah_segment_version_pcnt := AVE(GROUP,IF(h.major_ah_segment_version = (TYPEOF(h.major_ah_segment_version))'',0,100));
    maxlength_major_ah_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ah_segment_version)));
    avelength_major_ah_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_ah_segment_version)),h.major_ah_segment_version<>(typeof(h.major_ah_segment_version))'');
    populated_minor_ah_segment_version_pcnt := AVE(GROUP,IF(h.minor_ah_segment_version = (TYPEOF(h.minor_ah_segment_version))'',0,100));
    maxlength_minor_ah_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ah_segment_version)));
    avelength_minor_ah_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_ah_segment_version)),h.minor_ah_segment_version<>(typeof(h.minor_ah_segment_version))'');
    populated_major_zz_segment_version_pcnt := AVE(GROUP,IF(h.major_zz_segment_version = (TYPEOF(h.major_zz_segment_version))'',0,100));
    maxlength_major_zz_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_zz_segment_version)));
    avelength_major_zz_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.major_zz_segment_version)),h.major_zz_segment_version<>(typeof(h.major_zz_segment_version))'');
    populated_minor_zz_segment_version_pcnt := AVE(GROUP,IF(h.minor_zz_segment_version = (TYPEOF(h.minor_zz_segment_version))'',0,100));
    maxlength_minor_zz_segment_version := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_zz_segment_version)));
    avelength_minor_zz_segment_version := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.minor_zz_segment_version)),h.minor_zz_segment_version<>(typeof(h.minor_zz_segment_version))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_segment_identifier_pcnt *   0.00 / 100 + T.Populated_file_sequence_number_pcnt *   0.00 / 100 + T.Populated_sbfe_contributor_number_pcnt *   0.00 / 100 + T.Populated_extracted_date_pcnt *   0.00 / 100 + T.Populated_cycle_end_date_pcnt *   0.00 / 100 + T.Populated_cycle_number_pcnt *   0.00 / 100 + T.Populated_cycle_length_pcnt *   0.00 / 100 + T.Populated_file_correction_indicator_pcnt *   0.00 / 100 + T.Populated_overall_file_format_version_pcnt *   0.00 / 100 + T.Populated_major_aa_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_aa_segment_version_pcnt *   0.00 / 100 + T.Populated_major_ab_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_ab_segment_version_pcnt *   0.00 / 100 + T.Populated_major_ma_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_ma_segment_version_pcnt *   0.00 / 100 + T.Populated_major_ad_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_ad_segment_version_pcnt *   0.00 / 100 + T.Populated_major_pn_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_pn_segment_version_pcnt *   0.00 / 100 + T.Populated_major_ti_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_ti_segment_version_pcnt *   0.00 / 100 + T.Populated_major_is_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_is_segment_version_pcnt *   0.00 / 100 + T.Populated_major_bs_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_bs_segment_version_pcnt *   0.00 / 100 + T.Populated_major_bi_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_bi_segment_version_pcnt *   0.00 / 100 + T.Populated_major_cl_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_cl_segment_version_pcnt *   0.00 / 100 + T.Populated_major_ms_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_ms_segment_version_pcnt *   0.00 / 100 + T.Populated_major_ah_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_ah_segment_version_pcnt *   0.00 / 100 + T.Populated_major_zz_segment_version_pcnt *   0.00 / 100 + T.Populated_minor_zz_segment_version_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT31.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'segment_identifier','file_sequence_number','sbfe_contributor_number','extracted_date','cycle_end_date','cycle_number','cycle_length','file_correction_indicator','overall_file_format_version','major_aa_segment_version','minor_aa_segment_version','major_ab_segment_version','minor_ab_segment_version','major_ma_segment_version','minor_ma_segment_version','major_ad_segment_version','minor_ad_segment_version','major_pn_segment_version','minor_pn_segment_version','major_ti_segment_version','minor_ti_segment_version','major_is_segment_version','minor_is_segment_version','major_bs_segment_version','minor_bs_segment_version','major_bi_segment_version','minor_bi_segment_version','major_cl_segment_version','minor_cl_segment_version','major_ms_segment_version','minor_ms_segment_version','major_ah_segment_version','minor_ah_segment_version','major_zz_segment_version','minor_zz_segment_version');
  SELF.populated_pcnt := CHOOSE(C,le.populated_segment_identifier_pcnt,le.populated_file_sequence_number_pcnt,le.populated_sbfe_contributor_number_pcnt,le.populated_extracted_date_pcnt,le.populated_cycle_end_date_pcnt,le.populated_cycle_number_pcnt,le.populated_cycle_length_pcnt,le.populated_file_correction_indicator_pcnt,le.populated_overall_file_format_version_pcnt,le.populated_major_aa_segment_version_pcnt,le.populated_minor_aa_segment_version_pcnt,le.populated_major_ab_segment_version_pcnt,le.populated_minor_ab_segment_version_pcnt,le.populated_major_ma_segment_version_pcnt,le.populated_minor_ma_segment_version_pcnt,le.populated_major_ad_segment_version_pcnt,le.populated_minor_ad_segment_version_pcnt,le.populated_major_pn_segment_version_pcnt,le.populated_minor_pn_segment_version_pcnt,le.populated_major_ti_segment_version_pcnt,le.populated_minor_ti_segment_version_pcnt,le.populated_major_is_segment_version_pcnt,le.populated_minor_is_segment_version_pcnt,le.populated_major_bs_segment_version_pcnt,le.populated_minor_bs_segment_version_pcnt,le.populated_major_bi_segment_version_pcnt,le.populated_minor_bi_segment_version_pcnt,le.populated_major_cl_segment_version_pcnt,le.populated_minor_cl_segment_version_pcnt,le.populated_major_ms_segment_version_pcnt,le.populated_minor_ms_segment_version_pcnt,le.populated_major_ah_segment_version_pcnt,le.populated_minor_ah_segment_version_pcnt,le.populated_major_zz_segment_version_pcnt,le.populated_minor_zz_segment_version_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_segment_identifier,le.maxlength_file_sequence_number,le.maxlength_sbfe_contributor_number,le.maxlength_extracted_date,le.maxlength_cycle_end_date,le.maxlength_cycle_number,le.maxlength_cycle_length,le.maxlength_file_correction_indicator,le.maxlength_overall_file_format_version,le.maxlength_major_aa_segment_version,le.maxlength_minor_aa_segment_version,le.maxlength_major_ab_segment_version,le.maxlength_minor_ab_segment_version,le.maxlength_major_ma_segment_version,le.maxlength_minor_ma_segment_version,le.maxlength_major_ad_segment_version,le.maxlength_minor_ad_segment_version,le.maxlength_major_pn_segment_version,le.maxlength_minor_pn_segment_version,le.maxlength_major_ti_segment_version,le.maxlength_minor_ti_segment_version,le.maxlength_major_is_segment_version,le.maxlength_minor_is_segment_version,le.maxlength_major_bs_segment_version,le.maxlength_minor_bs_segment_version,le.maxlength_major_bi_segment_version,le.maxlength_minor_bi_segment_version,le.maxlength_major_cl_segment_version,le.maxlength_minor_cl_segment_version,le.maxlength_major_ms_segment_version,le.maxlength_minor_ms_segment_version,le.maxlength_major_ah_segment_version,le.maxlength_minor_ah_segment_version,le.maxlength_major_zz_segment_version,le.maxlength_minor_zz_segment_version);
  SELF.avelength := CHOOSE(C,le.avelength_segment_identifier,le.avelength_file_sequence_number,le.avelength_sbfe_contributor_number,le.avelength_extracted_date,le.avelength_cycle_end_date,le.avelength_cycle_number,le.avelength_cycle_length,le.avelength_file_correction_indicator,le.avelength_overall_file_format_version,le.avelength_major_aa_segment_version,le.avelength_minor_aa_segment_version,le.avelength_major_ab_segment_version,le.avelength_minor_ab_segment_version,le.avelength_major_ma_segment_version,le.avelength_minor_ma_segment_version,le.avelength_major_ad_segment_version,le.avelength_minor_ad_segment_version,le.avelength_major_pn_segment_version,le.avelength_minor_pn_segment_version,le.avelength_major_ti_segment_version,le.avelength_minor_ti_segment_version,le.avelength_major_is_segment_version,le.avelength_minor_is_segment_version,le.avelength_major_bs_segment_version,le.avelength_minor_bs_segment_version,le.avelength_major_bi_segment_version,le.avelength_minor_bi_segment_version,le.avelength_major_cl_segment_version,le.avelength_minor_cl_segment_version,le.avelength_major_ms_segment_version,le.avelength_minor_ms_segment_version,le.avelength_major_ah_segment_version,le.avelength_minor_ah_segment_version,le.avelength_major_zz_segment_version,le.avelength_minor_zz_segment_version);
END;
EXPORT invSummary := NORMALIZE(summary0, 35, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.sbfe_contributor_number),TRIM((SALT31.StrType)le.extracted_date),TRIM((SALT31.StrType)le.cycle_end_date),TRIM((SALT31.StrType)le.cycle_number),TRIM((SALT31.StrType)le.cycle_length),TRIM((SALT31.StrType)le.file_correction_indicator),TRIM((SALT31.StrType)le.overall_file_format_version),TRIM((SALT31.StrType)le.major_aa_segment_version),TRIM((SALT31.StrType)le.minor_aa_segment_version),TRIM((SALT31.StrType)le.major_ab_segment_version),TRIM((SALT31.StrType)le.minor_ab_segment_version),TRIM((SALT31.StrType)le.major_ma_segment_version),TRIM((SALT31.StrType)le.minor_ma_segment_version),TRIM((SALT31.StrType)le.major_ad_segment_version),TRIM((SALT31.StrType)le.minor_ad_segment_version),TRIM((SALT31.StrType)le.major_pn_segment_version),TRIM((SALT31.StrType)le.minor_pn_segment_version),TRIM((SALT31.StrType)le.major_ti_segment_version),TRIM((SALT31.StrType)le.minor_ti_segment_version),TRIM((SALT31.StrType)le.major_is_segment_version),TRIM((SALT31.StrType)le.minor_is_segment_version),TRIM((SALT31.StrType)le.major_bs_segment_version),TRIM((SALT31.StrType)le.minor_bs_segment_version),TRIM((SALT31.StrType)le.major_bi_segment_version),TRIM((SALT31.StrType)le.minor_bi_segment_version),TRIM((SALT31.StrType)le.major_cl_segment_version),TRIM((SALT31.StrType)le.minor_cl_segment_version),TRIM((SALT31.StrType)le.major_ms_segment_version),TRIM((SALT31.StrType)le.minor_ms_segment_version),TRIM((SALT31.StrType)le.major_ah_segment_version),TRIM((SALT31.StrType)le.minor_ah_segment_version),TRIM((SALT31.StrType)le.major_zz_segment_version),TRIM((SALT31.StrType)le.minor_zz_segment_version)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,35,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 35);
  SELF.FldNo2 := 1 + (C % 35);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.sbfe_contributor_number),TRIM((SALT31.StrType)le.extracted_date),TRIM((SALT31.StrType)le.cycle_end_date),TRIM((SALT31.StrType)le.cycle_number),TRIM((SALT31.StrType)le.cycle_length),TRIM((SALT31.StrType)le.file_correction_indicator),TRIM((SALT31.StrType)le.overall_file_format_version),TRIM((SALT31.StrType)le.major_aa_segment_version),TRIM((SALT31.StrType)le.minor_aa_segment_version),TRIM((SALT31.StrType)le.major_ab_segment_version),TRIM((SALT31.StrType)le.minor_ab_segment_version),TRIM((SALT31.StrType)le.major_ma_segment_version),TRIM((SALT31.StrType)le.minor_ma_segment_version),TRIM((SALT31.StrType)le.major_ad_segment_version),TRIM((SALT31.StrType)le.minor_ad_segment_version),TRIM((SALT31.StrType)le.major_pn_segment_version),TRIM((SALT31.StrType)le.minor_pn_segment_version),TRIM((SALT31.StrType)le.major_ti_segment_version),TRIM((SALT31.StrType)le.minor_ti_segment_version),TRIM((SALT31.StrType)le.major_is_segment_version),TRIM((SALT31.StrType)le.minor_is_segment_version),TRIM((SALT31.StrType)le.major_bs_segment_version),TRIM((SALT31.StrType)le.minor_bs_segment_version),TRIM((SALT31.StrType)le.major_bi_segment_version),TRIM((SALT31.StrType)le.minor_bi_segment_version),TRIM((SALT31.StrType)le.major_cl_segment_version),TRIM((SALT31.StrType)le.minor_cl_segment_version),TRIM((SALT31.StrType)le.major_ms_segment_version),TRIM((SALT31.StrType)le.minor_ms_segment_version),TRIM((SALT31.StrType)le.major_ah_segment_version),TRIM((SALT31.StrType)le.minor_ah_segment_version),TRIM((SALT31.StrType)le.major_zz_segment_version),TRIM((SALT31.StrType)le.minor_zz_segment_version)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.segment_identifier),TRIM((SALT31.StrType)le.file_sequence_number),TRIM((SALT31.StrType)le.sbfe_contributor_number),TRIM((SALT31.StrType)le.extracted_date),TRIM((SALT31.StrType)le.cycle_end_date),TRIM((SALT31.StrType)le.cycle_number),TRIM((SALT31.StrType)le.cycle_length),TRIM((SALT31.StrType)le.file_correction_indicator),TRIM((SALT31.StrType)le.overall_file_format_version),TRIM((SALT31.StrType)le.major_aa_segment_version),TRIM((SALT31.StrType)le.minor_aa_segment_version),TRIM((SALT31.StrType)le.major_ab_segment_version),TRIM((SALT31.StrType)le.minor_ab_segment_version),TRIM((SALT31.StrType)le.major_ma_segment_version),TRIM((SALT31.StrType)le.minor_ma_segment_version),TRIM((SALT31.StrType)le.major_ad_segment_version),TRIM((SALT31.StrType)le.minor_ad_segment_version),TRIM((SALT31.StrType)le.major_pn_segment_version),TRIM((SALT31.StrType)le.minor_pn_segment_version),TRIM((SALT31.StrType)le.major_ti_segment_version),TRIM((SALT31.StrType)le.minor_ti_segment_version),TRIM((SALT31.StrType)le.major_is_segment_version),TRIM((SALT31.StrType)le.minor_is_segment_version),TRIM((SALT31.StrType)le.major_bs_segment_version),TRIM((SALT31.StrType)le.minor_bs_segment_version),TRIM((SALT31.StrType)le.major_bi_segment_version),TRIM((SALT31.StrType)le.minor_bi_segment_version),TRIM((SALT31.StrType)le.major_cl_segment_version),TRIM((SALT31.StrType)le.minor_cl_segment_version),TRIM((SALT31.StrType)le.major_ms_segment_version),TRIM((SALT31.StrType)le.minor_ms_segment_version),TRIM((SALT31.StrType)le.major_ah_segment_version),TRIM((SALT31.StrType)le.minor_ah_segment_version),TRIM((SALT31.StrType)le.major_zz_segment_version),TRIM((SALT31.StrType)le.minor_zz_segment_version)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),35*35,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'segment_identifier'}
      ,{2,'file_sequence_number'}
      ,{3,'sbfe_contributor_number'}
      ,{4,'extracted_date'}
      ,{5,'cycle_end_date'}
      ,{6,'cycle_number'}
      ,{7,'cycle_length'}
      ,{8,'file_correction_indicator'}
      ,{9,'overall_file_format_version'}
      ,{10,'major_aa_segment_version'}
      ,{11,'minor_aa_segment_version'}
      ,{12,'major_ab_segment_version'}
      ,{13,'minor_ab_segment_version'}
      ,{14,'major_ma_segment_version'}
      ,{15,'minor_ma_segment_version'}
      ,{16,'major_ad_segment_version'}
      ,{17,'minor_ad_segment_version'}
      ,{18,'major_pn_segment_version'}
      ,{19,'minor_pn_segment_version'}
      ,{20,'major_ti_segment_version'}
      ,{21,'minor_ti_segment_version'}
      ,{22,'major_is_segment_version'}
      ,{23,'minor_is_segment_version'}
      ,{24,'major_bs_segment_version'}
      ,{25,'minor_bs_segment_version'}
      ,{26,'major_bi_segment_version'}
      ,{27,'minor_bi_segment_version'}
      ,{28,'major_cl_segment_version'}
      ,{29,'minor_cl_segment_version'}
      ,{30,'major_ms_segment_version'}
      ,{31,'minor_ms_segment_version'}
      ,{32,'major_ah_segment_version'}
      ,{33,'minor_ah_segment_version'}
      ,{34,'major_zz_segment_version'}
      ,{35,'minor_zz_segment_version'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    AA_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier),
    AA_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number),
    AA_Fields.InValid_sbfe_contributor_number((SALT31.StrType)le.sbfe_contributor_number),
    AA_Fields.InValid_extracted_date((SALT31.StrType)le.extracted_date),
    AA_Fields.InValid_cycle_end_date((SALT31.StrType)le.cycle_end_date),
    AA_Fields.InValid_cycle_number((SALT31.StrType)le.cycle_number),
    AA_Fields.InValid_cycle_length((SALT31.StrType)le.cycle_length),
    AA_Fields.InValid_file_correction_indicator((SALT31.StrType)le.file_correction_indicator),
    AA_Fields.InValid_overall_file_format_version((SALT31.StrType)le.overall_file_format_version),
    AA_Fields.InValid_major_aa_segment_version((SALT31.StrType)le.major_aa_segment_version),
    AA_Fields.InValid_minor_aa_segment_version((SALT31.StrType)le.minor_aa_segment_version),
    AA_Fields.InValid_major_ab_segment_version((SALT31.StrType)le.major_ab_segment_version),
    AA_Fields.InValid_minor_ab_segment_version((SALT31.StrType)le.minor_ab_segment_version),
    AA_Fields.InValid_major_ma_segment_version((SALT31.StrType)le.major_ma_segment_version),
    AA_Fields.InValid_minor_ma_segment_version((SALT31.StrType)le.minor_ma_segment_version),
    AA_Fields.InValid_major_ad_segment_version((SALT31.StrType)le.major_ad_segment_version),
    AA_Fields.InValid_minor_ad_segment_version((SALT31.StrType)le.minor_ad_segment_version),
    AA_Fields.InValid_major_pn_segment_version((SALT31.StrType)le.major_pn_segment_version),
    AA_Fields.InValid_minor_pn_segment_version((SALT31.StrType)le.minor_pn_segment_version),
    AA_Fields.InValid_major_ti_segment_version((SALT31.StrType)le.major_ti_segment_version),
    AA_Fields.InValid_minor_ti_segment_version((SALT31.StrType)le.minor_ti_segment_version),
    AA_Fields.InValid_major_is_segment_version((SALT31.StrType)le.major_is_segment_version),
    AA_Fields.InValid_minor_is_segment_version((SALT31.StrType)le.minor_is_segment_version),
    AA_Fields.InValid_major_bs_segment_version((SALT31.StrType)le.major_bs_segment_version),
    AA_Fields.InValid_minor_bs_segment_version((SALT31.StrType)le.minor_bs_segment_version),
    AA_Fields.InValid_major_bi_segment_version((SALT31.StrType)le.major_bi_segment_version),
    AA_Fields.InValid_minor_bi_segment_version((SALT31.StrType)le.minor_bi_segment_version),
    AA_Fields.InValid_major_cl_segment_version((SALT31.StrType)le.major_cl_segment_version),
    AA_Fields.InValid_minor_cl_segment_version((SALT31.StrType)le.minor_cl_segment_version),
    AA_Fields.InValid_major_ms_segment_version((SALT31.StrType)le.major_ms_segment_version),
    AA_Fields.InValid_minor_ms_segment_version((SALT31.StrType)le.minor_ms_segment_version),
    AA_Fields.InValid_major_ah_segment_version((SALT31.StrType)le.major_ah_segment_version),
    AA_Fields.InValid_minor_ah_segment_version((SALT31.StrType)le.minor_ah_segment_version),
    AA_Fields.InValid_major_zz_segment_version((SALT31.StrType)le.major_zz_segment_version),
    AA_Fields.InValid_minor_zz_segment_version((SALT31.StrType)le.minor_zz_segment_version),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,35,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := AA_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_segment_identifier','invalid_file_sequence_number','invalid_sbfe_contributor_num','invalid_extracted_date','invalid_cycle_end_date','invalid_cycle_number','invalid_cycle_length','invalid_file_correction_indicator','invalid_overall_file_format_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,AA_Fields.InValidMessage_segment_identifier(TotalErrors.ErrorNum),AA_Fields.InValidMessage_file_sequence_number(TotalErrors.ErrorNum),AA_Fields.InValidMessage_sbfe_contributor_number(TotalErrors.ErrorNum),AA_Fields.InValidMessage_extracted_date(TotalErrors.ErrorNum),AA_Fields.InValidMessage_cycle_end_date(TotalErrors.ErrorNum),AA_Fields.InValidMessage_cycle_number(TotalErrors.ErrorNum),AA_Fields.InValidMessage_cycle_length(TotalErrors.ErrorNum),AA_Fields.InValidMessage_file_correction_indicator(TotalErrors.ErrorNum),AA_Fields.InValidMessage_overall_file_format_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_aa_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_aa_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_ab_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_ab_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_ma_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_ma_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_ad_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_ad_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_pn_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_pn_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_ti_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_ti_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_is_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_is_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_bs_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_bs_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_bi_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_bi_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_cl_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_cl_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_ms_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_ms_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_ah_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_ah_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_major_zz_segment_version(TotalErrors.ErrorNum),AA_Fields.InValidMessage_minor_zz_segment_version(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
