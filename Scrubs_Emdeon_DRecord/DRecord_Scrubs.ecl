IMPORT ut,SALT31;
EXPORT DRecord_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(DRecord_Layout_DRecord)
    UNSIGNED1 claim_num_Invalid;
    UNSIGNED1 claim_rec_type_Invalid;
    UNSIGNED1 diag_code9_Invalid;
    UNSIGNED1 diag_code10_Invalid;
    UNSIGNED1 diag_code11_Invalid;
    UNSIGNED1 diag_code12_Invalid;
    UNSIGNED1 diag_code13_Invalid;
    UNSIGNED1 diag_code14_Invalid;
    UNSIGNED1 diag_code15_Invalid;
    UNSIGNED1 diag_code16_Invalid;
    UNSIGNED1 diag_code17_Invalid;
    UNSIGNED1 diag_code18_Invalid;
    UNSIGNED1 diag_code19_Invalid;
    UNSIGNED1 diag_code20_Invalid;
    UNSIGNED1 diag_code21_Invalid;
    UNSIGNED1 diag_code22_Invalid;
    UNSIGNED1 diag_code23_Invalid;
    UNSIGNED1 diag_code24_Invalid;
    UNSIGNED1 other_proc7_Invalid;
    UNSIGNED1 other_proc8_Invalid;
    UNSIGNED1 other_proc9_Invalid;
    UNSIGNED1 other_proc10_Invalid;
    UNSIGNED1 other_proc11_Invalid;
    UNSIGNED1 other_proc12_Invalid;
    UNSIGNED1 other_proc13_Invalid;
    UNSIGNED1 other_proc14_Invalid;
    UNSIGNED1 other_proc15_Invalid;
    UNSIGNED1 other_proc16_Invalid;
    UNSIGNED1 other_proc17_Invalid;
    UNSIGNED1 other_proc18_Invalid;
    UNSIGNED1 other_proc19_Invalid;
    UNSIGNED1 other_proc20_Invalid;
    UNSIGNED1 other_proc21_Invalid;
    UNSIGNED1 other_proc22_Invalid;
    UNSIGNED1 claim_indicator_code_Invalid;
    UNSIGNED1 ref_prov_state_lic_Invalid;
    UNSIGNED1 ref_prov_upin_Invalid;
    UNSIGNED1 ref_prov_commercial_id_Invalid;
    UNSIGNED1 cob1_group_policy_num_Invalid;
    UNSIGNED1 cob1_group_name_Invalid;
    UNSIGNED1 cob1_ins_type_code_Invalid;
    UNSIGNED1 cob1_claim_filing_indicator_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(DRecord_Layout_DRecord)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(DRecord_Layout_DRecord) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.claim_num_Invalid := DRecord_Fields.InValid_claim_num((SALT31.StrType)le.claim_num);
    SELF.claim_rec_type_Invalid := DRecord_Fields.InValid_claim_rec_type((SALT31.StrType)le.claim_rec_type);
    SELF.diag_code9_Invalid := DRecord_Fields.InValid_diag_code9((SALT31.StrType)le.diag_code9);
    SELF.diag_code10_Invalid := DRecord_Fields.InValid_diag_code10((SALT31.StrType)le.diag_code10);
    SELF.diag_code11_Invalid := DRecord_Fields.InValid_diag_code11((SALT31.StrType)le.diag_code11);
    SELF.diag_code12_Invalid := DRecord_Fields.InValid_diag_code12((SALT31.StrType)le.diag_code12);
    SELF.diag_code13_Invalid := DRecord_Fields.InValid_diag_code13((SALT31.StrType)le.diag_code13);
    SELF.diag_code14_Invalid := DRecord_Fields.InValid_diag_code14((SALT31.StrType)le.diag_code14);
    SELF.diag_code15_Invalid := DRecord_Fields.InValid_diag_code15((SALT31.StrType)le.diag_code15);
    SELF.diag_code16_Invalid := DRecord_Fields.InValid_diag_code16((SALT31.StrType)le.diag_code16);
    SELF.diag_code17_Invalid := DRecord_Fields.InValid_diag_code17((SALT31.StrType)le.diag_code17);
    SELF.diag_code18_Invalid := DRecord_Fields.InValid_diag_code18((SALT31.StrType)le.diag_code18);
    SELF.diag_code19_Invalid := DRecord_Fields.InValid_diag_code19((SALT31.StrType)le.diag_code19);
    SELF.diag_code20_Invalid := DRecord_Fields.InValid_diag_code20((SALT31.StrType)le.diag_code20);
    SELF.diag_code21_Invalid := DRecord_Fields.InValid_diag_code21((SALT31.StrType)le.diag_code21);
    SELF.diag_code22_Invalid := DRecord_Fields.InValid_diag_code22((SALT31.StrType)le.diag_code22);
    SELF.diag_code23_Invalid := DRecord_Fields.InValid_diag_code23((SALT31.StrType)le.diag_code23);
    SELF.diag_code24_Invalid := DRecord_Fields.InValid_diag_code24((SALT31.StrType)le.diag_code24);
    SELF.other_proc7_Invalid := DRecord_Fields.InValid_other_proc7((SALT31.StrType)le.other_proc7);
    SELF.other_proc8_Invalid := DRecord_Fields.InValid_other_proc8((SALT31.StrType)le.other_proc8);
    SELF.other_proc9_Invalid := DRecord_Fields.InValid_other_proc9((SALT31.StrType)le.other_proc9);
    SELF.other_proc10_Invalid := DRecord_Fields.InValid_other_proc10((SALT31.StrType)le.other_proc10);
    SELF.other_proc11_Invalid := DRecord_Fields.InValid_other_proc11((SALT31.StrType)le.other_proc11);
    SELF.other_proc12_Invalid := DRecord_Fields.InValid_other_proc12((SALT31.StrType)le.other_proc12);
    SELF.other_proc13_Invalid := DRecord_Fields.InValid_other_proc13((SALT31.StrType)le.other_proc13);
    SELF.other_proc14_Invalid := DRecord_Fields.InValid_other_proc14((SALT31.StrType)le.other_proc14);
    SELF.other_proc15_Invalid := DRecord_Fields.InValid_other_proc15((SALT31.StrType)le.other_proc15);
    SELF.other_proc16_Invalid := DRecord_Fields.InValid_other_proc16((SALT31.StrType)le.other_proc16);
    SELF.other_proc17_Invalid := DRecord_Fields.InValid_other_proc17((SALT31.StrType)le.other_proc17);
    SELF.other_proc18_Invalid := DRecord_Fields.InValid_other_proc18((SALT31.StrType)le.other_proc18);
    SELF.other_proc19_Invalid := DRecord_Fields.InValid_other_proc19((SALT31.StrType)le.other_proc19);
    SELF.other_proc20_Invalid := DRecord_Fields.InValid_other_proc20((SALT31.StrType)le.other_proc20);
    SELF.other_proc21_Invalid := DRecord_Fields.InValid_other_proc21((SALT31.StrType)le.other_proc21);
    SELF.other_proc22_Invalid := DRecord_Fields.InValid_other_proc22((SALT31.StrType)le.other_proc22);
    SELF.claim_indicator_code_Invalid := DRecord_Fields.InValid_claim_indicator_code((SALT31.StrType)le.claim_indicator_code);
    SELF.ref_prov_state_lic_Invalid := DRecord_Fields.InValid_ref_prov_state_lic((SALT31.StrType)le.ref_prov_state_lic);
    SELF.ref_prov_upin_Invalid := DRecord_Fields.InValid_ref_prov_upin((SALT31.StrType)le.ref_prov_upin);
    SELF.ref_prov_commercial_id_Invalid := DRecord_Fields.InValid_ref_prov_commercial_id((SALT31.StrType)le.ref_prov_commercial_id);
    SELF.cob1_group_policy_num_Invalid := DRecord_Fields.InValid_cob1_group_policy_num((SALT31.StrType)le.cob1_group_policy_num);
    SELF.cob1_group_name_Invalid := DRecord_Fields.InValid_cob1_group_name((SALT31.StrType)le.cob1_group_name);
    SELF.cob1_ins_type_code_Invalid := DRecord_Fields.InValid_cob1_ins_type_code((SALT31.StrType)le.cob1_ins_type_code);
    SELF.cob1_claim_filing_indicator_Invalid := DRecord_Fields.InValid_cob1_claim_filing_indicator((SALT31.StrType)le.cob1_claim_filing_indicator);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.claim_num_Invalid << 0 ) + ( le.claim_rec_type_Invalid << 3 ) + ( le.diag_code9_Invalid << 6 ) + ( le.diag_code10_Invalid << 9 ) + ( le.diag_code11_Invalid << 12 ) + ( le.diag_code12_Invalid << 15 ) + ( le.diag_code13_Invalid << 18 ) + ( le.diag_code14_Invalid << 21 ) + ( le.diag_code15_Invalid << 24 ) + ( le.diag_code16_Invalid << 27 ) + ( le.diag_code17_Invalid << 30 ) + ( le.diag_code18_Invalid << 33 ) + ( le.diag_code19_Invalid << 36 ) + ( le.diag_code20_Invalid << 39 ) + ( le.diag_code21_Invalid << 42 ) + ( le.diag_code22_Invalid << 45 ) + ( le.diag_code23_Invalid << 48 ) + ( le.diag_code24_Invalid << 51 ) + ( le.other_proc7_Invalid << 54 ) + ( le.other_proc8_Invalid << 57 ) + ( le.other_proc9_Invalid << 60 );
    SELF.ScrubsBits2 := ( le.other_proc10_Invalid << 0 ) + ( le.other_proc11_Invalid << 3 ) + ( le.other_proc12_Invalid << 6 ) + ( le.other_proc13_Invalid << 9 ) + ( le.other_proc14_Invalid << 12 ) + ( le.other_proc15_Invalid << 15 ) + ( le.other_proc16_Invalid << 18 ) + ( le.other_proc17_Invalid << 21 ) + ( le.other_proc18_Invalid << 24 ) + ( le.other_proc19_Invalid << 27 ) + ( le.other_proc20_Invalid << 30 ) + ( le.other_proc21_Invalid << 33 ) + ( le.other_proc22_Invalid << 36 ) + ( le.claim_indicator_code_Invalid << 39 ) + ( le.ref_prov_state_lic_Invalid << 42 ) + ( le.ref_prov_upin_Invalid << 44 ) + ( le.ref_prov_commercial_id_Invalid << 47 ) + ( le.cob1_group_policy_num_Invalid << 49 ) + ( le.cob1_group_name_Invalid << 52 ) + ( le.cob1_ins_type_code_Invalid << 54 ) + ( le.cob1_claim_filing_indicator_Invalid << 57 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,DRecord_Layout_DRecord);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.claim_num_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.claim_rec_type_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.diag_code9_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.diag_code10_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.diag_code11_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.diag_code12_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.diag_code13_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.diag_code14_Invalid := (le.ScrubsBits1 >> 21) & 7;
    SELF.diag_code15_Invalid := (le.ScrubsBits1 >> 24) & 7;
    SELF.diag_code16_Invalid := (le.ScrubsBits1 >> 27) & 7;
    SELF.diag_code17_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.diag_code18_Invalid := (le.ScrubsBits1 >> 33) & 7;
    SELF.diag_code19_Invalid := (le.ScrubsBits1 >> 36) & 7;
    SELF.diag_code20_Invalid := (le.ScrubsBits1 >> 39) & 7;
    SELF.diag_code21_Invalid := (le.ScrubsBits1 >> 42) & 7;
    SELF.diag_code22_Invalid := (le.ScrubsBits1 >> 45) & 7;
    SELF.diag_code23_Invalid := (le.ScrubsBits1 >> 48) & 7;
    SELF.diag_code24_Invalid := (le.ScrubsBits1 >> 51) & 7;
    SELF.other_proc7_Invalid := (le.ScrubsBits1 >> 54) & 7;
    SELF.other_proc8_Invalid := (le.ScrubsBits1 >> 57) & 7;
    SELF.other_proc9_Invalid := (le.ScrubsBits1 >> 60) & 7;
    SELF.other_proc10_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.other_proc11_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.other_proc12_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.other_proc13_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.other_proc14_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.other_proc15_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.other_proc16_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.other_proc17_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.other_proc18_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.other_proc19_Invalid := (le.ScrubsBits2 >> 27) & 7;
    SELF.other_proc20_Invalid := (le.ScrubsBits2 >> 30) & 7;
    SELF.other_proc21_Invalid := (le.ScrubsBits2 >> 33) & 7;
    SELF.other_proc22_Invalid := (le.ScrubsBits2 >> 36) & 7;
    SELF.claim_indicator_code_Invalid := (le.ScrubsBits2 >> 39) & 7;
    SELF.ref_prov_state_lic_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.ref_prov_upin_Invalid := (le.ScrubsBits2 >> 44) & 7;
    SELF.ref_prov_commercial_id_Invalid := (le.ScrubsBits2 >> 47) & 3;
    SELF.cob1_group_policy_num_Invalid := (le.ScrubsBits2 >> 49) & 7;
    SELF.cob1_group_name_Invalid := (le.ScrubsBits2 >> 52) & 3;
    SELF.cob1_ins_type_code_Invalid := (le.ScrubsBits2 >> 54) & 7;
    SELF.cob1_claim_filing_indicator_Invalid := (le.ScrubsBits2 >> 57) & 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    claim_num_LEFTTRIM_ErrorCount := COUNT(GROUP,h.claim_num_Invalid=1);
    claim_num_ALLOW_ErrorCount := COUNT(GROUP,h.claim_num_Invalid=2);
    claim_num_LENGTH_ErrorCount := COUNT(GROUP,h.claim_num_Invalid=3);
    claim_num_WORDS_ErrorCount := COUNT(GROUP,h.claim_num_Invalid=4);
    claim_num_Total_ErrorCount := COUNT(GROUP,h.claim_num_Invalid>0);
    claim_rec_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.claim_rec_type_Invalid=1);
    claim_rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.claim_rec_type_Invalid=2);
    claim_rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.claim_rec_type_Invalid=3);
    claim_rec_type_WORDS_ErrorCount := COUNT(GROUP,h.claim_rec_type_Invalid=4);
    claim_rec_type_Total_ErrorCount := COUNT(GROUP,h.claim_rec_type_Invalid>0);
    diag_code9_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code9_Invalid=1);
    diag_code9_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code9_Invalid=2);
    diag_code9_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code9_Invalid=3);
    diag_code9_WORDS_ErrorCount := COUNT(GROUP,h.diag_code9_Invalid=4);
    diag_code9_Total_ErrorCount := COUNT(GROUP,h.diag_code9_Invalid>0);
    diag_code10_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code10_Invalid=1);
    diag_code10_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code10_Invalid=2);
    diag_code10_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code10_Invalid=3);
    diag_code10_WORDS_ErrorCount := COUNT(GROUP,h.diag_code10_Invalid=4);
    diag_code10_Total_ErrorCount := COUNT(GROUP,h.diag_code10_Invalid>0);
    diag_code11_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code11_Invalid=1);
    diag_code11_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code11_Invalid=2);
    diag_code11_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code11_Invalid=3);
    diag_code11_WORDS_ErrorCount := COUNT(GROUP,h.diag_code11_Invalid=4);
    diag_code11_Total_ErrorCount := COUNT(GROUP,h.diag_code11_Invalid>0);
    diag_code12_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code12_Invalid=1);
    diag_code12_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code12_Invalid=2);
    diag_code12_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code12_Invalid=3);
    diag_code12_WORDS_ErrorCount := COUNT(GROUP,h.diag_code12_Invalid=4);
    diag_code12_Total_ErrorCount := COUNT(GROUP,h.diag_code12_Invalid>0);
    diag_code13_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code13_Invalid=1);
    diag_code13_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code13_Invalid=2);
    diag_code13_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code13_Invalid=3);
    diag_code13_WORDS_ErrorCount := COUNT(GROUP,h.diag_code13_Invalid=4);
    diag_code13_Total_ErrorCount := COUNT(GROUP,h.diag_code13_Invalid>0);
    diag_code14_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code14_Invalid=1);
    diag_code14_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code14_Invalid=2);
    diag_code14_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code14_Invalid=3);
    diag_code14_WORDS_ErrorCount := COUNT(GROUP,h.diag_code14_Invalid=4);
    diag_code14_Total_ErrorCount := COUNT(GROUP,h.diag_code14_Invalid>0);
    diag_code15_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code15_Invalid=1);
    diag_code15_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code15_Invalid=2);
    diag_code15_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code15_Invalid=3);
    diag_code15_WORDS_ErrorCount := COUNT(GROUP,h.diag_code15_Invalid=4);
    diag_code15_Total_ErrorCount := COUNT(GROUP,h.diag_code15_Invalid>0);
    diag_code16_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code16_Invalid=1);
    diag_code16_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code16_Invalid=2);
    diag_code16_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code16_Invalid=3);
    diag_code16_WORDS_ErrorCount := COUNT(GROUP,h.diag_code16_Invalid=4);
    diag_code16_Total_ErrorCount := COUNT(GROUP,h.diag_code16_Invalid>0);
    diag_code17_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code17_Invalid=1);
    diag_code17_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code17_Invalid=2);
    diag_code17_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code17_Invalid=3);
    diag_code17_WORDS_ErrorCount := COUNT(GROUP,h.diag_code17_Invalid=4);
    diag_code17_Total_ErrorCount := COUNT(GROUP,h.diag_code17_Invalid>0);
    diag_code18_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code18_Invalid=1);
    diag_code18_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code18_Invalid=2);
    diag_code18_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code18_Invalid=3);
    diag_code18_WORDS_ErrorCount := COUNT(GROUP,h.diag_code18_Invalid=4);
    diag_code18_Total_ErrorCount := COUNT(GROUP,h.diag_code18_Invalid>0);
    diag_code19_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code19_Invalid=1);
    diag_code19_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code19_Invalid=2);
    diag_code19_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code19_Invalid=3);
    diag_code19_WORDS_ErrorCount := COUNT(GROUP,h.diag_code19_Invalid=4);
    diag_code19_Total_ErrorCount := COUNT(GROUP,h.diag_code19_Invalid>0);
    diag_code20_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code20_Invalid=1);
    diag_code20_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code20_Invalid=2);
    diag_code20_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code20_Invalid=3);
    diag_code20_WORDS_ErrorCount := COUNT(GROUP,h.diag_code20_Invalid=4);
    diag_code20_Total_ErrorCount := COUNT(GROUP,h.diag_code20_Invalid>0);
    diag_code21_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code21_Invalid=1);
    diag_code21_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code21_Invalid=2);
    diag_code21_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code21_Invalid=3);
    diag_code21_WORDS_ErrorCount := COUNT(GROUP,h.diag_code21_Invalid=4);
    diag_code21_Total_ErrorCount := COUNT(GROUP,h.diag_code21_Invalid>0);
    diag_code22_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code22_Invalid=1);
    diag_code22_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code22_Invalid=2);
    diag_code22_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code22_Invalid=3);
    diag_code22_WORDS_ErrorCount := COUNT(GROUP,h.diag_code22_Invalid=4);
    diag_code22_Total_ErrorCount := COUNT(GROUP,h.diag_code22_Invalid>0);
    diag_code23_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code23_Invalid=1);
    diag_code23_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code23_Invalid=2);
    diag_code23_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code23_Invalid=3);
    diag_code23_WORDS_ErrorCount := COUNT(GROUP,h.diag_code23_Invalid=4);
    diag_code23_Total_ErrorCount := COUNT(GROUP,h.diag_code23_Invalid>0);
    diag_code24_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code24_Invalid=1);
    diag_code24_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code24_Invalid=2);
    diag_code24_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code24_Invalid=3);
    diag_code24_WORDS_ErrorCount := COUNT(GROUP,h.diag_code24_Invalid=4);
    diag_code24_Total_ErrorCount := COUNT(GROUP,h.diag_code24_Invalid>0);
    other_proc7_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc7_Invalid=1);
    other_proc7_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc7_Invalid=2);
    other_proc7_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc7_Invalid=3);
    other_proc7_WORDS_ErrorCount := COUNT(GROUP,h.other_proc7_Invalid=4);
    other_proc7_Total_ErrorCount := COUNT(GROUP,h.other_proc7_Invalid>0);
    other_proc8_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc8_Invalid=1);
    other_proc8_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc8_Invalid=2);
    other_proc8_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc8_Invalid=3);
    other_proc8_WORDS_ErrorCount := COUNT(GROUP,h.other_proc8_Invalid=4);
    other_proc8_Total_ErrorCount := COUNT(GROUP,h.other_proc8_Invalid>0);
    other_proc9_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc9_Invalid=1);
    other_proc9_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc9_Invalid=2);
    other_proc9_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc9_Invalid=3);
    other_proc9_WORDS_ErrorCount := COUNT(GROUP,h.other_proc9_Invalid=4);
    other_proc9_Total_ErrorCount := COUNT(GROUP,h.other_proc9_Invalid>0);
    other_proc10_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc10_Invalid=1);
    other_proc10_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc10_Invalid=2);
    other_proc10_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc10_Invalid=3);
    other_proc10_WORDS_ErrorCount := COUNT(GROUP,h.other_proc10_Invalid=4);
    other_proc10_Total_ErrorCount := COUNT(GROUP,h.other_proc10_Invalid>0);
    other_proc11_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc11_Invalid=1);
    other_proc11_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc11_Invalid=2);
    other_proc11_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc11_Invalid=3);
    other_proc11_WORDS_ErrorCount := COUNT(GROUP,h.other_proc11_Invalid=4);
    other_proc11_Total_ErrorCount := COUNT(GROUP,h.other_proc11_Invalid>0);
    other_proc12_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc12_Invalid=1);
    other_proc12_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc12_Invalid=2);
    other_proc12_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc12_Invalid=3);
    other_proc12_WORDS_ErrorCount := COUNT(GROUP,h.other_proc12_Invalid=4);
    other_proc12_Total_ErrorCount := COUNT(GROUP,h.other_proc12_Invalid>0);
    other_proc13_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc13_Invalid=1);
    other_proc13_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc13_Invalid=2);
    other_proc13_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc13_Invalid=3);
    other_proc13_WORDS_ErrorCount := COUNT(GROUP,h.other_proc13_Invalid=4);
    other_proc13_Total_ErrorCount := COUNT(GROUP,h.other_proc13_Invalid>0);
    other_proc14_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc14_Invalid=1);
    other_proc14_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc14_Invalid=2);
    other_proc14_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc14_Invalid=3);
    other_proc14_WORDS_ErrorCount := COUNT(GROUP,h.other_proc14_Invalid=4);
    other_proc14_Total_ErrorCount := COUNT(GROUP,h.other_proc14_Invalid>0);
    other_proc15_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc15_Invalid=1);
    other_proc15_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc15_Invalid=2);
    other_proc15_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc15_Invalid=3);
    other_proc15_WORDS_ErrorCount := COUNT(GROUP,h.other_proc15_Invalid=4);
    other_proc15_Total_ErrorCount := COUNT(GROUP,h.other_proc15_Invalid>0);
    other_proc16_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc16_Invalid=1);
    other_proc16_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc16_Invalid=2);
    other_proc16_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc16_Invalid=3);
    other_proc16_WORDS_ErrorCount := COUNT(GROUP,h.other_proc16_Invalid=4);
    other_proc16_Total_ErrorCount := COUNT(GROUP,h.other_proc16_Invalid>0);
    other_proc17_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc17_Invalid=1);
    other_proc17_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc17_Invalid=2);
    other_proc17_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc17_Invalid=3);
    other_proc17_WORDS_ErrorCount := COUNT(GROUP,h.other_proc17_Invalid=4);
    other_proc17_Total_ErrorCount := COUNT(GROUP,h.other_proc17_Invalid>0);
    other_proc18_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc18_Invalid=1);
    other_proc18_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc18_Invalid=2);
    other_proc18_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc18_Invalid=3);
    other_proc18_WORDS_ErrorCount := COUNT(GROUP,h.other_proc18_Invalid=4);
    other_proc18_Total_ErrorCount := COUNT(GROUP,h.other_proc18_Invalid>0);
    other_proc19_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc19_Invalid=1);
    other_proc19_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc19_Invalid=2);
    other_proc19_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc19_Invalid=3);
    other_proc19_WORDS_ErrorCount := COUNT(GROUP,h.other_proc19_Invalid=4);
    other_proc19_Total_ErrorCount := COUNT(GROUP,h.other_proc19_Invalid>0);
    other_proc20_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc20_Invalid=1);
    other_proc20_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc20_Invalid=2);
    other_proc20_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc20_Invalid=3);
    other_proc20_WORDS_ErrorCount := COUNT(GROUP,h.other_proc20_Invalid=4);
    other_proc20_Total_ErrorCount := COUNT(GROUP,h.other_proc20_Invalid>0);
    other_proc21_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc21_Invalid=1);
    other_proc21_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc21_Invalid=2);
    other_proc21_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc21_Invalid=3);
    other_proc21_WORDS_ErrorCount := COUNT(GROUP,h.other_proc21_Invalid=4);
    other_proc21_Total_ErrorCount := COUNT(GROUP,h.other_proc21_Invalid>0);
    other_proc22_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc22_Invalid=1);
    other_proc22_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc22_Invalid=2);
    other_proc22_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc22_Invalid=3);
    other_proc22_WORDS_ErrorCount := COUNT(GROUP,h.other_proc22_Invalid=4);
    other_proc22_Total_ErrorCount := COUNT(GROUP,h.other_proc22_Invalid>0);
    claim_indicator_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.claim_indicator_code_Invalid=1);
    claim_indicator_code_ALLOW_ErrorCount := COUNT(GROUP,h.claim_indicator_code_Invalid=2);
    claim_indicator_code_LENGTH_ErrorCount := COUNT(GROUP,h.claim_indicator_code_Invalid=3);
    claim_indicator_code_WORDS_ErrorCount := COUNT(GROUP,h.claim_indicator_code_Invalid=4);
    claim_indicator_code_Total_ErrorCount := COUNT(GROUP,h.claim_indicator_code_Invalid>0);
    ref_prov_state_lic_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ref_prov_state_lic_Invalid=1);
    ref_prov_state_lic_WORDS_ErrorCount := COUNT(GROUP,h.ref_prov_state_lic_Invalid=2);
    ref_prov_state_lic_Total_ErrorCount := COUNT(GROUP,h.ref_prov_state_lic_Invalid>0);
    ref_prov_upin_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ref_prov_upin_Invalid=1);
    ref_prov_upin_ALLOW_ErrorCount := COUNT(GROUP,h.ref_prov_upin_Invalid=2);
    ref_prov_upin_LENGTH_ErrorCount := COUNT(GROUP,h.ref_prov_upin_Invalid=3);
    ref_prov_upin_WORDS_ErrorCount := COUNT(GROUP,h.ref_prov_upin_Invalid=4);
    ref_prov_upin_Total_ErrorCount := COUNT(GROUP,h.ref_prov_upin_Invalid>0);
    ref_prov_commercial_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ref_prov_commercial_id_Invalid=1);
    ref_prov_commercial_id_ALLOW_ErrorCount := COUNT(GROUP,h.ref_prov_commercial_id_Invalid=2);
    ref_prov_commercial_id_WORDS_ErrorCount := COUNT(GROUP,h.ref_prov_commercial_id_Invalid=3);
    ref_prov_commercial_id_Total_ErrorCount := COUNT(GROUP,h.ref_prov_commercial_id_Invalid>0);
    cob1_group_policy_num_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cob1_group_policy_num_Invalid=1);
    cob1_group_policy_num_ALLOW_ErrorCount := COUNT(GROUP,h.cob1_group_policy_num_Invalid=2);
    cob1_group_policy_num_LENGTH_ErrorCount := COUNT(GROUP,h.cob1_group_policy_num_Invalid=3);
    cob1_group_policy_num_WORDS_ErrorCount := COUNT(GROUP,h.cob1_group_policy_num_Invalid=4);
    cob1_group_policy_num_Total_ErrorCount := COUNT(GROUP,h.cob1_group_policy_num_Invalid>0);
    cob1_group_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cob1_group_name_Invalid=1);
    cob1_group_name_ALLOW_ErrorCount := COUNT(GROUP,h.cob1_group_name_Invalid=2);
    cob1_group_name_WORDS_ErrorCount := COUNT(GROUP,h.cob1_group_name_Invalid=3);
    cob1_group_name_Total_ErrorCount := COUNT(GROUP,h.cob1_group_name_Invalid>0);
    cob1_ins_type_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cob1_ins_type_code_Invalid=1);
    cob1_ins_type_code_ALLOW_ErrorCount := COUNT(GROUP,h.cob1_ins_type_code_Invalid=2);
    cob1_ins_type_code_LENGTH_ErrorCount := COUNT(GROUP,h.cob1_ins_type_code_Invalid=3);
    cob1_ins_type_code_WORDS_ErrorCount := COUNT(GROUP,h.cob1_ins_type_code_Invalid=4);
    cob1_ins_type_code_Total_ErrorCount := COUNT(GROUP,h.cob1_ins_type_code_Invalid>0);
    cob1_claim_filing_indicator_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cob1_claim_filing_indicator_Invalid=1);
    cob1_claim_filing_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.cob1_claim_filing_indicator_Invalid=2);
    cob1_claim_filing_indicator_LENGTH_ErrorCount := COUNT(GROUP,h.cob1_claim_filing_indicator_Invalid=3);
    cob1_claim_filing_indicator_WORDS_ErrorCount := COUNT(GROUP,h.cob1_claim_filing_indicator_Invalid=4);
    cob1_claim_filing_indicator_Total_ErrorCount := COUNT(GROUP,h.cob1_claim_filing_indicator_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.claim_num_Invalid,le.claim_rec_type_Invalid,le.diag_code9_Invalid,le.diag_code10_Invalid,le.diag_code11_Invalid,le.diag_code12_Invalid,le.diag_code13_Invalid,le.diag_code14_Invalid,le.diag_code15_Invalid,le.diag_code16_Invalid,le.diag_code17_Invalid,le.diag_code18_Invalid,le.diag_code19_Invalid,le.diag_code20_Invalid,le.diag_code21_Invalid,le.diag_code22_Invalid,le.diag_code23_Invalid,le.diag_code24_Invalid,le.other_proc7_Invalid,le.other_proc8_Invalid,le.other_proc9_Invalid,le.other_proc10_Invalid,le.other_proc11_Invalid,le.other_proc12_Invalid,le.other_proc13_Invalid,le.other_proc14_Invalid,le.other_proc15_Invalid,le.other_proc16_Invalid,le.other_proc17_Invalid,le.other_proc18_Invalid,le.other_proc19_Invalid,le.other_proc20_Invalid,le.other_proc21_Invalid,le.other_proc22_Invalid,le.claim_indicator_code_Invalid,le.ref_prov_state_lic_Invalid,le.ref_prov_upin_Invalid,le.ref_prov_commercial_id_Invalid,le.cob1_group_policy_num_Invalid,le.cob1_group_name_Invalid,le.cob1_ins_type_code_Invalid,le.cob1_claim_filing_indicator_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,DRecord_Fields.InvalidMessage_claim_num(le.claim_num_Invalid),DRecord_Fields.InvalidMessage_claim_rec_type(le.claim_rec_type_Invalid),DRecord_Fields.InvalidMessage_diag_code9(le.diag_code9_Invalid),DRecord_Fields.InvalidMessage_diag_code10(le.diag_code10_Invalid),DRecord_Fields.InvalidMessage_diag_code11(le.diag_code11_Invalid),DRecord_Fields.InvalidMessage_diag_code12(le.diag_code12_Invalid),DRecord_Fields.InvalidMessage_diag_code13(le.diag_code13_Invalid),DRecord_Fields.InvalidMessage_diag_code14(le.diag_code14_Invalid),DRecord_Fields.InvalidMessage_diag_code15(le.diag_code15_Invalid),DRecord_Fields.InvalidMessage_diag_code16(le.diag_code16_Invalid),DRecord_Fields.InvalidMessage_diag_code17(le.diag_code17_Invalid),DRecord_Fields.InvalidMessage_diag_code18(le.diag_code18_Invalid),DRecord_Fields.InvalidMessage_diag_code19(le.diag_code19_Invalid),DRecord_Fields.InvalidMessage_diag_code20(le.diag_code20_Invalid),DRecord_Fields.InvalidMessage_diag_code21(le.diag_code21_Invalid),DRecord_Fields.InvalidMessage_diag_code22(le.diag_code22_Invalid),DRecord_Fields.InvalidMessage_diag_code23(le.diag_code23_Invalid),DRecord_Fields.InvalidMessage_diag_code24(le.diag_code24_Invalid),DRecord_Fields.InvalidMessage_other_proc7(le.other_proc7_Invalid),DRecord_Fields.InvalidMessage_other_proc8(le.other_proc8_Invalid),DRecord_Fields.InvalidMessage_other_proc9(le.other_proc9_Invalid),DRecord_Fields.InvalidMessage_other_proc10(le.other_proc10_Invalid),DRecord_Fields.InvalidMessage_other_proc11(le.other_proc11_Invalid),DRecord_Fields.InvalidMessage_other_proc12(le.other_proc12_Invalid),DRecord_Fields.InvalidMessage_other_proc13(le.other_proc13_Invalid),DRecord_Fields.InvalidMessage_other_proc14(le.other_proc14_Invalid),DRecord_Fields.InvalidMessage_other_proc15(le.other_proc15_Invalid),DRecord_Fields.InvalidMessage_other_proc16(le.other_proc16_Invalid),DRecord_Fields.InvalidMessage_other_proc17(le.other_proc17_Invalid),DRecord_Fields.InvalidMessage_other_proc18(le.other_proc18_Invalid),DRecord_Fields.InvalidMessage_other_proc19(le.other_proc19_Invalid),DRecord_Fields.InvalidMessage_other_proc20(le.other_proc20_Invalid),DRecord_Fields.InvalidMessage_other_proc21(le.other_proc21_Invalid),DRecord_Fields.InvalidMessage_other_proc22(le.other_proc22_Invalid),DRecord_Fields.InvalidMessage_claim_indicator_code(le.claim_indicator_code_Invalid),DRecord_Fields.InvalidMessage_ref_prov_state_lic(le.ref_prov_state_lic_Invalid),DRecord_Fields.InvalidMessage_ref_prov_upin(le.ref_prov_upin_Invalid),DRecord_Fields.InvalidMessage_ref_prov_commercial_id(le.ref_prov_commercial_id_Invalid),DRecord_Fields.InvalidMessage_cob1_group_policy_num(le.cob1_group_policy_num_Invalid),DRecord_Fields.InvalidMessage_cob1_group_name(le.cob1_group_name_Invalid),DRecord_Fields.InvalidMessage_cob1_ins_type_code(le.cob1_ins_type_code_Invalid),DRecord_Fields.InvalidMessage_cob1_claim_filing_indicator(le.cob1_claim_filing_indicator_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.claim_num_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.claim_rec_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code9_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code10_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code11_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code12_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code13_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code14_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code15_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code16_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code17_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code18_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code19_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code20_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code21_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code22_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code23_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code24_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc7_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc8_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc9_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc10_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc11_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc12_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc13_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc14_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc15_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc16_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc17_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc18_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc19_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc20_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc21_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc22_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.claim_indicator_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ref_prov_state_lic_Invalid,'LEFTTRIM','WORDS','UNKNOWN')
          ,CHOOSE(le.ref_prov_upin_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ref_prov_commercial_id_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.cob1_group_policy_num_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cob1_group_name_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.cob1_ins_type_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cob1_claim_filing_indicator_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'claim_num','claim_rec_type','diag_code9','diag_code10','diag_code11','diag_code12','diag_code13','diag_code14','diag_code15','diag_code16','diag_code17','diag_code18','diag_code19','diag_code20','diag_code21','diag_code22','diag_code23','diag_code24','other_proc7','other_proc8','other_proc9','other_proc10','other_proc11','other_proc12','other_proc13','other_proc14','other_proc15','other_proc16','other_proc17','other_proc18','other_proc19','other_proc20','other_proc21','other_proc22','claim_indicator_code','ref_prov_state_lic','ref_prov_upin','ref_prov_commercial_id','cob1_group_policy_num','cob1_group_name','cob1_ins_type_code','cob1_claim_filing_indicator','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'claim_num','claim_rec_type','diag_code9','diag_code10','diag_code11','diag_code12','diag_code13','diag_code14','diag_code15','diag_code16','diag_code17','diag_code18','diag_code19','diag_code20','diag_code21','diag_code22','diag_code23','diag_code24','other_proc7','other_proc8','other_proc9','other_proc10','other_proc11','other_proc12','other_proc13','other_proc14','other_proc15','other_proc16','other_proc17','other_proc18','other_proc19','other_proc20','other_proc21','other_proc22','claim_indicator_code','ref_prov_state_lic','ref_prov_upin','ref_prov_commercial_id','cob1_group_policy_num','cob1_group_name','cob1_ins_type_code','cob1_claim_filing_indicator','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.claim_num,(SALT31.StrType)le.claim_rec_type,(SALT31.StrType)le.diag_code9,(SALT31.StrType)le.diag_code10,(SALT31.StrType)le.diag_code11,(SALT31.StrType)le.diag_code12,(SALT31.StrType)le.diag_code13,(SALT31.StrType)le.diag_code14,(SALT31.StrType)le.diag_code15,(SALT31.StrType)le.diag_code16,(SALT31.StrType)le.diag_code17,(SALT31.StrType)le.diag_code18,(SALT31.StrType)le.diag_code19,(SALT31.StrType)le.diag_code20,(SALT31.StrType)le.diag_code21,(SALT31.StrType)le.diag_code22,(SALT31.StrType)le.diag_code23,(SALT31.StrType)le.diag_code24,(SALT31.StrType)le.other_proc7,(SALT31.StrType)le.other_proc8,(SALT31.StrType)le.other_proc9,(SALT31.StrType)le.other_proc10,(SALT31.StrType)le.other_proc11,(SALT31.StrType)le.other_proc12,(SALT31.StrType)le.other_proc13,(SALT31.StrType)le.other_proc14,(SALT31.StrType)le.other_proc15,(SALT31.StrType)le.other_proc16,(SALT31.StrType)le.other_proc17,(SALT31.StrType)le.other_proc18,(SALT31.StrType)le.other_proc19,(SALT31.StrType)le.other_proc20,(SALT31.StrType)le.other_proc21,(SALT31.StrType)le.other_proc22,(SALT31.StrType)le.claim_indicator_code,(SALT31.StrType)le.ref_prov_state_lic,(SALT31.StrType)le.ref_prov_upin,(SALT31.StrType)le.ref_prov_commercial_id,(SALT31.StrType)le.cob1_group_policy_num,(SALT31.StrType)le.cob1_group_name,(SALT31.StrType)le.cob1_ins_type_code,(SALT31.StrType)le.cob1_claim_filing_indicator,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,42,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'claim_num:claim_num:LEFTTRIM','claim_num:claim_num:ALLOW','claim_num:claim_num:LENGTH','claim_num:claim_num:WORDS'
          ,'claim_rec_type:claim_rec_type:LEFTTRIM','claim_rec_type:claim_rec_type:ALLOW','claim_rec_type:claim_rec_type:LENGTH','claim_rec_type:claim_rec_type:WORDS'
          ,'diag_code9:diag_code9:LEFTTRIM','diag_code9:diag_code9:ALLOW','diag_code9:diag_code9:LENGTH','diag_code9:diag_code9:WORDS'
          ,'diag_code10:diag_code10:LEFTTRIM','diag_code10:diag_code10:ALLOW','diag_code10:diag_code10:LENGTH','diag_code10:diag_code10:WORDS'
          ,'diag_code11:diag_code11:LEFTTRIM','diag_code11:diag_code11:ALLOW','diag_code11:diag_code11:LENGTH','diag_code11:diag_code11:WORDS'
          ,'diag_code12:diag_code12:LEFTTRIM','diag_code12:diag_code12:ALLOW','diag_code12:diag_code12:LENGTH','diag_code12:diag_code12:WORDS'
          ,'diag_code13:diag_code13:LEFTTRIM','diag_code13:diag_code13:ALLOW','diag_code13:diag_code13:LENGTH','diag_code13:diag_code13:WORDS'
          ,'diag_code14:diag_code14:LEFTTRIM','diag_code14:diag_code14:ALLOW','diag_code14:diag_code14:LENGTH','diag_code14:diag_code14:WORDS'
          ,'diag_code15:diag_code15:LEFTTRIM','diag_code15:diag_code15:ALLOW','diag_code15:diag_code15:LENGTH','diag_code15:diag_code15:WORDS'
          ,'diag_code16:diag_code16:LEFTTRIM','diag_code16:diag_code16:ALLOW','diag_code16:diag_code16:LENGTH','diag_code16:diag_code16:WORDS'
          ,'diag_code17:diag_code17:LEFTTRIM','diag_code17:diag_code17:ALLOW','diag_code17:diag_code17:LENGTH','diag_code17:diag_code17:WORDS'
          ,'diag_code18:diag_code18:LEFTTRIM','diag_code18:diag_code18:ALLOW','diag_code18:diag_code18:LENGTH','diag_code18:diag_code18:WORDS'
          ,'diag_code19:diag_code19:LEFTTRIM','diag_code19:diag_code19:ALLOW','diag_code19:diag_code19:LENGTH','diag_code19:diag_code19:WORDS'
          ,'diag_code20:diag_code20:LEFTTRIM','diag_code20:diag_code20:ALLOW','diag_code20:diag_code20:LENGTH','diag_code20:diag_code20:WORDS'
          ,'diag_code21:diag_code21:LEFTTRIM','diag_code21:diag_code21:ALLOW','diag_code21:diag_code21:LENGTH','diag_code21:diag_code21:WORDS'
          ,'diag_code22:diag_code22:LEFTTRIM','diag_code22:diag_code22:ALLOW','diag_code22:diag_code22:LENGTH','diag_code22:diag_code22:WORDS'
          ,'diag_code23:diag_code23:LEFTTRIM','diag_code23:diag_code23:ALLOW','diag_code23:diag_code23:LENGTH','diag_code23:diag_code23:WORDS'
          ,'diag_code24:diag_code24:LEFTTRIM','diag_code24:diag_code24:ALLOW','diag_code24:diag_code24:LENGTH','diag_code24:diag_code24:WORDS'
          ,'other_proc7:other_proc7:LEFTTRIM','other_proc7:other_proc7:ALLOW','other_proc7:other_proc7:LENGTH','other_proc7:other_proc7:WORDS'
          ,'other_proc8:other_proc8:LEFTTRIM','other_proc8:other_proc8:ALLOW','other_proc8:other_proc8:LENGTH','other_proc8:other_proc8:WORDS'
          ,'other_proc9:other_proc9:LEFTTRIM','other_proc9:other_proc9:ALLOW','other_proc9:other_proc9:LENGTH','other_proc9:other_proc9:WORDS'
          ,'other_proc10:other_proc10:LEFTTRIM','other_proc10:other_proc10:ALLOW','other_proc10:other_proc10:LENGTH','other_proc10:other_proc10:WORDS'
          ,'other_proc11:other_proc11:LEFTTRIM','other_proc11:other_proc11:ALLOW','other_proc11:other_proc11:LENGTH','other_proc11:other_proc11:WORDS'
          ,'other_proc12:other_proc12:LEFTTRIM','other_proc12:other_proc12:ALLOW','other_proc12:other_proc12:LENGTH','other_proc12:other_proc12:WORDS'
          ,'other_proc13:other_proc13:LEFTTRIM','other_proc13:other_proc13:ALLOW','other_proc13:other_proc13:LENGTH','other_proc13:other_proc13:WORDS'
          ,'other_proc14:other_proc14:LEFTTRIM','other_proc14:other_proc14:ALLOW','other_proc14:other_proc14:LENGTH','other_proc14:other_proc14:WORDS'
          ,'other_proc15:other_proc15:LEFTTRIM','other_proc15:other_proc15:ALLOW','other_proc15:other_proc15:LENGTH','other_proc15:other_proc15:WORDS'
          ,'other_proc16:other_proc16:LEFTTRIM','other_proc16:other_proc16:ALLOW','other_proc16:other_proc16:LENGTH','other_proc16:other_proc16:WORDS'
          ,'other_proc17:other_proc17:LEFTTRIM','other_proc17:other_proc17:ALLOW','other_proc17:other_proc17:LENGTH','other_proc17:other_proc17:WORDS'
          ,'other_proc18:other_proc18:LEFTTRIM','other_proc18:other_proc18:ALLOW','other_proc18:other_proc18:LENGTH','other_proc18:other_proc18:WORDS'
          ,'other_proc19:other_proc19:LEFTTRIM','other_proc19:other_proc19:ALLOW','other_proc19:other_proc19:LENGTH','other_proc19:other_proc19:WORDS'
          ,'other_proc20:other_proc20:LEFTTRIM','other_proc20:other_proc20:ALLOW','other_proc20:other_proc20:LENGTH','other_proc20:other_proc20:WORDS'
          ,'other_proc21:other_proc21:LEFTTRIM','other_proc21:other_proc21:ALLOW','other_proc21:other_proc21:LENGTH','other_proc21:other_proc21:WORDS'
          ,'other_proc22:other_proc22:LEFTTRIM','other_proc22:other_proc22:ALLOW','other_proc22:other_proc22:LENGTH','other_proc22:other_proc22:WORDS'
          ,'claim_indicator_code:claim_indicator_code:LEFTTRIM','claim_indicator_code:claim_indicator_code:ALLOW','claim_indicator_code:claim_indicator_code:LENGTH','claim_indicator_code:claim_indicator_code:WORDS'
          ,'ref_prov_state_lic:ref_prov_state_lic:LEFTTRIM','ref_prov_state_lic:ref_prov_state_lic:WORDS'
          ,'ref_prov_upin:ref_prov_upin:LEFTTRIM','ref_prov_upin:ref_prov_upin:ALLOW','ref_prov_upin:ref_prov_upin:LENGTH','ref_prov_upin:ref_prov_upin:WORDS'
          ,'ref_prov_commercial_id:ref_prov_commercial_id:LEFTTRIM','ref_prov_commercial_id:ref_prov_commercial_id:ALLOW','ref_prov_commercial_id:ref_prov_commercial_id:WORDS'
          ,'cob1_group_policy_num:cob1_group_policy_num:LEFTTRIM','cob1_group_policy_num:cob1_group_policy_num:ALLOW','cob1_group_policy_num:cob1_group_policy_num:LENGTH','cob1_group_policy_num:cob1_group_policy_num:WORDS'
          ,'cob1_group_name:cob1_group_name:LEFTTRIM','cob1_group_name:cob1_group_name:ALLOW','cob1_group_name:cob1_group_name:WORDS'
          ,'cob1_ins_type_code:cob1_ins_type_code:LEFTTRIM','cob1_ins_type_code:cob1_ins_type_code:ALLOW','cob1_ins_type_code:cob1_ins_type_code:LENGTH','cob1_ins_type_code:cob1_ins_type_code:WORDS'
          ,'cob1_claim_filing_indicator:cob1_claim_filing_indicator:LEFTTRIM','cob1_claim_filing_indicator:cob1_claim_filing_indicator:ALLOW','cob1_claim_filing_indicator:cob1_claim_filing_indicator:LENGTH','cob1_claim_filing_indicator:cob1_claim_filing_indicator:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,DRecord_Fields.InvalidMessage_claim_num(1),DRecord_Fields.InvalidMessage_claim_num(2),DRecord_Fields.InvalidMessage_claim_num(3),DRecord_Fields.InvalidMessage_claim_num(4)
          ,DRecord_Fields.InvalidMessage_claim_rec_type(1),DRecord_Fields.InvalidMessage_claim_rec_type(2),DRecord_Fields.InvalidMessage_claim_rec_type(3),DRecord_Fields.InvalidMessage_claim_rec_type(4)
          ,DRecord_Fields.InvalidMessage_diag_code9(1),DRecord_Fields.InvalidMessage_diag_code9(2),DRecord_Fields.InvalidMessage_diag_code9(3),DRecord_Fields.InvalidMessage_diag_code9(4)
          ,DRecord_Fields.InvalidMessage_diag_code10(1),DRecord_Fields.InvalidMessage_diag_code10(2),DRecord_Fields.InvalidMessage_diag_code10(3),DRecord_Fields.InvalidMessage_diag_code10(4)
          ,DRecord_Fields.InvalidMessage_diag_code11(1),DRecord_Fields.InvalidMessage_diag_code11(2),DRecord_Fields.InvalidMessage_diag_code11(3),DRecord_Fields.InvalidMessage_diag_code11(4)
          ,DRecord_Fields.InvalidMessage_diag_code12(1),DRecord_Fields.InvalidMessage_diag_code12(2),DRecord_Fields.InvalidMessage_diag_code12(3),DRecord_Fields.InvalidMessage_diag_code12(4)
          ,DRecord_Fields.InvalidMessage_diag_code13(1),DRecord_Fields.InvalidMessage_diag_code13(2),DRecord_Fields.InvalidMessage_diag_code13(3),DRecord_Fields.InvalidMessage_diag_code13(4)
          ,DRecord_Fields.InvalidMessage_diag_code14(1),DRecord_Fields.InvalidMessage_diag_code14(2),DRecord_Fields.InvalidMessage_diag_code14(3),DRecord_Fields.InvalidMessage_diag_code14(4)
          ,DRecord_Fields.InvalidMessage_diag_code15(1),DRecord_Fields.InvalidMessage_diag_code15(2),DRecord_Fields.InvalidMessage_diag_code15(3),DRecord_Fields.InvalidMessage_diag_code15(4)
          ,DRecord_Fields.InvalidMessage_diag_code16(1),DRecord_Fields.InvalidMessage_diag_code16(2),DRecord_Fields.InvalidMessage_diag_code16(3),DRecord_Fields.InvalidMessage_diag_code16(4)
          ,DRecord_Fields.InvalidMessage_diag_code17(1),DRecord_Fields.InvalidMessage_diag_code17(2),DRecord_Fields.InvalidMessage_diag_code17(3),DRecord_Fields.InvalidMessage_diag_code17(4)
          ,DRecord_Fields.InvalidMessage_diag_code18(1),DRecord_Fields.InvalidMessage_diag_code18(2),DRecord_Fields.InvalidMessage_diag_code18(3),DRecord_Fields.InvalidMessage_diag_code18(4)
          ,DRecord_Fields.InvalidMessage_diag_code19(1),DRecord_Fields.InvalidMessage_diag_code19(2),DRecord_Fields.InvalidMessage_diag_code19(3),DRecord_Fields.InvalidMessage_diag_code19(4)
          ,DRecord_Fields.InvalidMessage_diag_code20(1),DRecord_Fields.InvalidMessage_diag_code20(2),DRecord_Fields.InvalidMessage_diag_code20(3),DRecord_Fields.InvalidMessage_diag_code20(4)
          ,DRecord_Fields.InvalidMessage_diag_code21(1),DRecord_Fields.InvalidMessage_diag_code21(2),DRecord_Fields.InvalidMessage_diag_code21(3),DRecord_Fields.InvalidMessage_diag_code21(4)
          ,DRecord_Fields.InvalidMessage_diag_code22(1),DRecord_Fields.InvalidMessage_diag_code22(2),DRecord_Fields.InvalidMessage_diag_code22(3),DRecord_Fields.InvalidMessage_diag_code22(4)
          ,DRecord_Fields.InvalidMessage_diag_code23(1),DRecord_Fields.InvalidMessage_diag_code23(2),DRecord_Fields.InvalidMessage_diag_code23(3),DRecord_Fields.InvalidMessage_diag_code23(4)
          ,DRecord_Fields.InvalidMessage_diag_code24(1),DRecord_Fields.InvalidMessage_diag_code24(2),DRecord_Fields.InvalidMessage_diag_code24(3),DRecord_Fields.InvalidMessage_diag_code24(4)
          ,DRecord_Fields.InvalidMessage_other_proc7(1),DRecord_Fields.InvalidMessage_other_proc7(2),DRecord_Fields.InvalidMessage_other_proc7(3),DRecord_Fields.InvalidMessage_other_proc7(4)
          ,DRecord_Fields.InvalidMessage_other_proc8(1),DRecord_Fields.InvalidMessage_other_proc8(2),DRecord_Fields.InvalidMessage_other_proc8(3),DRecord_Fields.InvalidMessage_other_proc8(4)
          ,DRecord_Fields.InvalidMessage_other_proc9(1),DRecord_Fields.InvalidMessage_other_proc9(2),DRecord_Fields.InvalidMessage_other_proc9(3),DRecord_Fields.InvalidMessage_other_proc9(4)
          ,DRecord_Fields.InvalidMessage_other_proc10(1),DRecord_Fields.InvalidMessage_other_proc10(2),DRecord_Fields.InvalidMessage_other_proc10(3),DRecord_Fields.InvalidMessage_other_proc10(4)
          ,DRecord_Fields.InvalidMessage_other_proc11(1),DRecord_Fields.InvalidMessage_other_proc11(2),DRecord_Fields.InvalidMessage_other_proc11(3),DRecord_Fields.InvalidMessage_other_proc11(4)
          ,DRecord_Fields.InvalidMessage_other_proc12(1),DRecord_Fields.InvalidMessage_other_proc12(2),DRecord_Fields.InvalidMessage_other_proc12(3),DRecord_Fields.InvalidMessage_other_proc12(4)
          ,DRecord_Fields.InvalidMessage_other_proc13(1),DRecord_Fields.InvalidMessage_other_proc13(2),DRecord_Fields.InvalidMessage_other_proc13(3),DRecord_Fields.InvalidMessage_other_proc13(4)
          ,DRecord_Fields.InvalidMessage_other_proc14(1),DRecord_Fields.InvalidMessage_other_proc14(2),DRecord_Fields.InvalidMessage_other_proc14(3),DRecord_Fields.InvalidMessage_other_proc14(4)
          ,DRecord_Fields.InvalidMessage_other_proc15(1),DRecord_Fields.InvalidMessage_other_proc15(2),DRecord_Fields.InvalidMessage_other_proc15(3),DRecord_Fields.InvalidMessage_other_proc15(4)
          ,DRecord_Fields.InvalidMessage_other_proc16(1),DRecord_Fields.InvalidMessage_other_proc16(2),DRecord_Fields.InvalidMessage_other_proc16(3),DRecord_Fields.InvalidMessage_other_proc16(4)
          ,DRecord_Fields.InvalidMessage_other_proc17(1),DRecord_Fields.InvalidMessage_other_proc17(2),DRecord_Fields.InvalidMessage_other_proc17(3),DRecord_Fields.InvalidMessage_other_proc17(4)
          ,DRecord_Fields.InvalidMessage_other_proc18(1),DRecord_Fields.InvalidMessage_other_proc18(2),DRecord_Fields.InvalidMessage_other_proc18(3),DRecord_Fields.InvalidMessage_other_proc18(4)
          ,DRecord_Fields.InvalidMessage_other_proc19(1),DRecord_Fields.InvalidMessage_other_proc19(2),DRecord_Fields.InvalidMessage_other_proc19(3),DRecord_Fields.InvalidMessage_other_proc19(4)
          ,DRecord_Fields.InvalidMessage_other_proc20(1),DRecord_Fields.InvalidMessage_other_proc20(2),DRecord_Fields.InvalidMessage_other_proc20(3),DRecord_Fields.InvalidMessage_other_proc20(4)
          ,DRecord_Fields.InvalidMessage_other_proc21(1),DRecord_Fields.InvalidMessage_other_proc21(2),DRecord_Fields.InvalidMessage_other_proc21(3),DRecord_Fields.InvalidMessage_other_proc21(4)
          ,DRecord_Fields.InvalidMessage_other_proc22(1),DRecord_Fields.InvalidMessage_other_proc22(2),DRecord_Fields.InvalidMessage_other_proc22(3),DRecord_Fields.InvalidMessage_other_proc22(4)
          ,DRecord_Fields.InvalidMessage_claim_indicator_code(1),DRecord_Fields.InvalidMessage_claim_indicator_code(2),DRecord_Fields.InvalidMessage_claim_indicator_code(3),DRecord_Fields.InvalidMessage_claim_indicator_code(4)
          ,DRecord_Fields.InvalidMessage_ref_prov_state_lic(1),DRecord_Fields.InvalidMessage_ref_prov_state_lic(2)
          ,DRecord_Fields.InvalidMessage_ref_prov_upin(1),DRecord_Fields.InvalidMessage_ref_prov_upin(2),DRecord_Fields.InvalidMessage_ref_prov_upin(3),DRecord_Fields.InvalidMessage_ref_prov_upin(4)
          ,DRecord_Fields.InvalidMessage_ref_prov_commercial_id(1),DRecord_Fields.InvalidMessage_ref_prov_commercial_id(2),DRecord_Fields.InvalidMessage_ref_prov_commercial_id(3)
          ,DRecord_Fields.InvalidMessage_cob1_group_policy_num(1),DRecord_Fields.InvalidMessage_cob1_group_policy_num(2),DRecord_Fields.InvalidMessage_cob1_group_policy_num(3),DRecord_Fields.InvalidMessage_cob1_group_policy_num(4)
          ,DRecord_Fields.InvalidMessage_cob1_group_name(1),DRecord_Fields.InvalidMessage_cob1_group_name(2),DRecord_Fields.InvalidMessage_cob1_group_name(3)
          ,DRecord_Fields.InvalidMessage_cob1_ins_type_code(1),DRecord_Fields.InvalidMessage_cob1_ins_type_code(2),DRecord_Fields.InvalidMessage_cob1_ins_type_code(3),DRecord_Fields.InvalidMessage_cob1_ins_type_code(4)
          ,DRecord_Fields.InvalidMessage_cob1_claim_filing_indicator(1),DRecord_Fields.InvalidMessage_cob1_claim_filing_indicator(2),DRecord_Fields.InvalidMessage_cob1_claim_filing_indicator(3),DRecord_Fields.InvalidMessage_cob1_claim_filing_indicator(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.claim_num_LEFTTRIM_ErrorCount,le.claim_num_ALLOW_ErrorCount,le.claim_num_LENGTH_ErrorCount,le.claim_num_WORDS_ErrorCount
          ,le.claim_rec_type_LEFTTRIM_ErrorCount,le.claim_rec_type_ALLOW_ErrorCount,le.claim_rec_type_LENGTH_ErrorCount,le.claim_rec_type_WORDS_ErrorCount
          ,le.diag_code9_LEFTTRIM_ErrorCount,le.diag_code9_ALLOW_ErrorCount,le.diag_code9_LENGTH_ErrorCount,le.diag_code9_WORDS_ErrorCount
          ,le.diag_code10_LEFTTRIM_ErrorCount,le.diag_code10_ALLOW_ErrorCount,le.diag_code10_LENGTH_ErrorCount,le.diag_code10_WORDS_ErrorCount
          ,le.diag_code11_LEFTTRIM_ErrorCount,le.diag_code11_ALLOW_ErrorCount,le.diag_code11_LENGTH_ErrorCount,le.diag_code11_WORDS_ErrorCount
          ,le.diag_code12_LEFTTRIM_ErrorCount,le.diag_code12_ALLOW_ErrorCount,le.diag_code12_LENGTH_ErrorCount,le.diag_code12_WORDS_ErrorCount
          ,le.diag_code13_LEFTTRIM_ErrorCount,le.diag_code13_ALLOW_ErrorCount,le.diag_code13_LENGTH_ErrorCount,le.diag_code13_WORDS_ErrorCount
          ,le.diag_code14_LEFTTRIM_ErrorCount,le.diag_code14_ALLOW_ErrorCount,le.diag_code14_LENGTH_ErrorCount,le.diag_code14_WORDS_ErrorCount
          ,le.diag_code15_LEFTTRIM_ErrorCount,le.diag_code15_ALLOW_ErrorCount,le.diag_code15_LENGTH_ErrorCount,le.diag_code15_WORDS_ErrorCount
          ,le.diag_code16_LEFTTRIM_ErrorCount,le.diag_code16_ALLOW_ErrorCount,le.diag_code16_LENGTH_ErrorCount,le.diag_code16_WORDS_ErrorCount
          ,le.diag_code17_LEFTTRIM_ErrorCount,le.diag_code17_ALLOW_ErrorCount,le.diag_code17_LENGTH_ErrorCount,le.diag_code17_WORDS_ErrorCount
          ,le.diag_code18_LEFTTRIM_ErrorCount,le.diag_code18_ALLOW_ErrorCount,le.diag_code18_LENGTH_ErrorCount,le.diag_code18_WORDS_ErrorCount
          ,le.diag_code19_LEFTTRIM_ErrorCount,le.diag_code19_ALLOW_ErrorCount,le.diag_code19_LENGTH_ErrorCount,le.diag_code19_WORDS_ErrorCount
          ,le.diag_code20_LEFTTRIM_ErrorCount,le.diag_code20_ALLOW_ErrorCount,le.diag_code20_LENGTH_ErrorCount,le.diag_code20_WORDS_ErrorCount
          ,le.diag_code21_LEFTTRIM_ErrorCount,le.diag_code21_ALLOW_ErrorCount,le.diag_code21_LENGTH_ErrorCount,le.diag_code21_WORDS_ErrorCount
          ,le.diag_code22_LEFTTRIM_ErrorCount,le.diag_code22_ALLOW_ErrorCount,le.diag_code22_LENGTH_ErrorCount,le.diag_code22_WORDS_ErrorCount
          ,le.diag_code23_LEFTTRIM_ErrorCount,le.diag_code23_ALLOW_ErrorCount,le.diag_code23_LENGTH_ErrorCount,le.diag_code23_WORDS_ErrorCount
          ,le.diag_code24_LEFTTRIM_ErrorCount,le.diag_code24_ALLOW_ErrorCount,le.diag_code24_LENGTH_ErrorCount,le.diag_code24_WORDS_ErrorCount
          ,le.other_proc7_LEFTTRIM_ErrorCount,le.other_proc7_ALLOW_ErrorCount,le.other_proc7_LENGTH_ErrorCount,le.other_proc7_WORDS_ErrorCount
          ,le.other_proc8_LEFTTRIM_ErrorCount,le.other_proc8_ALLOW_ErrorCount,le.other_proc8_LENGTH_ErrorCount,le.other_proc8_WORDS_ErrorCount
          ,le.other_proc9_LEFTTRIM_ErrorCount,le.other_proc9_ALLOW_ErrorCount,le.other_proc9_LENGTH_ErrorCount,le.other_proc9_WORDS_ErrorCount
          ,le.other_proc10_LEFTTRIM_ErrorCount,le.other_proc10_ALLOW_ErrorCount,le.other_proc10_LENGTH_ErrorCount,le.other_proc10_WORDS_ErrorCount
          ,le.other_proc11_LEFTTRIM_ErrorCount,le.other_proc11_ALLOW_ErrorCount,le.other_proc11_LENGTH_ErrorCount,le.other_proc11_WORDS_ErrorCount
          ,le.other_proc12_LEFTTRIM_ErrorCount,le.other_proc12_ALLOW_ErrorCount,le.other_proc12_LENGTH_ErrorCount,le.other_proc12_WORDS_ErrorCount
          ,le.other_proc13_LEFTTRIM_ErrorCount,le.other_proc13_ALLOW_ErrorCount,le.other_proc13_LENGTH_ErrorCount,le.other_proc13_WORDS_ErrorCount
          ,le.other_proc14_LEFTTRIM_ErrorCount,le.other_proc14_ALLOW_ErrorCount,le.other_proc14_LENGTH_ErrorCount,le.other_proc14_WORDS_ErrorCount
          ,le.other_proc15_LEFTTRIM_ErrorCount,le.other_proc15_ALLOW_ErrorCount,le.other_proc15_LENGTH_ErrorCount,le.other_proc15_WORDS_ErrorCount
          ,le.other_proc16_LEFTTRIM_ErrorCount,le.other_proc16_ALLOW_ErrorCount,le.other_proc16_LENGTH_ErrorCount,le.other_proc16_WORDS_ErrorCount
          ,le.other_proc17_LEFTTRIM_ErrorCount,le.other_proc17_ALLOW_ErrorCount,le.other_proc17_LENGTH_ErrorCount,le.other_proc17_WORDS_ErrorCount
          ,le.other_proc18_LEFTTRIM_ErrorCount,le.other_proc18_ALLOW_ErrorCount,le.other_proc18_LENGTH_ErrorCount,le.other_proc18_WORDS_ErrorCount
          ,le.other_proc19_LEFTTRIM_ErrorCount,le.other_proc19_ALLOW_ErrorCount,le.other_proc19_LENGTH_ErrorCount,le.other_proc19_WORDS_ErrorCount
          ,le.other_proc20_LEFTTRIM_ErrorCount,le.other_proc20_ALLOW_ErrorCount,le.other_proc20_LENGTH_ErrorCount,le.other_proc20_WORDS_ErrorCount
          ,le.other_proc21_LEFTTRIM_ErrorCount,le.other_proc21_ALLOW_ErrorCount,le.other_proc21_LENGTH_ErrorCount,le.other_proc21_WORDS_ErrorCount
          ,le.other_proc22_LEFTTRIM_ErrorCount,le.other_proc22_ALLOW_ErrorCount,le.other_proc22_LENGTH_ErrorCount,le.other_proc22_WORDS_ErrorCount
          ,le.claim_indicator_code_LEFTTRIM_ErrorCount,le.claim_indicator_code_ALLOW_ErrorCount,le.claim_indicator_code_LENGTH_ErrorCount,le.claim_indicator_code_WORDS_ErrorCount
          ,le.ref_prov_state_lic_LEFTTRIM_ErrorCount,le.ref_prov_state_lic_WORDS_ErrorCount
          ,le.ref_prov_upin_LEFTTRIM_ErrorCount,le.ref_prov_upin_ALLOW_ErrorCount,le.ref_prov_upin_LENGTH_ErrorCount,le.ref_prov_upin_WORDS_ErrorCount
          ,le.ref_prov_commercial_id_LEFTTRIM_ErrorCount,le.ref_prov_commercial_id_ALLOW_ErrorCount,le.ref_prov_commercial_id_WORDS_ErrorCount
          ,le.cob1_group_policy_num_LEFTTRIM_ErrorCount,le.cob1_group_policy_num_ALLOW_ErrorCount,le.cob1_group_policy_num_LENGTH_ErrorCount,le.cob1_group_policy_num_WORDS_ErrorCount
          ,le.cob1_group_name_LEFTTRIM_ErrorCount,le.cob1_group_name_ALLOW_ErrorCount,le.cob1_group_name_WORDS_ErrorCount
          ,le.cob1_ins_type_code_LEFTTRIM_ErrorCount,le.cob1_ins_type_code_ALLOW_ErrorCount,le.cob1_ins_type_code_LENGTH_ErrorCount,le.cob1_ins_type_code_WORDS_ErrorCount
          ,le.cob1_claim_filing_indicator_LEFTTRIM_ErrorCount,le.cob1_claim_filing_indicator_ALLOW_ErrorCount,le.cob1_claim_filing_indicator_LENGTH_ErrorCount,le.cob1_claim_filing_indicator_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.claim_num_LEFTTRIM_ErrorCount,le.claim_num_ALLOW_ErrorCount,le.claim_num_LENGTH_ErrorCount,le.claim_num_WORDS_ErrorCount
          ,le.claim_rec_type_LEFTTRIM_ErrorCount,le.claim_rec_type_ALLOW_ErrorCount,le.claim_rec_type_LENGTH_ErrorCount,le.claim_rec_type_WORDS_ErrorCount
          ,le.diag_code9_LEFTTRIM_ErrorCount,le.diag_code9_ALLOW_ErrorCount,le.diag_code9_LENGTH_ErrorCount,le.diag_code9_WORDS_ErrorCount
          ,le.diag_code10_LEFTTRIM_ErrorCount,le.diag_code10_ALLOW_ErrorCount,le.diag_code10_LENGTH_ErrorCount,le.diag_code10_WORDS_ErrorCount
          ,le.diag_code11_LEFTTRIM_ErrorCount,le.diag_code11_ALLOW_ErrorCount,le.diag_code11_LENGTH_ErrorCount,le.diag_code11_WORDS_ErrorCount
          ,le.diag_code12_LEFTTRIM_ErrorCount,le.diag_code12_ALLOW_ErrorCount,le.diag_code12_LENGTH_ErrorCount,le.diag_code12_WORDS_ErrorCount
          ,le.diag_code13_LEFTTRIM_ErrorCount,le.diag_code13_ALLOW_ErrorCount,le.diag_code13_LENGTH_ErrorCount,le.diag_code13_WORDS_ErrorCount
          ,le.diag_code14_LEFTTRIM_ErrorCount,le.diag_code14_ALLOW_ErrorCount,le.diag_code14_LENGTH_ErrorCount,le.diag_code14_WORDS_ErrorCount
          ,le.diag_code15_LEFTTRIM_ErrorCount,le.diag_code15_ALLOW_ErrorCount,le.diag_code15_LENGTH_ErrorCount,le.diag_code15_WORDS_ErrorCount
          ,le.diag_code16_LEFTTRIM_ErrorCount,le.diag_code16_ALLOW_ErrorCount,le.diag_code16_LENGTH_ErrorCount,le.diag_code16_WORDS_ErrorCount
          ,le.diag_code17_LEFTTRIM_ErrorCount,le.diag_code17_ALLOW_ErrorCount,le.diag_code17_LENGTH_ErrorCount,le.diag_code17_WORDS_ErrorCount
          ,le.diag_code18_LEFTTRIM_ErrorCount,le.diag_code18_ALLOW_ErrorCount,le.diag_code18_LENGTH_ErrorCount,le.diag_code18_WORDS_ErrorCount
          ,le.diag_code19_LEFTTRIM_ErrorCount,le.diag_code19_ALLOW_ErrorCount,le.diag_code19_LENGTH_ErrorCount,le.diag_code19_WORDS_ErrorCount
          ,le.diag_code20_LEFTTRIM_ErrorCount,le.diag_code20_ALLOW_ErrorCount,le.diag_code20_LENGTH_ErrorCount,le.diag_code20_WORDS_ErrorCount
          ,le.diag_code21_LEFTTRIM_ErrorCount,le.diag_code21_ALLOW_ErrorCount,le.diag_code21_LENGTH_ErrorCount,le.diag_code21_WORDS_ErrorCount
          ,le.diag_code22_LEFTTRIM_ErrorCount,le.diag_code22_ALLOW_ErrorCount,le.diag_code22_LENGTH_ErrorCount,le.diag_code22_WORDS_ErrorCount
          ,le.diag_code23_LEFTTRIM_ErrorCount,le.diag_code23_ALLOW_ErrorCount,le.diag_code23_LENGTH_ErrorCount,le.diag_code23_WORDS_ErrorCount
          ,le.diag_code24_LEFTTRIM_ErrorCount,le.diag_code24_ALLOW_ErrorCount,le.diag_code24_LENGTH_ErrorCount,le.diag_code24_WORDS_ErrorCount
          ,le.other_proc7_LEFTTRIM_ErrorCount,le.other_proc7_ALLOW_ErrorCount,le.other_proc7_LENGTH_ErrorCount,le.other_proc7_WORDS_ErrorCount
          ,le.other_proc8_LEFTTRIM_ErrorCount,le.other_proc8_ALLOW_ErrorCount,le.other_proc8_LENGTH_ErrorCount,le.other_proc8_WORDS_ErrorCount
          ,le.other_proc9_LEFTTRIM_ErrorCount,le.other_proc9_ALLOW_ErrorCount,le.other_proc9_LENGTH_ErrorCount,le.other_proc9_WORDS_ErrorCount
          ,le.other_proc10_LEFTTRIM_ErrorCount,le.other_proc10_ALLOW_ErrorCount,le.other_proc10_LENGTH_ErrorCount,le.other_proc10_WORDS_ErrorCount
          ,le.other_proc11_LEFTTRIM_ErrorCount,le.other_proc11_ALLOW_ErrorCount,le.other_proc11_LENGTH_ErrorCount,le.other_proc11_WORDS_ErrorCount
          ,le.other_proc12_LEFTTRIM_ErrorCount,le.other_proc12_ALLOW_ErrorCount,le.other_proc12_LENGTH_ErrorCount,le.other_proc12_WORDS_ErrorCount
          ,le.other_proc13_LEFTTRIM_ErrorCount,le.other_proc13_ALLOW_ErrorCount,le.other_proc13_LENGTH_ErrorCount,le.other_proc13_WORDS_ErrorCount
          ,le.other_proc14_LEFTTRIM_ErrorCount,le.other_proc14_ALLOW_ErrorCount,le.other_proc14_LENGTH_ErrorCount,le.other_proc14_WORDS_ErrorCount
          ,le.other_proc15_LEFTTRIM_ErrorCount,le.other_proc15_ALLOW_ErrorCount,le.other_proc15_LENGTH_ErrorCount,le.other_proc15_WORDS_ErrorCount
          ,le.other_proc16_LEFTTRIM_ErrorCount,le.other_proc16_ALLOW_ErrorCount,le.other_proc16_LENGTH_ErrorCount,le.other_proc16_WORDS_ErrorCount
          ,le.other_proc17_LEFTTRIM_ErrorCount,le.other_proc17_ALLOW_ErrorCount,le.other_proc17_LENGTH_ErrorCount,le.other_proc17_WORDS_ErrorCount
          ,le.other_proc18_LEFTTRIM_ErrorCount,le.other_proc18_ALLOW_ErrorCount,le.other_proc18_LENGTH_ErrorCount,le.other_proc18_WORDS_ErrorCount
          ,le.other_proc19_LEFTTRIM_ErrorCount,le.other_proc19_ALLOW_ErrorCount,le.other_proc19_LENGTH_ErrorCount,le.other_proc19_WORDS_ErrorCount
          ,le.other_proc20_LEFTTRIM_ErrorCount,le.other_proc20_ALLOW_ErrorCount,le.other_proc20_LENGTH_ErrorCount,le.other_proc20_WORDS_ErrorCount
          ,le.other_proc21_LEFTTRIM_ErrorCount,le.other_proc21_ALLOW_ErrorCount,le.other_proc21_LENGTH_ErrorCount,le.other_proc21_WORDS_ErrorCount
          ,le.other_proc22_LEFTTRIM_ErrorCount,le.other_proc22_ALLOW_ErrorCount,le.other_proc22_LENGTH_ErrorCount,le.other_proc22_WORDS_ErrorCount
          ,le.claim_indicator_code_LEFTTRIM_ErrorCount,le.claim_indicator_code_ALLOW_ErrorCount,le.claim_indicator_code_LENGTH_ErrorCount,le.claim_indicator_code_WORDS_ErrorCount
          ,le.ref_prov_state_lic_LEFTTRIM_ErrorCount,le.ref_prov_state_lic_WORDS_ErrorCount
          ,le.ref_prov_upin_LEFTTRIM_ErrorCount,le.ref_prov_upin_ALLOW_ErrorCount,le.ref_prov_upin_LENGTH_ErrorCount,le.ref_prov_upin_WORDS_ErrorCount
          ,le.ref_prov_commercial_id_LEFTTRIM_ErrorCount,le.ref_prov_commercial_id_ALLOW_ErrorCount,le.ref_prov_commercial_id_WORDS_ErrorCount
          ,le.cob1_group_policy_num_LEFTTRIM_ErrorCount,le.cob1_group_policy_num_ALLOW_ErrorCount,le.cob1_group_policy_num_LENGTH_ErrorCount,le.cob1_group_policy_num_WORDS_ErrorCount
          ,le.cob1_group_name_LEFTTRIM_ErrorCount,le.cob1_group_name_ALLOW_ErrorCount,le.cob1_group_name_WORDS_ErrorCount
          ,le.cob1_ins_type_code_LEFTTRIM_ErrorCount,le.cob1_ins_type_code_ALLOW_ErrorCount,le.cob1_ins_type_code_LENGTH_ErrorCount,le.cob1_ins_type_code_WORDS_ErrorCount
          ,le.cob1_claim_filing_indicator_LEFTTRIM_ErrorCount,le.cob1_claim_filing_indicator_ALLOW_ErrorCount,le.cob1_claim_filing_indicator_LENGTH_ErrorCount,le.cob1_claim_filing_indicator_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,164,Into(LEFT,COUNTER));
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
