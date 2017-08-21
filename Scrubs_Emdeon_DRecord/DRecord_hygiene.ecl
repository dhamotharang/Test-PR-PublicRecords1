IMPORT ut,SALT31;
EXPORT DRecord_hygiene(dataset(DRecord_layout_DRecord) h) := MODULE
 
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
    populated_diag_code9_pcnt := AVE(GROUP,IF(h.diag_code9 = (TYPEOF(h.diag_code9))'',0,100));
    maxlength_diag_code9 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code9)));
    avelength_diag_code9 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code9)),h.diag_code9<>(typeof(h.diag_code9))'');
    populated_diag_code10_pcnt := AVE(GROUP,IF(h.diag_code10 = (TYPEOF(h.diag_code10))'',0,100));
    maxlength_diag_code10 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code10)));
    avelength_diag_code10 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code10)),h.diag_code10<>(typeof(h.diag_code10))'');
    populated_diag_code11_pcnt := AVE(GROUP,IF(h.diag_code11 = (TYPEOF(h.diag_code11))'',0,100));
    maxlength_diag_code11 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code11)));
    avelength_diag_code11 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code11)),h.diag_code11<>(typeof(h.diag_code11))'');
    populated_diag_code12_pcnt := AVE(GROUP,IF(h.diag_code12 = (TYPEOF(h.diag_code12))'',0,100));
    maxlength_diag_code12 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code12)));
    avelength_diag_code12 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code12)),h.diag_code12<>(typeof(h.diag_code12))'');
    populated_diag_code13_pcnt := AVE(GROUP,IF(h.diag_code13 = (TYPEOF(h.diag_code13))'',0,100));
    maxlength_diag_code13 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code13)));
    avelength_diag_code13 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code13)),h.diag_code13<>(typeof(h.diag_code13))'');
    populated_diag_code14_pcnt := AVE(GROUP,IF(h.diag_code14 = (TYPEOF(h.diag_code14))'',0,100));
    maxlength_diag_code14 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code14)));
    avelength_diag_code14 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code14)),h.diag_code14<>(typeof(h.diag_code14))'');
    populated_diag_code15_pcnt := AVE(GROUP,IF(h.diag_code15 = (TYPEOF(h.diag_code15))'',0,100));
    maxlength_diag_code15 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code15)));
    avelength_diag_code15 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code15)),h.diag_code15<>(typeof(h.diag_code15))'');
    populated_diag_code16_pcnt := AVE(GROUP,IF(h.diag_code16 = (TYPEOF(h.diag_code16))'',0,100));
    maxlength_diag_code16 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code16)));
    avelength_diag_code16 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code16)),h.diag_code16<>(typeof(h.diag_code16))'');
    populated_diag_code17_pcnt := AVE(GROUP,IF(h.diag_code17 = (TYPEOF(h.diag_code17))'',0,100));
    maxlength_diag_code17 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code17)));
    avelength_diag_code17 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code17)),h.diag_code17<>(typeof(h.diag_code17))'');
    populated_diag_code18_pcnt := AVE(GROUP,IF(h.diag_code18 = (TYPEOF(h.diag_code18))'',0,100));
    maxlength_diag_code18 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code18)));
    avelength_diag_code18 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code18)),h.diag_code18<>(typeof(h.diag_code18))'');
    populated_diag_code19_pcnt := AVE(GROUP,IF(h.diag_code19 = (TYPEOF(h.diag_code19))'',0,100));
    maxlength_diag_code19 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code19)));
    avelength_diag_code19 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code19)),h.diag_code19<>(typeof(h.diag_code19))'');
    populated_diag_code20_pcnt := AVE(GROUP,IF(h.diag_code20 = (TYPEOF(h.diag_code20))'',0,100));
    maxlength_diag_code20 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code20)));
    avelength_diag_code20 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code20)),h.diag_code20<>(typeof(h.diag_code20))'');
    populated_diag_code21_pcnt := AVE(GROUP,IF(h.diag_code21 = (TYPEOF(h.diag_code21))'',0,100));
    maxlength_diag_code21 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code21)));
    avelength_diag_code21 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code21)),h.diag_code21<>(typeof(h.diag_code21))'');
    populated_diag_code22_pcnt := AVE(GROUP,IF(h.diag_code22 = (TYPEOF(h.diag_code22))'',0,100));
    maxlength_diag_code22 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code22)));
    avelength_diag_code22 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code22)),h.diag_code22<>(typeof(h.diag_code22))'');
    populated_diag_code23_pcnt := AVE(GROUP,IF(h.diag_code23 = (TYPEOF(h.diag_code23))'',0,100));
    maxlength_diag_code23 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code23)));
    avelength_diag_code23 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code23)),h.diag_code23<>(typeof(h.diag_code23))'');
    populated_diag_code24_pcnt := AVE(GROUP,IF(h.diag_code24 = (TYPEOF(h.diag_code24))'',0,100));
    maxlength_diag_code24 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code24)));
    avelength_diag_code24 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.diag_code24)),h.diag_code24<>(typeof(h.diag_code24))'');
    populated_other_proc7_pcnt := AVE(GROUP,IF(h.other_proc7 = (TYPEOF(h.other_proc7))'',0,100));
    maxlength_other_proc7 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc7)));
    avelength_other_proc7 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc7)),h.other_proc7<>(typeof(h.other_proc7))'');
    populated_other_proc8_pcnt := AVE(GROUP,IF(h.other_proc8 = (TYPEOF(h.other_proc8))'',0,100));
    maxlength_other_proc8 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc8)));
    avelength_other_proc8 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc8)),h.other_proc8<>(typeof(h.other_proc8))'');
    populated_other_proc9_pcnt := AVE(GROUP,IF(h.other_proc9 = (TYPEOF(h.other_proc9))'',0,100));
    maxlength_other_proc9 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc9)));
    avelength_other_proc9 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc9)),h.other_proc9<>(typeof(h.other_proc9))'');
    populated_other_proc10_pcnt := AVE(GROUP,IF(h.other_proc10 = (TYPEOF(h.other_proc10))'',0,100));
    maxlength_other_proc10 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc10)));
    avelength_other_proc10 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc10)),h.other_proc10<>(typeof(h.other_proc10))'');
    populated_other_proc11_pcnt := AVE(GROUP,IF(h.other_proc11 = (TYPEOF(h.other_proc11))'',0,100));
    maxlength_other_proc11 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc11)));
    avelength_other_proc11 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc11)),h.other_proc11<>(typeof(h.other_proc11))'');
    populated_other_proc12_pcnt := AVE(GROUP,IF(h.other_proc12 = (TYPEOF(h.other_proc12))'',0,100));
    maxlength_other_proc12 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc12)));
    avelength_other_proc12 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc12)),h.other_proc12<>(typeof(h.other_proc12))'');
    populated_other_proc13_pcnt := AVE(GROUP,IF(h.other_proc13 = (TYPEOF(h.other_proc13))'',0,100));
    maxlength_other_proc13 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc13)));
    avelength_other_proc13 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc13)),h.other_proc13<>(typeof(h.other_proc13))'');
    populated_other_proc14_pcnt := AVE(GROUP,IF(h.other_proc14 = (TYPEOF(h.other_proc14))'',0,100));
    maxlength_other_proc14 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc14)));
    avelength_other_proc14 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc14)),h.other_proc14<>(typeof(h.other_proc14))'');
    populated_other_proc15_pcnt := AVE(GROUP,IF(h.other_proc15 = (TYPEOF(h.other_proc15))'',0,100));
    maxlength_other_proc15 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc15)));
    avelength_other_proc15 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc15)),h.other_proc15<>(typeof(h.other_proc15))'');
    populated_other_proc16_pcnt := AVE(GROUP,IF(h.other_proc16 = (TYPEOF(h.other_proc16))'',0,100));
    maxlength_other_proc16 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc16)));
    avelength_other_proc16 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc16)),h.other_proc16<>(typeof(h.other_proc16))'');
    populated_other_proc17_pcnt := AVE(GROUP,IF(h.other_proc17 = (TYPEOF(h.other_proc17))'',0,100));
    maxlength_other_proc17 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc17)));
    avelength_other_proc17 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc17)),h.other_proc17<>(typeof(h.other_proc17))'');
    populated_other_proc18_pcnt := AVE(GROUP,IF(h.other_proc18 = (TYPEOF(h.other_proc18))'',0,100));
    maxlength_other_proc18 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc18)));
    avelength_other_proc18 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc18)),h.other_proc18<>(typeof(h.other_proc18))'');
    populated_other_proc19_pcnt := AVE(GROUP,IF(h.other_proc19 = (TYPEOF(h.other_proc19))'',0,100));
    maxlength_other_proc19 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc19)));
    avelength_other_proc19 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc19)),h.other_proc19<>(typeof(h.other_proc19))'');
    populated_other_proc20_pcnt := AVE(GROUP,IF(h.other_proc20 = (TYPEOF(h.other_proc20))'',0,100));
    maxlength_other_proc20 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc20)));
    avelength_other_proc20 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc20)),h.other_proc20<>(typeof(h.other_proc20))'');
    populated_other_proc21_pcnt := AVE(GROUP,IF(h.other_proc21 = (TYPEOF(h.other_proc21))'',0,100));
    maxlength_other_proc21 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc21)));
    avelength_other_proc21 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc21)),h.other_proc21<>(typeof(h.other_proc21))'');
    populated_other_proc22_pcnt := AVE(GROUP,IF(h.other_proc22 = (TYPEOF(h.other_proc22))'',0,100));
    maxlength_other_proc22 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc22)));
    avelength_other_proc22 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc22)),h.other_proc22<>(typeof(h.other_proc22))'');
    populated_claim_indicator_code_pcnt := AVE(GROUP,IF(h.claim_indicator_code = (TYPEOF(h.claim_indicator_code))'',0,100));
    maxlength_claim_indicator_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_indicator_code)));
    avelength_claim_indicator_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_indicator_code)),h.claim_indicator_code<>(typeof(h.claim_indicator_code))'');
    populated_ref_prov_state_lic_pcnt := AVE(GROUP,IF(h.ref_prov_state_lic = (TYPEOF(h.ref_prov_state_lic))'',0,100));
    maxlength_ref_prov_state_lic := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ref_prov_state_lic)));
    avelength_ref_prov_state_lic := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ref_prov_state_lic)),h.ref_prov_state_lic<>(typeof(h.ref_prov_state_lic))'');
    populated_ref_prov_upin_pcnt := AVE(GROUP,IF(h.ref_prov_upin = (TYPEOF(h.ref_prov_upin))'',0,100));
    maxlength_ref_prov_upin := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ref_prov_upin)));
    avelength_ref_prov_upin := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ref_prov_upin)),h.ref_prov_upin<>(typeof(h.ref_prov_upin))'');
    populated_ref_prov_commercial_id_pcnt := AVE(GROUP,IF(h.ref_prov_commercial_id = (TYPEOF(h.ref_prov_commercial_id))'',0,100));
    maxlength_ref_prov_commercial_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.ref_prov_commercial_id)));
    avelength_ref_prov_commercial_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.ref_prov_commercial_id)),h.ref_prov_commercial_id<>(typeof(h.ref_prov_commercial_id))'');
    populated_pay_to_address1_pcnt := AVE(GROUP,IF(h.pay_to_address1 = (TYPEOF(h.pay_to_address1))'',0,100));
    maxlength_pay_to_address1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_address1)));
    avelength_pay_to_address1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_address1)),h.pay_to_address1<>(typeof(h.pay_to_address1))'');
    populated_pay_to_address2_pcnt := AVE(GROUP,IF(h.pay_to_address2 = (TYPEOF(h.pay_to_address2))'',0,100));
    maxlength_pay_to_address2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_address2)));
    avelength_pay_to_address2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_address2)),h.pay_to_address2<>(typeof(h.pay_to_address2))'');
    populated_pay_to_city_pcnt := AVE(GROUP,IF(h.pay_to_city = (TYPEOF(h.pay_to_city))'',0,100));
    maxlength_pay_to_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_city)));
    avelength_pay_to_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_city)),h.pay_to_city<>(typeof(h.pay_to_city))'');
    populated_pay_to_zip_pcnt := AVE(GROUP,IF(h.pay_to_zip = (TYPEOF(h.pay_to_zip))'',0,100));
    maxlength_pay_to_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_zip)));
    avelength_pay_to_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_zip)),h.pay_to_zip<>(typeof(h.pay_to_zip))'');
    populated_pay_to_state_pcnt := AVE(GROUP,IF(h.pay_to_state = (TYPEOF(h.pay_to_state))'',0,100));
    maxlength_pay_to_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_state)));
    avelength_pay_to_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_state)),h.pay_to_state<>(typeof(h.pay_to_state))'');
    populated_supervising_prov_org_name_pcnt := AVE(GROUP,IF(h.supervising_prov_org_name = (TYPEOF(h.supervising_prov_org_name))'',0,100));
    maxlength_supervising_prov_org_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_org_name)));
    avelength_supervising_prov_org_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_org_name)),h.supervising_prov_org_name<>(typeof(h.supervising_prov_org_name))'');
    populated_supervising_prov_last_name_pcnt := AVE(GROUP,IF(h.supervising_prov_last_name = (TYPEOF(h.supervising_prov_last_name))'',0,100));
    maxlength_supervising_prov_last_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_last_name)));
    avelength_supervising_prov_last_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_last_name)),h.supervising_prov_last_name<>(typeof(h.supervising_prov_last_name))'');
    populated_supervising_prov_first_name_pcnt := AVE(GROUP,IF(h.supervising_prov_first_name = (TYPEOF(h.supervising_prov_first_name))'',0,100));
    maxlength_supervising_prov_first_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_first_name)));
    avelength_supervising_prov_first_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_first_name)),h.supervising_prov_first_name<>(typeof(h.supervising_prov_first_name))'');
    populated_supervising_prov_middle_name_pcnt := AVE(GROUP,IF(h.supervising_prov_middle_name = (TYPEOF(h.supervising_prov_middle_name))'',0,100));
    maxlength_supervising_prov_middle_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_middle_name)));
    avelength_supervising_prov_middle_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_middle_name)),h.supervising_prov_middle_name<>(typeof(h.supervising_prov_middle_name))'');
    populated_supervising_prov_npi_pcnt := AVE(GROUP,IF(h.supervising_prov_npi = (TYPEOF(h.supervising_prov_npi))'',0,100));
    maxlength_supervising_prov_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_npi)));
    avelength_supervising_prov_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_npi)),h.supervising_prov_npi<>(typeof(h.supervising_prov_npi))'');
    populated_supervising_prov_state_lic_pcnt := AVE(GROUP,IF(h.supervising_prov_state_lic = (TYPEOF(h.supervising_prov_state_lic))'',0,100));
    maxlength_supervising_prov_state_lic := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_state_lic)));
    avelength_supervising_prov_state_lic := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_state_lic)),h.supervising_prov_state_lic<>(typeof(h.supervising_prov_state_lic))'');
    populated_supervising_prov_upin_pcnt := AVE(GROUP,IF(h.supervising_prov_upin = (TYPEOF(h.supervising_prov_upin))'',0,100));
    maxlength_supervising_prov_upin := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_upin)));
    avelength_supervising_prov_upin := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_upin)),h.supervising_prov_upin<>(typeof(h.supervising_prov_upin))'');
    populated_supervising_prov_commercial_id_pcnt := AVE(GROUP,IF(h.supervising_prov_commercial_id = (TYPEOF(h.supervising_prov_commercial_id))'',0,100));
    maxlength_supervising_prov_commercial_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_commercial_id)));
    avelength_supervising_prov_commercial_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_commercial_id)),h.supervising_prov_commercial_id<>(typeof(h.supervising_prov_commercial_id))'');
    populated_supervising_prov_location_pcnt := AVE(GROUP,IF(h.supervising_prov_location = (TYPEOF(h.supervising_prov_location))'',0,100));
    maxlength_supervising_prov_location := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_location)));
    avelength_supervising_prov_location := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.supervising_prov_location)),h.supervising_prov_location<>(typeof(h.supervising_prov_location))'');
    populated_operating_prov_org_name_pcnt := AVE(GROUP,IF(h.operating_prov_org_name = (TYPEOF(h.operating_prov_org_name))'',0,100));
    maxlength_operating_prov_org_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_org_name)));
    avelength_operating_prov_org_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_org_name)),h.operating_prov_org_name<>(typeof(h.operating_prov_org_name))'');
    populated_operating_prov_last_name_pcnt := AVE(GROUP,IF(h.operating_prov_last_name = (TYPEOF(h.operating_prov_last_name))'',0,100));
    maxlength_operating_prov_last_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_last_name)));
    avelength_operating_prov_last_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_last_name)),h.operating_prov_last_name<>(typeof(h.operating_prov_last_name))'');
    populated_operating_prov_first_name_pcnt := AVE(GROUP,IF(h.operating_prov_first_name = (TYPEOF(h.operating_prov_first_name))'',0,100));
    maxlength_operating_prov_first_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_first_name)));
    avelength_operating_prov_first_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_first_name)),h.operating_prov_first_name<>(typeof(h.operating_prov_first_name))'');
    populated_operating_prov_middle_name_pcnt := AVE(GROUP,IF(h.operating_prov_middle_name = (TYPEOF(h.operating_prov_middle_name))'',0,100));
    maxlength_operating_prov_middle_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_middle_name)));
    avelength_operating_prov_middle_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_middle_name)),h.operating_prov_middle_name<>(typeof(h.operating_prov_middle_name))'');
    populated_operating_prov_npi_pcnt := AVE(GROUP,IF(h.operating_prov_npi = (TYPEOF(h.operating_prov_npi))'',0,100));
    maxlength_operating_prov_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_npi)));
    avelength_operating_prov_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_npi)),h.operating_prov_npi<>(typeof(h.operating_prov_npi))'');
    populated_operating_prov_state_lic_pcnt := AVE(GROUP,IF(h.operating_prov_state_lic = (TYPEOF(h.operating_prov_state_lic))'',0,100));
    maxlength_operating_prov_state_lic := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_state_lic)));
    avelength_operating_prov_state_lic := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_state_lic)),h.operating_prov_state_lic<>(typeof(h.operating_prov_state_lic))'');
    populated_operating_prov_upin_pcnt := AVE(GROUP,IF(h.operating_prov_upin = (TYPEOF(h.operating_prov_upin))'',0,100));
    maxlength_operating_prov_upin := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_upin)));
    avelength_operating_prov_upin := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_upin)),h.operating_prov_upin<>(typeof(h.operating_prov_upin))'');
    populated_operating_prov_commercial_id_pcnt := AVE(GROUP,IF(h.operating_prov_commercial_id = (TYPEOF(h.operating_prov_commercial_id))'',0,100));
    maxlength_operating_prov_commercial_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_commercial_id)));
    avelength_operating_prov_commercial_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_commercial_id)),h.operating_prov_commercial_id<>(typeof(h.operating_prov_commercial_id))'');
    populated_operating_prov_location_pcnt := AVE(GROUP,IF(h.operating_prov_location = (TYPEOF(h.operating_prov_location))'',0,100));
    maxlength_operating_prov_location := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_location)));
    avelength_operating_prov_location := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.operating_prov_location)),h.operating_prov_location<>(typeof(h.operating_prov_location))'');
    populated_other_operating_prov_org_name_pcnt := AVE(GROUP,IF(h.other_operating_prov_org_name = (TYPEOF(h.other_operating_prov_org_name))'',0,100));
    maxlength_other_operating_prov_org_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_org_name)));
    avelength_other_operating_prov_org_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_org_name)),h.other_operating_prov_org_name<>(typeof(h.other_operating_prov_org_name))'');
    populated_other_operating_prov_last_name_pcnt := AVE(GROUP,IF(h.other_operating_prov_last_name = (TYPEOF(h.other_operating_prov_last_name))'',0,100));
    maxlength_other_operating_prov_last_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_last_name)));
    avelength_other_operating_prov_last_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_last_name)),h.other_operating_prov_last_name<>(typeof(h.other_operating_prov_last_name))'');
    populated_other_operating_prov_first_name_pcnt := AVE(GROUP,IF(h.other_operating_prov_first_name = (TYPEOF(h.other_operating_prov_first_name))'',0,100));
    maxlength_other_operating_prov_first_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_first_name)));
    avelength_other_operating_prov_first_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_first_name)),h.other_operating_prov_first_name<>(typeof(h.other_operating_prov_first_name))'');
    populated_other_operating_prov_middle_name_pcnt := AVE(GROUP,IF(h.other_operating_prov_middle_name = (TYPEOF(h.other_operating_prov_middle_name))'',0,100));
    maxlength_other_operating_prov_middle_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_middle_name)));
    avelength_other_operating_prov_middle_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_middle_name)),h.other_operating_prov_middle_name<>(typeof(h.other_operating_prov_middle_name))'');
    populated_other_operating_prov_npi_pcnt := AVE(GROUP,IF(h.other_operating_prov_npi = (TYPEOF(h.other_operating_prov_npi))'',0,100));
    maxlength_other_operating_prov_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_npi)));
    avelength_other_operating_prov_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_npi)),h.other_operating_prov_npi<>(typeof(h.other_operating_prov_npi))'');
    populated_other_operating_prov_state_lic_pcnt := AVE(GROUP,IF(h.other_operating_prov_state_lic = (TYPEOF(h.other_operating_prov_state_lic))'',0,100));
    maxlength_other_operating_prov_state_lic := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_state_lic)));
    avelength_other_operating_prov_state_lic := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_state_lic)),h.other_operating_prov_state_lic<>(typeof(h.other_operating_prov_state_lic))'');
    populated_other_operating_prov_upin_pcnt := AVE(GROUP,IF(h.other_operating_prov_upin = (TYPEOF(h.other_operating_prov_upin))'',0,100));
    maxlength_other_operating_prov_upin := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_upin)));
    avelength_other_operating_prov_upin := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_upin)),h.other_operating_prov_upin<>(typeof(h.other_operating_prov_upin))'');
    populated_other_operating_prov_commercial_id_pcnt := AVE(GROUP,IF(h.other_operating_prov_commercial_id = (TYPEOF(h.other_operating_prov_commercial_id))'',0,100));
    maxlength_other_operating_prov_commercial_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_commercial_id)));
    avelength_other_operating_prov_commercial_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_commercial_id)),h.other_operating_prov_commercial_id<>(typeof(h.other_operating_prov_commercial_id))'');
    populated_other_operating_prov_location_pcnt := AVE(GROUP,IF(h.other_operating_prov_location = (TYPEOF(h.other_operating_prov_location))'',0,100));
    maxlength_other_operating_prov_location := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_location)));
    avelength_other_operating_prov_location := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_operating_prov_location)),h.other_operating_prov_location<>(typeof(h.other_operating_prov_location))'');
    populated_pay_to_plan_name_pcnt := AVE(GROUP,IF(h.pay_to_plan_name = (TYPEOF(h.pay_to_plan_name))'',0,100));
    maxlength_pay_to_plan_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_name)));
    avelength_pay_to_plan_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_name)),h.pay_to_plan_name<>(typeof(h.pay_to_plan_name))'');
    populated_pay_to_plan_address1_pcnt := AVE(GROUP,IF(h.pay_to_plan_address1 = (TYPEOF(h.pay_to_plan_address1))'',0,100));
    maxlength_pay_to_plan_address1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_address1)));
    avelength_pay_to_plan_address1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_address1)),h.pay_to_plan_address1<>(typeof(h.pay_to_plan_address1))'');
    populated_pay_to_plan_address2_pcnt := AVE(GROUP,IF(h.pay_to_plan_address2 = (TYPEOF(h.pay_to_plan_address2))'',0,100));
    maxlength_pay_to_plan_address2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_address2)));
    avelength_pay_to_plan_address2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_address2)),h.pay_to_plan_address2<>(typeof(h.pay_to_plan_address2))'');
    populated_pay_to_plan_city_pcnt := AVE(GROUP,IF(h.pay_to_plan_city = (TYPEOF(h.pay_to_plan_city))'',0,100));
    maxlength_pay_to_plan_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_city)));
    avelength_pay_to_plan_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_city)),h.pay_to_plan_city<>(typeof(h.pay_to_plan_city))'');
    populated_pay_to_plan_zip_pcnt := AVE(GROUP,IF(h.pay_to_plan_zip = (TYPEOF(h.pay_to_plan_zip))'',0,100));
    maxlength_pay_to_plan_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_zip)));
    avelength_pay_to_plan_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_zip)),h.pay_to_plan_zip<>(typeof(h.pay_to_plan_zip))'');
    populated_pay_to_plan_state_pcnt := AVE(GROUP,IF(h.pay_to_plan_state = (TYPEOF(h.pay_to_plan_state))'',0,100));
    maxlength_pay_to_plan_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_state)));
    avelength_pay_to_plan_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_state)),h.pay_to_plan_state<>(typeof(h.pay_to_plan_state))'');
    populated_pay_to_plan_naic_id_pcnt := AVE(GROUP,IF(h.pay_to_plan_naic_id = (TYPEOF(h.pay_to_plan_naic_id))'',0,100));
    maxlength_pay_to_plan_naic_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_naic_id)));
    avelength_pay_to_plan_naic_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_naic_id)),h.pay_to_plan_naic_id<>(typeof(h.pay_to_plan_naic_id))'');
    populated_pay_to_plan_payer_id_pcnt := AVE(GROUP,IF(h.pay_to_plan_payer_id = (TYPEOF(h.pay_to_plan_payer_id))'',0,100));
    maxlength_pay_to_plan_payer_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_payer_id)));
    avelength_pay_to_plan_payer_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_payer_id)),h.pay_to_plan_payer_id<>(typeof(h.pay_to_plan_payer_id))'');
    populated_pay_to_plan_plan_id_pcnt := AVE(GROUP,IF(h.pay_to_plan_plan_id = (TYPEOF(h.pay_to_plan_plan_id))'',0,100));
    maxlength_pay_to_plan_plan_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_plan_id)));
    avelength_pay_to_plan_plan_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_plan_id)),h.pay_to_plan_plan_id<>(typeof(h.pay_to_plan_plan_id))'');
    populated_pay_to_plan_claim_ofc_num_pcnt := AVE(GROUP,IF(h.pay_to_plan_claim_ofc_num = (TYPEOF(h.pay_to_plan_claim_ofc_num))'',0,100));
    maxlength_pay_to_plan_claim_ofc_num := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_claim_ofc_num)));
    avelength_pay_to_plan_claim_ofc_num := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_claim_ofc_num)),h.pay_to_plan_claim_ofc_num<>(typeof(h.pay_to_plan_claim_ofc_num))'');
    populated_pay_to_plan_tax_id_pcnt := AVE(GROUP,IF(h.pay_to_plan_tax_id = (TYPEOF(h.pay_to_plan_tax_id))'',0,100));
    maxlength_pay_to_plan_tax_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_tax_id)));
    avelength_pay_to_plan_tax_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.pay_to_plan_tax_id)),h.pay_to_plan_tax_id<>(typeof(h.pay_to_plan_tax_id))'');
    populated_cob1_payer_name_pcnt := AVE(GROUP,IF(h.cob1_payer_name = (TYPEOF(h.cob1_payer_name))'',0,100));
    maxlength_cob1_payer_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_payer_name)));
    avelength_cob1_payer_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_payer_name)),h.cob1_payer_name<>(typeof(h.cob1_payer_name))'');
    populated_cob1_payer_id_pcnt := AVE(GROUP,IF(h.cob1_payer_id = (TYPEOF(h.cob1_payer_id))'',0,100));
    maxlength_cob1_payer_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_payer_id)));
    avelength_cob1_payer_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_payer_id)),h.cob1_payer_id<>(typeof(h.cob1_payer_id))'');
    populated_cob1_hpid_pcnt := AVE(GROUP,IF(h.cob1_hpid = (TYPEOF(h.cob1_hpid))'',0,100));
    maxlength_cob1_hpid := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_hpid)));
    avelength_cob1_hpid := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_hpid)),h.cob1_hpid<>(typeof(h.cob1_hpid))'');
    populated_cob1_resp_seq_code_pcnt := AVE(GROUP,IF(h.cob1_resp_seq_code = (TYPEOF(h.cob1_resp_seq_code))'',0,100));
    maxlength_cob1_resp_seq_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_resp_seq_code)));
    avelength_cob1_resp_seq_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_resp_seq_code)),h.cob1_resp_seq_code<>(typeof(h.cob1_resp_seq_code))'');
    populated_cob1_relationship_code_pcnt := AVE(GROUP,IF(h.cob1_relationship_code = (TYPEOF(h.cob1_relationship_code))'',0,100));
    maxlength_cob1_relationship_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_relationship_code)));
    avelength_cob1_relationship_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_relationship_code)),h.cob1_relationship_code<>(typeof(h.cob1_relationship_code))'');
    populated_cob1_group_policy_num_pcnt := AVE(GROUP,IF(h.cob1_group_policy_num = (TYPEOF(h.cob1_group_policy_num))'',0,100));
    maxlength_cob1_group_policy_num := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_group_policy_num)));
    avelength_cob1_group_policy_num := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_group_policy_num)),h.cob1_group_policy_num<>(typeof(h.cob1_group_policy_num))'');
    populated_cob1_group_name_pcnt := AVE(GROUP,IF(h.cob1_group_name = (TYPEOF(h.cob1_group_name))'',0,100));
    maxlength_cob1_group_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_group_name)));
    avelength_cob1_group_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_group_name)),h.cob1_group_name<>(typeof(h.cob1_group_name))'');
    populated_cob1_ins_type_code_pcnt := AVE(GROUP,IF(h.cob1_ins_type_code = (TYPEOF(h.cob1_ins_type_code))'',0,100));
    maxlength_cob1_ins_type_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_ins_type_code)));
    avelength_cob1_ins_type_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_ins_type_code)),h.cob1_ins_type_code<>(typeof(h.cob1_ins_type_code))'');
    populated_cob1_claim_filing_indicator_pcnt := AVE(GROUP,IF(h.cob1_claim_filing_indicator = (TYPEOF(h.cob1_claim_filing_indicator))'',0,100));
    maxlength_cob1_claim_filing_indicator := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_claim_filing_indicator)));
    avelength_cob1_claim_filing_indicator := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.cob1_claim_filing_indicator)),h.cob1_claim_filing_indicator<>(typeof(h.cob1_claim_filing_indicator))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_claim_num_pcnt *   0.00 / 100 + T.Populated_claim_rec_type_pcnt *   0.00 / 100 + T.Populated_diag_code9_pcnt *   0.00 / 100 + T.Populated_diag_code10_pcnt *   0.00 / 100 + T.Populated_diag_code11_pcnt *   0.00 / 100 + T.Populated_diag_code12_pcnt *   0.00 / 100 + T.Populated_diag_code13_pcnt *   0.00 / 100 + T.Populated_diag_code14_pcnt *   0.00 / 100 + T.Populated_diag_code15_pcnt *   0.00 / 100 + T.Populated_diag_code16_pcnt *   0.00 / 100 + T.Populated_diag_code17_pcnt *   0.00 / 100 + T.Populated_diag_code18_pcnt *   0.00 / 100 + T.Populated_diag_code19_pcnt *   0.00 / 100 + T.Populated_diag_code20_pcnt *   0.00 / 100 + T.Populated_diag_code21_pcnt *   0.00 / 100 + T.Populated_diag_code22_pcnt *   0.00 / 100 + T.Populated_diag_code23_pcnt *   0.00 / 100 + T.Populated_diag_code24_pcnt *   0.00 / 100 + T.Populated_other_proc7_pcnt *   0.00 / 100 + T.Populated_other_proc8_pcnt *   0.00 / 100 + T.Populated_other_proc9_pcnt *   0.00 / 100 + T.Populated_other_proc10_pcnt *   0.00 / 100 + T.Populated_other_proc11_pcnt *   0.00 / 100 + T.Populated_other_proc12_pcnt *   0.00 / 100 + T.Populated_other_proc13_pcnt *   0.00 / 100 + T.Populated_other_proc14_pcnt *   0.00 / 100 + T.Populated_other_proc15_pcnt *   0.00 / 100 + T.Populated_other_proc16_pcnt *   0.00 / 100 + T.Populated_other_proc17_pcnt *   0.00 / 100 + T.Populated_other_proc18_pcnt *   0.00 / 100 + T.Populated_other_proc19_pcnt *   0.00 / 100 + T.Populated_other_proc20_pcnt *   0.00 / 100 + T.Populated_other_proc21_pcnt *   0.00 / 100 + T.Populated_other_proc22_pcnt *   0.00 / 100 + T.Populated_claim_indicator_code_pcnt *   0.00 / 100 + T.Populated_ref_prov_state_lic_pcnt *   0.00 / 100 + T.Populated_ref_prov_upin_pcnt *   0.00 / 100 + T.Populated_ref_prov_commercial_id_pcnt *   0.00 / 100 + T.Populated_pay_to_address1_pcnt *   0.00 / 100 + T.Populated_pay_to_address2_pcnt *   0.00 / 100 + T.Populated_pay_to_city_pcnt *   0.00 / 100 + T.Populated_pay_to_zip_pcnt *   0.00 / 100 + T.Populated_pay_to_state_pcnt *   0.00 / 100 + T.Populated_supervising_prov_org_name_pcnt *   0.00 / 100 + T.Populated_supervising_prov_last_name_pcnt *   0.00 / 100 + T.Populated_supervising_prov_first_name_pcnt *   0.00 / 100 + T.Populated_supervising_prov_middle_name_pcnt *   0.00 / 100 + T.Populated_supervising_prov_npi_pcnt *   0.00 / 100 + T.Populated_supervising_prov_state_lic_pcnt *   0.00 / 100 + T.Populated_supervising_prov_upin_pcnt *   0.00 / 100 + T.Populated_supervising_prov_commercial_id_pcnt *   0.00 / 100 + T.Populated_supervising_prov_location_pcnt *   0.00 / 100 + T.Populated_operating_prov_org_name_pcnt *   0.00 / 100 + T.Populated_operating_prov_last_name_pcnt *   0.00 / 100 + T.Populated_operating_prov_first_name_pcnt *   0.00 / 100 + T.Populated_operating_prov_middle_name_pcnt *   0.00 / 100 + T.Populated_operating_prov_npi_pcnt *   0.00 / 100 + T.Populated_operating_prov_state_lic_pcnt *   0.00 / 100 + T.Populated_operating_prov_upin_pcnt *   0.00 / 100 + T.Populated_operating_prov_commercial_id_pcnt *   0.00 / 100 + T.Populated_operating_prov_location_pcnt *   0.00 / 100 + T.Populated_other_operating_prov_org_name_pcnt *   0.00 / 100 + T.Populated_other_operating_prov_last_name_pcnt *   0.00 / 100 + T.Populated_other_operating_prov_first_name_pcnt *   0.00 / 100 + T.Populated_other_operating_prov_middle_name_pcnt *   0.00 / 100 + T.Populated_other_operating_prov_npi_pcnt *   0.00 / 100 + T.Populated_other_operating_prov_state_lic_pcnt *   0.00 / 100 + T.Populated_other_operating_prov_upin_pcnt *   0.00 / 100 + T.Populated_other_operating_prov_commercial_id_pcnt *   0.00 / 100 + T.Populated_other_operating_prov_location_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_name_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_address1_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_address2_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_city_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_zip_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_state_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_naic_id_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_payer_id_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_plan_id_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_claim_ofc_num_pcnt *   0.00 / 100 + T.Populated_pay_to_plan_tax_id_pcnt *   0.00 / 100 + T.Populated_cob1_payer_name_pcnt *   0.00 / 100 + T.Populated_cob1_payer_id_pcnt *   0.00 / 100 + T.Populated_cob1_hpid_pcnt *   0.00 / 100 + T.Populated_cob1_resp_seq_code_pcnt *   0.00 / 100 + T.Populated_cob1_relationship_code_pcnt *   0.00 / 100 + T.Populated_cob1_group_policy_num_pcnt *   0.00 / 100 + T.Populated_cob1_group_name_pcnt *   0.00 / 100 + T.Populated_cob1_ins_type_code_pcnt *   0.00 / 100 + T.Populated_cob1_claim_filing_indicator_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'claim_num','claim_rec_type','diag_code9','diag_code10','diag_code11','diag_code12','diag_code13','diag_code14','diag_code15','diag_code16','diag_code17','diag_code18','diag_code19','diag_code20','diag_code21','diag_code22','diag_code23','diag_code24','other_proc7','other_proc8','other_proc9','other_proc10','other_proc11','other_proc12','other_proc13','other_proc14','other_proc15','other_proc16','other_proc17','other_proc18','other_proc19','other_proc20','other_proc21','other_proc22','claim_indicator_code','ref_prov_state_lic','ref_prov_upin','ref_prov_commercial_id','pay_to_address1','pay_to_address2','pay_to_city','pay_to_zip','pay_to_state','supervising_prov_org_name','supervising_prov_last_name','supervising_prov_first_name','supervising_prov_middle_name','supervising_prov_npi','supervising_prov_state_lic','supervising_prov_upin','supervising_prov_commercial_id','supervising_prov_location','operating_prov_org_name','operating_prov_last_name','operating_prov_first_name','operating_prov_middle_name','operating_prov_npi','operating_prov_state_lic','operating_prov_upin','operating_prov_commercial_id','operating_prov_location','other_operating_prov_org_name','other_operating_prov_last_name','other_operating_prov_first_name','other_operating_prov_middle_name','other_operating_prov_npi','other_operating_prov_state_lic','other_operating_prov_upin','other_operating_prov_commercial_id','other_operating_prov_location','pay_to_plan_name','pay_to_plan_address1','pay_to_plan_address2','pay_to_plan_city','pay_to_plan_zip','pay_to_plan_state','pay_to_plan_naic_id','pay_to_plan_payer_id','pay_to_plan_plan_id','pay_to_plan_claim_ofc_num','pay_to_plan_tax_id','cob1_payer_name','cob1_payer_id','cob1_hpid','cob1_resp_seq_code','cob1_relationship_code','cob1_group_policy_num','cob1_group_name','cob1_ins_type_code','cob1_claim_filing_indicator');
  SELF.populated_pcnt := CHOOSE(C,le.populated_claim_num_pcnt,le.populated_claim_rec_type_pcnt,le.populated_diag_code9_pcnt,le.populated_diag_code10_pcnt,le.populated_diag_code11_pcnt,le.populated_diag_code12_pcnt,le.populated_diag_code13_pcnt,le.populated_diag_code14_pcnt,le.populated_diag_code15_pcnt,le.populated_diag_code16_pcnt,le.populated_diag_code17_pcnt,le.populated_diag_code18_pcnt,le.populated_diag_code19_pcnt,le.populated_diag_code20_pcnt,le.populated_diag_code21_pcnt,le.populated_diag_code22_pcnt,le.populated_diag_code23_pcnt,le.populated_diag_code24_pcnt,le.populated_other_proc7_pcnt,le.populated_other_proc8_pcnt,le.populated_other_proc9_pcnt,le.populated_other_proc10_pcnt,le.populated_other_proc11_pcnt,le.populated_other_proc12_pcnt,le.populated_other_proc13_pcnt,le.populated_other_proc14_pcnt,le.populated_other_proc15_pcnt,le.populated_other_proc16_pcnt,le.populated_other_proc17_pcnt,le.populated_other_proc18_pcnt,le.populated_other_proc19_pcnt,le.populated_other_proc20_pcnt,le.populated_other_proc21_pcnt,le.populated_other_proc22_pcnt,le.populated_claim_indicator_code_pcnt,le.populated_ref_prov_state_lic_pcnt,le.populated_ref_prov_upin_pcnt,le.populated_ref_prov_commercial_id_pcnt,le.populated_pay_to_address1_pcnt,le.populated_pay_to_address2_pcnt,le.populated_pay_to_city_pcnt,le.populated_pay_to_zip_pcnt,le.populated_pay_to_state_pcnt,le.populated_supervising_prov_org_name_pcnt,le.populated_supervising_prov_last_name_pcnt,le.populated_supervising_prov_first_name_pcnt,le.populated_supervising_prov_middle_name_pcnt,le.populated_supervising_prov_npi_pcnt,le.populated_supervising_prov_state_lic_pcnt,le.populated_supervising_prov_upin_pcnt,le.populated_supervising_prov_commercial_id_pcnt,le.populated_supervising_prov_location_pcnt,le.populated_operating_prov_org_name_pcnt,le.populated_operating_prov_last_name_pcnt,le.populated_operating_prov_first_name_pcnt,le.populated_operating_prov_middle_name_pcnt,le.populated_operating_prov_npi_pcnt,le.populated_operating_prov_state_lic_pcnt,le.populated_operating_prov_upin_pcnt,le.populated_operating_prov_commercial_id_pcnt,le.populated_operating_prov_location_pcnt,le.populated_other_operating_prov_org_name_pcnt,le.populated_other_operating_prov_last_name_pcnt,le.populated_other_operating_prov_first_name_pcnt,le.populated_other_operating_prov_middle_name_pcnt,le.populated_other_operating_prov_npi_pcnt,le.populated_other_operating_prov_state_lic_pcnt,le.populated_other_operating_prov_upin_pcnt,le.populated_other_operating_prov_commercial_id_pcnt,le.populated_other_operating_prov_location_pcnt,le.populated_pay_to_plan_name_pcnt,le.populated_pay_to_plan_address1_pcnt,le.populated_pay_to_plan_address2_pcnt,le.populated_pay_to_plan_city_pcnt,le.populated_pay_to_plan_zip_pcnt,le.populated_pay_to_plan_state_pcnt,le.populated_pay_to_plan_naic_id_pcnt,le.populated_pay_to_plan_payer_id_pcnt,le.populated_pay_to_plan_plan_id_pcnt,le.populated_pay_to_plan_claim_ofc_num_pcnt,le.populated_pay_to_plan_tax_id_pcnt,le.populated_cob1_payer_name_pcnt,le.populated_cob1_payer_id_pcnt,le.populated_cob1_hpid_pcnt,le.populated_cob1_resp_seq_code_pcnt,le.populated_cob1_relationship_code_pcnt,le.populated_cob1_group_policy_num_pcnt,le.populated_cob1_group_name_pcnt,le.populated_cob1_ins_type_code_pcnt,le.populated_cob1_claim_filing_indicator_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_claim_num,le.maxlength_claim_rec_type,le.maxlength_diag_code9,le.maxlength_diag_code10,le.maxlength_diag_code11,le.maxlength_diag_code12,le.maxlength_diag_code13,le.maxlength_diag_code14,le.maxlength_diag_code15,le.maxlength_diag_code16,le.maxlength_diag_code17,le.maxlength_diag_code18,le.maxlength_diag_code19,le.maxlength_diag_code20,le.maxlength_diag_code21,le.maxlength_diag_code22,le.maxlength_diag_code23,le.maxlength_diag_code24,le.maxlength_other_proc7,le.maxlength_other_proc8,le.maxlength_other_proc9,le.maxlength_other_proc10,le.maxlength_other_proc11,le.maxlength_other_proc12,le.maxlength_other_proc13,le.maxlength_other_proc14,le.maxlength_other_proc15,le.maxlength_other_proc16,le.maxlength_other_proc17,le.maxlength_other_proc18,le.maxlength_other_proc19,le.maxlength_other_proc20,le.maxlength_other_proc21,le.maxlength_other_proc22,le.maxlength_claim_indicator_code,le.maxlength_ref_prov_state_lic,le.maxlength_ref_prov_upin,le.maxlength_ref_prov_commercial_id,le.maxlength_pay_to_address1,le.maxlength_pay_to_address2,le.maxlength_pay_to_city,le.maxlength_pay_to_zip,le.maxlength_pay_to_state,le.maxlength_supervising_prov_org_name,le.maxlength_supervising_prov_last_name,le.maxlength_supervising_prov_first_name,le.maxlength_supervising_prov_middle_name,le.maxlength_supervising_prov_npi,le.maxlength_supervising_prov_state_lic,le.maxlength_supervising_prov_upin,le.maxlength_supervising_prov_commercial_id,le.maxlength_supervising_prov_location,le.maxlength_operating_prov_org_name,le.maxlength_operating_prov_last_name,le.maxlength_operating_prov_first_name,le.maxlength_operating_prov_middle_name,le.maxlength_operating_prov_npi,le.maxlength_operating_prov_state_lic,le.maxlength_operating_prov_upin,le.maxlength_operating_prov_commercial_id,le.maxlength_operating_prov_location,le.maxlength_other_operating_prov_org_name,le.maxlength_other_operating_prov_last_name,le.maxlength_other_operating_prov_first_name,le.maxlength_other_operating_prov_middle_name,le.maxlength_other_operating_prov_npi,le.maxlength_other_operating_prov_state_lic,le.maxlength_other_operating_prov_upin,le.maxlength_other_operating_prov_commercial_id,le.maxlength_other_operating_prov_location,le.maxlength_pay_to_plan_name,le.maxlength_pay_to_plan_address1,le.maxlength_pay_to_plan_address2,le.maxlength_pay_to_plan_city,le.maxlength_pay_to_plan_zip,le.maxlength_pay_to_plan_state,le.maxlength_pay_to_plan_naic_id,le.maxlength_pay_to_plan_payer_id,le.maxlength_pay_to_plan_plan_id,le.maxlength_pay_to_plan_claim_ofc_num,le.maxlength_pay_to_plan_tax_id,le.maxlength_cob1_payer_name,le.maxlength_cob1_payer_id,le.maxlength_cob1_hpid,le.maxlength_cob1_resp_seq_code,le.maxlength_cob1_relationship_code,le.maxlength_cob1_group_policy_num,le.maxlength_cob1_group_name,le.maxlength_cob1_ins_type_code,le.maxlength_cob1_claim_filing_indicator);
  SELF.avelength := CHOOSE(C,le.avelength_claim_num,le.avelength_claim_rec_type,le.avelength_diag_code9,le.avelength_diag_code10,le.avelength_diag_code11,le.avelength_diag_code12,le.avelength_diag_code13,le.avelength_diag_code14,le.avelength_diag_code15,le.avelength_diag_code16,le.avelength_diag_code17,le.avelength_diag_code18,le.avelength_diag_code19,le.avelength_diag_code20,le.avelength_diag_code21,le.avelength_diag_code22,le.avelength_diag_code23,le.avelength_diag_code24,le.avelength_other_proc7,le.avelength_other_proc8,le.avelength_other_proc9,le.avelength_other_proc10,le.avelength_other_proc11,le.avelength_other_proc12,le.avelength_other_proc13,le.avelength_other_proc14,le.avelength_other_proc15,le.avelength_other_proc16,le.avelength_other_proc17,le.avelength_other_proc18,le.avelength_other_proc19,le.avelength_other_proc20,le.avelength_other_proc21,le.avelength_other_proc22,le.avelength_claim_indicator_code,le.avelength_ref_prov_state_lic,le.avelength_ref_prov_upin,le.avelength_ref_prov_commercial_id,le.avelength_pay_to_address1,le.avelength_pay_to_address2,le.avelength_pay_to_city,le.avelength_pay_to_zip,le.avelength_pay_to_state,le.avelength_supervising_prov_org_name,le.avelength_supervising_prov_last_name,le.avelength_supervising_prov_first_name,le.avelength_supervising_prov_middle_name,le.avelength_supervising_prov_npi,le.avelength_supervising_prov_state_lic,le.avelength_supervising_prov_upin,le.avelength_supervising_prov_commercial_id,le.avelength_supervising_prov_location,le.avelength_operating_prov_org_name,le.avelength_operating_prov_last_name,le.avelength_operating_prov_first_name,le.avelength_operating_prov_middle_name,le.avelength_operating_prov_npi,le.avelength_operating_prov_state_lic,le.avelength_operating_prov_upin,le.avelength_operating_prov_commercial_id,le.avelength_operating_prov_location,le.avelength_other_operating_prov_org_name,le.avelength_other_operating_prov_last_name,le.avelength_other_operating_prov_first_name,le.avelength_other_operating_prov_middle_name,le.avelength_other_operating_prov_npi,le.avelength_other_operating_prov_state_lic,le.avelength_other_operating_prov_upin,le.avelength_other_operating_prov_commercial_id,le.avelength_other_operating_prov_location,le.avelength_pay_to_plan_name,le.avelength_pay_to_plan_address1,le.avelength_pay_to_plan_address2,le.avelength_pay_to_plan_city,le.avelength_pay_to_plan_zip,le.avelength_pay_to_plan_state,le.avelength_pay_to_plan_naic_id,le.avelength_pay_to_plan_payer_id,le.avelength_pay_to_plan_plan_id,le.avelength_pay_to_plan_claim_ofc_num,le.avelength_pay_to_plan_tax_id,le.avelength_cob1_payer_name,le.avelength_cob1_payer_id,le.avelength_cob1_hpid,le.avelength_cob1_resp_seq_code,le.avelength_cob1_relationship_code,le.avelength_cob1_group_policy_num,le.avelength_cob1_group_name,le.avelength_cob1_ins_type_code,le.avelength_cob1_claim_filing_indicator);
