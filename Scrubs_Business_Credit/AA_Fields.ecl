IMPORT ut,SALT31;
IMPORT scrubs_business_credit,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT AA_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_segment_identifier','invalid_file_sequence_number','invalid_sbfe_contributor_num','invalid_extracted_date','invalid_cycle_end_date','invalid_cycle_number','invalid_cycle_length','invalid_file_correction_indicator','invalid_overall_file_format_version','invalid_major_aa_segment_version','invalid_minor_aa_segment_version');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'invalid_segment_identifier' => 1,'invalid_file_sequence_number' => 2,'invalid_sbfe_contributor_num' => 3,'invalid_extracted_date' => 4,'invalid_cycle_end_date' => 5,'invalid_cycle_number' => 6,'invalid_cycle_length' => 7,'invalid_file_correction_indicator' => 8,'invalid_overall_file_format_version' => 9,'invalid_major_aa_segment_version' => 10,'invalid_minor_aa_segment_version' => 11,0);
EXPORT MakeFT_invalid_segment_identifier(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment_identifier(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['AA','AA']);
EXPORT InValidMessageFT_invalid_segment_identifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('AA|AA'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_file_sequence_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_sequence_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_file_sequence_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_sbfe_contributor_num(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_sbfe_contributor_num(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'))),~scrubs_business_credit.fn_invalid_SBFEContributorNum(s)>0,~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_sbfe_contributor_num(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _'),SALT31.HygieneErrors.CustomFail('scrubs_business_credit.fn_invalid_SBFEContributorNum'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_extracted_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_extracted_date(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_extracted_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT31.HygieneErrors.NotLength('8'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_cycle_end_date(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cycle_end_date(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_cycle_end_date(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT31.HygieneErrors.NotLength('8,0'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_cycle_number(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cycle_number(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_cycle_number(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_cycle_length(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_cycle_length(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_cycle_length(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_file_correction_indicator(SALT31.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_file_correction_indicator(SALT31.StrType s) := WHICH(((SALT31.StrType) s) NOT IN ['001','002','003','004','']);
EXPORT InValidMessageFT_invalid_file_correction_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInEnum('001|002|003|004|'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_overall_file_format_version(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_overall_file_format_version(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_overall_file_format_version(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_major_aa_segment_version(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_major_aa_segment_version(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_major_aa_segment_version(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_invalid_minor_aa_segment_version(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_minor_aa_segment_version(SALT31.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_minor_aa_segment_version(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotInChars('0123456789'),SALT31.HygieneErrors.NotLength('1..'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'segment_identifier','file_sequence_number','sbfe_contributor_number','extracted_date','cycle_end_date','cycle_number','cycle_length','file_correction_indicator','overall_file_format_version','major_aa_segment_version','minor_aa_segment_version','major_ab_segment_version','minor_ab_segment_version','major_ma_segment_version','minor_ma_segment_version','major_ad_segment_version','minor_ad_segment_version','major_pn_segment_version','minor_pn_segment_version','major_ti_segment_version','minor_ti_segment_version','major_is_segment_version','minor_is_segment_version','major_bs_segment_version','minor_bs_segment_version','major_bi_segment_version','minor_bi_segment_version','major_cl_segment_version','minor_cl_segment_version','major_ms_segment_version','minor_ms_segment_version','major_ah_segment_version','minor_ah_segment_version','major_zz_segment_version','minor_zz_segment_version');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'segment_identifier' => 1,'file_sequence_number' => 2,'sbfe_contributor_number' => 3,'extracted_date' => 4,'cycle_end_date' => 5,'cycle_number' => 6,'cycle_length' => 7,'file_correction_indicator' => 8,'overall_file_format_version' => 9,'major_aa_segment_version' => 10,'minor_aa_segment_version' => 11,'major_ab_segment_version' => 12,'minor_ab_segment_version' => 13,'major_ma_segment_version' => 14,'minor_ma_segment_version' => 15,'major_ad_segment_version' => 16,'minor_ad_segment_version' => 17,'major_pn_segment_version' => 18,'minor_pn_segment_version' => 19,'major_ti_segment_version' => 20,'minor_ti_segment_version' => 21,'major_is_segment_version' => 22,'minor_is_segment_version' => 23,'major_bs_segment_version' => 24,'minor_bs_segment_version' => 25,'major_bi_segment_version' => 26,'minor_bi_segment_version' => 27,'major_cl_segment_version' => 28,'minor_cl_segment_version' => 29,'major_ms_segment_version' => 30,'minor_ms_segment_version' => 31,'major_ah_segment_version' => 32,'minor_ah_segment_version' => 33,'major_zz_segment_version' => 34,'minor_zz_segment_version' => 35,0);
//Individual field level validation
EXPORT Make_segment_identifier(SALT31.StrType s0) := MakeFT_invalid_segment_identifier(s0);
EXPORT InValid_segment_identifier(SALT31.StrType s) := InValidFT_invalid_segment_identifier(s);
EXPORT InValidMessage_segment_identifier(UNSIGNED1 wh) := InValidMessageFT_invalid_segment_identifier(wh);
EXPORT Make_file_sequence_number(SALT31.StrType s0) := MakeFT_invalid_file_sequence_number(s0);
EXPORT InValid_file_sequence_number(SALT31.StrType s) := InValidFT_invalid_file_sequence_number(s);
EXPORT InValidMessage_file_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_file_sequence_number(wh);
EXPORT Make_sbfe_contributor_number(SALT31.StrType s0) := MakeFT_invalid_sbfe_contributor_num(s0);
EXPORT InValid_sbfe_contributor_number(SALT31.StrType s) := InValidFT_invalid_sbfe_contributor_num(s);
EXPORT InValidMessage_sbfe_contributor_number(UNSIGNED1 wh) := InValidMessageFT_invalid_sbfe_contributor_num(wh);
EXPORT Make_extracted_date(SALT31.StrType s0) := MakeFT_invalid_extracted_date(s0);
EXPORT InValid_extracted_date(SALT31.StrType s) := InValidFT_invalid_extracted_date(s);
EXPORT InValidMessage_extracted_date(UNSIGNED1 wh) := InValidMessageFT_invalid_extracted_date(wh);
EXPORT Make_cycle_end_date(SALT31.StrType s0) := MakeFT_invalid_cycle_end_date(s0);
EXPORT InValid_cycle_end_date(SALT31.StrType s) := InValidFT_invalid_cycle_end_date(s);
EXPORT InValidMessage_cycle_end_date(UNSIGNED1 wh) := InValidMessageFT_invalid_cycle_end_date(wh);
EXPORT Make_cycle_number(SALT31.StrType s0) := MakeFT_invalid_cycle_number(s0);
EXPORT InValid_cycle_number(SALT31.StrType s) := InValidFT_invalid_cycle_number(s);
EXPORT InValidMessage_cycle_number(UNSIGNED1 wh) := InValidMessageFT_invalid_cycle_number(wh);
EXPORT Make_cycle_length(SALT31.StrType s0) := MakeFT_invalid_cycle_length(s0);
EXPORT InValid_cycle_length(SALT31.StrType s) := InValidFT_invalid_cycle_length(s);
EXPORT InValidMessage_cycle_length(UNSIGNED1 wh) := InValidMessageFT_invalid_cycle_length(wh);
EXPORT Make_file_correction_indicator(SALT31.StrType s0) := MakeFT_invalid_file_correction_indicator(s0);
EXPORT InValid_file_correction_indicator(SALT31.StrType s) := InValidFT_invalid_file_correction_indicator(s);
EXPORT InValidMessage_file_correction_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_file_correction_indicator(wh);
EXPORT Make_overall_file_format_version(SALT31.StrType s0) := MakeFT_invalid_overall_file_format_version(s0);
EXPORT InValid_overall_file_format_version(SALT31.StrType s) := InValidFT_invalid_overall_file_format_version(s);
EXPORT InValidMessage_overall_file_format_version(UNSIGNED1 wh) := InValidMessageFT_invalid_overall_file_format_version(wh);
EXPORT Make_major_aa_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_aa_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_aa_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_aa_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_aa_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_aa_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_ab_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_ab_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_ab_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_ab_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_ab_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_ab_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_ma_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_ma_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_ma_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_ma_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_ma_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_ma_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_ad_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_ad_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_ad_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_ad_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_ad_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_ad_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_pn_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_pn_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_pn_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_pn_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_pn_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_pn_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_ti_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_ti_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_ti_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_ti_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_ti_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_ti_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_is_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_is_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_is_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_is_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_is_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_is_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_bs_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_bs_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_bs_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_bs_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_bs_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_bs_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_bi_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_bi_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_bi_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_bi_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_bi_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_bi_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_cl_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_cl_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_cl_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_cl_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_cl_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_cl_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_ms_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_ms_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_ms_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_ms_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_ms_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_ms_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_ah_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_ah_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_ah_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_ah_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_ah_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_ah_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
EXPORT Make_major_zz_segment_version(SALT31.StrType s0) := MakeFT_invalid_major_aa_segment_version(s0);
EXPORT InValid_major_zz_segment_version(SALT31.StrType s) := InValidFT_invalid_major_aa_segment_version(s);
EXPORT InValidMessage_major_zz_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_major_aa_segment_version(wh);
EXPORT Make_minor_zz_segment_version(SALT31.StrType s0) := MakeFT_invalid_minor_aa_segment_version(s0);
EXPORT InValid_minor_zz_segment_version(SALT31.StrType s) := InValidFT_invalid_minor_aa_segment_version(s);
EXPORT InValidMessage_minor_zz_segment_version(UNSIGNED1 wh) := InValidMessageFT_invalid_minor_aa_segment_version(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_Business_Credit;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_segment_identifier;
    BOOLEAN Diff_file_sequence_number;
    BOOLEAN Diff_sbfe_contributor_number;
    BOOLEAN Diff_extracted_date;
    BOOLEAN Diff_cycle_end_date;
    BOOLEAN Diff_cycle_number;
    BOOLEAN Diff_cycle_length;
    BOOLEAN Diff_file_correction_indicator;
    BOOLEAN Diff_overall_file_format_version;
    BOOLEAN Diff_major_aa_segment_version;
    BOOLEAN Diff_minor_aa_segment_version;
    BOOLEAN Diff_major_ab_segment_version;
    BOOLEAN Diff_minor_ab_segment_version;
    BOOLEAN Diff_major_ma_segment_version;
    BOOLEAN Diff_minor_ma_segment_version;
    BOOLEAN Diff_major_ad_segment_version;
    BOOLEAN Diff_minor_ad_segment_version;
    BOOLEAN Diff_major_pn_segment_version;
    BOOLEAN Diff_minor_pn_segment_version;
    BOOLEAN Diff_major_ti_segment_version;
    BOOLEAN Diff_minor_ti_segment_version;
    BOOLEAN Diff_major_is_segment_version;
    BOOLEAN Diff_minor_is_segment_version;
    BOOLEAN Diff_major_bs_segment_version;
    BOOLEAN Diff_minor_bs_segment_version;
    BOOLEAN Diff_major_bi_segment_version;
    BOOLEAN Diff_minor_bi_segment_version;
    BOOLEAN Diff_major_cl_segment_version;
    BOOLEAN Diff_minor_cl_segment_version;
    BOOLEAN Diff_major_ms_segment_version;
    BOOLEAN Diff_minor_ms_segment_version;
    BOOLEAN Diff_major_ah_segment_version;
    BOOLEAN Diff_minor_ah_segment_version;
    BOOLEAN Diff_major_zz_segment_version;
    BOOLEAN Diff_minor_zz_segment_version;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_segment_identifier := le.segment_identifier <> ri.segment_identifier;
    SELF.Diff_file_sequence_number := le.file_sequence_number <> ri.file_sequence_number;
    SELF.Diff_sbfe_contributor_number := le.sbfe_contributor_number <> ri.sbfe_contributor_number;
    SELF.Diff_extracted_date := le.extracted_date <> ri.extracted_date;
    SELF.Diff_cycle_end_date := le.cycle_end_date <> ri.cycle_end_date;
    SELF.Diff_cycle_number := le.cycle_number <> ri.cycle_number;
    SELF.Diff_cycle_length := le.cycle_length <> ri.cycle_length;
    SELF.Diff_file_correction_indicator := le.file_correction_indicator <> ri.file_correction_indicator;
    SELF.Diff_overall_file_format_version := le.overall_file_format_version <> ri.overall_file_format_version;
    SELF.Diff_major_aa_segment_version := le.major_aa_segment_version <> ri.major_aa_segment_version;
    SELF.Diff_minor_aa_segment_version := le.minor_aa_segment_version <> ri.minor_aa_segment_version;
    SELF.Diff_major_ab_segment_version := le.major_ab_segment_version <> ri.major_ab_segment_version;
    SELF.Diff_minor_ab_segment_version := le.minor_ab_segment_version <> ri.minor_ab_segment_version;
    SELF.Diff_major_ma_segment_version := le.major_ma_segment_version <> ri.major_ma_segment_version;
    SELF.Diff_minor_ma_segment_version := le.minor_ma_segment_version <> ri.minor_ma_segment_version;
    SELF.Diff_major_ad_segment_version := le.major_ad_segment_version <> ri.major_ad_segment_version;
    SELF.Diff_minor_ad_segment_version := le.minor_ad_segment_version <> ri.minor_ad_segment_version;
    SELF.Diff_major_pn_segment_version := le.major_pn_segment_version <> ri.major_pn_segment_version;
    SELF.Diff_minor_pn_segment_version := le.minor_pn_segment_version <> ri.minor_pn_segment_version;
    SELF.Diff_major_ti_segment_version := le.major_ti_segment_version <> ri.major_ti_segment_version;
    SELF.Diff_minor_ti_segment_version := le.minor_ti_segment_version <> ri.minor_ti_segment_version;
    SELF.Diff_major_is_segment_version := le.major_is_segment_version <> ri.major_is_segment_version;
    SELF.Diff_minor_is_segment_version := le.minor_is_segment_version <> ri.minor_is_segment_version;
    SELF.Diff_major_bs_segment_version := le.major_bs_segment_version <> ri.major_bs_segment_version;
    SELF.Diff_minor_bs_segment_version := le.minor_bs_segment_version <> ri.minor_bs_segment_version;
    SELF.Diff_major_bi_segment_version := le.major_bi_segment_version <> ri.major_bi_segment_version;
    SELF.Diff_minor_bi_segment_version := le.minor_bi_segment_version <> ri.minor_bi_segment_version;
    SELF.Diff_major_cl_segment_version := le.major_cl_segment_version <> ri.major_cl_segment_version;
    SELF.Diff_minor_cl_segment_version := le.minor_cl_segment_version <> ri.minor_cl_segment_version;
    SELF.Diff_major_ms_segment_version := le.major_ms_segment_version <> ri.major_ms_segment_version;
    SELF.Diff_minor_ms_segment_version := le.minor_ms_segment_version <> ri.minor_ms_segment_version;
    SELF.Diff_major_ah_segment_version := le.major_ah_segment_version <> ri.major_ah_segment_version;
    SELF.Diff_minor_ah_segment_version := le.minor_ah_segment_version <> ri.minor_ah_segment_version;
    SELF.Diff_major_zz_segment_version := le.major_zz_segment_version <> ri.major_zz_segment_version;
    SELF.Diff_minor_zz_segment_version := le.minor_zz_segment_version <> ri.minor_zz_segment_version;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_segment_identifier,1,0)+ IF( SELF.Diff_file_sequence_number,1,0)+ IF( SELF.Diff_sbfe_contributor_number,1,0)+ IF( SELF.Diff_extracted_date,1,0)+ IF( SELF.Diff_cycle_end_date,1,0)+ IF( SELF.Diff_cycle_number,1,0)+ IF( SELF.Diff_cycle_length,1,0)+ IF( SELF.Diff_file_correction_indicator,1,0)+ IF( SELF.Diff_overall_file_format_version,1,0)+ IF( SELF.Diff_major_aa_segment_version,1,0)+ IF( SELF.Diff_minor_aa_segment_version,1,0)+ IF( SELF.Diff_major_ab_segment_version,1,0)+ IF( SELF.Diff_minor_ab_segment_version,1,0)+ IF( SELF.Diff_major_ma_segment_version,1,0)+ IF( SELF.Diff_minor_ma_segment_version,1,0)+ IF( SELF.Diff_major_ad_segment_version,1,0)+ IF( SELF.Diff_minor_ad_segment_version,1,0)+ IF( SELF.Diff_major_pn_segment_version,1,0)+ IF( SELF.Diff_minor_pn_segment_version,1,0)+ IF( SELF.Diff_major_ti_segment_version,1,0)+ IF( SELF.Diff_minor_ti_segment_version,1,0)+ IF( SELF.Diff_major_is_segment_version,1,0)+ IF( SELF.Diff_minor_is_segment_version,1,0)+ IF( SELF.Diff_major_bs_segment_version,1,0)+ IF( SELF.Diff_minor_bs_segment_version,1,0)+ IF( SELF.Diff_major_bi_segment_version,1,0)+ IF( SELF.Diff_minor_bi_segment_version,1,0)+ IF( SELF.Diff_major_cl_segment_version,1,0)+ IF( SELF.Diff_minor_cl_segment_version,1,0)+ IF( SELF.Diff_major_ms_segment_version,1,0)+ IF( SELF.Diff_minor_ms_segment_version,1,0)+ IF( SELF.Diff_major_ah_segment_version,1,0)+ IF( SELF.Diff_minor_ah_segment_version,1,0)+ IF( SELF.Diff_major_zz_segment_version,1,0)+ IF( SELF.Diff_minor_zz_segment_version,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_segment_identifier := COUNT(GROUP,%Closest%.Diff_segment_identifier);
    Count_Diff_file_sequence_number := COUNT(GROUP,%Closest%.Diff_file_sequence_number);
    Count_Diff_sbfe_contributor_number := COUNT(GROUP,%Closest%.Diff_sbfe_contributor_number);
    Count_Diff_extracted_date := COUNT(GROUP,%Closest%.Diff_extracted_date);
    Count_Diff_cycle_end_date := COUNT(GROUP,%Closest%.Diff_cycle_end_date);
    Count_Diff_cycle_number := COUNT(GROUP,%Closest%.Diff_cycle_number);
    Count_Diff_cycle_length := COUNT(GROUP,%Closest%.Diff_cycle_length);
    Count_Diff_file_correction_indicator := COUNT(GROUP,%Closest%.Diff_file_correction_indicator);
    Count_Diff_overall_file_format_version := COUNT(GROUP,%Closest%.Diff_overall_file_format_version);
    Count_Diff_major_aa_segment_version := COUNT(GROUP,%Closest%.Diff_major_aa_segment_version);
    Count_Diff_minor_aa_segment_version := COUNT(GROUP,%Closest%.Diff_minor_aa_segment_version);
    Count_Diff_major_ab_segment_version := COUNT(GROUP,%Closest%.Diff_major_ab_segment_version);
    Count_Diff_minor_ab_segment_version := COUNT(GROUP,%Closest%.Diff_minor_ab_segment_version);
    Count_Diff_major_ma_segment_version := COUNT(GROUP,%Closest%.Diff_major_ma_segment_version);
    Count_Diff_minor_ma_segment_version := COUNT(GROUP,%Closest%.Diff_minor_ma_segment_version);
    Count_Diff_major_ad_segment_version := COUNT(GROUP,%Closest%.Diff_major_ad_segment_version);
    Count_Diff_minor_ad_segment_version := COUNT(GROUP,%Closest%.Diff_minor_ad_segment_version);
    Count_Diff_major_pn_segment_version := COUNT(GROUP,%Closest%.Diff_major_pn_segment_version);
    Count_Diff_minor_pn_segment_version := COUNT(GROUP,%Closest%.Diff_minor_pn_segment_version);
    Count_Diff_major_ti_segment_version := COUNT(GROUP,%Closest%.Diff_major_ti_segment_version);
    Count_Diff_minor_ti_segment_version := COUNT(GROUP,%Closest%.Diff_minor_ti_segment_version);
    Count_Diff_major_is_segment_version := COUNT(GROUP,%Closest%.Diff_major_is_segment_version);
    Count_Diff_minor_is_segment_version := COUNT(GROUP,%Closest%.Diff_minor_is_segment_version);
    Count_Diff_major_bs_segment_version := COUNT(GROUP,%Closest%.Diff_major_bs_segment_version);
    Count_Diff_minor_bs_segment_version := COUNT(GROUP,%Closest%.Diff_minor_bs_segment_version);
    Count_Diff_major_bi_segment_version := COUNT(GROUP,%Closest%.Diff_major_bi_segment_version);
    Count_Diff_minor_bi_segment_version := COUNT(GROUP,%Closest%.Diff_minor_bi_segment_version);
    Count_Diff_major_cl_segment_version := COUNT(GROUP,%Closest%.Diff_major_cl_segment_version);
    Count_Diff_minor_cl_segment_version := COUNT(GROUP,%Closest%.Diff_minor_cl_segment_version);
    Count_Diff_major_ms_segment_version := COUNT(GROUP,%Closest%.Diff_major_ms_segment_version);
    Count_Diff_minor_ms_segment_version := COUNT(GROUP,%Closest%.Diff_minor_ms_segment_version);
    Count_Diff_major_ah_segment_version := COUNT(GROUP,%Closest%.Diff_major_ah_segment_version);
    Count_Diff_minor_ah_segment_version := COUNT(GROUP,%Closest%.Diff_minor_ah_segment_version);
    Count_Diff_major_zz_segment_version := COUNT(GROUP,%Closest%.Diff_major_zz_segment_version);
    Count_Diff_minor_zz_segment_version := COUNT(GROUP,%Closest%.Diff_minor_zz_segment_version);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
