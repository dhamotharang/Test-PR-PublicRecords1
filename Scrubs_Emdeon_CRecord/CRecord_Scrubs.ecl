IMPORT ut,SALT31;
EXPORT CRecord_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(CRecord_Layout_CRecord)
    UNSIGNED1 claim_num_Invalid;
    UNSIGNED1 claim_rec_type_Invalid;
    UNSIGNED1 payer_id_Invalid;
    UNSIGNED1 form_type_Invalid;
    UNSIGNED1 received_date_Invalid;
    UNSIGNED1 claim_type_Invalid;
    UNSIGNED1 adjustment_code_Invalid;
    UNSIGNED1 prev_claim_number_Invalid;
    UNSIGNED1 member_dob_Invalid;
    UNSIGNED1 member_state_Invalid;
    UNSIGNED1 member_zip_Invalid;
    UNSIGNED1 patient_relation_Invalid;
    UNSIGNED1 patient_gender_Invalid;
    UNSIGNED1 patient_dob_Invalid;
    UNSIGNED1 billing_id_Invalid;
    UNSIGNED1 billing_npi_Invalid;
    UNSIGNED1 billing_state_Invalid;
    UNSIGNED1 billing_zip_Invalid;
    UNSIGNED1 referring_id_Invalid;
    UNSIGNED1 referring_npi_Invalid;
    UNSIGNED1 referring_name1_Invalid;
    UNSIGNED1 referring_name2_Invalid;
    UNSIGNED1 attending_id_Invalid;
    UNSIGNED1 attending_npi_Invalid;
    UNSIGNED1 facility_state_Invalid;
    UNSIGNED1 facility_zip_Invalid;
    UNSIGNED1 statement_to_Invalid;
    UNSIGNED1 total_charge_Invalid;
    UNSIGNED1 drg_code_Invalid;
    UNSIGNED1 bill_type_Invalid;
    UNSIGNED1 release_sign_Invalid;
    UNSIGNED1 assignment_sign_Invalid;
    UNSIGNED1 principal_proc_Invalid;
    UNSIGNED1 admit_diag_Invalid;
    UNSIGNED1 primary_diag_Invalid;
    UNSIGNED1 diag_code2_Invalid;
    UNSIGNED1 diag_code3_Invalid;
    UNSIGNED1 diag_code4_Invalid;
    UNSIGNED1 diag_code5_Invalid;
    UNSIGNED1 diag_code6_Invalid;
    UNSIGNED1 diag_code7_Invalid;
    UNSIGNED1 diag_code8_Invalid;
    UNSIGNED1 other_proc_Invalid;
    UNSIGNED1 other_proc3_Invalid;
    UNSIGNED1 other_proc4_Invalid;
    UNSIGNED1 other_proc5_Invalid;
    UNSIGNED1 other_proc6_Invalid;
    UNSIGNED1 coverage_type_Invalid;
    UNSIGNED1 accident_related_Invalid;
    UNSIGNED1 esrd_patient_Invalid;
    UNSIGNED1 hosp_admit_or_er_Invalid;
    UNSIGNED1 amb_nurse_to_hosp_Invalid;
    UNSIGNED1 non_covered_specialty_Invalid;
    UNSIGNED1 electronic_claim_Invalid;
    UNSIGNED1 dialysis_related_Invalid;
    UNSIGNED1 new_patient_Invalid;
    UNSIGNED1 init_proc_Invalid;
    UNSIGNED1 amb_nurse_to_diag_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(CRecord_Layout_CRecord)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
  END;
