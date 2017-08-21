IMPORT ut,SALT31;
EXPORT HX_hygiene(dataset(HX_layout_HX) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_claim_type_pcnt := AVE(GROUP,IF(h.claim_type = (TYPEOF(h.claim_type))'',0,100));
    maxlength_claim_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_type)));
    avelength_claim_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_type)),h.claim_type<>(typeof(h.claim_type))'');
    populated_claim_num_pcnt := AVE(GROUP,IF(h.claim_num = (TYPEOF(h.claim_num))'',0,100));
    maxlength_claim_num := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_num)));
    avelength_claim_num := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_num)),h.claim_num<>(typeof(h.claim_num))'');
    populated_attend_prov_id_pcnt := AVE(GROUP,IF(h.attend_prov_id = (TYPEOF(h.attend_prov_id))'',0,100));
    maxlength_attend_prov_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.attend_prov_id)));
    avelength_attend_prov_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.attend_prov_id)),h.attend_prov_id<>(typeof(h.attend_prov_id))'');
    populated_attend_prov_name_pcnt := AVE(GROUP,IF(h.attend_prov_name = (TYPEOF(h.attend_prov_name))'',0,100));
    maxlength_attend_prov_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.attend_prov_name)));
    avelength_attend_prov_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.attend_prov_name)),h.attend_prov_name<>(typeof(h.attend_prov_name))'');
    populated_billing_addr_pcnt := AVE(GROUP,IF(h.billing_addr = (TYPEOF(h.billing_addr))'',0,100));
    maxlength_billing_addr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_addr)));
    avelength_billing_addr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_addr)),h.billing_addr<>(typeof(h.billing_addr))'');
    populated_billing_city_pcnt := AVE(GROUP,IF(h.billing_city = (TYPEOF(h.billing_city))'',0,100));
    maxlength_billing_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_city)));
    avelength_billing_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_city)),h.billing_city<>(typeof(h.billing_city))'');
    populated_billing_npi_pcnt := AVE(GROUP,IF(h.billing_npi = (TYPEOF(h.billing_npi))'',0,100));
    maxlength_billing_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_npi)));
    avelength_billing_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_npi)),h.billing_npi<>(typeof(h.billing_npi))'');
    populated_billing_org_name_pcnt := AVE(GROUP,IF(h.billing_org_name = (TYPEOF(h.billing_org_name))'',0,100));
    maxlength_billing_org_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_org_name)));
    avelength_billing_org_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_org_name)),h.billing_org_name<>(typeof(h.billing_org_name))'');
    populated_billing_state_pcnt := AVE(GROUP,IF(h.billing_state = (TYPEOF(h.billing_state))'',0,100));
    maxlength_billing_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_state)));
    avelength_billing_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_state)),h.billing_state<>(typeof(h.billing_state))'');
    populated_billing_tax_id_pcnt := AVE(GROUP,IF(h.billing_tax_id = (TYPEOF(h.billing_tax_id))'',0,100));
    maxlength_billing_tax_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_tax_id)));
    avelength_billing_tax_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_tax_id)),h.billing_tax_id<>(typeof(h.billing_tax_id))'');
    populated_billing_zip_pcnt := AVE(GROUP,IF(h.billing_zip = (TYPEOF(h.billing_zip))'',0,100));
    maxlength_billing_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_zip)));
    avelength_billing_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_zip)),h.billing_zip<>(typeof(h.billing_zip))'');
    populated_ext_injury_diag_code_pcnt := AVE(GROUP,IF(h.ext_injury_diag_code = (TYPEOF(h.ext_injury_diag_code))'',0,100));
    maxlength_ext_injury_diag_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ext_injury_diag_code)));
    avelength_ext_injury_diag_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ext_injury_diag_code)),h.ext_injury_diag_code<>(typeof(h.ext_injury_diag_code))'');
    populated_inpatient_proc1_pcnt := AVE(GROUP,IF(h.inpatient_proc1 = (TYPEOF(h.inpatient_proc1))'',0,100));
    maxlength_inpatient_proc1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.inpatient_proc1)));
    avelength_inpatient_proc1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.inpatient_proc1)),h.inpatient_proc1<>(typeof(h.inpatient_proc1))'');
    populated_inpatient_proc2_pcnt := AVE(GROUP,IF(h.inpatient_proc2 = (TYPEOF(h.inpatient_proc2))'',0,100));
    maxlength_inpatient_proc2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.inpatient_proc2)));
    avelength_inpatient_proc2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.inpatient_proc2)),h.inpatient_proc2<>(typeof(h.inpatient_proc2))'');
    populated_inpatient_proc3_pcnt := AVE(GROUP,IF(h.inpatient_proc3 = (TYPEOF(h.inpatient_proc3))'',0,100));
    maxlength_inpatient_proc3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.inpatient_proc3)));
    avelength_inpatient_proc3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.inpatient_proc3)),h.inpatient_proc3<>(typeof(h.inpatient_proc3))'');
    populated_operating_prov_id_pcnt := AVE(GROUP,IF(h.operating_prov_id = (TYPEOF(h.operating_prov_id))'',0,100));
    maxlength_operating_prov_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_id)));
    avelength_operating_prov_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_id)),h.operating_prov_id<>(typeof(h.operating_prov_id))'');
    populated_operating_prov_name_pcnt := AVE(GROUP,IF(h.operating_prov_name = (TYPEOF(h.operating_prov_name))'',0,100));
    maxlength_operating_prov_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_name)));
    avelength_operating_prov_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_name)),h.operating_prov_name<>(typeof(h.operating_prov_name))'');
    populated_other_diag1_pcnt := AVE(GROUP,IF(h.other_diag1 = (TYPEOF(h.other_diag1))'',0,100));
    maxlength_other_diag1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag1)));
    avelength_other_diag1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag1)),h.other_diag1<>(typeof(h.other_diag1))'');
    populated_other_diag2_pcnt := AVE(GROUP,IF(h.other_diag2 = (TYPEOF(h.other_diag2))'',0,100));
    maxlength_other_diag2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag2)));
    avelength_other_diag2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag2)),h.other_diag2<>(typeof(h.other_diag2))'');
    populated_other_diag3_pcnt := AVE(GROUP,IF(h.other_diag3 = (TYPEOF(h.other_diag3))'',0,100));
    maxlength_other_diag3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag3)));
    avelength_other_diag3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag3)),h.other_diag3<>(typeof(h.other_diag3))'');
    populated_other_diag4_pcnt := AVE(GROUP,IF(h.other_diag4 = (TYPEOF(h.other_diag4))'',0,100));
    maxlength_other_diag4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag4)));
    avelength_other_diag4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag4)),h.other_diag4<>(typeof(h.other_diag4))'');
    populated_other_diag5_pcnt := AVE(GROUP,IF(h.other_diag5 = (TYPEOF(h.other_diag5))'',0,100));
    maxlength_other_diag5 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag5)));
    avelength_other_diag5 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag5)),h.other_diag5<>(typeof(h.other_diag5))'');
    populated_other_diag6_pcnt := AVE(GROUP,IF(h.other_diag6 = (TYPEOF(h.other_diag6))'',0,100));
    maxlength_other_diag6 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag6)));
    avelength_other_diag6 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag6)),h.other_diag6<>(typeof(h.other_diag6))'');
    populated_other_diag7_pcnt := AVE(GROUP,IF(h.other_diag7 = (TYPEOF(h.other_diag7))'',0,100));
    maxlength_other_diag7 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag7)));
    avelength_other_diag7 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag7)),h.other_diag7<>(typeof(h.other_diag7))'');
    populated_other_diag8_pcnt := AVE(GROUP,IF(h.other_diag8 = (TYPEOF(h.other_diag8))'',0,100));
    maxlength_other_diag8 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag8)));
    avelength_other_diag8 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_diag8)),h.other_diag8<>(typeof(h.other_diag8))'');
    populated_other_proc1_pcnt := AVE(GROUP,IF(h.other_proc1 = (TYPEOF(h.other_proc1))'',0,100));
    maxlength_other_proc1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc1)));
    avelength_other_proc1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc1)),h.other_proc1<>(typeof(h.other_proc1))'');
    populated_other_proc2_pcnt := AVE(GROUP,IF(h.other_proc2 = (TYPEOF(h.other_proc2))'',0,100));
    maxlength_other_proc2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc2)));
    avelength_other_proc2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc2)),h.other_proc2<>(typeof(h.other_proc2))'');
    populated_other_proc3_pcnt := AVE(GROUP,IF(h.other_proc3 = (TYPEOF(h.other_proc3))'',0,100));
    maxlength_other_proc3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc3)));
    avelength_other_proc3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc3)),h.other_proc3<>(typeof(h.other_proc3))'');
    populated_other_proc4_pcnt := AVE(GROUP,IF(h.other_proc4 = (TYPEOF(h.other_proc4))'',0,100));
    maxlength_other_proc4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc4)));
    avelength_other_proc4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc4)),h.other_proc4<>(typeof(h.other_proc4))'');
    populated_other_proc5_pcnt := AVE(GROUP,IF(h.other_proc5 = (TYPEOF(h.other_proc5))'',0,100));
    maxlength_other_proc5 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc5)));
    avelength_other_proc5 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc5)),h.other_proc5<>(typeof(h.other_proc5))'');
    populated_other_proc_method_code_pcnt := AVE(GROUP,IF(h.other_proc_method_code = (TYPEOF(h.other_proc_method_code))'',0,100));
    maxlength_other_proc_method_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc_method_code)));
    avelength_other_proc_method_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc_method_code)),h.other_proc_method_code<>(typeof(h.other_proc_method_code))'');
    populated_other_prov_id1_pcnt := AVE(GROUP,IF(h.other_prov_id1 = (TYPEOF(h.other_prov_id1))'',0,100));
    maxlength_other_prov_id1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_prov_id1)));
    avelength_other_prov_id1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_prov_id1)),h.other_prov_id1<>(typeof(h.other_prov_id1))'');
    populated_other_prov_id2_pcnt := AVE(GROUP,IF(h.other_prov_id2 = (TYPEOF(h.other_prov_id2))'',0,100));
    maxlength_other_prov_id2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_prov_id2)));
    avelength_other_prov_id2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_prov_id2)),h.other_prov_id2<>(typeof(h.other_prov_id2))'');
    populated_other_prov_name1_pcnt := AVE(GROUP,IF(h.other_prov_name1 = (TYPEOF(h.other_prov_name1))'',0,100));
    maxlength_other_prov_name1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_prov_name1)));
    avelength_other_prov_name1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_prov_name1)),h.other_prov_name1<>(typeof(h.other_prov_name1))'');
    populated_other_prov_name2_pcnt := AVE(GROUP,IF(h.other_prov_name2 = (TYPEOF(h.other_prov_name2))'',0,100));
    maxlength_other_prov_name2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_prov_name2)));
    avelength_other_prov_name2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_prov_name2)),h.other_prov_name2<>(typeof(h.other_prov_name2))'');
    populated_outpatient_proc1_pcnt := AVE(GROUP,IF(h.outpatient_proc1 = (TYPEOF(h.outpatient_proc1))'',0,100));
    maxlength_outpatient_proc1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.outpatient_proc1)));
    avelength_outpatient_proc1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.outpatient_proc1)),h.outpatient_proc1<>(typeof(h.outpatient_proc1))'');
    populated_outpatient_proc2_pcnt := AVE(GROUP,IF(h.outpatient_proc2 = (TYPEOF(h.outpatient_proc2))'',0,100));
    maxlength_outpatient_proc2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.outpatient_proc2)));
    avelength_outpatient_proc2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.outpatient_proc2)),h.outpatient_proc2<>(typeof(h.outpatient_proc2))'');
    populated_outpatient_proc3_pcnt := AVE(GROUP,IF(h.outpatient_proc3 = (TYPEOF(h.outpatient_proc3))'',0,100));
    maxlength_outpatient_proc3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.outpatient_proc3)));
    avelength_outpatient_proc3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.outpatient_proc3)),h.outpatient_proc3<>(typeof(h.outpatient_proc3))'');
    populated_principle_diag_pcnt := AVE(GROUP,IF(h.principle_diag = (TYPEOF(h.principle_diag))'',0,100));
    maxlength_principle_diag := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.principle_diag)));
    avelength_principle_diag := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.principle_diag)),h.principle_diag<>(typeof(h.principle_diag))'');
    populated_principle_proc_pcnt := AVE(GROUP,IF(h.principle_proc = (TYPEOF(h.principle_proc))'',0,100));
    maxlength_principle_proc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.principle_proc)));
    avelength_principle_proc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.principle_proc)),h.principle_proc<>(typeof(h.principle_proc))'');
    populated_service_from_pcnt := AVE(GROUP,IF(h.service_from = (TYPEOF(h.service_from))'',0,100));
    maxlength_service_from := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_from)));
    avelength_service_from := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_from)),h.service_from<>(typeof(h.service_from))'');
    populated_service_line_pcnt := AVE(GROUP,IF(h.service_line = (TYPEOF(h.service_line))'',0,100));
    maxlength_service_line := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_line)));
    avelength_service_line := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_line)),h.service_line<>(typeof(h.service_line))'');
    populated_service_to_pcnt := AVE(GROUP,IF(h.service_to = (TYPEOF(h.service_to))'',0,100));
    maxlength_service_to := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_to)));
    avelength_service_to := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.service_to)),h.service_to<>(typeof(h.service_to))'');
    populated_submitted_date_pcnt := AVE(GROUP,IF(h.submitted_date = (TYPEOF(h.submitted_date))'',0,100));
    maxlength_submitted_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.submitted_date)));
    avelength_submitted_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.submitted_date)),h.submitted_date<>(typeof(h.submitted_date))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_claim_type_pcnt *   0.00 / 100 + T.Populated_claim_num_pcnt *   0.00 / 100 + T.Populated_attend_prov_id_pcnt *   0.00 / 100 + T.Populated_attend_prov_name_pcnt *   0.00 / 100 + T.Populated_billing_addr_pcnt *   0.00 / 100 + T.Populated_billing_city_pcnt *   0.00 / 100 + T.Populated_billing_npi_pcnt *   0.00 / 100 + T.Populated_billing_org_name_pcnt *   0.00 / 100 + T.Populated_billing_state_pcnt *   0.00 / 100 + T.Populated_billing_tax_id_pcnt *   0.00 / 100 + T.Populated_billing_zip_pcnt *   0.00 / 100 + T.Populated_ext_injury_diag_code_pcnt *   0.00 / 100 + T.Populated_inpatient_proc1_pcnt *   0.00 / 100 + T.Populated_inpatient_proc2_pcnt *   0.00 / 100 + T.Populated_inpatient_proc3_pcnt *   0.00 / 100 + T.Populated_operating_prov_id_pcnt *   0.00 / 100 + T.Populated_operating_prov_name_pcnt *   0.00 / 100 + T.Populated_other_diag1_pcnt *   0.00 / 100 + T.Populated_other_diag2_pcnt *   0.00 / 100 + T.Populated_other_diag3_pcnt *   0.00 / 100 + T.Populated_other_diag4_pcnt *   0.00 / 100 + T.Populated_other_diag5_pcnt *   0.00 / 100 + T.Populated_other_diag6_pcnt *   0.00 / 100 + T.Populated_other_diag7_pcnt *   0.00 / 100 + T.Populated_other_diag8_pcnt *   0.00 / 100 + T.Populated_other_proc1_pcnt *   0.00 / 100 + T.Populated_other_proc2_pcnt *   0.00 / 100 + T.Populated_other_proc3_pcnt *   0.00 / 100 + T.Populated_other_proc4_pcnt *   0.00 / 100 + T.Populated_other_proc5_pcnt *   0.00 / 100 + T.Populated_other_proc_method_code_pcnt *   0.00 / 100 + T.Populated_other_prov_id1_pcnt *   0.00 / 100 + T.Populated_other_prov_id2_pcnt *   0.00 / 100 + T.Populated_other_prov_name1_pcnt *   0.00 / 100 + T.Populated_other_prov_name2_pcnt *   0.00 / 100 + T.Populated_outpatient_proc1_pcnt *   0.00 / 100 + T.Populated_outpatient_proc2_pcnt *   0.00 / 100 + T.Populated_outpatient_proc3_pcnt *   0.00 / 100 + T.Populated_principle_diag_pcnt *   0.00 / 100 + T.Populated_principle_proc_pcnt *   0.00 / 100 + T.Populated_service_from_pcnt *   0.00 / 100 + T.Populated_service_line_pcnt *   0.00 / 100 + T.Populated_service_to_pcnt *   0.00 / 100 + T.Populated_submitted_date_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'claim_type','claim_num','attend_prov_id','attend_prov_name','billing_addr','billing_city','billing_npi','billing_org_name','billing_state','billing_tax_id','billing_zip','ext_injury_diag_code','inpatient_proc1','inpatient_proc2','inpatient_proc3','operating_prov_id','operating_prov_name','other_diag1','other_diag2','other_diag3','other_diag4','other_diag5','other_diag6','other_diag7','other_diag8','other_proc1','other_proc2','other_proc3','other_proc4','other_proc5','other_proc_method_code','other_prov_id1','other_prov_id2','other_prov_name1','other_prov_name2','outpatient_proc1','outpatient_proc2','outpatient_proc3','principle_diag','principle_proc','service_from','service_line','service_to','submitted_date');
  SELF.populated_pcnt := CHOOSE(C,le.populated_claim_type_pcnt,le.populated_claim_num_pcnt,le.populated_attend_prov_id_pcnt,le.populated_attend_prov_name_pcnt,le.populated_billing_addr_pcnt,le.populated_billing_city_pcnt,le.populated_billing_npi_pcnt,le.populated_billing_org_name_pcnt,le.populated_billing_state_pcnt,le.populated_billing_tax_id_pcnt,le.populated_billing_zip_pcnt,le.populated_ext_injury_diag_code_pcnt,le.populated_inpatient_proc1_pcnt,le.populated_inpatient_proc2_pcnt,le.populated_inpatient_proc3_pcnt,le.populated_operating_prov_id_pcnt,le.populated_operating_prov_name_pcnt,le.populated_other_diag1_pcnt,le.populated_other_diag2_pcnt,le.populated_other_diag3_pcnt,le.populated_other_diag4_pcnt,le.populated_other_diag5_pcnt,le.populated_other_diag6_pcnt,le.populated_other_diag7_pcnt,le.populated_other_diag8_pcnt,le.populated_other_proc1_pcnt,le.populated_other_proc2_pcnt,le.populated_other_proc3_pcnt,le.populated_other_proc4_pcnt,le.populated_other_proc5_pcnt,le.populated_other_proc_method_code_pcnt,le.populated_other_prov_id1_pcnt,le.populated_other_prov_id2_pcnt,le.populated_other_prov_name1_pcnt,le.populated_other_prov_name2_pcnt,le.populated_outpatient_proc1_pcnt,le.populated_outpatient_proc2_pcnt,le.populated_outpatient_proc3_pcnt,le.populated_principle_diag_pcnt,le.populated_principle_proc_pcnt,le.populated_service_from_pcnt,le.populated_service_line_pcnt,le.populated_service_to_pcnt,le.populated_submitted_date_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_claim_type,le.maxlength_claim_num,le.maxlength_attend_prov_id,le.maxlength_attend_prov_name,le.maxlength_billing_addr,le.maxlength_billing_city,le.maxlength_billing_npi,le.maxlength_billing_org_name,le.maxlength_billing_state,le.maxlength_billing_tax_id,le.maxlength_billing_zip,le.maxlength_ext_injury_diag_code,le.maxlength_inpatient_proc1,le.maxlength_inpatient_proc2,le.maxlength_inpatient_proc3,le.maxlength_operating_prov_id,le.maxlength_operating_prov_name,le.maxlength_other_diag1,le.maxlength_other_diag2,le.maxlength_other_diag3,le.maxlength_other_diag4,le.maxlength_other_diag5,le.maxlength_other_diag6,le.maxlength_other_diag7,le.maxlength_other_diag8,le.maxlength_other_proc1,le.maxlength_other_proc2,le.maxlength_other_proc3,le.maxlength_other_proc4,le.maxlength_other_proc5,le.maxlength_other_proc_method_code,le.maxlength_other_prov_id1,le.maxlength_other_prov_id2,le.maxlength_other_prov_name1,le.maxlength_other_prov_name2,le.maxlength_outpatient_proc1,le.maxlength_outpatient_proc2,le.maxlength_outpatient_proc3,le.maxlength_principle_diag,le.maxlength_principle_proc,le.maxlength_service_from,le.maxlength_service_line,le.maxlength_service_to,le.maxlength_submitted_date);
  SELF.avelength := CHOOSE(C,le.avelength_claim_type,le.avelength_claim_num,le.avelength_attend_prov_id,le.avelength_attend_prov_name,le.avelength_billing_addr,le.avelength_billing_city,le.avelength_billing_npi,le.avelength_billing_org_name,le.avelength_billing_state,le.avelength_billing_tax_id,le.avelength_billing_zip,le.avelength_ext_injury_diag_code,le.avelength_inpatient_proc1,le.avelength_inpatient_proc2,le.avelength_inpatient_proc3,le.avelength_operating_prov_id,le.avelength_operating_prov_name,le.avelength_other_diag1,le.avelength_other_diag2,le.avelength_other_diag3,le.avelength_other_diag4,le.avelength_other_diag5,le.avelength_other_diag6,le.avelength_other_diag7,le.avelength_other_diag8,le.avelength_other_proc1,le.avelength_other_proc2,le.avelength_other_proc3,le.avelength_other_proc4,le.avelength_other_proc5,le.avelength_other_proc_method_code,le.avelength_other_prov_id1,le.avelength_other_prov_id2,le.avelength_other_prov_name1,le.avelength_other_prov_name2,le.avelength_outpatient_proc1,le.avelength_outpatient_proc2,le.avelength_outpatient_proc3,le.avelength_principle_diag,le.avelength_principle_proc,le.avelength_service_from,le.avelength_service_line,le.avelength_service_to,le.avelength_submitted_date);
