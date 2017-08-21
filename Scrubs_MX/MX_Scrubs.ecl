IMPORT ut,SALT31;
EXPORT MX_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(MX_Layout_MX)
    UNSIGNED1 claim_type_Invalid;
    UNSIGNED1 claim_num_Invalid;
    UNSIGNED1 billing_addr_Invalid;
    UNSIGNED1 billing_city_Invalid;
    UNSIGNED1 billing_first_name_Invalid;
    UNSIGNED1 billing_last_name_Invalid;
    UNSIGNED1 billing_npi_Invalid;
    UNSIGNED1 billing_org_name_Invalid;
    UNSIGNED1 billing_specialty_code_Invalid;
    UNSIGNED1 billing_state_Invalid;
    UNSIGNED1 billing_tax_id_Invalid;
    UNSIGNED1 billing_upin_Invalid;
    UNSIGNED1 billing_zip_Invalid;
    UNSIGNED1 diag_code1_Invalid;
    UNSIGNED1 diag_code2_Invalid;
    UNSIGNED1 diag_code3_Invalid;
    UNSIGNED1 diag_code4_Invalid;
    UNSIGNED1 diag_code5_Invalid;
    UNSIGNED1 diag_code6_Invalid;
    UNSIGNED1 diag_code7_Invalid;
    UNSIGNED1 diag_code8_Invalid;
    UNSIGNED1 ext_injury_diag_code_Invalid;
    UNSIGNED1 facility_lab_addr_Invalid;
    UNSIGNED1 facility_lab_city_Invalid;
    UNSIGNED1 facility_lab_name_Invalid;
    UNSIGNED1 facility_lab_npi_Invalid;
    UNSIGNED1 facility_lab_state_Invalid;
    UNSIGNED1 facility_lab_zip_Invalid;
    UNSIGNED1 ordering_prov_first_name_Invalid;
    UNSIGNED1 ordering_prov_last_name_Invalid;
    UNSIGNED1 ordering_prov_middle_name_Invalid;
    UNSIGNED1 ordering_prov_npi_Invalid;
    UNSIGNED1 ordering_prov_state_Invalid;
    UNSIGNED1 pay_to_addr_Invalid;
    UNSIGNED1 pay_to_city_Invalid;
    UNSIGNED1 pay_to_state_Invalid;
    UNSIGNED1 pay_to_zip_Invalid;
    UNSIGNED1 performing_prov_tax_id_Invalid;
    UNSIGNED1 place_of_service_code_Invalid;
    UNSIGNED1 place_of_service_name_Invalid;
    UNSIGNED1 prov_a_addr_Invalid;
    UNSIGNED1 prov_a_city_Invalid;
    UNSIGNED1 prov_a_service_role_code_Invalid;
    UNSIGNED1 prov_a_state_Invalid;
    UNSIGNED1 prov_a_zip_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(MX_Layout_MX)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(MX_Layout_MX) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.claim_type_Invalid := MX_Fields.InValid_claim_type((SALT31.StrType)le.claim_type);
    SELF.claim_num_Invalid := MX_Fields.InValid_claim_num((SALT31.StrType)le.claim_num);
    SELF.billing_addr_Invalid := MX_Fields.InValid_billing_addr((SALT31.StrType)le.billing_addr);
    SELF.billing_city_Invalid := MX_Fields.InValid_billing_city((SALT31.StrType)le.billing_city);
    SELF.billing_first_name_Invalid := MX_Fields.InValid_billing_first_name((SALT31.StrType)le.billing_first_name);
    SELF.billing_last_name_Invalid := MX_Fields.InValid_billing_last_name((SALT31.StrType)le.billing_last_name);
    SELF.billing_npi_Invalid := MX_Fields.InValid_billing_npi((SALT31.StrType)le.billing_npi);
    SELF.billing_org_name_Invalid := MX_Fields.InValid_billing_org_name((SALT31.StrType)le.billing_org_name);
    SELF.billing_specialty_code_Invalid := MX_Fields.InValid_billing_specialty_code((SALT31.StrType)le.billing_specialty_code);
    SELF.billing_state_Invalid := MX_Fields.InValid_billing_state((SALT31.StrType)le.billing_state);
    SELF.billing_tax_id_Invalid := MX_Fields.InValid_billing_tax_id((SALT31.StrType)le.billing_tax_id);
    SELF.billing_upin_Invalid := MX_Fields.InValid_billing_upin((SALT31.StrType)le.billing_upin);
    SELF.billing_zip_Invalid := MX_Fields.InValid_billing_zip((SALT31.StrType)le.billing_zip);
    SELF.diag_code1_Invalid := MX_Fields.InValid_diag_code1((SALT31.StrType)le.diag_code1);
    SELF.diag_code2_Invalid := MX_Fields.InValid_diag_code2((SALT31.StrType)le.diag_code2);
    SELF.diag_code3_Invalid := MX_Fields.InValid_diag_code3((SALT31.StrType)le.diag_code3);
    SELF.diag_code4_Invalid := MX_Fields.InValid_diag_code4((SALT31.StrType)le.diag_code4);
    SELF.diag_code5_Invalid := MX_Fields.InValid_diag_code5((SALT31.StrType)le.diag_code5);
    SELF.diag_code6_Invalid := MX_Fields.InValid_diag_code6((SALT31.StrType)le.diag_code6);
    SELF.diag_code7_Invalid := MX_Fields.InValid_diag_code7((SALT31.StrType)le.diag_code7);
    SELF.diag_code8_Invalid := MX_Fields.InValid_diag_code8((SALT31.StrType)le.diag_code8);
    SELF.ext_injury_diag_code_Invalid := MX_Fields.InValid_ext_injury_diag_code((SALT31.StrType)le.ext_injury_diag_code);
    SELF.facility_lab_addr_Invalid := MX_Fields.InValid_facility_lab_addr((SALT31.StrType)le.facility_lab_addr);
    SELF.facility_lab_city_Invalid := MX_Fields.InValid_facility_lab_city((SALT31.StrType)le.facility_lab_city);
    SELF.facility_lab_name_Invalid := MX_Fields.InValid_facility_lab_name((SALT31.StrType)le.facility_lab_name);
    SELF.facility_lab_npi_Invalid := MX_Fields.InValid_facility_lab_npi((SALT31.StrType)le.facility_lab_npi);
    SELF.facility_lab_state_Invalid := MX_Fields.InValid_facility_lab_state((SALT31.StrType)le.facility_lab_state);
    SELF.facility_lab_zip_Invalid := MX_Fields.InValid_facility_lab_zip((SALT31.StrType)le.facility_lab_zip);
    SELF.ordering_prov_first_name_Invalid := MX_Fields.InValid_ordering_prov_first_name((SALT31.StrType)le.ordering_prov_first_name);
    SELF.ordering_prov_last_name_Invalid := MX_Fields.InValid_ordering_prov_last_name((SALT31.StrType)le.ordering_prov_last_name);
    SELF.ordering_prov_middle_name_Invalid := MX_Fields.InValid_ordering_prov_middle_name((SALT31.StrType)le.ordering_prov_middle_name);
    SELF.ordering_prov_npi_Invalid := MX_Fields.InValid_ordering_prov_npi((SALT31.StrType)le.ordering_prov_npi);
    SELF.ordering_prov_state_Invalid := MX_Fields.InValid_ordering_prov_state((SALT31.StrType)le.ordering_prov_state);
    SELF.pay_to_addr_Invalid := MX_Fields.InValid_pay_to_addr((SALT31.StrType)le.pay_to_addr);
    SELF.pay_to_city_Invalid := MX_Fields.InValid_pay_to_city((SALT31.StrType)le.pay_to_city);
    SELF.pay_to_state_Invalid := MX_Fields.InValid_pay_to_state((SALT31.StrType)le.pay_to_state);
    SELF.pay_to_zip_Invalid := MX_Fields.InValid_pay_to_zip((SALT31.StrType)le.pay_to_zip);
    SELF.performing_prov_tax_id_Invalid := MX_Fields.InValid_performing_prov_tax_id((SALT31.StrType)le.performing_prov_tax_id);
    SELF.place_of_service_code_Invalid := MX_Fields.InValid_place_of_service_code((SALT31.StrType)le.place_of_service_code);
    SELF.place_of_service_name_Invalid := MX_Fields.InValid_place_of_service_name((SALT31.StrType)le.place_of_service_name);
    SELF.prov_a_addr_Invalid := MX_Fields.InValid_prov_a_addr((SALT31.StrType)le.prov_a_addr);
    SELF.prov_a_city_Invalid := MX_Fields.InValid_prov_a_city((SALT31.StrType)le.prov_a_city);
    SELF.prov_a_service_role_code_Invalid := MX_Fields.InValid_prov_a_service_role_code((SALT31.StrType)le.prov_a_service_role_code);
    SELF.prov_a_state_Invalid := MX_Fields.InValid_prov_a_state((SALT31.StrType)le.prov_a_state);
    SELF.prov_a_zip_Invalid := MX_Fields.InValid_prov_a_zip((SALT31.StrType)le.prov_a_zip);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.claim_type_Invalid << 0 ) + ( le.claim_num_Invalid << 3 ) + ( le.billing_addr_Invalid << 6 ) + ( le.billing_city_Invalid << 8 ) + ( le.billing_first_name_Invalid << 10 ) + ( le.billing_last_name_Invalid << 12 ) + ( le.billing_npi_Invalid << 14 ) + ( le.billing_org_name_Invalid << 17 ) + ( le.billing_specialty_code_Invalid << 19 ) + ( le.billing_state_Invalid << 22 ) + ( le.billing_tax_id_Invalid << 25 ) + ( le.billing_upin_Invalid << 28 ) + ( le.billing_zip_Invalid << 31 ) + ( le.diag_code1_Invalid << 34 ) + ( le.diag_code2_Invalid << 37 ) + ( le.diag_code3_Invalid << 40 ) + ( le.diag_code4_Invalid << 43 ) + ( le.diag_code5_Invalid << 46 ) + ( le.diag_code6_Invalid << 49 ) + ( le.diag_code7_Invalid << 52 ) + ( le.diag_code8_Invalid << 55 ) + ( le.ext_injury_diag_code_Invalid << 58 ) + ( le.facility_lab_addr_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.facility_lab_city_Invalid << 0 ) + ( le.facility_lab_name_Invalid << 2 ) + ( le.facility_lab_npi_Invalid << 4 ) + ( le.facility_lab_state_Invalid << 7 ) + ( le.facility_lab_zip_Invalid << 10 ) + ( le.ordering_prov_first_name_Invalid << 13 ) + ( le.ordering_prov_last_name_Invalid << 15 ) + ( le.ordering_prov_middle_name_Invalid << 17 ) + ( le.ordering_prov_npi_Invalid << 19 ) + ( le.ordering_prov_state_Invalid << 22 ) + ( le.pay_to_addr_Invalid << 25 ) + ( le.pay_to_city_Invalid << 27 ) + ( le.pay_to_state_Invalid << 29 ) + ( le.pay_to_zip_Invalid << 32 ) + ( le.performing_prov_tax_id_Invalid << 35 ) + ( le.place_of_service_code_Invalid << 38 ) + ( le.place_of_service_name_Invalid << 41 ) + ( le.prov_a_addr_Invalid << 43 ) + ( le.prov_a_city_Invalid << 45 ) + ( le.prov_a_service_role_code_Invalid << 47 ) + ( le.prov_a_state_Invalid << 50 ) + ( le.prov_a_zip_Invalid << 53 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,MX_Layout_MX);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.claim_type_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.claim_num_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.billing_addr_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.billing_city_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.billing_first_name_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.billing_last_name_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.billing_npi_Invalid := (le.ScrubsBits1 >> 14) & 7;
    SELF.billing_org_name_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.billing_specialty_code_Invalid := (le.ScrubsBits1 >> 19) & 7;
    SELF.billing_state_Invalid := (le.ScrubsBits1 >> 22) & 7;
    SELF.billing_tax_id_Invalid := (le.ScrubsBits1 >> 25) & 7;
    SELF.billing_upin_Invalid := (le.ScrubsBits1 >> 28) & 7;
    SELF.billing_zip_Invalid := (le.ScrubsBits1 >> 31) & 7;
    SELF.diag_code1_Invalid := (le.ScrubsBits1 >> 34) & 7;
    SELF.diag_code2_Invalid := (le.ScrubsBits1 >> 37) & 7;
    SELF.diag_code3_Invalid := (le.ScrubsBits1 >> 40) & 7;
    SELF.diag_code4_Invalid := (le.ScrubsBits1 >> 43) & 7;
    SELF.diag_code5_Invalid := (le.ScrubsBits1 >> 46) & 7;
    SELF.diag_code6_Invalid := (le.ScrubsBits1 >> 49) & 7;
    SELF.diag_code7_Invalid := (le.ScrubsBits1 >> 52) & 7;
    SELF.diag_code8_Invalid := (le.ScrubsBits1 >> 55) & 7;
    SELF.ext_injury_diag_code_Invalid := (le.ScrubsBits1 >> 58) & 7;
    SELF.facility_lab_addr_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.facility_lab_city_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.facility_lab_name_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.facility_lab_npi_Invalid := (le.ScrubsBits2 >> 4) & 7;
    SELF.facility_lab_state_Invalid := (le.ScrubsBits2 >> 7) & 7;
    SELF.facility_lab_zip_Invalid := (le.ScrubsBits2 >> 10) & 7;
    SELF.ordering_prov_first_name_Invalid := (le.ScrubsBits2 >> 13) & 3;
    SELF.ordering_prov_last_name_Invalid := (le.ScrubsBits2 >> 15) & 3;
    SELF.ordering_prov_middle_name_Invalid := (le.ScrubsBits2 >> 17) & 3;
    SELF.ordering_prov_npi_Invalid := (le.ScrubsBits2 >> 19) & 7;
    SELF.ordering_prov_state_Invalid := (le.ScrubsBits2 >> 22) & 7;
    SELF.pay_to_addr_Invalid := (le.ScrubsBits2 >> 25) & 3;
    SELF.pay_to_city_Invalid := (le.ScrubsBits2 >> 27) & 3;
    SELF.pay_to_state_Invalid := (le.ScrubsBits2 >> 29) & 7;
    SELF.pay_to_zip_Invalid := (le.ScrubsBits2 >> 32) & 7;
    SELF.performing_prov_tax_id_Invalid := (le.ScrubsBits2 >> 35) & 7;
    SELF.place_of_service_code_Invalid := (le.ScrubsBits2 >> 38) & 7;
    SELF.place_of_service_name_Invalid := (le.ScrubsBits2 >> 41) & 3;
    SELF.prov_a_addr_Invalid := (le.ScrubsBits2 >> 43) & 3;
    SELF.prov_a_city_Invalid := (le.ScrubsBits2 >> 45) & 3;
    SELF.prov_a_service_role_code_Invalid := (le.ScrubsBits2 >> 47) & 7;
    SELF.prov_a_state_Invalid := (le.ScrubsBits2 >> 50) & 7;
    SELF.prov_a_zip_Invalid := (le.ScrubsBits2 >> 53) & 7;
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
    billing_addr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_addr_Invalid=1);
    billing_addr_ALLOW_ErrorCount := COUNT(GROUP,h.billing_addr_Invalid=2);
    billing_addr_Total_ErrorCount := COUNT(GROUP,h.billing_addr_Invalid>0);
    billing_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_city_Invalid=1);
    billing_city_ALLOW_ErrorCount := COUNT(GROUP,h.billing_city_Invalid=2);
    billing_city_Total_ErrorCount := COUNT(GROUP,h.billing_city_Invalid>0);
    billing_first_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_first_name_Invalid=1);
    billing_first_name_ALLOW_ErrorCount := COUNT(GROUP,h.billing_first_name_Invalid=2);
    billing_first_name_Total_ErrorCount := COUNT(GROUP,h.billing_first_name_Invalid>0);
    billing_last_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_last_name_Invalid=1);
    billing_last_name_ALLOW_ErrorCount := COUNT(GROUP,h.billing_last_name_Invalid=2);
    billing_last_name_Total_ErrorCount := COUNT(GROUP,h.billing_last_name_Invalid>0);
    billing_npi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=1);
    billing_npi_ALLOW_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=2);
    billing_npi_LENGTH_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=3);
    billing_npi_WORDS_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=4);
    billing_npi_Total_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid>0);
    billing_org_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_org_name_Invalid=1);
    billing_org_name_ALLOW_ErrorCount := COUNT(GROUP,h.billing_org_name_Invalid=2);
    billing_org_name_Total_ErrorCount := COUNT(GROUP,h.billing_org_name_Invalid>0);
    billing_specialty_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_specialty_code_Invalid=1);
    billing_specialty_code_ALLOW_ErrorCount := COUNT(GROUP,h.billing_specialty_code_Invalid=2);
    billing_specialty_code_LENGTH_ErrorCount := COUNT(GROUP,h.billing_specialty_code_Invalid=3);
    billing_specialty_code_WORDS_ErrorCount := COUNT(GROUP,h.billing_specialty_code_Invalid=4);
    billing_specialty_code_Total_ErrorCount := COUNT(GROUP,h.billing_specialty_code_Invalid>0);
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
    billing_upin_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_upin_Invalid=1);
    billing_upin_ALLOW_ErrorCount := COUNT(GROUP,h.billing_upin_Invalid=2);
    billing_upin_LENGTH_ErrorCount := COUNT(GROUP,h.billing_upin_Invalid=3);
    billing_upin_WORDS_ErrorCount := COUNT(GROUP,h.billing_upin_Invalid=4);
    billing_upin_Total_ErrorCount := COUNT(GROUP,h.billing_upin_Invalid>0);
    billing_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=1);
    billing_zip_ALLOW_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=2);
    billing_zip_LENGTH_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=3);
    billing_zip_WORDS_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=4);
    billing_zip_Total_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid>0);
    diag_code1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code1_Invalid=1);
    diag_code1_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code1_Invalid=2);
    diag_code1_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code1_Invalid=3);
    diag_code1_WORDS_ErrorCount := COUNT(GROUP,h.diag_code1_Invalid=4);
    diag_code1_Total_ErrorCount := COUNT(GROUP,h.diag_code1_Invalid>0);
    diag_code2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code2_Invalid=1);
    diag_code2_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code2_Invalid=2);
    diag_code2_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code2_Invalid=3);
    diag_code2_WORDS_ErrorCount := COUNT(GROUP,h.diag_code2_Invalid=4);
    diag_code2_Total_ErrorCount := COUNT(GROUP,h.diag_code2_Invalid>0);
    diag_code3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code3_Invalid=1);
    diag_code3_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code3_Invalid=2);
    diag_code3_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code3_Invalid=3);
    diag_code3_WORDS_ErrorCount := COUNT(GROUP,h.diag_code3_Invalid=4);
    diag_code3_Total_ErrorCount := COUNT(GROUP,h.diag_code3_Invalid>0);
    diag_code4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code4_Invalid=1);
    diag_code4_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code4_Invalid=2);
    diag_code4_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code4_Invalid=3);
    diag_code4_WORDS_ErrorCount := COUNT(GROUP,h.diag_code4_Invalid=4);
    diag_code4_Total_ErrorCount := COUNT(GROUP,h.diag_code4_Invalid>0);
    diag_code5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code5_Invalid=1);
    diag_code5_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code5_Invalid=2);
    diag_code5_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code5_Invalid=3);
    diag_code5_WORDS_ErrorCount := COUNT(GROUP,h.diag_code5_Invalid=4);
    diag_code5_Total_ErrorCount := COUNT(GROUP,h.diag_code5_Invalid>0);
    diag_code6_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code6_Invalid=1);
    diag_code6_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code6_Invalid=2);
    diag_code6_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code6_Invalid=3);
    diag_code6_WORDS_ErrorCount := COUNT(GROUP,h.diag_code6_Invalid=4);
    diag_code6_Total_ErrorCount := COUNT(GROUP,h.diag_code6_Invalid>0);
    diag_code7_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code7_Invalid=1);
    diag_code7_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code7_Invalid=2);
    diag_code7_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code7_Invalid=3);
    diag_code7_WORDS_ErrorCount := COUNT(GROUP,h.diag_code7_Invalid=4);
    diag_code7_Total_ErrorCount := COUNT(GROUP,h.diag_code7_Invalid>0);
    diag_code8_LEFTTRIM_ErrorCount := COUNT(GROUP,h.diag_code8_Invalid=1);
    diag_code8_ALLOW_ErrorCount := COUNT(GROUP,h.diag_code8_Invalid=2);
    diag_code8_LENGTH_ErrorCount := COUNT(GROUP,h.diag_code8_Invalid=3);
    diag_code8_WORDS_ErrorCount := COUNT(GROUP,h.diag_code8_Invalid=4);
    diag_code8_Total_ErrorCount := COUNT(GROUP,h.diag_code8_Invalid>0);
    ext_injury_diag_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ext_injury_diag_code_Invalid=1);
    ext_injury_diag_code_ALLOW_ErrorCount := COUNT(GROUP,h.ext_injury_diag_code_Invalid=2);
    ext_injury_diag_code_LENGTH_ErrorCount := COUNT(GROUP,h.ext_injury_diag_code_Invalid=3);
    ext_injury_diag_code_WORDS_ErrorCount := COUNT(GROUP,h.ext_injury_diag_code_Invalid=4);
    ext_injury_diag_code_Total_ErrorCount := COUNT(GROUP,h.ext_injury_diag_code_Invalid>0);
    facility_lab_addr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.facility_lab_addr_Invalid=1);
    facility_lab_addr_ALLOW_ErrorCount := COUNT(GROUP,h.facility_lab_addr_Invalid=2);
    facility_lab_addr_Total_ErrorCount := COUNT(GROUP,h.facility_lab_addr_Invalid>0);
    facility_lab_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.facility_lab_city_Invalid=1);
    facility_lab_city_ALLOW_ErrorCount := COUNT(GROUP,h.facility_lab_city_Invalid=2);
    facility_lab_city_Total_ErrorCount := COUNT(GROUP,h.facility_lab_city_Invalid>0);
    facility_lab_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.facility_lab_name_Invalid=1);
    facility_lab_name_ALLOW_ErrorCount := COUNT(GROUP,h.facility_lab_name_Invalid=2);
    facility_lab_name_Total_ErrorCount := COUNT(GROUP,h.facility_lab_name_Invalid>0);
    facility_lab_npi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.facility_lab_npi_Invalid=1);
    facility_lab_npi_ALLOW_ErrorCount := COUNT(GROUP,h.facility_lab_npi_Invalid=2);
    facility_lab_npi_LENGTH_ErrorCount := COUNT(GROUP,h.facility_lab_npi_Invalid=3);
    facility_lab_npi_WORDS_ErrorCount := COUNT(GROUP,h.facility_lab_npi_Invalid=4);
    facility_lab_npi_Total_ErrorCount := COUNT(GROUP,h.facility_lab_npi_Invalid>0);
    facility_lab_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.facility_lab_state_Invalid=1);
    facility_lab_state_ALLOW_ErrorCount := COUNT(GROUP,h.facility_lab_state_Invalid=2);
    facility_lab_state_LENGTH_ErrorCount := COUNT(GROUP,h.facility_lab_state_Invalid=3);
    facility_lab_state_WORDS_ErrorCount := COUNT(GROUP,h.facility_lab_state_Invalid=4);
    facility_lab_state_Total_ErrorCount := COUNT(GROUP,h.facility_lab_state_Invalid>0);
    facility_lab_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.facility_lab_zip_Invalid=1);
    facility_lab_zip_ALLOW_ErrorCount := COUNT(GROUP,h.facility_lab_zip_Invalid=2);
    facility_lab_zip_LENGTH_ErrorCount := COUNT(GROUP,h.facility_lab_zip_Invalid=3);
    facility_lab_zip_WORDS_ErrorCount := COUNT(GROUP,h.facility_lab_zip_Invalid=4);
    facility_lab_zip_Total_ErrorCount := COUNT(GROUP,h.facility_lab_zip_Invalid>0);
    ordering_prov_first_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ordering_prov_first_name_Invalid=1);
    ordering_prov_first_name_ALLOW_ErrorCount := COUNT(GROUP,h.ordering_prov_first_name_Invalid=2);
    ordering_prov_first_name_Total_ErrorCount := COUNT(GROUP,h.ordering_prov_first_name_Invalid>0);
    ordering_prov_last_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ordering_prov_last_name_Invalid=1);
    ordering_prov_last_name_ALLOW_ErrorCount := COUNT(GROUP,h.ordering_prov_last_name_Invalid=2);
    ordering_prov_last_name_Total_ErrorCount := COUNT(GROUP,h.ordering_prov_last_name_Invalid>0);
    ordering_prov_middle_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ordering_prov_middle_name_Invalid=1);
    ordering_prov_middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.ordering_prov_middle_name_Invalid=2);
    ordering_prov_middle_name_Total_ErrorCount := COUNT(GROUP,h.ordering_prov_middle_name_Invalid>0);
    ordering_prov_npi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ordering_prov_npi_Invalid=1);
    ordering_prov_npi_ALLOW_ErrorCount := COUNT(GROUP,h.ordering_prov_npi_Invalid=2);
    ordering_prov_npi_LENGTH_ErrorCount := COUNT(GROUP,h.ordering_prov_npi_Invalid=3);
    ordering_prov_npi_WORDS_ErrorCount := COUNT(GROUP,h.ordering_prov_npi_Invalid=4);
    ordering_prov_npi_Total_ErrorCount := COUNT(GROUP,h.ordering_prov_npi_Invalid>0);
    ordering_prov_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ordering_prov_state_Invalid=1);
    ordering_prov_state_ALLOW_ErrorCount := COUNT(GROUP,h.ordering_prov_state_Invalid=2);
    ordering_prov_state_LENGTH_ErrorCount := COUNT(GROUP,h.ordering_prov_state_Invalid=3);
    ordering_prov_state_WORDS_ErrorCount := COUNT(GROUP,h.ordering_prov_state_Invalid=4);
    ordering_prov_state_Total_ErrorCount := COUNT(GROUP,h.ordering_prov_state_Invalid>0);
    pay_to_addr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.pay_to_addr_Invalid=1);
    pay_to_addr_ALLOW_ErrorCount := COUNT(GROUP,h.pay_to_addr_Invalid=2);
    pay_to_addr_Total_ErrorCount := COUNT(GROUP,h.pay_to_addr_Invalid>0);
    pay_to_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.pay_to_city_Invalid=1);
    pay_to_city_ALLOW_ErrorCount := COUNT(GROUP,h.pay_to_city_Invalid=2);
    pay_to_city_Total_ErrorCount := COUNT(GROUP,h.pay_to_city_Invalid>0);
    pay_to_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.pay_to_state_Invalid=1);
    pay_to_state_ALLOW_ErrorCount := COUNT(GROUP,h.pay_to_state_Invalid=2);
    pay_to_state_LENGTH_ErrorCount := COUNT(GROUP,h.pay_to_state_Invalid=3);
    pay_to_state_WORDS_ErrorCount := COUNT(GROUP,h.pay_to_state_Invalid=4);
    pay_to_state_Total_ErrorCount := COUNT(GROUP,h.pay_to_state_Invalid>0);
    pay_to_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.pay_to_zip_Invalid=1);
    pay_to_zip_ALLOW_ErrorCount := COUNT(GROUP,h.pay_to_zip_Invalid=2);
    pay_to_zip_LENGTH_ErrorCount := COUNT(GROUP,h.pay_to_zip_Invalid=3);
    pay_to_zip_WORDS_ErrorCount := COUNT(GROUP,h.pay_to_zip_Invalid=4);
    pay_to_zip_Total_ErrorCount := COUNT(GROUP,h.pay_to_zip_Invalid>0);
    performing_prov_tax_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.performing_prov_tax_id_Invalid=1);
    performing_prov_tax_id_ALLOW_ErrorCount := COUNT(GROUP,h.performing_prov_tax_id_Invalid=2);
    performing_prov_tax_id_LENGTH_ErrorCount := COUNT(GROUP,h.performing_prov_tax_id_Invalid=3);
    performing_prov_tax_id_WORDS_ErrorCount := COUNT(GROUP,h.performing_prov_tax_id_Invalid=4);
    performing_prov_tax_id_Total_ErrorCount := COUNT(GROUP,h.performing_prov_tax_id_Invalid>0);
    place_of_service_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.place_of_service_code_Invalid=1);
    place_of_service_code_ALLOW_ErrorCount := COUNT(GROUP,h.place_of_service_code_Invalid=2);
    place_of_service_code_LENGTH_ErrorCount := COUNT(GROUP,h.place_of_service_code_Invalid=3);
    place_of_service_code_WORDS_ErrorCount := COUNT(GROUP,h.place_of_service_code_Invalid=4);
    place_of_service_code_Total_ErrorCount := COUNT(GROUP,h.place_of_service_code_Invalid>0);
    place_of_service_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.place_of_service_name_Invalid=1);
    place_of_service_name_ALLOW_ErrorCount := COUNT(GROUP,h.place_of_service_name_Invalid=2);
    place_of_service_name_Total_ErrorCount := COUNT(GROUP,h.place_of_service_name_Invalid>0);
    prov_a_addr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prov_a_addr_Invalid=1);
    prov_a_addr_ALLOW_ErrorCount := COUNT(GROUP,h.prov_a_addr_Invalid=2);
    prov_a_addr_Total_ErrorCount := COUNT(GROUP,h.prov_a_addr_Invalid>0);
    prov_a_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prov_a_city_Invalid=1);
    prov_a_city_ALLOW_ErrorCount := COUNT(GROUP,h.prov_a_city_Invalid=2);
    prov_a_city_Total_ErrorCount := COUNT(GROUP,h.prov_a_city_Invalid>0);
    prov_a_service_role_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prov_a_service_role_code_Invalid=1);
    prov_a_service_role_code_ALLOW_ErrorCount := COUNT(GROUP,h.prov_a_service_role_code_Invalid=2);
    prov_a_service_role_code_LENGTH_ErrorCount := COUNT(GROUP,h.prov_a_service_role_code_Invalid=3);
    prov_a_service_role_code_WORDS_ErrorCount := COUNT(GROUP,h.prov_a_service_role_code_Invalid=4);
    prov_a_service_role_code_Total_ErrorCount := COUNT(GROUP,h.prov_a_service_role_code_Invalid>0);
    prov_a_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prov_a_state_Invalid=1);
    prov_a_state_ALLOW_ErrorCount := COUNT(GROUP,h.prov_a_state_Invalid=2);
    prov_a_state_LENGTH_ErrorCount := COUNT(GROUP,h.prov_a_state_Invalid=3);
    prov_a_state_WORDS_ErrorCount := COUNT(GROUP,h.prov_a_state_Invalid=4);
    prov_a_state_Total_ErrorCount := COUNT(GROUP,h.prov_a_state_Invalid>0);
    prov_a_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prov_a_zip_Invalid=1);
    prov_a_zip_ALLOW_ErrorCount := COUNT(GROUP,h.prov_a_zip_Invalid=2);
    prov_a_zip_LENGTH_ErrorCount := COUNT(GROUP,h.prov_a_zip_Invalid=3);
    prov_a_zip_WORDS_ErrorCount := COUNT(GROUP,h.prov_a_zip_Invalid=4);
    prov_a_zip_Total_ErrorCount := COUNT(GROUP,h.prov_a_zip_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.claim_type_Invalid,le.claim_num_Invalid,le.billing_addr_Invalid,le.billing_city_Invalid,le.billing_first_name_Invalid,le.billing_last_name_Invalid,le.billing_npi_Invalid,le.billing_org_name_Invalid,le.billing_specialty_code_Invalid,le.billing_state_Invalid,le.billing_tax_id_Invalid,le.billing_upin_Invalid,le.billing_zip_Invalid,le.diag_code1_Invalid,le.diag_code2_Invalid,le.diag_code3_Invalid,le.diag_code4_Invalid,le.diag_code5_Invalid,le.diag_code6_Invalid,le.diag_code7_Invalid,le.diag_code8_Invalid,le.ext_injury_diag_code_Invalid,le.facility_lab_addr_Invalid,le.facility_lab_city_Invalid,le.facility_lab_name_Invalid,le.facility_lab_npi_Invalid,le.facility_lab_state_Invalid,le.facility_lab_zip_Invalid,le.ordering_prov_first_name_Invalid,le.ordering_prov_last_name_Invalid,le.ordering_prov_middle_name_Invalid,le.ordering_prov_npi_Invalid,le.ordering_prov_state_Invalid,le.pay_to_addr_Invalid,le.pay_to_city_Invalid,le.pay_to_state_Invalid,le.pay_to_zip_Invalid,le.performing_prov_tax_id_Invalid,le.place_of_service_code_Invalid,le.place_of_service_name_Invalid,le.prov_a_addr_Invalid,le.prov_a_city_Invalid,le.prov_a_service_role_code_Invalid,le.prov_a_state_Invalid,le.prov_a_zip_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,MX_Fields.InvalidMessage_claim_type(le.claim_type_Invalid),MX_Fields.InvalidMessage_claim_num(le.claim_num_Invalid),MX_Fields.InvalidMessage_billing_addr(le.billing_addr_Invalid),MX_Fields.InvalidMessage_billing_city(le.billing_city_Invalid),MX_Fields.InvalidMessage_billing_first_name(le.billing_first_name_Invalid),MX_Fields.InvalidMessage_billing_last_name(le.billing_last_name_Invalid),MX_Fields.InvalidMessage_billing_npi(le.billing_npi_Invalid),MX_Fields.InvalidMessage_billing_org_name(le.billing_org_name_Invalid),MX_Fields.InvalidMessage_billing_specialty_code(le.billing_specialty_code_Invalid),MX_Fields.InvalidMessage_billing_state(le.billing_state_Invalid),MX_Fields.InvalidMessage_billing_tax_id(le.billing_tax_id_Invalid),MX_Fields.InvalidMessage_billing_upin(le.billing_upin_Invalid),MX_Fields.InvalidMessage_billing_zip(le.billing_zip_Invalid),MX_Fields.InvalidMessage_diag_code1(le.diag_code1_Invalid),MX_Fields.InvalidMessage_diag_code2(le.diag_code2_Invalid),MX_Fields.InvalidMessage_diag_code3(le.diag_code3_Invalid),MX_Fields.InvalidMessage_diag_code4(le.diag_code4_Invalid),MX_Fields.InvalidMessage_diag_code5(le.diag_code5_Invalid),MX_Fields.InvalidMessage_diag_code6(le.diag_code6_Invalid),MX_Fields.InvalidMessage_diag_code7(le.diag_code7_Invalid),MX_Fields.InvalidMessage_diag_code8(le.diag_code8_Invalid),MX_Fields.InvalidMessage_ext_injury_diag_code(le.ext_injury_diag_code_Invalid),MX_Fields.InvalidMessage_facility_lab_addr(le.facility_lab_addr_Invalid),MX_Fields.InvalidMessage_facility_lab_city(le.facility_lab_city_Invalid),MX_Fields.InvalidMessage_facility_lab_name(le.facility_lab_name_Invalid),MX_Fields.InvalidMessage_facility_lab_npi(le.facility_lab_npi_Invalid),MX_Fields.InvalidMessage_facility_lab_state(le.facility_lab_state_Invalid),MX_Fields.InvalidMessage_facility_lab_zip(le.facility_lab_zip_Invalid),MX_Fields.InvalidMessage_ordering_prov_first_name(le.ordering_prov_first_name_Invalid),MX_Fields.InvalidMessage_ordering_prov_last_name(le.ordering_prov_last_name_Invalid),MX_Fields.InvalidMessage_ordering_prov_middle_name(le.ordering_prov_middle_name_Invalid),MX_Fields.InvalidMessage_ordering_prov_npi(le.ordering_prov_npi_Invalid),MX_Fields.InvalidMessage_ordering_prov_state(le.ordering_prov_state_Invalid),MX_Fields.InvalidMessage_pay_to_addr(le.pay_to_addr_Invalid),MX_Fields.InvalidMessage_pay_to_city(le.pay_to_city_Invalid),MX_Fields.InvalidMessage_pay_to_state(le.pay_to_state_Invalid),MX_Fields.InvalidMessage_pay_to_zip(le.pay_to_zip_Invalid),MX_Fields.InvalidMessage_performing_prov_tax_id(le.performing_prov_tax_id_Invalid),MX_Fields.InvalidMessage_place_of_service_code(le.place_of_service_code_Invalid),MX_Fields.InvalidMessage_place_of_service_name(le.place_of_service_name_Invalid),MX_Fields.InvalidMessage_prov_a_addr(le.prov_a_addr_Invalid),MX_Fields.InvalidMessage_prov_a_city(le.prov_a_city_Invalid),MX_Fields.InvalidMessage_prov_a_service_role_code(le.prov_a_service_role_code_Invalid),MX_Fields.InvalidMessage_prov_a_state(le.prov_a_state_Invalid),MX_Fields.InvalidMessage_prov_a_zip(le.prov_a_zip_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.claim_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.claim_num_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_addr_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.billing_city_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.billing_first_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.billing_last_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.billing_npi_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_org_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.billing_specialty_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_tax_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_upin_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code5_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code6_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code7_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code8_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ext_injury_diag_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.facility_lab_addr_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.facility_lab_city_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.facility_lab_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.facility_lab_npi_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.facility_lab_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.facility_lab_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ordering_prov_first_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.ordering_prov_last_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.ordering_prov_middle_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.ordering_prov_npi_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ordering_prov_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.pay_to_addr_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.pay_to_city_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.pay_to_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.pay_to_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.performing_prov_tax_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.place_of_service_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.place_of_service_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prov_a_addr_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prov_a_city_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prov_a_service_role_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prov_a_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prov_a_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'claim_type','claim_num','billing_addr','billing_city','billing_first_name','billing_last_name','billing_npi','billing_org_name','billing_specialty_code','billing_state','billing_tax_id','billing_upin','billing_zip','diag_code1','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','ext_injury_diag_code','facility_lab_addr','facility_lab_city','facility_lab_name','facility_lab_npi','facility_lab_state','facility_lab_zip','ordering_prov_first_name','ordering_prov_last_name','ordering_prov_middle_name','ordering_prov_npi','ordering_prov_state','pay_to_addr','pay_to_city','pay_to_state','pay_to_zip','performing_prov_tax_id','place_of_service_code','place_of_service_name','prov_a_addr','prov_a_city','prov_a_service_role_code','prov_a_state','prov_a_zip','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'claim_type','claim_num','billing_addr','billing_city','billing_first_name','billing_last_name','billing_npi','billing_org_name','billing_specialty_code','billing_state','billing_tax_id','billing_upin','billing_zip','diag_code1','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','ext_injury_diag_code','facility_lab_addr','facility_lab_city','facility_lab_name','facility_lab_npi','facility_lab_state','facility_lab_zip','ordering_prov_first_name','ordering_prov_last_name','ordering_prov_middle_name','ordering_prov_npi','ordering_prov_state','pay_to_addr','pay_to_city','pay_to_state','pay_to_zip','performing_prov_tax_id','place_of_service_code','place_of_service_name','prov_a_addr','prov_a_city','prov_a_service_role_code','prov_a_state','prov_a_zip','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.claim_type,(SALT31.StrType)le.claim_num,(SALT31.StrType)le.billing_addr,(SALT31.StrType)le.billing_city,(SALT31.StrType)le.billing_first_name,(SALT31.StrType)le.billing_last_name,(SALT31.StrType)le.billing_npi,(SALT31.StrType)le.billing_org_name,(SALT31.StrType)le.billing_specialty_code,(SALT31.StrType)le.billing_state,(SALT31.StrType)le.billing_tax_id,(SALT31.StrType)le.billing_upin,(SALT31.StrType)le.billing_zip,(SALT31.StrType)le.diag_code1,(SALT31.StrType)le.diag_code2,(SALT31.StrType)le.diag_code3,(SALT31.StrType)le.diag_code4,(SALT31.StrType)le.diag_code5,(SALT31.StrType)le.diag_code6,(SALT31.StrType)le.diag_code7,(SALT31.StrType)le.diag_code8,(SALT31.StrType)le.ext_injury_diag_code,(SALT31.StrType)le.facility_lab_addr,(SALT31.StrType)le.facility_lab_city,(SALT31.StrType)le.facility_lab_name,(SALT31.StrType)le.facility_lab_npi,(SALT31.StrType)le.facility_lab_state,(SALT31.StrType)le.facility_lab_zip,(SALT31.StrType)le.ordering_prov_first_name,(SALT31.StrType)le.ordering_prov_last_name,(SALT31.StrType)le.ordering_prov_middle_name,(SALT31.StrType)le.ordering_prov_npi,(SALT31.StrType)le.ordering_prov_state,(SALT31.StrType)le.pay_to_addr,(SALT31.StrType)le.pay_to_city,(SALT31.StrType)le.pay_to_state,(SALT31.StrType)le.pay_to_zip,(SALT31.StrType)le.performing_prov_tax_id,(SALT31.StrType)le.place_of_service_code,(SALT31.StrType)le.place_of_service_name,(SALT31.StrType)le.prov_a_addr,(SALT31.StrType)le.prov_a_city,(SALT31.StrType)le.prov_a_service_role_code,(SALT31.StrType)le.prov_a_state,(SALT31.StrType)le.prov_a_zip,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,45,Into(LEFT,COUNTER));
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
          ,'billing_addr:billing_addr:LEFTTRIM','billing_addr:billing_addr:ALLOW'
          ,'billing_city:billing_city:LEFTTRIM','billing_city:billing_city:ALLOW'
          ,'billing_first_name:billing_first_name:LEFTTRIM','billing_first_name:billing_first_name:ALLOW'
          ,'billing_last_name:billing_last_name:LEFTTRIM','billing_last_name:billing_last_name:ALLOW'
          ,'billing_npi:billing_npi:LEFTTRIM','billing_npi:billing_npi:ALLOW','billing_npi:billing_npi:LENGTH','billing_npi:billing_npi:WORDS'
          ,'billing_org_name:billing_org_name:LEFTTRIM','billing_org_name:billing_org_name:ALLOW'
          ,'billing_specialty_code:billing_specialty_code:LEFTTRIM','billing_specialty_code:billing_specialty_code:ALLOW','billing_specialty_code:billing_specialty_code:LENGTH','billing_specialty_code:billing_specialty_code:WORDS'
          ,'billing_state:billing_state:LEFTTRIM','billing_state:billing_state:ALLOW','billing_state:billing_state:LENGTH','billing_state:billing_state:WORDS'
          ,'billing_tax_id:billing_tax_id:LEFTTRIM','billing_tax_id:billing_tax_id:ALLOW','billing_tax_id:billing_tax_id:LENGTH','billing_tax_id:billing_tax_id:WORDS'
          ,'billing_upin:billing_upin:LEFTTRIM','billing_upin:billing_upin:ALLOW','billing_upin:billing_upin:LENGTH','billing_upin:billing_upin:WORDS'
          ,'billing_zip:billing_zip:LEFTTRIM','billing_zip:billing_zip:ALLOW','billing_zip:billing_zip:LENGTH','billing_zip:billing_zip:WORDS'
          ,'diag_code1:diag_code1:LEFTTRIM','diag_code1:diag_code1:ALLOW','diag_code1:diag_code1:LENGTH','diag_code1:diag_code1:WORDS'
          ,'diag_code2:diag_code2:LEFTTRIM','diag_code2:diag_code2:ALLOW','diag_code2:diag_code2:LENGTH','diag_code2:diag_code2:WORDS'
          ,'diag_code3:diag_code3:LEFTTRIM','diag_code3:diag_code3:ALLOW','diag_code3:diag_code3:LENGTH','diag_code3:diag_code3:WORDS'
          ,'diag_code4:diag_code4:LEFTTRIM','diag_code4:diag_code4:ALLOW','diag_code4:diag_code4:LENGTH','diag_code4:diag_code4:WORDS'
          ,'diag_code5:diag_code5:LEFTTRIM','diag_code5:diag_code5:ALLOW','diag_code5:diag_code5:LENGTH','diag_code5:diag_code5:WORDS'
          ,'diag_code6:diag_code6:LEFTTRIM','diag_code6:diag_code6:ALLOW','diag_code6:diag_code6:LENGTH','diag_code6:diag_code6:WORDS'
          ,'diag_code7:diag_code7:LEFTTRIM','diag_code7:diag_code7:ALLOW','diag_code7:diag_code7:LENGTH','diag_code7:diag_code7:WORDS'
          ,'diag_code8:diag_code8:LEFTTRIM','diag_code8:diag_code8:ALLOW','diag_code8:diag_code8:LENGTH','diag_code8:diag_code8:WORDS'
          ,'ext_injury_diag_code:ext_injury_diag_code:LEFTTRIM','ext_injury_diag_code:ext_injury_diag_code:ALLOW','ext_injury_diag_code:ext_injury_diag_code:LENGTH','ext_injury_diag_code:ext_injury_diag_code:WORDS'
          ,'facility_lab_addr:facility_lab_addr:LEFTTRIM','facility_lab_addr:facility_lab_addr:ALLOW'
          ,'facility_lab_city:facility_lab_city:LEFTTRIM','facility_lab_city:facility_lab_city:ALLOW'
          ,'facility_lab_name:facility_lab_name:LEFTTRIM','facility_lab_name:facility_lab_name:ALLOW'
          ,'facility_lab_npi:facility_lab_npi:LEFTTRIM','facility_lab_npi:facility_lab_npi:ALLOW','facility_lab_npi:facility_lab_npi:LENGTH','facility_lab_npi:facility_lab_npi:WORDS'
          ,'facility_lab_state:facility_lab_state:LEFTTRIM','facility_lab_state:facility_lab_state:ALLOW','facility_lab_state:facility_lab_state:LENGTH','facility_lab_state:facility_lab_state:WORDS'
          ,'facility_lab_zip:facility_lab_zip:LEFTTRIM','facility_lab_zip:facility_lab_zip:ALLOW','facility_lab_zip:facility_lab_zip:LENGTH','facility_lab_zip:facility_lab_zip:WORDS'
          ,'ordering_prov_first_name:ordering_prov_first_name:LEFTTRIM','ordering_prov_first_name:ordering_prov_first_name:ALLOW'
          ,'ordering_prov_last_name:ordering_prov_last_name:LEFTTRIM','ordering_prov_last_name:ordering_prov_last_name:ALLOW'
          ,'ordering_prov_middle_name:ordering_prov_middle_name:LEFTTRIM','ordering_prov_middle_name:ordering_prov_middle_name:ALLOW'
          ,'ordering_prov_npi:ordering_prov_npi:LEFTTRIM','ordering_prov_npi:ordering_prov_npi:ALLOW','ordering_prov_npi:ordering_prov_npi:LENGTH','ordering_prov_npi:ordering_prov_npi:WORDS'
          ,'ordering_prov_state:ordering_prov_state:LEFTTRIM','ordering_prov_state:ordering_prov_state:ALLOW','ordering_prov_state:ordering_prov_state:LENGTH','ordering_prov_state:ordering_prov_state:WORDS'
          ,'pay_to_addr:pay_to_addr:LEFTTRIM','pay_to_addr:pay_to_addr:ALLOW'
          ,'pay_to_city:pay_to_city:LEFTTRIM','pay_to_city:pay_to_city:ALLOW'
          ,'pay_to_state:pay_to_state:LEFTTRIM','pay_to_state:pay_to_state:ALLOW','pay_to_state:pay_to_state:LENGTH','pay_to_state:pay_to_state:WORDS'
          ,'pay_to_zip:pay_to_zip:LEFTTRIM','pay_to_zip:pay_to_zip:ALLOW','pay_to_zip:pay_to_zip:LENGTH','pay_to_zip:pay_to_zip:WORDS'
          ,'performing_prov_tax_id:performing_prov_tax_id:LEFTTRIM','performing_prov_tax_id:performing_prov_tax_id:ALLOW','performing_prov_tax_id:performing_prov_tax_id:LENGTH','performing_prov_tax_id:performing_prov_tax_id:WORDS'
          ,'place_of_service_code:place_of_service_code:LEFTTRIM','place_of_service_code:place_of_service_code:ALLOW','place_of_service_code:place_of_service_code:LENGTH','place_of_service_code:place_of_service_code:WORDS'
          ,'place_of_service_name:place_of_service_name:LEFTTRIM','place_of_service_name:place_of_service_name:ALLOW'
          ,'prov_a_addr:prov_a_addr:LEFTTRIM','prov_a_addr:prov_a_addr:ALLOW'
          ,'prov_a_city:prov_a_city:LEFTTRIM','prov_a_city:prov_a_city:ALLOW'
          ,'prov_a_service_role_code:prov_a_service_role_code:LEFTTRIM','prov_a_service_role_code:prov_a_service_role_code:ALLOW','prov_a_service_role_code:prov_a_service_role_code:LENGTH','prov_a_service_role_code:prov_a_service_role_code:WORDS'
          ,'prov_a_state:prov_a_state:LEFTTRIM','prov_a_state:prov_a_state:ALLOW','prov_a_state:prov_a_state:LENGTH','prov_a_state:prov_a_state:WORDS'
          ,'prov_a_zip:prov_a_zip:LEFTTRIM','prov_a_zip:prov_a_zip:ALLOW','prov_a_zip:prov_a_zip:LENGTH','prov_a_zip:prov_a_zip:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,MX_Fields.InvalidMessage_claim_type(1),MX_Fields.InvalidMessage_claim_type(2),MX_Fields.InvalidMessage_claim_type(3),MX_Fields.InvalidMessage_claim_type(4)
          ,MX_Fields.InvalidMessage_claim_num(1),MX_Fields.InvalidMessage_claim_num(2),MX_Fields.InvalidMessage_claim_num(3),MX_Fields.InvalidMessage_claim_num(4)
          ,MX_Fields.InvalidMessage_billing_addr(1),MX_Fields.InvalidMessage_billing_addr(2)
          ,MX_Fields.InvalidMessage_billing_city(1),MX_Fields.InvalidMessage_billing_city(2)
          ,MX_Fields.InvalidMessage_billing_first_name(1),MX_Fields.InvalidMessage_billing_first_name(2)
          ,MX_Fields.InvalidMessage_billing_last_name(1),MX_Fields.InvalidMessage_billing_last_name(2)
          ,MX_Fields.InvalidMessage_billing_npi(1),MX_Fields.InvalidMessage_billing_npi(2),MX_Fields.InvalidMessage_billing_npi(3),MX_Fields.InvalidMessage_billing_npi(4)
          ,MX_Fields.InvalidMessage_billing_org_name(1),MX_Fields.InvalidMessage_billing_org_name(2)
          ,MX_Fields.InvalidMessage_billing_specialty_code(1),MX_Fields.InvalidMessage_billing_specialty_code(2),MX_Fields.InvalidMessage_billing_specialty_code(3),MX_Fields.InvalidMessage_billing_specialty_code(4)
          ,MX_Fields.InvalidMessage_billing_state(1),MX_Fields.InvalidMessage_billing_state(2),MX_Fields.InvalidMessage_billing_state(3),MX_Fields.InvalidMessage_billing_state(4)
          ,MX_Fields.InvalidMessage_billing_tax_id(1),MX_Fields.InvalidMessage_billing_tax_id(2),MX_Fields.InvalidMessage_billing_tax_id(3),MX_Fields.InvalidMessage_billing_tax_id(4)
          ,MX_Fields.InvalidMessage_billing_upin(1),MX_Fields.InvalidMessage_billing_upin(2),MX_Fields.InvalidMessage_billing_upin(3),MX_Fields.InvalidMessage_billing_upin(4)
          ,MX_Fields.InvalidMessage_billing_zip(1),MX_Fields.InvalidMessage_billing_zip(2),MX_Fields.InvalidMessage_billing_zip(3),MX_Fields.InvalidMessage_billing_zip(4)
          ,MX_Fields.InvalidMessage_diag_code1(1),MX_Fields.InvalidMessage_diag_code1(2),MX_Fields.InvalidMessage_diag_code1(3),MX_Fields.InvalidMessage_diag_code1(4)
          ,MX_Fields.InvalidMessage_diag_code2(1),MX_Fields.InvalidMessage_diag_code2(2),MX_Fields.InvalidMessage_diag_code2(3),MX_Fields.InvalidMessage_diag_code2(4)
          ,MX_Fields.InvalidMessage_diag_code3(1),MX_Fields.InvalidMessage_diag_code3(2),MX_Fields.InvalidMessage_diag_code3(3),MX_Fields.InvalidMessage_diag_code3(4)
          ,MX_Fields.InvalidMessage_diag_code4(1),MX_Fields.InvalidMessage_diag_code4(2),MX_Fields.InvalidMessage_diag_code4(3),MX_Fields.InvalidMessage_diag_code4(4)
          ,MX_Fields.InvalidMessage_diag_code5(1),MX_Fields.InvalidMessage_diag_code5(2),MX_Fields.InvalidMessage_diag_code5(3),MX_Fields.InvalidMessage_diag_code5(4)
          ,MX_Fields.InvalidMessage_diag_code6(1),MX_Fields.InvalidMessage_diag_code6(2),MX_Fields.InvalidMessage_diag_code6(3),MX_Fields.InvalidMessage_diag_code6(4)
          ,MX_Fields.InvalidMessage_diag_code7(1),MX_Fields.InvalidMessage_diag_code7(2),MX_Fields.InvalidMessage_diag_code7(3),MX_Fields.InvalidMessage_diag_code7(4)
          ,MX_Fields.InvalidMessage_diag_code8(1),MX_Fields.InvalidMessage_diag_code8(2),MX_Fields.InvalidMessage_diag_code8(3),MX_Fields.InvalidMessage_diag_code8(4)
          ,MX_Fields.InvalidMessage_ext_injury_diag_code(1),MX_Fields.InvalidMessage_ext_injury_diag_code(2),MX_Fields.InvalidMessage_ext_injury_diag_code(3),MX_Fields.InvalidMessage_ext_injury_diag_code(4)
          ,MX_Fields.InvalidMessage_facility_lab_addr(1),MX_Fields.InvalidMessage_facility_lab_addr(2)
          ,MX_Fields.InvalidMessage_facility_lab_city(1),MX_Fields.InvalidMessage_facility_lab_city(2)
          ,MX_Fields.InvalidMessage_facility_lab_name(1),MX_Fields.InvalidMessage_facility_lab_name(2)
          ,MX_Fields.InvalidMessage_facility_lab_npi(1),MX_Fields.InvalidMessage_facility_lab_npi(2),MX_Fields.InvalidMessage_facility_lab_npi(3),MX_Fields.InvalidMessage_facility_lab_npi(4)
          ,MX_Fields.InvalidMessage_facility_lab_state(1),MX_Fields.InvalidMessage_facility_lab_state(2),MX_Fields.InvalidMessage_facility_lab_state(3),MX_Fields.InvalidMessage_facility_lab_state(4)
          ,MX_Fields.InvalidMessage_facility_lab_zip(1),MX_Fields.InvalidMessage_facility_lab_zip(2),MX_Fields.InvalidMessage_facility_lab_zip(3),MX_Fields.InvalidMessage_facility_lab_zip(4)
          ,MX_Fields.InvalidMessage_ordering_prov_first_name(1),MX_Fields.InvalidMessage_ordering_prov_first_name(2)
          ,MX_Fields.InvalidMessage_ordering_prov_last_name(1),MX_Fields.InvalidMessage_ordering_prov_last_name(2)
          ,MX_Fields.InvalidMessage_ordering_prov_middle_name(1),MX_Fields.InvalidMessage_ordering_prov_middle_name(2)
          ,MX_Fields.InvalidMessage_ordering_prov_npi(1),MX_Fields.InvalidMessage_ordering_prov_npi(2),MX_Fields.InvalidMessage_ordering_prov_npi(3),MX_Fields.InvalidMessage_ordering_prov_npi(4)
          ,MX_Fields.InvalidMessage_ordering_prov_state(1),MX_Fields.InvalidMessage_ordering_prov_state(2),MX_Fields.InvalidMessage_ordering_prov_state(3),MX_Fields.InvalidMessage_ordering_prov_state(4)
          ,MX_Fields.InvalidMessage_pay_to_addr(1),MX_Fields.InvalidMessage_pay_to_addr(2)
          ,MX_Fields.InvalidMessage_pay_to_city(1),MX_Fields.InvalidMessage_pay_to_city(2)
          ,MX_Fields.InvalidMessage_pay_to_state(1),MX_Fields.InvalidMessage_pay_to_state(2),MX_Fields.InvalidMessage_pay_to_state(3),MX_Fields.InvalidMessage_pay_to_state(4)
          ,MX_Fields.InvalidMessage_pay_to_zip(1),MX_Fields.InvalidMessage_pay_to_zip(2),MX_Fields.InvalidMessage_pay_to_zip(3),MX_Fields.InvalidMessage_pay_to_zip(4)
          ,MX_Fields.InvalidMessage_performing_prov_tax_id(1),MX_Fields.InvalidMessage_performing_prov_tax_id(2),MX_Fields.InvalidMessage_performing_prov_tax_id(3),MX_Fields.InvalidMessage_performing_prov_tax_id(4)
          ,MX_Fields.InvalidMessage_place_of_service_code(1),MX_Fields.InvalidMessage_place_of_service_code(2),MX_Fields.InvalidMessage_place_of_service_code(3),MX_Fields.InvalidMessage_place_of_service_code(4)
          ,MX_Fields.InvalidMessage_place_of_service_name(1),MX_Fields.InvalidMessage_place_of_service_name(2)
          ,MX_Fields.InvalidMessage_prov_a_addr(1),MX_Fields.InvalidMessage_prov_a_addr(2)
          ,MX_Fields.InvalidMessage_prov_a_city(1),MX_Fields.InvalidMessage_prov_a_city(2)
          ,MX_Fields.InvalidMessage_prov_a_service_role_code(1),MX_Fields.InvalidMessage_prov_a_service_role_code(2),MX_Fields.InvalidMessage_prov_a_service_role_code(3),MX_Fields.InvalidMessage_prov_a_service_role_code(4)
          ,MX_Fields.InvalidMessage_prov_a_state(1),MX_Fields.InvalidMessage_prov_a_state(2),MX_Fields.InvalidMessage_prov_a_state(3),MX_Fields.InvalidMessage_prov_a_state(4)
          ,MX_Fields.InvalidMessage_prov_a_zip(1),MX_Fields.InvalidMessage_prov_a_zip(2),MX_Fields.InvalidMessage_prov_a_zip(3),MX_Fields.InvalidMessage_prov_a_zip(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.claim_type_LEFTTRIM_ErrorCount,le.claim_type_ALLOW_ErrorCount,le.claim_type_LENGTH_ErrorCount,le.claim_type_WORDS_ErrorCount
          ,le.claim_num_LEFTTRIM_ErrorCount,le.claim_num_ALLOW_ErrorCount,le.claim_num_LENGTH_ErrorCount,le.claim_num_WORDS_ErrorCount
          ,le.billing_addr_LEFTTRIM_ErrorCount,le.billing_addr_ALLOW_ErrorCount
          ,le.billing_city_LEFTTRIM_ErrorCount,le.billing_city_ALLOW_ErrorCount
          ,le.billing_first_name_LEFTTRIM_ErrorCount,le.billing_first_name_ALLOW_ErrorCount
          ,le.billing_last_name_LEFTTRIM_ErrorCount,le.billing_last_name_ALLOW_ErrorCount
          ,le.billing_npi_LEFTTRIM_ErrorCount,le.billing_npi_ALLOW_ErrorCount,le.billing_npi_LENGTH_ErrorCount,le.billing_npi_WORDS_ErrorCount
          ,le.billing_org_name_LEFTTRIM_ErrorCount,le.billing_org_name_ALLOW_ErrorCount
          ,le.billing_specialty_code_LEFTTRIM_ErrorCount,le.billing_specialty_code_ALLOW_ErrorCount,le.billing_specialty_code_LENGTH_ErrorCount,le.billing_specialty_code_WORDS_ErrorCount
          ,le.billing_state_LEFTTRIM_ErrorCount,le.billing_state_ALLOW_ErrorCount,le.billing_state_LENGTH_ErrorCount,le.billing_state_WORDS_ErrorCount
          ,le.billing_tax_id_LEFTTRIM_ErrorCount,le.billing_tax_id_ALLOW_ErrorCount,le.billing_tax_id_LENGTH_ErrorCount,le.billing_tax_id_WORDS_ErrorCount
          ,le.billing_upin_LEFTTRIM_ErrorCount,le.billing_upin_ALLOW_ErrorCount,le.billing_upin_LENGTH_ErrorCount,le.billing_upin_WORDS_ErrorCount
          ,le.billing_zip_LEFTTRIM_ErrorCount,le.billing_zip_ALLOW_ErrorCount,le.billing_zip_LENGTH_ErrorCount,le.billing_zip_WORDS_ErrorCount
          ,le.diag_code1_LEFTTRIM_ErrorCount,le.diag_code1_ALLOW_ErrorCount,le.diag_code1_LENGTH_ErrorCount,le.diag_code1_WORDS_ErrorCount
          ,le.diag_code2_LEFTTRIM_ErrorCount,le.diag_code2_ALLOW_ErrorCount,le.diag_code2_LENGTH_ErrorCount,le.diag_code2_WORDS_ErrorCount
          ,le.diag_code3_LEFTTRIM_ErrorCount,le.diag_code3_ALLOW_ErrorCount,le.diag_code3_LENGTH_ErrorCount,le.diag_code3_WORDS_ErrorCount
          ,le.diag_code4_LEFTTRIM_ErrorCount,le.diag_code4_ALLOW_ErrorCount,le.diag_code4_LENGTH_ErrorCount,le.diag_code4_WORDS_ErrorCount
          ,le.diag_code5_LEFTTRIM_ErrorCount,le.diag_code5_ALLOW_ErrorCount,le.diag_code5_LENGTH_ErrorCount,le.diag_code5_WORDS_ErrorCount
          ,le.diag_code6_LEFTTRIM_ErrorCount,le.diag_code6_ALLOW_ErrorCount,le.diag_code6_LENGTH_ErrorCount,le.diag_code6_WORDS_ErrorCount
          ,le.diag_code7_LEFTTRIM_ErrorCount,le.diag_code7_ALLOW_ErrorCount,le.diag_code7_LENGTH_ErrorCount,le.diag_code7_WORDS_ErrorCount
          ,le.diag_code8_LEFTTRIM_ErrorCount,le.diag_code8_ALLOW_ErrorCount,le.diag_code8_LENGTH_ErrorCount,le.diag_code8_WORDS_ErrorCount
          ,le.ext_injury_diag_code_LEFTTRIM_ErrorCount,le.ext_injury_diag_code_ALLOW_ErrorCount,le.ext_injury_diag_code_LENGTH_ErrorCount,le.ext_injury_diag_code_WORDS_ErrorCount
          ,le.facility_lab_addr_LEFTTRIM_ErrorCount,le.facility_lab_addr_ALLOW_ErrorCount
          ,le.facility_lab_city_LEFTTRIM_ErrorCount,le.facility_lab_city_ALLOW_ErrorCount
          ,le.facility_lab_name_LEFTTRIM_ErrorCount,le.facility_lab_name_ALLOW_ErrorCount
          ,le.facility_lab_npi_LEFTTRIM_ErrorCount,le.facility_lab_npi_ALLOW_ErrorCount,le.facility_lab_npi_LENGTH_ErrorCount,le.facility_lab_npi_WORDS_ErrorCount
          ,le.facility_lab_state_LEFTTRIM_ErrorCount,le.facility_lab_state_ALLOW_ErrorCount,le.facility_lab_state_LENGTH_ErrorCount,le.facility_lab_state_WORDS_ErrorCount
          ,le.facility_lab_zip_LEFTTRIM_ErrorCount,le.facility_lab_zip_ALLOW_ErrorCount,le.facility_lab_zip_LENGTH_ErrorCount,le.facility_lab_zip_WORDS_ErrorCount
          ,le.ordering_prov_first_name_LEFTTRIM_ErrorCount,le.ordering_prov_first_name_ALLOW_ErrorCount
          ,le.ordering_prov_last_name_LEFTTRIM_ErrorCount,le.ordering_prov_last_name_ALLOW_ErrorCount
          ,le.ordering_prov_middle_name_LEFTTRIM_ErrorCount,le.ordering_prov_middle_name_ALLOW_ErrorCount
          ,le.ordering_prov_npi_LEFTTRIM_ErrorCount,le.ordering_prov_npi_ALLOW_ErrorCount,le.ordering_prov_npi_LENGTH_ErrorCount,le.ordering_prov_npi_WORDS_ErrorCount
          ,le.ordering_prov_state_LEFTTRIM_ErrorCount,le.ordering_prov_state_ALLOW_ErrorCount,le.ordering_prov_state_LENGTH_ErrorCount,le.ordering_prov_state_WORDS_ErrorCount
          ,le.pay_to_addr_LEFTTRIM_ErrorCount,le.pay_to_addr_ALLOW_ErrorCount
          ,le.pay_to_city_LEFTTRIM_ErrorCount,le.pay_to_city_ALLOW_ErrorCount
          ,le.pay_to_state_LEFTTRIM_ErrorCount,le.pay_to_state_ALLOW_ErrorCount,le.pay_to_state_LENGTH_ErrorCount,le.pay_to_state_WORDS_ErrorCount
          ,le.pay_to_zip_LEFTTRIM_ErrorCount,le.pay_to_zip_ALLOW_ErrorCount,le.pay_to_zip_LENGTH_ErrorCount,le.pay_to_zip_WORDS_ErrorCount
          ,le.performing_prov_tax_id_LEFTTRIM_ErrorCount,le.performing_prov_tax_id_ALLOW_ErrorCount,le.performing_prov_tax_id_LENGTH_ErrorCount,le.performing_prov_tax_id_WORDS_ErrorCount
          ,le.place_of_service_code_LEFTTRIM_ErrorCount,le.place_of_service_code_ALLOW_ErrorCount,le.place_of_service_code_LENGTH_ErrorCount,le.place_of_service_code_WORDS_ErrorCount
          ,le.place_of_service_name_LEFTTRIM_ErrorCount,le.place_of_service_name_ALLOW_ErrorCount
          ,le.prov_a_addr_LEFTTRIM_ErrorCount,le.prov_a_addr_ALLOW_ErrorCount
          ,le.prov_a_city_LEFTTRIM_ErrorCount,le.prov_a_city_ALLOW_ErrorCount
          ,le.prov_a_service_role_code_LEFTTRIM_ErrorCount,le.prov_a_service_role_code_ALLOW_ErrorCount,le.prov_a_service_role_code_LENGTH_ErrorCount,le.prov_a_service_role_code_WORDS_ErrorCount
          ,le.prov_a_state_LEFTTRIM_ErrorCount,le.prov_a_state_ALLOW_ErrorCount,le.prov_a_state_LENGTH_ErrorCount,le.prov_a_state_WORDS_ErrorCount
          ,le.prov_a_zip_LEFTTRIM_ErrorCount,le.prov_a_zip_ALLOW_ErrorCount,le.prov_a_zip_LENGTH_ErrorCount,le.prov_a_zip_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.claim_type_LEFTTRIM_ErrorCount,le.claim_type_ALLOW_ErrorCount,le.claim_type_LENGTH_ErrorCount,le.claim_type_WORDS_ErrorCount
          ,le.claim_num_LEFTTRIM_ErrorCount,le.claim_num_ALLOW_ErrorCount,le.claim_num_LENGTH_ErrorCount,le.claim_num_WORDS_ErrorCount
          ,le.billing_addr_LEFTTRIM_ErrorCount,le.billing_addr_ALLOW_ErrorCount
          ,le.billing_city_LEFTTRIM_ErrorCount,le.billing_city_ALLOW_ErrorCount
          ,le.billing_first_name_LEFTTRIM_ErrorCount,le.billing_first_name_ALLOW_ErrorCount
          ,le.billing_last_name_LEFTTRIM_ErrorCount,le.billing_last_name_ALLOW_ErrorCount
          ,le.billing_npi_LEFTTRIM_ErrorCount,le.billing_npi_ALLOW_ErrorCount,le.billing_npi_LENGTH_ErrorCount,le.billing_npi_WORDS_ErrorCount
          ,le.billing_org_name_LEFTTRIM_ErrorCount,le.billing_org_name_ALLOW_ErrorCount
          ,le.billing_specialty_code_LEFTTRIM_ErrorCount,le.billing_specialty_code_ALLOW_ErrorCount,le.billing_specialty_code_LENGTH_ErrorCount,le.billing_specialty_code_WORDS_ErrorCount
          ,le.billing_state_LEFTTRIM_ErrorCount,le.billing_state_ALLOW_ErrorCount,le.billing_state_LENGTH_ErrorCount,le.billing_state_WORDS_ErrorCount
          ,le.billing_tax_id_LEFTTRIM_ErrorCount,le.billing_tax_id_ALLOW_ErrorCount,le.billing_tax_id_LENGTH_ErrorCount,le.billing_tax_id_WORDS_ErrorCount
          ,le.billing_upin_LEFTTRIM_ErrorCount,le.billing_upin_ALLOW_ErrorCount,le.billing_upin_LENGTH_ErrorCount,le.billing_upin_WORDS_ErrorCount
          ,le.billing_zip_LEFTTRIM_ErrorCount,le.billing_zip_ALLOW_ErrorCount,le.billing_zip_LENGTH_ErrorCount,le.billing_zip_WORDS_ErrorCount
          ,le.diag_code1_LEFTTRIM_ErrorCount,le.diag_code1_ALLOW_ErrorCount,le.diag_code1_LENGTH_ErrorCount,le.diag_code1_WORDS_ErrorCount
          ,le.diag_code2_LEFTTRIM_ErrorCount,le.diag_code2_ALLOW_ErrorCount,le.diag_code2_LENGTH_ErrorCount,le.diag_code2_WORDS_ErrorCount
          ,le.diag_code3_LEFTTRIM_ErrorCount,le.diag_code3_ALLOW_ErrorCount,le.diag_code3_LENGTH_ErrorCount,le.diag_code3_WORDS_ErrorCount
          ,le.diag_code4_LEFTTRIM_ErrorCount,le.diag_code4_ALLOW_ErrorCount,le.diag_code4_LENGTH_ErrorCount,le.diag_code4_WORDS_ErrorCount
          ,le.diag_code5_LEFTTRIM_ErrorCount,le.diag_code5_ALLOW_ErrorCount,le.diag_code5_LENGTH_ErrorCount,le.diag_code5_WORDS_ErrorCount
          ,le.diag_code6_LEFTTRIM_ErrorCount,le.diag_code6_ALLOW_ErrorCount,le.diag_code6_LENGTH_ErrorCount,le.diag_code6_WORDS_ErrorCount
          ,le.diag_code7_LEFTTRIM_ErrorCount,le.diag_code7_ALLOW_ErrorCount,le.diag_code7_LENGTH_ErrorCount,le.diag_code7_WORDS_ErrorCount
          ,le.diag_code8_LEFTTRIM_ErrorCount,le.diag_code8_ALLOW_ErrorCount,le.diag_code8_LENGTH_ErrorCount,le.diag_code8_WORDS_ErrorCount
          ,le.ext_injury_diag_code_LEFTTRIM_ErrorCount,le.ext_injury_diag_code_ALLOW_ErrorCount,le.ext_injury_diag_code_LENGTH_ErrorCount,le.ext_injury_diag_code_WORDS_ErrorCount
          ,le.facility_lab_addr_LEFTTRIM_ErrorCount,le.facility_lab_addr_ALLOW_ErrorCount
          ,le.facility_lab_city_LEFTTRIM_ErrorCount,le.facility_lab_city_ALLOW_ErrorCount
          ,le.facility_lab_name_LEFTTRIM_ErrorCount,le.facility_lab_name_ALLOW_ErrorCount
          ,le.facility_lab_npi_LEFTTRIM_ErrorCount,le.facility_lab_npi_ALLOW_ErrorCount,le.facility_lab_npi_LENGTH_ErrorCount,le.facility_lab_npi_WORDS_ErrorCount
          ,le.facility_lab_state_LEFTTRIM_ErrorCount,le.facility_lab_state_ALLOW_ErrorCount,le.facility_lab_state_LENGTH_ErrorCount,le.facility_lab_state_WORDS_ErrorCount
          ,le.facility_lab_zip_LEFTTRIM_ErrorCount,le.facility_lab_zip_ALLOW_ErrorCount,le.facility_lab_zip_LENGTH_ErrorCount,le.facility_lab_zip_WORDS_ErrorCount
          ,le.ordering_prov_first_name_LEFTTRIM_ErrorCount,le.ordering_prov_first_name_ALLOW_ErrorCount
          ,le.ordering_prov_last_name_LEFTTRIM_ErrorCount,le.ordering_prov_last_name_ALLOW_ErrorCount
          ,le.ordering_prov_middle_name_LEFTTRIM_ErrorCount,le.ordering_prov_middle_name_ALLOW_ErrorCount
          ,le.ordering_prov_npi_LEFTTRIM_ErrorCount,le.ordering_prov_npi_ALLOW_ErrorCount,le.ordering_prov_npi_LENGTH_ErrorCount,le.ordering_prov_npi_WORDS_ErrorCount
          ,le.ordering_prov_state_LEFTTRIM_ErrorCount,le.ordering_prov_state_ALLOW_ErrorCount,le.ordering_prov_state_LENGTH_ErrorCount,le.ordering_prov_state_WORDS_ErrorCount
          ,le.pay_to_addr_LEFTTRIM_ErrorCount,le.pay_to_addr_ALLOW_ErrorCount
          ,le.pay_to_city_LEFTTRIM_ErrorCount,le.pay_to_city_ALLOW_ErrorCount
          ,le.pay_to_state_LEFTTRIM_ErrorCount,le.pay_to_state_ALLOW_ErrorCount,le.pay_to_state_LENGTH_ErrorCount,le.pay_to_state_WORDS_ErrorCount
          ,le.pay_to_zip_LEFTTRIM_ErrorCount,le.pay_to_zip_ALLOW_ErrorCount,le.pay_to_zip_LENGTH_ErrorCount,le.pay_to_zip_WORDS_ErrorCount
          ,le.performing_prov_tax_id_LEFTTRIM_ErrorCount,le.performing_prov_tax_id_ALLOW_ErrorCount,le.performing_prov_tax_id_LENGTH_ErrorCount,le.performing_prov_tax_id_WORDS_ErrorCount
          ,le.place_of_service_code_LEFTTRIM_ErrorCount,le.place_of_service_code_ALLOW_ErrorCount,le.place_of_service_code_LENGTH_ErrorCount,le.place_of_service_code_WORDS_ErrorCount
          ,le.place_of_service_name_LEFTTRIM_ErrorCount,le.place_of_service_name_ALLOW_ErrorCount
          ,le.prov_a_addr_LEFTTRIM_ErrorCount,le.prov_a_addr_ALLOW_ErrorCount
          ,le.prov_a_city_LEFTTRIM_ErrorCount,le.prov_a_city_ALLOW_ErrorCount
          ,le.prov_a_service_role_code_LEFTTRIM_ErrorCount,le.prov_a_service_role_code_ALLOW_ErrorCount,le.prov_a_service_role_code_LENGTH_ErrorCount,le.prov_a_service_role_code_WORDS_ErrorCount
          ,le.prov_a_state_LEFTTRIM_ErrorCount,le.prov_a_state_ALLOW_ErrorCount,le.prov_a_state_LENGTH_ErrorCount,le.prov_a_state_WORDS_ErrorCount
          ,le.prov_a_zip_LEFTTRIM_ErrorCount,le.prov_a_zip_ALLOW_ErrorCount,le.prov_a_zip_LENGTH_ErrorCount,le.prov_a_zip_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,148,Into(LEFT,COUNTER));
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
