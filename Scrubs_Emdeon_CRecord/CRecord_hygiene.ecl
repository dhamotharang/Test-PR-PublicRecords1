IMPORT ut,SALT31;
EXPORT CRecord_hygiene(dataset(CRecord_layout_CRecord) h) := MODULE
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
    populated_payer_id_pcnt := AVE(GROUP,IF(h.payer_id = (TYPEOF(h.payer_id))'',0,100));
    maxlength_payer_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.payer_id)));
    avelength_payer_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.payer_id)),h.payer_id<>(typeof(h.payer_id))'');
    populated_form_type_pcnt := AVE(GROUP,IF(h.form_type = (TYPEOF(h.form_type))'',0,100));
    maxlength_form_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.form_type)));
    avelength_form_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.form_type)),h.form_type<>(typeof(h.form_type))'');
    populated_received_date_pcnt := AVE(GROUP,IF(h.received_date = (TYPEOF(h.received_date))'',0,100));
    maxlength_received_date := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.received_date)));
    avelength_received_date := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.received_date)),h.received_date<>(typeof(h.received_date))'');
    populated_claim_type_pcnt := AVE(GROUP,IF(h.claim_type = (TYPEOF(h.claim_type))'',0,100));
    maxlength_claim_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_type)));
    avelength_claim_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.claim_type)),h.claim_type<>(typeof(h.claim_type))'');
    populated_adjustment_code_pcnt := AVE(GROUP,IF(h.adjustment_code = (TYPEOF(h.adjustment_code))'',0,100));
    maxlength_adjustment_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjustment_code)));
    avelength_adjustment_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.adjustment_code)),h.adjustment_code<>(typeof(h.adjustment_code))'');
    populated_prev_claim_number_pcnt := AVE(GROUP,IF(h.prev_claim_number = (TYPEOF(h.prev_claim_number))'',0,100));
    maxlength_prev_claim_number := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_claim_number)));
    avelength_prev_claim_number := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prev_claim_number)),h.prev_claim_number<>(typeof(h.prev_claim_number))'');
    populated_sub_client_id_pcnt := AVE(GROUP,IF(h.sub_client_id = (TYPEOF(h.sub_client_id))'',0,100));
    maxlength_sub_client_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.sub_client_id)));
    avelength_sub_client_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.sub_client_id)),h.sub_client_id<>(typeof(h.sub_client_id))'');
    populated_group_name_pcnt := AVE(GROUP,IF(h.group_name = (TYPEOF(h.group_name))'',0,100));
    maxlength_group_name := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.group_name)));
    avelength_group_name := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.group_name)),h.group_name<>(typeof(h.group_name))'');
    populated_member_id_pcnt := AVE(GROUP,IF(h.member_id = (TYPEOF(h.member_id))'',0,100));
    maxlength_member_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_id)));
    avelength_member_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_id)),h.member_id<>(typeof(h.member_id))'');
    populated_member_fname_pcnt := AVE(GROUP,IF(h.member_fname = (TYPEOF(h.member_fname))'',0,100));
    maxlength_member_fname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_fname)));
    avelength_member_fname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_fname)),h.member_fname<>(typeof(h.member_fname))'');
    populated_member_lname_pcnt := AVE(GROUP,IF(h.member_lname = (TYPEOF(h.member_lname))'',0,100));
    maxlength_member_lname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_lname)));
    avelength_member_lname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_lname)),h.member_lname<>(typeof(h.member_lname))'');
    populated_member_gender_pcnt := AVE(GROUP,IF(h.member_gender = (TYPEOF(h.member_gender))'',0,100));
    maxlength_member_gender := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_gender)));
    avelength_member_gender := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_gender)),h.member_gender<>(typeof(h.member_gender))'');
    populated_member_dob_pcnt := AVE(GROUP,IF(h.member_dob = (TYPEOF(h.member_dob))'',0,100));
    maxlength_member_dob := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_dob)));
    avelength_member_dob := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_dob)),h.member_dob<>(typeof(h.member_dob))'');
    populated_member_address1_pcnt := AVE(GROUP,IF(h.member_address1 = (TYPEOF(h.member_address1))'',0,100));
    maxlength_member_address1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_address1)));
    avelength_member_address1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_address1)),h.member_address1<>(typeof(h.member_address1))'');
    populated_member_address2_pcnt := AVE(GROUP,IF(h.member_address2 = (TYPEOF(h.member_address2))'',0,100));
    maxlength_member_address2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_address2)));
    avelength_member_address2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_address2)),h.member_address2<>(typeof(h.member_address2))'');
    populated_member_city_pcnt := AVE(GROUP,IF(h.member_city = (TYPEOF(h.member_city))'',0,100));
    maxlength_member_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_city)));
    avelength_member_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_city)),h.member_city<>(typeof(h.member_city))'');
    populated_member_state_pcnt := AVE(GROUP,IF(h.member_state = (TYPEOF(h.member_state))'',0,100));
    maxlength_member_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_state)));
    avelength_member_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_state)),h.member_state<>(typeof(h.member_state))'');
    populated_member_zip_pcnt := AVE(GROUP,IF(h.member_zip = (TYPEOF(h.member_zip))'',0,100));
    maxlength_member_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_zip)));
    avelength_member_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.member_zip)),h.member_zip<>(typeof(h.member_zip))'');
    populated_patient_id_pcnt := AVE(GROUP,IF(h.patient_id = (TYPEOF(h.patient_id))'',0,100));
    maxlength_patient_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_id)));
    avelength_patient_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_id)),h.patient_id<>(typeof(h.patient_id))'');
    populated_patient_relation_pcnt := AVE(GROUP,IF(h.patient_relation = (TYPEOF(h.patient_relation))'',0,100));
    maxlength_patient_relation := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_relation)));
    avelength_patient_relation := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_relation)),h.patient_relation<>(typeof(h.patient_relation))'');
    populated_patient_fname_pcnt := AVE(GROUP,IF(h.patient_fname = (TYPEOF(h.patient_fname))'',0,100));
    maxlength_patient_fname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_fname)));
    avelength_patient_fname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_fname)),h.patient_fname<>(typeof(h.patient_fname))'');
    populated_patient_lname_pcnt := AVE(GROUP,IF(h.patient_lname = (TYPEOF(h.patient_lname))'',0,100));
    maxlength_patient_lname := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_lname)));
    avelength_patient_lname := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_lname)),h.patient_lname<>(typeof(h.patient_lname))'');
    populated_patient_gender_pcnt := AVE(GROUP,IF(h.patient_gender = (TYPEOF(h.patient_gender))'',0,100));
    maxlength_patient_gender := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_gender)));
    avelength_patient_gender := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_gender)),h.patient_gender<>(typeof(h.patient_gender))'');
    populated_patient_dob_pcnt := AVE(GROUP,IF(h.patient_dob = (TYPEOF(h.patient_dob))'',0,100));
    maxlength_patient_dob := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_dob)));
    avelength_patient_dob := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_dob)),h.patient_dob<>(typeof(h.patient_dob))'');
    populated_patient_age_pcnt := AVE(GROUP,IF(h.patient_age = (TYPEOF(h.patient_age))'',0,100));
    maxlength_patient_age := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_age)));
    avelength_patient_age := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_age)),h.patient_age<>(typeof(h.patient_age))'');
    populated_billing_id_pcnt := AVE(GROUP,IF(h.billing_id = (TYPEOF(h.billing_id))'',0,100));
    maxlength_billing_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_id)));
    avelength_billing_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_id)),h.billing_id<>(typeof(h.billing_id))'');
    populated_billing_npi_pcnt := AVE(GROUP,IF(h.billing_npi = (TYPEOF(h.billing_npi))'',0,100));
    maxlength_billing_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_npi)));
    avelength_billing_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_npi)),h.billing_npi<>(typeof(h.billing_npi))'');
    populated_billing_name1_pcnt := AVE(GROUP,IF(h.billing_name1 = (TYPEOF(h.billing_name1))'',0,100));
    maxlength_billing_name1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_name1)));
    avelength_billing_name1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_name1)),h.billing_name1<>(typeof(h.billing_name1))'');
    populated_billing_name2_pcnt := AVE(GROUP,IF(h.billing_name2 = (TYPEOF(h.billing_name2))'',0,100));
    maxlength_billing_name2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_name2)));
    avelength_billing_name2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_name2)),h.billing_name2<>(typeof(h.billing_name2))'');
    populated_billing_address1_pcnt := AVE(GROUP,IF(h.billing_address1 = (TYPEOF(h.billing_address1))'',0,100));
    maxlength_billing_address1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_address1)));
    avelength_billing_address1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_address1)),h.billing_address1<>(typeof(h.billing_address1))'');
    populated_billing_address2_pcnt := AVE(GROUP,IF(h.billing_address2 = (TYPEOF(h.billing_address2))'',0,100));
    maxlength_billing_address2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_address2)));
    avelength_billing_address2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_address2)),h.billing_address2<>(typeof(h.billing_address2))'');
    populated_billing_city_pcnt := AVE(GROUP,IF(h.billing_city = (TYPEOF(h.billing_city))'',0,100));
    maxlength_billing_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_city)));
    avelength_billing_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_city)),h.billing_city<>(typeof(h.billing_city))'');
    populated_billing_state_pcnt := AVE(GROUP,IF(h.billing_state = (TYPEOF(h.billing_state))'',0,100));
    maxlength_billing_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_state)));
    avelength_billing_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_state)),h.billing_state<>(typeof(h.billing_state))'');
    populated_billing_zip_pcnt := AVE(GROUP,IF(h.billing_zip = (TYPEOF(h.billing_zip))'',0,100));
    maxlength_billing_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_zip)));
    avelength_billing_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.billing_zip)),h.billing_zip<>(typeof(h.billing_zip))'');
    populated_referring_id_pcnt := AVE(GROUP,IF(h.referring_id = (TYPEOF(h.referring_id))'',0,100));
    maxlength_referring_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.referring_id)));
    avelength_referring_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.referring_id)),h.referring_id<>(typeof(h.referring_id))'');
    populated_referring_npi_pcnt := AVE(GROUP,IF(h.referring_npi = (TYPEOF(h.referring_npi))'',0,100));
    maxlength_referring_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.referring_npi)));
    avelength_referring_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.referring_npi)),h.referring_npi<>(typeof(h.referring_npi))'');
    populated_referring_name1_pcnt := AVE(GROUP,IF(h.referring_name1 = (TYPEOF(h.referring_name1))'',0,100));
    maxlength_referring_name1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.referring_name1)));
    avelength_referring_name1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.referring_name1)),h.referring_name1<>(typeof(h.referring_name1))'');
    populated_referring_name2_pcnt := AVE(GROUP,IF(h.referring_name2 = (TYPEOF(h.referring_name2))'',0,100));
    maxlength_referring_name2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.referring_name2)));
    avelength_referring_name2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.referring_name2)),h.referring_name2<>(typeof(h.referring_name2))'');
    populated_attending_id_pcnt := AVE(GROUP,IF(h.attending_id = (TYPEOF(h.attending_id))'',0,100));
    maxlength_attending_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.attending_id)));
    avelength_attending_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.attending_id)),h.attending_id<>(typeof(h.attending_id))'');
    populated_attending_npi_pcnt := AVE(GROUP,IF(h.attending_npi = (TYPEOF(h.attending_npi))'',0,100));
    maxlength_attending_npi := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.attending_npi)));
    avelength_attending_npi := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.attending_npi)),h.attending_npi<>(typeof(h.attending_npi))'');
    populated_attending_name1_pcnt := AVE(GROUP,IF(h.attending_name1 = (TYPEOF(h.attending_name1))'',0,100));
    maxlength_attending_name1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.attending_name1)));
    avelength_attending_name1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.attending_name1)),h.attending_name1<>(typeof(h.attending_name1))'');
    populated_attending_name2_pcnt := AVE(GROUP,IF(h.attending_name2 = (TYPEOF(h.attending_name2))'',0,100));
    maxlength_attending_name2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.attending_name2)));
    avelength_attending_name2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.attending_name2)),h.attending_name2<>(typeof(h.attending_name2))'');
    populated_facility_id_pcnt := AVE(GROUP,IF(h.facility_id = (TYPEOF(h.facility_id))'',0,100));
    maxlength_facility_id := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_id)));
    avelength_facility_id := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_id)),h.facility_id<>(typeof(h.facility_id))'');
    populated_facility_name1_pcnt := AVE(GROUP,IF(h.facility_name1 = (TYPEOF(h.facility_name1))'',0,100));
    maxlength_facility_name1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_name1)));
    avelength_facility_name1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_name1)),h.facility_name1<>(typeof(h.facility_name1))'');
    populated_facility_name2_pcnt := AVE(GROUP,IF(h.facility_name2 = (TYPEOF(h.facility_name2))'',0,100));
    maxlength_facility_name2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_name2)));
    avelength_facility_name2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_name2)),h.facility_name2<>(typeof(h.facility_name2))'');
    populated_facility_address1_pcnt := AVE(GROUP,IF(h.facility_address1 = (TYPEOF(h.facility_address1))'',0,100));
    maxlength_facility_address1 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_address1)));
    avelength_facility_address1 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_address1)),h.facility_address1<>(typeof(h.facility_address1))'');
    populated_facility_address2_pcnt := AVE(GROUP,IF(h.facility_address2 = (TYPEOF(h.facility_address2))'',0,100));
    maxlength_facility_address2 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_address2)));
    avelength_facility_address2 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_address2)),h.facility_address2<>(typeof(h.facility_address2))'');
    populated_facility_city_pcnt := AVE(GROUP,IF(h.facility_city = (TYPEOF(h.facility_city))'',0,100));
    maxlength_facility_city := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_city)));
    avelength_facility_city := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_city)),h.facility_city<>(typeof(h.facility_city))'');
    populated_facility_state_pcnt := AVE(GROUP,IF(h.facility_state = (TYPEOF(h.facility_state))'',0,100));
    maxlength_facility_state := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_state)));
    avelength_facility_state := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_state)),h.facility_state<>(typeof(h.facility_state))'');
    populated_facility_zip_pcnt := AVE(GROUP,IF(h.facility_zip = (TYPEOF(h.facility_zip))'',0,100));
    maxlength_facility_zip := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_zip)));
    avelength_facility_zip := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.facility_zip)),h.facility_zip<>(typeof(h.facility_zip))'');
    populated_statement_from_pcnt := AVE(GROUP,IF(h.statement_from = (TYPEOF(h.statement_from))'',0,100));
    maxlength_statement_from := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.statement_from)));
    avelength_statement_from := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.statement_from)),h.statement_from<>(typeof(h.statement_from))'');
    populated_statement_to_pcnt := AVE(GROUP,IF(h.statement_to = (TYPEOF(h.statement_to))'',0,100));
    maxlength_statement_to := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.statement_to)));
    avelength_statement_to := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.statement_to)),h.statement_to<>(typeof(h.statement_to))'');
    populated_total_charge_pcnt := AVE(GROUP,IF(h.total_charge = (TYPEOF(h.total_charge))'',0,100));
    maxlength_total_charge := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.total_charge)));
    avelength_total_charge := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.total_charge)),h.total_charge<>(typeof(h.total_charge))'');
    populated_total_allowed_pcnt := AVE(GROUP,IF(h.total_allowed = (TYPEOF(h.total_allowed))'',0,100));
    maxlength_total_allowed := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.total_allowed)));
    avelength_total_allowed := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.total_allowed)),h.total_allowed<>(typeof(h.total_allowed))'');
    populated_drg_code_pcnt := AVE(GROUP,IF(h.drg_code = (TYPEOF(h.drg_code))'',0,100));
    maxlength_drg_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.drg_code)));
    avelength_drg_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.drg_code)),h.drg_code<>(typeof(h.drg_code))'');
    populated_patient_control_pcnt := AVE(GROUP,IF(h.patient_control = (TYPEOF(h.patient_control))'',0,100));
    maxlength_patient_control := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_control)));
    avelength_patient_control := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.patient_control)),h.patient_control<>(typeof(h.patient_control))'');
    populated_bill_type_pcnt := AVE(GROUP,IF(h.bill_type = (TYPEOF(h.bill_type))'',0,100));
    maxlength_bill_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.bill_type)));
    avelength_bill_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.bill_type)),h.bill_type<>(typeof(h.bill_type))'');
    populated_release_sign_pcnt := AVE(GROUP,IF(h.release_sign = (TYPEOF(h.release_sign))'',0,100));
    maxlength_release_sign := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.release_sign)));
    avelength_release_sign := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.release_sign)),h.release_sign<>(typeof(h.release_sign))'');
    populated_assignment_sign_pcnt := AVE(GROUP,IF(h.assignment_sign = (TYPEOF(h.assignment_sign))'',0,100));
    maxlength_assignment_sign := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.assignment_sign)));
    avelength_assignment_sign := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.assignment_sign)),h.assignment_sign<>(typeof(h.assignment_sign))'');
    populated_in_out_network_pcnt := AVE(GROUP,IF(h.in_out_network = (TYPEOF(h.in_out_network))'',0,100));
    maxlength_in_out_network := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_out_network)));
    avelength_in_out_network := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.in_out_network)),h.in_out_network<>(typeof(h.in_out_network))'');
    populated_principal_proc_pcnt := AVE(GROUP,IF(h.principal_proc = (TYPEOF(h.principal_proc))'',0,100));
    maxlength_principal_proc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.principal_proc)));
    avelength_principal_proc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.principal_proc)),h.principal_proc<>(typeof(h.principal_proc))'');
    populated_admit_diag_pcnt := AVE(GROUP,IF(h.admit_diag = (TYPEOF(h.admit_diag))'',0,100));
    maxlength_admit_diag := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.admit_diag)));
    avelength_admit_diag := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.admit_diag)),h.admit_diag<>(typeof(h.admit_diag))'');
    populated_primary_diag_pcnt := AVE(GROUP,IF(h.primary_diag = (TYPEOF(h.primary_diag))'',0,100));
    maxlength_primary_diag := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.primary_diag)));
    avelength_primary_diag := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.primary_diag)),h.primary_diag<>(typeof(h.primary_diag))'');
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
    populated_other_proc_pcnt := AVE(GROUP,IF(h.other_proc = (TYPEOF(h.other_proc))'',0,100));
    maxlength_other_proc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc)));
    avelength_other_proc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc)),h.other_proc<>(typeof(h.other_proc))'');
    populated_other_proc3_pcnt := AVE(GROUP,IF(h.other_proc3 = (TYPEOF(h.other_proc3))'',0,100));
    maxlength_other_proc3 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc3)));
    avelength_other_proc3 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc3)),h.other_proc3<>(typeof(h.other_proc3))'');
    populated_other_proc4_pcnt := AVE(GROUP,IF(h.other_proc4 = (TYPEOF(h.other_proc4))'',0,100));
    maxlength_other_proc4 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc4)));
    avelength_other_proc4 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc4)),h.other_proc4<>(typeof(h.other_proc4))'');
    populated_other_proc5_pcnt := AVE(GROUP,IF(h.other_proc5 = (TYPEOF(h.other_proc5))'',0,100));
    maxlength_other_proc5 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc5)));
    avelength_other_proc5 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc5)),h.other_proc5<>(typeof(h.other_proc5))'');
    populated_other_proc6_pcnt := AVE(GROUP,IF(h.other_proc6 = (TYPEOF(h.other_proc6))'',0,100));
    maxlength_other_proc6 := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc6)));
    avelength_other_proc6 := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.other_proc6)),h.other_proc6<>(typeof(h.other_proc6))'');
    populated_prov_specialty_pcnt := AVE(GROUP,IF(h.prov_specialty = (TYPEOF(h.prov_specialty))'',0,100));
    maxlength_prov_specialty := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_specialty)));
    avelength_prov_specialty := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.prov_specialty)),h.prov_specialty<>(typeof(h.prov_specialty))'');
    populated_coverage_type_pcnt := AVE(GROUP,IF(h.coverage_type = (TYPEOF(h.coverage_type))'',0,100));
    maxlength_coverage_type := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.coverage_type)));
    avelength_coverage_type := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.coverage_type)),h.coverage_type<>(typeof(h.coverage_type))'');
    populated_explanation_code_pcnt := AVE(GROUP,IF(h.explanation_code = (TYPEOF(h.explanation_code))'',0,100));
    maxlength_explanation_code := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.explanation_code)));
    avelength_explanation_code := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.explanation_code)),h.explanation_code<>(typeof(h.explanation_code))'');
    populated_accident_related_pcnt := AVE(GROUP,IF(h.accident_related = (TYPEOF(h.accident_related))'',0,100));
    maxlength_accident_related := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.accident_related)));
    avelength_accident_related := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.accident_related)),h.accident_related<>(typeof(h.accident_related))'');
    populated_esrd_patient_pcnt := AVE(GROUP,IF(h.esrd_patient = (TYPEOF(h.esrd_patient))'',0,100));
    maxlength_esrd_patient := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.esrd_patient)));
    avelength_esrd_patient := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.esrd_patient)),h.esrd_patient<>(typeof(h.esrd_patient))'');
    populated_hosp_admit_or_er_pcnt := AVE(GROUP,IF(h.hosp_admit_or_er = (TYPEOF(h.hosp_admit_or_er))'',0,100));
    maxlength_hosp_admit_or_er := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.hosp_admit_or_er)));
    avelength_hosp_admit_or_er := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.hosp_admit_or_er)),h.hosp_admit_or_er<>(typeof(h.hosp_admit_or_er))'');
    populated_amb_nurse_to_hosp_pcnt := AVE(GROUP,IF(h.amb_nurse_to_hosp = (TYPEOF(h.amb_nurse_to_hosp))'',0,100));
    maxlength_amb_nurse_to_hosp := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.amb_nurse_to_hosp)));
    avelength_amb_nurse_to_hosp := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.amb_nurse_to_hosp)),h.amb_nurse_to_hosp<>(typeof(h.amb_nurse_to_hosp))'');
    populated_non_covered_specialty_pcnt := AVE(GROUP,IF(h.non_covered_specialty = (TYPEOF(h.non_covered_specialty))'',0,100));
    maxlength_non_covered_specialty := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.non_covered_specialty)));
    avelength_non_covered_specialty := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.non_covered_specialty)),h.non_covered_specialty<>(typeof(h.non_covered_specialty))'');
    populated_electronic_claim_pcnt := AVE(GROUP,IF(h.electronic_claim = (TYPEOF(h.electronic_claim))'',0,100));
    maxlength_electronic_claim := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.electronic_claim)));
    avelength_electronic_claim := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.electronic_claim)),h.electronic_claim<>(typeof(h.electronic_claim))'');
    populated_dialysis_related_pcnt := AVE(GROUP,IF(h.dialysis_related = (TYPEOF(h.dialysis_related))'',0,100));
    maxlength_dialysis_related := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.dialysis_related)));
    avelength_dialysis_related := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.dialysis_related)),h.dialysis_related<>(typeof(h.dialysis_related))'');
    populated_new_patient_pcnt := AVE(GROUP,IF(h.new_patient = (TYPEOF(h.new_patient))'',0,100));
    maxlength_new_patient := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.new_patient)));
    avelength_new_patient := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.new_patient)),h.new_patient<>(typeof(h.new_patient))'');
    populated_init_proc_pcnt := AVE(GROUP,IF(h.init_proc = (TYPEOF(h.init_proc))'',0,100));
    maxlength_init_proc := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.init_proc)));
    avelength_init_proc := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.init_proc)),h.init_proc<>(typeof(h.init_proc))'');
    populated_amb_nurse_to_diag_pcnt := AVE(GROUP,IF(h.amb_nurse_to_diag = (TYPEOF(h.amb_nurse_to_diag))'',0,100));
    maxlength_amb_nurse_to_diag := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.amb_nurse_to_diag)));
    avelength_amb_nurse_to_diag := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.amb_nurse_to_diag)),h.amb_nurse_to_diag<>(typeof(h.amb_nurse_to_diag))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_claim_num_pcnt *   0.00 / 100 + T.Populated_claim_rec_type_pcnt *   0.00 / 100 + T.Populated_payer_id_pcnt *   0.00 / 100 + T.Populated_form_type_pcnt *   0.00 / 100 + T.Populated_received_date_pcnt *   0.00 / 100 + T.Populated_claim_type_pcnt *   0.00 / 100 + T.Populated_adjustment_code_pcnt *   0.00 / 100 + T.Populated_prev_claim_number_pcnt *   0.00 / 100 + T.Populated_sub_client_id_pcnt *   0.00 / 100 + T.Populated_group_name_pcnt *   0.00 / 100 + T.Populated_member_id_pcnt *   0.00 / 100 + T.Populated_member_fname_pcnt *   0.00 / 100 + T.Populated_member_lname_pcnt *   0.00 / 100 + T.Populated_member_gender_pcnt *   0.00 / 100 + T.Populated_member_dob_pcnt *   0.00 / 100 + T.Populated_member_address1_pcnt *   0.00 / 100 + T.Populated_member_address2_pcnt *   0.00 / 100 + T.Populated_member_city_pcnt *   0.00 / 100 + T.Populated_member_state_pcnt *   0.00 / 100 + T.Populated_member_zip_pcnt *   0.00 / 100 + T.Populated_patient_id_pcnt *   0.00 / 100 + T.Populated_patient_relation_pcnt *   0.00 / 100 + T.Populated_patient_fname_pcnt *   0.00 / 100 + T.Populated_patient_lname_pcnt *   0.00 / 100 + T.Populated_patient_gender_pcnt *   0.00 / 100 + T.Populated_patient_dob_pcnt *   0.00 / 100 + T.Populated_patient_age_pcnt *   0.00 / 100 + T.Populated_billing_id_pcnt *   0.00 / 100 + T.Populated_billing_npi_pcnt *   0.00 / 100 + T.Populated_billing_name1_pcnt *   0.00 / 100 + T.Populated_billing_name2_pcnt *   0.00 / 100 + T.Populated_billing_address1_pcnt *   0.00 / 100 + T.Populated_billing_address2_pcnt *   0.00 / 100 + T.Populated_billing_city_pcnt *   0.00 / 100 + T.Populated_billing_state_pcnt *   0.00 / 100 + T.Populated_billing_zip_pcnt *   0.00 / 100 + T.Populated_referring_id_pcnt *   0.00 / 100 + T.Populated_referring_npi_pcnt *   0.00 / 100 + T.Populated_referring_name1_pcnt *   0.00 / 100 + T.Populated_referring_name2_pcnt *   0.00 / 100 + T.Populated_attending_id_pcnt *   0.00 / 100 + T.Populated_attending_npi_pcnt *   0.00 / 100 + T.Populated_attending_name1_pcnt *   0.00 / 100 + T.Populated_attending_name2_pcnt *   0.00 / 100 + T.Populated_facility_id_pcnt *   0.00 / 100 + T.Populated_facility_name1_pcnt *   0.00 / 100 + T.Populated_facility_name2_pcnt *   0.00 / 100 + T.Populated_facility_address1_pcnt *   0.00 / 100 + T.Populated_facility_address2_pcnt *   0.00 / 100 + T.Populated_facility_city_pcnt *   0.00 / 100 + T.Populated_facility_state_pcnt *   0.00 / 100 + T.Populated_facility_zip_pcnt *   0.00 / 100 + T.Populated_statement_from_pcnt *   0.00 / 100 + T.Populated_statement_to_pcnt *   0.00 / 100 + T.Populated_total_charge_pcnt *   0.00 / 100 + T.Populated_total_allowed_pcnt *   0.00 / 100 + T.Populated_drg_code_pcnt *   0.00 / 100 + T.Populated_patient_control_pcnt *   0.00 / 100 + T.Populated_bill_type_pcnt *   0.00 / 100 + T.Populated_release_sign_pcnt *   0.00 / 100 + T.Populated_assignment_sign_pcnt *   0.00 / 100 + T.Populated_in_out_network_pcnt *   0.00 / 100 + T.Populated_principal_proc_pcnt *   0.00 / 100 + T.Populated_admit_diag_pcnt *   0.00 / 100 + T.Populated_primary_diag_pcnt *   0.00 / 100 + T.Populated_diag_code2_pcnt *   0.00 / 100 + T.Populated_diag_code3_pcnt *   0.00 / 100 + T.Populated_diag_code4_pcnt *   0.00 / 100 + T.Populated_diag_code5_pcnt *   0.00 / 100 + T.Populated_diag_code6_pcnt *   0.00 / 100 + T.Populated_diag_code7_pcnt *   0.00 / 100 + T.Populated_diag_code8_pcnt *   0.00 / 100 + T.Populated_other_proc_pcnt *   0.00 / 100 + T.Populated_other_proc3_pcnt *   0.00 / 100 + T.Populated_other_proc4_pcnt *   0.00 / 100 + T.Populated_other_proc5_pcnt *   0.00 / 100 + T.Populated_other_proc6_pcnt *   0.00 / 100 + T.Populated_prov_specialty_pcnt *   0.00 / 100 + T.Populated_coverage_type_pcnt *   0.00 / 100 + T.Populated_explanation_code_pcnt *   0.00 / 100 + T.Populated_accident_related_pcnt *   0.00 / 100 + T.Populated_esrd_patient_pcnt *   0.00 / 100 + T.Populated_hosp_admit_or_er_pcnt *   0.00 / 100 + T.Populated_amb_nurse_to_hosp_pcnt *   0.00 / 100 + T.Populated_non_covered_specialty_pcnt *   0.00 / 100 + T.Populated_electronic_claim_pcnt *   0.00 / 100 + T.Populated_dialysis_related_pcnt *   0.00 / 100 + T.Populated_new_patient_pcnt *   0.00 / 100 + T.Populated_init_proc_pcnt *   0.00 / 100 + T.Populated_amb_nurse_to_diag_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'claim_num','claim_rec_type','payer_id','form_type','received_date','claim_type','adjustment_code','prev_claim_number','sub_client_id','group_name','member_id','member_fname','member_lname','member_gender','member_dob','member_address1','member_address2','member_city','member_state','member_zip','patient_id','patient_relation','patient_fname','patient_lname','patient_gender','patient_dob','patient_age','billing_id','billing_npi','billing_name1','billing_name2','billing_address1','billing_address2','billing_city','billing_state','billing_zip','referring_id','referring_npi','referring_name1','referring_name2','attending_id','attending_npi','attending_name1','attending_name2','facility_id','facility_name1','facility_name2','facility_address1','facility_address2','facility_city','facility_state','facility_zip','statement_from','statement_to','total_charge','total_allowed','drg_code','patient_control','bill_type','release_sign','assignment_sign','in_out_network','principal_proc','admit_diag','primary_diag','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','other_proc','other_proc3','other_proc4','other_proc5','other_proc6','prov_specialty','coverage_type','explanation_code','accident_related','esrd_patient','hosp_admit_or_er','amb_nurse_to_hosp','non_covered_specialty','electronic_claim','dialysis_related','new_patient','init_proc','amb_nurse_to_diag');
  SELF.populated_pcnt := CHOOSE(C,le.populated_claim_num_pcnt,le.populated_claim_rec_type_pcnt,le.populated_payer_id_pcnt,le.populated_form_type_pcnt,le.populated_received_date_pcnt,le.populated_claim_type_pcnt,le.populated_adjustment_code_pcnt,le.populated_prev_claim_number_pcnt,le.populated_sub_client_id_pcnt,le.populated_group_name_pcnt,le.populated_member_id_pcnt,le.populated_member_fname_pcnt,le.populated_member_lname_pcnt,le.populated_member_gender_pcnt,le.populated_member_dob_pcnt,le.populated_member_address1_pcnt,le.populated_member_address2_pcnt,le.populated_member_city_pcnt,le.populated_member_state_pcnt,le.populated_member_zip_pcnt,le.populated_patient_id_pcnt,le.populated_patient_relation_pcnt,le.populated_patient_fname_pcnt,le.populated_patient_lname_pcnt,le.populated_patient_gender_pcnt,le.populated_patient_dob_pcnt,le.populated_patient_age_pcnt,le.populated_billing_id_pcnt,le.populated_billing_npi_pcnt,le.populated_billing_name1_pcnt,le.populated_billing_name2_pcnt,le.populated_billing_address1_pcnt,le.populated_billing_address2_pcnt,le.populated_billing_city_pcnt,le.populated_billing_state_pcnt,le.populated_billing_zip_pcnt,le.populated_referring_id_pcnt,le.populated_referring_npi_pcnt,le.populated_referring_name1_pcnt,le.populated_referring_name2_pcnt,le.populated_attending_id_pcnt,le.populated_attending_npi_pcnt,le.populated_attending_name1_pcnt,le.populated_attending_name2_pcnt,le.populated_facility_id_pcnt,le.populated_facility_name1_pcnt,le.populated_facility_name2_pcnt,le.populated_facility_address1_pcnt,le.populated_facility_address2_pcnt,le.populated_facility_city_pcnt,le.populated_facility_state_pcnt,le.populated_facility_zip_pcnt,le.populated_statement_from_pcnt,le.populated_statement_to_pcnt,le.populated_total_charge_pcnt,le.populated_total_allowed_pcnt,le.populated_drg_code_pcnt,le.populated_patient_control_pcnt,le.populated_bill_type_pcnt,le.populated_release_sign_pcnt,le.populated_assignment_sign_pcnt,le.populated_in_out_network_pcnt,le.populated_principal_proc_pcnt,le.populated_admit_diag_pcnt,le.populated_primary_diag_pcnt,le.populated_diag_code2_pcnt,le.populated_diag_code3_pcnt,le.populated_diag_code4_pcnt,le.populated_diag_code5_pcnt,le.populated_diag_code6_pcnt,le.populated_diag_code7_pcnt,le.populated_diag_code8_pcnt,le.populated_other_proc_pcnt,le.populated_other_proc3_pcnt,le.populated_other_proc4_pcnt,le.populated_other_proc5_pcnt,le.populated_other_proc6_pcnt,le.populated_prov_specialty_pcnt,le.populated_coverage_type_pcnt,le.populated_explanation_code_pcnt,le.populated_accident_related_pcnt,le.populated_esrd_patient_pcnt,le.populated_hosp_admit_or_er_pcnt,le.populated_amb_nurse_to_hosp_pcnt,le.populated_non_covered_specialty_pcnt,le.populated_electronic_claim_pcnt,le.populated_dialysis_related_pcnt,le.populated_new_patient_pcnt,le.populated_init_proc_pcnt,le.populated_amb_nurse_to_diag_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_claim_num,le.maxlength_claim_rec_type,le.maxlength_payer_id,le.maxlength_form_type,le.maxlength_received_date,le.maxlength_claim_type,le.maxlength_adjustment_code,le.maxlength_prev_claim_number,le.maxlength_sub_client_id,le.maxlength_group_name,le.maxlength_member_id,le.maxlength_member_fname,le.maxlength_member_lname,le.maxlength_member_gender,le.maxlength_member_dob,le.maxlength_member_address1,le.maxlength_member_address2,le.maxlength_member_city,le.maxlength_member_state,le.maxlength_member_zip,le.maxlength_patient_id,le.maxlength_patient_relation,le.maxlength_patient_fname,le.maxlength_patient_lname,le.maxlength_patient_gender,le.maxlength_patient_dob,le.maxlength_patient_age,le.maxlength_billing_id,le.maxlength_billing_npi,le.maxlength_billing_name1,le.maxlength_billing_name2,le.maxlength_billing_address1,le.maxlength_billing_address2,le.maxlength_billing_city,le.maxlength_billing_state,le.maxlength_billing_zip,le.maxlength_referring_id,le.maxlength_referring_npi,le.maxlength_referring_name1,le.maxlength_referring_name2,le.maxlength_attending_id,le.maxlength_attending_npi,le.maxlength_attending_name1,le.maxlength_attending_name2,le.maxlength_facility_id,le.maxlength_facility_name1,le.maxlength_facility_name2,le.maxlength_facility_address1,le.maxlength_facility_address2,le.maxlength_facility_city,le.maxlength_facility_state,le.maxlength_facility_zip,le.maxlength_statement_from,le.maxlength_statement_to,le.maxlength_total_charge,le.maxlength_total_allowed,le.maxlength_drg_code,le.maxlength_patient_control,le.maxlength_bill_type,le.maxlength_release_sign,le.maxlength_assignment_sign,le.maxlength_in_out_network,le.maxlength_principal_proc,le.maxlength_admit_diag,le.maxlength_primary_diag,le.maxlength_diag_code2,le.maxlength_diag_code3,le.maxlength_diag_code4,le.maxlength_diag_code5,le.maxlength_diag_code6,le.maxlength_diag_code7,le.maxlength_diag_code8,le.maxlength_other_proc,le.maxlength_other_proc3,le.maxlength_other_proc4,le.maxlength_other_proc5,le.maxlength_other_proc6,le.maxlength_prov_specialty,le.maxlength_coverage_type,le.maxlength_explanation_code,le.maxlength_accident_related,le.maxlength_esrd_patient,le.maxlength_hosp_admit_or_er,le.maxlength_amb_nurse_to_hosp,le.maxlength_non_covered_specialty,le.maxlength_electronic_claim,le.maxlength_dialysis_related,le.maxlength_new_patient,le.maxlength_init_proc,le.maxlength_amb_nurse_to_diag);
  SELF.avelength := CHOOSE(C,le.avelength_claim_num,le.avelength_claim_rec_type,le.avelength_payer_id,le.avelength_form_type,le.avelength_received_date,le.avelength_claim_type,le.avelength_adjustment_code,le.avelength_prev_claim_number,le.avelength_sub_client_id,le.avelength_group_name,le.avelength_member_id,le.avelength_member_fname,le.avelength_member_lname,le.avelength_member_gender,le.avelength_member_dob,le.avelength_member_address1,le.avelength_member_address2,le.avelength_member_city,le.avelength_member_state,le.avelength_member_zip,le.avelength_patient_id,le.avelength_patient_relation,le.avelength_patient_fname,le.avelength_patient_lname,le.avelength_patient_gender,le.avelength_patient_dob,le.avelength_patient_age,le.avelength_billing_id,le.avelength_billing_npi,le.avelength_billing_name1,le.avelength_billing_name2,le.avelength_billing_address1,le.avelength_billing_address2,le.avelength_billing_city,le.avelength_billing_state,le.avelength_billing_zip,le.avelength_referring_id,le.avelength_referring_npi,le.avelength_referring_name1,le.avelength_referring_name2,le.avelength_attending_id,le.avelength_attending_npi,le.avelength_attending_name1,le.avelength_attending_name2,le.avelength_facility_id,le.avelength_facility_name1,le.avelength_facility_name2,le.avelength_facility_address1,le.avelength_facility_address2,le.avelength_facility_city,le.avelength_facility_state,le.avelength_facility_zip,le.avelength_statement_from,le.avelength_statement_to,le.avelength_total_charge,le.avelength_total_allowed,le.avelength_drg_code,le.avelength_patient_control,le.avelength_bill_type,le.avelength_release_sign,le.avelength_assignment_sign,le.avelength_in_out_network,le.avelength_principal_proc,le.avelength_admit_diag,le.avelength_primary_diag,le.avelength_diag_code2,le.avelength_diag_code3,le.avelength_diag_code4,le.avelength_diag_code5,le.avelength_diag_code6,le.avelength_diag_code7,le.avelength_diag_code8,le.avelength_other_proc,le.avelength_other_proc3,le.avelength_other_proc4,le.avelength_other_proc5,le.avelength_other_proc6,le.avelength_prov_specialty,le.avelength_coverage_type,le.avelength_explanation_code,le.avelength_accident_related,le.avelength_esrd_patient,le.avelength_hosp_admit_or_er,le.avelength_amb_nurse_to_hosp,le.avelength_non_covered_specialty,le.avelength_electronic_claim,le.avelength_dialysis_related,le.avelength_new_patient,le.avelength_init_proc,le.avelength_amb_nurse_to_diag);
