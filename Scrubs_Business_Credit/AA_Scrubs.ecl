IMPORT ut,SALT31;
IMPORT scrubs_business_credit,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT AA_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(AA_Layout_Business_Credit)
    UNSIGNED1 segment_identifier_Invalid;
    UNSIGNED1 file_sequence_number_Invalid;
    UNSIGNED1 sbfe_contributor_number_Invalid;
    UNSIGNED1 extracted_date_Invalid;
    UNSIGNED1 cycle_end_date_Invalid;
    UNSIGNED1 cycle_number_Invalid;
    UNSIGNED1 cycle_length_Invalid;
    UNSIGNED1 file_correction_indicator_Invalid;
    UNSIGNED1 overall_file_format_version_Invalid;
    UNSIGNED1 major_aa_segment_version_Invalid;
    UNSIGNED1 minor_aa_segment_version_Invalid;
    UNSIGNED1 major_ab_segment_version_Invalid;
    UNSIGNED1 minor_ab_segment_version_Invalid;
    UNSIGNED1 major_ma_segment_version_Invalid;
    UNSIGNED1 minor_ma_segment_version_Invalid;
    UNSIGNED1 major_ad_segment_version_Invalid;
    UNSIGNED1 minor_ad_segment_version_Invalid;
    UNSIGNED1 major_pn_segment_version_Invalid;
    UNSIGNED1 minor_pn_segment_version_Invalid;
    UNSIGNED1 major_ti_segment_version_Invalid;
    UNSIGNED1 minor_ti_segment_version_Invalid;
    UNSIGNED1 major_is_segment_version_Invalid;
    UNSIGNED1 minor_is_segment_version_Invalid;
    UNSIGNED1 major_bs_segment_version_Invalid;
    UNSIGNED1 minor_bs_segment_version_Invalid;
    UNSIGNED1 major_bi_segment_version_Invalid;
    UNSIGNED1 minor_bi_segment_version_Invalid;
    UNSIGNED1 major_cl_segment_version_Invalid;
    UNSIGNED1 minor_cl_segment_version_Invalid;
    UNSIGNED1 major_ms_segment_version_Invalid;
    UNSIGNED1 minor_ms_segment_version_Invalid;
    UNSIGNED1 major_ah_segment_version_Invalid;
    UNSIGNED1 minor_ah_segment_version_Invalid;
    UNSIGNED1 major_zz_segment_version_Invalid;
    UNSIGNED1 minor_zz_segment_version_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(AA_Layout_Business_Credit)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(AA_Layout_Business_Credit) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := AA_Fields.InValid_segment_identifier((SALT31.StrType)le.segment_identifier);
    SELF.file_sequence_number_Invalid := AA_Fields.InValid_file_sequence_number((SALT31.StrType)le.file_sequence_number);
    SELF.sbfe_contributor_number_Invalid := AA_Fields.InValid_sbfe_contributor_number((SALT31.StrType)le.sbfe_contributor_number);
    SELF.extracted_date_Invalid := AA_Fields.InValid_extracted_date((SALT31.StrType)le.extracted_date);
    SELF.cycle_end_date_Invalid := AA_Fields.InValid_cycle_end_date((SALT31.StrType)le.cycle_end_date);
    SELF.cycle_number_Invalid := AA_Fields.InValid_cycle_number((SALT31.StrType)le.cycle_number);
    SELF.cycle_length_Invalid := AA_Fields.InValid_cycle_length((SALT31.StrType)le.cycle_length);
    SELF.file_correction_indicator_Invalid := AA_Fields.InValid_file_correction_indicator((SALT31.StrType)le.file_correction_indicator);
    SELF.overall_file_format_version_Invalid := AA_Fields.InValid_overall_file_format_version((SALT31.StrType)le.overall_file_format_version);
    SELF.major_aa_segment_version_Invalid := AA_Fields.InValid_major_aa_segment_version((SALT31.StrType)le.major_aa_segment_version);
    SELF.minor_aa_segment_version_Invalid := AA_Fields.InValid_minor_aa_segment_version((SALT31.StrType)le.minor_aa_segment_version);
    SELF.major_ab_segment_version_Invalid := AA_Fields.InValid_major_ab_segment_version((SALT31.StrType)le.major_ab_segment_version);
    SELF.minor_ab_segment_version_Invalid := AA_Fields.InValid_minor_ab_segment_version((SALT31.StrType)le.minor_ab_segment_version);
    SELF.major_ma_segment_version_Invalid := AA_Fields.InValid_major_ma_segment_version((SALT31.StrType)le.major_ma_segment_version);
    SELF.minor_ma_segment_version_Invalid := AA_Fields.InValid_minor_ma_segment_version((SALT31.StrType)le.minor_ma_segment_version);
    SELF.major_ad_segment_version_Invalid := AA_Fields.InValid_major_ad_segment_version((SALT31.StrType)le.major_ad_segment_version);
    SELF.minor_ad_segment_version_Invalid := AA_Fields.InValid_minor_ad_segment_version((SALT31.StrType)le.minor_ad_segment_version);
    SELF.major_pn_segment_version_Invalid := AA_Fields.InValid_major_pn_segment_version((SALT31.StrType)le.major_pn_segment_version);
    SELF.minor_pn_segment_version_Invalid := AA_Fields.InValid_minor_pn_segment_version((SALT31.StrType)le.minor_pn_segment_version);
    SELF.major_ti_segment_version_Invalid := AA_Fields.InValid_major_ti_segment_version((SALT31.StrType)le.major_ti_segment_version);
    SELF.minor_ti_segment_version_Invalid := AA_Fields.InValid_minor_ti_segment_version((SALT31.StrType)le.minor_ti_segment_version);
    SELF.major_is_segment_version_Invalid := AA_Fields.InValid_major_is_segment_version((SALT31.StrType)le.major_is_segment_version);
    SELF.minor_is_segment_version_Invalid := AA_Fields.InValid_minor_is_segment_version((SALT31.StrType)le.minor_is_segment_version);
    SELF.major_bs_segment_version_Invalid := AA_Fields.InValid_major_bs_segment_version((SALT31.StrType)le.major_bs_segment_version);
    SELF.minor_bs_segment_version_Invalid := AA_Fields.InValid_minor_bs_segment_version((SALT31.StrType)le.minor_bs_segment_version);
    SELF.major_bi_segment_version_Invalid := AA_Fields.InValid_major_bi_segment_version((SALT31.StrType)le.major_bi_segment_version);
    SELF.minor_bi_segment_version_Invalid := AA_Fields.InValid_minor_bi_segment_version((SALT31.StrType)le.minor_bi_segment_version);
    SELF.major_cl_segment_version_Invalid := AA_Fields.InValid_major_cl_segment_version((SALT31.StrType)le.major_cl_segment_version);
    SELF.minor_cl_segment_version_Invalid := AA_Fields.InValid_minor_cl_segment_version((SALT31.StrType)le.minor_cl_segment_version);
    SELF.major_ms_segment_version_Invalid := AA_Fields.InValid_major_ms_segment_version((SALT31.StrType)le.major_ms_segment_version);
    SELF.minor_ms_segment_version_Invalid := AA_Fields.InValid_minor_ms_segment_version((SALT31.StrType)le.minor_ms_segment_version);
    SELF.major_ah_segment_version_Invalid := AA_Fields.InValid_major_ah_segment_version((SALT31.StrType)le.major_ah_segment_version);
    SELF.minor_ah_segment_version_Invalid := AA_Fields.InValid_minor_ah_segment_version((SALT31.StrType)le.minor_ah_segment_version);
    SELF.major_zz_segment_version_Invalid := AA_Fields.InValid_major_zz_segment_version((SALT31.StrType)le.major_zz_segment_version);
    SELF.minor_zz_segment_version_Invalid := AA_Fields.InValid_minor_zz_segment_version((SALT31.StrType)le.minor_zz_segment_version);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.segment_identifier_Invalid << 0 ) + ( le.file_sequence_number_Invalid << 1 ) + ( le.sbfe_contributor_number_Invalid << 3 ) + ( le.extracted_date_Invalid << 5 ) + ( le.cycle_end_date_Invalid << 7 ) + ( le.cycle_number_Invalid << 9 ) + ( le.cycle_length_Invalid << 10 ) + ( le.file_correction_indicator_Invalid << 11 ) + ( le.overall_file_format_version_Invalid << 12 ) + ( le.major_aa_segment_version_Invalid << 14 ) + ( le.minor_aa_segment_version_Invalid << 16 ) + ( le.major_ab_segment_version_Invalid << 18 ) + ( le.minor_ab_segment_version_Invalid << 20 ) + ( le.major_ma_segment_version_Invalid << 22 ) + ( le.minor_ma_segment_version_Invalid << 24 ) + ( le.major_ad_segment_version_Invalid << 26 ) + ( le.minor_ad_segment_version_Invalid << 28 ) + ( le.major_pn_segment_version_Invalid << 30 ) + ( le.minor_pn_segment_version_Invalid << 32 ) + ( le.major_ti_segment_version_Invalid << 34 ) + ( le.minor_ti_segment_version_Invalid << 36 ) + ( le.major_is_segment_version_Invalid << 38 ) + ( le.minor_is_segment_version_Invalid << 40 ) + ( le.major_bs_segment_version_Invalid << 42 ) + ( le.minor_bs_segment_version_Invalid << 44 ) + ( le.major_bi_segment_version_Invalid << 46 ) + ( le.minor_bi_segment_version_Invalid << 48 ) + ( le.major_cl_segment_version_Invalid << 50 ) + ( le.minor_cl_segment_version_Invalid << 52 ) + ( le.major_ms_segment_version_Invalid << 54 ) + ( le.minor_ms_segment_version_Invalid << 56 ) + ( le.major_ah_segment_version_Invalid << 58 ) + ( le.minor_ah_segment_version_Invalid << 60 ) + ( le.major_zz_segment_version_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.minor_zz_segment_version_Invalid << 0 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,AA_Layout_Business_Credit);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.segment_identifier_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.file_sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.sbfe_contributor_number_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.extracted_date_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.cycle_end_date_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.cycle_number_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.cycle_length_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.file_correction_indicator_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.overall_file_format_version_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.major_aa_segment_version_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.minor_aa_segment_version_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.major_ab_segment_version_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.minor_ab_segment_version_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.major_ma_segment_version_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.minor_ma_segment_version_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.major_ad_segment_version_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.minor_ad_segment_version_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.major_pn_segment_version_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.minor_pn_segment_version_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.major_ti_segment_version_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.minor_ti_segment_version_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.major_is_segment_version_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.minor_is_segment_version_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.major_bs_segment_version_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.minor_bs_segment_version_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.major_bi_segment_version_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.minor_bi_segment_version_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.major_cl_segment_version_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.minor_cl_segment_version_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.major_ms_segment_version_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.minor_ms_segment_version_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.major_ah_segment_version_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.minor_ah_segment_version_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.major_zz_segment_version_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.minor_zz_segment_version_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    segment_identifier_ENUM_ErrorCount := COUNT(GROUP,h.segment_identifier_Invalid=1);
    file_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid=1);
    file_sequence_number_LENGTH_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid=2);
    file_sequence_number_Total_ErrorCount := COUNT(GROUP,h.file_sequence_number_Invalid>0);
    sbfe_contributor_number_ALLOW_ErrorCount := COUNT(GROUP,h.sbfe_contributor_number_Invalid=1);
    sbfe_contributor_number_CUSTOM_ErrorCount := COUNT(GROUP,h.sbfe_contributor_number_Invalid=2);
    sbfe_contributor_number_LENGTH_ErrorCount := COUNT(GROUP,h.sbfe_contributor_number_Invalid=3);
    sbfe_contributor_number_Total_ErrorCount := COUNT(GROUP,h.sbfe_contributor_number_Invalid>0);
    extracted_date_ALLOW_ErrorCount := COUNT(GROUP,h.extracted_date_Invalid=1);
    extracted_date_CUSTOM_ErrorCount := COUNT(GROUP,h.extracted_date_Invalid=2);
    extracted_date_LENGTH_ErrorCount := COUNT(GROUP,h.extracted_date_Invalid=3);
    extracted_date_Total_ErrorCount := COUNT(GROUP,h.extracted_date_Invalid>0);
    cycle_end_date_ALLOW_ErrorCount := COUNT(GROUP,h.cycle_end_date_Invalid=1);
    cycle_end_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cycle_end_date_Invalid=2);
    cycle_end_date_LENGTH_ErrorCount := COUNT(GROUP,h.cycle_end_date_Invalid=3);
    cycle_end_date_Total_ErrorCount := COUNT(GROUP,h.cycle_end_date_Invalid>0);
    cycle_number_ALLOW_ErrorCount := COUNT(GROUP,h.cycle_number_Invalid=1);
    cycle_length_ALLOW_ErrorCount := COUNT(GROUP,h.cycle_length_Invalid=1);
    file_correction_indicator_ENUM_ErrorCount := COUNT(GROUP,h.file_correction_indicator_Invalid=1);
    overall_file_format_version_ALLOW_ErrorCount := COUNT(GROUP,h.overall_file_format_version_Invalid=1);
    overall_file_format_version_LENGTH_ErrorCount := COUNT(GROUP,h.overall_file_format_version_Invalid=2);
    overall_file_format_version_Total_ErrorCount := COUNT(GROUP,h.overall_file_format_version_Invalid>0);
    major_aa_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_aa_segment_version_Invalid=1);
    major_aa_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_aa_segment_version_Invalid=2);
    major_aa_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_aa_segment_version_Invalid>0);
    minor_aa_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_aa_segment_version_Invalid=1);
    minor_aa_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_aa_segment_version_Invalid=2);
    minor_aa_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_aa_segment_version_Invalid>0);
    major_ab_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_ab_segment_version_Invalid=1);
    major_ab_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_ab_segment_version_Invalid=2);
    major_ab_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_ab_segment_version_Invalid>0);
    minor_ab_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_ab_segment_version_Invalid=1);
    minor_ab_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_ab_segment_version_Invalid=2);
    minor_ab_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_ab_segment_version_Invalid>0);
    major_ma_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_ma_segment_version_Invalid=1);
    major_ma_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_ma_segment_version_Invalid=2);
    major_ma_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_ma_segment_version_Invalid>0);
    minor_ma_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_ma_segment_version_Invalid=1);
    minor_ma_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_ma_segment_version_Invalid=2);
    minor_ma_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_ma_segment_version_Invalid>0);
    major_ad_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_ad_segment_version_Invalid=1);
    major_ad_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_ad_segment_version_Invalid=2);
    major_ad_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_ad_segment_version_Invalid>0);
    minor_ad_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_ad_segment_version_Invalid=1);
    minor_ad_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_ad_segment_version_Invalid=2);
    minor_ad_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_ad_segment_version_Invalid>0);
    major_pn_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_pn_segment_version_Invalid=1);
    major_pn_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_pn_segment_version_Invalid=2);
    major_pn_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_pn_segment_version_Invalid>0);
    minor_pn_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_pn_segment_version_Invalid=1);
    minor_pn_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_pn_segment_version_Invalid=2);
    minor_pn_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_pn_segment_version_Invalid>0);
    major_ti_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_ti_segment_version_Invalid=1);
    major_ti_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_ti_segment_version_Invalid=2);
    major_ti_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_ti_segment_version_Invalid>0);
    minor_ti_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_ti_segment_version_Invalid=1);
    minor_ti_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_ti_segment_version_Invalid=2);
    minor_ti_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_ti_segment_version_Invalid>0);
    major_is_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_is_segment_version_Invalid=1);
    major_is_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_is_segment_version_Invalid=2);
    major_is_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_is_segment_version_Invalid>0);
    minor_is_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_is_segment_version_Invalid=1);
    minor_is_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_is_segment_version_Invalid=2);
    minor_is_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_is_segment_version_Invalid>0);
    major_bs_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_bs_segment_version_Invalid=1);
    major_bs_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_bs_segment_version_Invalid=2);
    major_bs_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_bs_segment_version_Invalid>0);
    minor_bs_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_bs_segment_version_Invalid=1);
    minor_bs_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_bs_segment_version_Invalid=2);
    minor_bs_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_bs_segment_version_Invalid>0);
    major_bi_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_bi_segment_version_Invalid=1);
    major_bi_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_bi_segment_version_Invalid=2);
    major_bi_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_bi_segment_version_Invalid>0);
    minor_bi_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_bi_segment_version_Invalid=1);
    minor_bi_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_bi_segment_version_Invalid=2);
    minor_bi_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_bi_segment_version_Invalid>0);
    major_cl_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_cl_segment_version_Invalid=1);
    major_cl_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_cl_segment_version_Invalid=2);
    major_cl_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_cl_segment_version_Invalid>0);
    minor_cl_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_cl_segment_version_Invalid=1);
    minor_cl_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_cl_segment_version_Invalid=2);
    minor_cl_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_cl_segment_version_Invalid>0);
    major_ms_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_ms_segment_version_Invalid=1);
    major_ms_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_ms_segment_version_Invalid=2);
    major_ms_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_ms_segment_version_Invalid>0);
    minor_ms_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_ms_segment_version_Invalid=1);
    minor_ms_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_ms_segment_version_Invalid=2);
    minor_ms_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_ms_segment_version_Invalid>0);
    major_ah_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_ah_segment_version_Invalid=1);
    major_ah_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_ah_segment_version_Invalid=2);
    major_ah_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_ah_segment_version_Invalid>0);
    minor_ah_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_ah_segment_version_Invalid=1);
    minor_ah_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_ah_segment_version_Invalid=2);
    minor_ah_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_ah_segment_version_Invalid>0);
    major_zz_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.major_zz_segment_version_Invalid=1);
    major_zz_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.major_zz_segment_version_Invalid=2);
    major_zz_segment_version_Total_ErrorCount := COUNT(GROUP,h.major_zz_segment_version_Invalid>0);
    minor_zz_segment_version_ALLOW_ErrorCount := COUNT(GROUP,h.minor_zz_segment_version_Invalid=1);
    minor_zz_segment_version_LENGTH_ErrorCount := COUNT(GROUP,h.minor_zz_segment_version_Invalid=2);
    minor_zz_segment_version_Total_ErrorCount := COUNT(GROUP,h.minor_zz_segment_version_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT31.StrType ErrorMessage;
    SALT31.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.segment_identifier_Invalid,le.file_sequence_number_Invalid,le.sbfe_contributor_number_Invalid,le.extracted_date_Invalid,le.cycle_end_date_Invalid,le.cycle_number_Invalid,le.cycle_length_Invalid,le.file_correction_indicator_Invalid,le.overall_file_format_version_Invalid,le.major_aa_segment_version_Invalid,le.minor_aa_segment_version_Invalid,le.major_ab_segment_version_Invalid,le.minor_ab_segment_version_Invalid,le.major_ma_segment_version_Invalid,le.minor_ma_segment_version_Invalid,le.major_ad_segment_version_Invalid,le.minor_ad_segment_version_Invalid,le.major_pn_segment_version_Invalid,le.minor_pn_segment_version_Invalid,le.major_ti_segment_version_Invalid,le.minor_ti_segment_version_Invalid,le.major_is_segment_version_Invalid,le.minor_is_segment_version_Invalid,le.major_bs_segment_version_Invalid,le.minor_bs_segment_version_Invalid,le.major_bi_segment_version_Invalid,le.minor_bi_segment_version_Invalid,le.major_cl_segment_version_Invalid,le.minor_cl_segment_version_Invalid,le.major_ms_segment_version_Invalid,le.minor_ms_segment_version_Invalid,le.major_ah_segment_version_Invalid,le.minor_ah_segment_version_Invalid,le.major_zz_segment_version_Invalid,le.minor_zz_segment_version_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,AA_Fields.InvalidMessage_segment_identifier(le.segment_identifier_Invalid),AA_Fields.InvalidMessage_file_sequence_number(le.file_sequence_number_Invalid),AA_Fields.InvalidMessage_sbfe_contributor_number(le.sbfe_contributor_number_Invalid),AA_Fields.InvalidMessage_extracted_date(le.extracted_date_Invalid),AA_Fields.InvalidMessage_cycle_end_date(le.cycle_end_date_Invalid),AA_Fields.InvalidMessage_cycle_number(le.cycle_number_Invalid),AA_Fields.InvalidMessage_cycle_length(le.cycle_length_Invalid),AA_Fields.InvalidMessage_file_correction_indicator(le.file_correction_indicator_Invalid),AA_Fields.InvalidMessage_overall_file_format_version(le.overall_file_format_version_Invalid),AA_Fields.InvalidMessage_major_aa_segment_version(le.major_aa_segment_version_Invalid),AA_Fields.InvalidMessage_minor_aa_segment_version(le.minor_aa_segment_version_Invalid),AA_Fields.InvalidMessage_major_ab_segment_version(le.major_ab_segment_version_Invalid),AA_Fields.InvalidMessage_minor_ab_segment_version(le.minor_ab_segment_version_Invalid),AA_Fields.InvalidMessage_major_ma_segment_version(le.major_ma_segment_version_Invalid),AA_Fields.InvalidMessage_minor_ma_segment_version(le.minor_ma_segment_version_Invalid),AA_Fields.InvalidMessage_major_ad_segment_version(le.major_ad_segment_version_Invalid),AA_Fields.InvalidMessage_minor_ad_segment_version(le.minor_ad_segment_version_Invalid),AA_Fields.InvalidMessage_major_pn_segment_version(le.major_pn_segment_version_Invalid),AA_Fields.InvalidMessage_minor_pn_segment_version(le.minor_pn_segment_version_Invalid),AA_Fields.InvalidMessage_major_ti_segment_version(le.major_ti_segment_version_Invalid),AA_Fields.InvalidMessage_minor_ti_segment_version(le.minor_ti_segment_version_Invalid),AA_Fields.InvalidMessage_major_is_segment_version(le.major_is_segment_version_Invalid),AA_Fields.InvalidMessage_minor_is_segment_version(le.minor_is_segment_version_Invalid),AA_Fields.InvalidMessage_major_bs_segment_version(le.major_bs_segment_version_Invalid),AA_Fields.InvalidMessage_minor_bs_segment_version(le.minor_bs_segment_version_Invalid),AA_Fields.InvalidMessage_major_bi_segment_version(le.major_bi_segment_version_Invalid),AA_Fields.InvalidMessage_minor_bi_segment_version(le.minor_bi_segment_version_Invalid),AA_Fields.InvalidMessage_major_cl_segment_version(le.major_cl_segment_version_Invalid),AA_Fields.InvalidMessage_minor_cl_segment_version(le.minor_cl_segment_version_Invalid),AA_Fields.InvalidMessage_major_ms_segment_version(le.major_ms_segment_version_Invalid),AA_Fields.InvalidMessage_minor_ms_segment_version(le.minor_ms_segment_version_Invalid),AA_Fields.InvalidMessage_major_ah_segment_version(le.major_ah_segment_version_Invalid),AA_Fields.InvalidMessage_minor_ah_segment_version(le.minor_ah_segment_version_Invalid),AA_Fields.InvalidMessage_major_zz_segment_version(le.major_zz_segment_version_Invalid),AA_Fields.InvalidMessage_minor_zz_segment_version(le.minor_zz_segment_version_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.segment_identifier_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.file_sequence_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.sbfe_contributor_number_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.extracted_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.cycle_end_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.cycle_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cycle_length_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.file_correction_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.overall_file_format_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_aa_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_aa_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_ab_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_ab_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_ma_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_ma_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_ad_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_ad_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_pn_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_pn_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_ti_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_ti_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_is_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_is_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_bs_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_bs_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_bi_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_bi_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_cl_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_cl_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_ms_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_ms_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_ah_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_ah_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.major_zz_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.minor_zz_segment_version_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'segment_identifier','file_sequence_number','sbfe_contributor_number','extracted_date','cycle_end_date','cycle_number','cycle_length','file_correction_indicator','overall_file_format_version','major_aa_segment_version','minor_aa_segment_version','major_ab_segment_version','minor_ab_segment_version','major_ma_segment_version','minor_ma_segment_version','major_ad_segment_version','minor_ad_segment_version','major_pn_segment_version','minor_pn_segment_version','major_ti_segment_version','minor_ti_segment_version','major_is_segment_version','minor_is_segment_version','major_bs_segment_version','minor_bs_segment_version','major_bi_segment_version','minor_bi_segment_version','major_cl_segment_version','minor_cl_segment_version','major_ms_segment_version','minor_ms_segment_version','major_ah_segment_version','minor_ah_segment_version','major_zz_segment_version','minor_zz_segment_version','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_segment_identifier','invalid_file_sequence_number','invalid_sbfe_contributor_num','invalid_extracted_date','invalid_cycle_end_date','invalid_cycle_number','invalid_cycle_length','invalid_file_correction_indicator','invalid_overall_file_format_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.segment_identifier,(SALT31.StrType)le.file_sequence_number,(SALT31.StrType)le.sbfe_contributor_number,(SALT31.StrType)le.extracted_date,(SALT31.StrType)le.cycle_end_date,(SALT31.StrType)le.cycle_number,(SALT31.StrType)le.cycle_length,(SALT31.StrType)le.file_correction_indicator,(SALT31.StrType)le.overall_file_format_version,(SALT31.StrType)le.major_aa_segment_version,(SALT31.StrType)le.minor_aa_segment_version,(SALT31.StrType)le.major_ab_segment_version,(SALT31.StrType)le.minor_ab_segment_version,(SALT31.StrType)le.major_ma_segment_version,(SALT31.StrType)le.minor_ma_segment_version,(SALT31.StrType)le.major_ad_segment_version,(SALT31.StrType)le.minor_ad_segment_version,(SALT31.StrType)le.major_pn_segment_version,(SALT31.StrType)le.minor_pn_segment_version,(SALT31.StrType)le.major_ti_segment_version,(SALT31.StrType)le.minor_ti_segment_version,(SALT31.StrType)le.major_is_segment_version,(SALT31.StrType)le.minor_is_segment_version,(SALT31.StrType)le.major_bs_segment_version,(SALT31.StrType)le.minor_bs_segment_version,(SALT31.StrType)le.major_bi_segment_version,(SALT31.StrType)le.minor_bi_segment_version,(SALT31.StrType)le.major_cl_segment_version,(SALT31.StrType)le.minor_cl_segment_version,(SALT31.StrType)le.major_ms_segment_version,(SALT31.StrType)le.minor_ms_segment_version,(SALT31.StrType)le.major_ah_segment_version,(SALT31.StrType)le.minor_ah_segment_version,(SALT31.StrType)le.major_zz_segment_version,(SALT31.StrType)le.minor_zz_segment_version,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,35,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'segment_identifier:invalid_segment_identifier:ENUM'
          ,'file_sequence_number:invalid_file_sequence_number:ALLOW','file_sequence_number:invalid_file_sequence_number:LENGTH'
          ,'sbfe_contributor_number:invalid_sbfe_contributor_num:ALLOW','sbfe_contributor_number:invalid_sbfe_contributor_num:CUSTOM','sbfe_contributor_number:invalid_sbfe_contributor_num:LENGTH'
          ,'extracted_date:invalid_extracted_date:ALLOW','extracted_date:invalid_extracted_date:CUSTOM','extracted_date:invalid_extracted_date:LENGTH'
          ,'cycle_end_date:invalid_cycle_end_date:ALLOW','cycle_end_date:invalid_cycle_end_date:CUSTOM','cycle_end_date:invalid_cycle_end_date:LENGTH'
          ,'cycle_number:invalid_cycle_number:ALLOW'
          ,'cycle_length:invalid_cycle_length:ALLOW'
          ,'file_correction_indicator:invalid_file_correction_indicator:ENUM'
          ,'overall_file_format_version:invalid_overall_file_format_version:ALLOW','overall_file_format_version:invalid_overall_file_format_version:LENGTH'
          ,'major_aa_segment_version:invalid_major_aa_segment_version:ALLOW','major_aa_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_aa_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_aa_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_ab_segment_version:invalid_major_aa_segment_version:ALLOW','major_ab_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_ab_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_ab_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_ma_segment_version:invalid_major_aa_segment_version:ALLOW','major_ma_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_ma_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_ma_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_ad_segment_version:invalid_major_aa_segment_version:ALLOW','major_ad_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_ad_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_ad_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_pn_segment_version:invalid_major_aa_segment_version:ALLOW','major_pn_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_pn_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_pn_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_ti_segment_version:invalid_major_aa_segment_version:ALLOW','major_ti_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_ti_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_ti_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_is_segment_version:invalid_major_aa_segment_version:ALLOW','major_is_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_is_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_is_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_bs_segment_version:invalid_major_aa_segment_version:ALLOW','major_bs_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_bs_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_bs_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_bi_segment_version:invalid_major_aa_segment_version:ALLOW','major_bi_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_bi_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_bi_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_cl_segment_version:invalid_major_aa_segment_version:ALLOW','major_cl_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_cl_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_cl_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_ms_segment_version:invalid_major_aa_segment_version:ALLOW','major_ms_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_ms_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_ms_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_ah_segment_version:invalid_major_aa_segment_version:ALLOW','major_ah_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_ah_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_ah_segment_version:invalid_minor_aa_segment_version:LENGTH'
          ,'major_zz_segment_version:invalid_major_aa_segment_version:ALLOW','major_zz_segment_version:invalid_major_aa_segment_version:LENGTH'
          ,'minor_zz_segment_version:invalid_minor_aa_segment_version:ALLOW','minor_zz_segment_version:invalid_minor_aa_segment_version:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,AA_Fields.InvalidMessage_segment_identifier(1)
          ,AA_Fields.InvalidMessage_file_sequence_number(1),AA_Fields.InvalidMessage_file_sequence_number(2)
          ,AA_Fields.InvalidMessage_sbfe_contributor_number(1),AA_Fields.InvalidMessage_sbfe_contributor_number(2),AA_Fields.InvalidMessage_sbfe_contributor_number(3)
          ,AA_Fields.InvalidMessage_extracted_date(1),AA_Fields.InvalidMessage_extracted_date(2),AA_Fields.InvalidMessage_extracted_date(3)
          ,AA_Fields.InvalidMessage_cycle_end_date(1),AA_Fields.InvalidMessage_cycle_end_date(2),AA_Fields.InvalidMessage_cycle_end_date(3)
          ,AA_Fields.InvalidMessage_cycle_number(1)
          ,AA_Fields.InvalidMessage_cycle_length(1)
          ,AA_Fields.InvalidMessage_file_correction_indicator(1)
          ,AA_Fields.InvalidMessage_overall_file_format_version(1),AA_Fields.InvalidMessage_overall_file_format_version(2)
          ,AA_Fields.InvalidMessage_major_aa_segment_version(1),AA_Fields.InvalidMessage_major_aa_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_aa_segment_version(1),AA_Fields.InvalidMessage_minor_aa_segment_version(2)
          ,AA_Fields.InvalidMessage_major_ab_segment_version(1),AA_Fields.InvalidMessage_major_ab_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_ab_segment_version(1),AA_Fields.InvalidMessage_minor_ab_segment_version(2)
          ,AA_Fields.InvalidMessage_major_ma_segment_version(1),AA_Fields.InvalidMessage_major_ma_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_ma_segment_version(1),AA_Fields.InvalidMessage_minor_ma_segment_version(2)
          ,AA_Fields.InvalidMessage_major_ad_segment_version(1),AA_Fields.InvalidMessage_major_ad_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_ad_segment_version(1),AA_Fields.InvalidMessage_minor_ad_segment_version(2)
          ,AA_Fields.InvalidMessage_major_pn_segment_version(1),AA_Fields.InvalidMessage_major_pn_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_pn_segment_version(1),AA_Fields.InvalidMessage_minor_pn_segment_version(2)
          ,AA_Fields.InvalidMessage_major_ti_segment_version(1),AA_Fields.InvalidMessage_major_ti_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_ti_segment_version(1),AA_Fields.InvalidMessage_minor_ti_segment_version(2)
          ,AA_Fields.InvalidMessage_major_is_segment_version(1),AA_Fields.InvalidMessage_major_is_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_is_segment_version(1),AA_Fields.InvalidMessage_minor_is_segment_version(2)
          ,AA_Fields.InvalidMessage_major_bs_segment_version(1),AA_Fields.InvalidMessage_major_bs_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_bs_segment_version(1),AA_Fields.InvalidMessage_minor_bs_segment_version(2)
          ,AA_Fields.InvalidMessage_major_bi_segment_version(1),AA_Fields.InvalidMessage_major_bi_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_bi_segment_version(1),AA_Fields.InvalidMessage_minor_bi_segment_version(2)
          ,AA_Fields.InvalidMessage_major_cl_segment_version(1),AA_Fields.InvalidMessage_major_cl_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_cl_segment_version(1),AA_Fields.InvalidMessage_minor_cl_segment_version(2)
          ,AA_Fields.InvalidMessage_major_ms_segment_version(1),AA_Fields.InvalidMessage_major_ms_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_ms_segment_version(1),AA_Fields.InvalidMessage_minor_ms_segment_version(2)
          ,AA_Fields.InvalidMessage_major_ah_segment_version(1),AA_Fields.InvalidMessage_major_ah_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_ah_segment_version(1),AA_Fields.InvalidMessage_minor_ah_segment_version(2)
          ,AA_Fields.InvalidMessage_major_zz_segment_version(1),AA_Fields.InvalidMessage_major_zz_segment_version(2)
          ,AA_Fields.InvalidMessage_minor_zz_segment_version(1),AA_Fields.InvalidMessage_minor_zz_segment_version(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.sbfe_contributor_number_ALLOW_ErrorCount,le.sbfe_contributor_number_CUSTOM_ErrorCount,le.sbfe_contributor_number_LENGTH_ErrorCount
          ,le.extracted_date_ALLOW_ErrorCount,le.extracted_date_CUSTOM_ErrorCount,le.extracted_date_LENGTH_ErrorCount
          ,le.cycle_end_date_ALLOW_ErrorCount,le.cycle_end_date_CUSTOM_ErrorCount,le.cycle_end_date_LENGTH_ErrorCount
          ,le.cycle_number_ALLOW_ErrorCount
          ,le.cycle_length_ALLOW_ErrorCount
          ,le.file_correction_indicator_ENUM_ErrorCount
          ,le.overall_file_format_version_ALLOW_ErrorCount,le.overall_file_format_version_LENGTH_ErrorCount
          ,le.major_aa_segment_version_ALLOW_ErrorCount,le.major_aa_segment_version_LENGTH_ErrorCount
          ,le.minor_aa_segment_version_ALLOW_ErrorCount,le.minor_aa_segment_version_LENGTH_ErrorCount
          ,le.major_ab_segment_version_ALLOW_ErrorCount,le.major_ab_segment_version_LENGTH_ErrorCount
          ,le.minor_ab_segment_version_ALLOW_ErrorCount,le.minor_ab_segment_version_LENGTH_ErrorCount
          ,le.major_ma_segment_version_ALLOW_ErrorCount,le.major_ma_segment_version_LENGTH_ErrorCount
          ,le.minor_ma_segment_version_ALLOW_ErrorCount,le.minor_ma_segment_version_LENGTH_ErrorCount
          ,le.major_ad_segment_version_ALLOW_ErrorCount,le.major_ad_segment_version_LENGTH_ErrorCount
          ,le.minor_ad_segment_version_ALLOW_ErrorCount,le.minor_ad_segment_version_LENGTH_ErrorCount
          ,le.major_pn_segment_version_ALLOW_ErrorCount,le.major_pn_segment_version_LENGTH_ErrorCount
          ,le.minor_pn_segment_version_ALLOW_ErrorCount,le.minor_pn_segment_version_LENGTH_ErrorCount
          ,le.major_ti_segment_version_ALLOW_ErrorCount,le.major_ti_segment_version_LENGTH_ErrorCount
          ,le.minor_ti_segment_version_ALLOW_ErrorCount,le.minor_ti_segment_version_LENGTH_ErrorCount
          ,le.major_is_segment_version_ALLOW_ErrorCount,le.major_is_segment_version_LENGTH_ErrorCount
          ,le.minor_is_segment_version_ALLOW_ErrorCount,le.minor_is_segment_version_LENGTH_ErrorCount
          ,le.major_bs_segment_version_ALLOW_ErrorCount,le.major_bs_segment_version_LENGTH_ErrorCount
          ,le.minor_bs_segment_version_ALLOW_ErrorCount,le.minor_bs_segment_version_LENGTH_ErrorCount
          ,le.major_bi_segment_version_ALLOW_ErrorCount,le.major_bi_segment_version_LENGTH_ErrorCount
          ,le.minor_bi_segment_version_ALLOW_ErrorCount,le.minor_bi_segment_version_LENGTH_ErrorCount
          ,le.major_cl_segment_version_ALLOW_ErrorCount,le.major_cl_segment_version_LENGTH_ErrorCount
          ,le.minor_cl_segment_version_ALLOW_ErrorCount,le.minor_cl_segment_version_LENGTH_ErrorCount
          ,le.major_ms_segment_version_ALLOW_ErrorCount,le.major_ms_segment_version_LENGTH_ErrorCount
          ,le.minor_ms_segment_version_ALLOW_ErrorCount,le.minor_ms_segment_version_LENGTH_ErrorCount
          ,le.major_ah_segment_version_ALLOW_ErrorCount,le.major_ah_segment_version_LENGTH_ErrorCount
          ,le.minor_ah_segment_version_ALLOW_ErrorCount,le.minor_ah_segment_version_LENGTH_ErrorCount
          ,le.major_zz_segment_version_ALLOW_ErrorCount,le.major_zz_segment_version_LENGTH_ErrorCount
          ,le.minor_zz_segment_version_ALLOW_ErrorCount,le.minor_zz_segment_version_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.segment_identifier_ENUM_ErrorCount
          ,le.file_sequence_number_ALLOW_ErrorCount,le.file_sequence_number_LENGTH_ErrorCount
          ,le.sbfe_contributor_number_ALLOW_ErrorCount,le.sbfe_contributor_number_CUSTOM_ErrorCount,le.sbfe_contributor_number_LENGTH_ErrorCount
          ,le.extracted_date_ALLOW_ErrorCount,le.extracted_date_CUSTOM_ErrorCount,le.extracted_date_LENGTH_ErrorCount
          ,le.cycle_end_date_ALLOW_ErrorCount,le.cycle_end_date_CUSTOM_ErrorCount,le.cycle_end_date_LENGTH_ErrorCount
          ,le.cycle_number_ALLOW_ErrorCount
          ,le.cycle_length_ALLOW_ErrorCount
          ,le.file_correction_indicator_ENUM_ErrorCount
          ,le.overall_file_format_version_ALLOW_ErrorCount,le.overall_file_format_version_LENGTH_ErrorCount
          ,le.major_aa_segment_version_ALLOW_ErrorCount,le.major_aa_segment_version_LENGTH_ErrorCount
          ,le.minor_aa_segment_version_ALLOW_ErrorCount,le.minor_aa_segment_version_LENGTH_ErrorCount
          ,le.major_ab_segment_version_ALLOW_ErrorCount,le.major_ab_segment_version_LENGTH_ErrorCount
          ,le.minor_ab_segment_version_ALLOW_ErrorCount,le.minor_ab_segment_version_LENGTH_ErrorCount
          ,le.major_ma_segment_version_ALLOW_ErrorCount,le.major_ma_segment_version_LENGTH_ErrorCount
          ,le.minor_ma_segment_version_ALLOW_ErrorCount,le.minor_ma_segment_version_LENGTH_ErrorCount
          ,le.major_ad_segment_version_ALLOW_ErrorCount,le.major_ad_segment_version_LENGTH_ErrorCount
          ,le.minor_ad_segment_version_ALLOW_ErrorCount,le.minor_ad_segment_version_LENGTH_ErrorCount
          ,le.major_pn_segment_version_ALLOW_ErrorCount,le.major_pn_segment_version_LENGTH_ErrorCount
          ,le.minor_pn_segment_version_ALLOW_ErrorCount,le.minor_pn_segment_version_LENGTH_ErrorCount
          ,le.major_ti_segment_version_ALLOW_ErrorCount,le.major_ti_segment_version_LENGTH_ErrorCount
          ,le.minor_ti_segment_version_ALLOW_ErrorCount,le.minor_ti_segment_version_LENGTH_ErrorCount
          ,le.major_is_segment_version_ALLOW_ErrorCount,le.major_is_segment_version_LENGTH_ErrorCount
          ,le.minor_is_segment_version_ALLOW_ErrorCount,le.minor_is_segment_version_LENGTH_ErrorCount
          ,le.major_bs_segment_version_ALLOW_ErrorCount,le.major_bs_segment_version_LENGTH_ErrorCount
          ,le.minor_bs_segment_version_ALLOW_ErrorCount,le.minor_bs_segment_version_LENGTH_ErrorCount
          ,le.major_bi_segment_version_ALLOW_ErrorCount,le.major_bi_segment_version_LENGTH_ErrorCount
          ,le.minor_bi_segment_version_ALLOW_ErrorCount,le.minor_bi_segment_version_LENGTH_ErrorCount
          ,le.major_cl_segment_version_ALLOW_ErrorCount,le.major_cl_segment_version_LENGTH_ErrorCount
          ,le.minor_cl_segment_version_ALLOW_ErrorCount,le.minor_cl_segment_version_LENGTH_ErrorCount
          ,le.major_ms_segment_version_ALLOW_ErrorCount,le.major_ms_segment_version_LENGTH_ErrorCount
          ,le.minor_ms_segment_version_ALLOW_ErrorCount,le.minor_ms_segment_version_LENGTH_ErrorCount
          ,le.major_ah_segment_version_ALLOW_ErrorCount,le.major_ah_segment_version_LENGTH_ErrorCount
          ,le.minor_ah_segment_version_ALLOW_ErrorCount,le.minor_ah_segment_version_LENGTH_ErrorCount
          ,le.major_zz_segment_version_ALLOW_ErrorCount,le.major_zz_segment_version_LENGTH_ErrorCount
          ,le.minor_zz_segment_version_ALLOW_ErrorCount,le.minor_zz_segment_version_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,69,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT31.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT31.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