END;
EXPORT invSummary := NORMALIZE(summary0, 44, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.claim_type),TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.attend_prov_id),TRIM((SALT31.StrType)le.attend_prov_name),TRIM((SALT31.StrType)le.billing_addr),TRIM((SALT31.StrType)le.billing_city),TRIM((SALT31.StrType)le.billing_npi),TRIM((SALT31.StrType)le.billing_org_name),TRIM((SALT31.StrType)le.billing_state),TRIM((SALT31.StrType)le.billing_tax_id),TRIM((SALT31.StrType)le.billing_zip),TRIM((SALT31.StrType)le.ext_injury_diag_code),TRIM((SALT31.StrType)le.inpatient_proc1),TRIM((SALT31.StrType)le.inpatient_proc2),TRIM((SALT31.StrType)le.inpatient_proc3),TRIM((SALT31.StrType)le.operating_prov_id),TRIM((SALT31.StrType)le.operating_prov_name),TRIM((SALT31.StrType)le.other_diag1),TRIM((SALT31.StrType)le.other_diag2),TRIM((SALT31.StrType)le.other_diag3),TRIM((SALT31.StrType)le.other_diag4),TRIM((SALT31.StrType)le.other_diag5),TRIM((SALT31.StrType)le.other_diag6),TRIM((SALT31.StrType)le.other_diag7),TRIM((SALT31.StrType)le.other_diag8),TRIM((SALT31.StrType)le.other_proc1),TRIM((SALT31.StrType)le.other_proc2),TRIM((SALT31.StrType)le.other_proc3),TRIM((SALT31.StrType)le.other_proc4),TRIM((SALT31.StrType)le.other_proc5),TRIM((SALT31.StrType)le.other_proc_method_code),TRIM((SALT31.StrType)le.other_prov_id1),TRIM((SALT31.StrType)le.other_prov_id2),TRIM((SALT31.StrType)le.other_prov_name1),TRIM((SALT31.StrType)le.other_prov_name2),TRIM((SALT31.StrType)le.outpatient_proc1),TRIM((SALT31.StrType)le.outpatient_proc2),TRIM((SALT31.StrType)le.outpatient_proc3),TRIM((SALT31.StrType)le.principle_diag),TRIM((SALT31.StrType)le.principle_proc),TRIM((SALT31.StrType)le.service_from),TRIM((SALT31.StrType)le.service_line),TRIM((SALT31.StrType)le.service_to),TRIM((SALT31.StrType)le.submitted_date)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,44,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 44);
  SELF.FldNo2 := 1 + (C % 44);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.claim_type),TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.attend_prov_id),TRIM((SALT31.StrType)le.attend_prov_name),TRIM((SALT31.StrType)le.billing_addr),TRIM((SALT31.StrType)le.billing_city),TRIM((SALT31.StrType)le.billing_npi),TRIM((SALT31.StrType)le.billing_org_name),TRIM((SALT31.StrType)le.billing_state),TRIM((SALT31.StrType)le.billing_tax_id),TRIM((SALT31.StrType)le.billing_zip),TRIM((SALT31.StrType)le.ext_injury_diag_code),TRIM((SALT31.StrType)le.inpatient_proc1),TRIM((SALT31.StrType)le.inpatient_proc2),TRIM((SALT31.StrType)le.inpatient_proc3),TRIM((SALT31.StrType)le.operating_prov_id),TRIM((SALT31.StrType)le.operating_prov_name),TRIM((SALT31.StrType)le.other_diag1),TRIM((SALT31.StrType)le.other_diag2),TRIM((SALT31.StrType)le.other_diag3),TRIM((SALT31.StrType)le.other_diag4),TRIM((SALT31.StrType)le.other_diag5),TRIM((SALT31.StrType)le.other_diag6),TRIM((SALT31.StrType)le.other_diag7),TRIM((SALT31.StrType)le.other_diag8),TRIM((SALT31.StrType)le.other_proc1),TRIM((SALT31.StrType)le.other_proc2),TRIM((SALT31.StrType)le.other_proc3),TRIM((SALT31.StrType)le.other_proc4),TRIM((SALT31.StrType)le.other_proc5),TRIM((SALT31.StrType)le.other_proc_method_code),TRIM((SALT31.StrType)le.other_prov_id1),TRIM((SALT31.StrType)le.other_prov_id2),TRIM((SALT31.StrType)le.other_prov_name1),TRIM((SALT31.StrType)le.other_prov_name2),TRIM((SALT31.StrType)le.outpatient_proc1),TRIM((SALT31.StrType)le.outpatient_proc2),TRIM((SALT31.StrType)le.outpatient_proc3),TRIM((SALT31.StrType)le.principle_diag),TRIM((SALT31.StrType)le.principle_proc),TRIM((SALT31.StrType)le.service_from),TRIM((SALT31.StrType)le.service_line),TRIM((SALT31.StrType)le.service_to),TRIM((SALT31.StrType)le.submitted_date)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.claim_type),TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.attend_prov_id),TRIM((SALT31.StrType)le.attend_prov_name),TRIM((SALT31.StrType)le.billing_addr),TRIM((SALT31.StrType)le.billing_city),TRIM((SALT31.StrType)le.billing_npi),TRIM((SALT31.StrType)le.billing_org_name),TRIM((SALT31.StrType)le.billing_state),TRIM((SALT31.StrType)le.billing_tax_id),TRIM((SALT31.StrType)le.billing_zip),TRIM((SALT31.StrType)le.ext_injury_diag_code),TRIM((SALT31.StrType)le.inpatient_proc1),TRIM((SALT31.StrType)le.inpatient_proc2),TRIM((SALT31.StrType)le.inpatient_proc3),TRIM((SALT31.StrType)le.operating_prov_id),TRIM((SALT31.StrType)le.operating_prov_name),TRIM((SALT31.StrType)le.other_diag1),TRIM((SALT31.StrType)le.other_diag2),TRIM((SALT31.StrType)le.other_diag3),TRIM((SALT31.StrType)le.other_diag4),TRIM((SALT31.StrType)le.other_diag5),TRIM((SALT31.StrType)le.other_diag6),TRIM((SALT31.StrType)le.other_diag7),TRIM((SALT31.StrType)le.other_diag8),TRIM((SALT31.StrType)le.other_proc1),TRIM((SALT31.StrType)le.other_proc2),TRIM((SALT31.StrType)le.other_proc3),TRIM((SALT31.StrType)le.other_proc4),TRIM((SALT31.StrType)le.other_proc5),TRIM((SALT31.StrType)le.other_proc_method_code),TRIM((SALT31.StrType)le.other_prov_id1),TRIM((SALT31.StrType)le.other_prov_id2),TRIM((SALT31.StrType)le.other_prov_name1),TRIM((SALT31.StrType)le.other_prov_name2),TRIM((SALT31.StrType)le.outpatient_proc1),TRIM((SALT31.StrType)le.outpatient_proc2),TRIM((SALT31.StrType)le.outpatient_proc3),TRIM((SALT31.StrType)le.principle_diag),TRIM((SALT31.StrType)le.principle_proc),TRIM((SALT31.StrType)le.service_from),TRIM((SALT31.StrType)le.service_line),TRIM((SALT31.StrType)le.service_to),TRIM((SALT31.StrType)le.submitted_date)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),44*44,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'claim_type'}
      ,{2,'claim_num'}
      ,{3,'attend_prov_id'}
      ,{4,'attend_prov_name'}
      ,{5,'billing_addr'}
      ,{6,'billing_city'}
      ,{7,'billing_npi'}
      ,{8,'billing_org_name'}
      ,{9,'billing_state'}
      ,{10,'billing_tax_id'}
      ,{11,'billing_zip'}
      ,{12,'ext_injury_diag_code'}
      ,{13,'inpatient_proc1'}
      ,{14,'inpatient_proc2'}
      ,{15,'inpatient_proc3'}
      ,{16,'operating_prov_id'}
      ,{17,'operating_prov_name'}
      ,{18,'other_diag1'}
      ,{19,'other_diag2'}
      ,{20,'other_diag3'}
      ,{21,'other_diag4'}
      ,{22,'other_diag5'}
      ,{23,'other_diag6'}
      ,{24,'other_diag7'}
      ,{25,'other_diag8'}
      ,{26,'other_proc1'}
      ,{27,'other_proc2'}
      ,{28,'other_proc3'}
      ,{29,'other_proc4'}
      ,{30,'other_proc5'}
      ,{31,'other_proc_method_code'}
      ,{32,'other_prov_id1'}
      ,{33,'other_prov_id2'}
      ,{34,'other_prov_name1'}
      ,{35,'other_prov_name2'}
      ,{36,'outpatient_proc1'}
      ,{37,'outpatient_proc2'}
      ,{38,'outpatient_proc3'}
      ,{39,'principle_diag'}
      ,{40,'principle_proc'}
      ,{41,'service_from'}
      ,{42,'service_line'}
      ,{43,'service_to'}
      ,{44,'submitted_date'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    HX_Fields.InValid_claim_type((SALT31.StrType)le.claim_type),
    HX_Fields.InValid_claim_num((SALT31.StrType)le.claim_num),
    HX_Fields.InValid_attend_prov_id((SALT31.StrType)le.attend_prov_id),
    HX_Fields.InValid_attend_prov_name((SALT31.StrType)le.attend_prov_name),
    HX_Fields.InValid_billing_addr((SALT31.StrType)le.billing_addr),
    HX_Fields.InValid_billing_city((SALT31.StrType)le.billing_city),
    HX_Fields.InValid_billing_npi((SALT31.StrType)le.billing_npi),
    HX_Fields.InValid_billing_org_name((SALT31.StrType)le.billing_org_name),
    HX_Fields.InValid_billing_state((SALT31.StrType)le.billing_state),
    HX_Fields.InValid_billing_tax_id((SALT31.StrType)le.billing_tax_id),
    HX_Fields.InValid_billing_zip((SALT31.StrType)le.billing_zip),
    HX_Fields.InValid_ext_injury_diag_code((SALT31.StrType)le.ext_injury_diag_code),
    HX_Fields.InValid_inpatient_proc1((SALT31.StrType)le.inpatient_proc1),
    HX_Fields.InValid_inpatient_proc2((SALT31.StrType)le.inpatient_proc2),
    HX_Fields.InValid_inpatient_proc3((SALT31.StrType)le.inpatient_proc3),
    HX_Fields.InValid_operating_prov_id((SALT31.StrType)le.operating_prov_id),
    HX_Fields.InValid_operating_prov_name((SALT31.StrType)le.operating_prov_name),
    HX_Fields.InValid_other_diag1((SALT31.StrType)le.other_diag1),
    HX_Fields.InValid_other_diag2((SALT31.StrType)le.other_diag2),
    HX_Fields.InValid_other_diag3((SALT31.StrType)le.other_diag3),
    HX_Fields.InValid_other_diag4((SALT31.StrType)le.other_diag4),
    HX_Fields.InValid_other_diag5((SALT31.StrType)le.other_diag5),
    HX_Fields.InValid_other_diag6((SALT31.StrType)le.other_diag6),
    HX_Fields.InValid_other_diag7((SALT31.StrType)le.other_diag7),
    HX_Fields.InValid_other_diag8((SALT31.StrType)le.other_diag8),
    HX_Fields.InValid_other_proc1((SALT31.StrType)le.other_proc1),
    HX_Fields.InValid_other_proc2((SALT31.StrType)le.other_proc2),
    HX_Fields.InValid_other_proc3((SALT31.StrType)le.other_proc3),
    HX_Fields.InValid_other_proc4((SALT31.StrType)le.other_proc4),
    HX_Fields.InValid_other_proc5((SALT31.StrType)le.other_proc5),
    HX_Fields.InValid_other_proc_method_code((SALT31.StrType)le.other_proc_method_code),
    HX_Fields.InValid_other_prov_id1((SALT31.StrType)le.other_prov_id1),
    HX_Fields.InValid_other_prov_id2((SALT31.StrType)le.other_prov_id2),
    HX_Fields.InValid_other_prov_name1((SALT31.StrType)le.other_prov_name1),
    HX_Fields.InValid_other_prov_name2((SALT31.StrType)le.other_prov_name2),
    HX_Fields.InValid_outpatient_proc1((SALT31.StrType)le.outpatient_proc1),
    HX_Fields.InValid_outpatient_proc2((SALT31.StrType)le.outpatient_proc2),
    HX_Fields.InValid_outpatient_proc3((SALT31.StrType)le.outpatient_proc3),
    HX_Fields.InValid_principle_diag((SALT31.StrType)le.principle_diag),
    HX_Fields.InValid_principle_proc((SALT31.StrType)le.principle_proc),
    HX_Fields.InValid_service_from((SALT31.StrType)le.service_from),
    HX_Fields.InValid_service_line((SALT31.StrType)le.service_line),
    HX_Fields.InValid_service_to((SALT31.StrType)le.service_to),
    HX_Fields.InValid_submitted_date((SALT31.StrType)le.submitted_date),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,44,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := HX_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'claim_type','claim_num','attend_prov_id','attend_prov_name','billing_addr','billing_city','billing_npi','billing_org_name','billing_state','billing_tax_id','billing_zip','Unknown','inpatient_proc1','inpatient_proc2','inpatient_proc3','operating_prov_id','operating_prov_name','other_diag1','other_diag2','other_diag3','other_diag4','other_diag5','other_diag6','other_diag7','other_diag8','other_proc1','other_proc2','other_proc3','other_proc4','other_proc5','other_proc_method_code','other_prov_id1','Unknown','other_prov_name1','Unknown','outpatient_proc1','outpatient_proc2','outpatient_proc3','principle_diag','principle_proc','service_from','service_line','service_to','submitted_date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,HX_Fields.InValidMessage_claim_type(TotalErrors.ErrorNum),HX_Fields.InValidMessage_claim_num(TotalErrors.ErrorNum),HX_Fields.InValidMessage_attend_prov_id(TotalErrors.ErrorNum),HX_Fields.InValidMessage_attend_prov_name(TotalErrors.ErrorNum),HX_Fields.InValidMessage_billing_addr(TotalErrors.ErrorNum),HX_Fields.InValidMessage_billing_city(TotalErrors.ErrorNum),HX_Fields.InValidMessage_billing_npi(TotalErrors.ErrorNum),HX_Fields.InValidMessage_billing_org_name(TotalErrors.ErrorNum),HX_Fields.InValidMessage_billing_state(TotalErrors.ErrorNum),HX_Fields.InValidMessage_billing_tax_id(TotalErrors.ErrorNum),HX_Fields.InValidMessage_billing_zip(TotalErrors.ErrorNum),HX_Fields.InValidMessage_ext_injury_diag_code(TotalErrors.ErrorNum),HX_Fields.InValidMessage_inpatient_proc1(TotalErrors.ErrorNum),HX_Fields.InValidMessage_inpatient_proc2(TotalErrors.ErrorNum),HX_Fields.InValidMessage_inpatient_proc3(TotalErrors.ErrorNum),HX_Fields.InValidMessage_operating_prov_id(TotalErrors.ErrorNum),HX_Fields.InValidMessage_operating_prov_name(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_diag1(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_diag2(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_diag3(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_diag4(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_diag5(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_diag6(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_diag7(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_diag8(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_proc1(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_proc2(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_proc3(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_proc4(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_proc5(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_proc_method_code(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_prov_id1(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_prov_id2(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_prov_name1(TotalErrors.ErrorNum),HX_Fields.InValidMessage_other_prov_name2(TotalErrors.ErrorNum),HX_Fields.InValidMessage_outpatient_proc1(TotalErrors.ErrorNum),HX_Fields.InValidMessage_outpatient_proc2(TotalErrors.ErrorNum),HX_Fields.InValidMessage_outpatient_proc3(TotalErrors.ErrorNum),HX_Fields.InValidMessage_principle_diag(TotalErrors.ErrorNum),HX_Fields.InValidMessage_principle_proc(TotalErrors.ErrorNum),HX_Fields.InValidMessage_service_from(TotalErrors.ErrorNum),HX_Fields.InValidMessage_service_line(TotalErrors.ErrorNum),HX_Fields.InValidMessage_service_to(TotalErrors.ErrorNum),HX_Fields.InValidMessage_submitted_date(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