EXPORT FromNone(DATASET(CRecord_Layout_CRecord) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.claim_num_Invalid := CRecord_Fields.InValid_claim_num((SALT31.StrType)le.claim_num);
    SELF.claim_rec_type_Invalid := CRecord_Fields.InValid_claim_rec_type((SALT31.StrType)le.claim_rec_type);
    SELF.payer_id_Invalid := CRecord_Fields.InValid_payer_id((SALT31.StrType)le.payer_id);
    SELF.form_type_Invalid := CRecord_Fields.InValid_form_type((SALT31.StrType)le.form_type);
    SELF.received_date_Invalid := CRecord_Fields.InValid_received_date((SALT31.StrType)le.received_date);
    SELF.claim_type_Invalid := CRecord_Fields.InValid_claim_type((SALT31.StrType)le.claim_type);
    SELF.adjustment_code_Invalid := CRecord_Fields.InValid_adjustment_code((SALT31.StrType)le.adjustment_code);
    SELF.prev_claim_number_Invalid := CRecord_Fields.InValid_prev_claim_number((SALT31.StrType)le.prev_claim_number);
    SELF.member_dob_Invalid := CRecord_Fields.InValid_member_dob((SALT31.StrType)le.member_dob);
    SELF.member_state_Invalid := CRecord_Fields.InValid_member_state((SALT31.StrType)le.member_state);
    SELF.member_zip_Invalid := CRecord_Fields.InValid_member_zip((SALT31.StrType)le.member_zip);
    SELF.patient_relation_Invalid := CRecord_Fields.InValid_patient_relation((SALT31.StrType)le.patient_relation);
    SELF.patient_gender_Invalid := CRecord_Fields.InValid_patient_gender((SALT31.StrType)le.patient_gender);
    SELF.patient_dob_Invalid := CRecord_Fields.InValid_patient_dob((SALT31.StrType)le.patient_dob);
    SELF.billing_id_Invalid := CRecord_Fields.InValid_billing_id((SALT31.StrType)le.billing_id);
    SELF.billing_npi_Invalid := CRecord_Fields.InValid_billing_npi((SALT31.StrType)le.billing_npi);
    SELF.billing_state_Invalid := CRecord_Fields.InValid_billing_state((SALT31.StrType)le.billing_state);
    SELF.billing_zip_Invalid := CRecord_Fields.InValid_billing_zip((SALT31.StrType)le.billing_zip);
    SELF.referring_id_Invalid := CRecord_Fields.InValid_referring_id((SALT31.StrType)le.referring_id);
    SELF.referring_npi_Invalid := CRecord_Fields.InValid_referring_npi((SALT31.StrType)le.referring_npi);
    SELF.referring_name1_Invalid := CRecord_Fields.InValid_referring_name1((SALT31.StrType)le.referring_name1);
    SELF.referring_name2_Invalid := CRecord_Fields.InValid_referring_name2((SALT31.StrType)le.referring_name2);
    SELF.attending_id_Invalid := CRecord_Fields.InValid_attending_id((SALT31.StrType)le.attending_id);
    SELF.attending_npi_Invalid := CRecord_Fields.InValid_attending_npi((SALT31.StrType)le.attending_npi);
    SELF.facility_state_Invalid := CRecord_Fields.InValid_facility_state((SALT31.StrType)le.facility_state);
    SELF.facility_zip_Invalid := CRecord_Fields.InValid_facility_zip((SALT31.StrType)le.facility_zip);
    SELF.statement_to_Invalid := CRecord_Fields.InValid_statement_to((SALT31.StrType)le.statement_to);
    SELF.total_charge_Invalid := CRecord_Fields.InValid_total_charge((SALT31.StrType)le.total_charge);
    SELF.drg_code_Invalid := CRecord_Fields.InValid_drg_code((SALT31.StrType)le.drg_code);
    SELF.bill_type_Invalid := CRecord_Fields.InValid_bill_type((SALT31.StrType)le.bill_type);
    SELF.release_sign_Invalid := CRecord_Fields.InValid_release_sign((SALT31.StrType)le.release_sign);
    SELF.assignment_sign_Invalid := CRecord_Fields.InValid_assignment_sign((SALT31.StrType)le.assignment_sign);
    SELF.principal_proc_Invalid := CRecord_Fields.InValid_principal_proc((SALT31.StrType)le.principal_proc);
    SELF.admit_diag_Invalid := CRecord_Fields.InValid_admit_diag((SALT31.StrType)le.admit_diag);
    SELF.primary_diag_Invalid := CRecord_Fields.InValid_primary_diag((SALT31.StrType)le.primary_diag);
    SELF.diag_code2_Invalid := CRecord_Fields.InValid_diag_code2((SALT31.StrType)le.diag_code2);
    SELF.diag_code3_Invalid := CRecord_Fields.InValid_diag_code3((SALT31.StrType)le.diag_code3);
    SELF.diag_code4_Invalid := CRecord_Fields.InValid_diag_code4((SALT31.StrType)le.diag_code4);
    SELF.diag_code5_Invalid := CRecord_Fields.InValid_diag_code5((SALT31.StrType)le.diag_code5);
    SELF.diag_code6_Invalid := CRecord_Fields.InValid_diag_code6((SALT31.StrType)le.diag_code6);
    SELF.diag_code7_Invalid := CRecord_Fields.InValid_diag_code7((SALT31.StrType)le.diag_code7);
    SELF.diag_code8_Invalid := CRecord_Fields.InValid_diag_code8((SALT31.StrType)le.diag_code8);
    SELF.other_proc_Invalid := CRecord_Fields.InValid_other_proc((SALT31.StrType)le.other_proc);
    SELF.other_proc3_Invalid := CRecord_Fields.InValid_other_proc3((SALT31.StrType)le.other_proc3);
    SELF.other_proc4_Invalid := CRecord_Fields.InValid_other_proc4((SALT31.StrType)le.other_proc4);
    SELF.other_proc5_Invalid := CRecord_Fields.InValid_other_proc5((SALT31.StrType)le.other_proc5);
    SELF.other_proc6_Invalid := CRecord_Fields.InValid_other_proc6((SALT31.StrType)le.other_proc6);
    SELF.coverage_type_Invalid := CRecord_Fields.InValid_coverage_type((SALT31.StrType)le.coverage_type);
    SELF.accident_related_Invalid := CRecord_Fields.InValid_accident_related((SALT31.StrType)le.accident_related);
    SELF.esrd_patient_Invalid := CRecord_Fields.InValid_esrd_patient((SALT31.StrType)le.esrd_patient);
    SELF.hosp_admit_or_er_Invalid := CRecord_Fields.InValid_hosp_admit_or_er((SALT31.StrType)le.hosp_admit_or_er);
    SELF.amb_nurse_to_hosp_Invalid := CRecord_Fields.InValid_amb_nurse_to_hosp((SALT31.StrType)le.amb_nurse_to_hosp);
    SELF.non_covered_specialty_Invalid := CRecord_Fields.InValid_non_covered_specialty((SALT31.StrType)le.non_covered_specialty);
    SELF.electronic_claim_Invalid := CRecord_Fields.InValid_electronic_claim((SALT31.StrType)le.electronic_claim);
    SELF.dialysis_related_Invalid := CRecord_Fields.InValid_dialysis_related((SALT31.StrType)le.dialysis_related);
    SELF.new_patient_Invalid := CRecord_Fields.InValid_new_patient((SALT31.StrType)le.new_patient);
    SELF.init_proc_Invalid := CRecord_Fields.InValid_init_proc((SALT31.StrType)le.init_proc);
    SELF.amb_nurse_to_diag_Invalid := CRecord_Fields.InValid_amb_nurse_to_diag((SALT31.StrType)le.amb_nurse_to_diag);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.claim_num_Invalid << 0 ) + ( le.claim_rec_type_Invalid << 3 ) + ( le.payer_id_Invalid << 6 ) + ( le.form_type_Invalid << 9 ) + ( le.received_date_Invalid << 12 ) + ( le.claim_type_Invalid << 15 ) + ( le.adjustment_code_Invalid << 18 ) + ( le.prev_claim_number_Invalid << 21 ) + ( le.member_dob_Invalid << 23 ) + ( le.member_state_Invalid << 26 ) + ( le.member_zip_Invalid << 29 ) + ( le.patient_relation_Invalid << 32 ) + ( le.patient_gender_Invalid << 35 ) + ( le.patient_dob_Invalid << 38 ) + ( le.billing_id_Invalid << 41 ) + ( le.billing_npi_Invalid << 44 ) + ( le.billing_state_Invalid << 47 ) + ( le.billing_zip_Invalid << 50 ) + ( le.referring_id_Invalid << 53 ) + ( le.referring_npi_Invalid << 56 ) + ( le.referring_name1_Invalid << 59 ) + ( le.referring_name2_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.attending_id_Invalid << 0 ) + ( le.attending_npi_Invalid << 2 ) + ( le.facility_state_Invalid << 5 ) + ( le.facility_zip_Invalid << 8 ) + ( le.statement_to_Invalid << 11 ) + ( le.total_charge_Invalid << 13 ) + ( le.drg_code_Invalid << 15 ) + ( le.bill_type_Invalid << 18 ) + ( le.release_sign_Invalid << 21 ) + ( le.assignment_sign_Invalid << 24 ) + ( le.principal_proc_Invalid << 27 ) + ( le.admit_diag_Invalid << 30 ) + ( le.primary_diag_Invalid << 33 ) + ( le.diag_code2_Invalid << 36 ) + ( le.diag_code3_Invalid << 39 ) + ( le.diag_code4_Invalid << 42 ) + ( le.diag_code5_Invalid << 45 ) + ( le.diag_code6_Invalid << 48 ) + ( le.diag_code7_Invalid << 51 ) + ( le.diag_code8_Invalid << 54 ) + ( le.other_proc_Invalid << 57 ) + ( le.other_proc3_Invalid << 60 );
    SELF.ScrubsBits3 := ( le.other_proc4_Invalid << 0 ) + ( le.other_proc5_Invalid << 3 ) + ( le.other_proc6_Invalid << 6 ) + ( le.coverage_type_Invalid << 9 ) + ( le.accident_related_Invalid << 12 ) + ( le.esrd_patient_Invalid << 15 ) + ( le.hosp_admit_or_er_Invalid << 18 ) + ( le.amb_nurse_to_hosp_Invalid << 21 ) + ( le.non_covered_specialty_Invalid << 24 ) + ( le.electronic_claim_Invalid << 27 ) + ( le.dialysis_related_Invalid << 30 ) + ( le.new_patient_Invalid << 33 ) + ( le.init_proc_Invalid << 36 ) + ( le.amb_nurse_to_diag_Invalid << 39 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,CRecord_Layout_CRecord);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.claim_num_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.claim_rec_type_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.payer_id_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.form_type_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.received_date_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.claim_type_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.adjustment_code_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.prev_claim_number_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.member_dob_Invalid := (le.ScrubsBits1 >> 23) & 7;
    SELF.member_state_Invalid := (le.ScrubsBits1 >> 26) & 7;
    SELF.member_zip_Invalid := (le.ScrubsBits1 >> 29) & 7;
    SELF.patient_relation_Invalid := (le.ScrubsBits1 >> 32) & 7;
    SELF.patient_gender_Invalid := (le.ScrubsBits1 >> 35) & 7;
    SELF.patient_dob_Invalid := (le.ScrubsBits1 >> 38) & 7;
    SELF.billing_id_Invalid := (le.ScrubsBits1 >> 41) & 7;
    SELF.billing_npi_Invalid := (le.ScrubsBits1 >> 44) & 7;
    SELF.billing_state_Invalid := (le.ScrubsBits1 >> 47) & 7;
    SELF.billing_zip_Invalid := (le.ScrubsBits1 >> 50) & 7;
    SELF.referring_id_Invalid := (le.ScrubsBits1 >> 53) & 7;
    SELF.referring_npi_Invalid := (le.ScrubsBits1 >> 56) & 7;
    SELF.referring_name1_Invalid := (le.ScrubsBits1 >> 59) & 7;
    SELF.referring_name2_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.attending_id_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.attending_npi_Invalid := (le.ScrubsBits2 >> 2) & 7;
    SELF.facility_state_Invalid := (le.ScrubsBits2 >> 5) & 7;
    SELF.facility_zip_Invalid := (le.ScrubsBits2 >> 8) & 7;
    SELF.statement_to_Invalid := (le.ScrubsBits2 >> 11) & 3;
    SELF.total_charge_Invalid := (le.ScrubsBits2 >> 13) & 3;
    SELF.drg_code_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.bill_type_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.release_sign_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.assignment_sign_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.principal_proc_Invalid := (le.ScrubsBits2 >> 27) & 7;
    SELF.admit_diag_Invalid := (le.ScrubsBits2 >> 30) & 7;
    SELF.primary_diag_Invalid := (le.ScrubsBits2 >> 33) & 7;
    SELF.diag_code2_Invalid := (le.ScrubsBits2 >> 36) & 7;
    SELF.diag_code3_Invalid := (le.ScrubsBits2 >> 39) & 7;
    SELF.diag_code4_Invalid := (le.ScrubsBits2 >> 42) & 7;
    SELF.diag_code5_Invalid := (le.ScrubsBits2 >> 45) & 7;
    SELF.diag_code6_Invalid := (le.ScrubsBits2 >> 48) & 7;
    SELF.diag_code7_Invalid := (le.ScrubsBits2 >> 51) & 7;
    SELF.diag_code8_Invalid := (le.ScrubsBits2 >> 54) & 7;
    SELF.other_proc_Invalid := (le.ScrubsBits2 >> 57) & 7;
    SELF.other_proc3_Invalid := (le.ScrubsBits2 >> 60) & 7;
    SELF.other_proc4_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.other_proc5_Invalid := (le.ScrubsBits3 >> 3) & 7;
    SELF.other_proc6_Invalid := (le.ScrubsBits3 >> 6) & 7;
    SELF.coverage_type_Invalid := (le.ScrubsBits3 >> 9) & 7;
    SELF.accident_related_Invalid := (le.ScrubsBits3 >> 12) & 7;
    SELF.esrd_patient_Invalid := (le.ScrubsBits3 >> 15) & 7;
    SELF.hosp_admit_or_er_Invalid := (le.ScrubsBits3 >> 18) & 7;
    SELF.amb_nurse_to_hosp_Invalid := (le.ScrubsBits3 >> 21) & 7;
    SELF.non_covered_specialty_Invalid := (le.ScrubsBits3 >> 24) & 7;
    SELF.electronic_claim_Invalid := (le.ScrubsBits3 >> 27) & 7;
    SELF.dialysis_related_Invalid := (le.ScrubsBits3 >> 30) & 7;
    SELF.new_patient_Invalid := (le.ScrubsBits3 >> 33) & 7;
    SELF.init_proc_Invalid := (le.ScrubsBits3 >> 36) & 7;
    SELF.amb_nurse_to_diag_Invalid := (le.ScrubsBits3 >> 39) & 7;
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
    payer_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.payer_id_Invalid=1);
    payer_id_ALLOW_ErrorCount := COUNT(GROUP,h.payer_id_Invalid=2);
    payer_id_LENGTH_ErrorCount := COUNT(GROUP,h.payer_id_Invalid=3);
    payer_id_WORDS_ErrorCount := COUNT(GROUP,h.payer_id_Invalid=4);
    payer_id_Total_ErrorCount := COUNT(GROUP,h.payer_id_Invalid>0);
    form_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.form_type_Invalid=1);
    form_type_ALLOW_ErrorCount := COUNT(GROUP,h.form_type_Invalid=2);
    form_type_LENGTH_ErrorCount := COUNT(GROUP,h.form_type_Invalid=3);
    form_type_WORDS_ErrorCount := COUNT(GROUP,h.form_type_Invalid=4);
    form_type_Total_ErrorCount := COUNT(GROUP,h.form_type_Invalid>0);
    received_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.received_date_Invalid=1);
    received_date_ALLOW_ErrorCount := COUNT(GROUP,h.received_date_Invalid=2);
    received_date_LENGTH_ErrorCount := COUNT(GROUP,h.received_date_Invalid=3);
    received_date_WORDS_ErrorCount := COUNT(GROUP,h.received_date_Invalid=4);
    received_date_Total_ErrorCount := COUNT(GROUP,h.received_date_Invalid>0);
    claim_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.claim_type_Invalid=1);
    claim_type_ALLOW_ErrorCount := COUNT(GROUP,h.claim_type_Invalid=2);
    claim_type_LENGTH_ErrorCount := COUNT(GROUP,h.claim_type_Invalid=3);
    claim_type_WORDS_ErrorCount := COUNT(GROUP,h.claim_type_Invalid=4);
    claim_type_Total_ErrorCount := COUNT(GROUP,h.claim_type_Invalid>0);
    adjustment_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.adjustment_code_Invalid=1);
    adjustment_code_ALLOW_ErrorCount := COUNT(GROUP,h.adjustment_code_Invalid=2);
    adjustment_code_LENGTH_ErrorCount := COUNT(GROUP,h.adjustment_code_Invalid=3);
    adjustment_code_WORDS_ErrorCount := COUNT(GROUP,h.adjustment_code_Invalid=4);
    adjustment_code_Total_ErrorCount := COUNT(GROUP,h.adjustment_code_Invalid>0);
    prev_claim_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prev_claim_number_Invalid=1);
    prev_claim_number_ALLOW_ErrorCount := COUNT(GROUP,h.prev_claim_number_Invalid=2);
    prev_claim_number_Total_ErrorCount := COUNT(GROUP,h.prev_claim_number_Invalid>0);
    member_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.member_dob_Invalid=1);
    member_dob_ALLOW_ErrorCount := COUNT(GROUP,h.member_dob_Invalid=2);
    member_dob_LENGTH_ErrorCount := COUNT(GROUP,h.member_dob_Invalid=3);
    member_dob_WORDS_ErrorCount := COUNT(GROUP,h.member_dob_Invalid=4);
    member_dob_Total_ErrorCount := COUNT(GROUP,h.member_dob_Invalid>0);
    member_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.member_state_Invalid=1);
    member_state_ALLOW_ErrorCount := COUNT(GROUP,h.member_state_Invalid=2);
    member_state_LENGTH_ErrorCount := COUNT(GROUP,h.member_state_Invalid=3);
    member_state_WORDS_ErrorCount := COUNT(GROUP,h.member_state_Invalid=4);
    member_state_Total_ErrorCount := COUNT(GROUP,h.member_state_Invalid>0);
    member_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.member_zip_Invalid=1);
    member_zip_ALLOW_ErrorCount := COUNT(GROUP,h.member_zip_Invalid=2);
    member_zip_LENGTH_ErrorCount := COUNT(GROUP,h.member_zip_Invalid=3);
    member_zip_WORDS_ErrorCount := COUNT(GROUP,h.member_zip_Invalid=4);
    member_zip_Total_ErrorCount := COUNT(GROUP,h.member_zip_Invalid>0);
    patient_relation_LEFTTRIM_ErrorCount := COUNT(GROUP,h.patient_relation_Invalid=1);
    patient_relation_ALLOW_ErrorCount := COUNT(GROUP,h.patient_relation_Invalid=2);
    patient_relation_LENGTH_ErrorCount := COUNT(GROUP,h.patient_relation_Invalid=3);
    patient_relation_WORDS_ErrorCount := COUNT(GROUP,h.patient_relation_Invalid=4);
    patient_relation_Total_ErrorCount := COUNT(GROUP,h.patient_relation_Invalid>0);
    patient_gender_LEFTTRIM_ErrorCount := COUNT(GROUP,h.patient_gender_Invalid=1);
    patient_gender_ALLOW_ErrorCount := COUNT(GROUP,h.patient_gender_Invalid=2);
    patient_gender_LENGTH_ErrorCount := COUNT(GROUP,h.patient_gender_Invalid=3);
    patient_gender_WORDS_ErrorCount := COUNT(GROUP,h.patient_gender_Invalid=4);
    patient_gender_Total_ErrorCount := COUNT(GROUP,h.patient_gender_Invalid>0);
    patient_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.patient_dob_Invalid=1);
    patient_dob_ALLOW_ErrorCount := COUNT(GROUP,h.patient_dob_Invalid=2);
    patient_dob_LENGTH_ErrorCount := COUNT(GROUP,h.patient_dob_Invalid=3);
    patient_dob_WORDS_ErrorCount := COUNT(GROUP,h.patient_dob_Invalid=4);
    patient_dob_Total_ErrorCount := COUNT(GROUP,h.patient_dob_Invalid>0);
    billing_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_id_Invalid=1);
    billing_id_ALLOW_ErrorCount := COUNT(GROUP,h.billing_id_Invalid=2);
    billing_id_LENGTH_ErrorCount := COUNT(GROUP,h.billing_id_Invalid=3);
    billing_id_WORDS_ErrorCount := COUNT(GROUP,h.billing_id_Invalid=4);
    billing_id_Total_ErrorCount := COUNT(GROUP,h.billing_id_Invalid>0);
    billing_npi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=1);
    billing_npi_ALLOW_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=2);
    billing_npi_LENGTH_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=3);
    billing_npi_WORDS_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid=4);
    billing_npi_Total_ErrorCount := COUNT(GROUP,h.billing_npi_Invalid>0);
    billing_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_state_Invalid=1);
    billing_state_ALLOW_ErrorCount := COUNT(GROUP,h.billing_state_Invalid=2);
    billing_state_LENGTH_ErrorCount := COUNT(GROUP,h.billing_state_Invalid=3);
    billing_state_WORDS_ErrorCount := COUNT(GROUP,h.billing_state_Invalid=4);
    billing_state_Total_ErrorCount := COUNT(GROUP,h.billing_state_Invalid>0);
    billing_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=1);
    billing_zip_ALLOW_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=2);
    billing_zip_LENGTH_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=3);
    billing_zip_WORDS_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid=4);
    billing_zip_Total_ErrorCount := COUNT(GROUP,h.billing_zip_Invalid>0);
    referring_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.referring_id_Invalid=1);
    referring_id_ALLOW_ErrorCount := COUNT(GROUP,h.referring_id_Invalid=2);
    referring_id_LENGTH_ErrorCount := COUNT(GROUP,h.referring_id_Invalid=3);
    referring_id_WORDS_ErrorCount := COUNT(GROUP,h.referring_id_Invalid=4);
    referring_id_Total_ErrorCount := COUNT(GROUP,h.referring_id_Invalid>0);
    referring_npi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.referring_npi_Invalid=1);
    referring_npi_ALLOW_ErrorCount := COUNT(GROUP,h.referring_npi_Invalid=2);
    referring_npi_LENGTH_ErrorCount := COUNT(GROUP,h.referring_npi_Invalid=3);
    referring_npi_WORDS_ErrorCount := COUNT(GROUP,h.referring_npi_Invalid=4);
    referring_npi_Total_ErrorCount := COUNT(GROUP,h.referring_npi_Invalid>0);
    referring_name1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.referring_name1_Invalid=1);
    referring_name1_ALLOW_ErrorCount := COUNT(GROUP,h.referring_name1_Invalid=2);
    referring_name1_LENGTH_ErrorCount := COUNT(GROUP,h.referring_name1_Invalid=3);
    referring_name1_WORDS_ErrorCount := COUNT(GROUP,h.referring_name1_Invalid=4);
    referring_name1_Total_ErrorCount := COUNT(GROUP,h.referring_name1_Invalid>0);
    referring_name2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.referring_name2_Invalid=1);
    referring_name2_ALLOW_ErrorCount := COUNT(GROUP,h.referring_name2_Invalid=2);
    referring_name2_Total_ErrorCount := COUNT(GROUP,h.referring_name2_Invalid>0);
    attending_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.attending_id_Invalid=1);
    attending_id_ALLOW_ErrorCount := COUNT(GROUP,h.attending_id_Invalid=2);
    attending_id_WORDS_ErrorCount := COUNT(GROUP,h.attending_id_Invalid=3);
    attending_id_Total_ErrorCount := COUNT(GROUP,h.attending_id_Invalid>0);
    attending_npi_LEFTTRIM_ErrorCount := COUNT(GROUP,h.attending_npi_Invalid=1);
    attending_npi_ALLOW_ErrorCount := COUNT(GROUP,h.attending_npi_Invalid=2);
    attending_npi_LENGTH_ErrorCount := COUNT(GROUP,h.attending_npi_Invalid=3);
    attending_npi_WORDS_ErrorCount := COUNT(GROUP,h.attending_npi_Invalid=4);
    attending_npi_Total_ErrorCount := COUNT(GROUP,h.attending_npi_Invalid>0);
    facility_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.facility_state_Invalid=1);
    facility_state_ALLOW_ErrorCount := COUNT(GROUP,h.facility_state_Invalid=2);
    facility_state_LENGTH_ErrorCount := COUNT(GROUP,h.facility_state_Invalid=3);
    facility_state_WORDS_ErrorCount := COUNT(GROUP,h.facility_state_Invalid=4);
    facility_state_Total_ErrorCount := COUNT(GROUP,h.facility_state_Invalid>0);
    facility_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.facility_zip_Invalid=1);
    facility_zip_ALLOW_ErrorCount := COUNT(GROUP,h.facility_zip_Invalid=2);
    facility_zip_LENGTH_ErrorCount := COUNT(GROUP,h.facility_zip_Invalid=3);
    facility_zip_WORDS_ErrorCount := COUNT(GROUP,h.facility_zip_Invalid=4);
    facility_zip_Total_ErrorCount := COUNT(GROUP,h.facility_zip_Invalid>0);
    statement_to_LEFTTRIM_ErrorCount := COUNT(GROUP,h.statement_to_Invalid=1);
    statement_to_ALLOW_ErrorCount := COUNT(GROUP,h.statement_to_Invalid=2);
    statement_to_WORDS_ErrorCount := COUNT(GROUP,h.statement_to_Invalid=3);
    statement_to_Total_ErrorCount := COUNT(GROUP,h.statement_to_Invalid>0);
    total_charge_LEFTTRIM_ErrorCount := COUNT(GROUP,h.total_charge_Invalid=1);
    total_charge_ALLOW_ErrorCount := COUNT(GROUP,h.total_charge_Invalid=2);
    total_charge_WORDS_ErrorCount := COUNT(GROUP,h.total_charge_Invalid=3);
    total_charge_Total_ErrorCount := COUNT(GROUP,h.total_charge_Invalid>0);
    drg_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.drg_code_Invalid=1);
    drg_code_ALLOW_ErrorCount := COUNT(GROUP,h.drg_code_Invalid=2);
    drg_code_LENGTH_ErrorCount := COUNT(GROUP,h.drg_code_Invalid=3);
    drg_code_WORDS_ErrorCount := COUNT(GROUP,h.drg_code_Invalid=4);
    drg_code_Total_ErrorCount := COUNT(GROUP,h.drg_code_Invalid>0);
    bill_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.bill_type_Invalid=1);
    bill_type_ALLOW_ErrorCount := COUNT(GROUP,h.bill_type_Invalid=2);
    bill_type_LENGTH_ErrorCount := COUNT(GROUP,h.bill_type_Invalid=3);
    bill_type_WORDS_ErrorCount := COUNT(GROUP,h.bill_type_Invalid=4);
    bill_type_Total_ErrorCount := COUNT(GROUP,h.bill_type_Invalid>0);
    release_sign_LEFTTRIM_ErrorCount := COUNT(GROUP,h.release_sign_Invalid=1);
    release_sign_ALLOW_ErrorCount := COUNT(GROUP,h.release_sign_Invalid=2);
    release_sign_LENGTH_ErrorCount := COUNT(GROUP,h.release_sign_Invalid=3);
    release_sign_WORDS_ErrorCount := COUNT(GROUP,h.release_sign_Invalid=4);
    release_sign_Total_ErrorCount := COUNT(GROUP,h.release_sign_Invalid>0);
    assignment_sign_LEFTTRIM_ErrorCount := COUNT(GROUP,h.assignment_sign_Invalid=1);
    assignment_sign_ALLOW_ErrorCount := COUNT(GROUP,h.assignment_sign_Invalid=2);
    assignment_sign_LENGTH_ErrorCount := COUNT(GROUP,h.assignment_sign_Invalid=3);
    assignment_sign_WORDS_ErrorCount := COUNT(GROUP,h.assignment_sign_Invalid=4);
    assignment_sign_Total_ErrorCount := COUNT(GROUP,h.assignment_sign_Invalid>0);
    principal_proc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.principal_proc_Invalid=1);
    principal_proc_ALLOW_ErrorCount := COUNT(GROUP,h.principal_proc_Invalid=2);
    principal_proc_LENGTH_ErrorCount := COUNT(GROUP,h.principal_proc_Invalid=3);
    principal_proc_WORDS_ErrorCount := COUNT(GROUP,h.principal_proc_Invalid=4);
    principal_proc_Total_ErrorCount := COUNT(GROUP,h.principal_proc_Invalid>0);
    admit_diag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.admit_diag_Invalid=1);
    admit_diag_ALLOW_ErrorCount := COUNT(GROUP,h.admit_diag_Invalid=2);
    admit_diag_LENGTH_ErrorCount := COUNT(GROUP,h.admit_diag_Invalid=3);
    admit_diag_WORDS_ErrorCount := COUNT(GROUP,h.admit_diag_Invalid=4);
    admit_diag_Total_ErrorCount := COUNT(GROUP,h.admit_diag_Invalid>0);
    primary_diag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.primary_diag_Invalid=1);
    primary_diag_ALLOW_ErrorCount := COUNT(GROUP,h.primary_diag_Invalid=2);
    primary_diag_LENGTH_ErrorCount := COUNT(GROUP,h.primary_diag_Invalid=3);
    primary_diag_WORDS_ErrorCount := COUNT(GROUP,h.primary_diag_Invalid=4);
    primary_diag_Total_ErrorCount := COUNT(GROUP,h.primary_diag_Invalid>0);
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
    other_proc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc_Invalid=1);
    other_proc_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc_Invalid=2);
    other_proc_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc_Invalid=3);
    other_proc_WORDS_ErrorCount := COUNT(GROUP,h.other_proc_Invalid=4);
    other_proc_Total_ErrorCount := COUNT(GROUP,h.other_proc_Invalid>0);
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
    other_proc6_LEFTTRIM_ErrorCount := COUNT(GROUP,h.other_proc6_Invalid=1);
    other_proc6_ALLOW_ErrorCount := COUNT(GROUP,h.other_proc6_Invalid=2);
    other_proc6_LENGTH_ErrorCount := COUNT(GROUP,h.other_proc6_Invalid=3);
    other_proc6_WORDS_ErrorCount := COUNT(GROUP,h.other_proc6_Invalid=4);
    other_proc6_Total_ErrorCount := COUNT(GROUP,h.other_proc6_Invalid>0);
    coverage_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.coverage_type_Invalid=1);
    coverage_type_ALLOW_ErrorCount := COUNT(GROUP,h.coverage_type_Invalid=2);
    coverage_type_LENGTH_ErrorCount := COUNT(GROUP,h.coverage_type_Invalid=3);
    coverage_type_WORDS_ErrorCount := COUNT(GROUP,h.coverage_type_Invalid=4);
    coverage_type_Total_ErrorCount := COUNT(GROUP,h.coverage_type_Invalid>0);
    accident_related_LEFTTRIM_ErrorCount := COUNT(GROUP,h.accident_related_Invalid=1);
    accident_related_ALLOW_ErrorCount := COUNT(GROUP,h.accident_related_Invalid=2);
    accident_related_LENGTH_ErrorCount := COUNT(GROUP,h.accident_related_Invalid=3);
    accident_related_WORDS_ErrorCount := COUNT(GROUP,h.accident_related_Invalid=4);
    accident_related_Total_ErrorCount := COUNT(GROUP,h.accident_related_Invalid>0);
    esrd_patient_LEFTTRIM_ErrorCount := COUNT(GROUP,h.esrd_patient_Invalid=1);
    esrd_patient_ALLOW_ErrorCount := COUNT(GROUP,h.esrd_patient_Invalid=2);
    esrd_patient_LENGTH_ErrorCount := COUNT(GROUP,h.esrd_patient_Invalid=3);
    esrd_patient_WORDS_ErrorCount := COUNT(GROUP,h.esrd_patient_Invalid=4);
    esrd_patient_Total_ErrorCount := COUNT(GROUP,h.esrd_patient_Invalid>0);
    hosp_admit_or_er_LEFTTRIM_ErrorCount := COUNT(GROUP,h.hosp_admit_or_er_Invalid=1);
    hosp_admit_or_er_ALLOW_ErrorCount := COUNT(GROUP,h.hosp_admit_or_er_Invalid=2);
    hosp_admit_or_er_LENGTH_ErrorCount := COUNT(GROUP,h.hosp_admit_or_er_Invalid=3);
    hosp_admit_or_er_WORDS_ErrorCount := COUNT(GROUP,h.hosp_admit_or_er_Invalid=4);
    hosp_admit_or_er_Total_ErrorCount := COUNT(GROUP,h.hosp_admit_or_er_Invalid>0);
    amb_nurse_to_hosp_LEFTTRIM_ErrorCount := COUNT(GROUP,h.amb_nurse_to_hosp_Invalid=1);
    amb_nurse_to_hosp_ALLOW_ErrorCount := COUNT(GROUP,h.amb_nurse_to_hosp_Invalid=2);
    amb_nurse_to_hosp_LENGTH_ErrorCount := COUNT(GROUP,h.amb_nurse_to_hosp_Invalid=3);
    amb_nurse_to_hosp_WORDS_ErrorCount := COUNT(GROUP,h.amb_nurse_to_hosp_Invalid=4);
    amb_nurse_to_hosp_Total_ErrorCount := COUNT(GROUP,h.amb_nurse_to_hosp_Invalid>0);
    non_covered_specialty_LEFTTRIM_ErrorCount := COUNT(GROUP,h.non_covered_specialty_Invalid=1);
    non_covered_specialty_ALLOW_ErrorCount := COUNT(GROUP,h.non_covered_specialty_Invalid=2);
    non_covered_specialty_LENGTH_ErrorCount := COUNT(GROUP,h.non_covered_specialty_Invalid=3);
    non_covered_specialty_WORDS_ErrorCount := COUNT(GROUP,h.non_covered_specialty_Invalid=4);
    non_covered_specialty_Total_ErrorCount := COUNT(GROUP,h.non_covered_specialty_Invalid>0);
    electronic_claim_LEFTTRIM_ErrorCount := COUNT(GROUP,h.electronic_claim_Invalid=1);
    electronic_claim_ALLOW_ErrorCount := COUNT(GROUP,h.electronic_claim_Invalid=2);
    electronic_claim_LENGTH_ErrorCount := COUNT(GROUP,h.electronic_claim_Invalid=3);
    electronic_claim_WORDS_ErrorCount := COUNT(GROUP,h.electronic_claim_Invalid=4);
    electronic_claim_Total_ErrorCount := COUNT(GROUP,h.electronic_claim_Invalid>0);
    dialysis_related_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dialysis_related_Invalid=1);
    dialysis_related_ALLOW_ErrorCount := COUNT(GROUP,h.dialysis_related_Invalid=2);
    dialysis_related_LENGTH_ErrorCount := COUNT(GROUP,h.dialysis_related_Invalid=3);
    dialysis_related_WORDS_ErrorCount := COUNT(GROUP,h.dialysis_related_Invalid=4);
    dialysis_related_Total_ErrorCount := COUNT(GROUP,h.dialysis_related_Invalid>0);
    new_patient_LEFTTRIM_ErrorCount := COUNT(GROUP,h.new_patient_Invalid=1);
    new_patient_ALLOW_ErrorCount := COUNT(GROUP,h.new_patient_Invalid=2);
    new_patient_LENGTH_ErrorCount := COUNT(GROUP,h.new_patient_Invalid=3);
    new_patient_WORDS_ErrorCount := COUNT(GROUP,h.new_patient_Invalid=4);
    new_patient_Total_ErrorCount := COUNT(GROUP,h.new_patient_Invalid>0);
    init_proc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.init_proc_Invalid=1);
    init_proc_ALLOW_ErrorCount := COUNT(GROUP,h.init_proc_Invalid=2);
    init_proc_LENGTH_ErrorCount := COUNT(GROUP,h.init_proc_Invalid=3);
    init_proc_WORDS_ErrorCount := COUNT(GROUP,h.init_proc_Invalid=4);
    init_proc_Total_ErrorCount := COUNT(GROUP,h.init_proc_Invalid>0);
    amb_nurse_to_diag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.amb_nurse_to_diag_Invalid=1);
    amb_nurse_to_diag_ALLOW_ErrorCount := COUNT(GROUP,h.amb_nurse_to_diag_Invalid=2);
    amb_nurse_to_diag_LENGTH_ErrorCount := COUNT(GROUP,h.amb_nurse_to_diag_Invalid=3);
    amb_nurse_to_diag_WORDS_ErrorCount := COUNT(GROUP,h.amb_nurse_to_diag_Invalid=4);
    amb_nurse_to_diag_Total_ErrorCount := COUNT(GROUP,h.amb_nurse_to_diag_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.claim_num_Invalid,le.claim_rec_type_Invalid,le.payer_id_Invalid,le.form_type_Invalid,le.received_date_Invalid,le.claim_type_Invalid,le.adjustment_code_Invalid,le.prev_claim_number_Invalid,le.member_dob_Invalid,le.member_state_Invalid,le.member_zip_Invalid,le.patient_relation_Invalid,le.patient_gender_Invalid,le.patient_dob_Invalid,le.billing_id_Invalid,le.billing_npi_Invalid,le.billing_state_Invalid,le.billing_zip_Invalid,le.referring_id_Invalid,le.referring_npi_Invalid,le.referring_name1_Invalid,le.referring_name2_Invalid,le.attending_id_Invalid,le.attending_npi_Invalid,le.facility_state_Invalid,le.facility_zip_Invalid,le.statement_to_Invalid,le.total_charge_Invalid,le.drg_code_Invalid,le.bill_type_Invalid,le.release_sign_Invalid,le.assignment_sign_Invalid,le.principal_proc_Invalid,le.admit_diag_Invalid,le.primary_diag_Invalid,le.diag_code2_Invalid,le.diag_code3_Invalid,le.diag_code4_Invalid,le.diag_code5_Invalid,le.diag_code6_Invalid,le.diag_code7_Invalid,le.diag_code8_Invalid,le.other_proc_Invalid,le.other_proc3_Invalid,le.other_proc4_Invalid,le.other_proc5_Invalid,le.other_proc6_Invalid,le.coverage_type_Invalid,le.accident_related_Invalid,le.esrd_patient_Invalid,le.hosp_admit_or_er_Invalid,le.amb_nurse_to_hosp_Invalid,le.non_covered_specialty_Invalid,le.electronic_claim_Invalid,le.dialysis_related_Invalid,le.new_patient_Invalid,le.init_proc_Invalid,le.amb_nurse_to_diag_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,CRecord_Fields.InvalidMessage_claim_num(le.claim_num_Invalid),CRecord_Fields.InvalidMessage_claim_rec_type(le.claim_rec_type_Invalid),CRecord_Fields.InvalidMessage_payer_id(le.payer_id_Invalid),CRecord_Fields.InvalidMessage_form_type(le.form_type_Invalid),CRecord_Fields.InvalidMessage_received_date(le.received_date_Invalid),CRecord_Fields.InvalidMessage_claim_type(le.claim_type_Invalid),CRecord_Fields.InvalidMessage_adjustment_code(le.adjustment_code_Invalid),CRecord_Fields.InvalidMessage_prev_claim_number(le.prev_claim_number_Invalid),CRecord_Fields.InvalidMessage_member_dob(le.member_dob_Invalid),CRecord_Fields.InvalidMessage_member_state(le.member_state_Invalid),CRecord_Fields.InvalidMessage_member_zip(le.member_zip_Invalid),CRecord_Fields.InvalidMessage_patient_relation(le.patient_relation_Invalid),CRecord_Fields.InvalidMessage_patient_gender(le.patient_gender_Invalid),CRecord_Fields.InvalidMessage_patient_dob(le.patient_dob_Invalid),CRecord_Fields.InvalidMessage_billing_id(le.billing_id_Invalid),CRecord_Fields.InvalidMessage_billing_npi(le.billing_npi_Invalid),CRecord_Fields.InvalidMessage_billing_state(le.billing_state_Invalid),CRecord_Fields.InvalidMessage_billing_zip(le.billing_zip_Invalid),CRecord_Fields.InvalidMessage_referring_id(le.referring_id_Invalid),CRecord_Fields.InvalidMessage_referring_npi(le.referring_npi_Invalid),CRecord_Fields.InvalidMessage_referring_name1(le.referring_name1_Invalid),CRecord_Fields.InvalidMessage_referring_name2(le.referring_name2_Invalid),CRecord_Fields.InvalidMessage_attending_id(le.attending_id_Invalid),CRecord_Fields.InvalidMessage_attending_npi(le.attending_npi_Invalid),CRecord_Fields.InvalidMessage_facility_state(le.facility_state_Invalid),CRecord_Fields.InvalidMessage_facility_zip(le.facility_zip_Invalid),CRecord_Fields.InvalidMessage_statement_to(le.statement_to_Invalid),CRecord_Fields.InvalidMessage_total_charge(le.total_charge_Invalid),CRecord_Fields.InvalidMessage_drg_code(le.drg_code_Invalid),CRecord_Fields.InvalidMessage_bill_type(le.bill_type_Invalid),CRecord_Fields.InvalidMessage_release_sign(le.release_sign_Invalid),CRecord_Fields.InvalidMessage_assignment_sign(le.assignment_sign_Invalid),CRecord_Fields.InvalidMessage_principal_proc(le.principal_proc_Invalid),CRecord_Fields.InvalidMessage_admit_diag(le.admit_diag_Invalid),CRecord_Fields.InvalidMessage_primary_diag(le.primary_diag_Invalid),CRecord_Fields.InvalidMessage_diag_code2(le.diag_code2_Invalid),CRecord_Fields.InvalidMessage_diag_code3(le.diag_code3_Invalid),CRecord_Fields.InvalidMessage_diag_code4(le.diag_code4_Invalid),CRecord_Fields.InvalidMessage_diag_code5(le.diag_code5_Invalid),CRecord_Fields.InvalidMessage_diag_code6(le.diag_code6_Invalid),CRecord_Fields.InvalidMessage_diag_code7(le.diag_code7_Invalid),CRecord_Fields.InvalidMessage_diag_code8(le.diag_code8_Invalid),CRecord_Fields.InvalidMessage_other_proc(le.other_proc_Invalid),CRecord_Fields.InvalidMessage_other_proc3(le.other_proc3_Invalid),CRecord_Fields.InvalidMessage_other_proc4(le.other_proc4_Invalid),CRecord_Fields.InvalidMessage_other_proc5(le.other_proc5_Invalid),CRecord_Fields.InvalidMessage_other_proc6(le.other_proc6_Invalid),CRecord_Fields.InvalidMessage_coverage_type(le.coverage_type_Invalid),CRecord_Fields.InvalidMessage_accident_related(le.accident_related_Invalid),CRecord_Fields.InvalidMessage_esrd_patient(le.esrd_patient_Invalid),CRecord_Fields.InvalidMessage_hosp_admit_or_er(le.hosp_admit_or_er_Invalid),CRecord_Fields.InvalidMessage_amb_nurse_to_hosp(le.amb_nurse_to_hosp_Invalid),CRecord_Fields.InvalidMessage_non_covered_specialty(le.non_covered_specialty_Invalid),CRecord_Fields.InvalidMessage_electronic_claim(le.electronic_claim_Invalid),CRecord_Fields.InvalidMessage_dialysis_related(le.dialysis_related_Invalid),CRecord_Fields.InvalidMessage_new_patient(le.new_patient_Invalid),CRecord_Fields.InvalidMessage_init_proc(le.init_proc_Invalid),CRecord_Fields.InvalidMessage_amb_nurse_to_diag(le.amb_nurse_to_diag_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.claim_num_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.claim_rec_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.payer_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.form_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.received_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.claim_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.adjustment_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.prev_claim_number_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.member_dob_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.member_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.member_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.patient_relation_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.patient_gender_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.patient_dob_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_npi_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.billing_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.referring_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.referring_npi_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.referring_name1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.referring_name2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.attending_id_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.attending_npi_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.facility_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.facility_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.statement_to_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.total_charge_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.drg_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.bill_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.release_sign_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.assignment_sign_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.principal_proc_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.admit_diag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.primary_diag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code5_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code6_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code7_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code8_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc5_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.other_proc6_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.coverage_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.accident_related_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.esrd_patient_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.hosp_admit_or_er_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.amb_nurse_to_hosp_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.non_covered_specialty_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.electronic_claim_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dialysis_related_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.new_patient_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.init_proc_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.amb_nurse_to_diag_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'claim_num','claim_rec_type','payer_id','form_type','received_date','claim_type','adjustment_code','prev_claim_number','member_dob','member_state','member_zip','patient_relation','patient_gender','patient_dob','billing_id','billing_npi','billing_state','billing_zip','referring_id','referring_npi','referring_name1','referring_name2','attending_id','attending_npi','facility_state','facility_zip','statement_to','total_charge','drg_code','bill_type','release_sign','assignment_sign','principal_proc','admit_diag','primary_diag','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','other_proc','other_proc3','other_proc4','other_proc5','other_proc6','coverage_type','accident_related','esrd_patient','hosp_admit_or_er','amb_nurse_to_hosp','non_covered_specialty','electronic_claim','dialysis_related','new_patient','init_proc','amb_nurse_to_diag','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'claim_num','claim_rec_type','payer_id','form_type','received_date','claim_type','adjustment_code','prev_claim_number','member_dob','member_state','member_zip','patient_relation','patient_gender','patient_dob','billing_id','billing_npi','billing_state','billing_zip','referring_id','referring_npi','referring_name1','referring_name2','attending_id','attending_npi','facility_state','facility_zip','statement_to','total_charge','drg_code','bill_type','release_sign','assignment_sign','principal_proc','admit_diag','primary_diag','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','other_proc','other_proc3','other_proc4','other_proc5','other_proc6','coverage_type','accident_related','esrd_patient','hosp_admit_or_er','amb_nurse_to_hosp','non_covered_specialty','electronic_claim','dialysis_related','new_patient','init_proc','amb_nurse_to_diag','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.claim_num,(SALT31.StrType)le.claim_rec_type,(SALT31.StrType)le.payer_id,(SALT31.StrType)le.form_type,(SALT31.StrType)le.received_date,(SALT31.StrType)le.claim_type,(SALT31.StrType)le.adjustment_code,(SALT31.StrType)le.prev_claim_number,(SALT31.StrType)le.member_dob,(SALT31.StrType)le.member_state,(SALT31.StrType)le.member_zip,(SALT31.StrType)le.patient_relation,(SALT31.StrType)le.patient_gender,(SALT31.StrType)le.patient_dob,(SALT31.StrType)le.billing_id,(SALT31.StrType)le.billing_npi,(SALT31.StrType)le.billing_state,(SALT31.StrType)le.billing_zip,(SALT31.StrType)le.referring_id,(SALT31.StrType)le.referring_npi,(SALT31.StrType)le.referring_name1,(SALT31.StrType)le.referring_name2,(SALT31.StrType)le.attending_id,(SALT31.StrType)le.attending_npi,(SALT31.StrType)le.facility_state,(SALT31.StrType)le.facility_zip,(SALT31.StrType)le.statement_to,(SALT31.StrType)le.total_charge,(SALT31.StrType)le.drg_code,(SALT31.StrType)le.bill_type,(SALT31.StrType)le.release_sign,(SALT31.StrType)le.assignment_sign,(SALT31.StrType)le.principal_proc,(SALT31.StrType)le.admit_diag,(SALT31.StrType)le.primary_diag,(SALT31.StrType)le.diag_code2,(SALT31.StrType)le.diag_code3,(SALT31.StrType)le.diag_code4,(SALT31.StrType)le.diag_code5,(SALT31.StrType)le.diag_code6,(SALT31.StrType)le.diag_code7,(SALT31.StrType)le.diag_code8,(SALT31.StrType)le.other_proc,(SALT31.StrType)le.other_proc3,(SALT31.StrType)le.other_proc4,(SALT31.StrType)le.other_proc5,(SALT31.StrType)le.other_proc6,(SALT31.StrType)le.coverage_type,(SALT31.StrType)le.accident_related,(SALT31.StrType)le.esrd_patient,(SALT31.StrType)le.hosp_admit_or_er,(SALT31.StrType)le.amb_nurse_to_hosp,(SALT31.StrType)le.non_covered_specialty,(SALT31.StrType)le.electronic_claim,(SALT31.StrType)le.dialysis_related,(SALT31.StrType)le.new_patient,(SALT31.StrType)le.init_proc,(SALT31.StrType)le.amb_nurse_to_diag,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,58,Into(LEFT,COUNTER));
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
          ,'payer_id:payer_id:LEFTTRIM','payer_id:payer_id:ALLOW','payer_id:payer_id:LENGTH','payer_id:payer_id:WORDS'
          ,'form_type:form_type:LEFTTRIM','form_type:form_type:ALLOW','form_type:form_type:LENGTH','form_type:form_type:WORDS'
          ,'received_date:received_date:LEFTTRIM','received_date:received_date:ALLOW','received_date:received_date:LENGTH','received_date:received_date:WORDS'
          ,'claim_type:claim_type:LEFTTRIM','claim_type:claim_type:ALLOW','claim_type:claim_type:LENGTH','claim_type:claim_type:WORDS'
          ,'adjustment_code:adjustment_code:LEFTTRIM','adjustment_code:adjustment_code:ALLOW','adjustment_code:adjustment_code:LENGTH','adjustment_code:adjustment_code:WORDS'
          ,'prev_claim_number:prev_claim_number:LEFTTRIM','prev_claim_number:prev_claim_number:ALLOW'
          ,'member_dob:member_dob:LEFTTRIM','member_dob:member_dob:ALLOW','member_dob:member_dob:LENGTH','member_dob:member_dob:WORDS'
          ,'member_state:member_state:LEFTTRIM','member_state:member_state:ALLOW','member_state:member_state:LENGTH','member_state:member_state:WORDS'
          ,'member_zip:member_zip:LEFTTRIM','member_zip:member_zip:ALLOW','member_zip:member_zip:LENGTH','member_zip:member_zip:WORDS'
          ,'patient_relation:patient_relation:LEFTTRIM','patient_relation:patient_relation:ALLOW','patient_relation:patient_relation:LENGTH','patient_relation:patient_relation:WORDS'
          ,'patient_gender:patient_gender:LEFTTRIM','patient_gender:patient_gender:ALLOW','patient_gender:patient_gender:LENGTH','patient_gender:patient_gender:WORDS'
          ,'patient_dob:patient_dob:LEFTTRIM','patient_dob:patient_dob:ALLOW','patient_dob:patient_dob:LENGTH','patient_dob:patient_dob:WORDS'
          ,'billing_id:billing_id:LEFTTRIM','billing_id:billing_id:ALLOW','billing_id:billing_id:LENGTH','billing_id:billing_id:WORDS'
          ,'billing_npi:billing_npi:LEFTTRIM','billing_npi:billing_npi:ALLOW','billing_npi:billing_npi:LENGTH','billing_npi:billing_npi:WORDS'
          ,'billing_state:billing_state:LEFTTRIM','billing_state:billing_state:ALLOW','billing_state:billing_state:LENGTH','billing_state:billing_state:WORDS'
          ,'billing_zip:billing_zip:LEFTTRIM','billing_zip:billing_zip:ALLOW','billing_zip:billing_zip:LENGTH','billing_zip:billing_zip:WORDS'
          ,'referring_id:referring_id:LEFTTRIM','referring_id:referring_id:ALLOW','referring_id:referring_id:LENGTH','referring_id:referring_id:WORDS'
          ,'referring_npi:referring_npi:LEFTTRIM','referring_npi:referring_npi:ALLOW','referring_npi:referring_npi:LENGTH','referring_npi:referring_npi:WORDS'
          ,'referring_name1:referring_name1:LEFTTRIM','referring_name1:referring_name1:ALLOW','referring_name1:referring_name1:LENGTH','referring_name1:referring_name1:WORDS'
          ,'referring_name2:referring_name2:LEFTTRIM','referring_name2:referring_name2:ALLOW'
          ,'attending_id:attending_id:LEFTTRIM','attending_id:attending_id:ALLOW','attending_id:attending_id:WORDS'
          ,'attending_npi:attending_npi:LEFTTRIM','attending_npi:attending_npi:ALLOW','attending_npi:attending_npi:LENGTH','attending_npi:attending_npi:WORDS'
          ,'facility_state:facility_state:LEFTTRIM','facility_state:facility_state:ALLOW','facility_state:facility_state:LENGTH','facility_state:facility_state:WORDS'
          ,'facility_zip:facility_zip:LEFTTRIM','facility_zip:facility_zip:ALLOW','facility_zip:facility_zip:LENGTH','facility_zip:facility_zip:WORDS'
          ,'statement_to:statement_to:LEFTTRIM','statement_to:statement_to:ALLOW','statement_to:statement_to:WORDS'
          ,'total_charge:total_charge:LEFTTRIM','total_charge:total_charge:ALLOW','total_charge:total_charge:WORDS'
          ,'drg_code:drg_code:LEFTTRIM','drg_code:drg_code:ALLOW','drg_code:drg_code:LENGTH','drg_code:drg_code:WORDS'
          ,'bill_type:bill_type:LEFTTRIM','bill_type:bill_type:ALLOW','bill_type:bill_type:LENGTH','bill_type:bill_type:WORDS'
          ,'release_sign:release_sign:LEFTTRIM','release_sign:release_sign:ALLOW','release_sign:release_sign:LENGTH','release_sign:release_sign:WORDS'
          ,'assignment_sign:assignment_sign:LEFTTRIM','assignment_sign:assignment_sign:ALLOW','assignment_sign:assignment_sign:LENGTH','assignment_sign:assignment_sign:WORDS'
          ,'principal_proc:principal_proc:LEFTTRIM','principal_proc:principal_proc:ALLOW','principal_proc:principal_proc:LENGTH','principal_proc:principal_proc:WORDS'
          ,'admit_diag:admit_diag:LEFTTRIM','admit_diag:admit_diag:ALLOW','admit_diag:admit_diag:LENGTH','admit_diag:admit_diag:WORDS'
          ,'primary_diag:primary_diag:LEFTTRIM','primary_diag:primary_diag:ALLOW','primary_diag:primary_diag:LENGTH','primary_diag:primary_diag:WORDS'
          ,'diag_code2:diag_code2:LEFTTRIM','diag_code2:diag_code2:ALLOW','diag_code2:diag_code2:LENGTH','diag_code2:diag_code2:WORDS'
          ,'diag_code3:diag_code3:LEFTTRIM','diag_code3:diag_code3:ALLOW','diag_code3:diag_code3:LENGTH','diag_code3:diag_code3:WORDS'
          ,'diag_code4:diag_code4:LEFTTRIM','diag_code4:diag_code4:ALLOW','diag_code4:diag_code4:LENGTH','diag_code4:diag_code4:WORDS'
          ,'diag_code5:diag_code5:LEFTTRIM','diag_code5:diag_code5:ALLOW','diag_code5:diag_code5:LENGTH','diag_code5:diag_code5:WORDS'
          ,'diag_code6:diag_code6:LEFTTRIM','diag_code6:diag_code6:ALLOW','diag_code6:diag_code6:LENGTH','diag_code6:diag_code6:WORDS'
          ,'diag_code7:diag_code7:LEFTTRIM','diag_code7:diag_code7:ALLOW','diag_code7:diag_code7:LENGTH','diag_code7:diag_code7:WORDS'
          ,'diag_code8:diag_code8:LEFTTRIM','diag_code8:diag_code8:ALLOW','diag_code8:diag_code8:LENGTH','diag_code8:diag_code8:WORDS'
          ,'other_proc:other_proc:LEFTTRIM','other_proc:other_proc:ALLOW','other_proc:other_proc:LENGTH','other_proc:other_proc:WORDS'
          ,'other_proc3:other_proc3:LEFTTRIM','other_proc3:other_proc3:ALLOW','other_proc3:other_proc3:LENGTH','other_proc3:other_proc3:WORDS'
          ,'other_proc4:other_proc4:LEFTTRIM','other_proc4:other_proc4:ALLOW','other_proc4:other_proc4:LENGTH','other_proc4:other_proc4:WORDS'
          ,'other_proc5:other_proc5:LEFTTRIM','other_proc5:other_proc5:ALLOW','other_proc5:other_proc5:LENGTH','other_proc5:other_proc5:WORDS'
          ,'other_proc6:other_proc6:LEFTTRIM','other_proc6:other_proc6:ALLOW','other_proc6:other_proc6:LENGTH','other_proc6:other_proc6:WORDS'
          ,'coverage_type:coverage_type:LEFTTRIM','coverage_type:coverage_type:ALLOW','coverage_type:coverage_type:LENGTH','coverage_type:coverage_type:WORDS'
          ,'accident_related:accident_related:LEFTTRIM','accident_related:accident_related:ALLOW','accident_related:accident_related:LENGTH','accident_related:accident_related:WORDS'
          ,'esrd_patient:esrd_patient:LEFTTRIM','esrd_patient:esrd_patient:ALLOW','esrd_patient:esrd_patient:LENGTH','esrd_patient:esrd_patient:WORDS'
          ,'hosp_admit_or_er:hosp_admit_or_er:LEFTTRIM','hosp_admit_or_er:hosp_admit_or_er:ALLOW','hosp_admit_or_er:hosp_admit_or_er:LENGTH','hosp_admit_or_er:hosp_admit_or_er:WORDS'
          ,'amb_nurse_to_hosp:amb_nurse_to_hosp:LEFTTRIM','amb_nurse_to_hosp:amb_nurse_to_hosp:ALLOW','amb_nurse_to_hosp:amb_nurse_to_hosp:LENGTH','amb_nurse_to_hosp:amb_nurse_to_hosp:WORDS'
          ,'non_covered_specialty:non_covered_specialty:LEFTTRIM','non_covered_specialty:non_covered_specialty:ALLOW','non_covered_specialty:non_covered_specialty:LENGTH','non_covered_specialty:non_covered_specialty:WORDS'
          ,'electronic_claim:electronic_claim:LEFTTRIM','electronic_claim:electronic_claim:ALLOW','electronic_claim:electronic_claim:LENGTH','electronic_claim:electronic_claim:WORDS'
          ,'dialysis_related:dialysis_related:LEFTTRIM','dialysis_related:dialysis_related:ALLOW','dialysis_related:dialysis_related:LENGTH','dialysis_related:dialysis_related:WORDS'
          ,'new_patient:new_patient:LEFTTRIM','new_patient:new_patient:ALLOW','new_patient:new_patient:LENGTH','new_patient:new_patient:WORDS'
          ,'init_proc:init_proc:LEFTTRIM','init_proc:init_proc:ALLOW','init_proc:init_proc:LENGTH','init_proc:init_proc:WORDS'
          ,'amb_nurse_to_diag:amb_nurse_to_diag:LEFTTRIM','amb_nurse_to_diag:amb_nurse_to_diag:ALLOW','amb_nurse_to_diag:amb_nurse_to_diag:LENGTH','amb_nurse_to_diag:amb_nurse_to_diag:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,CRecord_Fields.InvalidMessage_claim_num(1),CRecord_Fields.InvalidMessage_claim_num(2),CRecord_Fields.InvalidMessage_claim_num(3),CRecord_Fields.InvalidMessage_claim_num(4)
          ,CRecord_Fields.InvalidMessage_claim_rec_type(1),CRecord_Fields.InvalidMessage_claim_rec_type(2),CRecord_Fields.InvalidMessage_claim_rec_type(3),CRecord_Fields.InvalidMessage_claim_rec_type(4)
          ,CRecord_Fields.InvalidMessage_payer_id(1),CRecord_Fields.InvalidMessage_payer_id(2),CRecord_Fields.InvalidMessage_payer_id(3),CRecord_Fields.InvalidMessage_payer_id(4)
          ,CRecord_Fields.InvalidMessage_form_type(1),CRecord_Fields.InvalidMessage_form_type(2),CRecord_Fields.InvalidMessage_form_type(3),CRecord_Fields.InvalidMessage_form_type(4)
          ,CRecord_Fields.InvalidMessage_received_date(1),CRecord_Fields.InvalidMessage_received_date(2),CRecord_Fields.InvalidMessage_received_date(3),CRecord_Fields.InvalidMessage_received_date(4)
          ,CRecord_Fields.InvalidMessage_claim_type(1),CRecord_Fields.InvalidMessage_claim_type(2),CRecord_Fields.InvalidMessage_claim_type(3),CRecord_Fields.InvalidMessage_claim_type(4)
          ,CRecord_Fields.InvalidMessage_adjustment_code(1),CRecord_Fields.InvalidMessage_adjustment_code(2),CRecord_Fields.InvalidMessage_adjustment_code(3),CRecord_Fields.InvalidMessage_adjustment_code(4)
          ,CRecord_Fields.InvalidMessage_prev_claim_number(1),CRecord_Fields.InvalidMessage_prev_claim_number(2)
          ,CRecord_Fields.InvalidMessage_member_dob(1),CRecord_Fields.InvalidMessage_member_dob(2),CRecord_Fields.InvalidMessage_member_dob(3),CRecord_Fields.InvalidMessage_member_dob(4)
          ,CRecord_Fields.InvalidMessage_member_state(1),CRecord_Fields.InvalidMessage_member_state(2),CRecord_Fields.InvalidMessage_member_state(3),CRecord_Fields.InvalidMessage_member_state(4)
          ,CRecord_Fields.InvalidMessage_member_zip(1),CRecord_Fields.InvalidMessage_member_zip(2),CRecord_Fields.InvalidMessage_member_zip(3),CRecord_Fields.InvalidMessage_member_zip(4)
          ,CRecord_Fields.InvalidMessage_patient_relation(1),CRecord_Fields.InvalidMessage_patient_relation(2),CRecord_Fields.InvalidMessage_patient_relation(3),CRecord_Fields.InvalidMessage_patient_relation(4)
          ,CRecord_Fields.InvalidMessage_patient_gender(1),CRecord_Fields.InvalidMessage_patient_gender(2),CRecord_Fields.InvalidMessage_patient_gender(3),CRecord_Fields.InvalidMessage_patient_gender(4)
          ,CRecord_Fields.InvalidMessage_patient_dob(1),CRecord_Fields.InvalidMessage_patient_dob(2),CRecord_Fields.InvalidMessage_patient_dob(3),CRecord_Fields.InvalidMessage_patient_dob(4)
          ,CRecord_Fields.InvalidMessage_billing_id(1),CRecord_Fields.InvalidMessage_billing_id(2),CRecord_Fields.InvalidMessage_billing_id(3),CRecord_Fields.InvalidMessage_billing_id(4)
          ,CRecord_Fields.InvalidMessage_billing_npi(1),CRecord_Fields.InvalidMessage_billing_npi(2),CRecord_Fields.InvalidMessage_billing_npi(3),CRecord_Fields.InvalidMessage_billing_npi(4)
          ,CRecord_Fields.InvalidMessage_billing_state(1),CRecord_Fields.InvalidMessage_billing_state(2),CRecord_Fields.InvalidMessage_billing_state(3),CRecord_Fields.InvalidMessage_billing_state(4)
          ,CRecord_Fields.InvalidMessage_billing_zip(1),CRecord_Fields.InvalidMessage_billing_zip(2),CRecord_Fields.InvalidMessage_billing_zip(3),CRecord_Fields.InvalidMessage_billing_zip(4)
          ,CRecord_Fields.InvalidMessage_referring_id(1),CRecord_Fields.InvalidMessage_referring_id(2),CRecord_Fields.InvalidMessage_referring_id(3),CRecord_Fields.InvalidMessage_referring_id(4)
          ,CRecord_Fields.InvalidMessage_referring_npi(1),CRecord_Fields.InvalidMessage_referring_npi(2),CRecord_Fields.InvalidMessage_referring_npi(3),CRecord_Fields.InvalidMessage_referring_npi(4)
          ,CRecord_Fields.InvalidMessage_referring_name1(1),CRecord_Fields.InvalidMessage_referring_name1(2),CRecord_Fields.InvalidMessage_referring_name1(3),CRecord_Fields.InvalidMessage_referring_name1(4)
          ,CRecord_Fields.InvalidMessage_referring_name2(1),CRecord_Fields.InvalidMessage_referring_name2(2)
          ,CRecord_Fields.InvalidMessage_attending_id(1),CRecord_Fields.InvalidMessage_attending_id(2),CRecord_Fields.InvalidMessage_attending_id(3)
          ,CRecord_Fields.InvalidMessage_attending_npi(1),CRecord_Fields.InvalidMessage_attending_npi(2),CRecord_Fields.InvalidMessage_attending_npi(3),CRecord_Fields.InvalidMessage_attending_npi(4)
          ,CRecord_Fields.InvalidMessage_facility_state(1),CRecord_Fields.InvalidMessage_facility_state(2),CRecord_Fields.InvalidMessage_facility_state(3),CRecord_Fields.InvalidMessage_facility_state(4)
          ,CRecord_Fields.InvalidMessage_facility_zip(1),CRecord_Fields.InvalidMessage_facility_zip(2),CRecord_Fields.InvalidMessage_facility_zip(3),CRecord_Fields.InvalidMessage_facility_zip(4)
          ,CRecord_Fields.InvalidMessage_statement_to(1),CRecord_Fields.InvalidMessage_statement_to(2),CRecord_Fields.InvalidMessage_statement_to(3)
          ,CRecord_Fields.InvalidMessage_total_charge(1),CRecord_Fields.InvalidMessage_total_charge(2),CRecord_Fields.InvalidMessage_total_charge(3)
          ,CRecord_Fields.InvalidMessage_drg_code(1),CRecord_Fields.InvalidMessage_drg_code(2),CRecord_Fields.InvalidMessage_drg_code(3),CRecord_Fields.InvalidMessage_drg_code(4)
          ,CRecord_Fields.InvalidMessage_bill_type(1),CRecord_Fields.InvalidMessage_bill_type(2),CRecord_Fields.InvalidMessage_bill_type(3),CRecord_Fields.InvalidMessage_bill_type(4)
          ,CRecord_Fields.InvalidMessage_release_sign(1),CRecord_Fields.InvalidMessage_release_sign(2),CRecord_Fields.InvalidMessage_release_sign(3),CRecord_Fields.InvalidMessage_release_sign(4)
          ,CRecord_Fields.InvalidMessage_assignment_sign(1),CRecord_Fields.InvalidMessage_assignment_sign(2),CRecord_Fields.InvalidMessage_assignment_sign(3),CRecord_Fields.InvalidMessage_assignment_sign(4)
          ,CRecord_Fields.InvalidMessage_principal_proc(1),CRecord_Fields.InvalidMessage_principal_proc(2),CRecord_Fields.InvalidMessage_principal_proc(3),CRecord_Fields.InvalidMessage_principal_proc(4)
          ,CRecord_Fields.InvalidMessage_admit_diag(1),CRecord_Fields.InvalidMessage_admit_diag(2),CRecord_Fields.InvalidMessage_admit_diag(3),CRecord_Fields.InvalidMessage_admit_diag(4)
          ,CRecord_Fields.InvalidMessage_primary_diag(1),CRecord_Fields.InvalidMessage_primary_diag(2),CRecord_Fields.InvalidMessage_primary_diag(3),CRecord_Fields.InvalidMessage_primary_diag(4)
          ,CRecord_Fields.InvalidMessage_diag_code2(1),CRecord_Fields.InvalidMessage_diag_code2(2),CRecord_Fields.InvalidMessage_diag_code2(3),CRecord_Fields.InvalidMessage_diag_code2(4)
          ,CRecord_Fields.InvalidMessage_diag_code3(1),CRecord_Fields.InvalidMessage_diag_code3(2),CRecord_Fields.InvalidMessage_diag_code3(3),CRecord_Fields.InvalidMessage_diag_code3(4)
          ,CRecord_Fields.InvalidMessage_diag_code4(1),CRecord_Fields.InvalidMessage_diag_code4(2),CRecord_Fields.InvalidMessage_diag_code4(3),CRecord_Fields.InvalidMessage_diag_code4(4)
          ,CRecord_Fields.InvalidMessage_diag_code5(1),CRecord_Fields.InvalidMessage_diag_code5(2),CRecord_Fields.InvalidMessage_diag_code5(3),CRecord_Fields.InvalidMessage_diag_code5(4)
          ,CRecord_Fields.InvalidMessage_diag_code6(1),CRecord_Fields.InvalidMessage_diag_code6(2),CRecord_Fields.InvalidMessage_diag_code6(3),CRecord_Fields.InvalidMessage_diag_code6(4)
          ,CRecord_Fields.InvalidMessage_diag_code7(1),CRecord_Fields.InvalidMessage_diag_code7(2),CRecord_Fields.InvalidMessage_diag_code7(3),CRecord_Fields.InvalidMessage_diag_code7(4)
          ,CRecord_Fields.InvalidMessage_diag_code8(1),CRecord_Fields.InvalidMessage_diag_code8(2),CRecord_Fields.InvalidMessage_diag_code8(3),CRecord_Fields.InvalidMessage_diag_code8(4)
          ,CRecord_Fields.InvalidMessage_other_proc(1),CRecord_Fields.InvalidMessage_other_proc(2),CRecord_Fields.InvalidMessage_other_proc(3),CRecord_Fields.InvalidMessage_other_proc(4)
          ,CRecord_Fields.InvalidMessage_other_proc3(1),CRecord_Fields.InvalidMessage_other_proc3(2),CRecord_Fields.InvalidMessage_other_proc3(3),CRecord_Fields.InvalidMessage_other_proc3(4)
          ,CRecord_Fields.InvalidMessage_other_proc4(1),CRecord_Fields.InvalidMessage_other_proc4(2),CRecord_Fields.InvalidMessage_other_proc4(3),CRecord_Fields.InvalidMessage_other_proc4(4)
          ,CRecord_Fields.InvalidMessage_other_proc5(1),CRecord_Fields.InvalidMessage_other_proc5(2),CRecord_Fields.InvalidMessage_other_proc5(3),CRecord_Fields.InvalidMessage_other_proc5(4)
          ,CRecord_Fields.InvalidMessage_other_proc6(1),CRecord_Fields.InvalidMessage_other_proc6(2),CRecord_Fields.InvalidMessage_other_proc6(3),CRecord_Fields.InvalidMessage_other_proc6(4)
          ,CRecord_Fields.InvalidMessage_coverage_type(1),CRecord_Fields.InvalidMessage_coverage_type(2),CRecord_Fields.InvalidMessage_coverage_type(3),CRecord_Fields.InvalidMessage_coverage_type(4)
          ,CRecord_Fields.InvalidMessage_accident_related(1),CRecord_Fields.InvalidMessage_accident_related(2),CRecord_Fields.InvalidMessage_accident_related(3),CRecord_Fields.InvalidMessage_accident_related(4)
          ,CRecord_Fields.InvalidMessage_esrd_patient(1),CRecord_Fields.InvalidMessage_esrd_patient(2),CRecord_Fields.InvalidMessage_esrd_patient(3),CRecord_Fields.InvalidMessage_esrd_patient(4)
          ,CRecord_Fields.InvalidMessage_hosp_admit_or_er(1),CRecord_Fields.InvalidMessage_hosp_admit_or_er(2),CRecord_Fields.InvalidMessage_hosp_admit_or_er(3),CRecord_Fields.InvalidMessage_hosp_admit_or_er(4)
          ,CRecord_Fields.InvalidMessage_amb_nurse_to_hosp(1),CRecord_Fields.InvalidMessage_amb_nurse_to_hosp(2),CRecord_Fields.InvalidMessage_amb_nurse_to_hosp(3),CRecord_Fields.InvalidMessage_amb_nurse_to_hosp(4)
          ,CRecord_Fields.InvalidMessage_non_covered_specialty(1),CRecord_Fields.InvalidMessage_non_covered_specialty(2),CRecord_Fields.InvalidMessage_non_covered_specialty(3),CRecord_Fields.InvalidMessage_non_covered_specialty(4)
          ,CRecord_Fields.InvalidMessage_electronic_claim(1),CRecord_Fields.InvalidMessage_electronic_claim(2),CRecord_Fields.InvalidMessage_electronic_claim(3),CRecord_Fields.InvalidMessage_electronic_claim(4)
          ,CRecord_Fields.InvalidMessage_dialysis_related(1),CRecord_Fields.InvalidMessage_dialysis_related(2),CRecord_Fields.InvalidMessage_dialysis_related(3),CRecord_Fields.InvalidMessage_dialysis_related(4)
          ,CRecord_Fields.InvalidMessage_new_patient(1),CRecord_Fields.InvalidMessage_new_patient(2),CRecord_Fields.InvalidMessage_new_patient(3),CRecord_Fields.InvalidMessage_new_patient(4)
          ,CRecord_Fields.InvalidMessage_init_proc(1),CRecord_Fields.InvalidMessage_init_proc(2),CRecord_Fields.InvalidMessage_init_proc(3),CRecord_Fields.InvalidMessage_init_proc(4)
          ,CRecord_Fields.InvalidMessage_amb_nurse_to_diag(1),CRecord_Fields.InvalidMessage_amb_nurse_to_diag(2),CRecord_Fields.InvalidMessage_amb_nurse_to_diag(3),CRecord_Fields.InvalidMessage_amb_nurse_to_diag(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.claim_num_LEFTTRIM_ErrorCount,le.claim_num_ALLOW_ErrorCount,le.claim_num_LENGTH_ErrorCount,le.claim_num_WORDS_ErrorCount
          ,le.claim_rec_type_LEFTTRIM_ErrorCount,le.claim_rec_type_ALLOW_ErrorCount,le.claim_rec_type_LENGTH_ErrorCount,le.claim_rec_type_WORDS_ErrorCount
          ,le.payer_id_LEFTTRIM_ErrorCount,le.payer_id_ALLOW_ErrorCount,le.payer_id_LENGTH_ErrorCount,le.payer_id_WORDS_ErrorCount
          ,le.form_type_LEFTTRIM_ErrorCount,le.form_type_ALLOW_ErrorCount,le.form_type_LENGTH_ErrorCount,le.form_type_WORDS_ErrorCount
          ,le.received_date_LEFTTRIM_ErrorCount,le.received_date_ALLOW_ErrorCount,le.received_date_LENGTH_ErrorCount,le.received_date_WORDS_ErrorCount
          ,le.claim_type_LEFTTRIM_ErrorCount,le.claim_type_ALLOW_ErrorCount,le.claim_type_LENGTH_ErrorCount,le.claim_type_WORDS_ErrorCount
          ,le.adjustment_code_LEFTTRIM_ErrorCount,le.adjustment_code_ALLOW_ErrorCount,le.adjustment_code_LENGTH_ErrorCount,le.adjustment_code_WORDS_ErrorCount
          ,le.prev_claim_number_LEFTTRIM_ErrorCount,le.prev_claim_number_ALLOW_ErrorCount
          ,le.member_dob_LEFTTRIM_ErrorCount,le.member_dob_ALLOW_ErrorCount,le.member_dob_LENGTH_ErrorCount,le.member_dob_WORDS_ErrorCount
          ,le.member_state_LEFTTRIM_ErrorCount,le.member_state_ALLOW_ErrorCount,le.member_state_LENGTH_ErrorCount,le.member_state_WORDS_ErrorCount
          ,le.member_zip_LEFTTRIM_ErrorCount,le.member_zip_ALLOW_ErrorCount,le.member_zip_LENGTH_ErrorCount,le.member_zip_WORDS_ErrorCount
          ,le.patient_relation_LEFTTRIM_ErrorCount,le.patient_relation_ALLOW_ErrorCount,le.patient_relation_LENGTH_ErrorCount,le.patient_relation_WORDS_ErrorCount
          ,le.patient_gender_LEFTTRIM_ErrorCount,le.patient_gender_ALLOW_ErrorCount,le.patient_gender_LENGTH_ErrorCount,le.patient_gender_WORDS_ErrorCount
          ,le.patient_dob_LEFTTRIM_ErrorCount,le.patient_dob_ALLOW_ErrorCount,le.patient_dob_LENGTH_ErrorCount,le.patient_dob_WORDS_ErrorCount
          ,le.billing_id_LEFTTRIM_ErrorCount,le.billing_id_ALLOW_ErrorCount,le.billing_id_LENGTH_ErrorCount,le.billing_id_WORDS_ErrorCount
          ,le.billing_npi_LEFTTRIM_ErrorCount,le.billing_npi_ALLOW_ErrorCount,le.billing_npi_LENGTH_ErrorCount,le.billing_npi_WORDS_ErrorCount
          ,le.billing_state_LEFTTRIM_ErrorCount,le.billing_state_ALLOW_ErrorCount,le.billing_state_LENGTH_ErrorCount,le.billing_state_WORDS_ErrorCount
          ,le.billing_zip_LEFTTRIM_ErrorCount,le.billing_zip_ALLOW_ErrorCount,le.billing_zip_LENGTH_ErrorCount,le.billing_zip_WORDS_ErrorCount
          ,le.referring_id_LEFTTRIM_ErrorCount,le.referring_id_ALLOW_ErrorCount,le.referring_id_LENGTH_ErrorCount,le.referring_id_WORDS_ErrorCount
          ,le.referring_npi_LEFTTRIM_ErrorCount,le.referring_npi_ALLOW_ErrorCount,le.referring_npi_LENGTH_ErrorCount,le.referring_npi_WORDS_ErrorCount
          ,le.referring_name1_LEFTTRIM_ErrorCount,le.referring_name1_ALLOW_ErrorCount,le.referring_name1_LENGTH_ErrorCount,le.referring_name1_WORDS_ErrorCount
          ,le.referring_name2_LEFTTRIM_ErrorCount,le.referring_name2_ALLOW_ErrorCount
          ,le.attending_id_LEFTTRIM_ErrorCount,le.attending_id_ALLOW_ErrorCount,le.attending_id_WORDS_ErrorCount
          ,le.attending_npi_LEFTTRIM_ErrorCount,le.attending_npi_ALLOW_ErrorCount,le.attending_npi_LENGTH_ErrorCount,le.attending_npi_WORDS_ErrorCount
          ,le.facility_state_LEFTTRIM_ErrorCount,le.facility_state_ALLOW_ErrorCount,le.facility_state_LENGTH_ErrorCount,le.facility_state_WORDS_ErrorCount
          ,le.facility_zip_LEFTTRIM_ErrorCount,le.facility_zip_ALLOW_ErrorCount,le.facility_zip_LENGTH_ErrorCount,le.facility_zip_WORDS_ErrorCount
          ,le.statement_to_LEFTTRIM_ErrorCount,le.statement_to_ALLOW_ErrorCount,le.statement_to_WORDS_ErrorCount
          ,le.total_charge_LEFTTRIM_ErrorCount,le.total_charge_ALLOW_ErrorCount,le.total_charge_WORDS_ErrorCount
          ,le.drg_code_LEFTTRIM_ErrorCount,le.drg_code_ALLOW_ErrorCount,le.drg_code_LENGTH_ErrorCount,le.drg_code_WORDS_ErrorCount
          ,le.bill_type_LEFTTRIM_ErrorCount,le.bill_type_ALLOW_ErrorCount,le.bill_type_LENGTH_ErrorCount,le.bill_type_WORDS_ErrorCount
          ,le.release_sign_LEFTTRIM_ErrorCount,le.release_sign_ALLOW_ErrorCount,le.release_sign_LENGTH_ErrorCount,le.release_sign_WORDS_ErrorCount
          ,le.assignment_sign_LEFTTRIM_ErrorCount,le.assignment_sign_ALLOW_ErrorCount,le.assignment_sign_LENGTH_ErrorCount,le.assignment_sign_WORDS_ErrorCount
          ,le.principal_proc_LEFTTRIM_ErrorCount,le.principal_proc_ALLOW_ErrorCount,le.principal_proc_LENGTH_ErrorCount,le.principal_proc_WORDS_ErrorCount
          ,le.admit_diag_LEFTTRIM_ErrorCount,le.admit_diag_ALLOW_ErrorCount,le.admit_diag_LENGTH_ErrorCount,le.admit_diag_WORDS_ErrorCount
          ,le.primary_diag_LEFTTRIM_ErrorCount,le.primary_diag_ALLOW_ErrorCount,le.primary_diag_LENGTH_ErrorCount,le.primary_diag_WORDS_ErrorCount
          ,le.diag_code2_LEFTTRIM_ErrorCount,le.diag_code2_ALLOW_ErrorCount,le.diag_code2_LENGTH_ErrorCount,le.diag_code2_WORDS_ErrorCount
          ,le.diag_code3_LEFTTRIM_ErrorCount,le.diag_code3_ALLOW_ErrorCount,le.diag_code3_LENGTH_ErrorCount,le.diag_code3_WORDS_ErrorCount
          ,le.diag_code4_LEFTTRIM_ErrorCount,le.diag_code4_ALLOW_ErrorCount,le.diag_code4_LENGTH_ErrorCount,le.diag_code4_WORDS_ErrorCount
          ,le.diag_code5_LEFTTRIM_ErrorCount,le.diag_code5_ALLOW_ErrorCount,le.diag_code5_LENGTH_ErrorCount,le.diag_code5_WORDS_ErrorCount
          ,le.diag_code6_LEFTTRIM_ErrorCount,le.diag_code6_ALLOW_ErrorCount,le.diag_code6_LENGTH_ErrorCount,le.diag_code6_WORDS_ErrorCount
          ,le.diag_code7_LEFTTRIM_ErrorCount,le.diag_code7_ALLOW_ErrorCount,le.diag_code7_LENGTH_ErrorCount,le.diag_code7_WORDS_ErrorCount
          ,le.diag_code8_LEFTTRIM_ErrorCount,le.diag_code8_ALLOW_ErrorCount,le.diag_code8_LENGTH_ErrorCount,le.diag_code8_WORDS_ErrorCount
          ,le.other_proc_LEFTTRIM_ErrorCount,le.other_proc_ALLOW_ErrorCount,le.other_proc_LENGTH_ErrorCount,le.other_proc_WORDS_ErrorCount
          ,le.other_proc3_LEFTTRIM_ErrorCount,le.other_proc3_ALLOW_ErrorCount,le.other_proc3_LENGTH_ErrorCount,le.other_proc3_WORDS_ErrorCount
          ,le.other_proc4_LEFTTRIM_ErrorCount,le.other_proc4_ALLOW_ErrorCount,le.other_proc4_LENGTH_ErrorCount,le.other_proc4_WORDS_ErrorCount
          ,le.other_proc5_LEFTTRIM_ErrorCount,le.other_proc5_ALLOW_ErrorCount,le.other_proc5_LENGTH_ErrorCount,le.other_proc5_WORDS_ErrorCount
          ,le.other_proc6_LEFTTRIM_ErrorCount,le.other_proc6_ALLOW_ErrorCount,le.other_proc6_LENGTH_ErrorCount,le.other_proc6_WORDS_ErrorCount
          ,le.coverage_type_LEFTTRIM_ErrorCount,le.coverage_type_ALLOW_ErrorCount,le.coverage_type_LENGTH_ErrorCount,le.coverage_type_WORDS_ErrorCount
          ,le.accident_related_LEFTTRIM_ErrorCount,le.accident_related_ALLOW_ErrorCount,le.accident_related_LENGTH_ErrorCount,le.accident_related_WORDS_ErrorCount
          ,le.esrd_patient_LEFTTRIM_ErrorCount,le.esrd_patient_ALLOW_ErrorCount,le.esrd_patient_LENGTH_ErrorCount,le.esrd_patient_WORDS_ErrorCount
          ,le.hosp_admit_or_er_LEFTTRIM_ErrorCount,le.hosp_admit_or_er_ALLOW_ErrorCount,le.hosp_admit_or_er_LENGTH_ErrorCount,le.hosp_admit_or_er_WORDS_ErrorCount
          ,le.amb_nurse_to_hosp_LEFTTRIM_ErrorCount,le.amb_nurse_to_hosp_ALLOW_ErrorCount,le.amb_nurse_to_hosp_LENGTH_ErrorCount,le.amb_nurse_to_hosp_WORDS_ErrorCount
          ,le.non_covered_specialty_LEFTTRIM_ErrorCount,le.non_covered_specialty_ALLOW_ErrorCount,le.non_covered_specialty_LENGTH_ErrorCount,le.non_covered_specialty_WORDS_ErrorCount
          ,le.electronic_claim_LEFTTRIM_ErrorCount,le.electronic_claim_ALLOW_ErrorCount,le.electronic_claim_LENGTH_ErrorCount,le.electronic_claim_WORDS_ErrorCount
          ,le.dialysis_related_LEFTTRIM_ErrorCount,le.dialysis_related_ALLOW_ErrorCount,le.dialysis_related_LENGTH_ErrorCount,le.dialysis_related_WORDS_ErrorCount
          ,le.new_patient_LEFTTRIM_ErrorCount,le.new_patient_ALLOW_ErrorCount,le.new_patient_LENGTH_ErrorCount,le.new_patient_WORDS_ErrorCount
          ,le.init_proc_LEFTTRIM_ErrorCount,le.init_proc_ALLOW_ErrorCount,le.init_proc_LENGTH_ErrorCount,le.init_proc_WORDS_ErrorCount
          ,le.amb_nurse_to_diag_LEFTTRIM_ErrorCount,le.amb_nurse_to_diag_ALLOW_ErrorCount,le.amb_nurse_to_diag_LENGTH_ErrorCount,le.amb_nurse_to_diag_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.claim_num_LEFTTRIM_ErrorCount,le.claim_num_ALLOW_ErrorCount,le.claim_num_LENGTH_ErrorCount,le.claim_num_WORDS_ErrorCount
          ,le.claim_rec_type_LEFTTRIM_ErrorCount,le.claim_rec_type_ALLOW_ErrorCount,le.claim_rec_type_LENGTH_ErrorCount,le.claim_rec_type_WORDS_ErrorCount
          ,le.payer_id_LEFTTRIM_ErrorCount,le.payer_id_ALLOW_ErrorCount,le.payer_id_LENGTH_ErrorCount,le.payer_id_WORDS_ErrorCount
          ,le.form_type_LEFTTRIM_ErrorCount,le.form_type_ALLOW_ErrorCount,le.form_type_LENGTH_ErrorCount,le.form_type_WORDS_ErrorCount
          ,le.received_date_LEFTTRIM_ErrorCount,le.received_date_ALLOW_ErrorCount,le.received_date_LENGTH_ErrorCount,le.received_date_WORDS_ErrorCount
          ,le.claim_type_LEFTTRIM_ErrorCount,le.claim_type_ALLOW_ErrorCount,le.claim_type_LENGTH_ErrorCount,le.claim_type_WORDS_ErrorCount
          ,le.adjustment_code_LEFTTRIM_ErrorCount,le.adjustment_code_ALLOW_ErrorCount,le.adjustment_code_LENGTH_ErrorCount,le.adjustment_code_WORDS_ErrorCount
          ,le.prev_claim_number_LEFTTRIM_ErrorCount,le.prev_claim_number_ALLOW_ErrorCount
          ,le.member_dob_LEFTTRIM_ErrorCount,le.member_dob_ALLOW_ErrorCount,le.member_dob_LENGTH_ErrorCount,le.member_dob_WORDS_ErrorCount
          ,le.member_state_LEFTTRIM_ErrorCount,le.member_state_ALLOW_ErrorCount,le.member_state_LENGTH_ErrorCount,le.member_state_WORDS_ErrorCount
          ,le.member_zip_LEFTTRIM_ErrorCount,le.member_zip_ALLOW_ErrorCount,le.member_zip_LENGTH_ErrorCount,le.member_zip_WORDS_ErrorCount
          ,le.patient_relation_LEFTTRIM_ErrorCount,le.patient_relation_ALLOW_ErrorCount,le.patient_relation_LENGTH_ErrorCount,le.patient_relation_WORDS_ErrorCount
          ,le.patient_gender_LEFTTRIM_ErrorCount,le.patient_gender_ALLOW_ErrorCount,le.patient_gender_LENGTH_ErrorCount,le.patient_gender_WORDS_ErrorCount
          ,le.patient_dob_LEFTTRIM_ErrorCount,le.patient_dob_ALLOW_ErrorCount,le.patient_dob_LENGTH_ErrorCount,le.patient_dob_WORDS_ErrorCount
          ,le.billing_id_LEFTTRIM_ErrorCount,le.billing_id_ALLOW_ErrorCount,le.billing_id_LENGTH_ErrorCount,le.billing_id_WORDS_ErrorCount
          ,le.billing_npi_LEFTTRIM_ErrorCount,le.billing_npi_ALLOW_ErrorCount,le.billing_npi_LENGTH_ErrorCount,le.billing_npi_WORDS_ErrorCount
          ,le.billing_state_LEFTTRIM_ErrorCount,le.billing_state_ALLOW_ErrorCount,le.billing_state_LENGTH_ErrorCount,le.billing_state_WORDS_ErrorCount
          ,le.billing_zip_LEFTTRIM_ErrorCount,le.billing_zip_ALLOW_ErrorCount,le.billing_zip_LENGTH_ErrorCount,le.billing_zip_WORDS_ErrorCount
          ,le.referring_id_LEFTTRIM_ErrorCount,le.referring_id_ALLOW_ErrorCount,le.referring_id_LENGTH_ErrorCount,le.referring_id_WORDS_ErrorCount
          ,le.referring_npi_LEFTTRIM_ErrorCount,le.referring_npi_ALLOW_ErrorCount,le.referring_npi_LENGTH_ErrorCount,le.referring_npi_WORDS_ErrorCount
          ,le.referring_name1_LEFTTRIM_ErrorCount,le.referring_name1_ALLOW_ErrorCount,le.referring_name1_LENGTH_ErrorCount,le.referring_name1_WORDS_ErrorCount
          ,le.referring_name2_LEFTTRIM_ErrorCount,le.referring_name2_ALLOW_ErrorCount
          ,le.attending_id_LEFTTRIM_ErrorCount,le.attending_id_ALLOW_ErrorCount,le.attending_id_WORDS_ErrorCount
          ,le.attending_npi_LEFTTRIM_ErrorCount,le.attending_npi_ALLOW_ErrorCount,le.attending_npi_LENGTH_ErrorCount,le.attending_npi_WORDS_ErrorCount
          ,le.facility_state_LEFTTRIM_ErrorCount,le.facility_state_ALLOW_ErrorCount,le.facility_state_LENGTH_ErrorCount,le.facility_state_WORDS_ErrorCount
          ,le.facility_zip_LEFTTRIM_ErrorCount,le.facility_zip_ALLOW_ErrorCount,le.facility_zip_LENGTH_ErrorCount,le.facility_zip_WORDS_ErrorCount
          ,le.statement_to_LEFTTRIM_ErrorCount,le.statement_to_ALLOW_ErrorCount,le.statement_to_WORDS_ErrorCount
          ,le.total_charge_LEFTTRIM_ErrorCount,le.total_charge_ALLOW_ErrorCount,le.total_charge_WORDS_ErrorCount
          ,le.drg_code_LEFTTRIM_ErrorCount,le.drg_code_ALLOW_ErrorCount,le.drg_code_LENGTH_ErrorCount,le.drg_code_WORDS_ErrorCount
          ,le.bill_type_LEFTTRIM_ErrorCount,le.bill_type_ALLOW_ErrorCount,le.bill_type_LENGTH_ErrorCount,le.bill_type_WORDS_ErrorCount
          ,le.release_sign_LEFTTRIM_ErrorCount,le.release_sign_ALLOW_ErrorCount,le.release_sign_LENGTH_ErrorCount,le.release_sign_WORDS_ErrorCount
          ,le.assignment_sign_LEFTTRIM_ErrorCount,le.assignment_sign_ALLOW_ErrorCount,le.assignment_sign_LENGTH_ErrorCount,le.assignment_sign_WORDS_ErrorCount
          ,le.principal_proc_LEFTTRIM_ErrorCount,le.principal_proc_ALLOW_ErrorCount,le.principal_proc_LENGTH_ErrorCount,le.principal_proc_WORDS_ErrorCount
          ,le.admit_diag_LEFTTRIM_ErrorCount,le.admit_diag_ALLOW_ErrorCount,le.admit_diag_LENGTH_ErrorCount,le.admit_diag_WORDS_ErrorCount
          ,le.primary_diag_LEFTTRIM_ErrorCount,le.primary_diag_ALLOW_ErrorCount,le.primary_diag_LENGTH_ErrorCount,le.primary_diag_WORDS_ErrorCount
          ,le.diag_code2_LEFTTRIM_ErrorCount,le.diag_code2_ALLOW_ErrorCount,le.diag_code2_LENGTH_ErrorCount,le.diag_code2_WORDS_ErrorCount
          ,le.diag_code3_LEFTTRIM_ErrorCount,le.diag_code3_ALLOW_ErrorCount,le.diag_code3_LENGTH_ErrorCount,le.diag_code3_WORDS_ErrorCount
          ,le.diag_code4_LEFTTRIM_ErrorCount,le.diag_code4_ALLOW_ErrorCount,le.diag_code4_LENGTH_ErrorCount,le.diag_code4_WORDS_ErrorCount
          ,le.diag_code5_LEFTTRIM_ErrorCount,le.diag_code5_ALLOW_ErrorCount,le.diag_code5_LENGTH_ErrorCount,le.diag_code5_WORDS_ErrorCount
          ,le.diag_code6_LEFTTRIM_ErrorCount,le.diag_code6_ALLOW_ErrorCount,le.diag_code6_LENGTH_ErrorCount,le.diag_code6_WORDS_ErrorCount
          ,le.diag_code7_LEFTTRIM_ErrorCount,le.diag_code7_ALLOW_ErrorCount,le.diag_code7_LENGTH_ErrorCount,le.diag_code7_WORDS_ErrorCount
          ,le.diag_code8_LEFTTRIM_ErrorCount,le.diag_code8_ALLOW_ErrorCount,le.diag_code8_LENGTH_ErrorCount,le.diag_code8_WORDS_ErrorCount
          ,le.other_proc_LEFTTRIM_ErrorCount,le.other_proc_ALLOW_ErrorCount,le.other_proc_LENGTH_ErrorCount,le.other_proc_WORDS_ErrorCount
          ,le.other_proc3_LEFTTRIM_ErrorCount,le.other_proc3_ALLOW_ErrorCount,le.other_proc3_LENGTH_ErrorCount,le.other_proc3_WORDS_ErrorCount
          ,le.other_proc4_LEFTTRIM_ErrorCount,le.other_proc4_ALLOW_ErrorCount,le.other_proc4_LENGTH_ErrorCount,le.other_proc4_WORDS_ErrorCount
          ,le.other_proc5_LEFTTRIM_ErrorCount,le.other_proc5_ALLOW_ErrorCount,le.other_proc5_LENGTH_ErrorCount,le.other_proc5_WORDS_ErrorCount
          ,le.other_proc6_LEFTTRIM_ErrorCount,le.other_proc6_ALLOW_ErrorCount,le.other_proc6_LENGTH_ErrorCount,le.other_proc6_WORDS_ErrorCount
          ,le.coverage_type_LEFTTRIM_ErrorCount,le.coverage_type_ALLOW_ErrorCount,le.coverage_type_LENGTH_ErrorCount,le.coverage_type_WORDS_ErrorCount
          ,le.accident_related_LEFTTRIM_ErrorCount,le.accident_related_ALLOW_ErrorCount,le.accident_related_LENGTH_ErrorCount,le.accident_related_WORDS_ErrorCount
          ,le.esrd_patient_LEFTTRIM_ErrorCount,le.esrd_patient_ALLOW_ErrorCount,le.esrd_patient_LENGTH_ErrorCount,le.esrd_patient_WORDS_ErrorCount
          ,le.hosp_admit_or_er_LEFTTRIM_ErrorCount,le.hosp_admit_or_er_ALLOW_ErrorCount,le.hosp_admit_or_er_LENGTH_ErrorCount,le.hosp_admit_or_er_WORDS_ErrorCount
          ,le.amb_nurse_to_hosp_LEFTTRIM_ErrorCount,le.amb_nurse_to_hosp_ALLOW_ErrorCount,le.amb_nurse_to_hosp_LENGTH_ErrorCount,le.amb_nurse_to_hosp_WORDS_ErrorCount
          ,le.non_covered_specialty_LEFTTRIM_ErrorCount,le.non_covered_specialty_ALLOW_ErrorCount,le.non_covered_specialty_LENGTH_ErrorCount,le.non_covered_specialty_WORDS_ErrorCount
          ,le.electronic_claim_LEFTTRIM_ErrorCount,le.electronic_claim_ALLOW_ErrorCount,le.electronic_claim_LENGTH_ErrorCount,le.electronic_claim_WORDS_ErrorCount
          ,le.dialysis_related_LEFTTRIM_ErrorCount,le.dialysis_related_ALLOW_ErrorCount,le.dialysis_related_LENGTH_ErrorCount,le.dialysis_related_WORDS_ErrorCount
          ,le.new_patient_LEFTTRIM_ErrorCount,le.new_patient_ALLOW_ErrorCount,le.new_patient_LENGTH_ErrorCount,le.new_patient_WORDS_ErrorCount
          ,le.init_proc_LEFTTRIM_ErrorCount,le.init_proc_ALLOW_ErrorCount,le.init_proc_LENGTH_ErrorCount,le.init_proc_WORDS_ErrorCount
          ,le.amb_nurse_to_diag_LEFTTRIM_ErrorCount,le.amb_nurse_to_diag_ALLOW_ErrorCount,le.amb_nurse_to_diag_LENGTH_ErrorCount,le.amb_nurse_to_diag_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,225,Into(LEFT,COUNTER));
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