END;
EXPORT invSummary := NORMALIZE(summary0, 90, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.claim_rec_type),TRIM((SALT31.StrType)le.diag_code9),TRIM((SALT31.StrType)le.diag_code10),TRIM((SALT31.StrType)le.diag_code11),TRIM((SALT31.StrType)le.diag_code12),TRIM((SALT31.StrType)le.diag_code13),TRIM((SALT31.StrType)le.diag_code14),TRIM((SALT31.StrType)le.diag_code15),TRIM((SALT31.StrType)le.diag_code16),TRIM((SALT31.StrType)le.diag_code17),TRIM((SALT31.StrType)le.diag_code18),TRIM((SALT31.StrType)le.diag_code19),TRIM((SALT31.StrType)le.diag_code20),TRIM((SALT31.StrType)le.diag_code21),TRIM((SALT31.StrType)le.diag_code22),TRIM((SALT31.StrType)le.diag_code23),TRIM((SALT31.StrType)le.diag_code24),TRIM((SALT31.StrType)le.other_proc7),TRIM((SALT31.StrType)le.other_proc8),TRIM((SALT31.StrType)le.other_proc9),TRIM((SALT31.StrType)le.other_proc10),TRIM((SALT31.StrType)le.other_proc11),TRIM((SALT31.StrType)le.other_proc12),TRIM((SALT31.StrType)le.other_proc13),TRIM((SALT31.StrType)le.other_proc14),TRIM((SALT31.StrType)le.other_proc15),TRIM((SALT31.StrType)le.other_proc16),TRIM((SALT31.StrType)le.other_proc17),TRIM((SALT31.StrType)le.other_proc18),TRIM((SALT31.StrType)le.other_proc19),TRIM((SALT31.StrType)le.other_proc20),TRIM((SALT31.StrType)le.other_proc21),TRIM((SALT31.StrType)le.other_proc22),TRIM((SALT31.StrType)le.claim_indicator_code),TRIM((SALT31.StrType)le.ref_prov_state_lic),TRIM((SALT31.StrType)le.ref_prov_upin),TRIM((SALT31.StrType)le.ref_prov_commercial_id),TRIM((SALT31.StrType)le.pay_to_address1),TRIM((SALT31.StrType)le.pay_to_address2),TRIM((SALT31.StrType)le.pay_to_city),TRIM((SALT31.StrType)le.pay_to_zip),TRIM((SALT31.StrType)le.pay_to_state),TRIM((SALT31.StrType)le.supervising_prov_org_name),TRIM((SALT31.StrType)le.supervising_prov_last_name),TRIM((SALT31.StrType)le.supervising_prov_first_name),TRIM((SALT31.StrType)le.supervising_prov_middle_name),TRIM((SALT31.StrType)le.supervising_prov_npi),TRIM((SALT31.StrType)le.supervising_prov_state_lic),TRIM((SALT31.StrType)le.supervising_prov_upin),TRIM((SALT31.StrType)le.supervising_prov_commercial_id),TRIM((SALT31.StrType)le.supervising_prov_location),TRIM((SALT31.StrType)le.operating_prov_org_name),TRIM((SALT31.StrType)le.operating_prov_last_name),TRIM((SALT31.StrType)le.operating_prov_first_name),TRIM((SALT31.StrType)le.operating_prov_middle_name),TRIM((SALT31.StrType)le.operating_prov_npi),TRIM((SALT31.StrType)le.operating_prov_state_lic),TRIM((SALT31.StrType)le.operating_prov_upin),TRIM((SALT31.StrType)le.operating_prov_commercial_id),TRIM((SALT31.StrType)le.operating_prov_location),TRIM((SALT31.StrType)le.other_operating_prov_org_name),TRIM((SALT31.StrType)le.other_operating_prov_last_name),TRIM((SALT31.StrType)le.other_operating_prov_first_name),TRIM((SALT31.StrType)le.other_operating_prov_middle_name),TRIM((SALT31.StrType)le.other_operating_prov_npi),TRIM((SALT31.StrType)le.other_operating_prov_state_lic),TRIM((SALT31.StrType)le.other_operating_prov_upin),TRIM((SALT31.StrType)le.other_operating_prov_commercial_id),TRIM((SALT31.StrType)le.other_operating_prov_location),TRIM((SALT31.StrType)le.pay_to_plan_name),TRIM((SALT31.StrType)le.pay_to_plan_address1),TRIM((SALT31.StrType)le.pay_to_plan_address2),TRIM((SALT31.StrType)le.pay_to_plan_city),TRIM((SALT31.StrType)le.pay_to_plan_zip),TRIM((SALT31.StrType)le.pay_to_plan_state),TRIM((SALT31.StrType)le.pay_to_plan_naic_id),TRIM((SALT31.StrType)le.pay_to_plan_payer_id),TRIM((SALT31.StrType)le.pay_to_plan_plan_id),TRIM((SALT31.StrType)le.pay_to_plan_claim_ofc_num),TRIM((SALT31.StrType)le.pay_to_plan_tax_id),TRIM((SALT31.StrType)le.cob1_payer_name),TRIM((SALT31.StrType)le.cob1_payer_id),TRIM((SALT31.StrType)le.cob1_hpid),TRIM((SALT31.StrType)le.cob1_resp_seq_code),TRIM((SALT31.StrType)le.cob1_relationship_code),TRIM((SALT31.StrType)le.cob1_group_policy_num),TRIM((SALT31.StrType)le.cob1_group_name),TRIM((SALT31.StrType)le.cob1_ins_type_code),TRIM((SALT31.StrType)le.cob1_claim_filing_indicator)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,90,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 90);
  SELF.FldNo2 := 1 + (C % 90);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.claim_rec_type),TRIM((SALT31.StrType)le.diag_code9),TRIM((SALT31.StrType)le.diag_code10),TRIM((SALT31.StrType)le.diag_code11),TRIM((SALT31.StrType)le.diag_code12),TRIM((SALT31.StrType)le.diag_code13),TRIM((SALT31.StrType)le.diag_code14),TRIM((SALT31.StrType)le.diag_code15),TRIM((SALT31.StrType)le.diag_code16),TRIM((SALT31.StrType)le.diag_code17),TRIM((SALT31.StrType)le.diag_code18),TRIM((SALT31.StrType)le.diag_code19),TRIM((SALT31.StrType)le.diag_code20),TRIM((SALT31.StrType)le.diag_code21),TRIM((SALT31.StrType)le.diag_code22),TRIM((SALT31.StrType)le.diag_code23),TRIM((SALT31.StrType)le.diag_code24),TRIM((SALT31.StrType)le.other_proc7),TRIM((SALT31.StrType)le.other_proc8),TRIM((SALT31.StrType)le.other_proc9),TRIM((SALT31.StrType)le.other_proc10),TRIM((SALT31.StrType)le.other_proc11),TRIM((SALT31.StrType)le.other_proc12),TRIM((SALT31.StrType)le.other_proc13),TRIM((SALT31.StrType)le.other_proc14),TRIM((SALT31.StrType)le.other_proc15),TRIM((SALT31.StrType)le.other_proc16),TRIM((SALT31.StrType)le.other_proc17),TRIM((SALT31.StrType)le.other_proc18),TRIM((SALT31.StrType)le.other_proc19),TRIM((SALT31.StrType)le.other_proc20),TRIM((SALT31.StrType)le.other_proc21),TRIM((SALT31.StrType)le.other_proc22),TRIM((SALT31.StrType)le.claim_indicator_code),TRIM((SALT31.StrType)le.ref_prov_state_lic),TRIM((SALT31.StrType)le.ref_prov_upin),TRIM((SALT31.StrType)le.ref_prov_commercial_id),TRIM((SALT31.StrType)le.pay_to_address1),TRIM((SALT31.StrType)le.pay_to_address2),TRIM((SALT31.StrType)le.pay_to_city),TRIM((SALT31.StrType)le.pay_to_zip),TRIM((SALT31.StrType)le.pay_to_state),TRIM((SALT31.StrType)le.supervising_prov_org_name),TRIM((SALT31.StrType)le.supervising_prov_last_name),TRIM((SALT31.StrType)le.supervising_prov_first_name),TRIM((SALT31.StrType)le.supervising_prov_middle_name),TRIM((SALT31.StrType)le.supervising_prov_npi),TRIM((SALT31.StrType)le.supervising_prov_state_lic),TRIM((SALT31.StrType)le.supervising_prov_upin),TRIM((SALT31.StrType)le.supervising_prov_commercial_id),TRIM((SALT31.StrType)le.supervising_prov_location),TRIM((SALT31.StrType)le.operating_prov_org_name),TRIM((SALT31.StrType)le.operating_prov_last_name),TRIM((SALT31.StrType)le.operating_prov_first_name),TRIM((SALT31.StrType)le.operating_prov_middle_name),TRIM((SALT31.StrType)le.operating_prov_npi),TRIM((SALT31.StrType)le.operating_prov_state_lic),TRIM((SALT31.StrType)le.operating_prov_upin),TRIM((SALT31.StrType)le.operating_prov_commercial_id),TRIM((SALT31.StrType)le.operating_prov_location),TRIM((SALT31.StrType)le.other_operating_prov_org_name),TRIM((SALT31.StrType)le.other_operating_prov_last_name),TRIM((SALT31.StrType)le.other_operating_prov_first_name),TRIM((SALT31.StrType)le.other_operating_prov_middle_name),TRIM((SALT31.StrType)le.other_operating_prov_npi),TRIM((SALT31.StrType)le.other_operating_prov_state_lic),TRIM((SALT31.StrType)le.other_operating_prov_upin),TRIM((SALT31.StrType)le.other_operating_prov_commercial_id),TRIM((SALT31.StrType)le.other_operating_prov_location),TRIM((SALT31.StrType)le.pay_to_plan_name),TRIM((SALT31.StrType)le.pay_to_plan_address1),TRIM((SALT31.StrType)le.pay_to_plan_address2),TRIM((SALT31.StrType)le.pay_to_plan_city),TRIM((SALT31.StrType)le.pay_to_plan_zip),TRIM((SALT31.StrType)le.pay_to_plan_state),TRIM((SALT31.StrType)le.pay_to_plan_naic_id),TRIM((SALT31.StrType)le.pay_to_plan_payer_id),TRIM((SALT31.StrType)le.pay_to_plan_plan_id),TRIM((SALT31.StrType)le.pay_to_plan_claim_ofc_num),TRIM((SALT31.StrType)le.pay_to_plan_tax_id),TRIM((SALT31.StrType)le.cob1_payer_name),TRIM((SALT31.StrType)le.cob1_payer_id),TRIM((SALT31.StrType)le.cob1_hpid),TRIM((SALT31.StrType)le.cob1_resp_seq_code),TRIM((SALT31.StrType)le.cob1_relationship_code),TRIM((SALT31.StrType)le.cob1_group_policy_num),TRIM((SALT31.StrType)le.cob1_group_name),TRIM((SALT31.StrType)le.cob1_ins_type_code),TRIM((SALT31.StrType)le.cob1_claim_filing_indicator)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.claim_rec_type),TRIM((SALT31.StrType)le.diag_code9),TRIM((SALT31.StrType)le.diag_code10),TRIM((SALT31.StrType)le.diag_code11),TRIM((SALT31.StrType)le.diag_code12),TRIM((SALT31.StrType)le.diag_code13),TRIM((SALT31.StrType)le.diag_code14),TRIM((SALT31.StrType)le.diag_code15),TRIM((SALT31.StrType)le.diag_code16),TRIM((SALT31.StrType)le.diag_code17),TRIM((SALT31.StrType)le.diag_code18),TRIM((SALT31.StrType)le.diag_code19),TRIM((SALT31.StrType)le.diag_code20),TRIM((SALT31.StrType)le.diag_code21),TRIM((SALT31.StrType)le.diag_code22),TRIM((SALT31.StrType)le.diag_code23),TRIM((SALT31.StrType)le.diag_code24),TRIM((SALT31.StrType)le.other_proc7),TRIM((SALT31.StrType)le.other_proc8),TRIM((SALT31.StrType)le.other_proc9),TRIM((SALT31.StrType)le.other_proc10),TRIM((SALT31.StrType)le.other_proc11),TRIM((SALT31.StrType)le.other_proc12),TRIM((SALT31.StrType)le.other_proc13),TRIM((SALT31.StrType)le.other_proc14),TRIM((SALT31.StrType)le.other_proc15),TRIM((SALT31.StrType)le.other_proc16),TRIM((SALT31.StrType)le.other_proc17),TRIM((SALT31.StrType)le.other_proc18),TRIM((SALT31.StrType)le.other_proc19),TRIM((SALT31.StrType)le.other_proc20),TRIM((SALT31.StrType)le.other_proc21),TRIM((SALT31.StrType)le.other_proc22),TRIM((SALT31.StrType)le.claim_indicator_code),TRIM((SALT31.StrType)le.ref_prov_state_lic),TRIM((SALT31.StrType)le.ref_prov_upin),TRIM((SALT31.StrType)le.ref_prov_commercial_id),TRIM((SALT31.StrType)le.pay_to_address1),TRIM((SALT31.StrType)le.pay_to_address2),TRIM((SALT31.StrType)le.pay_to_city),TRIM((SALT31.StrType)le.pay_to_zip),TRIM((SALT31.StrType)le.pay_to_state),TRIM((SALT31.StrType)le.supervising_prov_org_name),TRIM((SALT31.StrType)le.supervising_prov_last_name),TRIM((SALT31.StrType)le.supervising_prov_first_name),TRIM((SALT31.StrType)le.supervising_prov_middle_name),TRIM((SALT31.StrType)le.supervising_prov_npi),TRIM((SALT31.StrType)le.supervising_prov_state_lic),TRIM((SALT31.StrType)le.supervising_prov_upin),TRIM((SALT31.StrType)le.supervising_prov_commercial_id),TRIM((SALT31.StrType)le.supervising_prov_location),TRIM((SALT31.StrType)le.operating_prov_org_name),TRIM((SALT31.StrType)le.operating_prov_last_name),TRIM((SALT31.StrType)le.operating_prov_first_name),TRIM((SALT31.StrType)le.operating_prov_middle_name),TRIM((SALT31.StrType)le.operating_prov_npi),TRIM((SALT31.StrType)le.operating_prov_state_lic),TRIM((SALT31.StrType)le.operating_prov_upin),TRIM((SALT31.StrType)le.operating_prov_commercial_id),TRIM((SALT31.StrType)le.operating_prov_location),TRIM((SALT31.StrType)le.other_operating_prov_org_name),TRIM((SALT31.StrType)le.other_operating_prov_last_name),TRIM((SALT31.StrType)le.other_operating_prov_first_name),TRIM((SALT31.StrType)le.other_operating_prov_middle_name),TRIM((SALT31.StrType)le.other_operating_prov_npi),TRIM((SALT31.StrType)le.other_operating_prov_state_lic),TRIM((SALT31.StrType)le.other_operating_prov_upin),TRIM((SALT31.StrType)le.other_operating_prov_commercial_id),TRIM((SALT31.StrType)le.other_operating_prov_location),TRIM((SALT31.StrType)le.pay_to_plan_name),TRIM((SALT31.StrType)le.pay_to_plan_address1),TRIM((SALT31.StrType)le.pay_to_plan_address2),TRIM((SALT31.StrType)le.pay_to_plan_city),TRIM((SALT31.StrType)le.pay_to_plan_zip),TRIM((SALT31.StrType)le.pay_to_plan_state),TRIM((SALT31.StrType)le.pay_to_plan_naic_id),TRIM((SALT31.StrType)le.pay_to_plan_payer_id),TRIM((SALT31.StrType)le.pay_to_plan_plan_id),TRIM((SALT31.StrType)le.pay_to_plan_claim_ofc_num),TRIM((SALT31.StrType)le.pay_to_plan_tax_id),TRIM((SALT31.StrType)le.cob1_payer_name),TRIM((SALT31.StrType)le.cob1_payer_id),TRIM((SALT31.StrType)le.cob1_hpid),TRIM((SALT31.StrType)le.cob1_resp_seq_code),TRIM((SALT31.StrType)le.cob1_relationship_code),TRIM((SALT31.StrType)le.cob1_group_policy_num),TRIM((SALT31.StrType)le.cob1_group_name),TRIM((SALT31.StrType)le.cob1_ins_type_code),TRIM((SALT31.StrType)le.cob1_claim_filing_indicator)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),90*90,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'claim_num'}
      ,{2,'claim_rec_type'}
      ,{3,'diag_code9'}
      ,{4,'diag_code10'}
      ,{5,'diag_code11'}
      ,{6,'diag_code12'}
      ,{7,'diag_code13'}
      ,{8,'diag_code14'}
      ,{9,'diag_code15'}
      ,{10,'diag_code16'}
      ,{11,'diag_code17'}
      ,{12,'diag_code18'}
      ,{13,'diag_code19'}
      ,{14,'diag_code20'}
      ,{15,'diag_code21'}
      ,{16,'diag_code22'}
      ,{17,'diag_code23'}
      ,{18,'diag_code24'}
      ,{19,'other_proc7'}
      ,{20,'other_proc8'}
      ,{21,'other_proc9'}
      ,{22,'other_proc10'}
      ,{23,'other_proc11'}
      ,{24,'other_proc12'}
      ,{25,'other_proc13'}
      ,{26,'other_proc14'}
      ,{27,'other_proc15'}
      ,{28,'other_proc16'}
      ,{29,'other_proc17'}
      ,{30,'other_proc18'}
      ,{31,'other_proc19'}
      ,{32,'other_proc20'}
      ,{33,'other_proc21'}
      ,{34,'other_proc22'}
      ,{35,'claim_indicator_code'}
      ,{36,'ref_prov_state_lic'}
      ,{37,'ref_prov_upin'}
      ,{38,'ref_prov_commercial_id'}
      ,{39,'pay_to_address1'}
      ,{40,'pay_to_address2'}
      ,{41,'pay_to_city'}
      ,{42,'pay_to_zip'}
      ,{43,'pay_to_state'}
      ,{44,'supervising_prov_org_name'}
      ,{45,'supervising_prov_last_name'}
      ,{46,'supervising_prov_first_name'}
      ,{47,'supervising_prov_middle_name'}
      ,{48,'supervising_prov_npi'}
      ,{49,'supervising_prov_state_lic'}
      ,{50,'supervising_prov_upin'}
      ,{51,'supervising_prov_commercial_id'}
      ,{52,'supervising_prov_location'}
      ,{53,'operating_prov_org_name'}
      ,{54,'operating_prov_last_name'}
      ,{55,'operating_prov_first_name'}
      ,{56,'operating_prov_middle_name'}
      ,{57,'operating_prov_npi'}
      ,{58,'operating_prov_state_lic'}
      ,{59,'operating_prov_upin'}
      ,{60,'operating_prov_commercial_id'}
      ,{61,'operating_prov_location'}
      ,{62,'other_operating_prov_org_name'}
      ,{63,'other_operating_prov_last_name'}
      ,{64,'other_operating_prov_first_name'}
      ,{65,'other_operating_prov_middle_name'}
      ,{66,'other_operating_prov_npi'}
      ,{67,'other_operating_prov_state_lic'}
      ,{68,'other_operating_prov_upin'}
      ,{69,'other_operating_prov_commercial_id'}
      ,{70,'other_operating_prov_location'}
      ,{71,'pay_to_plan_name'}
      ,{72,'pay_to_plan_address1'}
      ,{73,'pay_to_plan_address2'}
      ,{74,'pay_to_plan_city'}
      ,{75,'pay_to_plan_zip'}
      ,{76,'pay_to_plan_state'}
      ,{77,'pay_to_plan_naic_id'}
      ,{78,'pay_to_plan_payer_id'}
      ,{79,'pay_to_plan_plan_id'}
      ,{80,'pay_to_plan_claim_ofc_num'}
      ,{81,'pay_to_plan_tax_id'}
      ,{82,'cob1_payer_name'}
      ,{83,'cob1_payer_id'}
      ,{84,'cob1_hpid'}
      ,{85,'cob1_resp_seq_code'}
      ,{86,'cob1_relationship_code'}
      ,{87,'cob1_group_policy_num'}
      ,{88,'cob1_group_name'}
      ,{89,'cob1_ins_type_code'}
      ,{90,'cob1_claim_filing_indicator'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    DRecord_Fields.InValid_claim_num((SALT31.StrType)le.claim_num),
    DRecord_Fields.InValid_claim_rec_type((SALT31.StrType)le.claim_rec_type),
    DRecord_Fields.InValid_diag_code9((SALT31.StrType)le.diag_code9),
    DRecord_Fields.InValid_diag_code10((SALT31.StrType)le.diag_code10),
    DRecord_Fields.InValid_diag_code11((SALT31.StrType)le.diag_code11),
    DRecord_Fields.InValid_diag_code12((SALT31.StrType)le.diag_code12),
    DRecord_Fields.InValid_diag_code13((SALT31.StrType)le.diag_code13),
    DRecord_Fields.InValid_diag_code14((SALT31.StrType)le.diag_code14),
    DRecord_Fields.InValid_diag_code15((SALT31.StrType)le.diag_code15),
    DRecord_Fields.InValid_diag_code16((SALT31.StrType)le.diag_code16),
    DRecord_Fields.InValid_diag_code17((SALT31.StrType)le.diag_code17),
    DRecord_Fields.InValid_diag_code18((SALT31.StrType)le.diag_code18),
    DRecord_Fields.InValid_diag_code19((SALT31.StrType)le.diag_code19),
    DRecord_Fields.InValid_diag_code20((SALT31.StrType)le.diag_code20),
    DRecord_Fields.InValid_diag_code21((SALT31.StrType)le.diag_code21),
    DRecord_Fields.InValid_diag_code22((SALT31.StrType)le.diag_code22),
    DRecord_Fields.InValid_diag_code23((SALT31.StrType)le.diag_code23),
    DRecord_Fields.InValid_diag_code24((SALT31.StrType)le.diag_code24),
    DRecord_Fields.InValid_other_proc7((SALT31.StrType)le.other_proc7),
    DRecord_Fields.InValid_other_proc8((SALT31.StrType)le.other_proc8),
    DRecord_Fields.InValid_other_proc9((SALT31.StrType)le.other_proc9),
    DRecord_Fields.InValid_other_proc10((SALT31.StrType)le.other_proc10),
    DRecord_Fields.InValid_other_proc11((SALT31.StrType)le.other_proc11),
    DRecord_Fields.InValid_other_proc12((SALT31.StrType)le.other_proc12),
    DRecord_Fields.InValid_other_proc13((SALT31.StrType)le.other_proc13),
    DRecord_Fields.InValid_other_proc14((SALT31.StrType)le.other_proc14),
    DRecord_Fields.InValid_other_proc15((SALT31.StrType)le.other_proc15),
    DRecord_Fields.InValid_other_proc16((SALT31.StrType)le.other_proc16),
    DRecord_Fields.InValid_other_proc17((SALT31.StrType)le.other_proc17),
    DRecord_Fields.InValid_other_proc18((SALT31.StrType)le.other_proc18),
    DRecord_Fields.InValid_other_proc19((SALT31.StrType)le.other_proc19),
    DRecord_Fields.InValid_other_proc20((SALT31.StrType)le.other_proc20),
    DRecord_Fields.InValid_other_proc21((SALT31.StrType)le.other_proc21),
    DRecord_Fields.InValid_other_proc22((SALT31.StrType)le.other_proc22),
    DRecord_Fields.InValid_claim_indicator_code((SALT31.StrType)le.claim_indicator_code),
    DRecord_Fields.InValid_ref_prov_state_lic((SALT31.StrType)le.ref_prov_state_lic),
    DRecord_Fields.InValid_ref_prov_upin((SALT31.StrType)le.ref_prov_upin),
    DRecord_Fields.InValid_ref_prov_commercial_id((SALT31.StrType)le.ref_prov_commercial_id),
    DRecord_Fields.InValid_pay_to_address1((SALT31.StrType)le.pay_to_address1),
    DRecord_Fields.InValid_pay_to_address2((SALT31.StrType)le.pay_to_address2),
    DRecord_Fields.InValid_pay_to_city((SALT31.StrType)le.pay_to_city),
    DRecord_Fields.InValid_pay_to_zip((SALT31.StrType)le.pay_to_zip),
    DRecord_Fields.InValid_pay_to_state((SALT31.StrType)le.pay_to_state),
    DRecord_Fields.InValid_supervising_prov_org_name((SALT31.StrType)le.supervising_prov_org_name),
    DRecord_Fields.InValid_supervising_prov_last_name((SALT31.StrType)le.supervising_prov_last_name),
    DRecord_Fields.InValid_supervising_prov_first_name((SALT31.StrType)le.supervising_prov_first_name),
    DRecord_Fields.InValid_supervising_prov_middle_name((SALT31.StrType)le.supervising_prov_middle_name),
    DRecord_Fields.InValid_supervising_prov_npi((SALT31.StrType)le.supervising_prov_npi),
    DRecord_Fields.InValid_supervising_prov_state_lic((SALT31.StrType)le.supervising_prov_state_lic),
    DRecord_Fields.InValid_supervising_prov_upin((SALT31.StrType)le.supervising_prov_upin),
    DRecord_Fields.InValid_supervising_prov_commercial_id((SALT31.StrType)le.supervising_prov_commercial_id),
    DRecord_Fields.InValid_supervising_prov_location((SALT31.StrType)le.supervising_prov_location),
    DRecord_Fields.InValid_operating_prov_org_name((SALT31.StrType)le.operating_prov_org_name),
    DRecord_Fields.InValid_operating_prov_last_name((SALT31.StrType)le.operating_prov_last_name),
    DRecord_Fields.InValid_operating_prov_first_name((SALT31.StrType)le.operating_prov_first_name),
    DRecord_Fields.InValid_operating_prov_middle_name((SALT31.StrType)le.operating_prov_middle_name),
    DRecord_Fields.InValid_operating_prov_npi((SALT31.StrType)le.operating_prov_npi),
    DRecord_Fields.InValid_operating_prov_state_lic((SALT31.StrType)le.operating_prov_state_lic),
    DRecord_Fields.InValid_operating_prov_upin((SALT31.StrType)le.operating_prov_upin),
    DRecord_Fields.InValid_operating_prov_commercial_id((SALT31.StrType)le.operating_prov_commercial_id),
    DRecord_Fields.InValid_operating_prov_location((SALT31.StrType)le.operating_prov_location),
    DRecord_Fields.InValid_other_operating_prov_org_name((SALT31.StrType)le.other_operating_prov_org_name),
    DRecord_Fields.InValid_other_operating_prov_last_name((SALT31.StrType)le.other_operating_prov_last_name),
    DRecord_Fields.InValid_other_operating_prov_first_name((SALT31.StrType)le.other_operating_prov_first_name),
    DRecord_Fields.InValid_other_operating_prov_middle_name((SALT31.StrType)le.other_operating_prov_middle_name),
    DRecord_Fields.InValid_other_operating_prov_npi((SALT31.StrType)le.other_operating_prov_npi),
    DRecord_Fields.InValid_other_operating_prov_state_lic((SALT31.StrType)le.other_operating_prov_state_lic),
    DRecord_Fields.InValid_other_operating_prov_upin((SALT31.StrType)le.other_operating_prov_upin),
    DRecord_Fields.InValid_other_operating_prov_commercial_id((SALT31.StrType)le.other_operating_prov_commercial_id),
    DRecord_Fields.InValid_other_operating_prov_location((SALT31.StrType)le.other_operating_prov_location),
    DRecord_Fields.InValid_pay_to_plan_name((SALT31.StrType)le.pay_to_plan_name),
    DRecord_Fields.InValid_pay_to_plan_address1((SALT31.StrType)le.pay_to_plan_address1),
    DRecord_Fields.InValid_pay_to_plan_address2((SALT31.StrType)le.pay_to_plan_address2),
    DRecord_Fields.InValid_pay_to_plan_city((SALT31.StrType)le.pay_to_plan_city),
    DRecord_Fields.InValid_pay_to_plan_zip((SALT31.StrType)le.pay_to_plan_zip),
    DRecord_Fields.InValid_pay_to_plan_state((SALT31.StrType)le.pay_to_plan_state),
    DRecord_Fields.InValid_pay_to_plan_naic_id((SALT31.StrType)le.pay_to_plan_naic_id),
    DRecord_Fields.InValid_pay_to_plan_payer_id((SALT31.StrType)le.pay_to_plan_payer_id),
    DRecord_Fields.InValid_pay_to_plan_plan_id((SALT31.StrType)le.pay_to_plan_plan_id),
    DRecord_Fields.InValid_pay_to_plan_claim_ofc_num((SALT31.StrType)le.pay_to_plan_claim_ofc_num),
    DRecord_Fields.InValid_pay_to_plan_tax_id((SALT31.StrType)le.pay_to_plan_tax_id),
    DRecord_Fields.InValid_cob1_payer_name((SALT31.StrType)le.cob1_payer_name),
    DRecord_Fields.InValid_cob1_payer_id((SALT31.StrType)le.cob1_payer_id),
    DRecord_Fields.InValid_cob1_hpid((SALT31.StrType)le.cob1_hpid),
    DRecord_Fields.InValid_cob1_resp_seq_code((SALT31.StrType)le.cob1_resp_seq_code),
    DRecord_Fields.InValid_cob1_relationship_code((SALT31.StrType)le.cob1_relationship_code),
    DRecord_Fields.InValid_cob1_group_policy_num((SALT31.StrType)le.cob1_group_policy_num),
    DRecord_Fields.InValid_cob1_group_name((SALT31.StrType)le.cob1_group_name),
    DRecord_Fields.InValid_cob1_ins_type_code((SALT31.StrType)le.cob1_ins_type_code),
    DRecord_Fields.InValid_cob1_claim_filing_indicator((SALT31.StrType)le.cob1_claim_filing_indicator),
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
  FieldNme := DRecord_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'claim_num','claim_rec_type','diag_code9','diag_code10','diag_code11','diag_code12','diag_code13','diag_code14','diag_code15','diag_code16','diag_code17','diag_code18','diag_code19','diag_code20','diag_code21','diag_code22','diag_code23','diag_code24','other_proc7','other_proc8','other_proc9','other_proc10','other_proc11','other_proc12','other_proc13','other_proc14','other_proc15','other_proc16','other_proc17','other_proc18','other_proc19','other_proc20','other_proc21','other_proc22','claim_indicator_code','ref_prov_state_lic','ref_prov_upin','ref_prov_commercial_id','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','cob1_group_policy_num','cob1_group_name','cob1_ins_type_code','cob1_claim_filing_indicator');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,DRecord_Fields.InValidMessage_claim_num(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_claim_rec_type(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code9(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code10(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code11(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code12(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code13(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code14(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code15(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code16(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code17(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code18(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code19(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code20(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code21(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code22(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code23(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_diag_code24(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc7(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc8(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc9(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc10(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc11(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc12(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc13(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc14(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc15(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc16(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc17(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc18(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc19(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc20(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc21(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_proc22(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_claim_indicator_code(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_ref_prov_state_lic(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_ref_prov_upin(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_ref_prov_commercial_id(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_address1(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_address2(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_city(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_zip(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_state(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_supervising_prov_org_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_supervising_prov_last_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_supervising_prov_first_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_supervising_prov_middle_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_supervising_prov_npi(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_supervising_prov_state_lic(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_supervising_prov_upin(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_supervising_prov_commercial_id(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_supervising_prov_location(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_operating_prov_org_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_operating_prov_last_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_operating_prov_first_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_operating_prov_middle_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_operating_prov_npi(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_operating_prov_state_lic(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_operating_prov_upin(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_operating_prov_commercial_id(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_operating_prov_location(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_operating_prov_org_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_operating_prov_last_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_operating_prov_first_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_operating_prov_middle_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_operating_prov_npi(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_operating_prov_state_lic(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_operating_prov_upin(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_operating_prov_commercial_id(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_other_operating_prov_location(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_address1(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_address2(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_city(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_zip(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_state(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_naic_id(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_payer_id(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_plan_id(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_claim_ofc_num(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_pay_to_plan_tax_id(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_cob1_payer_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_cob1_payer_id(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_cob1_hpid(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_cob1_resp_seq_code(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_cob1_relationship_code(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_cob1_group_policy_num(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_cob1_group_name(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_cob1_ins_type_code(TotalErrors.ErrorNum),DRecord_Fields.InValidMessage_cob1_claim_filing_indicator(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
