IMPORT ut,SALT31;
EXPORT SRecord_hygiene(dataset(SRecord_layout_SRecord) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_claim_num_pcnt := AVE(GROUP,IF(h.claim_num = (TYPEOF(h.claim_num))'',0,100));
    maxlength_claim_num := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_num)));
    avelength_claim_num := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_num)),h.claim_num<>(typeof(h.claim_num))'');
    populated_claim_rec_type_pcnt := AVE(GROUP,IF(h.claim_rec_type = (TYPEOF(h.claim_rec_type))'',0,100));
    maxlength_claim_rec_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_rec_type)));
    avelength_claim_rec_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_rec_type)),h.claim_rec_type<>(typeof(h.claim_rec_type))'');
    populated_line_number_pcnt := AVE(GROUP,IF(h.line_number = (TYPEOF(h.line_number))'',0,100));
    maxlength_line_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.line_number)));
    avelength_line_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.line_number)),h.line_number<>(typeof(h.line_number))'');
    populated_service_from_pcnt := AVE(GROUP,IF(h.service_from = (TYPEOF(h.service_from))'',0,100));
    maxlength_service_from := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_from)));
    avelength_service_from := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_from)),h.service_from<>(typeof(h.service_from))'');
    populated_service_to_pcnt := AVE(GROUP,IF(h.service_to = (TYPEOF(h.service_to))'',0,100));
    maxlength_service_to := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_to)));
    avelength_service_to := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_to)),h.service_to<>(typeof(h.service_to))'');
    populated_place_service_pcnt := AVE(GROUP,IF(h.place_service = (TYPEOF(h.place_service))'',0,100));
    maxlength_place_service := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.place_service)));
    avelength_place_service := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.place_service)),h.place_service<>(typeof(h.place_service))'');
    populated_cpt_code_pcnt := AVE(GROUP,IF(h.cpt_code = (TYPEOF(h.cpt_code))'',0,100));
    maxlength_cpt_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cpt_code)));
    avelength_cpt_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cpt_code)),h.cpt_code<>(typeof(h.cpt_code))'');
    populated_proc_qual_pcnt := AVE(GROUP,IF(h.proc_qual = (TYPEOF(h.proc_qual))'',0,100));
    maxlength_proc_qual := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proc_qual)));
    avelength_proc_qual := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proc_qual)),h.proc_qual<>(typeof(h.proc_qual))'');
    populated_proc_mod1_pcnt := AVE(GROUP,IF(h.proc_mod1 = (TYPEOF(h.proc_mod1))'',0,100));
    maxlength_proc_mod1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proc_mod1)));
    avelength_proc_mod1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proc_mod1)),h.proc_mod1<>(typeof(h.proc_mod1))'');
    populated_proc_mod2_pcnt := AVE(GROUP,IF(h.proc_mod2 = (TYPEOF(h.proc_mod2))'',0,100));
    maxlength_proc_mod2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proc_mod2)));
    avelength_proc_mod2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proc_mod2)),h.proc_mod2<>(typeof(h.proc_mod2))'');
    populated_proc_mod3_pcnt := AVE(GROUP,IF(h.proc_mod3 = (TYPEOF(h.proc_mod3))'',0,100));
    maxlength_proc_mod3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proc_mod3)));
    avelength_proc_mod3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proc_mod3)),h.proc_mod3<>(typeof(h.proc_mod3))'');
    populated_proc_mod4_pcnt := AVE(GROUP,IF(h.proc_mod4 = (TYPEOF(h.proc_mod4))'',0,100));
    maxlength_proc_mod4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.proc_mod4)));
    avelength_proc_mod4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.proc_mod4)),h.proc_mod4<>(typeof(h.proc_mod4))'');
    populated_line_charge_pcnt := AVE(GROUP,IF(h.line_charge = (TYPEOF(h.line_charge))'',0,100));
    maxlength_line_charge := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.line_charge)));
    avelength_line_charge := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.line_charge)),h.line_charge<>(typeof(h.line_charge))'');
    populated_line_allowed_pcnt := AVE(GROUP,IF(h.line_allowed = (TYPEOF(h.line_allowed))'',0,100));
    maxlength_line_allowed := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.line_allowed)));
    avelength_line_allowed := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.line_allowed)),h.line_allowed<>(typeof(h.line_allowed))'');
    populated_units_pcnt := AVE(GROUP,IF(h.units = (TYPEOF(h.units))'',0,100));
    maxlength_units := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.units)));
    avelength_units := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.units)),h.units<>(typeof(h.units))'');
    populated_revenue_code_pcnt := AVE(GROUP,IF(h.revenue_code = (TYPEOF(h.revenue_code))'',0,100));
    maxlength_revenue_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.revenue_code)));
    avelength_revenue_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.revenue_code)),h.revenue_code<>(typeof(h.revenue_code))'');
    populated_diag_code1_pcnt := AVE(GROUP,IF(h.diag_code1 = (TYPEOF(h.diag_code1))'',0,100));
    maxlength_diag_code1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code1)));
    avelength_diag_code1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code1)),h.diag_code1<>(typeof(h.diag_code1))'');
    populated_diag_code2_pcnt := AVE(GROUP,IF(h.diag_code2 = (TYPEOF(h.diag_code2))'',0,100));
    maxlength_diag_code2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code2)));
    avelength_diag_code2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code2)),h.diag_code2<>(typeof(h.diag_code2))'');
    populated_diag_code3_pcnt := AVE(GROUP,IF(h.diag_code3 = (TYPEOF(h.diag_code3))'',0,100));
    maxlength_diag_code3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code3)));
    avelength_diag_code3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code3)),h.diag_code3<>(typeof(h.diag_code3))'');
    populated_diag_code4_pcnt := AVE(GROUP,IF(h.diag_code4 = (TYPEOF(h.diag_code4))'',0,100));
    maxlength_diag_code4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code4)));
    avelength_diag_code4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code4)),h.diag_code4<>(typeof(h.diag_code4))'');
    populated_diag_code5_pcnt := AVE(GROUP,IF(h.diag_code5 = (TYPEOF(h.diag_code5))'',0,100));
    maxlength_diag_code5 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code5)));
    avelength_diag_code5 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code5)),h.diag_code5<>(typeof(h.diag_code5))'');
    populated_diag_code6_pcnt := AVE(GROUP,IF(h.diag_code6 = (TYPEOF(h.diag_code6))'',0,100));
    maxlength_diag_code6 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code6)));
    avelength_diag_code6 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code6)),h.diag_code6<>(typeof(h.diag_code6))'');
    populated_diag_code7_pcnt := AVE(GROUP,IF(h.diag_code7 = (TYPEOF(h.diag_code7))'',0,100));
    maxlength_diag_code7 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code7)));
    avelength_diag_code7 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code7)),h.diag_code7<>(typeof(h.diag_code7))'');
    populated_diag_code8_pcnt := AVE(GROUP,IF(h.diag_code8 = (TYPEOF(h.diag_code8))'',0,100));
    maxlength_diag_code8 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code8)));
    avelength_diag_code8 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code8)),h.diag_code8<>(typeof(h.diag_code8))'');
    populated_ndc_pcnt := AVE(GROUP,IF(h.ndc = (TYPEOF(h.ndc))'',0,100));
    maxlength_ndc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ndc)));
    avelength_ndc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ndc)),h.ndc<>(typeof(h.ndc))'');
    populated_ambulance_to_hosp_pcnt := AVE(GROUP,IF(h.ambulance_to_hosp = (TYPEOF(h.ambulance_to_hosp))'',0,100));
    maxlength_ambulance_to_hosp := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ambulance_to_hosp)));
    avelength_ambulance_to_hosp := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ambulance_to_hosp)),h.ambulance_to_hosp<>(typeof(h.ambulance_to_hosp))'');
    populated_emergency_pcnt := AVE(GROUP,IF(h.emergency = (TYPEOF(h.emergency))'',0,100));
    maxlength_emergency := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.emergency)));
    avelength_emergency := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.emergency)),h.emergency<>(typeof(h.emergency))'');
    populated_tooth_surface_pcnt := AVE(GROUP,IF(h.tooth_surface = (TYPEOF(h.tooth_surface))'',0,100));
    maxlength_tooth_surface := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.tooth_surface)));
    avelength_tooth_surface := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.tooth_surface)),h.tooth_surface<>(typeof(h.tooth_surface))'');
    populated_oral_cavity_pcnt := AVE(GROUP,IF(h.oral_cavity = (TYPEOF(h.oral_cavity))'',0,100));
    maxlength_oral_cavity := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.oral_cavity)));
    avelength_oral_cavity := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.oral_cavity)),h.oral_cavity<>(typeof(h.oral_cavity))'');
    populated_service_type_pcnt := AVE(GROUP,IF(h.service_type = (TYPEOF(h.service_type))'',0,100));
    maxlength_service_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_type)));
    avelength_service_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_type)),h.service_type<>(typeof(h.service_type))'');
    populated_copay_pcnt := AVE(GROUP,IF(h.copay = (TYPEOF(h.copay))'',0,100));
    maxlength_copay := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.copay)));
    avelength_copay := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.copay)),h.copay<>(typeof(h.copay))'');
    populated_paid_amount_pcnt := AVE(GROUP,IF(h.paid_amount = (TYPEOF(h.paid_amount))'',0,100));
    maxlength_paid_amount := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.paid_amount)));
    avelength_paid_amount := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.paid_amount)),h.paid_amount<>(typeof(h.paid_amount))'');
    populated_paid_date_pcnt := AVE(GROUP,IF(h.paid_date = (TYPEOF(h.paid_date))'',0,100));
    maxlength_paid_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.paid_date)));
    avelength_paid_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.paid_date)),h.paid_date<>(typeof(h.paid_date))'');
    populated_bene_not_entitled_pcnt := AVE(GROUP,IF(h.bene_not_entitled = (TYPEOF(h.bene_not_entitled))'',0,100));
    maxlength_bene_not_entitled := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bene_not_entitled)));
    avelength_bene_not_entitled := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bene_not_entitled)),h.bene_not_entitled<>(typeof(h.bene_not_entitled))'');
    populated_patient_reach_max_pcnt := AVE(GROUP,IF(h.patient_reach_max = (TYPEOF(h.patient_reach_max))'',0,100));
    maxlength_patient_reach_max := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_reach_max)));
    avelength_patient_reach_max := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_reach_max)),h.patient_reach_max<>(typeof(h.patient_reach_max))'');
    populated_svc_during_postop_pcnt := AVE(GROUP,IF(h.svc_during_postop = (TYPEOF(h.svc_during_postop))'',0,100));
    maxlength_svc_during_postop := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.svc_during_postop)));
    avelength_svc_during_postop := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.svc_during_postop)),h.svc_during_postop<>(typeof(h.svc_during_postop))'');
    populated_adjudicated_proc_pcnt := AVE(GROUP,IF(h.adjudicated_proc = (TYPEOF(h.adjudicated_proc))'',0,100));
    maxlength_adjudicated_proc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc)));
    avelength_adjudicated_proc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc)),h.adjudicated_proc<>(typeof(h.adjudicated_proc))'');
    populated_adjudicated_proc_qual_pcnt := AVE(GROUP,IF(h.adjudicated_proc_qual = (TYPEOF(h.adjudicated_proc_qual))'',0,100));
    maxlength_adjudicated_proc_qual := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc_qual)));
    avelength_adjudicated_proc_qual := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc_qual)),h.adjudicated_proc_qual<>(typeof(h.adjudicated_proc_qual))'');
    populated_adjudicated_proc_mod1_pcnt := AVE(GROUP,IF(h.adjudicated_proc_mod1 = (TYPEOF(h.adjudicated_proc_mod1))'',0,100));
    maxlength_adjudicated_proc_mod1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc_mod1)));
    avelength_adjudicated_proc_mod1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc_mod1)),h.adjudicated_proc_mod1<>(typeof(h.adjudicated_proc_mod1))'');
    populated_adjudicated_proc_mod2_pcnt := AVE(GROUP,IF(h.adjudicated_proc_mod2 = (TYPEOF(h.adjudicated_proc_mod2))'',0,100));
    maxlength_adjudicated_proc_mod2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc_mod2)));
    avelength_adjudicated_proc_mod2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc_mod2)),h.adjudicated_proc_mod2<>(typeof(h.adjudicated_proc_mod2))'');
    populated_adjudicated_proc_mod3_pcnt := AVE(GROUP,IF(h.adjudicated_proc_mod3 = (TYPEOF(h.adjudicated_proc_mod3))'',0,100));
    maxlength_adjudicated_proc_mod3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc_mod3)));
    avelength_adjudicated_proc_mod3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc_mod3)),h.adjudicated_proc_mod3<>(typeof(h.adjudicated_proc_mod3))'');
    populated_adjudicated_proc_mod4_pcnt := AVE(GROUP,IF(h.adjudicated_proc_mod4 = (TYPEOF(h.adjudicated_proc_mod4))'',0,100));
    maxlength_adjudicated_proc_mod4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc_mod4)));
    avelength_adjudicated_proc_mod4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjudicated_proc_mod4)),h.adjudicated_proc_mod4<>(typeof(h.adjudicated_proc_mod4))'');
    populated_pid_pcnt := AVE(GROUP,IF(h.pid = (TYPEOF(h.pid))'',0,100));
    maxlength_pid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pid)));
    avelength_pid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pid)),h.pid<>(typeof(h.pid))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_ln_record_type_pcnt := AVE(GROUP,IF(h.ln_record_type = (TYPEOF(h.ln_record_type))'',0,100));
    maxlength_ln_record_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ln_record_type)));
    avelength_ln_record_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ln_record_type)),h.ln_record_type<>(typeof(h.ln_record_type))'');
    populated_clean_service_from_pcnt := AVE(GROUP,IF(h.clean_service_from = (TYPEOF(h.clean_service_from))'',0,100));
    maxlength_clean_service_from := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_service_from)));
    avelength_clean_service_from := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_service_from)),h.clean_service_from<>(typeof(h.clean_service_from))'');
    populated_clean_service_to_pcnt := AVE(GROUP,IF(h.clean_service_to = (TYPEOF(h.clean_service_to))'',0,100));
    maxlength_clean_service_to := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_service_to)));
    avelength_clean_service_to := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_service_to)),h.clean_service_to<>(typeof(h.clean_service_to))'');
    populated_clean_paid_date_pcnt := AVE(GROUP,IF(h.clean_paid_date = (TYPEOF(h.clean_paid_date))'',0,100));
    maxlength_clean_paid_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_paid_date)));
    avelength_clean_paid_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.clean_paid_date)),h.clean_paid_date<>(typeof(h.clean_paid_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_claim_num_pcnt *   0.00 / 100 + T.Populated_claim_rec_type_pcnt *   0.00 / 100 + T.Populated_line_number_pcnt *   0.00 / 100 + T.Populated_service_from_pcnt *   0.00 / 100 + T.Populated_service_to_pcnt *   0.00 / 100 + T.Populated_place_service_pcnt *   0.00 / 100 + T.Populated_cpt_code_pcnt *   0.00 / 100 + T.Populated_proc_qual_pcnt *   0.00 / 100 + T.Populated_proc_mod1_pcnt *   0.00 / 100 + T.Populated_proc_mod2_pcnt *   0.00 / 100 + T.Populated_proc_mod3_pcnt *   0.00 / 100 + T.Populated_proc_mod4_pcnt *   0.00 / 100 + T.Populated_line_charge_pcnt *   0.00 / 100 + T.Populated_line_allowed_pcnt *   0.00 / 100 + T.Populated_units_pcnt *   0.00 / 100 + T.Populated_revenue_code_pcnt *   0.00 / 100 + T.Populated_diag_code1_pcnt *   0.00 / 100 + T.Populated_diag_code2_pcnt *   0.00 / 100 + T.Populated_diag_code3_pcnt *   0.00 / 100 + T.Populated_diag_code4_pcnt *   0.00 / 100 + T.Populated_diag_code5_pcnt *   0.00 / 100 + T.Populated_diag_code6_pcnt *   0.00 / 100 + T.Populated_diag_code7_pcnt *   0.00 / 100 + T.Populated_diag_code8_pcnt *   0.00 / 100 + T.Populated_ndc_pcnt *   0.00 / 100 + T.Populated_ambulance_to_hosp_pcnt *   0.00 / 100 + T.Populated_emergency_pcnt *   0.00 / 100 + T.Populated_tooth_surface_pcnt *   0.00 / 100 + T.Populated_oral_cavity_pcnt *   0.00 / 100 + T.Populated_service_type_pcnt *   0.00 / 100 + T.Populated_copay_pcnt *   0.00 / 100 + T.Populated_paid_amount_pcnt *   0.00 / 100 + T.Populated_paid_date_pcnt *   0.00 / 100 + T.Populated_bene_not_entitled_pcnt *   0.00 / 100 + T.Populated_patient_reach_max_pcnt *   0.00 / 100 + T.Populated_svc_during_postop_pcnt *   0.00 / 100 + T.Populated_adjudicated_proc_pcnt *   0.00 / 100 + T.Populated_adjudicated_proc_qual_pcnt *   0.00 / 100 + T.Populated_adjudicated_proc_mod1_pcnt *   0.00 / 100 + T.Populated_adjudicated_proc_mod2_pcnt *   0.00 / 100 + T.Populated_adjudicated_proc_mod3_pcnt *   0.00 / 100 + T.Populated_adjudicated_proc_mod4_pcnt *   0.00 / 100 + T.Populated_pid_pcnt *   0.00 / 100 + T.Populated_src_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_ln_record_type_pcnt *   0.00 / 100 + T.Populated_clean_service_from_pcnt *   0.00 / 100 + T.Populated_clean_service_to_pcnt *   0.00 / 100 + T.Populated_clean_paid_date_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'claim_num','claim_rec_type','line_number','service_from','service_to','place_service','cpt_code','proc_qual','proc_mod1','proc_mod2','proc_mod3','proc_mod4','line_charge','line_allowed','units','revenue_code','diag_code1','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','ndc','ambulance_to_hosp','emergency','tooth_surface','oral_cavity','service_type','copay','paid_amount','paid_date','bene_not_entitled','patient_reach_max','svc_during_postop','adjudicated_proc','adjudicated_proc_qual','adjudicated_proc_mod1','adjudicated_proc_mod2','adjudicated_proc_mod3','adjudicated_proc_mod4','pid','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','ln_record_type','clean_service_from','clean_service_to','clean_paid_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_claim_num_pcnt,le.populated_claim_rec_type_pcnt,le.populated_line_number_pcnt,le.populated_service_from_pcnt,le.populated_service_to_pcnt,le.populated_place_service_pcnt,le.populated_cpt_code_pcnt,le.populated_proc_qual_pcnt,le.populated_proc_mod1_pcnt,le.populated_proc_mod2_pcnt,le.populated_proc_mod3_pcnt,le.populated_proc_mod4_pcnt,le.populated_line_charge_pcnt,le.populated_line_allowed_pcnt,le.populated_units_pcnt,le.populated_revenue_code_pcnt,le.populated_diag_code1_pcnt,le.populated_diag_code2_pcnt,le.populated_diag_code3_pcnt,le.populated_diag_code4_pcnt,le.populated_diag_code5_pcnt,le.populated_diag_code6_pcnt,le.populated_diag_code7_pcnt,le.populated_diag_code8_pcnt,le.populated_ndc_pcnt,le.populated_ambulance_to_hosp_pcnt,le.populated_emergency_pcnt,le.populated_tooth_surface_pcnt,le.populated_oral_cavity_pcnt,le.populated_service_type_pcnt,le.populated_copay_pcnt,le.populated_paid_amount_pcnt,le.populated_paid_date_pcnt,le.populated_bene_not_entitled_pcnt,le.populated_patient_reach_max_pcnt,le.populated_svc_during_postop_pcnt,le.populated_adjudicated_proc_pcnt,le.populated_adjudicated_proc_qual_pcnt,le.populated_adjudicated_proc_mod1_pcnt,le.populated_adjudicated_proc_mod2_pcnt,le.populated_adjudicated_proc_mod3_pcnt,le.populated_adjudicated_proc_mod4_pcnt,le.populated_pid_pcnt,le.populated_src_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_ln_record_type_pcnt,le.populated_clean_service_from_pcnt,le.populated_clean_service_to_pcnt,le.populated_clean_paid_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_claim_num,le.maxlength_claim_rec_type,le.maxlength_line_number,le.maxlength_service_from,le.maxlength_service_to,le.maxlength_place_service,le.maxlength_cpt_code,le.maxlength_proc_qual,le.maxlength_proc_mod1,le.maxlength_proc_mod2,le.maxlength_proc_mod3,le.maxlength_proc_mod4,le.maxlength_line_charge,le.maxlength_line_allowed,le.maxlength_units,le.maxlength_revenue_code,le.maxlength_diag_code1,le.maxlength_diag_code2,le.maxlength_diag_code3,le.maxlength_diag_code4,le.maxlength_diag_code5,le.maxlength_diag_code6,le.maxlength_diag_code7,le.maxlength_diag_code8,le.maxlength_ndc,le.maxlength_ambulance_to_hosp,le.maxlength_emergency,le.maxlength_tooth_surface,le.maxlength_oral_cavity,le.maxlength_service_type,le.maxlength_copay,le.maxlength_paid_amount,le.maxlength_paid_date,le.maxlength_bene_not_entitled,le.maxlength_patient_reach_max,le.maxlength_svc_during_postop,le.maxlength_adjudicated_proc,le.maxlength_adjudicated_proc_qual,le.maxlength_adjudicated_proc_mod1,le.maxlength_adjudicated_proc_mod2,le.maxlength_adjudicated_proc_mod3,le.maxlength_adjudicated_proc_mod4,le.maxlength_pid,le.maxlength_src,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_ln_record_type,le.maxlength_clean_service_from,le.maxlength_clean_service_to,le.maxlength_clean_paid_date);
  SELF.avelength := CHOOSE(C,le.avelength_claim_num,le.avelength_claim_rec_type,le.avelength_line_number,le.avelength_service_from,le.avelength_service_to,le.avelength_place_service,le.avelength_cpt_code,le.avelength_proc_qual,le.avelength_proc_mod1,le.avelength_proc_mod2,le.avelength_proc_mod3,le.avelength_proc_mod4,le.avelength_line_charge,le.avelength_line_allowed,le.avelength_units,le.avelength_revenue_code,le.avelength_diag_code1,le.avelength_diag_code2,le.avelength_diag_code3,le.avelength_diag_code4,le.avelength_diag_code5,le.avelength_diag_code6,le.avelength_diag_code7,le.avelength_diag_code8,le.avelength_ndc,le.avelength_ambulance_to_hosp,le.avelength_emergency,le.avelength_tooth_surface,le.avelength_oral_cavity,le.avelength_service_type,le.avelength_copay,le.avelength_paid_amount,le.avelength_paid_date,le.avelength_bene_not_entitled,le.avelength_patient_reach_max,le.avelength_svc_during_postop,le.avelength_adjudicated_proc,le.avelength_adjudicated_proc_qual,le.avelength_adjudicated_proc_mod1,le.avelength_adjudicated_proc_mod2,le.avelength_adjudicated_proc_mod3,le.avelength_adjudicated_proc_mod4,le.avelength_pid,le.avelength_src,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_ln_record_type,le.avelength_clean_service_from,le.avelength_clean_service_to,le.avelength_clean_paid_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 52, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.claim_rec_type),TRIM((SALT31.StrType)le.line_number),TRIM((SALT31.StrType)le.service_from),TRIM((SALT31.StrType)le.service_to),TRIM((SALT31.StrType)le.place_service),TRIM((SALT31.StrType)le.cpt_code),TRIM((SALT31.StrType)le.proc_qual),TRIM((SALT31.StrType)le.proc_mod1),TRIM((SALT31.StrType)le.proc_mod2),TRIM((SALT31.StrType)le.proc_mod3),TRIM((SALT31.StrType)le.proc_mod4),TRIM((SALT31.StrType)le.line_charge),TRIM((SALT31.StrType)le.line_allowed),TRIM((SALT31.StrType)le.units),TRIM((SALT31.StrType)le.revenue_code),TRIM((SALT31.StrType)le.diag_code1),TRIM((SALT31.StrType)le.diag_code2),TRIM((SALT31.StrType)le.diag_code3),TRIM((SALT31.StrType)le.diag_code4),TRIM((SALT31.StrType)le.diag_code5),TRIM((SALT31.StrType)le.diag_code6),TRIM((SALT31.StrType)le.diag_code7),TRIM((SALT31.StrType)le.diag_code8),TRIM((SALT31.StrType)le.ndc),TRIM((SALT31.StrType)le.ambulance_to_hosp),TRIM((SALT31.StrType)le.emergency),TRIM((SALT31.StrType)le.tooth_surface),TRIM((SALT31.StrType)le.oral_cavity),TRIM((SALT31.StrType)le.service_type),TRIM((SALT31.StrType)le.copay),TRIM((SALT31.StrType)le.paid_amount),TRIM((SALT31.StrType)le.paid_date),TRIM((SALT31.StrType)le.bene_not_entitled),TRIM((SALT31.StrType)le.patient_reach_max),TRIM((SALT31.StrType)le.svc_during_postop),TRIM((SALT31.StrType)le.adjudicated_proc),TRIM((SALT31.StrType)le.adjudicated_proc_qual),TRIM((SALT31.StrType)le.adjudicated_proc_mod1),TRIM((SALT31.StrType)le.adjudicated_proc_mod2),TRIM((SALT31.StrType)le.adjudicated_proc_mod3),TRIM((SALT31.StrType)le.adjudicated_proc_mod4),TRIM((SALT31.StrType)le.pid),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.ln_record_type),TRIM((SALT31.StrType)le.clean_service_from),TRIM((SALT31.StrType)le.clean_service_to),TRIM((SALT31.StrType)le.clean_paid_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,52,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 52);
  SELF.FldNo2 := 1 + (C % 52);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.claim_rec_type),TRIM((SALT31.StrType)le.line_number),TRIM((SALT31.StrType)le.service_from),TRIM((SALT31.StrType)le.service_to),TRIM((SALT31.StrType)le.place_service),TRIM((SALT31.StrType)le.cpt_code),TRIM((SALT31.StrType)le.proc_qual),TRIM((SALT31.StrType)le.proc_mod1),TRIM((SALT31.StrType)le.proc_mod2),TRIM((SALT31.StrType)le.proc_mod3),TRIM((SALT31.StrType)le.proc_mod4),TRIM((SALT31.StrType)le.line_charge),TRIM((SALT31.StrType)le.line_allowed),TRIM((SALT31.StrType)le.units),TRIM((SALT31.StrType)le.revenue_code),TRIM((SALT31.StrType)le.diag_code1),TRIM((SALT31.StrType)le.diag_code2),TRIM((SALT31.StrType)le.diag_code3),TRIM((SALT31.StrType)le.diag_code4),TRIM((SALT31.StrType)le.diag_code5),TRIM((SALT31.StrType)le.diag_code6),TRIM((SALT31.StrType)le.diag_code7),TRIM((SALT31.StrType)le.diag_code8),TRIM((SALT31.StrType)le.ndc),TRIM((SALT31.StrType)le.ambulance_to_hosp),TRIM((SALT31.StrType)le.emergency),TRIM((SALT31.StrType)le.tooth_surface),TRIM((SALT31.StrType)le.oral_cavity),TRIM((SALT31.StrType)le.service_type),TRIM((SALT31.StrType)le.copay),TRIM((SALT31.StrType)le.paid_amount),TRIM((SALT31.StrType)le.paid_date),TRIM((SALT31.StrType)le.bene_not_entitled),TRIM((SALT31.StrType)le.patient_reach_max),TRIM((SALT31.StrType)le.svc_during_postop),TRIM((SALT31.StrType)le.adjudicated_proc),TRIM((SALT31.StrType)le.adjudicated_proc_qual),TRIM((SALT31.StrType)le.adjudicated_proc_mod1),TRIM((SALT31.StrType)le.adjudicated_proc_mod2),TRIM((SALT31.StrType)le.adjudicated_proc_mod3),TRIM((SALT31.StrType)le.adjudicated_proc_mod4),TRIM((SALT31.StrType)le.pid),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.ln_record_type),TRIM((SALT31.StrType)le.clean_service_from),TRIM((SALT31.StrType)le.clean_service_to),TRIM((SALT31.StrType)le.clean_paid_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.claim_rec_type),TRIM((SALT31.StrType)le.line_number),TRIM((SALT31.StrType)le.service_from),TRIM((SALT31.StrType)le.service_to),TRIM((SALT31.StrType)le.place_service),TRIM((SALT31.StrType)le.cpt_code),TRIM((SALT31.StrType)le.proc_qual),TRIM((SALT31.StrType)le.proc_mod1),TRIM((SALT31.StrType)le.proc_mod2),TRIM((SALT31.StrType)le.proc_mod3),TRIM((SALT31.StrType)le.proc_mod4),TRIM((SALT31.StrType)le.line_charge),TRIM((SALT31.StrType)le.line_allowed),TRIM((SALT31.StrType)le.units),TRIM((SALT31.StrType)le.revenue_code),TRIM((SALT31.StrType)le.diag_code1),TRIM((SALT31.StrType)le.diag_code2),TRIM((SALT31.StrType)le.diag_code3),TRIM((SALT31.StrType)le.diag_code4),TRIM((SALT31.StrType)le.diag_code5),TRIM((SALT31.StrType)le.diag_code6),TRIM((SALT31.StrType)le.diag_code7),TRIM((SALT31.StrType)le.diag_code8),TRIM((SALT31.StrType)le.ndc),TRIM((SALT31.StrType)le.ambulance_to_hosp),TRIM((SALT31.StrType)le.emergency),TRIM((SALT31.StrType)le.tooth_surface),TRIM((SALT31.StrType)le.oral_cavity),TRIM((SALT31.StrType)le.service_type),TRIM((SALT31.StrType)le.copay),TRIM((SALT31.StrType)le.paid_amount),TRIM((SALT31.StrType)le.paid_date),TRIM((SALT31.StrType)le.bene_not_entitled),TRIM((SALT31.StrType)le.patient_reach_max),TRIM((SALT31.StrType)le.svc_during_postop),TRIM((SALT31.StrType)le.adjudicated_proc),TRIM((SALT31.StrType)le.adjudicated_proc_qual),TRIM((SALT31.StrType)le.adjudicated_proc_mod1),TRIM((SALT31.StrType)le.adjudicated_proc_mod2),TRIM((SALT31.StrType)le.adjudicated_proc_mod3),TRIM((SALT31.StrType)le.adjudicated_proc_mod4),TRIM((SALT31.StrType)le.pid),TRIM((SALT31.StrType)le.src),TRIM((SALT31.StrType)le.dt_vendor_first_reported),TRIM((SALT31.StrType)le.dt_vendor_last_reported),TRIM((SALT31.StrType)le.dt_first_seen),TRIM((SALT31.StrType)le.dt_last_seen),TRIM((SALT31.StrType)le.ln_record_type),TRIM((SALT31.StrType)le.clean_service_from),TRIM((SALT31.StrType)le.clean_service_to),TRIM((SALT31.StrType)le.clean_paid_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),52*52,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'claim_num'}
      ,{2,'claim_rec_type'}
      ,{3,'line_number'}
      ,{4,'service_from'}
      ,{5,'service_to'}
      ,{6,'place_service'}
      ,{7,'cpt_code'}
      ,{8,'proc_qual'}
      ,{9,'proc_mod1'}
      ,{10,'proc_mod2'}
      ,{11,'proc_mod3'}
      ,{12,'proc_mod4'}
      ,{13,'line_charge'}
      ,{14,'line_allowed'}
      ,{15,'units'}
      ,{16,'revenue_code'}
      ,{17,'diag_code1'}
      ,{18,'diag_code2'}
      ,{19,'diag_code3'}
      ,{20,'diag_code4'}
      ,{21,'diag_code5'}
      ,{22,'diag_code6'}
      ,{23,'diag_code7'}
      ,{24,'diag_code8'}
      ,{25,'ndc'}
      ,{26,'ambulance_to_hosp'}
      ,{27,'emergency'}
      ,{28,'tooth_surface'}
      ,{29,'oral_cavity'}
      ,{30,'service_type'}
      ,{31,'copay'}
      ,{32,'paid_amount'}
      ,{33,'paid_date'}
      ,{34,'bene_not_entitled'}
      ,{35,'patient_reach_max'}
      ,{36,'svc_during_postop'}
      ,{37,'adjudicated_proc'}
      ,{38,'adjudicated_proc_qual'}
      ,{39,'adjudicated_proc_mod1'}
      ,{40,'adjudicated_proc_mod2'}
      ,{41,'adjudicated_proc_mod3'}
      ,{42,'adjudicated_proc_mod4'}
      ,{43,'pid'}
      ,{44,'src'}
      ,{45,'dt_vendor_first_reported'}
      ,{46,'dt_vendor_last_reported'}
      ,{47,'dt_first_seen'}
      ,{48,'dt_last_seen'}
      ,{49,'ln_record_type'}
      ,{50,'clean_service_from'}
      ,{51,'clean_service_to'}
      ,{52,'clean_paid_date'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    SRecord_Fields.InValid_claim_num((SALT31.StrType)le.claim_num),
    SRecord_Fields.InValid_claim_rec_type((SALT31.StrType)le.claim_rec_type),
    SRecord_Fields.InValid_line_number((SALT31.StrType)le.line_number),
    SRecord_Fields.InValid_service_from((SALT31.StrType)le.service_from),
    SRecord_Fields.InValid_service_to((SALT31.StrType)le.service_to),
    SRecord_Fields.InValid_place_service((SALT31.StrType)le.place_service),
    SRecord_Fields.InValid_cpt_code((SALT31.StrType)le.cpt_code),
    SRecord_Fields.InValid_proc_qual((SALT31.StrType)le.proc_qual),
    SRecord_Fields.InValid_proc_mod1((SALT31.StrType)le.proc_mod1),
    SRecord_Fields.InValid_proc_mod2((SALT31.StrType)le.proc_mod2),
    SRecord_Fields.InValid_proc_mod3((SALT31.StrType)le.proc_mod3),
    SRecord_Fields.InValid_proc_mod4((SALT31.StrType)le.proc_mod4),
    SRecord_Fields.InValid_line_charge((SALT31.StrType)le.line_charge),
    SRecord_Fields.InValid_line_allowed((SALT31.StrType)le.line_allowed),
    SRecord_Fields.InValid_units((SALT31.StrType)le.units),
    SRecord_Fields.InValid_revenue_code((SALT31.StrType)le.revenue_code),
    SRecord_Fields.InValid_diag_code1((SALT31.StrType)le.diag_code1),
    SRecord_Fields.InValid_diag_code2((SALT31.StrType)le.diag_code2),
    SRecord_Fields.InValid_diag_code3((SALT31.StrType)le.diag_code3),
    SRecord_Fields.InValid_diag_code4((SALT31.StrType)le.diag_code4),
    SRecord_Fields.InValid_diag_code5((SALT31.StrType)le.diag_code5),
    SRecord_Fields.InValid_diag_code6((SALT31.StrType)le.diag_code6),
    SRecord_Fields.InValid_diag_code7((SALT31.StrType)le.diag_code7),
    SRecord_Fields.InValid_diag_code8((SALT31.StrType)le.diag_code8),
    SRecord_Fields.InValid_ndc((SALT31.StrType)le.ndc),
    SRecord_Fields.InValid_ambulance_to_hosp((SALT31.StrType)le.ambulance_to_hosp),
    SRecord_Fields.InValid_emergency((SALT31.StrType)le.emergency),
    SRecord_Fields.InValid_tooth_surface((SALT31.StrType)le.tooth_surface),
    SRecord_Fields.InValid_oral_cavity((SALT31.StrType)le.oral_cavity),
    SRecord_Fields.InValid_service_type((SALT31.StrType)le.service_type),
    SRecord_Fields.InValid_copay((SALT31.StrType)le.copay),
    SRecord_Fields.InValid_paid_amount((SALT31.StrType)le.paid_amount),
    SRecord_Fields.InValid_paid_date((SALT31.StrType)le.paid_date),
    SRecord_Fields.InValid_bene_not_entitled((SALT31.StrType)le.bene_not_entitled),
    SRecord_Fields.InValid_patient_reach_max((SALT31.StrType)le.patient_reach_max),
    SRecord_Fields.InValid_svc_during_postop((SALT31.StrType)le.svc_during_postop),
    SRecord_Fields.InValid_adjudicated_proc((SALT31.StrType)le.adjudicated_proc),
    SRecord_Fields.InValid_adjudicated_proc_qual((SALT31.StrType)le.adjudicated_proc_qual),
    SRecord_Fields.InValid_adjudicated_proc_mod1((SALT31.StrType)le.adjudicated_proc_mod1),
    SRecord_Fields.InValid_adjudicated_proc_mod2((SALT31.StrType)le.adjudicated_proc_mod2),
    SRecord_Fields.InValid_adjudicated_proc_mod3((SALT31.StrType)le.adjudicated_proc_mod3),
    SRecord_Fields.InValid_adjudicated_proc_mod4((SALT31.StrType)le.adjudicated_proc_mod4),
    SRecord_Fields.InValid_pid((SALT31.StrType)le.pid),
    SRecord_Fields.InValid_src((SALT31.StrType)le.src),
    SRecord_Fields.InValid_dt_vendor_first_reported((SALT31.StrType)le.dt_vendor_first_reported),
    SRecord_Fields.InValid_dt_vendor_last_reported((SALT31.StrType)le.dt_vendor_last_reported),
    SRecord_Fields.InValid_dt_first_seen((SALT31.StrType)le.dt_first_seen),
    SRecord_Fields.InValid_dt_last_seen((SALT31.StrType)le.dt_last_seen),
    SRecord_Fields.InValid_ln_record_type((SALT31.StrType)le.ln_record_type),
    SRecord_Fields.InValid_clean_service_from((SALT31.StrType)le.clean_service_from),
    SRecord_Fields.InValid_clean_service_to((SALT31.StrType)le.clean_service_to),
    SRecord_Fields.InValid_clean_paid_date((SALT31.StrType)le.clean_paid_date),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,52,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := SRecord_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'claim_num','claim_rec_type','line_number','service_from','service_to','place_service','cpt_code','proc_qual','proc_mod1','proc_mod2','proc_mod3','Unknown','line_charge','Unknown','units','revenue_code','diag_code1','diag_code2','diag_code3','diag_code4','Unknown','Unknown','Unknown','Unknown','Unknown','ambulance_to_hosp','emergency','Unknown','Unknown','Unknown','Unknown','Unknown','paid_date','bene_not_entitled','patient_reach_max','svc_during_postop','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','pid','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','ln_record_type','clean_service_from','clean_service_to','clean_paid_date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,SRecord_Fields.InValidMessage_claim_num(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_claim_rec_type(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_line_number(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_service_from(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_service_to(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_place_service(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_cpt_code(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_proc_qual(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_proc_mod1(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_proc_mod2(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_proc_mod3(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_proc_mod4(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_line_charge(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_line_allowed(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_units(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_revenue_code(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_diag_code1(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_diag_code2(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_diag_code3(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_diag_code4(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_diag_code5(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_diag_code6(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_diag_code7(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_diag_code8(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_ndc(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_ambulance_to_hosp(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_emergency(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_tooth_surface(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_oral_cavity(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_service_type(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_copay(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_paid_amount(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_paid_date(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_bene_not_entitled(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_patient_reach_max(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_svc_during_postop(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_adjudicated_proc(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_adjudicated_proc_qual(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_adjudicated_proc_mod1(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_adjudicated_proc_mod2(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_adjudicated_proc_mod3(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_adjudicated_proc_mod4(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_pid(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_src(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_ln_record_type(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_clean_service_from(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_clean_service_to(TotalErrors.ErrorNum),SRecord_Fields.InValidMessage_clean_paid_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