END;
EXPORT invSummary := NORMALIZE(summary0, 90, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.claim_rec_type),TRIM((SALT31.StrType)le.payer_id),TRIM((SALT31.StrType)le.form_type),TRIM((SALT31.StrType)le.received_date),TRIM((SALT31.StrType)le.claim_type),TRIM((SALT31.StrType)le.adjustment_code),TRIM((SALT31.StrType)le.prev_claim_number),TRIM((SALT31.StrType)le.sub_client_id),TRIM((SALT31.StrType)le.group_name),TRIM((SALT31.StrType)le.member_id),TRIM((SALT31.StrType)le.member_fname),TRIM((SALT31.StrType)le.member_lname),TRIM((SALT31.StrType)le.member_gender),TRIM((SALT31.StrType)le.member_dob),TRIM((SALT31.StrType)le.member_address1),TRIM((SALT31.StrType)le.member_address2),TRIM((SALT31.StrType)le.member_city),TRIM((SALT31.StrType)le.member_state),TRIM((SALT31.StrType)le.member_zip),TRIM((SALT31.StrType)le.patient_id),TRIM((SALT31.StrType)le.patient_relation),TRIM((SALT31.StrType)le.patient_fname),TRIM((SALT31.StrType)le.patient_lname),TRIM((SALT31.StrType)le.patient_gender),TRIM((SALT31.StrType)le.patient_dob),TRIM((SALT31.StrType)le.patient_age),TRIM((SALT31.StrType)le.billing_id),TRIM((SALT31.StrType)le.billing_npi),TRIM((SALT31.StrType)le.billing_name1),TRIM((SALT31.StrType)le.billing_name2),TRIM((SALT31.StrType)le.billing_address1),TRIM((SALT31.StrType)le.billing_address2),TRIM((SALT31.StrType)le.billing_city),TRIM((SALT31.StrType)le.billing_state),TRIM((SALT31.StrType)le.billing_zip),TRIM((SALT31.StrType)le.referring_id),TRIM((SALT31.StrType)le.referring_npi),TRIM((SALT31.StrType)le.referring_name1),TRIM((SALT31.StrType)le.referring_name2),TRIM((SALT31.StrType)le.attending_id),TRIM((SALT31.StrType)le.attending_npi),TRIM((SALT31.StrType)le.attending_name1),TRIM((SALT31.StrType)le.attending_name2),TRIM((SALT31.StrType)le.facility_id),TRIM((SALT31.StrType)le.facility_name1),TRIM((SALT31.StrType)le.facility_name2),TRIM((SALT31.StrType)le.facility_address1),TRIM((SALT31.StrType)le.facility_address2),TRIM((SALT31.StrType)le.facility_city),TRIM((SALT31.StrType)le.facility_state),TRIM((SALT31.StrType)le.facility_zip),TRIM((SALT31.StrType)le.statement_from),TRIM((SALT31.StrType)le.statement_to),TRIM((SALT31.StrType)le.total_charge),TRIM((SALT31.StrType)le.total_allowed),TRIM((SALT31.StrType)le.drg_code),TRIM((SALT31.StrType)le.patient_control),TRIM((SALT31.StrType)le.bill_type),TRIM((SALT31.StrType)le.release_sign),TRIM((SALT31.StrType)le.assignment_sign),TRIM((SALT31.StrType)le.in_out_network),TRIM((SALT31.StrType)le.principal_proc),TRIM((SALT31.StrType)le.admit_diag),TRIM((SALT31.StrType)le.primary_diag),TRIM((SALT31.StrType)le.diag_code2),TRIM((SALT31.StrType)le.diag_code3),TRIM((SALT31.StrType)le.diag_code4),TRIM((SALT31.StrType)le.diag_code5),TRIM((SALT31.StrType)le.diag_code6),TRIM((SALT31.StrType)le.diag_code7),TRIM((SALT31.StrType)le.diag_code8),TRIM((SALT31.StrType)le.other_proc),TRIM((SALT31.StrType)le.other_proc3),TRIM((SALT31.StrType)le.other_proc4),TRIM((SALT31.StrType)le.other_proc5),TRIM((SALT31.StrType)le.other_proc6),TRIM((SALT31.StrType)le.prov_specialty),TRIM((SALT31.StrType)le.coverage_type),TRIM((SALT31.StrType)le.explanation_code),TRIM((SALT31.StrType)le.accident_related),TRIM((SALT31.StrType)le.esrd_patient),TRIM((SALT31.StrType)le.hosp_admit_or_er),TRIM((SALT31.StrType)le.amb_nurse_to_hosp),TRIM((SALT31.StrType)le.non_covered_specialty),TRIM((SALT31.StrType)le.electronic_claim),TRIM((SALT31.StrType)le.dialysis_related),TRIM((SALT31.StrType)le.new_patient),TRIM((SALT31.StrType)le.init_proc),TRIM((SALT31.StrType)le.amb_nurse_to_diag)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,90,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 90);
  SELF.FldNo2 := 1 + (C % 90);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.claim_rec_type),TRIM((SALT31.StrType)le.payer_id),TRIM((SALT31.StrType)le.form_type),TRIM((SALT31.StrType)le.received_date),TRIM((SALT31.StrType)le.claim_type),TRIM((SALT31.StrType)le.adjustment_code),TRIM((SALT31.StrType)le.prev_claim_number),TRIM((SALT31.StrType)le.sub_client_id),TRIM((SALT31.StrType)le.group_name),TRIM((SALT31.StrType)le.member_id),TRIM((SALT31.StrType)le.member_fname),TRIM((SALT31.StrType)le.member_lname),TRIM((SALT31.StrType)le.member_gender),TRIM((SALT31.StrType)le.member_dob),TRIM((SALT31.StrType)le.member_address1),TRIM((SALT31.StrType)le.member_address2),TRIM((SALT31.StrType)le.member_city),TRIM((SALT31.StrType)le.member_state),TRIM((SALT31.StrType)le.member_zip),TRIM((SALT31.StrType)le.patient_id),TRIM((SALT31.StrType)le.patient_relation),TRIM((SALT31.StrType)le.patient_fname),TRIM((SALT31.StrType)le.patient_lname),TRIM((SALT31.StrType)le.patient_gender),TRIM((SALT31.StrType)le.patient_dob),TRIM((SALT31.StrType)le.patient_age),TRIM((SALT31.StrType)le.billing_id),TRIM((SALT31.StrType)le.billing_npi),TRIM((SALT31.StrType)le.billing_name1),TRIM((SALT31.StrType)le.billing_name2),TRIM((SALT31.StrType)le.billing_address1),TRIM((SALT31.StrType)le.billing_address2),TRIM((SALT31.StrType)le.billing_city),TRIM((SALT31.StrType)le.billing_state),TRIM((SALT31.StrType)le.billing_zip),TRIM((SALT31.StrType)le.referring_id),TRIM((SALT31.StrType)le.referring_npi),TRIM((SALT31.StrType)le.referring_name1),TRIM((SALT31.StrType)le.referring_name2),TRIM((SALT31.StrType)le.attending_id),TRIM((SALT31.StrType)le.attending_npi),TRIM((SALT31.StrType)le.attending_name1),TRIM((SALT31.StrType)le.attending_name2),TRIM((SALT31.StrType)le.facility_id),TRIM((SALT31.StrType)le.facility_name1),TRIM((SALT31.StrType)le.facility_name2),TRIM((SALT31.StrType)le.facility_address1),TRIM((SALT31.StrType)le.facility_address2),TRIM((SALT31.StrType)le.facility_city),TRIM((SALT31.StrType)le.facility_state),TRIM((SALT31.StrType)le.facility_zip),TRIM((SALT31.StrType)le.statement_from),TRIM((SALT31.StrType)le.statement_to),TRIM((SALT31.StrType)le.total_charge),TRIM((SALT31.StrType)le.total_allowed),TRIM((SALT31.StrType)le.drg_code),TRIM((SALT31.StrType)le.patient_control),TRIM((SALT31.StrType)le.bill_type),TRIM((SALT31.StrType)le.release_sign),TRIM((SALT31.StrType)le.assignment_sign),TRIM((SALT31.StrType)le.in_out_network),TRIM((SALT31.StrType)le.principal_proc),TRIM((SALT31.StrType)le.admit_diag),TRIM((SALT31.StrType)le.primary_diag),TRIM((SALT31.StrType)le.diag_code2),TRIM((SALT31.StrType)le.diag_code3),TRIM((SALT31.StrType)le.diag_code4),TRIM((SALT31.StrType)le.diag_code5),TRIM((SALT31.StrType)le.diag_code6),TRIM((SALT31.StrType)le.diag_code7),TRIM((SALT31.StrType)le.diag_code8),TRIM((SALT31.StrType)le.other_proc),TRIM((SALT31.StrType)le.other_proc3),TRIM((SALT31.StrType)le.other_proc4),TRIM((SALT31.StrType)le.other_proc5),TRIM((SALT31.StrType)le.other_proc6),TRIM((SALT31.StrType)le.prov_specialty),TRIM((SALT31.StrType)le.coverage_type),TRIM((SALT31.StrType)le.explanation_code),TRIM((SALT31.StrType)le.accident_related),TRIM((SALT31.StrType)le.esrd_patient),TRIM((SALT31.StrType)le.hosp_admit_or_er),TRIM((SALT31.StrType)le.amb_nurse_to_hosp),TRIM((SALT31.StrType)le.non_covered_specialty),TRIM((SALT31.StrType)le.electronic_claim),TRIM((SALT31.StrType)le.dialysis_related),TRIM((SALT31.StrType)le.new_patient),TRIM((SALT31.StrType)le.init_proc),TRIM((SALT31.StrType)le.amb_nurse_to_diag)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.claim_num),TRIM((SALT31.StrType)le.claim_rec_type),TRIM((SALT31.StrType)le.payer_id),TRIM((SALT31.StrType)le.form_type),TRIM((SALT31.StrType)le.received_date),TRIM((SALT31.StrType)le.claim_type),TRIM((SALT31.StrType)le.adjustment_code),TRIM((SALT31.StrType)le.prev_claim_number),TRIM((SALT31.StrType)le.sub_client_id),TRIM((SALT31.StrType)le.group_name),TRIM((SALT31.StrType)le.member_id),TRIM((SALT31.StrType)le.member_fname),TRIM((SALT31.StrType)le.member_lname),TRIM((SALT31.StrType)le.member_gender),TRIM((SALT31.StrType)le.member_dob),TRIM((SALT31.StrType)le.member_address1),TRIM((SALT31.StrType)le.member_address2),TRIM((SALT31.StrType)le.member_city),TRIM((SALT31.StrType)le.member_state),TRIM((SALT31.StrType)le.member_zip),TRIM((SALT31.StrType)le.patient_id),TRIM((SALT31.StrType)le.patient_relation),TRIM((SALT31.StrType)le.patient_fname),TRIM((SALT31.StrType)le.patient_lname),TRIM((SALT31.StrType)le.patient_gender),TRIM((SALT31.StrType)le.patient_dob),TRIM((SALT31.StrType)le.patient_age),TRIM((SALT31.StrType)le.billing_id),TRIM((SALT31.StrType)le.billing_npi),TRIM((SALT31.StrType)le.billing_name1),TRIM((SALT31.StrType)le.billing_name2),TRIM((SALT31.StrType)le.billing_address1),TRIM((SALT31.StrType)le.billing_address2),TRIM((SALT31.StrType)le.billing_city),TRIM((SALT31.StrType)le.billing_state),TRIM((SALT31.StrType)le.billing_zip),TRIM((SALT31.StrType)le.referring_id),TRIM((SALT31.StrType)le.referring_npi),TRIM((SALT31.StrType)le.referring_name1),TRIM((SALT31.StrType)le.referring_name2),TRIM((SALT31.StrType)le.attending_id),TRIM((SALT31.StrType)le.attending_npi),TRIM((SALT31.StrType)le.attending_name1),TRIM((SALT31.StrType)le.attending_name2),TRIM((SALT31.StrType)le.facility_id),TRIM((SALT31.StrType)le.facility_name1),TRIM((SALT31.StrType)le.facility_name2),TRIM((SALT31.StrType)le.facility_address1),TRIM((SALT31.StrType)le.facility_address2),TRIM((SALT31.StrType)le.facility_city),TRIM((SALT31.StrType)le.facility_state),TRIM((SALT31.StrType)le.facility_zip),TRIM((SALT31.StrType)le.statement_from),TRIM((SALT31.StrType)le.statement_to),TRIM((SALT31.StrType)le.total_charge),TRIM((SALT31.StrType)le.total_allowed),TRIM((SALT31.StrType)le.drg_code),TRIM((SALT31.StrType)le.patient_control),TRIM((SALT31.StrType)le.bill_type),TRIM((SALT31.StrType)le.release_sign),TRIM((SALT31.StrType)le.assignment_sign),TRIM((SALT31.StrType)le.in_out_network),TRIM((SALT31.StrType)le.principal_proc),TRIM((SALT31.StrType)le.admit_diag),TRIM((SALT31.StrType)le.primary_diag),TRIM((SALT31.StrType)le.diag_code2),TRIM((SALT31.StrType)le.diag_code3),TRIM((SALT31.StrType)le.diag_code4),TRIM((SALT31.StrType)le.diag_code5),TRIM((SALT31.StrType)le.diag_code6),TRIM((SALT31.StrType)le.diag_code7),TRIM((SALT31.StrType)le.diag_code8),TRIM((SALT31.StrType)le.other_proc),TRIM((SALT31.StrType)le.other_proc3),TRIM((SALT31.StrType)le.other_proc4),TRIM((SALT31.StrType)le.other_proc5),TRIM((SALT31.StrType)le.other_proc6),TRIM((SALT31.StrType)le.prov_specialty),TRIM((SALT31.StrType)le.coverage_type),TRIM((SALT31.StrType)le.explanation_code),TRIM((SALT31.StrType)le.accident_related),TRIM((SALT31.StrType)le.esrd_patient),TRIM((SALT31.StrType)le.hosp_admit_or_er),TRIM((SALT31.StrType)le.amb_nurse_to_hosp),TRIM((SALT31.StrType)le.non_covered_specialty),TRIM((SALT31.StrType)le.electronic_claim),TRIM((SALT31.StrType)le.dialysis_related),TRIM((SALT31.StrType)le.new_patient),TRIM((SALT31.StrType)le.init_proc),TRIM((SALT31.StrType)le.amb_nurse_to_diag)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),90*90,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'claim_num'}
      ,{2,'claim_rec_type'}
      ,{3,'payer_id'}
      ,{4,'form_type'}
      ,{5,'received_date'}
      ,{6,'claim_type'}
      ,{7,'adjustment_code'}
      ,{8,'prev_claim_number'}
      ,{9,'sub_client_id'}
      ,{10,'group_name'}
      ,{11,'member_id'}
      ,{12,'member_fname'}
      ,{13,'member_lname'}
      ,{14,'member_gender'}
      ,{15,'member_dob'}
      ,{16,'member_address1'}
      ,{17,'member_address2'}
      ,{18,'member_city'}
      ,{19,'member_state'}
      ,{20,'member_zip'}
      ,{21,'patient_id'}
      ,{22,'patient_relation'}
      ,{23,'patient_fname'}
      ,{24,'patient_lname'}
      ,{25,'patient_gender'}
      ,{26,'patient_dob'}
      ,{27,'patient_age'}
      ,{28,'billing_id'}
      ,{29,'billing_npi'}
      ,{30,'billing_name1'}
      ,{31,'billing_name2'}
      ,{32,'billing_address1'}
      ,{33,'billing_address2'}
      ,{34,'billing_city'}
      ,{35,'billing_state'}
      ,{36,'billing_zip'}
      ,{37,'referring_id'}
      ,{38,'referring_npi'}
      ,{39,'referring_name1'}
      ,{40,'referring_name2'}
      ,{41,'attending_id'}
      ,{42,'attending_npi'}
      ,{43,'attending_name1'}
      ,{44,'attending_name2'}
      ,{45,'facility_id'}
      ,{46,'facility_name1'}
      ,{47,'facility_name2'}
      ,{48,'facility_address1'}
      ,{49,'facility_address2'}
      ,{50,'facility_city'}
      ,{51,'facility_state'}
      ,{52,'facility_zip'}
      ,{53,'statement_from'}
      ,{54,'statement_to'}
      ,{55,'total_charge'}
      ,{56,'total_allowed'}
      ,{57,'drg_code'}
      ,{58,'patient_control'}
      ,{59,'bill_type'}
      ,{60,'release_sign'}
      ,{61,'assignment_sign'}
      ,{62,'in_out_network'}
      ,{63,'principal_proc'}
      ,{64,'admit_diag'}
      ,{65,'primary_diag'}
      ,{66,'diag_code2'}
      ,{67,'diag_code3'}
      ,{68,'diag_code4'}
      ,{69,'diag_code5'}
      ,{70,'diag_code6'}
      ,{71,'diag_code7'}
      ,{72,'diag_code8'}
      ,{73,'other_proc'}
      ,{74,'other_proc3'}
      ,{75,'other_proc4'}
      ,{76,'other_proc5'}
      ,{77,'other_proc6'}
      ,{78,'prov_specialty'}
      ,{79,'coverage_type'}
      ,{80,'explanation_code'}
      ,{81,'accident_related'}
      ,{82,'esrd_patient'}
      ,{83,'hosp_admit_or_er'}
      ,{84,'amb_nurse_to_hosp'}
      ,{85,'non_covered_specialty'}
      ,{86,'electronic_claim'}
      ,{87,'dialysis_related'}
      ,{88,'new_patient'}
      ,{89,'init_proc'}
      ,{90,'amb_nurse_to_diag'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    CRecord_Fields.InValid_claim_num((SALT31.StrType)le.claim_num),
    CRecord_Fields.InValid_claim_rec_type((SALT31.StrType)le.claim_rec_type),
    CRecord_Fields.InValid_payer_id((SALT31.StrType)le.payer_id),
    CRecord_Fields.InValid_form_type((SALT31.StrType)le.form_type),
    CRecord_Fields.InValid_received_date((SALT31.StrType)le.received_date),
    CRecord_Fields.InValid_claim_type((SALT31.StrType)le.claim_type),
    CRecord_Fields.InValid_adjustment_code((SALT31.StrType)le.adjustment_code),
    CRecord_Fields.InValid_prev_claim_number((SALT31.StrType)le.prev_claim_number),
    CRecord_Fields.InValid_sub_client_id((SALT31.StrType)le.sub_client_id),
    CRecord_Fields.InValid_group_name((SALT31.StrType)le.group_name),
    CRecord_Fields.InValid_member_id((SALT31.StrType)le.member_id),
    CRecord_Fields.InValid_member_fname((SALT31.StrType)le.member_fname),
    CRecord_Fields.InValid_member_lname((SALT31.StrType)le.member_lname),
    CRecord_Fields.InValid_member_gender((SALT31.StrType)le.member_gender),
    CRecord_Fields.InValid_member_dob((SALT31.StrType)le.member_dob),
    CRecord_Fields.InValid_member_address1((SALT31.StrType)le.member_address1),
    CRecord_Fields.InValid_member_address2((SALT31.StrType)le.member_address2),
    CRecord_Fields.InValid_member_city((SALT31.StrType)le.member_city),
    CRecord_Fields.InValid_member_state((SALT31.StrType)le.member_state),
    CRecord_Fields.InValid_member_zip((SALT31.StrType)le.member_zip),
    CRecord_Fields.InValid_patient_id((SALT31.StrType)le.patient_id),
    CRecord_Fields.InValid_patient_relation((SALT31.StrType)le.patient_relation),
    CRecord_Fields.InValid_patient_fname((SALT31.StrType)le.patient_fname),
    CRecord_Fields.InValid_patient_lname((SALT31.StrType)le.patient_lname),
    CRecord_Fields.InValid_patient_gender((SALT31.StrType)le.patient_gender),
    CRecord_Fields.InValid_patient_dob((SALT31.StrType)le.patient_dob),
    CRecord_Fields.InValid_patient_age((SALT31.StrType)le.patient_age),
    CRecord_Fields.InValid_billing_id((SALT31.StrType)le.billing_id),
    CRecord_Fields.InValid_billing_npi((SALT31.StrType)le.billing_npi),
    CRecord_Fields.InValid_billing_name1((SALT31.StrType)le.billing_name1),
    CRecord_Fields.InValid_billing_name2((SALT31.StrType)le.billing_name2),
    CRecord_Fields.InValid_billing_address1((SALT31.StrType)le.billing_address1),
    CRecord_Fields.InValid_billing_address2((SALT31.StrType)le.billing_address2),
    CRecord_Fields.InValid_billing_city((SALT31.StrType)le.billing_city),
    CRecord_Fields.InValid_billing_state((SALT31.StrType)le.billing_state),
    CRecord_Fields.InValid_billing_zip((SALT31.StrType)le.billing_zip),
    CRecord_Fields.InValid_referring_id((SALT31.StrType)le.referring_id),
    CRecord_Fields.InValid_referring_npi((SALT31.StrType)le.referring_npi),
    CRecord_Fields.InValid_referring_name1((SALT31.StrType)le.referring_name1),
    CRecord_Fields.InValid_referring_name2((SALT31.StrType)le.referring_name2),
    CRecord_Fields.InValid_attending_id((SALT31.StrType)le.attending_id),
    CRecord_Fields.InValid_attending_npi((SALT31.StrType)le.attending_npi),
    CRecord_Fields.InValid_attending_name1((SALT31.StrType)le.attending_name1),
    CRecord_Fields.InValid_attending_name2((SALT31.StrType)le.attending_name2),
    CRecord_Fields.InValid_facility_id((SALT31.StrType)le.facility_id),
    CRecord_Fields.InValid_facility_name1((SALT31.StrType)le.facility_name1),
    CRecord_Fields.InValid_facility_name2((SALT31.StrType)le.facility_name2),
    CRecord_Fields.InValid_facility_address1((SALT31.StrType)le.facility_address1),
    CRecord_Fields.InValid_facility_address2((SALT31.StrType)le.facility_address2),
    CRecord_Fields.InValid_facility_city((SALT31.StrType)le.facility_city),
    CRecord_Fields.InValid_facility_state((SALT31.StrType)le.facility_state),
    CRecord_Fields.InValid_facility_zip((SALT31.StrType)le.facility_zip),
    CRecord_Fields.InValid_statement_from((SALT31.StrType)le.statement_from),
    CRecord_Fields.InValid_statement_to((SALT31.StrType)le.statement_to),
    CRecord_Fields.InValid_total_charge((SALT31.StrType)le.total_charge),
    CRecord_Fields.InValid_total_allowed((SALT31.StrType)le.total_allowed),
    CRecord_Fields.InValid_drg_code((SALT31.StrType)le.drg_code),
    CRecord_Fields.InValid_patient_control((SALT31.StrType)le.patient_control),
    CRecord_Fields.InValid_bill_type((SALT31.StrType)le.bill_type),
    CRecord_Fields.InValid_release_sign((SALT31.StrType)le.release_sign),
    CRecord_Fields.InValid_assignment_sign((SALT31.StrType)le.assignment_sign),
    CRecord_Fields.InValid_in_out_network((SALT31.StrType)le.in_out_network),
    CRecord_Fields.InValid_principal_proc((SALT31.StrType)le.principal_proc),
    CRecord_Fields.InValid_admit_diag((SALT31.StrType)le.admit_diag),
    CRecord_Fields.InValid_primary_diag((SALT31.StrType)le.primary_diag),
    CRecord_Fields.InValid_diag_code2((SALT31.StrType)le.diag_code2),
    CRecord_Fields.InValid_diag_code3((SALT31.StrType)le.diag_code3),
    CRecord_Fields.InValid_diag_code4((SALT31.StrType)le.diag_code4),
    CRecord_Fields.InValid_diag_code5((SALT31.StrType)le.diag_code5),
    CRecord_Fields.InValid_diag_code6((SALT31.StrType)le.diag_code6),
    CRecord_Fields.InValid_diag_code7((SALT31.StrType)le.diag_code7),
    CRecord_Fields.InValid_diag_code8((SALT31.StrType)le.diag_code8),
    CRecord_Fields.InValid_other_proc((SALT31.StrType)le.other_proc),
    CRecord_Fields.InValid_other_proc3((SALT31.StrType)le.other_proc3),
    CRecord_Fields.InValid_other_proc4((SALT31.StrType)le.other_proc4),
    CRecord_Fields.InValid_other_proc5((SALT31.StrType)le.other_proc5),
    CRecord_Fields.InValid_other_proc6((SALT31.StrType)le.other_proc6),
    CRecord_Fields.InValid_prov_specialty((SALT31.StrType)le.prov_specialty),
    CRecord_Fields.InValid_coverage_type((SALT31.StrType)le.coverage_type),
    CRecord_Fields.InValid_explanation_code((SALT31.StrType)le.explanation_code),
    CRecord_Fields.InValid_accident_related((SALT31.StrType)le.accident_related),
    CRecord_Fields.InValid_esrd_patient((SALT31.StrType)le.esrd_patient),
    CRecord_Fields.InValid_hosp_admit_or_er((SALT31.StrType)le.hosp_admit_or_er),
    CRecord_Fields.InValid_amb_nurse_to_hosp((SALT31.StrType)le.amb_nurse_to_hosp),
    CRecord_Fields.InValid_non_covered_specialty((SALT31.StrType)le.non_covered_specialty),
    CRecord_Fields.InValid_electronic_claim((SALT31.StrType)le.electronic_claim),
    CRecord_Fields.InValid_dialysis_related((SALT31.StrType)le.dialysis_related),
    CRecord_Fields.InValid_new_patient((SALT31.StrType)le.new_patient),
    CRecord_Fields.InValid_init_proc((SALT31.StrType)le.init_proc),
    CRecord_Fields.InValid_amb_nurse_to_diag((SALT31.StrType)le.amb_nurse_to_diag),
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
  FieldNme := CRecord_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'claim_num','claim_rec_type','payer_id','form_type','received_date','claim_type','adjustment_code','prev_claim_number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','member_dob','Unknown','Unknown','Unknown','member_state','member_zip','Unknown','patient_relation','Unknown','Unknown','patient_gender','patient_dob','Unknown','billing_id','billing_npi','Unknown','Unknown','Unknown','Unknown','Unknown','billing_state','billing_zip','referring_id','referring_npi','referring_name1','referring_name2','attending_id','attending_npi','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','facility_state','facility_zip','Unknown','statement_to','total_charge','Unknown','drg_code','Unknown','bill_type','release_sign','assignment_sign','Unknown','principal_proc','admit_diag','primary_diag','diag_code2','diag_code3','diag_code4','diag_code5','diag_code6','diag_code7','diag_code8','other_proc','other_proc3','other_proc4','other_proc5','other_proc6','Unknown','coverage_type','Unknown','accident_related','esrd_patient','hosp_admit_or_er','amb_nurse_to_hosp','non_covered_specialty','electronic_claim','dialysis_related','new_patient','init_proc','amb_nurse_to_diag');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,CRecord_Fields.InValidMessage_claim_num(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_claim_rec_type(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_payer_id(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_form_type(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_received_date(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_claim_type(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_adjustment_code(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_prev_claim_number(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_sub_client_id(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_group_name(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_member_id(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_member_fname(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_member_lname(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_member_gender(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_member_dob(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_member_address1(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_member_address2(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_member_city(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_member_state(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_member_zip(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_patient_id(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_patient_relation(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_patient_fname(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_patient_lname(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_patient_gender(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_patient_dob(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_patient_age(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_billing_id(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_billing_npi(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_billing_name1(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_billing_name2(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_billing_address1(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_billing_address2(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_billing_city(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_billing_state(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_billing_zip(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_referring_id(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_referring_npi(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_referring_name1(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_referring_name2(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_attending_id(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_attending_npi(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_attending_name1(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_attending_name2(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_facility_id(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_facility_name1(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_facility_name2(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_facility_address1(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_facility_address2(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_facility_city(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_facility_state(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_facility_zip(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_statement_from(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_statement_to(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_total_charge(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_total_allowed(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_drg_code(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_patient_control(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_bill_type(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_release_sign(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_assignment_sign(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_in_out_network(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_principal_proc(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_admit_diag(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_primary_diag(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_diag_code2(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_diag_code3(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_diag_code4(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_diag_code5(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_diag_code6(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_diag_code7(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_diag_code8(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_other_proc(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_other_proc3(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_other_proc4(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_other_proc5(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_other_proc6(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_prov_specialty(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_coverage_type(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_explanation_code(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_accident_related(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_esrd_patient(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_hosp_admit_or_er(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_amb_nurse_to_hosp(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_non_covered_specialty(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_electronic_claim(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_dialysis_related(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_new_patient(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_init_proc(TotalErrors.ErrorNum),CRecord_Fields.InValidMessage_amb_nurse_to_diag(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
