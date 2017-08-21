IMPORT ut,SALT31;
EXPORT SRecord_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(SRecord_Layout_SRecord)
    UNSIGNED1 claim_num_Invalid;
    UNSIGNED1 claim_rec_type_Invalid;
    UNSIGNED1 line_number_Invalid;
    UNSIGNED1 service_from_Invalid;
    UNSIGNED1 service_to_Invalid;
    UNSIGNED1 place_service_Invalid;
    UNSIGNED1 cpt_code_Invalid;
    UNSIGNED1 proc_qual_Invalid;
    UNSIGNED1 proc_mod1_Invalid;
    UNSIGNED1 proc_mod2_Invalid;
    UNSIGNED1 proc_mod3_Invalid;
    UNSIGNED1 line_charge_Invalid;
    UNSIGNED1 units_Invalid;
    UNSIGNED1 revenue_code_Invalid;
    UNSIGNED1 diag_code1_Invalid;
    UNSIGNED1 diag_code2_Invalid;
    UNSIGNED1 diag_code3_Invalid;
    UNSIGNED1 diag_code4_Invalid;
    UNSIGNED1 ambulance_to_hosp_Invalid;
    UNSIGNED1 emergency_Invalid;
    UNSIGNED1 paid_date_Invalid;
    UNSIGNED1 bene_not_entitled_Invalid;
    UNSIGNED1 patient_reach_max_Invalid;
    UNSIGNED1 svc_during_postop_Invalid;
    UNSIGNED1 pid_Invalid;
    UNSIGNED1 src_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 ln_record_type_Invalid;
    UNSIGNED1 clean_service_from_Invalid;
    UNSIGNED1 clean_service_to_Invalid;
    UNSIGNED1 clean_paid_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(SRecord_Layout_SRecord)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(SRecord_Layout_SRecord) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.claim_num_Invalid := SRecord_Fields.InValid_claim_num((SALT31.StrType)le.claim_num);
    SELF.claim_rec_type_Invalid := SRecord_Fields.InValid_claim_rec_type((SALT31.StrType)le.claim_rec_type);
    SELF.line_number_Invalid := SRecord_Fields.InValid_line_number((SALT31.StrType)le.line_number);
    SELF.service_from_Invalid := SRecord_Fields.InValid_service_from((SALT31.StrType)le.service_from);
    SELF.service_to_Invalid := SRecord_Fields.InValid_service_to((SALT31.StrType)le.service_to);
    SELF.place_service_Invalid := SRecord_Fields.InValid_place_service((SALT31.StrType)le.place_service);
    SELF.cpt_code_Invalid := SRecord_Fields.InValid_cpt_code((SALT31.StrType)le.cpt_code);
    SELF.proc_qual_Invalid := SRecord_Fields.InValid_proc_qual((SALT31.StrType)le.proc_qual);
    SELF.proc_mod1_Invalid := SRecord_Fields.InValid_proc_mod1((SALT31.StrType)le.proc_mod1);
    SELF.proc_mod2_Invalid := SRecord_Fields.InValid_proc_mod2((SALT31.StrType)le.proc_mod2);
    SELF.proc_mod3_Invalid := SRecord_Fields.InValid_proc_mod3((SALT31.StrType)le.proc_mod3);
    SELF.line_charge_Invalid := SRecord_Fields.InValid_line_charge((SALT31.StrType)le.line_charge);
    SELF.units_Invalid := SRecord_Fields.InValid_units((SALT31.StrType)le.units);
    SELF.revenue_code_Invalid := SRecord_Fields.InValid_revenue_code((SALT31.StrType)le.revenue_code);
    SELF.diag_code1_Invalid := SRecord_Fields.InValid_diag_code1((SALT31.StrType)le.diag_code1);
    SELF.diag_code2_Invalid := SRecord_Fields.InValid_diag_code2((SALT31.StrType)le.diag_code2);
    SELF.diag_code3_Invalid := SRecord_Fields.InValid_diag_code3((SALT31.StrType)le.diag_code3);
    SELF.diag_code4_Invalid := SRecord_Fields.InValid_diag_code4((SALT31.StrType)le.diag_code4);
    SELF.ambulance_to_hosp_Invalid := SRecord_Fields.InValid_ambulance_to_hosp((SALT31.StrType)le.ambulance_to_hosp);
    SELF.emergency_Invalid := SRecord_Fields.InValid_emergency((SALT31.StrType)le.emergency);
    SELF.paid_date_Invalid := SRecord_Fields.InValid_paid_date((SALT31.StrType)le.paid_date);
    SELF.bene_not_entitled_Invalid := SRecord_Fields.InValid_bene_not_entitled((SALT31.StrType)le.bene_not_entitled);
    SELF.patient_reach_max_Invalid := SRecord_Fields.InValid_patient_reach_max((SALT31.StrType)le.patient_reach_max);
    SELF.svc_during_postop_Invalid := SRecord_Fields.InValid_svc_during_postop((SALT31.StrType)le.svc_during_postop);
    SELF.pid_Invalid := SRecord_Fields.InValid_pid((SALT31.StrType)le.pid);
    SELF.src_Invalid := SRecord_Fields.InValid_src((SALT31.StrType)le.src);
    SELF.dt_vendor_first_reported_Invalid := SRecord_Fields.InValid_dt_vendor_first_reported((SALT31.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := SRecord_Fields.InValid_dt_vendor_last_reported((SALT31.StrType)le.dt_vendor_last_reported);
    SELF.dt_first_seen_Invalid := SRecord_Fields.InValid_dt_first_seen((SALT31.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := SRecord_Fields.InValid_dt_last_seen((SALT31.StrType)le.dt_last_seen);
    SELF.ln_record_type_Invalid := SRecord_Fields.InValid_ln_record_type((SALT31.StrType)le.ln_record_type);
    SELF.clean_service_from_Invalid := SRecord_Fields.InValid_clean_service_from((SALT31.StrType)le.clean_service_from);
    SELF.clean_service_to_Invalid := SRecord_Fields.InValid_clean_service_to((SALT31.StrType)le.clean_service_to);
    SELF.clean_paid_date_Invalid := SRecord_Fields.InValid_clean_paid_date((SALT31.StrType)le.clean_paid_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.claim_num_Invalid << 0 ) + ( le.claim_rec_type_Invalid << 3 ) + ( le.line_number_Invalid << 6 ) + ( le.service_from_Invalid << 9 ) + ( le.service_to_Invalid << 12 ) + ( le.place_service_Invalid << 15 ) + ( le.cpt_code_Invalid << 18 ) + ( le.proc_qual_Invalid << 21 ) + ( le.proc_mod1_Invalid << 24 ) + ( le.proc_mod2_Invalid << 27 ) + ( le.proc_mod3_Invalid << 30 ) + ( le.line_charge_Invalid << 33 ) + ( le.units_Invalid << 35 ) + ( le.revenue_code_Invalid << 37 ) + ( le.diag_code1_Invalid << 40 ) + ( le.diag_code2_Invalid << 43 ) + ( le.diag_code3_Invalid << 46 ) + ( le.diag_code4_Invalid << 49 ) + ( le.ambulance_to_hosp_Invalid << 52 ) + ( le.emergency_Invalid << 55 ) + ( le.paid_date_Invalid << 58 ) + ( le.bene_not_entitled_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.patient_reach_max_Invalid << 0 ) + ( le.svc_during_postop_Invalid << 3 ) + ( le.pid_Invalid << 6 ) + ( le.src_Invalid << 9 ) + ( le.dt_vendor_first_reported_Invalid << 12 ) + ( le.dt_vendor_last_reported_Invalid << 15 ) + ( le.dt_first_seen_Invalid << 18 ) + ( le.dt_last_seen_Invalid << 21 ) + ( le.ln_record_type_Invalid << 24 ) + ( le.clean_service_from_Invalid << 27 ) + ( le.clean_service_to_Invalid << 30 ) + ( le.clean_paid_date_Invalid << 33 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,SRecord_Layout_SRecord);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.claim_num_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.claim_rec_type_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.line_number_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.service_from_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.service_to_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.place_service_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.cpt_code_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.proc_qual_Invalid := (le.ScrubsBits1 >> 21) & 7;
    SELF.proc_mod1_Invalid := (le.ScrubsBits1 >> 24) & 7;
    SELF.proc_mod2_Invalid := (le.ScrubsBits1 >> 27) & 7;
    SELF.proc_mod3_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.line_charge_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.units_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.revenue_code_Invalid := (le.ScrubsBits1 >> 37) & 7;
    SELF.diag_code1_Invalid := (le.ScrubsBits1 >> 40) & 7;
    SELF.diag_code2_Invalid := (le.ScrubsBits1 >> 43) & 7;
    SELF.diag_code3_Invalid := (le.ScrubsBits1 >> 46) & 7;
    SELF.diag_code4_Invalid := (le.ScrubsBits1 >> 49) & 7;
    SELF.ambulance_to_hosp_Invalid := (le.ScrubsBits1 >> 52) & 7;
    SELF.emergency_Invalid := (le.ScrubsBits1 >> 55) & 7;
    SELF.paid_date_Invalid := (le.ScrubsBits1 >> 58) & 7;
    SELF.bene_not_entitled_Invalid := (le.ScrubsBits1 >> 61) & 7;
    SELF.patient_reach_max_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.svc_during_postop_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.pid_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.src_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.ln_record_type_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.clean_service_from_Invalid := (le.ScrubsBits2 >> 27) & 7;
    SELF.clean_service_to_Invalid := (le.ScrubsBits2 >> 30) & 7;
    SELF.clean_paid_date_Invalid := (le.ScrubsBits2 >> 33) & 7;
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
    line_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.line_number_Invalid=1);
    line_number_ALLOW_ErrorCount := COUNT(GROUP,h.line_number_Invalid=2);
    line_number_LENGTH_ErrorCount := COUNT(GROUP,h.line_number_Invalid=3);
    line_number_WORDS_ErrorCount := COUNT(GROUP,h.line_number_Invalid=4);
    line_number_Total_ErrorCount := COUNT(GROUP,h.line_number_Invalid>0);
    service_from_LEFTTRIM_ErrorCount := COUNT(GROUP,h.service_from_Invalid=1);
    service_from_ALLOW_ErrorCount := COUNT(GROUP,h.service_from_Invalid=2);
    service_from_LENGTH_ErrorCount := COUNT(GROUP,h.service_from_Invalid=3);
    service_from_WORDS_ErrorCount := COUNT(GROUP,h.service_from_Invalid=4);
    service_from_Total_ErrorCount := COUNT(GROUP,h.service_from_Invalid>0);
    service_to_LEFTTRIM_ErrorCount := COUNT(GROUP,h.service_to_Invalid=1);
    service_to_ALLOW_ErrorCount := COUNT(GROUP,h.service_to_Invalid=2);
    service_to_LENGTH_ErrorCount := COUNT(GROUP,h.service_to_Invalid=3);
    service_to_WORDS_ErrorCount := COUNT(GROUP,h.service_to_Invalid=4);
    service_to_Total_ErrorCount := COUNT(GROUP,h.service_to_Invalid>0);
    place_service_LEFTTRIM_ErrorCount := COUNT(GROUP,h.place_service_Invalid=1);
    place_service_ALLOW_ErrorCount := COUNT(GROUP,h.place_service_Invalid=2);
    place_service_LENGTH_ErrorCount := COUNT(GROUP,h.place_service_Invalid=3);
    place_service_WORDS_ErrorCount := COUNT(GROUP,h.place_service_Invalid=4);
    place_service_Total_ErrorCount := COUNT(GROUP,h.place_service_Invalid>0);
    cpt_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cpt_code_Invalid=1);
    cpt_code_ALLOW_ErrorCount := COUNT(GROUP,h.cpt_code_Invalid=2);
    cpt_code_LENGTH_ErrorCount := COUNT(GROUP,h.cpt_code_Invalid=3);
    cpt_code_WORDS_ErrorCount := COUNT(GROUP,h.cpt_code_Invalid=4);
    cpt_code_Total_ErrorCount := COUNT(GROUP,h.cpt_code_Invalid>0);
    proc_qual_LEFTTRIM_ErrorCount := COUNT(GROUP,h.proc_qual_Invalid=1);
    proc_qual_ALLOW_ErrorCount := COUNT(GROUP,h.proc_qual_Invalid=2);
    proc_qual_LENGTH_ErrorCount := COUNT(GROUP,h.proc_qual_Invalid=3);
    proc_qual_WORDS_ErrorCount := COUNT(GROUP,h.proc_qual_Invalid=4);
    proc_qual_Total_ErrorCount := COUNT(GROUP,h.proc_qual_Invalid>0);
    proc_mod1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.proc_mod1_Invalid=1);
    proc_mod1_ALLOW_ErrorCount := COUNT(GROUP,h.proc_mod1_Invalid=2);
    proc_mod1_LENGTH_ErrorCount := COUNT(GROUP,h.proc_mod1_Invalid=3);
    proc_mod1_WORDS_ErrorCount := COUNT(GROUP,h.proc_mod1_Invalid=4);
    proc_mod1_Total_ErrorCount := COUNT(GROUP,h.proc_mod1_Invalid>0);
    proc_mod2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.proc_mod2_Invalid=1);
    proc_mod2_ALLOW_ErrorCount := COUNT(GROUP,h.proc_mod2_Invalid=2);
    proc_mod2_LENGTH_ErrorCount := COUNT(GROUP,h.proc_mod2_Invalid=3);
    proc_mod2_WORDS_ErrorCount := COUNT(GROUP,h.proc_mod2_Invalid=4);
    proc_mod2_Total_ErrorCount := COUNT(GROUP,h.proc_mod2_Invalid>0);
    proc_mod3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.proc_mod3_Invalid=1);
    proc_mod3_ALLOW_ErrorCount := COUNT(GROUP,h.proc_mod3_Invalid=2);
    proc_mod3_LENGTH_ErrorCount := COUNT(GROUP,h.proc_mod3_Invalid=3);
    proc_mod3_WORDS_ErrorCount := COUNT(GROUP,h.proc_mod3_Invalid=4);
    proc_mod3_Total_ErrorCount := COUNT(GROUP,h.proc_mod3_Invalid>0);
    line_charge_LEFTTRIM_ErrorCount := COUNT(GROUP,h.line_charge_Invalid=1);
    line_charge_ALLOW_ErrorCount := COUNT(GROUP,h.line_charge_Invalid=2);
    line_charge_WORDS_ErrorCount := COUNT(GROUP,h.line_charge_Invalid=3);
    line_charge_Total_ErrorCount := COUNT(GROUP,h.line_charge_Invalid>0);
    units_LEFTTRIM_ErrorCount := COUNT(GROUP,h.units_Invalid=1);
    units_ALLOW_ErrorCount := COUNT(GROUP,h.units_Invalid=2);
    units_WORDS_ErrorCount := COUNT(GROUP,h.units_Invalid=3);
    units_Total_ErrorCount := COUNT(GROUP,h.units_Invalid>0);
    revenue_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.revenue_code_Invalid=1);
    revenue_code_ALLOW_ErrorCount := COUNT(GROUP,h.revenue_code_Invalid=2);
    revenue_code_LENGTH_ErrorCount := COUNT(GROUP,h.revenue_code_Invalid=3);
    revenue_code_WORDS_ErrorCount := COUNT(GROUP,h.revenue_code_Invalid=4);
    revenue_code_Total_ErrorCount := COUNT(GROUP,h.revenue_code_Invalid>0);
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
    ambulance_to_hosp_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ambulance_to_hosp_Invalid=1);
    ambulance_to_hosp_ALLOW_ErrorCount := COUNT(GROUP,h.ambulance_to_hosp_Invalid=2);
    ambulance_to_hosp_LENGTH_ErrorCount := COUNT(GROUP,h.ambulance_to_hosp_Invalid=3);
    ambulance_to_hosp_WORDS_ErrorCount := COUNT(GROUP,h.ambulance_to_hosp_Invalid=4);
    ambulance_to_hosp_Total_ErrorCount := COUNT(GROUP,h.ambulance_to_hosp_Invalid>0);
    emergency_LEFTTRIM_ErrorCount := COUNT(GROUP,h.emergency_Invalid=1);
    emergency_ALLOW_ErrorCount := COUNT(GROUP,h.emergency_Invalid=2);
    emergency_LENGTH_ErrorCount := COUNT(GROUP,h.emergency_Invalid=3);
    emergency_WORDS_ErrorCount := COUNT(GROUP,h.emergency_Invalid=4);
    emergency_Total_ErrorCount := COUNT(GROUP,h.emergency_Invalid>0);
    paid_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.paid_date_Invalid=1);
    paid_date_ALLOW_ErrorCount := COUNT(GROUP,h.paid_date_Invalid=2);
    paid_date_LENGTH_ErrorCount := COUNT(GROUP,h.paid_date_Invalid=3);
    paid_date_WORDS_ErrorCount := COUNT(GROUP,h.paid_date_Invalid=4);
    paid_date_Total_ErrorCount := COUNT(GROUP,h.paid_date_Invalid>0);
    bene_not_entitled_LEFTTRIM_ErrorCount := COUNT(GROUP,h.bene_not_entitled_Invalid=1);
    bene_not_entitled_ALLOW_ErrorCount := COUNT(GROUP,h.bene_not_entitled_Invalid=2);
    bene_not_entitled_LENGTH_ErrorCount := COUNT(GROUP,h.bene_not_entitled_Invalid=3);
    bene_not_entitled_WORDS_ErrorCount := COUNT(GROUP,h.bene_not_entitled_Invalid=4);
    bene_not_entitled_Total_ErrorCount := COUNT(GROUP,h.bene_not_entitled_Invalid>0);
    patient_reach_max_LEFTTRIM_ErrorCount := COUNT(GROUP,h.patient_reach_max_Invalid=1);
    patient_reach_max_ALLOW_ErrorCount := COUNT(GROUP,h.patient_reach_max_Invalid=2);
    patient_reach_max_LENGTH_ErrorCount := COUNT(GROUP,h.patient_reach_max_Invalid=3);
    patient_reach_max_WORDS_ErrorCount := COUNT(GROUP,h.patient_reach_max_Invalid=4);
    patient_reach_max_Total_ErrorCount := COUNT(GROUP,h.patient_reach_max_Invalid>0);
    svc_during_postop_LEFTTRIM_ErrorCount := COUNT(GROUP,h.svc_during_postop_Invalid=1);
    svc_during_postop_ALLOW_ErrorCount := COUNT(GROUP,h.svc_during_postop_Invalid=2);
    svc_during_postop_LENGTH_ErrorCount := COUNT(GROUP,h.svc_during_postop_Invalid=3);
    svc_during_postop_WORDS_ErrorCount := COUNT(GROUP,h.svc_during_postop_Invalid=4);
    svc_during_postop_Total_ErrorCount := COUNT(GROUP,h.svc_during_postop_Invalid>0);
    pid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.pid_Invalid=1);
    pid_ALLOW_ErrorCount := COUNT(GROUP,h.pid_Invalid=2);
    pid_LENGTH_ErrorCount := COUNT(GROUP,h.pid_Invalid=3);
    pid_WORDS_ErrorCount := COUNT(GROUP,h.pid_Invalid=4);
    pid_Total_ErrorCount := COUNT(GROUP,h.pid_Invalid>0);
    src_LEFTTRIM_ErrorCount := COUNT(GROUP,h.src_Invalid=1);
    src_ALLOW_ErrorCount := COUNT(GROUP,h.src_Invalid=2);
    src_LENGTH_ErrorCount := COUNT(GROUP,h.src_Invalid=3);
    src_WORDS_ErrorCount := COUNT(GROUP,h.src_Invalid=4);
    src_Total_ErrorCount := COUNT(GROUP,h.src_Invalid>0);
    dt_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=3);
    dt_vendor_first_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=4);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=3);
    dt_vendor_last_reported_WORDS_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=4);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    dt_first_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=3);
    dt_first_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=4);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=3);
    dt_last_seen_WORDS_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=4);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    ln_record_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ln_record_type_Invalid=1);
    ln_record_type_ALLOW_ErrorCount := COUNT(GROUP,h.ln_record_type_Invalid=2);
    ln_record_type_LENGTH_ErrorCount := COUNT(GROUP,h.ln_record_type_Invalid=3);
    ln_record_type_WORDS_ErrorCount := COUNT(GROUP,h.ln_record_type_Invalid=4);
    ln_record_type_Total_ErrorCount := COUNT(GROUP,h.ln_record_type_Invalid>0);
    clean_service_from_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_service_from_Invalid=1);
    clean_service_from_ALLOW_ErrorCount := COUNT(GROUP,h.clean_service_from_Invalid=2);
    clean_service_from_LENGTH_ErrorCount := COUNT(GROUP,h.clean_service_from_Invalid=3);
    clean_service_from_WORDS_ErrorCount := COUNT(GROUP,h.clean_service_from_Invalid=4);
    clean_service_from_Total_ErrorCount := COUNT(GROUP,h.clean_service_from_Invalid>0);
    clean_service_to_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_service_to_Invalid=1);
    clean_service_to_ALLOW_ErrorCount := COUNT(GROUP,h.clean_service_to_Invalid=2);
    clean_service_to_LENGTH_ErrorCount := COUNT(GROUP,h.clean_service_to_Invalid=3);
    clean_service_to_WORDS_ErrorCount := COUNT(GROUP,h.clean_service_to_Invalid=4);
    clean_service_to_Total_ErrorCount := COUNT(GROUP,h.clean_service_to_Invalid>0);
    clean_paid_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_paid_date_Invalid=1);
    clean_paid_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_paid_date_Invalid=2);
    clean_paid_date_LENGTH_ErrorCount := COUNT(GROUP,h.clean_paid_date_Invalid=3);
    clean_paid_date_WORDS_ErrorCount := COUNT(GROUP,h.clean_paid_date_Invalid=4);
    clean_paid_date_Total_ErrorCount := COUNT(GROUP,h.clean_paid_date_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.claim_num_Invalid,le.claim_rec_type_Invalid,le.line_number_Invalid,le.service_from_Invalid,le.service_to_Invalid,le.place_service_Invalid,le.cpt_code_Invalid,le.proc_qual_Invalid,le.proc_mod1_Invalid,le.proc_mod2_Invalid,le.proc_mod3_Invalid,le.line_charge_Invalid,le.units_Invalid,le.revenue_code_Invalid,le.diag_code1_Invalid,le.diag_code2_Invalid,le.diag_code3_Invalid,le.diag_code4_Invalid,le.ambulance_to_hosp_Invalid,le.emergency_Invalid,le.paid_date_Invalid,le.bene_not_entitled_Invalid,le.patient_reach_max_Invalid,le.svc_during_postop_Invalid,le.pid_Invalid,le.src_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.ln_record_type_Invalid,le.clean_service_from_Invalid,le.clean_service_to_Invalid,le.clean_paid_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,SRecord_Fields.InvalidMessage_claim_num(le.claim_num_Invalid),SRecord_Fields.InvalidMessage_claim_rec_type(le.claim_rec_type_Invalid),SRecord_Fields.InvalidMessage_line_number(le.line_number_Invalid),SRecord_Fields.InvalidMessage_service_from(le.service_from_Invalid),SRecord_Fields.InvalidMessage_service_to(le.service_to_Invalid),SRecord_Fields.InvalidMessage_place_service(le.place_service_Invalid),SRecord_Fields.InvalidMessage_cpt_code(le.cpt_code_Invalid),SRecord_Fields.InvalidMessage_proc_qual(le.proc_qual_Invalid),SRecord_Fields.InvalidMessage_proc_mod1(le.proc_mod1_Invalid),SRecord_Fields.InvalidMessage_proc_mod2(le.proc_mod2_Invalid),SRecord_Fields.InvalidMessage_proc_mod3(le.proc_mod3_Invalid),SRecord_Fields.InvalidMessage_line_charge(le.line_charge_Invalid),SRecord_Fields.InvalidMessage_units(le.units_Invalid),SRecord_Fields.InvalidMessage_revenue_code(le.revenue_code_Invalid),SRecord_Fields.InvalidMessage_diag_code1(le.diag_code1_Invalid),SRecord_Fields.InvalidMessage_diag_code2(le.diag_code2_Invalid),SRecord_Fields.InvalidMessage_diag_code3(le.diag_code3_Invalid),SRecord_Fields.InvalidMessage_diag_code4(le.diag_code4_Invalid),SRecord_Fields.InvalidMessage_ambulance_to_hosp(le.ambulance_to_hosp_Invalid),SRecord_Fields.InvalidMessage_emergency(le.emergency_Invalid),SRecord_Fields.InvalidMessage_paid_date(le.paid_date_Invalid),SRecord_Fields.InvalidMessage_bene_not_entitled(le.bene_not_entitled_Invalid),SRecord_Fields.InvalidMessage_patient_reach_max(le.patient_reach_max_Invalid),SRecord_Fields.InvalidMessage_svc_during_postop(le.svc_during_postop_Invalid),SRecord_Fields.InvalidMessage_pid(le.pid_Invalid),SRecord_Fields.InvalidMessage_src(le.src_Invalid),SRecord_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),SRecord_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),SRecord_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),SRecord_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),SRecord_Fields.InvalidMessage_ln_record_type(le.ln_record_type_Invalid),SRecord_Fields.InvalidMessage_clean_service_from(le.clean_service_from_Invalid),SRecord_Fields.InvalidMessage_clean_service_to(le.clean_service_to_Invalid),SRecord_Fields.InvalidMessage_clean_paid_date(le.clean_paid_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.claim_num_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.claim_rec_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.line_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.service_from_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.service_to_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.place_service_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cpt_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.proc_qual_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.proc_mod1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.proc_mod2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.proc_mod3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.line_charge_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.units_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.revenue_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.diag_code4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ambulance_to_hosp_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.emergency_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.paid_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.bene_not_entitled_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.patient_reach_max_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.svc_during_postop_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.pid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.src_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ln_record_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_service_from_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_service_to_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.clean_paid_date_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'claim_num','claim_rec_type','line_number','service_from','service_to','place_service','cpt_code','proc_qual','proc_mod1','proc_mod2','proc_mod3','line_charge','units','revenue_code','diag_code1','diag_code2','diag_code3','diag_code4','ambulance_to_hosp','emergency','paid_date','bene_not_entitled','patient_reach_max','svc_during_postop','pid','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','ln_record_type','clean_service_from','clean_service_to','clean_paid_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'claim_num','claim_rec_type','line_number','service_from','service_to','place_service','cpt_code','proc_qual','proc_mod1','proc_mod2','proc_mod3','line_charge','units','revenue_code','diag_code1','diag_code2','diag_code3','diag_code4','ambulance_to_hosp','emergency','paid_date','bene_not_entitled','patient_reach_max','svc_during_postop','pid','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','ln_record_type','clean_service_from','clean_service_to','clean_paid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.claim_num,(SALT31.StrType)le.claim_rec_type,(SALT31.StrType)le.line_number,(SALT31.StrType)le.service_from,(SALT31.StrType)le.service_to,(SALT31.StrType)le.place_service,(SALT31.StrType)le.cpt_code,(SALT31.StrType)le.proc_qual,(SALT31.StrType)le.proc_mod1,(SALT31.StrType)le.proc_mod2,(SALT31.StrType)le.proc_mod3,(SALT31.StrType)le.line_charge,(SALT31.StrType)le.units,(SALT31.StrType)le.revenue_code,(SALT31.StrType)le.diag_code1,(SALT31.StrType)le.diag_code2,(SALT31.StrType)le.diag_code3,(SALT31.StrType)le.diag_code4,(SALT31.StrType)le.ambulance_to_hosp,(SALT31.StrType)le.emergency,(SALT31.StrType)le.paid_date,(SALT31.StrType)le.bene_not_entitled,(SALT31.StrType)le.patient_reach_max,(SALT31.StrType)le.svc_during_postop,(SALT31.StrType)le.pid,(SALT31.StrType)le.src,(SALT31.StrType)le.dt_vendor_first_reported,(SALT31.StrType)le.dt_vendor_last_reported,(SALT31.StrType)le.dt_first_seen,(SALT31.StrType)le.dt_last_seen,(SALT31.StrType)le.ln_record_type,(SALT31.StrType)le.clean_service_from,(SALT31.StrType)le.clean_service_to,(SALT31.StrType)le.clean_paid_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,34,Into(LEFT,COUNTER));
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
          ,'line_number:line_number:LEFTTRIM','line_number:line_number:ALLOW','line_number:line_number:LENGTH','line_number:line_number:WORDS'
          ,'service_from:service_from:LEFTTRIM','service_from:service_from:ALLOW','service_from:service_from:LENGTH','service_from:service_from:WORDS'
          ,'service_to:service_to:LEFTTRIM','service_to:service_to:ALLOW','service_to:service_to:LENGTH','service_to:service_to:WORDS'
          ,'place_service:place_service:LEFTTRIM','place_service:place_service:ALLOW','place_service:place_service:LENGTH','place_service:place_service:WORDS'
          ,'cpt_code:cpt_code:LEFTTRIM','cpt_code:cpt_code:ALLOW','cpt_code:cpt_code:LENGTH','cpt_code:cpt_code:WORDS'
          ,'proc_qual:proc_qual:LEFTTRIM','proc_qual:proc_qual:ALLOW','proc_qual:proc_qual:LENGTH','proc_qual:proc_qual:WORDS'
          ,'proc_mod1:proc_mod1:LEFTTRIM','proc_mod1:proc_mod1:ALLOW','proc_mod1:proc_mod1:LENGTH','proc_mod1:proc_mod1:WORDS'
          ,'proc_mod2:proc_mod2:LEFTTRIM','proc_mod2:proc_mod2:ALLOW','proc_mod2:proc_mod2:LENGTH','proc_mod2:proc_mod2:WORDS'
          ,'proc_mod3:proc_mod3:LEFTTRIM','proc_mod3:proc_mod3:ALLOW','proc_mod3:proc_mod3:LENGTH','proc_mod3:proc_mod3:WORDS'
          ,'line_charge:line_charge:LEFTTRIM','line_charge:line_charge:ALLOW','line_charge:line_charge:WORDS'
          ,'units:units:LEFTTRIM','units:units:ALLOW','units:units:WORDS'
          ,'revenue_code:revenue_code:LEFTTRIM','revenue_code:revenue_code:ALLOW','revenue_code:revenue_code:LENGTH','revenue_code:revenue_code:WORDS'
          ,'diag_code1:diag_code1:LEFTTRIM','diag_code1:diag_code1:ALLOW','diag_code1:diag_code1:LENGTH','diag_code1:diag_code1:WORDS'
          ,'diag_code2:diag_code2:LEFTTRIM','diag_code2:diag_code2:ALLOW','diag_code2:diag_code2:LENGTH','diag_code2:diag_code2:WORDS'
          ,'diag_code3:diag_code3:LEFTTRIM','diag_code3:diag_code3:ALLOW','diag_code3:diag_code3:LENGTH','diag_code3:diag_code3:WORDS'
          ,'diag_code4:diag_code4:LEFTTRIM','diag_code4:diag_code4:ALLOW','diag_code4:diag_code4:LENGTH','diag_code4:diag_code4:WORDS'
          ,'ambulance_to_hosp:ambulance_to_hosp:LEFTTRIM','ambulance_to_hosp:ambulance_to_hosp:ALLOW','ambulance_to_hosp:ambulance_to_hosp:LENGTH','ambulance_to_hosp:ambulance_to_hosp:WORDS'
          ,'emergency:emergency:LEFTTRIM','emergency:emergency:ALLOW','emergency:emergency:LENGTH','emergency:emergency:WORDS'
          ,'paid_date:paid_date:LEFTTRIM','paid_date:paid_date:ALLOW','paid_date:paid_date:LENGTH','paid_date:paid_date:WORDS'
          ,'bene_not_entitled:bene_not_entitled:LEFTTRIM','bene_not_entitled:bene_not_entitled:ALLOW','bene_not_entitled:bene_not_entitled:LENGTH','bene_not_entitled:bene_not_entitled:WORDS'
          ,'patient_reach_max:patient_reach_max:LEFTTRIM','patient_reach_max:patient_reach_max:ALLOW','patient_reach_max:patient_reach_max:LENGTH','patient_reach_max:patient_reach_max:WORDS'
          ,'svc_during_postop:svc_during_postop:LEFTTRIM','svc_during_postop:svc_during_postop:ALLOW','svc_during_postop:svc_during_postop:LENGTH','svc_during_postop:svc_during_postop:WORDS'
          ,'pid:pid:LEFTTRIM','pid:pid:ALLOW','pid:pid:LENGTH','pid:pid:WORDS'
          ,'src:src:LEFTTRIM','src:src:ALLOW','src:src:LENGTH','src:src:WORDS'
          ,'dt_vendor_first_reported:dt_vendor_first_reported:LEFTTRIM','dt_vendor_first_reported:dt_vendor_first_reported:ALLOW','dt_vendor_first_reported:dt_vendor_first_reported:LENGTH','dt_vendor_first_reported:dt_vendor_first_reported:WORDS'
          ,'dt_vendor_last_reported:dt_vendor_last_reported:LEFTTRIM','dt_vendor_last_reported:dt_vendor_last_reported:ALLOW','dt_vendor_last_reported:dt_vendor_last_reported:LENGTH','dt_vendor_last_reported:dt_vendor_last_reported:WORDS'
          ,'dt_first_seen:dt_first_seen:LEFTTRIM','dt_first_seen:dt_first_seen:ALLOW','dt_first_seen:dt_first_seen:LENGTH','dt_first_seen:dt_first_seen:WORDS'
          ,'dt_last_seen:dt_last_seen:LEFTTRIM','dt_last_seen:dt_last_seen:ALLOW','dt_last_seen:dt_last_seen:LENGTH','dt_last_seen:dt_last_seen:WORDS'
          ,'ln_record_type:ln_record_type:LEFTTRIM','ln_record_type:ln_record_type:ALLOW','ln_record_type:ln_record_type:LENGTH','ln_record_type:ln_record_type:WORDS'
          ,'clean_service_from:clean_service_from:LEFTTRIM','clean_service_from:clean_service_from:ALLOW','clean_service_from:clean_service_from:LENGTH','clean_service_from:clean_service_from:WORDS'
          ,'clean_service_to:clean_service_to:LEFTTRIM','clean_service_to:clean_service_to:ALLOW','clean_service_to:clean_service_to:LENGTH','clean_service_to:clean_service_to:WORDS'
          ,'clean_paid_date:clean_paid_date:LEFTTRIM','clean_paid_date:clean_paid_date:ALLOW','clean_paid_date:clean_paid_date:LENGTH','clean_paid_date:clean_paid_date:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,SRecord_Fields.InvalidMessage_claim_num(1),SRecord_Fields.InvalidMessage_claim_num(2),SRecord_Fields.InvalidMessage_claim_num(3),SRecord_Fields.InvalidMessage_claim_num(4)
          ,SRecord_Fields.InvalidMessage_claim_rec_type(1),SRecord_Fields.InvalidMessage_claim_rec_type(2),SRecord_Fields.InvalidMessage_claim_rec_type(3),SRecord_Fields.InvalidMessage_claim_rec_type(4)
          ,SRecord_Fields.InvalidMessage_line_number(1),SRecord_Fields.InvalidMessage_line_number(2),SRecord_Fields.InvalidMessage_line_number(3),SRecord_Fields.InvalidMessage_line_number(4)
          ,SRecord_Fields.InvalidMessage_service_from(1),SRecord_Fields.InvalidMessage_service_from(2),SRecord_Fields.InvalidMessage_service_from(3),SRecord_Fields.InvalidMessage_service_from(4)
          ,SRecord_Fields.InvalidMessage_service_to(1),SRecord_Fields.InvalidMessage_service_to(2),SRecord_Fields.InvalidMessage_service_to(3),SRecord_Fields.InvalidMessage_service_to(4)
          ,SRecord_Fields.InvalidMessage_place_service(1),SRecord_Fields.InvalidMessage_place_service(2),SRecord_Fields.InvalidMessage_place_service(3),SRecord_Fields.InvalidMessage_place_service(4)
          ,SRecord_Fields.InvalidMessage_cpt_code(1),SRecord_Fields.InvalidMessage_cpt_code(2),SRecord_Fields.InvalidMessage_cpt_code(3),SRecord_Fields.InvalidMessage_cpt_code(4)
          ,SRecord_Fields.InvalidMessage_proc_qual(1),SRecord_Fields.InvalidMessage_proc_qual(2),SRecord_Fields.InvalidMessage_proc_qual(3),SRecord_Fields.InvalidMessage_proc_qual(4)
          ,SRecord_Fields.InvalidMessage_proc_mod1(1),SRecord_Fields.InvalidMessage_proc_mod1(2),SRecord_Fields.InvalidMessage_proc_mod1(3),SRecord_Fields.InvalidMessage_proc_mod1(4)
          ,SRecord_Fields.InvalidMessage_proc_mod2(1),SRecord_Fields.InvalidMessage_proc_mod2(2),SRecord_Fields.InvalidMessage_proc_mod2(3),SRecord_Fields.InvalidMessage_proc_mod2(4)
          ,SRecord_Fields.InvalidMessage_proc_mod3(1),SRecord_Fields.InvalidMessage_proc_mod3(2),SRecord_Fields.InvalidMessage_proc_mod3(3),SRecord_Fields.InvalidMessage_proc_mod3(4)
          ,SRecord_Fields.InvalidMessage_line_charge(1),SRecord_Fields.InvalidMessage_line_charge(2),SRecord_Fields.InvalidMessage_line_charge(3)
          ,SRecord_Fields.InvalidMessage_units(1),SRecord_Fields.InvalidMessage_units(2),SRecord_Fields.InvalidMessage_units(3)
          ,SRecord_Fields.InvalidMessage_revenue_code(1),SRecord_Fields.InvalidMessage_revenue_code(2),SRecord_Fields.InvalidMessage_revenue_code(3),SRecord_Fields.InvalidMessage_revenue_code(4)
          ,SRecord_Fields.InvalidMessage_diag_code1(1),SRecord_Fields.InvalidMessage_diag_code1(2),SRecord_Fields.InvalidMessage_diag_code1(3),SRecord_Fields.InvalidMessage_diag_code1(4)
          ,SRecord_Fields.InvalidMessage_diag_code2(1),SRecord_Fields.InvalidMessage_diag_code2(2),SRecord_Fields.InvalidMessage_diag_code2(3),SRecord_Fields.InvalidMessage_diag_code2(4)
          ,SRecord_Fields.InvalidMessage_diag_code3(1),SRecord_Fields.InvalidMessage_diag_code3(2),SRecord_Fields.InvalidMessage_diag_code3(3),SRecord_Fields.InvalidMessage_diag_code3(4)
          ,SRecord_Fields.InvalidMessage_diag_code4(1),SRecord_Fields.InvalidMessage_diag_code4(2),SRecord_Fields.InvalidMessage_diag_code4(3),SRecord_Fields.InvalidMessage_diag_code4(4)
          ,SRecord_Fields.InvalidMessage_ambulance_to_hosp(1),SRecord_Fields.InvalidMessage_ambulance_to_hosp(2),SRecord_Fields.InvalidMessage_ambulance_to_hosp(3),SRecord_Fields.InvalidMessage_ambulance_to_hosp(4)
          ,SRecord_Fields.InvalidMessage_emergency(1),SRecord_Fields.InvalidMessage_emergency(2),SRecord_Fields.InvalidMessage_emergency(3),SRecord_Fields.InvalidMessage_emergency(4)
          ,SRecord_Fields.InvalidMessage_paid_date(1),SRecord_Fields.InvalidMessage_paid_date(2),SRecord_Fields.InvalidMessage_paid_date(3),SRecord_Fields.InvalidMessage_paid_date(4)
          ,SRecord_Fields.InvalidMessage_bene_not_entitled(1),SRecord_Fields.InvalidMessage_bene_not_entitled(2),SRecord_Fields.InvalidMessage_bene_not_entitled(3),SRecord_Fields.InvalidMessage_bene_not_entitled(4)
          ,SRecord_Fields.InvalidMessage_patient_reach_max(1),SRecord_Fields.InvalidMessage_patient_reach_max(2),SRecord_Fields.InvalidMessage_patient_reach_max(3),SRecord_Fields.InvalidMessage_patient_reach_max(4)
          ,SRecord_Fields.InvalidMessage_svc_during_postop(1),SRecord_Fields.InvalidMessage_svc_during_postop(2),SRecord_Fields.InvalidMessage_svc_during_postop(3),SRecord_Fields.InvalidMessage_svc_during_postop(4)
          ,SRecord_Fields.InvalidMessage_pid(1),SRecord_Fields.InvalidMessage_pid(2),SRecord_Fields.InvalidMessage_pid(3),SRecord_Fields.InvalidMessage_pid(4)
          ,SRecord_Fields.InvalidMessage_src(1),SRecord_Fields.InvalidMessage_src(2),SRecord_Fields.InvalidMessage_src(3),SRecord_Fields.InvalidMessage_src(4)
          ,SRecord_Fields.InvalidMessage_dt_vendor_first_reported(1),SRecord_Fields.InvalidMessage_dt_vendor_first_reported(2),SRecord_Fields.InvalidMessage_dt_vendor_first_reported(3),SRecord_Fields.InvalidMessage_dt_vendor_first_reported(4)
          ,SRecord_Fields.InvalidMessage_dt_vendor_last_reported(1),SRecord_Fields.InvalidMessage_dt_vendor_last_reported(2),SRecord_Fields.InvalidMessage_dt_vendor_last_reported(3),SRecord_Fields.InvalidMessage_dt_vendor_last_reported(4)
          ,SRecord_Fields.InvalidMessage_dt_first_seen(1),SRecord_Fields.InvalidMessage_dt_first_seen(2),SRecord_Fields.InvalidMessage_dt_first_seen(3),SRecord_Fields.InvalidMessage_dt_first_seen(4)
          ,SRecord_Fields.InvalidMessage_dt_last_seen(1),SRecord_Fields.InvalidMessage_dt_last_seen(2),SRecord_Fields.InvalidMessage_dt_last_seen(3),SRecord_Fields.InvalidMessage_dt_last_seen(4)
          ,SRecord_Fields.InvalidMessage_ln_record_type(1),SRecord_Fields.InvalidMessage_ln_record_type(2),SRecord_Fields.InvalidMessage_ln_record_type(3),SRecord_Fields.InvalidMessage_ln_record_type(4)
          ,SRecord_Fields.InvalidMessage_clean_service_from(1),SRecord_Fields.InvalidMessage_clean_service_from(2),SRecord_Fields.InvalidMessage_clean_service_from(3),SRecord_Fields.InvalidMessage_clean_service_from(4)
          ,SRecord_Fields.InvalidMessage_clean_service_to(1),SRecord_Fields.InvalidMessage_clean_service_to(2),SRecord_Fields.InvalidMessage_clean_service_to(3),SRecord_Fields.InvalidMessage_clean_service_to(4)
          ,SRecord_Fields.InvalidMessage_clean_paid_date(1),SRecord_Fields.InvalidMessage_clean_paid_date(2),SRecord_Fields.InvalidMessage_clean_paid_date(3),SRecord_Fields.InvalidMessage_clean_paid_date(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.claim_num_LEFTTRIM_ErrorCount,le.claim_num_ALLOW_ErrorCount,le.claim_num_LENGTH_ErrorCount,le.claim_num_WORDS_ErrorCount
          ,le.claim_rec_type_LEFTTRIM_ErrorCount,le.claim_rec_type_ALLOW_ErrorCount,le.claim_rec_type_LENGTH_ErrorCount,le.claim_rec_type_WORDS_ErrorCount
          ,le.line_number_LEFTTRIM_ErrorCount,le.line_number_ALLOW_ErrorCount,le.line_number_LENGTH_ErrorCount,le.line_number_WORDS_ErrorCount
          ,le.service_from_LEFTTRIM_ErrorCount,le.service_from_ALLOW_ErrorCount,le.service_from_LENGTH_ErrorCount,le.service_from_WORDS_ErrorCount
          ,le.service_to_LEFTTRIM_ErrorCount,le.service_to_ALLOW_ErrorCount,le.service_to_LENGTH_ErrorCount,le.service_to_WORDS_ErrorCount
          ,le.place_service_LEFTTRIM_ErrorCount,le.place_service_ALLOW_ErrorCount,le.place_service_LENGTH_ErrorCount,le.place_service_WORDS_ErrorCount
          ,le.cpt_code_LEFTTRIM_ErrorCount,le.cpt_code_ALLOW_ErrorCount,le.cpt_code_LENGTH_ErrorCount,le.cpt_code_WORDS_ErrorCount
          ,le.proc_qual_LEFTTRIM_ErrorCount,le.proc_qual_ALLOW_ErrorCount,le.proc_qual_LENGTH_ErrorCount,le.proc_qual_WORDS_ErrorCount
          ,le.proc_mod1_LEFTTRIM_ErrorCount,le.proc_mod1_ALLOW_ErrorCount,le.proc_mod1_LENGTH_ErrorCount,le.proc_mod1_WORDS_ErrorCount
          ,le.proc_mod2_LEFTTRIM_ErrorCount,le.proc_mod2_ALLOW_ErrorCount,le.proc_mod2_LENGTH_ErrorCount,le.proc_mod2_WORDS_ErrorCount
          ,le.proc_mod3_LEFTTRIM_ErrorCount,le.proc_mod3_ALLOW_ErrorCount,le.proc_mod3_LENGTH_ErrorCount,le.proc_mod3_WORDS_ErrorCount
          ,le.line_charge_LEFTTRIM_ErrorCount,le.line_charge_ALLOW_ErrorCount,le.line_charge_WORDS_ErrorCount
          ,le.units_LEFTTRIM_ErrorCount,le.units_ALLOW_ErrorCount,le.units_WORDS_ErrorCount
          ,le.revenue_code_LEFTTRIM_ErrorCount,le.revenue_code_ALLOW_ErrorCount,le.revenue_code_LENGTH_ErrorCount,le.revenue_code_WORDS_ErrorCount
          ,le.diag_code1_LEFTTRIM_ErrorCount,le.diag_code1_ALLOW_ErrorCount,le.diag_code1_LENGTH_ErrorCount,le.diag_code1_WORDS_ErrorCount
          ,le.diag_code2_LEFTTRIM_ErrorCount,le.diag_code2_ALLOW_ErrorCount,le.diag_code2_LENGTH_ErrorCount,le.diag_code2_WORDS_ErrorCount
          ,le.diag_code3_LEFTTRIM_ErrorCount,le.diag_code3_ALLOW_ErrorCount,le.diag_code3_LENGTH_ErrorCount,le.diag_code3_WORDS_ErrorCount
          ,le.diag_code4_LEFTTRIM_ErrorCount,le.diag_code4_ALLOW_ErrorCount,le.diag_code4_LENGTH_ErrorCount,le.diag_code4_WORDS_ErrorCount
          ,le.ambulance_to_hosp_LEFTTRIM_ErrorCount,le.ambulance_to_hosp_ALLOW_ErrorCount,le.ambulance_to_hosp_LENGTH_ErrorCount,le.ambulance_to_hosp_WORDS_ErrorCount
          ,le.emergency_LEFTTRIM_ErrorCount,le.emergency_ALLOW_ErrorCount,le.emergency_LENGTH_ErrorCount,le.emergency_WORDS_ErrorCount
          ,le.paid_date_LEFTTRIM_ErrorCount,le.paid_date_ALLOW_ErrorCount,le.paid_date_LENGTH_ErrorCount,le.paid_date_WORDS_ErrorCount
          ,le.bene_not_entitled_LEFTTRIM_ErrorCount,le.bene_not_entitled_ALLOW_ErrorCount,le.bene_not_entitled_LENGTH_ErrorCount,le.bene_not_entitled_WORDS_ErrorCount
          ,le.patient_reach_max_LEFTTRIM_ErrorCount,le.patient_reach_max_ALLOW_ErrorCount,le.patient_reach_max_LENGTH_ErrorCount,le.patient_reach_max_WORDS_ErrorCount
          ,le.svc_during_postop_LEFTTRIM_ErrorCount,le.svc_during_postop_ALLOW_ErrorCount,le.svc_during_postop_LENGTH_ErrorCount,le.svc_during_postop_WORDS_ErrorCount
          ,le.pid_LEFTTRIM_ErrorCount,le.pid_ALLOW_ErrorCount,le.pid_LENGTH_ErrorCount,le.pid_WORDS_ErrorCount
          ,le.src_LEFTTRIM_ErrorCount,le.src_ALLOW_ErrorCount,le.src_LENGTH_ErrorCount,le.src_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.ln_record_type_LEFTTRIM_ErrorCount,le.ln_record_type_ALLOW_ErrorCount,le.ln_record_type_LENGTH_ErrorCount,le.ln_record_type_WORDS_ErrorCount
          ,le.clean_service_from_LEFTTRIM_ErrorCount,le.clean_service_from_ALLOW_ErrorCount,le.clean_service_from_LENGTH_ErrorCount,le.clean_service_from_WORDS_ErrorCount
          ,le.clean_service_to_LEFTTRIM_ErrorCount,le.clean_service_to_ALLOW_ErrorCount,le.clean_service_to_LENGTH_ErrorCount,le.clean_service_to_WORDS_ErrorCount
          ,le.clean_paid_date_LEFTTRIM_ErrorCount,le.clean_paid_date_ALLOW_ErrorCount,le.clean_paid_date_LENGTH_ErrorCount,le.clean_paid_date_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.claim_num_LEFTTRIM_ErrorCount,le.claim_num_ALLOW_ErrorCount,le.claim_num_LENGTH_ErrorCount,le.claim_num_WORDS_ErrorCount
          ,le.claim_rec_type_LEFTTRIM_ErrorCount,le.claim_rec_type_ALLOW_ErrorCount,le.claim_rec_type_LENGTH_ErrorCount,le.claim_rec_type_WORDS_ErrorCount
          ,le.line_number_LEFTTRIM_ErrorCount,le.line_number_ALLOW_ErrorCount,le.line_number_LENGTH_ErrorCount,le.line_number_WORDS_ErrorCount
          ,le.service_from_LEFTTRIM_ErrorCount,le.service_from_ALLOW_ErrorCount,le.service_from_LENGTH_ErrorCount,le.service_from_WORDS_ErrorCount
          ,le.service_to_LEFTTRIM_ErrorCount,le.service_to_ALLOW_ErrorCount,le.service_to_LENGTH_ErrorCount,le.service_to_WORDS_ErrorCount
          ,le.place_service_LEFTTRIM_ErrorCount,le.place_service_ALLOW_ErrorCount,le.place_service_LENGTH_ErrorCount,le.place_service_WORDS_ErrorCount
          ,le.cpt_code_LEFTTRIM_ErrorCount,le.cpt_code_ALLOW_ErrorCount,le.cpt_code_LENGTH_ErrorCount,le.cpt_code_WORDS_ErrorCount
          ,le.proc_qual_LEFTTRIM_ErrorCount,le.proc_qual_ALLOW_ErrorCount,le.proc_qual_LENGTH_ErrorCount,le.proc_qual_WORDS_ErrorCount
          ,le.proc_mod1_LEFTTRIM_ErrorCount,le.proc_mod1_ALLOW_ErrorCount,le.proc_mod1_LENGTH_ErrorCount,le.proc_mod1_WORDS_ErrorCount
          ,le.proc_mod2_LEFTTRIM_ErrorCount,le.proc_mod2_ALLOW_ErrorCount,le.proc_mod2_LENGTH_ErrorCount,le.proc_mod2_WORDS_ErrorCount
          ,le.proc_mod3_LEFTTRIM_ErrorCount,le.proc_mod3_ALLOW_ErrorCount,le.proc_mod3_LENGTH_ErrorCount,le.proc_mod3_WORDS_ErrorCount
          ,le.line_charge_LEFTTRIM_ErrorCount,le.line_charge_ALLOW_ErrorCount,le.line_charge_WORDS_ErrorCount
          ,le.units_LEFTTRIM_ErrorCount,le.units_ALLOW_ErrorCount,le.units_WORDS_ErrorCount
          ,le.revenue_code_LEFTTRIM_ErrorCount,le.revenue_code_ALLOW_ErrorCount,le.revenue_code_LENGTH_ErrorCount,le.revenue_code_WORDS_ErrorCount
          ,le.diag_code1_LEFTTRIM_ErrorCount,le.diag_code1_ALLOW_ErrorCount,le.diag_code1_LENGTH_ErrorCount,le.diag_code1_WORDS_ErrorCount
          ,le.diag_code2_LEFTTRIM_ErrorCount,le.diag_code2_ALLOW_ErrorCount,le.diag_code2_LENGTH_ErrorCount,le.diag_code2_WORDS_ErrorCount
          ,le.diag_code3_LEFTTRIM_ErrorCount,le.diag_code3_ALLOW_ErrorCount,le.diag_code3_LENGTH_ErrorCount,le.diag_code3_WORDS_ErrorCount
          ,le.diag_code4_LEFTTRIM_ErrorCount,le.diag_code4_ALLOW_ErrorCount,le.diag_code4_LENGTH_ErrorCount,le.diag_code4_WORDS_ErrorCount
          ,le.ambulance_to_hosp_LEFTTRIM_ErrorCount,le.ambulance_to_hosp_ALLOW_ErrorCount,le.ambulance_to_hosp_LENGTH_ErrorCount,le.ambulance_to_hosp_WORDS_ErrorCount
          ,le.emergency_LEFTTRIM_ErrorCount,le.emergency_ALLOW_ErrorCount,le.emergency_LENGTH_ErrorCount,le.emergency_WORDS_ErrorCount
          ,le.paid_date_LEFTTRIM_ErrorCount,le.paid_date_ALLOW_ErrorCount,le.paid_date_LENGTH_ErrorCount,le.paid_date_WORDS_ErrorCount
          ,le.bene_not_entitled_LEFTTRIM_ErrorCount,le.bene_not_entitled_ALLOW_ErrorCount,le.bene_not_entitled_LENGTH_ErrorCount,le.bene_not_entitled_WORDS_ErrorCount
          ,le.patient_reach_max_LEFTTRIM_ErrorCount,le.patient_reach_max_ALLOW_ErrorCount,le.patient_reach_max_LENGTH_ErrorCount,le.patient_reach_max_WORDS_ErrorCount
          ,le.svc_during_postop_LEFTTRIM_ErrorCount,le.svc_during_postop_ALLOW_ErrorCount,le.svc_during_postop_LENGTH_ErrorCount,le.svc_during_postop_WORDS_ErrorCount
          ,le.pid_LEFTTRIM_ErrorCount,le.pid_ALLOW_ErrorCount,le.pid_LENGTH_ErrorCount,le.pid_WORDS_ErrorCount
          ,le.src_LEFTTRIM_ErrorCount,le.src_ALLOW_ErrorCount,le.src_LENGTH_ErrorCount,le.src_WORDS_ErrorCount
          ,le.dt_vendor_first_reported_LEFTTRIM_ErrorCount,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTH_ErrorCount,le.dt_vendor_first_reported_WORDS_ErrorCount
          ,le.dt_vendor_last_reported_LEFTTRIM_ErrorCount,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTH_ErrorCount,le.dt_vendor_last_reported_WORDS_ErrorCount
          ,le.dt_first_seen_LEFTTRIM_ErrorCount,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTH_ErrorCount,le.dt_first_seen_WORDS_ErrorCount
          ,le.dt_last_seen_LEFTTRIM_ErrorCount,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTH_ErrorCount,le.dt_last_seen_WORDS_ErrorCount
          ,le.ln_record_type_LEFTTRIM_ErrorCount,le.ln_record_type_ALLOW_ErrorCount,le.ln_record_type_LENGTH_ErrorCount,le.ln_record_type_WORDS_ErrorCount
          ,le.clean_service_from_LEFTTRIM_ErrorCount,le.clean_service_from_ALLOW_ErrorCount,le.clean_service_from_LENGTH_ErrorCount,le.clean_service_from_WORDS_ErrorCount
          ,le.clean_service_to_LEFTTRIM_ErrorCount,le.clean_service_to_ALLOW_ErrorCount,le.clean_service_to_LENGTH_ErrorCount,le.clean_service_to_WORDS_ErrorCount
          ,le.clean_paid_date_LEFTTRIM_ErrorCount,le.clean_paid_date_ALLOW_ErrorCount,le.clean_paid_date_LENGTH_ErrorCount,le.clean_paid_date_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,134,Into(LEFT,COUNTER));
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
