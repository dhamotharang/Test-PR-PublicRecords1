IMPORT ut,SALT31;
EXPORT HX_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(HX_Layout_HX)
    UNSIGNED1 claim_type_Invalid;
    UNSIGNED1 claim_num_Invalid;
    UNSIGNED1 attend_prov_id_Invalid;
    UNSIGNED1 attend_prov_name_Invalid;
    UNSIGNED1 billing_addr_Invalid;
    UNSIGNED1 billing_city_Invalid;
    UNSIGNED1 billing_npi_Invalid;
    UNSIGNED1 billing_org_name_Invalid;
    UNSIGNED1 billing_state_Invalid;
    UNSIGNED1 billing_tax_id_Invalid;
    UNSIGNED1 billing_zip_Invalid;
    UNSIGNED1 inpatient_proc1_Invalid;
    UNSIGNED1 inpatient_proc2_Invalid;
    UNSIGNED1 inpatient_proc3_Invalid;
    UNSIGNED1 operating_prov_id_Invalid;
    UNSIGNED1 operating_prov_name_Invalid;
    UNSIGNED1 other_diag1_Invalid;
    UNSIGNED1 other_diag2_Invalid;
    UNSIGNED1 other_diag3_Invalid;
    UNSIGNED1 other_diag4_Invalid;
    UNSIGNED1 other_diag5_Invalid;
    UNSIGNED1 other_diag6_Invalid;
    UNSIGNED1 other_diag7_Invalid;
    UNSIGNED1 other_diag8_Invalid;
    UNSIGNED1 other_proc1_Invalid;
    UNSIGNED1 other_proc2_Invalid;
    UNSIGNED1 other_proc3_Invalid;
    UNSIGNED1 other_proc4_Invalid;
    UNSIGNED1 other_proc5_Invalid;
    UNSIGNED1 other_proc_method_code_Invalid;
    UNSIGNED1 other_prov_id1_Invalid;
    UNSIGNED1 other_prov_name1_Invalid;
    UNSIGNED1 outpatient_proc1_Invalid;
    UNSIGNED1 outpatient_proc2_Invalid;
    UNSIGNED1 outpatient_proc3_Invalid;
    UNSIGNED1 principle_diag_Invalid;
    UNSIGNED1 principle_proc_Invalid;
    UNSIGNED1 service_from_Invalid;
    UNSIGNED1 service_line_Invalid;
    UNSIGNED1 service_to_Invalid;
    UNSIGNED1 submitted_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(HX_Layout_HX)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(HX_Layout_HX) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.claim_type_Invalid := HX_Fields.InValid_claim_type((SALT31.StrType)le.claim_type);
    SELF.claim_num_Invalid := HX_Fields.InValid_claim_num((SALT31.StrType)le.claim_num);
    SELF.attend_prov_id_Invalid := HX_Fields.InValid_attend_prov_id((SALT31.StrType)le.attend_prov_id);
    SELF.attend_prov_name_Invalid := HX_Fields.InValid_attend_prov_name((SALT31.StrType)le.attend_prov_name);
    SELF.billing_addr_Invalid := HX_Fields.InValid_billing_addr((SALT31.StrType)le.billing_addr);
    SELF.billing_city_Invalid := HX_Fields.InValid_billing_city((SALT31.StrType)le.billing_city);
    SELF.billing_npi_Invalid := HX_Fields.InValid_billing_npi((SALT31.StrType)le.billing_npi);
    SELF.billing_org_name_Invalid := HX_Fields.InValid_billing_org_name((SALT31.StrType)le.billing_org_name);
    SELF.billing_state_Invalid := HX_Fields.InValid_billing_state((SALT31.StrType)le.billing_state);
    SELF.billing_tax_id_Invalid := HX_Fields.InValid_billing_tax_id((SALT31.StrType)le.billing_tax_id);
    SELF.billing_zip_Invalid := HX_Fields.InValid_billing_zip((SALT31.StrType)le.billing_zip);
    SELF.inpatient_proc1_Invalid := HX_Fields.InValid_inpatient_proc1((SALT31.StrType)le.inpatient_proc1);
    SELF.inpatient_proc2_Invalid := HX_Fields.InValid_inpatient_proc2((SALT31.StrType)le.inpatient_proc2);
    SELF.inpatient_proc3_Invalid := HX_Fields.InValid_inpatient_proc3((SALT31.StrType)le.inpatient_proc3);
    SELF.operating_prov_id_Invalid := HX_Fields.InValid_operating_prov_id((SALT31.StrType)le.operating_prov_id);
    SELF.operating_prov_name_Invalid := HX_Fields.InValid_operating_prov_name((SALT31.StrType)le.operating_prov_name);
    SELF.other_diag1_Invalid := HX_Fields.InValid_other_diag1((SALT31.StrType)le.other_diag1);
    SELF.other_diag2_Invalid := HX_Fields.InValid_other_diag2((SALT31.StrType)le.other_diag2);
    SELF.other_diag3_Invalid := HX_Fields.InValid_other_diag3((SALT31.StrType)le.other_diag3);
    SELF.other_diag4_Invalid := HX_Fields.InValid_other_diag4((SALT31.StrType)le.other_diag4);
    SELF.other_diag5_Invalid := HX_Fields.InValid_other_diag5((SALT31.StrType)le.other_diag5);
    SELF.other_diag6_Invalid := HX_Fields.InValid_other_diag6((SALT31.StrType)le.other_diag6);
    SELF.other_diag7_Invalid := HX_Fields.InValid_other_diag7((SALT31.StrType)le.other_diag7);
    SELF.other_diag8_Invalid := HX_Fields.InValid_other_diag8((SALT31.StrType)le.other_diag8);
    SELF.other_proc1_Invalid := HX_Fields.InValid_other_proc1((SALT31.StrType)le.other_proc1);
    SELF.other_proc2_Invalid := HX_Fields.InValid_other_proc2((SALT31.StrType)le.other_proc2);
    SELF.other_proc3_Invalid := HX_Fields.InValid_other_proc3((SALT31.StrType)le.other_proc3);
    SELF.other_proc4_Invalid := HX_Fields.InValid_other_proc4((SALT31.StrType)le.other_proc4);
    SELF.other_proc5_Invalid := HX_Fields.InValid_other_proc5((SALT31.StrType)le.other_proc5);
    SELF.other_proc_method_code_Invalid := HX_Fields.InValid_other_proc_method_code((SALT31.StrType)le.other_proc_method_code);
    SELF.other_prov_id1_Invalid := HX_Fields.InValid_other_prov_id1((SALT31.StrType)le.other_prov_id1);
    SELF.other_prov_name1_Invalid := HX_Fields.InValid_other_prov_name1((SALT31.StrType)le.other_prov_name1);
    SELF.outpatient_proc1_Invalid := HX_Fields.InValid_outpatient_proc1((SALT31.StrType)le.outpatient_proc1);
    SELF.outpatient_proc2_Invalid := HX_Fields.InValid_outpatient_proc2((SALT31.StrType)le.outpatient_proc2);
    SELF.outpatient_proc3_Invalid := HX_Fields.InValid_outpatient_proc3((SALT31.StrType)le.outpatient_proc3);
    SELF.principle_diag_Invalid := HX_Fields.InValid_principle_diag((SALT31.StrType)le.principle_diag);
    SELF.principle_proc_Invalid := HX_Fields.InValid_principle_proc((SALT31.StrType)le.principle_proc);
    SELF.service_from_Invalid := HX_Fields.InValid_service_from((SALT31.StrType)le.service_from);
    SELF.service_line_Invalid := HX_Fields.InValid_service_line((SALT31.StrType)le.service_line);
    SELF.service_to_Invalid := HX_Fields.InValid_service_to((SALT31.StrType)le.service_to);
    SELF.submitted_date_Invalid := HX_Fields.InValid_submitted_date((SALT31.StrType)le.submitted_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.claim_type_Invalid << 0 ) + ( le.claim_num_Invalid << 3 ) + ( le.attend_prov_id_Invalid << 6 ) + ( le.attend_prov_name_Invalid << 9 ) + ( le.billing_addr_Invalid << 11 ) + ( le.billing_city_Invalid << 12 ) + ( le.billing_npi_Invalid << 13 ) + ( le.billing_org_name_Invalid << 16 ) + ( le.billing_state_Invalid << 18 ) + ( le.billing_tax_id_Invalid << 21 ) + ( le.billing_zip_Invalid << 24 ) + ( le.inpatient_proc1_Invalid << 27 ) + ( le.inpatient_proc2_Invalid << 30 ) + ( le.inpatient_proc3_Invalid << 33 ) + ( le.operating_prov_id_Invalid << 36 ) + ( le.operating_prov_name_Invalid << 39 ) + ( le.other_diag1_Invalid << 41 ) + ( le.other_diag2_Invalid << 44 ) + ( le.other_diag3_Invalid << 47 ) + ( le.other_diag4_Invalid << 50 ) + ( le.other_diag5_Invalid << 53 ) + ( le.other_diag6_Invalid << 56 ) + ( le.other_diag7_Invalid << 59 );
    SELF.ScrubsBits2 := ( le.other_diag8_Invalid << 0 ) + ( le.other_proc1_Invalid << 3 ) + ( le.other_proc2_Invalid << 6 ) + ( le.other_proc3_Invalid << 9 ) + ( le.other_proc4_Invalid << 12 ) + ( le.other_proc5_Invalid << 15 ) + ( le.other_proc_method_code_Invalid << 18 ) + ( le.other_prov_id1_Invalid << 21 ) + ( le.other_prov_name1_Invalid << 24 ) + ( le.outpatient_proc1_Invalid << 26 ) + ( le.outpatient_proc2_Invalid << 29 ) + ( le.outpatient_proc3_Invalid << 32 ) + ( le.principle_diag_Invalid << 35 ) + ( le.principle_proc_Invalid << 38 ) + ( le.service_from_Invalid << 41 ) + ( le.service_line_Invalid << 44 ) + ( le.service_to_Invalid << 47 ) + ( le.submitted_date_Invalid << 50 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,HX_Layout_HX);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.claim_type_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.claim_num_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.attend_prov_id_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.attend_prov_name_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.billing_addr_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.billing_city_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.billing_npi_Invalid := (le.ScrubsBits1 >> 13) & 7;
    SELF.billing_org_name_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.billing_state_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.billing_tax_id_Invalid := (le.ScrubsBits1 >> 21) & 7;
    SELF.billing_zip_Invalid := (le.ScrubsBits1 >> 24) & 7;
    SELF.inpatient_proc1_Invalid := (le.ScrubsBits1 >> 27) & 7;
    SELF.inpatient_proc2_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.inpatient_proc3_Invalid := (le.ScrubsBits1 >> 33) & 7;
    SELF.operating_prov_id_Invalid := (le.ScrubsBits1 >> 36) & 7;
    SELF.operating_prov_name_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.other_diag1_Invalid := (le.ScrubsBits1 >> 41) & 7;
    SELF.other_diag2_Invalid := (le.ScrubsBits1 >> 44) & 7;
    SELF.other_diag3_Invalid := (le.ScrubsBits1 >> 47) & 7;
    SELF.other_diag4_Invalid := (le.ScrubsBits1 >> 50) & 7;
    SELF.other_diag5_Invalid := (le.ScrubsBits1 >> 53) & 7;
    SELF.other_diag6_Invalid := (le.ScrubsBits1 >> 56) & 7;
    SELF.other_diag7_Invalid := (le.ScrubsBits1 >> 59) & 7;
    SELF.other_diag8_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.other_proc1_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.other_proc2_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.other_proc3_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.other_proc4_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.other_proc5_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.other_proc_method_code_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.other_prov_id1_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.other_prov_name1_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.outpatient_proc1_Invalid := (le.ScrubsBits2 >> 26) & 7;
    SELF.outpatient_proc2_Invalid := (le.ScrubsBits2 >> 29) & 7;
    SELF.outpatient_proc3_Invalid := (le.ScrubsBits2 >> 32) & 7;
    SELF.principle_diag_Invalid := (le.ScrubsBits2 >> 35) & 7;
    SELF.principle_proc_Invalid := (le.ScrubsBits2 >> 38) & 7;
    SELF.service_from_Invalid := (le.ScrubsBits2 >> 41) & 7;
    SELF.service_line_Invalid := (le.ScrubsBits2 >> 44) & 7;
    SELF.service_to_Invalid := (le.ScrubsBits2 >> 47) & 7;
    SELF.submitted_date_Invalid := (le.ScrubsBits2 >> 50) & 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    claim_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.claim_type_Invalid=1);
    claim_type_ALLOW_ErrorCount := COUNT(GROUP,h.claim_type_Invalid=2);
    claim_type_LENGTH_ErrorCount := COUNT(GROUP,h.claim_type_Invalid=3);
    claim_type_WORDS_ErrorCount := COUNT(GROUP,h.claim_type_Invalid=4);
    claim_type_Total_ErrorCount := COUNT(GROUP,h.claim_type_Invalid>0);
    claim_num_LEFTTRIM_ErrorCount := COUNT(GROUP,h.claim_num_Invalid=1);
    claim_num_ALLOW_ErrorCount := COUNT(GROUP,h.claim_num_Invalid=2);
    claim_num_LENGTH_ErrorCount := COUNT(GROUP,h.claim_num_Invalid=3);
    claim_num_WORDS_ErrorCount := COUNT(GROUP,h.claim_num_Invalid=4);
    claim_num_Total_ErrorCount := COUNT(GROUP,h.claim_num_Invalid>0);
    attend_prov_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.attend_prov_id_Invalid=1);
    attend_prov_id_ALLOW_ErrorCount := COUNT(GROUP,h.attend_prov_id_Invalid=2);
    attend_prov_id_LENGTH_ErrorCount := COUNT(GROUP,h.attend_prov_id_Invalid=3);
    attend_prov_id_WORDS_ErrorCount := COUNT(GROUP,h.attend_prov_id_Invalid=4);
    attend_prov_id_Total_ErrorCount := COUNT(GROUP,h.attend_prov_id_Invalid>0);
    attend_prov_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.attend_prov_name_Invalid=1);
    attend_prov_name_ALLOW_ErrorCount := COUNT(GROUP,h.attend_prov_name_Invalid=2);
    attend_prov_name_WORDS_ErrorCount := COUNT(GROUP,h.attend_prov_name_Invalid=3);
    attend_prov_name_Total_ErrorCount := COUNT(GROUP,h.attend_prov_name_Invalid>0);
    billing_addr_ALLOW_ErrorCount := COUNT(GROUP,h.billing_addr_Invalid=1);
    billing_city_ALLOW_ErrorCount := COUNT(GROUP,h.billing_city_Invalid=1);
    billing_npi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=1);
    billing_npi_ALLOW_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=2);
    billing_npi_LENGTH_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=3);
    billing_npi_WORDS_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=4);
    billing_npi_Total_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid>0);
    billing_org_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_org_name_Invalid=1);
    billing_org_name_ALLOW_ErrorCount := COUNT(GROUP,h.billing_org_name_Invalid=2);
    billing_org_name_Total_ErrorCount := COUNT(GROUP,h.billing_org_name_Invalid>0);
    billing_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_state_Invalid=1);
    billing_state_ALLOW_ErrorCount := COUNT(GROUP,h.billing_state_Invalid=2);
    billing_state_LENGTH_ErrorCount := COUNT(GROUP,h.billing_state_Invalid=3);
    billing_state_WORDS_ErrorCount := COUNT(GROUP,h.billing_state_Invalid=4);
    billing_state_Total_ErrorCount := COUNT(GROUP,h.billing_state_Invalid>0);
    billing_tax_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_tax_id_Invalid=1);
    billing_tax_id_ALLOW_ErrorCount := COUNT(GROUP,h.billing_tax_id_Invalid=2);
    billing_tax_id_LENGTH_ErrorCount := COUNT(GROUP,h.billing_tax_id_Invalid=3);
    billing_tax_id_WORDS_ErrorCount := COUNT(GROUP,h.billing_tax_id_Invalid=4);
    billing_tax_id_Total_ErrorCount := COUNT(GROUP,h.billing_tax_id_Invalid>0);
    billing_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=1);
    billing_zip_ALLOW_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=2);
    billing_zip_LENGTH_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=3);
    billing_zip_WORDS_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=4);
    billing_zip_Total_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid>0);
    inpatient_proc1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.inpatient_proc1_Invalid=1);
    inpatient_proc1_ALLOW_ErrorCount := COUNT(GROUP,h.inpatient_proc1_Invalid=2);
    inpatient_proc1_LENGTH_ErrorCount := COUNT(GROUP,h.inpatient_proc1_Invalid=3);
    inpatient_proc1_WORDS_ErrorCount := COUNT(GROUP,h.inpatient_proc1_Invalid=4);
    inpatient_proc1_Total_ErrorCount := COUNT(GROUP,h.inpatient_proc1_Invalid>0);
    inpatient_proc2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.inpatient_proc2_Invalid=1);
    inpatient_proc2_ALLOW_ErrorCount := COUNT(GROUP,h.inpatient_proc2_Invalid=2);
    inpatient_proc2_LENGTH_ErrorCount := COUNT(GROUP,h.inpatient_proc2_Invalid=3);
    inpatient_proc2_WORDS_ErrorCount := COUNT(GROUP,h.inpatient_proc2_Invalid=4);
    inpatient_proc2_Total_ErrorCount := COUNT(GROUP,h.inpatient_proc2_Invalid>0);
    inpatient_proc3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.inpatient_proc3_Invalid=1);
    inpatient_proc3_ALLOW_ErrorCount := COUNT(GROUP,h.inpatient_proc3_Invalid=2);
    inpatient_proc3_LENGTH_ErrorCount := COUNT(GROUP,h.inpatient_proc3_Invalid=3);
    inpatient_proc3_WORDS_ErrorCount := COUNT(GROUP,h.inpatient_proc3_Invalid=4);
    inpatient_proc3_Total_ErrorCount := COUNT(GROUP,h.inpatient_proc3_Invalid>0);
    operating_prov_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.operating_prov_id_Invalid=1);
    operating_prov_id_ALLOW_ErrorCount := COUNT(GROUP,h.operating_prov_id_Invalid=2);
    operating_prov_id_LENGTH_ErrorCount := COUNT(GROUP,h.operating_prov_id_Invalid=3);
    operating_prov_id_WORDS_ErrorCount := COUNT(GROUP,h.operating_prov_id_Invalid=4);
    operating_prov_id_Total_ErrorCount := COUNT(GROUP,h.operating_prov_id_Invalid>0);
    operating_prov_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.operating_prov_name_Invalid=1);
    operating_prov_name_ALLOW_ErrorCount := COUNT(GROUP,h.operating_prov_name_Invalid=2);
    operating_prov_name_Total_ErrorCount := COUNT(GROUP,h.operating_prov_name_Invalid>0);
    other_diag1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_diag1_Invalid=1);
    other_diag1_ALLOW_ErrorCount := COUNT(GROUP,h.other_diag1_Invalid=2);
    other_diag1_LENGTH_ErrorCount := COUNT(GROUP,h.other_diag1_Invalid=3);
    other_diag1_WORDS_ErrorCount := COUNT(GROUP,h.other_diag1_Invalid=4);
    other_diag1_Total_ErrorCount := COUNT(GROUP,h.other_diag1_Invalid>0);
    other_diag2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_diag2_Invalid=1);
    other_diag2_ALLOW_ErrorCount := COUNT(GROUP,h.other_diag2_Invalid=2);
    other_diag2_LENGTH_ErrorCount := COUNT(GROUP,h.other_diag2_Invalid=3);
    other_diag2_WORDS_ErrorCount := COUNT(GROUP,h.other_diag2_Invalid=4);
    other_diag2_Total_ErrorCount := COUNT(GROUP,h.other_diag2_Invalid>0);
    other_diag3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_diag3_Invalid=1);
    other_diag3_ALLOW_ErrorCount := COUNT(GROUP,h.other_diag3_Invalid=2);
    other_diag3_LENGTH_ErrorCount := COUNT(GROUP,h.other_diag3_Invalid=3);
    other_diag3_WORDS_ErrorCount := COUNT(GROUP,h.other_diag3_Invalid=4);
    other_diag3_Total_ErrorCount := COUNT(GROUP,h.other_diag3_Invalid>0);
    other_diag4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_diag4_Invalid=1);
    other_diag4_ALLOW_ErrorCount := COUNT(GROUP,h.other_diag4_Invalid=2);
    other_diag4_LENGTH_ErrorCount := COUNT(GROUP,h.other_diag4_Invalid=3);
    other_diag4_WORDS_ErrorCount := COUNT(GROUP,h.other_diag4_Invalid=4);
    other_diag4_Total_ErrorCount := COUNT(GROUP,h.other_diag4_Invalid>0);
    other_diag5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_diag5_Invalid=1);
    other_diag5_ALLOW_ErrorCount := COUNT(GROUP,h.other_diag5_Invalid=2);
    other_diag5_LENGTH_ErrorCount := COUNT(GROUP,h.other_diag5_Invalid=3);
    other_diag5_WORDS_ErrorCount := COUNT(GROUP,h.other_diag5_Invalid=4);
    other_diag5_Total_ErrorCount := COUNT(GROUP,h.other_diag5_Invalid>0);
    other_diag6_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_diag6_Invalid=1);
    other_diag6_ALLOW_ErrorCount := COUNT(GROUP,h.other_diag6_Invalid=2);
    other_diag6_LENGTH_ErrorCount := COUNT(GROUP,h.other_diag6_Invalid=3);
    other_diag6_WORDS_ErrorCount := COUNT(GROUP,h.other_diag6_Invalid=4);
    other_diag6_Total_ErrorCount := COUNT(GROUP,h.other_diag6_Invalid>0);
    other_diag7_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_diag7_Invalid=1);
    other_diag7_ALLOW_ErrorCount := COUNT(GROUP,h.other_diag7_Invalid=2);
    other_diag7_LENGTH_ErrorCount := COUNT(GROUP,h.other_diag7_Invalid=3);
    other_diag7_WORDS_ErrorCount := COUNT(GROUP,h.other_diag7_Invalid=4);
    other_diag7_Total_ErrorCount := COUNT(GROUP,h.other_diag7_Invalid>0);
    other_diag8_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_diag8_Invalid=1);
    other_diag8_ALLOW_ErrorCount := COUNT(GROUP,h.other_diag8_Invalid=2);
    other_diag8_LENGTH_ErrorCount := COUNT(GROUP,h.other_diag8_Invalid=3);
    other_diag8_WORDS_ErrorCount := COUNT(GROUP,h.other_diag8_Invalid=4);
    other_diag8_Total_ErrorCount := COUNT(GROUP,h.other_diag8_Invalid>0);
    other_proc1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc1_Invalid=1);
    other_proc1_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc1_Invalid=2);
    other_proc1_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc1_Invalid=3);
    other_proc1_WORDS_ErrorCount := COUNT(GROUP,h.other_proc1_Invalid=4);
    other_proc1_Total_ErrorCount := COUNT(GROUP,h.other_proc1_Invalid>0);
    other_proc2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc2_Invalid=1);
    other_proc2_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc2_Invalid=2);
    other_proc2_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc2_Invalid=3);
    other_proc2_WORDS_ErrorCount := COUNT(GROUP,h.other_proc2_Invalid=4);
    other_proc2_Total_ErrorCount := COUNT(GROUP,h.other_proc2_Invalid>0);
    other_proc3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc3_Invalid=1);
    other_proc3_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc3_Invalid=2);
    other_proc3_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc3_Invalid=3);
    other_proc3_WORDS_ErrorCount := COUNT(GROUP,h.other_proc3_Invalid=4);
    other_proc3_Total_ErrorCount := COUNT(GROUP,h.other_proc3_Invalid>0);
    other_proc4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc4_Invalid=1);
    other_proc4_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc4_Invalid=2);
    other_proc4_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc4_Invalid=3);
    other_proc4_WORDS_ErrorCount := COUNT(GROUP,h.other_proc4_Invalid=4);
    other_proc4_Total_ErrorCount := COUNT(GROUP,h.other_proc4_Invalid>0);
    other_proc5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc5_Invalid=1);
    other_proc5_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc5_Invalid=2);
    other_proc5_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc5_Invalid=3);
    other_proc5_WORDS_ErrorCount := COUNT(GROUP,h.other_proc5_Invalid=4);
    other_proc5_Total_ErrorCount := COUNT(GROUP,h.other_proc5_Invalid>0);
    other_proc_method_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc_method_code_Invalid=1);
    other_proc_method_code_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc_method_code_Invalid=2);
    other_proc_method_code_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc_method_code_Invalid=3);
    other_proc_method_code_WORDS_ErrorCount := COUNT(GROUP,h.other_proc_method_code_Invalid=4);
    other_proc_method_code_Total_ErrorCount := COUNT(GROUP,h.other_proc_method_code_Invalid>0);
    other_prov_id1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_prov_id1_Invalid=1);
    other_prov_id1_ALLOW_ErrorCount := COUNT(GROUP,h.other_prov_id1_Invalid=2);
    other_prov_id1_LENGTH_ErrorCount := COUNT(GROUP,h.other_prov_id1_Invalid=3);
    other_prov_id1_WORDS_ErrorCount := COUNT(GROUP,h.other_prov_id1_Invalid=4);
    other_prov_id1_Total_ErrorCount := COUNT(GROUP,h.other_prov_id1_Invalid>0);
    other_prov_name1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_prov_name1_Invalid=1);
    other_prov_name1_ALLOW_ErrorCount := COUNT(GROUP,h.other_prov_name1_Invalid=2);
    other_prov_name1_Total_ErrorCount := COUNT(GROUP,h.other_prov_name1_Invalid>0);
    outpatient_proc1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.outpatient_proc1_Invalid=1);
    outpatient_proc1_ALLOW_ErrorCount := COUNT(GROUP,h.outpatient_proc1_Invalid=2);
    outpatient_proc1_LENGTH_ErrorCount := COUNT(GROUP,h.outpatient_proc1_Invalid=3);
    outpatient_proc1_WORDS_ErrorCount := COUNT(GROUP,h.outpatient_proc1_Invalid=4);
    outpatient_proc1_Total_ErrorCount := COUNT(GROUP,h.outpatient_proc1_Invalid>0);
    outpatient_proc2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.outpatient_proc2_Invalid=1);
    outpatient_proc2_ALLOW_ErrorCount := COUNT(GROUP,h.outpatient_proc2_Invalid=2);
    outpatient_proc2_LENGTH_ErrorCount := COUNT(GROUP,h.outpatient_proc2_Invalid=3);
    outpatient_proc2_WORDS_ErrorCount := COUNT(GROUP,h.outpatient_proc2_Invalid=4);
    outpatient_proc2_Total_ErrorCount := COUNT(GROUP,h.outpatient_proc2_Invalid>0);
    outpatient_proc3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.outpatient_proc3_Invalid=1);
    outpatient_proc3_ALLOW_ErrorCount := COUNT(GROUP,h.outpatient_proc3_Invalid=2);
    outpatient_proc3_LENGTH_ErrorCount := COUNT(GROUP,h.outpatient_proc3_Invalid=3);
    outpatient_proc3_WORDS_ErrorCount := COUNT(GROUP,h.outpatient_proc3_Invalid=4);
    outpatient_proc3_Total_ErrorCount := COUNT(GROUP,h.outpatient_proc3_Invalid>0);
    principle_diag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.principle_diag_Invalid=1);
    principle_diag_ALLOW_ErrorCount := COUNT(GROUP,h.principle_diag_Invalid=2);
    principle_diag_LENGTH_ErrorCount := COUNT(GROUP,h.principle_diag_Invalid=3);
    principle_diag_WORDS_ErrorCount := COUNT(GROUP,h.principle_diag_Invalid=4);
    principle_diag_Total_ErrorCount := COUNT(GROUP,h.principle_diag_Invalid>0);
    principle_proc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.principle_proc_Invalid=1);
    principle_proc_ALLOW_ErrorCount := COUNT(GROUP,h.principle_proc_Invalid=2);
    principle_proc_LENGTH_ErrorCount := COUNT(GROUP,h.principle_proc_Invalid=3);
    principle_proc_WORDS_ErrorCount := COUNT(GROUP,h.principle_proc_Invalid=4);
    principle_proc_Total_ErrorCount := COUNT(GROUP,h.principle_proc_Invalid>0);
    service_from_LEFTTRIM_ErrorCount := COUNT(GROUP,h.service_from_Invalid=1);
    service_from_ALLOW_ErrorCount := COUNT(GROUP,h.service_from_Invalid=2);
    service_from_LENGTH_ErrorCount := COUNT(GROUP,h.service_from_Invalid=3);
    service_from_WORDS_ErrorCount := COUNT(GROUP,h.service_from_Invalid=4);
    service_from_Total_ErrorCount := COUNT(GROUP,h.service_from_Invalid>0);
    service_line_LEFTTRIM_ErrorCount := COUNT(GROUP,h.service_line_Invalid=1);
    service_line_ALLOW_ErrorCount := COUNT(GROUP,h.service_line_Invalid=2);
    service_line_LENGTH_ErrorCount := COUNT(GROUP,h.service_line_Invalid=3);
    service_line_WORDS_ErrorCount := COUNT(GROUP,h.service_line_Invalid=4);
    service_line_Total_ErrorCount := COUNT(GROUP,h.service_line_Invalid>0);
    service_to_LEFTTRIM_ErrorCount := COUNT(GROUP,h.service_to_Invalid=1);
    service_to_ALLOW_ErrorCount := COUNT(GROUP,h.service_to_Invalid=2);
    service_to_LENGTH_ErrorCount := COUNT(GROUP,h.service_to_Invalid=3);
    service_to_WORDS_ErrorCount := COUNT(GROUP,h.service_to_Invalid=4);
    service_to_Total_ErrorCount := COUNT(GROUP,h.service_to_Invalid>0);
    submitted_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.submitted_date_Invalid=1);
    submitted_date_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_date_Invalid=2);
    submitted_date_LENGTH_ErrorCount := COUNT(GROUP,h.submitted_date_Invalid=3);
    submitted_date_WORDS_ErrorCount := COUNT(GROUP,h.submitted_date_Invalid=4);
    submitted_date_Total_ErrorCount := COUNT(GROUP,h.submitted_date_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.claim_type_Invalid,le.claim_num_Invalid,le.attend_prov_id_Invalid,le.attend_prov_name_Invalid,le.billing_addr_Invalid,le.billing_city_Invalid,le.billing_npi_Invalid,le.billing_org_name_Invalid,le.billing_state_Invalid,le.billing_tax_id_Invalid,le.billing_zip_Invalid,le.inpatient_proc1_Invalid,le.inpatient_proc2_Invalid,le.inpatient_proc3_Invalid,le.operating_prov_id_Invalid,le.operating_prov_name_Invalid,le.other_diag1_Invalid,le.other_diag2_Invalid,le.other_diag3_Invalid,le.other_diag4_Invalid,le.other_diag5_Invalid,le.other_diag6_Invalid,le.other_diag7_Invalid,le.other_diag8_Invalid,le.other_proc1_Invalid,le.other_proc2_Invalid,le.other_proc3_Invalid,le.other_proc4_Invalid,le.other_proc5_Invalid,le.other_proc_method_code_Invalid,le.other_prov_id1_Invalid,le.other_prov_name1_Invalid,le.outpatient_proc1_Invalid,le.outpatient_proc2_Invalid,le.outpatient_proc3_Invalid,le.principle_diag_Invalid,le.principle_proc_Invalid,le.service_from_Invalid,le.service_line_Invalid,le.service_to_Invalid,le.submitted_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,HX_Fields.InvalidMessage_claim_type(le.claim_type_Invalid),HX_Fields.InvalidMessage_claim_num(le.claim_num_Invalid),HX_Fields.InvalidMessage_attend_prov_id(le.attend_prov_id_Invalid),HX_Fields.InvalidMessage_attend_prov_name(le.attend_prov_name_Invalid),HX_Fields.InvalidMessage_billing_addr(le.billing_addr_Invalid),HX_Fields.InvalidMessage_billing_city(le.billing_city_Invalid),HX_Fields.InvalidMessage_billing_npi(le.billing_npi_Invalid),HX_Fields.InvalidMessage_billing_org_name(le.billing_org_name_Invalid),HX_Fields.InvalidMessage_billing_state(le.billing_state_Invalid),HX_Fields.InvalidMessage_billing_tax_id(le.billing_tax_id_Invalid),HX_Fields.InvalidMessage_billing_zip(le.billing_zip_Invalid),HX_Fields.InvalidMessage_inpatient_proc1(le.inpatient_proc1_Invalid),HX_Fields.InvalidMessage_inpatient_proc2(le.inpatient_proc2_Invalid),HX_Fields.InvalidMessage_inpatient_proc3(le.inpatient_proc3_Invalid),HX_Fields.InvalidMessage_operating_prov_id(le.operating_prov_id_Invalid),HX_Fields.InvalidMessage_operating_prov_name(le.operating_prov_name_Invalid),HX_Fields.InvalidMessage_other_diag1(le.other_diag1_Invalid),HX_Fields.InvalidMessage_other_diag2(le.other_diag2_Invalid),HX_Fields.InvalidMessage_other_diag3(le.other_diag3_Invalid),HX_Fields.InvalidMessage_other_diag4(le.other_diag4_Invalid),HX_Fields.InvalidMessage_other_diag5(le.other_diag5_Invalid),HX_Fields.InvalidMessage_other_diag6(le.other_diag6_Invalid),HX_Fields.InvalidMessage_other_diag7(le.other_diag7_Invalid),HX_Fields.InvalidMessage_other_diag8(le.other_diag8_Invalid),HX_Fields.InvalidMessage_other_proc1(le.other_proc1_Invalid),HX_Fields.InvalidMessage_other_proc2(le.other_proc2_Invalid),HX_Fields.InvalidMessage_other_proc3(le.other_proc3_Invalid),HX_Fields.InvalidMessage_other_proc4(le.other_proc4_Invalid),HX_Fields.InvalidMessage_other_proc5(le.other_proc5_Invalid),HX_Fields.InvalidMessage_other_proc_method_code(le.other_proc_method_code_Invalid),HX_Fields.InvalidMessage_other_prov_id1(le.other_prov_id1_Invalid),HX_Fields.InvalidMessage_other_prov_name1(le.other_prov_name1_Invalid),HX_Fields.InvalidMessage_outpatient_proc1(le.outpatient_proc1_Invalid),HX_Fields.InvalidMessage_outpatient_proc2(le.outpatient_proc2_Invalid),HX_Fields.InvalidMessage_outpatient_proc3(le.outpatient_proc3_Invalid),HX_Fields.InvalidMessage_principle_diag(le.principle_diag_Invalid),HX_Fields.InvalidMessage_principle_proc(le.principle_proc_Invalid),HX_Fields.InvalidMessage_service_from(le.service_from_Invalid),HX_Fields.InvalidMessage_service_line(le.service_line_Invalid),HX_Fields.InvalidMessage_service_to(le.service_to_Invalid),HX_Fields.InvalidMessage_submitted_date(le.submitted_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.claim_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.claim_num_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.attend_prov_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.attend_prov_name_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_addr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.billing_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.billing_npi_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_org_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.billing_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_tax_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.inpatient_proc1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.inpatient_proc2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.inpatient_proc3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.operating_prov_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.operating_prov_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.other_diag1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_diag2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_diag3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_diag4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_diag5_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_diag6_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_diag7_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_diag8_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc5_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc_method_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_prov_id1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_prov_name1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.outpatient_proc1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.outpatient_proc2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.outpatient_proc3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.principle_diag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.principle_proc_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.service_from_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.service_line_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.service_to_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.submitted_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'claim_type','claim_num','attend_prov_id','attend_prov_name','billing_addr','billing_city','billing_npi','billing_org_name','billing_state','billing_tax_id','billing_zip','inpatient_proc1','inpatient_proc2','inpatient_proc3','operating_prov_id','operating_prov_name','other_diag1','other_diag2','other_diag3','other_diag4','other_diag5','other_diag6','other_diag7','other_diag8','other_proc1','other_proc2','other_proc3','other_proc4','other_proc5','other_proc_method_code','other_prov_id1','other_prov_name1','outpatient_proc1','outpatient_proc2','outpatient_proc3','principle_diag','principle_proc','service_from','service_line','service_to','submitted_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'claim_type','claim_num','attend_prov_id','attend_prov_name','billing_addr','billing_city','billing_npi','billing_org_name','billing_state','billing_tax_id','billing_zip','inpatient_proc1','inpatient_proc2','inpatient_proc3','operating_prov_id','operating_prov_name','other_diag1','other_diag2','other_diag3','other_diag4','other_diag5','other_diag6','other_diag7','other_diag8','other_proc1','other_proc2','other_proc3','other_proc4','other_proc5','other_proc_method_code','other_prov_id1','other_prov_name1','outpatient_proc1','outpatient_proc2','outpatient_proc3','principle_diag','principle_proc','service_from','service_line','service_to','submitted_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.claim_type,(SALT31.StrType)le.claim_num,(SALT31.StrType)le.attend_prov_id,(SALT31.StrType)le.attend_prov_name,(SALT31.StrType)le.billing_addr,(SALT31.StrType)le.billing_city,(SALT31.StrType)le.billing_npi,(SALT31.StrType)le.billing_org_name,(SALT31.StrType)le.billing_state,(SALT31.StrType)le.billing_tax_id,(SALT31.StrType)le.billing_zip,(SALT31.StrType)le.inpatient_proc1,(SALT31.StrType)le.inpatient_proc2,(SALT31.StrType)le.inpatient_proc3,(SALT31.StrType)le.operating_prov_id,(SALT31.StrType)le.operating_prov_name,(SALT31.StrType)le.other_diag1,(SALT31.StrType)le.other_diag2,(SALT31.StrType)le.other_diag3,(SALT31.StrType)le.other_diag4,(SALT31.StrType)le.other_diag5,(SALT31.StrType)le.other_diag6,(SALT31.StrType)le.other_diag7,(SALT31.StrType)le.other_diag8,(SALT31.StrType)le.other_proc1,(SALT31.StrType)le.other_proc2,(SALT31.StrType)le.other_proc3,(SALT31.StrType)le.other_proc4,(SALT31.StrType)le.other_proc5,(SALT31.StrType)le.other_proc_method_code,(SALT31.StrType)le.other_prov_id1,(SALT31.StrType)le.other_prov_name1,(SALT31.StrType)le.outpatient_proc1,(SALT31.StrType)le.outpatient_proc2,(SALT31.StrType)le.outpatient_proc3,(SALT31.StrType)le.principle_diag,(SALT31.StrType)le.principle_proc,(SALT31.StrType)le.service_from,(SALT31.StrType)le.service_line,(SALT31.StrType)le.service_to,(SALT31.StrType)le.submitted_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,41,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'claim_type:claim_type:LEFTTRIM','claim_type:claim_type:ALLOW','claim_type:claim_type:LENGTH','claim_type:claim_type:WORDS'
          ,'claim_num:claim_num:LEFTTRIM','claim_num:claim_num:ALLOW','claim_num:claim_num:LENGTH','claim_num:claim_num:WORDS'
          ,'attend_prov_id:attend_prov_id:LEFTTRIM','attend_prov_id:attend_prov_id:ALLOW','attend_prov_id:attend_prov_id:LENGTH','attend_prov_id:attend_prov_id:WORDS'
          ,'attend_prov_name:attend_prov_name:LEFTTRIM','attend_prov_name:attend_prov_name:ALLOW','attend_prov_name:attend_prov_name:WORDS'
          ,'billing_addr:billing_addr:ALLOW'
          ,'billing_city:billing_city:ALLOW'
          ,'billing_npi:billing_npi:LEFTTRIM','billing_npi:billing_npi:ALLOW','billing_npi:billing_npi:LENGTH','billing_npi:billing_npi:WORDS'
          ,'billing_org_name:billing_org_name:LEFTTRIM','billing_org_name:billing_org_name:ALLOW'
          ,'billing_state:billing_state:LEFTTRIM','billing_state:billing_state:ALLOW','billing_state:billing_state:LENGTH','billing_state:billing_state:WORDS'
          ,'billing_tax_id:billing_tax_id:LEFTTRIM','billing_tax_id:billing_tax_id:ALLOW','billing_tax_id:billing_tax_id:LENGTH','billing_tax_id:billing_tax_id:WORDS'
          ,'billing_zip:billing_zip:LEFTTRIM','billing_zip:billing_zip:ALLOW','billing_zip:billing_zip:LENGTH','billing_zip:billing_zip:WORDS'
          ,'inpatient_proc1:inpatient_proc1:LEFTTRIM','inpatient_proc1:inpatient_proc1:ALLOW','inpatient_proc1:inpatient_proc1:LENGTH','inpatient_proc1:inpatient_proc1:WORDS'
          ,'inpatient_proc2:inpatient_proc2:LEFTTRIM','inpatient_proc2:inpatient_proc2:ALLOW','inpatient_proc2:inpatient_proc2:LENGTH','inpatient_proc2:inpatient_proc2:WORDS'
          ,'inpatient_proc3:inpatient_proc3:LEFTTRIM','inpatient_proc3:inpatient_proc3:ALLOW','inpatient_proc3:inpatient_proc3:LENGTH','inpatient_proc3:inpatient_proc3:WORDS'
          ,'operating_prov_id:operating_prov_id:LEFTTRIM','operating_prov_id:operating_prov_id:ALLOW','operating_prov_id:operating_prov_id:LENGTH','operating_prov_id:operating_prov_id:WORDS'
          ,'operating_prov_name:operating_prov_name:LEFTTRIM','operating_prov_name:operating_prov_name:ALLOW'
          ,'other_diag1:other_diag1:LEFTTRIM','other_diag1:other_diag1:ALLOW','other_diag1:other_diag1:LENGTH','other_diag1:other_diag1:WORDS'
          ,'other_diag2:other_diag2:LEFTTRIM','other_diag2:other_diag2:ALLOW','other_diag2:other_diag2:LENGTH','other_diag2:other_diag2:WORDS'
          ,'other_diag3:other_diag3:LEFTTRIM','other_diag3:other_diag3:ALLOW','other_diag3:other_diag3:LENGTH','other_diag3:other_diag3:WORDS'
          ,'other_diag4:other_diag4:LEFTTRIM','other_diag4:other_diag4:ALLOW','other_diag4:other_diag4:LENGTH','other_diag4:other_diag4:WORDS'
          ,'other_diag5:other_diag5:LEFTTRIM','other_diag5:other_diag5:ALLOW','other_diag5:other_diag5:LENGTH','other_diag5:other_diag5:WORDS'
          ,'other_diag6:other_diag6:LEFTTRIM','other_diag6:other_diag6:ALLOW','other_diag6:other_diag6:LENGTH','other_diag6:other_diag6:WORDS'
          ,'other_diag7:other_diag7:LEFTTRIM','other_diag7:other_diag7:ALLOW','other_diag7:other_diag7:LENGTH','other_diag7:other_diag7:WORDS'
          ,'other_diag8:other_diag8:LEFTTRIM','other_diag8:other_diag8:ALLOW','other_diag8:other_diag8:LENGTH','other_diag8:other_diag8:WORDS'
          ,'other_proc1:other_proc1:LEFTTRIM','other_proc1:other_proc1:ALLOW','other_proc1:other_proc1:LENGTH','other_proc1:other_proc1:WORDS'
          ,'other_proc2:other_proc2:LEFTTRIM','other_proc2:other_proc2:ALLOW','other_proc2:other_proc2:LENGTH','other_proc2:other_proc2:WORDS'
          ,'other_proc3:other_proc3:LEFTTRIM','other_proc3:other_proc3:ALLOW','other_proc3:other_proc3:LENGTH','other_proc3:other_proc3:WORDS'
          ,'other_proc4:other_proc4:LEFTTRIM','other_proc4:other_proc4:ALLOW','other_proc4:other_proc4:LENGTH','other_proc4:other_proc4:WORDS'
          ,'other_proc5:other_proc5:LEFTTRIM','other_proc5:other_proc5:ALLOW','other_proc5:other_proc5:LENGTH','other_proc5:other_proc5:WORDS'
          ,'other_proc_method_code:other_proc_method_code:LEFTTRIM','other_proc_method_code:other_proc_method_code:ALLOW','other_proc_method_code:other_proc_method_code:LENGTH','other_proc_method_code:other_proc_method_code:WORDS'
          ,'other_prov_id1:other_prov_id1:LEFTTRIM','other_prov_id1:other_prov_id1:ALLOW','other_prov_id1:other_prov_id1:LENGTH','other_prov_id1:other_prov_id1:WORDS'
          ,'other_prov_name1:other_prov_name1:LEFTTRIM','other_prov_name1:other_prov_name1:ALLOW'
          ,'outpatient_proc1:outpatient_proc1:LEFTTRIM','outpatient_proc1:outpatient_proc1:ALLOW','outpatient_proc1:outpatient_proc1:LENGTH','outpatient_proc1:outpatient_proc1:WORDS'
          ,'outpatient_proc2:outpatient_proc2:LEFTTRIM','outpatient_proc2:outpatient_proc2:ALLOW','outpatient_proc2:outpatient_proc2:LENGTH','outpatient_proc2:outpatient_proc2:WORDS'
          ,'outpatient_proc3:outpatient_proc3:LEFTTRIM','outpatient_proc3:outpatient_proc3:ALLOW','outpatient_proc3:outpatient_proc3:LENGTH','outpatient_proc3:outpatient_proc3:WORDS'
          ,'principle_diag:principle_diag:LEFTTRIM','principle_diag:principle_diag:ALLOW','principle_diag:principle_diag:LENGTH','principle_diag:principle_diag:WORDS'
          ,'principle_proc:principle_proc:LEFTTRIM','principle_proc:principle_proc:ALLOW','principle_proc:principle_proc:LENGTH','principle_proc:principle_proc:WORDS'
          ,'service_from:service_from:LEFTTRIM','service_from:service_from:ALLOW','service_from:service_from:LENGTH','service_from:service_from:WORDS'
          ,'service_line:service_line:LEFTTRIM','service_line:service_line:ALLOW','service_line:service_line:LENGTH','service_line:service_line:WORDS'
          ,'service_to:service_to:LEFTTRIM','service_to:service_to:ALLOW','service_to:service_to:LENGTH','service_to:service_to:WORDS'
          ,'submitted_date:submitted_date:LEFTTRIM','submitted_date:submitted_date:ALLOW','submitted_date:submitted_date:LENGTH','submitted_date:submitted_date:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,HX_Fields.InvalidMessage_claim_type(1),HX_Fields.InvalidMessage_claim_type(2),HX_Fields.InvalidMessage_claim_type(3),HX_Fields.InvalidMessage_claim_type(4)
          ,HX_Fields.InvalidMessage_claim_num(1),HX_Fields.InvalidMessage_claim_num(2),HX_Fields.InvalidMessage_claim_num(3),HX_Fields.InvalidMessage_claim_num(4)
          ,HX_Fields.InvalidMessage_attend_prov_id(1),HX_Fields.InvalidMessage_attend_prov_id(2),HX_Fields.InvalidMessage_attend_prov_id(3),HX_Fields.InvalidMessage_attend_prov_id(4)
          ,HX_Fields.InvalidMessage_attend_prov_name(1),HX_Fields.InvalidMessage_attend_prov_name(2),HX_Fields.InvalidMessage_attend_prov_name(3)
          ,HX_Fields.InvalidMessage_billing_addr(1)
          ,HX_Fields.InvalidMessage_billing_city(1)
          ,HX_Fields.InvalidMessage_billing_npi(1),HX_Fields.InvalidMessage_billing_npi(2),HX_Fields.InvalidMessage_billing_npi(3),HX_Fields.InvalidMessage_billing_npi(4)
          ,HX_Fields.InvalidMessage_billing_org_name(1),HX_Fields.InvalidMessage_billing_org_name(2)
          ,HX_Fields.InvalidMessage_billing_state(1),HX_Fields.InvalidMessage_billing_state(2),HX_Fields.InvalidMessage_billing_state(3),HX_Fields.InvalidMessage_billing_state(4)
          ,HX_Fields.InvalidMessage_billing_tax_id(1),HX_Fields.InvalidMessage_billing_tax_id(2),HX_Fields.InvalidMessage_billing_tax_id(3),HX_Fields.InvalidMessage_billing_tax_id(4)
          ,HX_Fields.InvalidMessage_billing_zip(1),HX_Fields.InvalidMessage_billing_zip(2),HX_Fields.InvalidMessage_billing_zip(3),HX_Fields.InvalidMessage_billing_zip(4)
          ,HX_Fields.InvalidMessage_inpatient_proc1(1),HX_Fields.InvalidMessage_inpatient_proc1(2),HX_Fields.InvalidMessage_inpatient_proc1(3),HX_Fields.InvalidMessage_inpatient_proc1(4)
          ,HX_Fields.InvalidMessage_inpatient_proc2(1),HX_Fields.InvalidMessage_inpatient_proc2(2),HX_Fields.InvalidMessage_inpatient_proc2(3),HX_Fields.InvalidMessage_inpatient_proc2(4)
          ,HX_Fields.InvalidMessage_inpatient_proc3(1),HX_Fields.InvalidMessage_inpatient_proc3(2),HX_Fields.InvalidMessage_inpatient_proc3(3),HX_Fields.InvalidMessage_inpatient_proc3(4)
          ,HX_Fields.InvalidMessage_operating_prov_id(1),HX_Fields.InvalidMessage_operating_prov_id(2),HX_Fields.InvalidMessage_operating_prov_id(3),HX_Fields.InvalidMessage_operating_prov_id(4)
          ,HX_Fields.InvalidMessage_operating_prov_name(1),HX_Fields.InvalidMessage_operating_prov_name(2)
          ,HX_Fields.InvalidMessage_other_diag1(1),HX_Fields.InvalidMessage_other_diag1(2),HX_Fields.InvalidMessage_other_diag1(3),HX_Fields.InvalidMessage_other_diag1(4)
          ,HX_Fields.InvalidMessage_other_diag2(1),HX_Fields.InvalidMessage_other_diag2(2),HX_Fields.InvalidMessage_other_diag2(3),HX_Fields.InvalidMessage_other_diag2(4)
          ,HX_Fields.InvalidMessage_other_diag3(1),HX_Fields.InvalidMessage_other_diag3(2),HX_Fields.InvalidMessage_other_diag3(3),HX_Fields.InvalidMessage_other_diag3(4)
          ,HX_Fields.InvalidMessage_other_diag4(1),HX_Fields.InvalidMessage_other_diag4(2),HX_Fields.InvalidMessage_other_diag4(3),HX_Fields.InvalidMessage_other_diag4(4)
          ,HX_Fields.InvalidMessage_other_diag5(1),HX_Fields.InvalidMessage_other_diag5(2),HX_Fields.InvalidMessage_other_diag5(3),HX_Fields.InvalidMessage_other_diag5(4)
          ,HX_Fields.InvalidMessage_other_diag6(1),HX_Fields.InvalidMessage_other_diag6(2),HX_Fields.InvalidMessage_other_diag6(3),HX_Fields.InvalidMessage_other_diag6(4)
          ,HX_Fields.InvalidMessage_other_diag7(1),HX_Fields.InvalidMessage_other_diag7(2),HX_Fields.InvalidMessage_other_diag7(3),HX_Fields.InvalidMessage_other_diag7(4)
          ,HX_Fields.InvalidMessage_other_diag8(1),HX_Fields.InvalidMessage_other_diag8(2),HX_Fields.InvalidMessage_other_diag8(3),HX_Fields.InvalidMessage_other_diag8(4)
          ,HX_Fields.InvalidMessage_other_proc1(1),HX_Fields.InvalidMessage_other_proc1(2),HX_Fields.InvalidMessage_other_proc1(3),HX_Fields.InvalidMessage_other_proc1(4)
          ,HX_Fields.InvalidMessage_other_proc2(1),HX_Fields.InvalidMessage_other_proc2(2),HX_Fields.InvalidMessage_other_proc2(3),HX_Fields.InvalidMessage_other_proc2(4)
          ,HX_Fields.InvalidMessage_other_proc3(1),HX_Fields.InvalidMessage_other_proc3(2),HX_Fields.InvalidMessage_other_proc3(3),HX_Fields.InvalidMessage_other_proc3(4)
          ,HX_Fields.InvalidMessage_other_proc4(1),HX_Fields.InvalidMessage_other_proc4(2),HX_Fields.InvalidMessage_other_proc4(3),HX_Fields.InvalidMessage_other_proc4(4)
          ,HX_Fields.InvalidMessage_other_proc5(1),HX_Fields.InvalidMessage_other_proc5(2),HX_Fields.InvalidMessage_other_proc5(3),HX_Fields.InvalidMessage_other_proc5(4)
          ,HX_Fields.InvalidMessage_other_proc_method_code(1),HX_Fields.InvalidMessage_other_proc_method_code(2),HX_Fields.InvalidMessage_other_proc_method_code(3),HX_Fields.InvalidMessage_other_proc_method_code(4)
          ,HX_Fields.InvalidMessage_other_prov_id1(1),HX_Fields.InvalidMessage_other_prov_id1(2),HX_Fields.InvalidMessage_other_prov_id1(3),HX_Fields.InvalidMessage_other_prov_id1(4)
          ,HX_Fields.InvalidMessage_other_prov_name1(1),HX_Fields.InvalidMessage_other_prov_name1(2)
          ,HX_Fields.InvalidMessage_outpatient_proc1(1),HX_Fields.InvalidMessage_outpatient_proc1(2),HX_Fields.InvalidMessage_outpatient_proc1(3),HX_Fields.InvalidMessage_outpatient_proc1(4)
          ,HX_Fields.InvalidMessage_outpatient_proc2(1),HX_Fields.InvalidMessage_outpatient_proc2(2),HX_Fields.InvalidMessage_outpatient_proc2(3),HX_Fields.InvalidMessage_outpatient_proc2(4)
          ,HX_Fields.InvalidMessage_outpatient_proc3(1),HX_Fields.InvalidMessage_outpatient_proc3(2),HX_Fields.InvalidMessage_outpatient_proc3(3),HX_Fields.InvalidMessage_outpatient_proc3(4)
          ,HX_Fields.InvalidMessage_principle_diag(1),HX_Fields.InvalidMessage_principle_diag(2),HX_Fields.InvalidMessage_principle_diag(3),HX_Fields.InvalidMessage_principle_diag(4)
          ,HX_Fields.InvalidMessage_principle_proc(1),HX_Fields.InvalidMessage_principle_proc(2),HX_Fields.InvalidMessage_principle_proc(3),HX_Fields.InvalidMessage_principle_proc(4)
          ,HX_Fields.InvalidMessage_service_from(1),HX_Fields.InvalidMessage_service_from(2),HX_Fields.InvalidMessage_service_from(3),HX_Fields.InvalidMessage_service_from(4)
          ,HX_Fields.InvalidMessage_service_line(1),HX_Fields.InvalidMessage_service_line(2),HX_Fields.InvalidMessage_service_line(3),HX_Fields.InvalidMessage_service_line(4)
          ,HX_Fields.InvalidMessage_service_to(1),HX_Fields.InvalidMessage_service_to(2),HX_Fields.InvalidMessage_service_to(3),HX_Fields.InvalidMessage_service_to(4)
          ,HX_Fields.InvalidMessage_submitted_date(1),HX_Fields.InvalidMessage_submitted_date(2),HX_Fields.InvalidMessage_submitted_date(3),HX_Fields.InvalidMessage_submitted_date(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.claim_type_LEFTTRIM_ErrorCount,le.claim_type_ALLOW_ErrorCount,le.claim_type_LENGTH_ErrorCount,le.claim_type_WORDS_ErrorCount
          ,le.claim_num_LEFTTRIM_ErrorCount,le.claim_num_ALLOW_ErrorCount,le.claim_num_LENGTH_ErrorCount,le.claim_num_WORDS_ErrorCount
          ,le.attend_prov_id_LEFTTRIM_ErrorCount,le.attend_prov_id_ALLOW_ErrorCount,le.attend_prov_id_LENGTH_ErrorCount,le.attend_prov_id_WORDS_ErrorCount
          ,le.attend_prov_name_LEFTTRIM_ErrorCount,le.attend_prov_name_ALLOW_ErrorCount,le.attend_prov_name_WORDS_ErrorCount
          ,le.billing_addr_ALLOW_ErrorCount
          ,le.billing_city_ALLOW_ErrorCount
          ,le.billing_npi_LEFTTRIM_ErrorCount,le.billing_npi_ALLOW_ErrorCount,le.billing_npi_LENGTH_ErrorCount,le.billing_npi_WORDS_ErrorCount
          ,le.billing_org_name_LEFTTRIM_ErrorCount,le.billing_org_name_ALLOW_ErrorCount
          ,le.billing_state_LEFTTRIM_ErrorCount,le.billing_state_ALLOW_ErrorCount,le.billing_state_LENGTH_ErrorCount,le.billing_state_WORDS_ErrorCount
          ,le.billing_tax_id_LEFTTRIM_ErrorCount,le.billing_tax_id_ALLOW_ErrorCount,le.billing_tax_id_LENGTH_ErrorCount,le.billing_tax_id_WORDS_ErrorCount
          ,le.billing_zip_LEFTTRIM_ErrorCount,le.billing_zip_ALLOW_ErrorCount,le.billing_zip_LENGTH_ErrorCount,le.billing_zip_WORDS_ErrorCount
          ,le.inpatient_proc1_LEFTTRIM_ErrorCount,le.inpatient_proc1_ALLOW_ErrorCount,le.inpatient_proc1_LENGTH_ErrorCount,le.inpatient_proc1_WORDS_ErrorCount
          ,le.inpatient_proc2_LEFTTRIM_ErrorCount,le.inpatient_proc2_ALLOW_ErrorCount,le.inpatient_proc2_LENGTH_ErrorCount,le.inpatient_proc2_WORDS_ErrorCount
          ,le.inpatient_proc3_LEFTTRIM_ErrorCount,le.inpatient_proc3_ALLOW_ErrorCount,le.inpatient_proc3_LENGTH_ErrorCount,le.inpatient_proc3_WORDS_ErrorCount
          ,le.operating_prov_id_LEFTTRIM_ErrorCount,le.operating_prov_id_ALLOW_ErrorCount,le.operating_prov_id_LENGTH_ErrorCount,le.operating_prov_id_WORDS_ErrorCount
          ,le.operating_prov_name_LEFTTRIM_ErrorCount,le.operating_prov_name_ALLOW_ErrorCount
          ,le.other_diag1_LEFTTRIM_ErrorCount,le.other_diag1_ALLOW_ErrorCount,le.other_diag1_LENGTH_ErrorCount,le.other_diag1_WORDS_ErrorCount
          ,le.other_diag2_LEFTTRIM_ErrorCount,le.other_diag2_ALLOW_ErrorCount,le.other_diag2_LENGTH_ErrorCount,le.other_diag2_WORDS_ErrorCount
          ,le.other_diag3_LEFTTRIM_ErrorCount,le.other_diag3_ALLOW_ErrorCount,le.other_diag3_LENGTH_ErrorCount,le.other_diag3_WORDS_ErrorCount
          ,le.other_diag4_LEFTTRIM_ErrorCount,le.other_diag4_ALLOW_ErrorCount,le.other_diag4_LENGTH_ErrorCount,le.other_diag4_WORDS_ErrorCount
          ,le.other_diag5_LEFTTRIM_ErrorCount,le.other_diag5_ALLOW_ErrorCount,le.other_diag5_LENGTH_ErrorCount,le.other_diag5_WORDS_ErrorCount
          ,le.other_diag6_LEFTTRIM_ErrorCount,le.other_diag6_ALLOW_ErrorCount,le.other_diag6_LENGTH_ErrorCount,le.other_diag6_WORDS_ErrorCount
          ,le.other_diag7_LEFTTRIM_ErrorCount,le.other_diag7_ALLOW_ErrorCount,le.other_diag7_LENGTH_ErrorCount,le.other_diag7_WORDS_ErrorCount
          ,le.other_diag8_LEFTTRIM_ErrorCount,le.other_diag8_ALLOW_ErrorCount,le.other_diag8_LENGTH_ErrorCount,le.other_diag8_WORDS_ErrorCount
          ,le.other_proc1_LEFTTRIM_ErrorCount,le.other_proc1_ALLOW_ErrorCount,le.other_proc1_LENGTH_ErrorCount,le.other_proc1_WORDS_ErrorCount
          ,le.other_proc2_LEFTTRIM_ErrorCount,le.other_proc2_ALLOW_ErrorCount,le.other_proc2_LENGTH_ErrorCount,le.other_proc2_WORDS_ErrorCount
          ,le.other_proc3_LEFTTRIM_ErrorCount,le.other_proc3_ALLOW_ErrorCount,le.other_proc3_LENGTH_ErrorCount,le.other_proc3_WORDS_ErrorCount
          ,le.other_proc4_LEFTTRIM_ErrorCount,le.other_proc4_ALLOW_ErrorCount,le.other_proc4_LENGTH_ErrorCount,le.other_proc4_WORDS_ErrorCount
          ,le.other_proc5_LEFTTRIM_ErrorCount,le.other_proc5_ALLOW_ErrorCount,le.other_proc5_LENGTH_ErrorCount,le.other_proc5_WORDS_ErrorCount
          ,le.other_proc_method_code_LEFTTRIM_ErrorCount,le.other_proc_method_code_ALLOW_ErrorCount,le.other_proc_method_code_LENGTH_ErrorCount,le.other_proc_method_code_WORDS_ErrorCount
          ,le.other_prov_id1_LEFTTRIM_ErrorCount,le.other_prov_id1_ALLOW_ErrorCount,le.other_prov_id1_LENGTH_ErrorCount,le.other_prov_id1_WORDS_ErrorCount
          ,le.other_prov_name1_LEFTTRIM_ErrorCount,le.other_prov_name1_ALLOW_ErrorCount
          ,le.outpatient_proc1_LEFTTRIM_ErrorCount,le.outpatient_proc1_ALLOW_ErrorCount,le.outpatient_proc1_LENGTH_ErrorCount,le.outpatient_proc1_WORDS_ErrorCount
          ,le.outpatient_proc2_LEFTTRIM_ErrorCount,le.outpatient_proc2_ALLOW_ErrorCount,le.outpatient_proc2_LENGTH_ErrorCount,le.outpatient_proc2_WORDS_ErrorCount
          ,le.outpatient_proc3_LEFTTRIM_ErrorCount,le.outpatient_proc3_ALLOW_ErrorCount,le.outpatient_proc3_LENGTH_ErrorCount,le.outpatient_proc3_WORDS_ErrorCount
          ,le.principle_diag_LEFTTRIM_ErrorCount,le.principle_diag_ALLOW_ErrorCount,le.principle_diag_LENGTH_ErrorCount,le.principle_diag_WORDS_ErrorCount
          ,le.principle_proc_LEFTTRIM_ErrorCount,le.principle_proc_ALLOW_ErrorCount,le.principle_proc_LENGTH_ErrorCount,le.principle_proc_WORDS_ErrorCount
          ,le.service_from_LEFTTRIM_ErrorCount,le.service_from_ALLOW_ErrorCount,le.service_from_LENGTH_ErrorCount,le.service_from_WORDS_ErrorCount
          ,le.service_line_LEFTTRIM_ErrorCount,le.service_line_ALLOW_ErrorCount,le.service_line_LENGTH_ErrorCount,le.service_line_WORDS_ErrorCount
          ,le.service_to_LEFTTRIM_ErrorCount,le.service_to_ALLOW_ErrorCount,le.service_to_LENGTH_ErrorCount,le.service_to_WORDS_ErrorCount
          ,le.submitted_date_LEFTTRIM_ErrorCount,le.submitted_date_ALLOW_ErrorCount,le.submitted_date_LENGTH_ErrorCount,le.submitted_date_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.claim_type_LEFTTRIM_ErrorCount,le.claim_type_ALLOW_ErrorCount,le.claim_type_LENGTH_ErrorCount,le.claim_type_WORDS_ErrorCount
          ,le.claim_num_LEFTTRIM_ErrorCount,le.claim_num_ALLOW_ErrorCount,le.claim_num_LENGTH_ErrorCount,le.claim_num_WORDS_ErrorCount
          ,le.attend_prov_id_LEFTTRIM_ErrorCount,le.attend_prov_id_ALLOW_ErrorCount,le.attend_prov_id_LENGTH_ErrorCount,le.attend_prov_id_WORDS_ErrorCount
          ,le.attend_prov_name_LEFTTRIM_ErrorCount,le.attend_prov_name_ALLOW_ErrorCount,le.attend_prov_name_WORDS_ErrorCount
          ,le.billing_addr_ALLOW_ErrorCount
          ,le.billing_city_ALLOW_ErrorCount
          ,le.billing_npi_LEFTTRIM_ErrorCount,le.billing_npi_ALLOW_ErrorCount,le.billing_npi_LENGTH_ErrorCount,le.billing_npi_WORDS_ErrorCount
          ,le.billing_org_name_LEFTTRIM_ErrorCount,le.billing_org_name_ALLOW_ErrorCount
          ,le.billing_state_LEFTTRIM_ErrorCount,le.billing_state_ALLOW_ErrorCount,le.billing_state_LENGTH_ErrorCount,le.billing_state_WORDS_ErrorCount
          ,le.billing_tax_id_LEFTTRIM_ErrorCount,le.billing_tax_id_ALLOW_ErrorCount,le.billing_tax_id_LENGTH_ErrorCount,le.billing_tax_id_WORDS_ErrorCount
          ,le.billing_zip_LEFTTRIM_ErrorCount,le.billing_zip_ALLOW_ErrorCount,le.billing_zip_LENGTH_ErrorCount,le.billing_zip_WORDS_ErrorCount
          ,le.inpatient_proc1_LEFTTRIM_ErrorCount,le.inpatient_proc1_ALLOW_ErrorCount,le.inpatient_proc1_LENGTH_ErrorCount,le.inpatient_proc1_WORDS_ErrorCount
          ,le.inpatient_proc2_LEFTTRIM_ErrorCount,le.inpatient_proc2_ALLOW_ErrorCount,le.inpatient_proc2_LENGTH_ErrorCount,le.inpatient_proc2_WORDS_ErrorCount
          ,le.inpatient_proc3_LEFTTRIM_ErrorCount,le.inpatient_proc3_ALLOW_ErrorCount,le.inpatient_proc3_LENGTH_ErrorCount,le.inpatient_proc3_WORDS_ErrorCount
          ,le.operating_prov_id_LEFTTRIM_ErrorCount,le.operating_prov_id_ALLOW_ErrorCount,le.operating_prov_id_LENGTH_ErrorCount,le.operating_prov_id_WORDS_ErrorCount
          ,le.operating_prov_name_LEFTTRIM_ErrorCount,le.operating_prov_name_ALLOW_ErrorCount
          ,le.other_diag1_LEFTTRIM_ErrorCount,le.other_diag1_ALLOW_ErrorCount,le.other_diag1_LENGTH_ErrorCount,le.other_diag1_WORDS_ErrorCount
          ,le.other_diag2_LEFTTRIM_ErrorCount,le.other_diag2_ALLOW_ErrorCount,le.other_diag2_LENGTH_ErrorCount,le.other_diag2_WORDS_ErrorCount
          ,le.other_diag3_LEFTTRIM_ErrorCount,le.other_diag3_ALLOW_ErrorCount,le.other_diag3_LENGTH_ErrorCount,le.other_diag3_WORDS_ErrorCount
          ,le.other_diag4_LEFTTRIM_ErrorCount,le.other_diag4_ALLOW_ErrorCount,le.other_diag4_LENGTH_ErrorCount,le.other_diag4_WORDS_ErrorCount
          ,le.other_diag5_LEFTTRIM_ErrorCount,le.other_diag5_ALLOW_ErrorCount,le.other_diag5_LENGTH_ErrorCount,le.other_diag5_WORDS_ErrorCount
          ,le.other_diag6_LEFTTRIM_ErrorCount,le.other_diag6_ALLOW_ErrorCount,le.other_diag6_LENGTH_ErrorCount,le.other_diag6_WORDS_ErrorCount
          ,le.other_diag7_LEFTTRIM_ErrorCount,le.other_diag7_ALLOW_ErrorCount,le.other_diag7_LENGTH_ErrorCount,le.other_diag7_WORDS_ErrorCount
          ,le.other_diag8_LEFTTRIM_ErrorCount,le.other_diag8_ALLOW_ErrorCount,le.other_diag8_LENGTH_ErrorCount,le.other_diag8_WORDS_ErrorCount
          ,le.other_proc1_LEFTTRIM_ErrorCount,le.other_proc1_ALLOW_ErrorCount,le.other_proc1_LENGTH_ErrorCount,le.other_proc1_WORDS_ErrorCount
          ,le.other_proc2_LEFTTRIM_ErrorCount,le.other_proc2_ALLOW_ErrorCount,le.other_proc2_LENGTH_ErrorCount,le.other_proc2_WORDS_ErrorCount
          ,le.other_proc3_LEFTTRIM_ErrorCount,le.other_proc3_ALLOW_ErrorCount,le.other_proc3_LENGTH_ErrorCount,le.other_proc3_WORDS_ErrorCount
          ,le.other_proc4_LEFTTRIM_ErrorCount,le.other_proc4_ALLOW_ErrorCount,le.other_proc4_LENGTH_ErrorCount,le.other_proc4_WORDS_ErrorCount
          ,le.other_proc5_LEFTTRIM_ErrorCount,le.other_proc5_ALLOW_ErrorCount,le.other_proc5_LENGTH_ErrorCount,le.other_proc5_WORDS_ErrorCount
          ,le.other_proc_method_code_LEFTTRIM_ErrorCount,le.other_proc_method_code_ALLOW_ErrorCount,le.other_proc_method_code_LENGTH_ErrorCount,le.other_proc_method_code_WORDS_ErrorCount
          ,le.other_prov_id1_LEFTTRIM_ErrorCount,le.other_prov_id1_ALLOW_ErrorCount,le.other_prov_id1_LENGTH_ErrorCount,le.other_prov_id1_WORDS_ErrorCount
          ,le.other_prov_name1_LEFTTRIM_ErrorCount,le.other_prov_name1_ALLOW_ErrorCount
          ,le.outpatient_proc1_LEFTTRIM_ErrorCount,le.outpatient_proc1_ALLOW_ErrorCount,le.outpatient_proc1_LENGTH_ErrorCount,le.outpatient_proc1_WORDS_ErrorCount
          ,le.outpatient_proc2_LEFTTRIM_ErrorCount,le.outpatient_proc2_ALLOW_ErrorCount,le.outpatient_proc2_LENGTH_ErrorCount,le.outpatient_proc2_WORDS_ErrorCount
          ,le.outpatient_proc3_LEFTTRIM_ErrorCount,le.outpatient_proc3_ALLOW_ErrorCount,le.outpatient_proc3_LENGTH_ErrorCount,le.outpatient_proc3_WORDS_ErrorCount
          ,le.principle_diag_LEFTTRIM_ErrorCount,le.principle_diag_ALLOW_ErrorCount,le.principle_diag_LENGTH_ErrorCount,le.principle_diag_WORDS_ErrorCount
          ,le.principle_proc_LEFTTRIM_ErrorCount,le.principle_proc_ALLOW_ErrorCount,le.principle_proc_LENGTH_ErrorCount,le.principle_proc_WORDS_ErrorCount
          ,le.service_from_LEFTTRIM_ErrorCount,le.service_from_ALLOW_ErrorCount,le.service_from_LENGTH_ErrorCount,le.service_from_WORDS_ErrorCount
          ,le.service_line_LEFTTRIM_ErrorCount,le.service_line_ALLOW_ErrorCount,le.service_line_LENGTH_ErrorCount,le.service_line_WORDS_ErrorCount
          ,le.service_to_LEFTTRIM_ErrorCount,le.service_to_ALLOW_ErrorCount,le.service_to_LENGTH_ErrorCount,le.service_to_WORDS_ErrorCount
          ,le.submitted_date_LEFTTRIM_ErrorCount,le.submitted_date_ALLOW_ErrorCount,le.submitted_date_LENGTH_ErrorCount,le.submitted_date_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,151,Into(LEFT,COUNTER));
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
