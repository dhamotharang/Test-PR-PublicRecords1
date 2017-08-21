IMPORT ut,SALT31;
EXPORT MX_hygiene(dataset(MX_layout_MX) h) := MODULE
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
    populated_billing_pay_to_taxonomy_pcnt := AVE(GROUP,IF(h.billing_pay_to_taxonomy = (TYPEOF(h.billing_pay_to_taxonomy))'',0,100));
    maxlength_billing_pay_to_taxonomy := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_pay_to_taxonomy)));
    avelength_billing_pay_to_taxonomy := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_pay_to_taxonomy)),h.billing_pay_to_taxonomy<>(typeof(h.billing_pay_to_taxonomy))'');
    populated_billing_addr_pcnt := AVE(GROUP,IF(h.billing_addr = (TYPEOF(h.billing_addr))'',0,100));
    maxlength_billing_addr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_addr)));
    avelength_billing_addr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_addr)),h.billing_addr<>(typeof(h.billing_addr))'');
    populated_billing_anesth_lic_pcnt := AVE(GROUP,IF(h.billing_anesth_lic = (TYPEOF(h.billing_anesth_lic))'',0,100));
    maxlength_billing_anesth_lic := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_anesth_lic)));
    avelength_billing_anesth_lic := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_anesth_lic)),h.billing_anesth_lic<>(typeof(h.billing_anesth_lic))'');
    populated_billing_city_pcnt := AVE(GROUP,IF(h.billing_city = (TYPEOF(h.billing_city))'',0,100));
    maxlength_billing_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_city)));
    avelength_billing_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_city)),h.billing_city<>(typeof(h.billing_city))'');
    populated_billing_dentist_lic_pcnt := AVE(GROUP,IF(h.billing_dentist_lic = (TYPEOF(h.billing_dentist_lic))'',0,100));
    maxlength_billing_dentist_lic := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_dentist_lic)));
    avelength_billing_dentist_lic := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_dentist_lic)),h.billing_dentist_lic<>(typeof(h.billing_dentist_lic))'');
    populated_billing_first_name_pcnt := AVE(GROUP,IF(h.billing_first_name = (TYPEOF(h.billing_first_name))'',0,100));
    maxlength_billing_first_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_first_name)));
    avelength_billing_first_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_first_name)),h.billing_first_name<>(typeof(h.billing_first_name))'');
    populated_billing_last_name_pcnt := AVE(GROUP,IF(h.billing_last_name = (TYPEOF(h.billing_last_name))'',0,100));
    maxlength_billing_last_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_last_name)));
    avelength_billing_last_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_last_name)),h.billing_last_name<>(typeof(h.billing_last_name))'');
    populated_billing_middle_name_pcnt := AVE(GROUP,IF(h.billing_middle_name = (TYPEOF(h.billing_middle_name))'',0,100));
    maxlength_billing_middle_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_middle_name)));
    avelength_billing_middle_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_middle_name)),h.billing_middle_name<>(typeof(h.billing_middle_name))'');
    populated_billing_npi_pcnt := AVE(GROUP,IF(h.billing_npi = (TYPEOF(h.billing_npi))'',0,100));
    maxlength_billing_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_npi)));
    avelength_billing_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_npi)),h.billing_npi<>(typeof(h.billing_npi))'');
    populated_billing_org_name_pcnt := AVE(GROUP,IF(h.billing_org_name = (TYPEOF(h.billing_org_name))'',0,100));
    maxlength_billing_org_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_org_name)));
    avelength_billing_org_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_org_name)),h.billing_org_name<>(typeof(h.billing_org_name))'');
    populated_billing_service_phone_pcnt := AVE(GROUP,IF(h.billing_service_phone = (TYPEOF(h.billing_service_phone))'',0,100));
    maxlength_billing_service_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_service_phone)));
    avelength_billing_service_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_service_phone)),h.billing_service_phone<>(typeof(h.billing_service_phone))'');
    populated_billing_specialty_code_pcnt := AVE(GROUP,IF(h.billing_specialty_code = (TYPEOF(h.billing_specialty_code))'',0,100));
    maxlength_billing_specialty_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_specialty_code)));
    avelength_billing_specialty_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_specialty_code)),h.billing_specialty_code<>(typeof(h.billing_specialty_code))'');
    populated_billing_specialty_lic_pcnt := AVE(GROUP,IF(h.billing_specialty_lic = (TYPEOF(h.billing_specialty_lic))'',0,100));
    maxlength_billing_specialty_lic := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_specialty_lic)));
    avelength_billing_specialty_lic := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_specialty_lic)),h.billing_specialty_lic<>(typeof(h.billing_specialty_lic))'');
    populated_billing_state_pcnt := AVE(GROUP,IF(h.billing_state = (TYPEOF(h.billing_state))'',0,100));
    maxlength_billing_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_state)));
    avelength_billing_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_state)),h.billing_state<>(typeof(h.billing_state))'');
    populated_billing_state_lic_pcnt := AVE(GROUP,IF(h.billing_state_lic = (TYPEOF(h.billing_state_lic))'',0,100));
    maxlength_billing_state_lic := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_state_lic)));
    avelength_billing_state_lic := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_state_lic)),h.billing_state_lic<>(typeof(h.billing_state_lic))'');
    populated_billing_tax_id_pcnt := AVE(GROUP,IF(h.billing_tax_id = (TYPEOF(h.billing_tax_id))'',0,100));
    maxlength_billing_tax_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_tax_id)));
    avelength_billing_tax_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_tax_id)),h.billing_tax_id<>(typeof(h.billing_tax_id))'');
    populated_billing_upin_pcnt := AVE(GROUP,IF(h.billing_upin = (TYPEOF(h.billing_upin))'',0,100));
    maxlength_billing_upin := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_upin)));
    avelength_billing_upin := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_upin)),h.billing_upin<>(typeof(h.billing_upin))'');
    populated_billing_zip_pcnt := AVE(GROUP,IF(h.billing_zip = (TYPEOF(h.billing_zip))'',0,100));
    maxlength_billing_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_zip)));
    avelength_billing_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_zip)),h.billing_zip<>(typeof(h.billing_zip))'');
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
    populated_dme_hcpcs_proc_code_pcnt := AVE(GROUP,IF(h.dme_hcpcs_proc_code = (TYPEOF(h.dme_hcpcs_proc_code))'',0,100));
    maxlength_dme_hcpcs_proc_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dme_hcpcs_proc_code)));
    avelength_dme_hcpcs_proc_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dme_hcpcs_proc_code)),h.dme_hcpcs_proc_code<>(typeof(h.dme_hcpcs_proc_code))'');
    populated_emt_paramedic_first_name_pcnt := AVE(GROUP,IF(h.emt_paramedic_first_name = (TYPEOF(h.emt_paramedic_first_name))'',0,100));
    maxlength_emt_paramedic_first_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.emt_paramedic_first_name)));
    avelength_emt_paramedic_first_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.emt_paramedic_first_name)),h.emt_paramedic_first_name<>(typeof(h.emt_paramedic_first_name))'');
    populated_emt_paramedic_last_name_pcnt := AVE(GROUP,IF(h.emt_paramedic_last_name = (TYPEOF(h.emt_paramedic_last_name))'',0,100));
    maxlength_emt_paramedic_last_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.emt_paramedic_last_name)));
    avelength_emt_paramedic_last_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.emt_paramedic_last_name)),h.emt_paramedic_last_name<>(typeof(h.emt_paramedic_last_name))'');
    populated_emt_paramedic_middle_name_pcnt := AVE(GROUP,IF(h.emt_paramedic_middle_name = (TYPEOF(h.emt_paramedic_middle_name))'',0,100));
    maxlength_emt_paramedic_middle_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.emt_paramedic_middle_name)));
    avelength_emt_paramedic_middle_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.emt_paramedic_middle_name)),h.emt_paramedic_middle_name<>(typeof(h.emt_paramedic_middle_name))'');
    populated_ext_injury_diag_code_pcnt := AVE(GROUP,IF(h.ext_injury_diag_code = (TYPEOF(h.ext_injury_diag_code))'',0,100));
    maxlength_ext_injury_diag_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ext_injury_diag_code)));
    avelength_ext_injury_diag_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ext_injury_diag_code)),h.ext_injury_diag_code<>(typeof(h.ext_injury_diag_code))'');
    populated_facility_lab_addr_pcnt := AVE(GROUP,IF(h.facility_lab_addr = (TYPEOF(h.facility_lab_addr))'',0,100));
    maxlength_facility_lab_addr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_addr)));
    avelength_facility_lab_addr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_addr)),h.facility_lab_addr<>(typeof(h.facility_lab_addr))'');
    populated_facility_lab_city_pcnt := AVE(GROUP,IF(h.facility_lab_city = (TYPEOF(h.facility_lab_city))'',0,100));
    maxlength_facility_lab_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_city)));
    avelength_facility_lab_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_city)),h.facility_lab_city<>(typeof(h.facility_lab_city))'');
    populated_facility_lab_name_pcnt := AVE(GROUP,IF(h.facility_lab_name = (TYPEOF(h.facility_lab_name))'',0,100));
    maxlength_facility_lab_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_name)));
    avelength_facility_lab_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_name)),h.facility_lab_name<>(typeof(h.facility_lab_name))'');
    populated_facility_lab_npi_pcnt := AVE(GROUP,IF(h.facility_lab_npi = (TYPEOF(h.facility_lab_npi))'',0,100));
    maxlength_facility_lab_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_npi)));
    avelength_facility_lab_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_npi)),h.facility_lab_npi<>(typeof(h.facility_lab_npi))'');
    populated_facility_lab_state_pcnt := AVE(GROUP,IF(h.facility_lab_state = (TYPEOF(h.facility_lab_state))'',0,100));
    maxlength_facility_lab_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_state)));
    avelength_facility_lab_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_state)),h.facility_lab_state<>(typeof(h.facility_lab_state))'');
    populated_facility_lab_tax_id_pcnt := AVE(GROUP,IF(h.facility_lab_tax_id = (TYPEOF(h.facility_lab_tax_id))'',0,100));
    maxlength_facility_lab_tax_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_tax_id)));
    avelength_facility_lab_tax_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_tax_id)),h.facility_lab_tax_id<>(typeof(h.facility_lab_tax_id))'');
    populated_facility_lab_type_code_pcnt := AVE(GROUP,IF(h.facility_lab_type_code = (TYPEOF(h.facility_lab_type_code))'',0,100));
    maxlength_facility_lab_type_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_type_code)));
    avelength_facility_lab_type_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_type_code)),h.facility_lab_type_code<>(typeof(h.facility_lab_type_code))'');
    populated_facility_lab_zip_pcnt := AVE(GROUP,IF(h.facility_lab_zip = (TYPEOF(h.facility_lab_zip))'',0,100));
    maxlength_facility_lab_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_zip)));
    avelength_facility_lab_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_lab_zip)),h.facility_lab_zip<>(typeof(h.facility_lab_zip))'');
    populated_ordering_prov_addr_pcnt := AVE(GROUP,IF(h.ordering_prov_addr = (TYPEOF(h.ordering_prov_addr))'',0,100));
    maxlength_ordering_prov_addr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_addr)));
    avelength_ordering_prov_addr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_addr)),h.ordering_prov_addr<>(typeof(h.ordering_prov_addr))'');
    populated_ordering_prov_city_pcnt := AVE(GROUP,IF(h.ordering_prov_city = (TYPEOF(h.ordering_prov_city))'',0,100));
    maxlength_ordering_prov_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_city)));
    avelength_ordering_prov_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_city)),h.ordering_prov_city<>(typeof(h.ordering_prov_city))'');
    populated_ordering_prov_first_name_pcnt := AVE(GROUP,IF(h.ordering_prov_first_name = (TYPEOF(h.ordering_prov_first_name))'',0,100));
    maxlength_ordering_prov_first_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_first_name)));
    avelength_ordering_prov_first_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_first_name)),h.ordering_prov_first_name<>(typeof(h.ordering_prov_first_name))'');
    populated_ordering_prov_last_name_pcnt := AVE(GROUP,IF(h.ordering_prov_last_name = (TYPEOF(h.ordering_prov_last_name))'',0,100));
    maxlength_ordering_prov_last_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_last_name)));
    avelength_ordering_prov_last_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_last_name)),h.ordering_prov_last_name<>(typeof(h.ordering_prov_last_name))'');
    populated_ordering_prov_middle_name_pcnt := AVE(GROUP,IF(h.ordering_prov_middle_name = (TYPEOF(h.ordering_prov_middle_name))'',0,100));
    maxlength_ordering_prov_middle_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_middle_name)));
    avelength_ordering_prov_middle_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_middle_name)),h.ordering_prov_middle_name<>(typeof(h.ordering_prov_middle_name))'');
    populated_ordering_prov_npi_pcnt := AVE(GROUP,IF(h.ordering_prov_npi = (TYPEOF(h.ordering_prov_npi))'',0,100));
    maxlength_ordering_prov_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_npi)));
    avelength_ordering_prov_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_npi)),h.ordering_prov_npi<>(typeof(h.ordering_prov_npi))'');
    populated_ordering_prov_state_pcnt := AVE(GROUP,IF(h.ordering_prov_state = (TYPEOF(h.ordering_prov_state))'',0,100));
    maxlength_ordering_prov_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_state)));
    avelength_ordering_prov_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_state)),h.ordering_prov_state<>(typeof(h.ordering_prov_state))'');
    populated_ordering_prov_upin_pcnt := AVE(GROUP,IF(h.ordering_prov_upin = (TYPEOF(h.ordering_prov_upin))'',0,100));
    maxlength_ordering_prov_upin := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_upin)));
    avelength_ordering_prov_upin := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_upin)),h.ordering_prov_upin<>(typeof(h.ordering_prov_upin))'');
    populated_ordering_prov_zip_pcnt := AVE(GROUP,IF(h.ordering_prov_zip = (TYPEOF(h.ordering_prov_zip))'',0,100));
    maxlength_ordering_prov_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_zip)));
    avelength_ordering_prov_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ordering_prov_zip)),h.ordering_prov_zip<>(typeof(h.ordering_prov_zip))'');
    populated_pay_to_addr_pcnt := AVE(GROUP,IF(h.pay_to_addr = (TYPEOF(h.pay_to_addr))'',0,100));
    maxlength_pay_to_addr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_addr)));
    avelength_pay_to_addr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_addr)),h.pay_to_addr<>(typeof(h.pay_to_addr))'');
    populated_pay_to_city_pcnt := AVE(GROUP,IF(h.pay_to_city = (TYPEOF(h.pay_to_city))'',0,100));
    maxlength_pay_to_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_city)));
    avelength_pay_to_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_city)),h.pay_to_city<>(typeof(h.pay_to_city))'');
    populated_pay_to_first_name_pcnt := AVE(GROUP,IF(h.pay_to_first_name = (TYPEOF(h.pay_to_first_name))'',0,100));
    maxlength_pay_to_first_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_first_name)));
    avelength_pay_to_first_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_first_name)),h.pay_to_first_name<>(typeof(h.pay_to_first_name))'');
    populated_pay_to_last_name_pcnt := AVE(GROUP,IF(h.pay_to_last_name = (TYPEOF(h.pay_to_last_name))'',0,100));
    maxlength_pay_to_last_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_last_name)));
    avelength_pay_to_last_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_last_name)),h.pay_to_last_name<>(typeof(h.pay_to_last_name))'');
    populated_pay_to_middle_name_pcnt := AVE(GROUP,IF(h.pay_to_middle_name = (TYPEOF(h.pay_to_middle_name))'',0,100));
    maxlength_pay_to_middle_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_middle_name)));
    avelength_pay_to_middle_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_middle_name)),h.pay_to_middle_name<>(typeof(h.pay_to_middle_name))'');
    populated_pay_to_npi_pcnt := AVE(GROUP,IF(h.pay_to_npi = (TYPEOF(h.pay_to_npi))'',0,100));
    maxlength_pay_to_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_npi)));
    avelength_pay_to_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_npi)),h.pay_to_npi<>(typeof(h.pay_to_npi))'');
    populated_pay_to_service_phone_pcnt := AVE(GROUP,IF(h.pay_to_service_phone = (TYPEOF(h.pay_to_service_phone))'',0,100));
    maxlength_pay_to_service_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_service_phone)));
    avelength_pay_to_service_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_service_phone)),h.pay_to_service_phone<>(typeof(h.pay_to_service_phone))'');
    populated_pay_to_state_pcnt := AVE(GROUP,IF(h.pay_to_state = (TYPEOF(h.pay_to_state))'',0,100));
    maxlength_pay_to_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_state)));
    avelength_pay_to_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_state)),h.pay_to_state<>(typeof(h.pay_to_state))'');
    populated_pay_to_tax_id_pcnt := AVE(GROUP,IF(h.pay_to_tax_id = (TYPEOF(h.pay_to_tax_id))'',0,100));
    maxlength_pay_to_tax_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_tax_id)));
    avelength_pay_to_tax_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_tax_id)),h.pay_to_tax_id<>(typeof(h.pay_to_tax_id))'');
    populated_pay_to_zip_pcnt := AVE(GROUP,IF(h.pay_to_zip = (TYPEOF(h.pay_to_zip))'',0,100));
    maxlength_pay_to_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_zip)));
    avelength_pay_to_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_zip)),h.pay_to_zip<>(typeof(h.pay_to_zip))'');
    populated_performing_prov_phone_pcnt := AVE(GROUP,IF(h.performing_prov_phone = (TYPEOF(h.performing_prov_phone))'',0,100));
    maxlength_performing_prov_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.performing_prov_phone)));
    avelength_performing_prov_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.performing_prov_phone)),h.performing_prov_phone<>(typeof(h.performing_prov_phone))'');
    populated_performing_prov_specialty_pcnt := AVE(GROUP,IF(h.performing_prov_specialty = (TYPEOF(h.performing_prov_specialty))'',0,100));
    maxlength_performing_prov_specialty := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.performing_prov_specialty)));
    avelength_performing_prov_specialty := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.performing_prov_specialty)),h.performing_prov_specialty<>(typeof(h.performing_prov_specialty))'');
    populated_performing_prov_tax_id_pcnt := AVE(GROUP,IF(h.performing_prov_tax_id = (TYPEOF(h.performing_prov_tax_id))'',0,100));
    maxlength_performing_prov_tax_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.performing_prov_tax_id)));
    avelength_performing_prov_tax_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.performing_prov_tax_id)),h.performing_prov_tax_id<>(typeof(h.performing_prov_tax_id))'');
    populated_place_of_service_code_pcnt := AVE(GROUP,IF(h.place_of_service_code = (TYPEOF(h.place_of_service_code))'',0,100));
    maxlength_place_of_service_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.place_of_service_code)));
    avelength_place_of_service_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.place_of_service_code)),h.place_of_service_code<>(typeof(h.place_of_service_code))'');
    populated_place_of_service_name_pcnt := AVE(GROUP,IF(h.place_of_service_name = (TYPEOF(h.place_of_service_name))'',0,100));
    maxlength_place_of_service_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.place_of_service_name)));
    avelength_place_of_service_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.place_of_service_name)),h.place_of_service_name<>(typeof(h.place_of_service_name))'');
    populated_prov_a_addr_pcnt := AVE(GROUP,IF(h.prov_a_addr = (TYPEOF(h.prov_a_addr))'',0,100));
    maxlength_prov_a_addr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_a_addr)));
    avelength_prov_a_addr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_a_addr)),h.prov_a_addr<>(typeof(h.prov_a_addr))'');
    populated_prov_a_city_pcnt := AVE(GROUP,IF(h.prov_a_city = (TYPEOF(h.prov_a_city))'',0,100));
    maxlength_prov_a_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_a_city)));
    avelength_prov_a_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_a_city)),h.prov_a_city<>(typeof(h.prov_a_city))'');
    populated_prov_a_service_role_code_pcnt := AVE(GROUP,IF(h.prov_a_service_role_code = (TYPEOF(h.prov_a_service_role_code))'',0,100));
    maxlength_prov_a_service_role_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_a_service_role_code)));
    avelength_prov_a_service_role_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_a_service_role_code)),h.prov_a_service_role_code<>(typeof(h.prov_a_service_role_code))'');
    populated_prov_a_state_pcnt := AVE(GROUP,IF(h.prov_a_state = (TYPEOF(h.prov_a_state))'',0,100));
    maxlength_prov_a_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_a_state)));
    avelength_prov_a_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_a_state)),h.prov_a_state<>(typeof(h.prov_a_state))'');
    populated_prov_a_zip_pcnt := AVE(GROUP,IF(h.prov_a_zip = (TYPEOF(h.prov_a_zip))'',0,100));
    maxlength_prov_a_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_a_zip)));
    avelength_prov_a_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_a_zip)),h.prov_a_zip<>(typeof(h.prov_a_zip))'');
    populated_prov_b_addr_pcnt := AVE(GROUP,IF(h.prov_b_addr = (TYPEOF(h.prov_b_addr))'',0,100));
    maxlength_prov_b_addr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_b_addr)));
    avelength_prov_b_addr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_b_addr)),h.prov_b_addr<>(typeof(h.prov_b_addr))'');
    populated_prov_b_city_pcnt := AVE(GROUP,IF(h.prov_b_city = (TYPEOF(h.prov_b_city))'',0,100));
    maxlength_prov_b_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_b_city)));
    avelength_prov_b_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_b_city)),h.prov_b_city<>(typeof(h.prov_b_city))'');
    populated_prov_b_service_role_code_pcnt := AVE(GROUP,IF(h.prov_b_service_role_code = (TYPEOF(h.prov_b_service_role_code))'',0,100));
    maxlength_prov_b_service_role_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_b_service_role_code)));
    avelength_prov_b_service_role_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_b_service_role_code)),h.prov_b_service_role_code<>(typeof(h.prov_b_service_role_code))'');
    populated_prov_b_state_pcnt := AVE(GROUP,IF(h.prov_b_state = (TYPEOF(h.prov_b_state))'',0,100));
    maxlength_prov_b_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_b_state)));
    avelength_prov_b_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_b_state)),h.prov_b_state<>(typeof(h.prov_b_state))'');
    populated_prov_b_zip_pcnt := AVE(GROUP,IF(h.prov_b_zip = (TYPEOF(h.prov_b_zip))'',0,100));
    maxlength_prov_b_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_b_zip)));
    avelength_prov_b_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_b_zip)),h.prov_b_zip<>(typeof(h.prov_b_zip))'');
    populated_prov_c_addr_pcnt := AVE(GROUP,IF(h.prov_c_addr = (TYPEOF(h.prov_c_addr))'',0,100));
    maxlength_prov_c_addr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_c_addr)));
    avelength_prov_c_addr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_c_addr)),h.prov_c_addr<>(typeof(h.prov_c_addr))'');
    populated_prov_c_city_pcnt := AVE(GROUP,IF(h.prov_c_city = (TYPEOF(h.prov_c_city))'',0,100));
    maxlength_prov_c_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_c_city)));
    avelength_prov_c_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_c_city)),h.prov_c_city<>(typeof(h.prov_c_city))'');
    populated_prov_c_service_role_code_pcnt := AVE(GROUP,IF(h.prov_c_service_role_code = (TYPEOF(h.prov_c_service_role_code))'',0,100));
    maxlength_prov_c_service_role_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_c_service_role_code)));
    avelength_prov_c_service_role_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_c_service_role_code)),h.prov_c_service_role_code<>(typeof(h.prov_c_service_role_code))'');
    populated_prov_c_state_pcnt := AVE(GROUP,IF(h.prov_c_state = (TYPEOF(h.prov_c_state))'',0,100));
    maxlength_prov_c_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_c_state)));
    avelength_prov_c_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_c_state)),h.prov_c_state<>(typeof(h.prov_c_state))'');
    populated_prov_c_zip_pcnt := AVE(GROUP,IF(h.prov_c_zip = (TYPEOF(h.prov_c_zip))'',0,100));
    maxlength_prov_c_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_c_zip)));
    avelength_prov_c_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_c_zip)),h.prov_c_zip<>(typeof(h.prov_c_zip))'');
    populated_purch_service_first_name_pcnt := AVE(GROUP,IF(h.purch_service_first_name = (TYPEOF(h.purch_service_first_name))'',0,100));
    maxlength_purch_service_first_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_first_name)));
    avelength_purch_service_first_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_first_name)),h.purch_service_first_name<>(typeof(h.purch_service_first_name))'');
    populated_purch_service_last_name_pcnt := AVE(GROUP,IF(h.purch_service_last_name = (TYPEOF(h.purch_service_last_name))'',0,100));
    maxlength_purch_service_last_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_last_name)));
    avelength_purch_service_last_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_last_name)),h.purch_service_last_name<>(typeof(h.purch_service_last_name))'');
    populated_purch_service_middle_name_pcnt := AVE(GROUP,IF(h.purch_service_middle_name = (TYPEOF(h.purch_service_middle_name))'',0,100));
    maxlength_purch_service_middle_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_middle_name)));
    avelength_purch_service_middle_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_middle_name)),h.purch_service_middle_name<>(typeof(h.purch_service_middle_name))'');
    populated_purch_service_npi_pcnt := AVE(GROUP,IF(h.purch_service_npi = (TYPEOF(h.purch_service_npi))'',0,100));
    maxlength_purch_service_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_npi)));
    avelength_purch_service_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_npi)),h.purch_service_npi<>(typeof(h.purch_service_npi))'');
    populated_purch_service_prov_addr_pcnt := AVE(GROUP,IF(h.purch_service_prov_addr = (TYPEOF(h.purch_service_prov_addr))'',0,100));
    maxlength_purch_service_prov_addr := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_addr)));
    avelength_purch_service_prov_addr := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_addr)),h.purch_service_prov_addr<>(typeof(h.purch_service_prov_addr))'');
    populated_purch_service_prov_city_pcnt := AVE(GROUP,IF(h.purch_service_prov_city = (TYPEOF(h.purch_service_prov_city))'',0,100));
    maxlength_purch_service_prov_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_city)));
    avelength_purch_service_prov_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_city)),h.purch_service_prov_city<>(typeof(h.purch_service_prov_city))'');
    populated_purch_service_prov_name_pcnt := AVE(GROUP,IF(h.purch_service_prov_name = (TYPEOF(h.purch_service_prov_name))'',0,100));
    maxlength_purch_service_prov_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_name)));
    avelength_purch_service_prov_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_name)),h.purch_service_prov_name<>(typeof(h.purch_service_prov_name))'');
    populated_purch_service_prov_phone_pcnt := AVE(GROUP,IF(h.purch_service_prov_phone = (TYPEOF(h.purch_service_prov_phone))'',0,100));
    maxlength_purch_service_prov_phone := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_phone)));
    avelength_purch_service_prov_phone := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_phone)),h.purch_service_prov_phone<>(typeof(h.purch_service_prov_phone))'');
    populated_purch_service_prov_state_pcnt := AVE(GROUP,IF(h.purch_service_prov_state = (TYPEOF(h.purch_service_prov_state))'',0,100));
    maxlength_purch_service_prov_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_state)));
    avelength_purch_service_prov_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_state)),h.purch_service_prov_state<>(typeof(h.purch_service_prov_state))'');
    populated_purch_service_prov_zip_pcnt := AVE(GROUP,IF(h.purch_service_prov_zip = (TYPEOF(h.purch_service_prov_zip))'',0,100));
    maxlength_purch_service_prov_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_zip)));
    avelength_purch_service_prov_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.purch_service_prov_zip)),h.purch_service_prov_zip<>(typeof(h.purch_service_prov_zip))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_claim_type_pcnt *   0.00 / 100 + T.Populated_claim_num_pcnt *   0.00 / 100 + T.Populated_billing_pay_to_taxonomy_pcnt *   0.00 / 100 + T.Populated_billing_addr_pcnt *   0.00 / 100 + T.Populated_billing_anesth_lic_pcnt *   0.00 / 100 + T.Populated_billing_city_pcnt *   0.00 / 100 + T.Populated_billing_dentist_lic_pcnt *   0.00 / 100 + T.Populated_billing_first_name_pcnt *   0.00 / 100 + T.Populated_billing_last_name_pcnt *   0.00 / 100 + T.Populated_billing_middle_name_pcnt *   0.00 / 100 + T.Populated_billing_npi_pcnt *   0.00 / 100 + T.Populated_billing_org_name_pcnt *   0.00 / 100 + T.Populated_billing_service_phone_pcnt *   0.00 / 100 + T.Populated_billing_specialty_code_pcnt *   0.00 / 100 + T.Populated_billing_specialty_lic_pcnt *   0.00 / 100 + T.Populated_billing_state_pcnt *   0.00 / 100 + T.Populated_billing_state_lic_pcnt *   0.00 / 100 + T.Populated_billing_tax_id_pcnt *   0.00 / 100 + T.Populated_billing_upin_pcnt *   0.00 / 100 + T.Populated_billing_zip_pcnt *   0.00 / 100 + T.Populated_diag_code1_pcnt *   0.00 / 100 + T.Populated_diag_code2_pcnt *   0.00 / 100 + T.Populated_diag_code3_pcnt *   0.00 / 100 + T.Populated_diag_code4_pcnt *   0.00 / 100 + T.Populated_diag_code5_pcnt *   0.00 / 100 + T.Populated_diag_code6_pcnt *   0.00 / 100 + T.Populated_diag_code7_pcnt *   0.00 / 100 + T.Populated_diag_code8_pcnt *   0.00 / 100 + T.Populated_dme_hcpcs_proc_code_pcnt *   0.00 / 100 + T.Populated_emt_paramedic_first_name_pcnt *   0.00 / 100 + T.Populated_emt_paramedic_last_name_pcnt *   0.00 / 100 + T.Populated_emt_paramedic_middle_name_pcnt *   0.00 / 100 + T.Populated_ext_injury_diag_code_pcnt *   0.00 / 100 + T.Populated_facility_lab_addr_pcnt *   0.00 / 100 + T.Populated_facility_lab_city_pcnt *   0.00 / 100 + T.Populated_facility_lab_name_pcnt *   0.00 / 100 + T.Populated_facility_lab_npi_pcnt *   0.00 / 100 + T.Populated_facility_lab_state_pcnt *   0.00 / 100 + T.Populated_facility_lab_tax_id_pcnt *   0.00 / 100 + T.Populated_facility_lab_type_code_pcnt *   0.00 / 100 + T.Populated_facility_lab_zip_pcnt *   0.00 / 100 + T.Populated_ordering_prov_addr_pcnt *   0.00 / 100 + T.Populated_ordering_prov_city_pcnt *   0.00 / 100 + T.Populated_ordering_prov_first_name_pcnt *   0.00 / 100 + T.Populated_ordering_prov_last_name_pcnt *   0.00 / 100 + T.Populated_ordering_prov_middle_name_pcnt *   0.00 / 100 + T.Populated_ordering_prov_npi_pcnt *   0.00 / 100 + T.Populated_ordering_prov_state_pcnt *   0.00 / 100 + T.Populated_ordering_prov_upin_pcnt *   0.00 / 100 + T.Populated_ordering_prov_zip_pcnt *   0.00 / 100 + T.Populated_pay_to_addr_pcnt *   0.00 / 100 + T.Populated_pay_to_city_pcnt *   0.00 / 100 + T.Populated_pay_to_first_name_pcnt *   0.00 / 100 + T.Populated_pay_to_last_name_pcnt *   0.00 / 100 + T.Populated_pay_to_middle_name_pcnt *   0.00 / 100 + T.Populated_pay_to_npi_pcnt *   0.00 / 100 + T.Populated_pay_to_service_phone_pcnt *   0.00 / 100 + T.Populated_pay_to_state_pcnt *   0.00 / 100 + T.Populated_pay_to_tax_id_pcnt *   0.00 / 100 + T.Populated_pay_to_zip_pcnt *   0.00 / 100 + T.Populated_performing_prov_phone_pcnt *   0.00 / 100 + T.Populated_performing_prov_specialty_pcnt *   0.00 / 100 + T.Populated_performing_prov_tax_id_pcnt *   0.00 / 100 + T.Populated_place_of_service_code_pcnt *   0.00 / 100 + T.Populated_place_of_service_name_pcnt *   0.00 / 100 + T.Populated_prov_a_addr_pcnt *   0.00 / 100 + T.Populated_prov_a_city_pcnt *   0.00 / 100 + T.Populated_prov_a_service_role_code_pcnt *   0.00 / 100 + T.Populated_prov_a_state_pcnt *   0.00 / 100 + T.Populated_prov_a_zip_pcnt *   0.00 / 100 + T.Populated_prov_b_addr_pcnt *   0.00 / 100 + T.Populated_prov_b_city_pcnt *   0.00 / 100 + T.Populated_prov_b_service_role_code_pcnt *   0.00 / 100 + T.Populated_prov_b_state_pcnt *   0.00 / 100 + T.Populated_prov_b_zip_pcnt *   0.00 / 100 + T.Populated_prov_c_addr_pcnt *   0.00 / 100 + T.Populated_prov_c_city_pcnt *   0.00 / 100 + T.Populated_prov_c_service_role_code_pcnt *   0.00 / 100 + T.Populated_prov_c_state_pcnt *   0.00 / 100 + T.Populated_prov_c_zip_pcnt *   0.00 / 100 + T.Populated_purch_service_first_name_pcnt *   0.00 / 100 + T.Populated_purch_service_last_name_pcnt *   0.00 / 100 + T.Populated_purch_service_middle_name_pcnt *   0.00 / 100 + T.Populated_purch_service_npi_pcnt *   0.00 / 100 + T.Populated_purch_service_prov_addr_pcnt *   0.00 / 100 + T.Populated_purch_service_prov_city_pcnt *   0.00 / 100 + T.Populated_purch_service_prov_name_pcnt *   0.00 / 100 + T.Populated_purch_service_prov_phone_pcnt *   0.00 / 100 + T.Populated_purch_service_prov_state_pcnt *   0.00 / 100 + T.Populated_purch_service_prov_zip_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'claim_type','claim_num','billing_pay_to_taxonomy','billing_addr','billing_anesth_lic','billing_city','billing_dentist_lic','billing_first_name','billing_last_name','billing_middle_name','billing_npi','billing_org_name','billing_service_phone','billing_specialty_code','billing_specialty_lic','billing_state','billing_state_lic','billing_tax_id','billing_upin','billing_zip','diag_code1','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','dme_hcpcs_proc_code','emt_paramedic_first_name','emt_paramedic_last_name','emt_paramedic_middle_name','ext_injury_diag_code','facility_lab_addr','facility_lab_city','facility_lab_name','facility_lab_npi','facility_lab_state','facility_lab_tax_id','facility_lab_type_code','facility_lab_zip','ordering_prov_addr','ordering_prov_city','ordering_prov_first_name','ordering_prov_last_name','ordering_prov_middle_name','ordering_prov_npi','ordering_prov_state','ordering_prov_upin','ordering_prov_zip','pay_to_addr','pay_to_city','pay_to_first_name','pay_to_last_name','pay_to_middle_name','pay_to_npi','pay_to_service_phone','pay_to_state','pay_to_tax_id','pay_to_zip','performing_prov_phone','performing_prov_specialty','performing_prov_tax_id','place_of_service_code','place_of_service_name','prov_a_addr','prov_a_city','prov_a_service_role_code','prov_a_state','prov_a_zip','prov_b_addr','prov_b_city','prov_b_service_role_code','prov_b_state','prov_b_zip','prov_c_addr','prov_c_city','prov_c_service_role_code','prov_c_state','prov_c_zip','purch_service_first_name','purch_service_last_name','purch_service_middle_name','purch_service_npi','purch_service_prov_addr','purch_service_prov_city','purch_service_prov_name','purch_service_prov_phone','purch_service_prov_state','purch_service_prov_zip');
  SELF.populated_pcnt := CHOOSE(C,le.populated_claim_type_pcnt,le.populated_claim_num_pcnt,le.populated_billing_pay_to_taxonomy_pcnt,le.populated_billing_addr_pcnt,le.populated_billing_anesth_lic_pcnt,le.populated_billing_city_pcnt,le.populated_billing_dentist_lic_pcnt,le.populated_billing_first_name_pcnt,le.populated_billing_last_name_pcnt,le.populated_billing_middle_name_pcnt,le.populated_billing_npi_pcnt,le.populated_billing_org_name_pcnt,le.populated_billing_service_phone_pcnt,le.populated_billing_specialty_code_pcnt,le.populated_billing_specialty_lic_pcnt,le.populated_billing_state_pcnt,le.populated_billing_state_lic_pcnt,le.populated_billing_tax_id_pcnt,le.populated_billing_upin_pcnt,le.populated_billing_zip_pcnt,le.populated_diag_code1_pcnt,le.populated_diag_code2_pcnt,le.populated_diag_code3_pcnt,le.populated_diag_code4_pcnt,le.populated_diag_code5_pcnt,le.populated_diag_code6_pcnt,le.populated_diag_code7_pcnt,le.populated_diag_code8_pcnt,le.populated_dme_hcpcs_proc_code_pcnt,le.populated_emt_paramedic_first_name_pcnt,le.populated_emt_paramedic_last_name_pcnt,le.populated_emt_paramedic_middle_name_pcnt,le.populated_ext_injury_diag_code_pcnt,le.populated_facility_lab_addr_pcnt,le.populated_facility_lab_city_pcnt,le.populated_facility_lab_name_pcnt,le.populated_facility_lab_npi_pcnt,le.populated_facility_lab_state_pcnt,le.populated_facility_lab_tax_id_pcnt,le.populated_facility_lab_type_code_pcnt,le.populated_facility_lab_zip_pcnt,le.populated_ordering_prov_addr_pcnt,le.populated_ordering_prov_city_pcnt,le.populated_ordering_prov_first_name_pcnt,le.populated_ordering_prov_last_name_pcnt,le.populated_ordering_prov_middle_name_pcnt,le.populated_ordering_prov_npi_pcnt,le.populated_ordering_prov_state_pcnt,le.populated_ordering_prov_upin_pcnt,le.populated_ordering_prov_zip_pcnt,le.populated_pay_to_addr_pcnt,le.populated_pay_to_city_pcnt,le.populated_pay_to_first_name_pcnt,le.populated_pay_to_last_name_pcnt,le.populated_pay_to_middle_name_pcnt,le.populated_pay_to_npi_pcnt,le.populated_pay_to_service_phone_pcnt,le.populated_pay_to_state_pcnt,le.populated_pay_to_tax_id_pcnt,le.populated_pay_to_zip_pcnt,le.populated_performing_prov_phone_pcnt,le.populated_performing_prov_specialty_pcnt,le.populated_performing_prov_tax_id_pcnt,le.populated_place_of_service_code_pcnt,le.populated_place_of_service_name_pcnt,le.populated_prov_a_addr_pcnt,le.populated_prov_a_city_pcnt,le.populated_prov_a_service_role_code_pcnt,le.populated_prov_a_state_pcnt,le.populated_prov_a_zip_pcnt,le.populated_prov_b_addr_pcnt,le.populated_prov_b_city_pcnt,le.populated_prov_b_service_role_code_pcnt,le.populated_prov_b_state_pcnt,le.populated_prov_b_zip_pcnt,le.populated_prov_c_addr_pcnt,le.populated_prov_c_city_pcnt,le.populated_prov_c_service_role_code_pcnt,le.populated_prov_c_state_pcnt,le.populated_prov_c_zip_pcnt,le.populated_purch_service_first_name_pcnt,le.populated_purch_service_last_name_pcnt,le.populated_purch_service_middle_name_pcnt,le.populated_purch_service_npi_pcnt,le.populated_purch_service_prov_addr_pcnt,le.populated_purch_service_prov_city_pcnt,le.populated_purch_service_prov_name_pcnt,le.populated_purch_service_prov_phone_pcnt,le.populated_purch_service_prov_state_pcnt,le.populated_purch_service_prov_zip_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_claim_type,le.maxlength_claim_num,le.maxlength_billing_pay_to_taxonomy,le.maxlength_billing_addr,le.maxlength_billing_anesth_lic,le.maxlength_billing_city,le.maxlength_billing_dentist_lic,le.maxlength_billing_first_name,le.maxlength_billing_last_name,le.maxlength_billing_middle_name,le.maxlength_billing_npi,le.maxlength_billing_org_name,le.maxlength_billing_service_phone,le.maxlength_billing_specialty_code,le.maxlength_billing_specialty_lic,le.maxlength_billing_state,le.maxlength_billing_state_lic,le.maxlength_billing_tax_id,le.maxlength_billing_upin,le.maxlength_billing_zip,le.maxlength_diag_code1,le.maxlength_diag_code2,le.maxlength_diag_code3,le.maxlength_diag_code4,le.maxlength_diag_code5,le.maxlength_diag_code6,le.maxlength_diag_code7,le.maxlength_diag_code8,le.maxlength_dme_hcpcs_proc_code,le.maxlength_emt_paramedic_first_name,le.maxlength_emt_paramedic_last_name,le.maxlength_emt_paramedic_middle_name,le.maxlength_ext_injury_diag_code,le.maxlength_facility_lab_addr,le.maxlength_facility_lab_city,le.maxlength_facility_lab_name,le.maxlength_facility_lab_npi,le.maxlength_facility_lab_state,le.maxlength_facility_lab_tax_id,le.maxlength_facility_lab_type_code,le.maxlength_facility_lab_zip,le.maxlength_ordering_prov_addr,le.maxlength_ordering_prov_city,le.maxlength_ordering_prov_first_name,le.maxlength_ordering_prov_last_name,le.maxlength_ordering_prov_middle_name,le.maxlength_ordering_prov_npi,le.maxlength_ordering_prov_state,le.maxlength_ordering_prov_upin,le.maxlength_ordering_prov_zip,le.maxlength_pay_to_addr,le.maxlength_pay_to_city,le.maxlength_pay_to_first_name,le.maxlength_pay_to_last_name,le.maxlength_pay_to_middle_name,le.maxlength_pay_to_npi,le.maxlength_pay_to_service_phone,le.maxlength_pay_to_state,le.maxlength_pay_to_tax_id,le.maxlength_pay_to_zip,le.maxlength_performing_prov_phone,le.maxlength_performing_prov_specialty,le.maxlength_performing_prov_tax_id,le.maxlength_place_of_service_code,le.maxlength_place_of_service_name,le.maxlength_prov_a_addr,le.maxlength_prov_a_city,le.maxlength_prov_a_service_role_code,le.maxlength_prov_a_state,le.maxlength_prov_a_zip,le.maxlength_prov_b_addr,le.maxlength_prov_b_city,le.maxlength_prov_b_service_role_code,le.maxlength_prov_b_state,le.maxlength_prov_b_zip,le.maxlength_prov_c_addr,le.maxlength_prov_c_city,le.maxlength_prov_c_service_role_code,le.maxlength_prov_c_state,le.maxlength_prov_c_zip,le.maxlength_purch_service_first_name,le.maxlength_purch_service_last_name,le.maxlength_purch_service_middle_name,le.maxlength_purch_service_npi,le.maxlength_purch_service_prov_addr,le.maxlength_purch_service_prov_city,le.maxlength_purch_service_prov_name,le.maxlength_purch_service_prov_phone,le.maxlength_purch_service_prov_state,le.maxlength_purch_service_prov_zip);
  SELF.avelength := CHOOSE(C,le.avelength_claim_type,le.avelength_claim_num,le.avelength_billing_pay_to_taxonomy,le.avelength_billing_addr,le.avelength_billing_anesth_lic,le.avelength_billing_city,le.avelength_billing_dentist_lic,le.avelength_billing_first_name,le.avelength_billing_last_name,le.avelength_billing_middle_name,le.avelength_billing_npi,le.avelength_billing_org_name,le.avelength_billing_service_phone,le.avelength_billing_specialty_code,le.avelength_billing_specialty_lic,le.avelength_billing_state,le.avelength_billing_state_lic,le.avelength_billing_tax_id,le.avelength_billing_upin,le.avelength_billing_zip,le.avelength_diag_code1,le.avelength_diag_code2,le.avelength_diag_code3,le.avelength_diag_code4,le.avelength_diag_code5,le.avelength_diag_code6,le.avelength_diag_code7,le.avelength_diag_code8,le.avelength_dme_hcpcs_proc_code,le.avelength_emt_paramedic_first_name,le.avelength_emt_paramedic_last_name,le.avelength_emt_paramedic_middle_name,le.avelength_ext_injury_diag_code,le.avelength_facility_lab_addr,le.avelength_facility_lab_city,le.avelength_facility_lab_name,le.avelength_facility_lab_npi,le.avelength_facility_lab_state,le.avelength_facility_lab_tax_id,le.avelength_facility_lab_type_code,le.avelength_facility_lab_zip,le.avelength_ordering_prov_addr,le.avelength_ordering_prov_city,le.avelength_ordering_prov_first_name,le.avelength_ordering_prov_last_name,le.avelength_ordering_prov_middle_name,le.avelength_ordering_prov_npi,le.avelength_ordering_prov_state,le.avelength_ordering_prov_upin,le.avelength_ordering_prov_zip,le.avelength_pay_to_addr,le.avelength_pay_to_city,le.avelength_pay_to_first_name,le.avelength_pay_to_last_name,le.avelength_pay_to_middle_name,le.avelength_pay_to_npi,le.avelength_pay_to_service_phone,le.avelength_pay_to_state,le.avelength_pay_to_tax_id,le.avelength_pay_to_zip,le.avelength_performing_prov_phone,le.avelength_performing_prov_specialty,le.avelength_performing_prov_tax_id,le.avelength_place_of_service_code,le.avelength_place_of_service_name,le.avelength_prov_a_addr,le.avelength_prov_a_city,le.avelength_prov_a_service_role_code,le.avelength_prov_a_state,le.avelength_prov_a_zip,le.avelength_prov_b_addr,le.avelength_prov_b_city,le.avelength_prov_b_service_role_code,le.avelength_prov_b_state,le.avelength_prov_b_zip,le.avelength_prov_c_addr,le.avelength_prov_c_city,le.avelength_prov_c_service_role_code,le.avelength_prov_c_state,le.avelength_prov_c_zip,le.avelength_purch_service_first_name,le.avelength_purch_service_last_name,le.avelength_purch_service_middle_name,le.avelength_purch_service_npi,le.avelength_purch_service_prov_addr,le.avelength_purch_service_prov_city,le.avelength_purch_service_prov_name,le.avelength_purch_service_prov_phone,le.avelength_purch_service_prov_state,le.avelength_purch_service_prov_zip);
END;
EXPORT invSummary := NORMALIZE(summary0, 90, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.claim_type),TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.billing_pay_to_taxonomy),TRIM((SALT31.StrType)le.billing_addr),TRIM((SALT31.StrType)le.billing_anesth_lic),TRIM((SALT31.StrType)le.billing_city),TRIM((SALT31.StrType)le.billing_dentist_lic),TRIM((SALT31.StrType)le.billing_first_name),TRIM((SALT31.StrType)le.billing_last_name),TRIM((SALT31.StrType)le.billing_middle_name),TRIM((SALT31.StrType)le.billing_npi),TRIM((SALT31.StrType)le.billing_org_name),TRIM((SALT31.StrType)le.billing_service_phone),TRIM((SALT31.StrType)le.billing_specialty_code),TRIM((SALT31.StrType)le.billing_specialty_lic),TRIM((SALT31.StrType)le.billing_state),TRIM((SALT31.StrType)le.billing_state_lic),TRIM((SALT31.StrType)le.billing_tax_id),TRIM((SALT31.StrType)le.billing_upin),TRIM((SALT31.StrType)le.billing_zip),TRIM((SALT31.StrType)le.diag_code1),TRIM((SALT31.StrType)le.diag_code2),TRIM((SALT31.StrType)le.diag_code3),TRIM((SALT31.StrType)le.diag_code4),TRIM((SALT31.StrType)le.diag_code5),TRIM((SALT31.StrType)le.diag_code6),TRIM((SALT31.StrType)le.diag_code7),TRIM((SALT31.StrType)le.diag_code8),TRIM((SALT31.StrType)le.dme_hcpcs_proc_code),TRIM((SALT31.StrType)le.emt_paramedic_first_name),TRIM((SALT31.StrType)le.emt_paramedic_last_name),TRIM((SALT31.StrType)le.emt_paramedic_middle_name),TRIM((SALT31.StrType)le.ext_injury_diag_code),TRIM((SALT31.StrType)le.facility_lab_addr),TRIM((SALT31.StrType)le.facility_lab_city),TRIM((SALT31.StrType)le.facility_lab_name),TRIM((SALT31.StrType)le.facility_lab_npi),TRIM((SALT31.StrType)le.facility_lab_state),TRIM((SALT31.StrType)le.facility_lab_tax_id),TRIM((SALT31.StrType)le.facility_lab_type_code),TRIM((SALT31.StrType)le.facility_lab_zip),TRIM((SALT31.StrType)le.ordering_prov_addr),TRIM((SALT31.StrType)le.ordering_prov_city),TRIM((SALT31.StrType)le.ordering_prov_first_name),TRIM((SALT31.StrType)le.ordering_prov_last_name),TRIM((SALT31.StrType)le.ordering_prov_middle_name),TRIM((SALT31.StrType)le.ordering_prov_npi),TRIM((SALT31.StrType)le.ordering_prov_state),TRIM((SALT31.StrType)le.ordering_prov_upin),TRIM((SALT31.StrType)le.ordering_prov_zip),TRIM((SALT31.StrType)le.pay_to_addr),TRIM((SALT31.StrType)le.pay_to_city),TRIM((SALT31.StrType)le.pay_to_first_name),TRIM((SALT31.StrType)le.pay_to_last_name),TRIM((SALT31.StrType)le.pay_to_middle_name),TRIM((SALT31.StrType)le.pay_to_npi),TRIM((SALT31.StrType)le.pay_to_service_phone),TRIM((SALT31.StrType)le.pay_to_state),TRIM((SALT31.StrType)le.pay_to_tax_id),TRIM((SALT31.StrType)le.pay_to_zip),TRIM((SALT31.StrType)le.performing_prov_phone),TRIM((SALT31.StrType)le.performing_prov_specialty),TRIM((SALT31.StrType)le.performing_prov_tax_id),TRIM((SALT31.StrType)le.place_of_service_code),TRIM((SALT31.StrType)le.place_of_service_name),TRIM((SALT31.StrType)le.prov_a_addr),TRIM((SALT31.StrType)le.prov_a_city),TRIM((SALT31.StrType)le.prov_a_service_role_code),TRIM((SALT31.StrType)le.prov_a_state),TRIM((SALT31.StrType)le.prov_a_zip),TRIM((SALT31.StrType)le.prov_b_addr),TRIM((SALT31.StrType)le.prov_b_city),TRIM((SALT31.StrType)le.prov_b_service_role_code),TRIM((SALT31.StrType)le.prov_b_state),TRIM((SALT31.StrType)le.prov_b_zip),TRIM((SALT31.StrType)le.prov_c_addr),TRIM((SALT31.StrType)le.prov_c_city),TRIM((SALT31.StrType)le.prov_c_service_role_code),TRIM((SALT31.StrType)le.prov_c_state),TRIM((SALT31.StrType)le.prov_c_zip),TRIM((SALT31.StrType)le.purch_service_first_name),TRIM((SALT31.StrType)le.purch_service_last_name),TRIM((SALT31.StrType)le.purch_service_middle_name),TRIM((SALT31.StrType)le.purch_service_npi),TRIM((SALT31.StrType)le.purch_service_prov_addr),TRIM((SALT31.StrType)le.purch_service_prov_city),TRIM((SALT31.StrType)le.purch_service_prov_name),TRIM((SALT31.StrType)le.purch_service_prov_phone),TRIM((SALT31.StrType)le.purch_service_prov_state),TRIM((SALT31.StrType)le.purch_service_prov_zip)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,90,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 90);
  SELF.FldNo2 := 1 + (C % 90);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.claim_type),TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.billing_pay_to_taxonomy),TRIM((SALT31.StrType)le.billing_addr),TRIM((SALT31.StrType)le.billing_anesth_lic),TRIM((SALT31.StrType)le.billing_city),TRIM((SALT31.StrType)le.billing_dentist_lic),TRIM((SALT31.StrType)le.billing_first_name),TRIM((SALT31.StrType)le.billing_last_name),TRIM((SALT31.StrType)le.billing_middle_name),TRIM((SALT31.StrType)le.billing_npi),TRIM((SALT31.StrType)le.billing_org_name),TRIM((SALT31.StrType)le.billing_service_phone),TRIM((SALT31.StrType)le.billing_specialty_code),TRIM((SALT31.StrType)le.billing_specialty_lic),TRIM((SALT31.StrType)le.billing_state),TRIM((SALT31.StrType)le.billing_state_lic),TRIM((SALT31.StrType)le.billing_tax_id),TRIM((SALT31.StrType)le.billing_upin),TRIM((SALT31.StrType)le.billing_zip),TRIM((SALT31.StrType)le.diag_code1),TRIM((SALT31.StrType)le.diag_code2),TRIM((SALT31.StrType)le.diag_code3),TRIM((SALT31.StrType)le.diag_code4),TRIM((SALT31.StrType)le.diag_code5),TRIM((SALT31.StrType)le.diag_code6),TRIM((SALT31.StrType)le.diag_code7),TRIM((SALT31.StrType)le.diag_code8),TRIM((SALT31.StrType)le.dme_hcpcs_proc_code),TRIM((SALT31.StrType)le.emt_paramedic_first_name),TRIM((SALT31.StrType)le.emt_paramedic_last_name),TRIM((SALT31.StrType)le.emt_paramedic_middle_name),TRIM((SALT31.StrType)le.ext_injury_diag_code),TRIM((SALT31.StrType)le.facility_lab_addr),TRIM((SALT31.StrType)le.facility_lab_city),TRIM((SALT31.StrType)le.facility_lab_name),TRIM((SALT31.StrType)le.facility_lab_npi),TRIM((SALT31.StrType)le.facility_lab_state),TRIM((SALT31.StrType)le.facility_lab_tax_id),TRIM((SALT31.StrType)le.facility_lab_type_code),TRIM((SALT31.StrType)le.facility_lab_zip),TRIM((SALT31.StrType)le.ordering_prov_addr),TRIM((SALT31.StrType)le.ordering_prov_city),TRIM((SALT31.StrType)le.ordering_prov_first_name),TRIM((SALT31.StrType)le.ordering_prov_last_name),TRIM((SALT31.StrType)le.ordering_prov_middle_name),TRIM((SALT31.StrType)le.ordering_prov_npi),TRIM((SALT31.StrType)le.ordering_prov_state),TRIM((SALT31.StrType)le.ordering_prov_upin),TRIM((SALT31.StrType)le.ordering_prov_zip),TRIM((SALT31.StrType)le.pay_to_addr),TRIM((SALT31.StrType)le.pay_to_city),TRIM((SALT31.StrType)le.pay_to_first_name),TRIM((SALT31.StrType)le.pay_to_last_name),TRIM((SALT31.StrType)le.pay_to_middle_name),TRIM((SALT31.StrType)le.pay_to_npi),TRIM((SALT31.StrType)le.pay_to_service_phone),TRIM((SALT31.StrType)le.pay_to_state),TRIM((SALT31.StrType)le.pay_to_tax_id),TRIM((SALT31.StrType)le.pay_to_zip),TRIM((SALT31.StrType)le.performing_prov_phone),TRIM((SALT31.StrType)le.performing_prov_specialty),TRIM((SALT31.StrType)le.performing_prov_tax_id),TRIM((SALT31.StrType)le.place_of_service_code),TRIM((SALT31.StrType)le.place_of_service_name),TRIM((SALT31.StrType)le.prov_a_addr),TRIM((SALT31.StrType)le.prov_a_city),TRIM((SALT31.StrType)le.prov_a_service_role_code),TRIM((SALT31.StrType)le.prov_a_state),TRIM((SALT31.StrType)le.prov_a_zip),TRIM((SALT31.StrType)le.prov_b_addr),TRIM((SALT31.StrType)le.prov_b_city),TRIM((SALT31.StrType)le.prov_b_service_role_code),TRIM((SALT31.StrType)le.prov_b_state),TRIM((SALT31.StrType)le.prov_b_zip),TRIM((SALT31.StrType)le.prov_c_addr),TRIM((SALT31.StrType)le.prov_c_city),TRIM((SALT31.StrType)le.prov_c_service_role_code),TRIM((SALT31.StrType)le.prov_c_state),TRIM((SALT31.StrType)le.prov_c_zip),TRIM((SALT31.StrType)le.purch_service_first_name),TRIM((SALT31.StrType)le.purch_service_last_name),TRIM((SALT31.StrType)le.purch_service_middle_name),TRIM((SALT31.StrType)le.purch_service_npi),TRIM((SALT31.StrType)le.purch_service_prov_addr),TRIM((SALT31.StrType)le.purch_service_prov_city),TRIM((SALT31.StrType)le.purch_service_prov_name),TRIM((SALT31.StrType)le.purch_service_prov_phone),TRIM((SALT31.StrType)le.purch_service_prov_state),TRIM((SALT31.StrType)le.purch_service_prov_zip)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.claim_type),TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.billing_pay_to_taxonomy),TRIM((SALT31.StrType)le.billing_addr),TRIM((SALT31.StrType)le.billing_anesth_lic),TRIM((SALT31.StrType)le.billing_city),TRIM((SALT31.StrType)le.billing_dentist_lic),TRIM((SALT31.StrType)le.billing_first_name),TRIM((SALT31.StrType)le.billing_last_name),TRIM((SALT31.StrType)le.billing_middle_name),TRIM((SALT31.StrType)le.billing_npi),TRIM((SALT31.StrType)le.billing_org_name),TRIM((SALT31.StrType)le.billing_service_phone),TRIM((SALT31.StrType)le.billing_specialty_code),TRIM((SALT31.StrType)le.billing_specialty_lic),TRIM((SALT31.StrType)le.billing_state),TRIM((SALT31.StrType)le.billing_state_lic),TRIM((SALT31.StrType)le.billing_tax_id),TRIM((SALT31.StrType)le.billing_upin),TRIM((SALT31.StrType)le.billing_zip),TRIM((SALT31.StrType)le.diag_code1),TRIM((SALT31.StrType)le.diag_code2),TRIM((SALT31.StrType)le.diag_code3),TRIM((SALT31.StrType)le.diag_code4),TRIM((SALT31.StrType)le.diag_code5),TRIM((SALT31.StrType)le.diag_code6),TRIM((SALT31.StrType)le.diag_code7),TRIM((SALT31.StrType)le.diag_code8),TRIM((SALT31.StrType)le.dme_hcpcs_proc_code),TRIM((SALT31.StrType)le.emt_paramedic_first_name),TRIM((SALT31.StrType)le.emt_paramedic_last_name),TRIM((SALT31.StrType)le.emt_paramedic_middle_name),TRIM((SALT31.StrType)le.ext_injury_diag_code),TRIM((SALT31.StrType)le.facility_lab_addr),TRIM((SALT31.StrType)le.facility_lab_city),TRIM((SALT31.StrType)le.facility_lab_name),TRIM((SALT31.StrType)le.facility_lab_npi),TRIM((SALT31.StrType)le.facility_lab_state),TRIM((SALT31.StrType)le.facility_lab_tax_id),TRIM((SALT31.StrType)le.facility_lab_type_code),TRIM((SALT31.StrType)le.facility_lab_zip),TRIM((SALT31.StrType)le.ordering_prov_addr),TRIM((SALT31.StrType)le.ordering_prov_city),TRIM((SALT31.StrType)le.ordering_prov_first_name),TRIM((SALT31.StrType)le.ordering_prov_last_name),TRIM((SALT31.StrType)le.ordering_prov_middle_name),TRIM((SALT31.StrType)le.ordering_prov_npi),TRIM((SALT31.StrType)le.ordering_prov_state),TRIM((SALT31.StrType)le.ordering_prov_upin),TRIM((SALT31.StrType)le.ordering_prov_zip),TRIM((SALT31.StrType)le.pay_to_addr),TRIM((SALT31.StrType)le.pay_to_city),TRIM((SALT31.StrType)le.pay_to_first_name),TRIM((SALT31.StrType)le.pay_to_last_name),TRIM((SALT31.StrType)le.pay_to_middle_name),TRIM((SALT31.StrType)le.pay_to_npi),TRIM((SALT31.StrType)le.pay_to_service_phone),TRIM((SALT31.StrType)le.pay_to_state),TRIM((SALT31.StrType)le.pay_to_tax_id),TRIM((SALT31.StrType)le.pay_to_zip),TRIM((SALT31.StrType)le.performing_prov_phone),TRIM((SALT31.StrType)le.performing_prov_specialty),TRIM((SALT31.StrType)le.performing_prov_tax_id),TRIM((SALT31.StrType)le.place_of_service_code),TRIM((SALT31.StrType)le.place_of_service_name),TRIM((SALT31.StrType)le.prov_a_addr),TRIM((SALT31.StrType)le.prov_a_city),TRIM((SALT31.StrType)le.prov_a_service_role_code),TRIM((SALT31.StrType)le.prov_a_state),TRIM((SALT31.StrType)le.prov_a_zip),TRIM((SALT31.StrType)le.prov_b_addr),TRIM((SALT31.StrType)le.prov_b_city),TRIM((SALT31.StrType)le.prov_b_service_role_code),TRIM((SALT31.StrType)le.prov_b_state),TRIM((SALT31.StrType)le.prov_b_zip),TRIM((SALT31.StrType)le.prov_c_addr),TRIM((SALT31.StrType)le.prov_c_city),TRIM((SALT31.StrType)le.prov_c_service_role_code),TRIM((SALT31.StrType)le.prov_c_state),TRIM((SALT31.StrType)le.prov_c_zip),TRIM((SALT31.StrType)le.purch_service_first_name),TRIM((SALT31.StrType)le.purch_service_last_name),TRIM((SALT31.StrType)le.purch_service_middle_name),TRIM((SALT31.StrType)le.purch_service_npi),TRIM((SALT31.StrType)le.purch_service_prov_addr),TRIM((SALT31.StrType)le.purch_service_prov_city),TRIM((SALT31.StrType)le.purch_service_prov_name),TRIM((SALT31.StrType)le.purch_service_prov_phone),TRIM((SALT31.StrType)le.purch_service_prov_state),TRIM((SALT31.StrType)le.purch_service_prov_zip)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),90*90,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'claim_type'}
      ,{2,'claim_num'}
      ,{3,'billing_pay_to_taxonomy'}
      ,{4,'billing_addr'}
      ,{5,'billing_anesth_lic'}
      ,{6,'billing_city'}
      ,{7,'billing_dentist_lic'}
      ,{8,'billing_first_name'}
      ,{9,'billing_last_name'}
      ,{10,'billing_middle_name'}
      ,{11,'billing_npi'}
      ,{12,'billing_org_name'}
      ,{13,'billing_service_phone'}
      ,{14,'billing_specialty_code'}
      ,{15,'billing_specialty_lic'}
      ,{16,'billing_state'}
      ,{17,'billing_state_lic'}
      ,{18,'billing_tax_id'}
      ,{19,'billing_upin'}
      ,{20,'billing_zip'}
      ,{21,'diag_code1'}
      ,{22,'diag_code2'}
      ,{23,'diag_code3'}
      ,{24,'diag_code4'}
      ,{25,'diag_code5'}
      ,{26,'diag_code6'}
      ,{27,'diag_code7'}
      ,{28,'diag_code8'}
      ,{29,'dme_hcpcs_proc_code'}
      ,{30,'emt_paramedic_first_name'}
      ,{31,'emt_paramedic_last_name'}
      ,{32,'emt_paramedic_middle_name'}
      ,{33,'ext_injury_diag_code'}
      ,{34,'facility_lab_addr'}
      ,{35,'facility_lab_city'}
      ,{36,'facility_lab_name'}
      ,{37,'facility_lab_npi'}
      ,{38,'facility_lab_state'}
      ,{39,'facility_lab_tax_id'}
      ,{40,'facility_lab_type_code'}
      ,{41,'facility_lab_zip'}
      ,{42,'ordering_prov_addr'}
      ,{43,'ordering_prov_city'}
      ,{44,'ordering_prov_first_name'}
      ,{45,'ordering_prov_last_name'}
      ,{46,'ordering_prov_middle_name'}
      ,{47,'ordering_prov_npi'}
      ,{48,'ordering_prov_state'}
      ,{49,'ordering_prov_upin'}
      ,{50,'ordering_prov_zip'}
      ,{51,'pay_to_addr'}
      ,{52,'pay_to_city'}
      ,{53,'pay_to_first_name'}
      ,{54,'pay_to_last_name'}
      ,{55,'pay_to_middle_name'}
      ,{56,'pay_to_npi'}
      ,{57,'pay_to_service_phone'}
      ,{58,'pay_to_state'}
      ,{59,'pay_to_tax_id'}
      ,{60,'pay_to_zip'}
      ,{61,'performing_prov_phone'}
      ,{62,'performing_prov_specialty'}
      ,{63,'performing_prov_tax_id'}
      ,{64,'place_of_service_code'}
      ,{65,'place_of_service_name'}
      ,{66,'prov_a_addr'}
      ,{67,'prov_a_city'}
      ,{68,'prov_a_service_role_code'}
      ,{69,'prov_a_state'}
      ,{70,'prov_a_zip'}
      ,{71,'prov_b_addr'}
      ,{72,'prov_b_city'}
      ,{73,'prov_b_service_role_code'}
      ,{74,'prov_b_state'}
      ,{75,'prov_b_zip'}
      ,{76,'prov_c_addr'}
      ,{77,'prov_c_city'}
      ,{78,'prov_c_service_role_code'}
      ,{79,'prov_c_state'}
      ,{80,'prov_c_zip'}
      ,{81,'purch_service_first_name'}
      ,{82,'purch_service_last_name'}
      ,{83,'purch_service_middle_name'}
      ,{84,'purch_service_npi'}
      ,{85,'purch_service_prov_addr'}
      ,{86,'purch_service_prov_city'}
      ,{87,'purch_service_prov_name'}
      ,{88,'purch_service_prov_phone'}
      ,{89,'purch_service_prov_state'}
      ,{90,'purch_service_prov_zip'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    MX_Fields.InValid_claim_type((SALT31.StrType)le.claim_type),
    MX_Fields.InValid_claim_num((SALT31.StrType)le.claim_num),
    MX_Fields.InValid_billing_pay_to_taxonomy((SALT31.StrType)le.billing_pay_to_taxonomy),
    MX_Fields.InValid_billing_addr((SALT31.StrType)le.billing_addr),
    MX_Fields.InValid_billing_anesth_lic((SALT31.StrType)le.billing_anesth_lic),
    MX_Fields.InValid_billing_city((SALT31.StrType)le.billing_city),
    MX_Fields.InValid_billing_dentist_lic((SALT31.StrType)le.billing_dentist_lic),
    MX_Fields.InValid_billing_first_name((SALT31.StrType)le.billing_first_name),
    MX_Fields.InValid_billing_last_name((SALT31.StrType)le.billing_last_name),
    MX_Fields.InValid_billing_middle_name((SALT31.StrType)le.billing_middle_name),
    MX_Fields.InValid_billing_npi((SALT31.StrType)le.billing_npi),
    MX_Fields.InValid_billing_org_name((SALT31.StrType)le.billing_org_name),
    MX_Fields.InValid_billing_service_phone((SALT31.StrType)le.billing_service_phone),
    MX_Fields.InValid_billing_specialty_code((SALT31.StrType)le.billing_specialty_code),
    MX_Fields.InValid_billing_specialty_lic((SALT31.StrType)le.billing_specialty_lic),
    MX_Fields.InValid_billing_state((SALT31.StrType)le.billing_state),
    MX_Fields.InValid_billing_state_lic((SALT31.StrType)le.billing_state_lic),
    MX_Fields.InValid_billing_tax_id((SALT31.StrType)le.billing_tax_id),
    MX_Fields.InValid_billing_upin((SALT31.StrType)le.billing_upin),
    MX_Fields.InValid_billing_zip((SALT31.StrType)le.billing_zip),
    MX_Fields.InValid_diag_code1((SALT31.StrType)le.diag_code1),
    MX_Fields.InValid_diag_code2((SALT31.StrType)le.diag_code2),
    MX_Fields.InValid_diag_code3((SALT31.StrType)le.diag_code3),
    MX_Fields.InValid_diag_code4((SALT31.StrType)le.diag_code4),
    MX_Fields.InValid_diag_code5((SALT31.StrType)le.diag_code5),
    MX_Fields.InValid_diag_code6((SALT31.StrType)le.diag_code6),
    MX_Fields.InValid_diag_code7((SALT31.StrType)le.diag_code7),
    MX_Fields.InValid_diag_code8((SALT31.StrType)le.diag_code8),
    MX_Fields.InValid_dme_hcpcs_proc_code((SALT31.StrType)le.dme_hcpcs_proc_code),
    MX_Fields.InValid_emt_paramedic_first_name((SALT31.StrType)le.emt_paramedic_first_name),
    MX_Fields.InValid_emt_paramedic_last_name((SALT31.StrType)le.emt_paramedic_last_name),
    MX_Fields.InValid_emt_paramedic_middle_name((SALT31.StrType)le.emt_paramedic_middle_name),
    MX_Fields.InValid_ext_injury_diag_code((SALT31.StrType)le.ext_injury_diag_code),
    MX_Fields.InValid_facility_lab_addr((SALT31.StrType)le.facility_lab_addr),
    MX_Fields.InValid_facility_lab_city((SALT31.StrType)le.facility_lab_city),
    MX_Fields.InValid_facility_lab_name((SALT31.StrType)le.facility_lab_name),
    MX_Fields.InValid_facility_lab_npi((SALT31.StrType)le.facility_lab_npi),
    MX_Fields.InValid_facility_lab_state((SALT31.StrType)le.facility_lab_state),
    MX_Fields.InValid_facility_lab_tax_id((SALT31.StrType)le.facility_lab_tax_id),
    MX_Fields.InValid_facility_lab_type_code((SALT31.StrType)le.facility_lab_type_code),
    MX_Fields.InValid_facility_lab_zip((SALT31.StrType)le.facility_lab_zip),
    MX_Fields.InValid_ordering_prov_addr((SALT31.StrType)le.ordering_prov_addr),
    MX_Fields.InValid_ordering_prov_city((SALT31.StrType)le.ordering_prov_city),
    MX_Fields.InValid_ordering_prov_first_name((SALT31.StrType)le.ordering_prov_first_name),
    MX_Fields.InValid_ordering_prov_last_name((SALT31.StrType)le.ordering_prov_last_name),
    MX_Fields.InValid_ordering_prov_middle_name((SALT31.StrType)le.ordering_prov_middle_name),
    MX_Fields.InValid_ordering_prov_npi((SALT31.StrType)le.ordering_prov_npi),
    MX_Fields.InValid_ordering_prov_state((SALT31.StrType)le.ordering_prov_state),
    MX_Fields.InValid_ordering_prov_upin((SALT31.StrType)le.ordering_prov_upin),
    MX_Fields.InValid_ordering_prov_zip((SALT31.StrType)le.ordering_prov_zip),
    MX_Fields.InValid_pay_to_addr((SALT31.StrType)le.pay_to_addr),
    MX_Fields.InValid_pay_to_city((SALT31.StrType)le.pay_to_city),
    MX_Fields.InValid_pay_to_first_name((SALT31.StrType)le.pay_to_first_name),
    MX_Fields.InValid_pay_to_last_name((SALT31.StrType)le.pay_to_last_name),
    MX_Fields.InValid_pay_to_middle_name((SALT31.StrType)le.pay_to_middle_name),
    MX_Fields.InValid_pay_to_npi((SALT31.StrType)le.pay_to_npi),
    MX_Fields.InValid_pay_to_service_phone((SALT31.StrType)le.pay_to_service_phone),
    MX_Fields.InValid_pay_to_state((SALT31.StrType)le.pay_to_state),
    MX_Fields.InValid_pay_to_tax_id((SALT31.StrType)le.pay_to_tax_id),
    MX_Fields.InValid_pay_to_zip((SALT31.StrType)le.pay_to_zip),
    MX_Fields.InValid_performing_prov_phone((SALT31.StrType)le.performing_prov_phone),
    MX_Fields.InValid_performing_prov_specialty((SALT31.StrType)le.performing_prov_specialty),
    MX_Fields.InValid_performing_prov_tax_id((SALT31.StrType)le.performing_prov_tax_id),
    MX_Fields.InValid_place_of_service_code((SALT31.StrType)le.place_of_service_code),
    MX_Fields.InValid_place_of_service_name((SALT31.StrType)le.place_of_service_name),
    MX_Fields.InValid_prov_a_addr((SALT31.StrType)le.prov_a_addr),
    MX_Fields.InValid_prov_a_city((SALT31.StrType)le.prov_a_city),
    MX_Fields.InValid_prov_a_service_role_code((SALT31.StrType)le.prov_a_service_role_code),
    MX_Fields.InValid_prov_a_state((SALT31.StrType)le.prov_a_state),
    MX_Fields.InValid_prov_a_zip((SALT31.StrType)le.prov_a_zip),
    MX_Fields.InValid_prov_b_addr((SALT31.StrType)le.prov_b_addr),
    MX_Fields.InValid_prov_b_city((SALT31.StrType)le.prov_b_city),
    MX_Fields.InValid_prov_b_service_role_code((SALT31.StrType)le.prov_b_service_role_code),
    MX_Fields.InValid_prov_b_state((SALT31.StrType)le.prov_b_state),
    MX_Fields.InValid_prov_b_zip((SALT31.StrType)le.prov_b_zip),
    MX_Fields.InValid_prov_c_addr((SALT31.StrType)le.prov_c_addr),
    MX_Fields.InValid_prov_c_city((SALT31.StrType)le.prov_c_city),
    MX_Fields.InValid_prov_c_service_role_code((SALT31.StrType)le.prov_c_service_role_code),
    MX_Fields.InValid_prov_c_state((SALT31.StrType)le.prov_c_state),
    MX_Fields.InValid_prov_c_zip((SALT31.StrType)le.prov_c_zip),
    MX_Fields.InValid_purch_service_first_name((SALT31.StrType)le.purch_service_first_name),
    MX_Fields.InValid_purch_service_last_name((SALT31.StrType)le.purch_service_last_name),
    MX_Fields.InValid_purch_service_middle_name((SALT31.StrType)le.purch_service_middle_name),
    MX_Fields.InValid_purch_service_npi((SALT31.StrType)le.purch_service_npi),
    MX_Fields.InValid_purch_service_prov_addr((SALT31.StrType)le.purch_service_prov_addr),
    MX_Fields.InValid_purch_service_prov_city((SALT31.StrType)le.purch_service_prov_city),
    MX_Fields.InValid_purch_service_prov_name((SALT31.StrType)le.purch_service_prov_name),
    MX_Fields.InValid_purch_service_prov_phone((SALT31.StrType)le.purch_service_prov_phone),
    MX_Fields.InValid_purch_service_prov_state((SALT31.StrType)le.purch_service_prov_state),
    MX_Fields.InValid_purch_service_prov_zip((SALT31.StrType)le.purch_service_prov_zip),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,90,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := MX_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'claim_type','claim_num','Unknown','billing_addr','Unknown','billing_city','Unknown','billing_first_name','billing_last_name','Unknown','billing_npi','billing_org_name','Unknown','billing_specialty_code','Unknown','billing_state','Unknown','billing_tax_id','billing_upin','billing_zip','diag_code1','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','Unknown','Unknown','Unknown','Unknown','ext_injury_diag_code','facility_lab_addr','facility_lab_city','facility_lab_name','facility_lab_npi','facility_lab_state','Unknown','Unknown','facility_lab_zip','Unknown','Unknown','ordering_prov_first_name','ordering_prov_last_name','ordering_prov_middle_name','ordering_prov_npi','ordering_prov_state','Unknown','Unknown','pay_to_addr','pay_to_city','Unknown','Unknown','Unknown','Unknown','Unknown','pay_to_state','Unknown','pay_to_zip','Unknown','Unknown','performing_prov_tax_id','place_of_service_code','place_of_service_name','prov_a_addr','prov_a_city','prov_a_service_role_code','prov_a_state','prov_a_zip','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,MX_Fields.InValidMessage_claim_type(TotalErrors.ErrorNum),MX_Fields.InValidMessage_claim_num(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_pay_to_taxonomy(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_addr(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_anesth_lic(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_city(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_dentist_lic(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_first_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_last_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_middle_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_npi(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_org_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_service_phone(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_specialty_code(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_specialty_lic(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_state(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_state_lic(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_tax_id(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_upin(TotalErrors.ErrorNum),MX_Fields.InValidMessage_billing_zip(TotalErrors.ErrorNum),MX_Fields.InValidMessage_diag_code1(TotalErrors.ErrorNum),MX_Fields.InValidMessage_diag_code2(TotalErrors.ErrorNum),MX_Fields.InValidMessage_diag_code3(TotalErrors.ErrorNum),MX_Fields.InValidMessage_diag_code4(TotalErrors.ErrorNum),MX_Fields.InValidMessage_diag_code5(TotalErrors.ErrorNum),MX_Fields.InValidMessage_diag_code6(TotalErrors.ErrorNum),MX_Fields.InValidMessage_diag_code7(TotalErrors.ErrorNum),MX_Fields.InValidMessage_diag_code8(TotalErrors.ErrorNum),MX_Fields.InValidMessage_dme_hcpcs_proc_code(TotalErrors.ErrorNum),MX_Fields.InValidMessage_emt_paramedic_first_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_emt_paramedic_last_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_emt_paramedic_middle_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_ext_injury_diag_code(TotalErrors.ErrorNum),MX_Fields.InValidMessage_facility_lab_addr(TotalErrors.ErrorNum),MX_Fields.InValidMessage_facility_lab_city(TotalErrors.ErrorNum),MX_Fields.InValidMessage_facility_lab_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_facility_lab_npi(TotalErrors.ErrorNum),MX_Fields.InValidMessage_facility_lab_state(TotalErrors.ErrorNum),MX_Fields.InValidMessage_facility_lab_tax_id(TotalErrors.ErrorNum),MX_Fields.InValidMessage_facility_lab_type_code(TotalErrors.ErrorNum),MX_Fields.InValidMessage_facility_lab_zip(TotalErrors.ErrorNum),MX_Fields.InValidMessage_ordering_prov_addr(TotalErrors.ErrorNum),MX_Fields.InValidMessage_ordering_prov_city(TotalErrors.ErrorNum),MX_Fields.InValidMessage_ordering_prov_first_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_ordering_prov_last_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_ordering_prov_middle_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_ordering_prov_npi(TotalErrors.ErrorNum),MX_Fields.InValidMessage_ordering_prov_state(TotalErrors.ErrorNum),MX_Fields.InValidMessage_ordering_prov_upin(TotalErrors.ErrorNum),MX_Fields.InValidMessage_ordering_prov_zip(TotalErrors.ErrorNum),MX_Fields.InValidMessage_pay_to_addr(TotalErrors.ErrorNum),MX_Fields.InValidMessage_pay_to_city(TotalErrors.ErrorNum),MX_Fields.InValidMessage_pay_to_first_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_pay_to_last_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_pay_to_middle_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_pay_to_npi(TotalErrors.ErrorNum),MX_Fields.InValidMessage_pay_to_service_phone(TotalErrors.ErrorNum),MX_Fields.InValidMessage_pay_to_state(TotalErrors.ErrorNum),MX_Fields.InValidMessage_pay_to_tax_id(TotalErrors.ErrorNum),MX_Fields.InValidMessage_pay_to_zip(TotalErrors.ErrorNum),MX_Fields.InValidMessage_performing_prov_phone(TotalErrors.ErrorNum),MX_Fields.InValidMessage_performing_prov_specialty(TotalErrors.ErrorNum),MX_Fields.InValidMessage_performing_prov_tax_id(TotalErrors.ErrorNum),MX_Fields.InValidMessage_place_of_service_code(TotalErrors.ErrorNum),MX_Fields.InValidMessage_place_of_service_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_a_addr(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_a_city(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_a_service_role_code(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_a_state(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_a_zip(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_b_addr(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_b_city(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_b_service_role_code(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_b_state(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_b_zip(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_c_addr(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_c_city(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_c_service_role_code(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_c_state(TotalErrors.ErrorNum),MX_Fields.InValidMessage_prov_c_zip(TotalErrors.ErrorNum),MX_Fields.InValidMessage_purch_service_first_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_purch_service_last_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_purch_service_middle_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_purch_service_npi(TotalErrors.ErrorNum),MX_Fields.InValidMessage_purch_service_prov_addr(TotalErrors.ErrorNum),MX_Fields.InValidMessage_purch_service_prov_city(TotalErrors.ErrorNum),MX_Fields.InValidMessage_purch_service_prov_name(TotalErrors.ErrorNum),MX_Fields.InValidMessage_purch_service_prov_phone(TotalErrors.ErrorNum),MX_Fields.InValidMessage_purch_service_prov_state(TotalErrors.ErrorNum),MX_Fields.InValidMessage_purch_service_prov_zip(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
