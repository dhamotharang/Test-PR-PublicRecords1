IMPORT SALT311,STD;
EXPORT IL_Main_hygiene(dataset(IL_Main_layout_UCCV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_tmsid_cnt := COUNT(GROUP,h.tmsid <> (TYPEOF(h.tmsid))'');
    populated_tmsid_pcnt := AVE(GROUP,IF(h.tmsid = (TYPEOF(h.tmsid))'',0,100));
    maxlength_tmsid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tmsid)));
    avelength_tmsid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tmsid)),h.tmsid<>(typeof(h.tmsid))'');
    populated_rmsid_cnt := COUNT(GROUP,h.rmsid <> (TYPEOF(h.rmsid))'');
    populated_rmsid_pcnt := AVE(GROUP,IF(h.rmsid = (TYPEOF(h.rmsid))'',0,100));
    maxlength_rmsid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rmsid)));
    avelength_rmsid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rmsid)),h.rmsid<>(typeof(h.rmsid))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_static_value_cnt := COUNT(GROUP,h.static_value <> (TYPEOF(h.static_value))'');
    populated_static_value_pcnt := AVE(GROUP,IF(h.static_value = (TYPEOF(h.static_value))'',0,100));
    maxlength_static_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.static_value)));
    avelength_static_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.static_value)),h.static_value<>(typeof(h.static_value))'');
    populated_date_vendor_removed_cnt := COUNT(GROUP,h.date_vendor_removed <> (TYPEOF(h.date_vendor_removed))'');
    populated_date_vendor_removed_pcnt := AVE(GROUP,IF(h.date_vendor_removed = (TYPEOF(h.date_vendor_removed))'',0,100));
    maxlength_date_vendor_removed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_removed)));
    avelength_date_vendor_removed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_removed)),h.date_vendor_removed<>(typeof(h.date_vendor_removed))'');
    populated_date_vendor_changed_cnt := COUNT(GROUP,h.date_vendor_changed <> (TYPEOF(h.date_vendor_changed))'');
    populated_date_vendor_changed_pcnt := AVE(GROUP,IF(h.date_vendor_changed = (TYPEOF(h.date_vendor_changed))'',0,100));
    maxlength_date_vendor_changed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_changed)));
    avelength_date_vendor_changed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_changed)),h.date_vendor_changed<>(typeof(h.date_vendor_changed))'');
    populated_filing_jurisdiction_cnt := COUNT(GROUP,h.filing_jurisdiction <> (TYPEOF(h.filing_jurisdiction))'');
    populated_filing_jurisdiction_pcnt := AVE(GROUP,IF(h.filing_jurisdiction = (TYPEOF(h.filing_jurisdiction))'',0,100));
    maxlength_filing_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_jurisdiction)));
    avelength_filing_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_jurisdiction)),h.filing_jurisdiction<>(typeof(h.filing_jurisdiction))'');
    populated_orig_filing_number_cnt := COUNT(GROUP,h.orig_filing_number <> (TYPEOF(h.orig_filing_number))'');
    populated_orig_filing_number_pcnt := AVE(GROUP,IF(h.orig_filing_number = (TYPEOF(h.orig_filing_number))'',0,100));
    maxlength_orig_filing_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_filing_number)));
    avelength_orig_filing_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_filing_number)),h.orig_filing_number<>(typeof(h.orig_filing_number))'');
    populated_orig_filing_type_cnt := COUNT(GROUP,h.orig_filing_type <> (TYPEOF(h.orig_filing_type))'');
    populated_orig_filing_type_pcnt := AVE(GROUP,IF(h.orig_filing_type = (TYPEOF(h.orig_filing_type))'',0,100));
    maxlength_orig_filing_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_filing_type)));
    avelength_orig_filing_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_filing_type)),h.orig_filing_type<>(typeof(h.orig_filing_type))'');
    populated_orig_filing_date_cnt := COUNT(GROUP,h.orig_filing_date <> (TYPEOF(h.orig_filing_date))'');
    populated_orig_filing_date_pcnt := AVE(GROUP,IF(h.orig_filing_date = (TYPEOF(h.orig_filing_date))'',0,100));
    maxlength_orig_filing_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_filing_date)));
    avelength_orig_filing_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_filing_date)),h.orig_filing_date<>(typeof(h.orig_filing_date))'');
    populated_orig_filing_time_cnt := COUNT(GROUP,h.orig_filing_time <> (TYPEOF(h.orig_filing_time))'');
    populated_orig_filing_time_pcnt := AVE(GROUP,IF(h.orig_filing_time = (TYPEOF(h.orig_filing_time))'',0,100));
    maxlength_orig_filing_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_filing_time)));
    avelength_orig_filing_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_filing_time)),h.orig_filing_time<>(typeof(h.orig_filing_time))'');
    populated_filing_number_cnt := COUNT(GROUP,h.filing_number <> (TYPEOF(h.filing_number))'');
    populated_filing_number_pcnt := AVE(GROUP,IF(h.filing_number = (TYPEOF(h.filing_number))'',0,100));
    maxlength_filing_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_number)));
    avelength_filing_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_number)),h.filing_number<>(typeof(h.filing_number))'');
    populated_filing_number_indc_cnt := COUNT(GROUP,h.filing_number_indc <> (TYPEOF(h.filing_number_indc))'');
    populated_filing_number_indc_pcnt := AVE(GROUP,IF(h.filing_number_indc = (TYPEOF(h.filing_number_indc))'',0,100));
    maxlength_filing_number_indc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_number_indc)));
    avelength_filing_number_indc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_number_indc)),h.filing_number_indc<>(typeof(h.filing_number_indc))'');
    populated_filing_type_cnt := COUNT(GROUP,h.filing_type <> (TYPEOF(h.filing_type))'');
    populated_filing_type_pcnt := AVE(GROUP,IF(h.filing_type = (TYPEOF(h.filing_type))'',0,100));
    maxlength_filing_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_type)));
    avelength_filing_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_type)),h.filing_type<>(typeof(h.filing_type))'');
    populated_filing_date_cnt := COUNT(GROUP,h.filing_date <> (TYPEOF(h.filing_date))'');
    populated_filing_date_pcnt := AVE(GROUP,IF(h.filing_date = (TYPEOF(h.filing_date))'',0,100));
    maxlength_filing_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_date)));
    avelength_filing_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_date)),h.filing_date<>(typeof(h.filing_date))'');
    populated_filing_time_cnt := COUNT(GROUP,h.filing_time <> (TYPEOF(h.filing_time))'');
    populated_filing_time_pcnt := AVE(GROUP,IF(h.filing_time = (TYPEOF(h.filing_time))'',0,100));
    maxlength_filing_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_time)));
    avelength_filing_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_time)),h.filing_time<>(typeof(h.filing_time))'');
    populated_filing_status_cnt := COUNT(GROUP,h.filing_status <> (TYPEOF(h.filing_status))'');
    populated_filing_status_pcnt := AVE(GROUP,IF(h.filing_status = (TYPEOF(h.filing_status))'',0,100));
    maxlength_filing_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_status)));
    avelength_filing_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_status)),h.filing_status<>(typeof(h.filing_status))'');
    populated_status_type_cnt := COUNT(GROUP,h.status_type <> (TYPEOF(h.status_type))'');
    populated_status_type_pcnt := AVE(GROUP,IF(h.status_type = (TYPEOF(h.status_type))'',0,100));
    maxlength_status_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.status_type)));
    avelength_status_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.status_type)),h.status_type<>(typeof(h.status_type))'');
    populated_page_cnt := COUNT(GROUP,h.page <> (TYPEOF(h.page))'');
    populated_page_pcnt := AVE(GROUP,IF(h.page = (TYPEOF(h.page))'',0,100));
    maxlength_page := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.page)));
    avelength_page := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.page)),h.page<>(typeof(h.page))'');
    populated_expiration_date_cnt := COUNT(GROUP,h.expiration_date <> (TYPEOF(h.expiration_date))'');
    populated_expiration_date_pcnt := AVE(GROUP,IF(h.expiration_date = (TYPEOF(h.expiration_date))'',0,100));
    maxlength_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expiration_date)));
    avelength_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expiration_date)),h.expiration_date<>(typeof(h.expiration_date))'');
    populated_contract_type_cnt := COUNT(GROUP,h.contract_type <> (TYPEOF(h.contract_type))'');
    populated_contract_type_pcnt := AVE(GROUP,IF(h.contract_type = (TYPEOF(h.contract_type))'',0,100));
    maxlength_contract_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contract_type)));
    avelength_contract_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contract_type)),h.contract_type<>(typeof(h.contract_type))'');
    populated_vendor_entry_date_cnt := COUNT(GROUP,h.vendor_entry_date <> (TYPEOF(h.vendor_entry_date))'');
    populated_vendor_entry_date_pcnt := AVE(GROUP,IF(h.vendor_entry_date = (TYPEOF(h.vendor_entry_date))'',0,100));
    maxlength_vendor_entry_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_entry_date)));
    avelength_vendor_entry_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_entry_date)),h.vendor_entry_date<>(typeof(h.vendor_entry_date))'');
    populated_vendor_upd_date_cnt := COUNT(GROUP,h.vendor_upd_date <> (TYPEOF(h.vendor_upd_date))'');
    populated_vendor_upd_date_pcnt := AVE(GROUP,IF(h.vendor_upd_date = (TYPEOF(h.vendor_upd_date))'',0,100));
    maxlength_vendor_upd_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_upd_date)));
    avelength_vendor_upd_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_upd_date)),h.vendor_upd_date<>(typeof(h.vendor_upd_date))'');
    populated_statements_filed_cnt := COUNT(GROUP,h.statements_filed <> (TYPEOF(h.statements_filed))'');
    populated_statements_filed_pcnt := AVE(GROUP,IF(h.statements_filed = (TYPEOF(h.statements_filed))'',0,100));
    maxlength_statements_filed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.statements_filed)));
    avelength_statements_filed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.statements_filed)),h.statements_filed<>(typeof(h.statements_filed))'');
    populated_continuious_expiration_cnt := COUNT(GROUP,h.continuious_expiration <> (TYPEOF(h.continuious_expiration))'');
    populated_continuious_expiration_pcnt := AVE(GROUP,IF(h.continuious_expiration = (TYPEOF(h.continuious_expiration))'',0,100));
    maxlength_continuious_expiration := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.continuious_expiration)));
    avelength_continuious_expiration := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.continuious_expiration)),h.continuious_expiration<>(typeof(h.continuious_expiration))'');
    populated_microfilm_number_cnt := COUNT(GROUP,h.microfilm_number <> (TYPEOF(h.microfilm_number))'');
    populated_microfilm_number_pcnt := AVE(GROUP,IF(h.microfilm_number = (TYPEOF(h.microfilm_number))'',0,100));
    maxlength_microfilm_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.microfilm_number)));
    avelength_microfilm_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.microfilm_number)),h.microfilm_number<>(typeof(h.microfilm_number))'');
    populated_amount_cnt := COUNT(GROUP,h.amount <> (TYPEOF(h.amount))'');
    populated_amount_pcnt := AVE(GROUP,IF(h.amount = (TYPEOF(h.amount))'',0,100));
    maxlength_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.amount)));
    avelength_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.amount)),h.amount<>(typeof(h.amount))'');
    populated_irs_serial_number_cnt := COUNT(GROUP,h.irs_serial_number <> (TYPEOF(h.irs_serial_number))'');
    populated_irs_serial_number_pcnt := AVE(GROUP,IF(h.irs_serial_number = (TYPEOF(h.irs_serial_number))'',0,100));
    maxlength_irs_serial_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.irs_serial_number)));
    avelength_irs_serial_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.irs_serial_number)),h.irs_serial_number<>(typeof(h.irs_serial_number))'');
    populated_effective_date_cnt := COUNT(GROUP,h.effective_date <> (TYPEOF(h.effective_date))'');
    populated_effective_date_pcnt := AVE(GROUP,IF(h.effective_date = (TYPEOF(h.effective_date))'',0,100));
    maxlength_effective_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.effective_date)));
    avelength_effective_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.effective_date)),h.effective_date<>(typeof(h.effective_date))'');
    populated_signer_name_cnt := COUNT(GROUP,h.signer_name <> (TYPEOF(h.signer_name))'');
    populated_signer_name_pcnt := AVE(GROUP,IF(h.signer_name = (TYPEOF(h.signer_name))'',0,100));
    maxlength_signer_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.signer_name)));
    avelength_signer_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.signer_name)),h.signer_name<>(typeof(h.signer_name))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_filing_agency_cnt := COUNT(GROUP,h.filing_agency <> (TYPEOF(h.filing_agency))'');
    populated_filing_agency_pcnt := AVE(GROUP,IF(h.filing_agency = (TYPEOF(h.filing_agency))'',0,100));
    maxlength_filing_agency := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_agency)));
    avelength_filing_agency := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filing_agency)),h.filing_agency<>(typeof(h.filing_agency))'');
    populated_address_cnt := COUNT(GROUP,h.address <> (TYPEOF(h.address))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_duns_number_cnt := COUNT(GROUP,h.duns_number <> (TYPEOF(h.duns_number))'');
    populated_duns_number_pcnt := AVE(GROUP,IF(h.duns_number = (TYPEOF(h.duns_number))'',0,100));
    maxlength_duns_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.duns_number)));
    avelength_duns_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.duns_number)),h.duns_number<>(typeof(h.duns_number))'');
    populated_cmnt_effective_date_cnt := COUNT(GROUP,h.cmnt_effective_date <> (TYPEOF(h.cmnt_effective_date))'');
    populated_cmnt_effective_date_pcnt := AVE(GROUP,IF(h.cmnt_effective_date = (TYPEOF(h.cmnt_effective_date))'',0,100));
    maxlength_cmnt_effective_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cmnt_effective_date)));
    avelength_cmnt_effective_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cmnt_effective_date)),h.cmnt_effective_date<>(typeof(h.cmnt_effective_date))'');
    populated_description_cnt := COUNT(GROUP,h.description <> (TYPEOF(h.description))'');
    populated_description_pcnt := AVE(GROUP,IF(h.description = (TYPEOF(h.description))'',0,100));
    maxlength_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.description)));
    avelength_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.description)),h.description<>(typeof(h.description))'');
    populated_collateral_desc_cnt := COUNT(GROUP,h.collateral_desc <> (TYPEOF(h.collateral_desc))'');
    populated_collateral_desc_pcnt := AVE(GROUP,IF(h.collateral_desc = (TYPEOF(h.collateral_desc))'',0,100));
    maxlength_collateral_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.collateral_desc)));
    avelength_collateral_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.collateral_desc)),h.collateral_desc<>(typeof(h.collateral_desc))'');
    populated_prim_machine_cnt := COUNT(GROUP,h.prim_machine <> (TYPEOF(h.prim_machine))'');
    populated_prim_machine_pcnt := AVE(GROUP,IF(h.prim_machine = (TYPEOF(h.prim_machine))'',0,100));
    maxlength_prim_machine := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_machine)));
    avelength_prim_machine := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_machine)),h.prim_machine<>(typeof(h.prim_machine))'');
    populated_sec_machine_cnt := COUNT(GROUP,h.sec_machine <> (TYPEOF(h.sec_machine))'');
    populated_sec_machine_pcnt := AVE(GROUP,IF(h.sec_machine = (TYPEOF(h.sec_machine))'',0,100));
    maxlength_sec_machine := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_machine)));
    avelength_sec_machine := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_machine)),h.sec_machine<>(typeof(h.sec_machine))'');
    populated_manufacturer_code_cnt := COUNT(GROUP,h.manufacturer_code <> (TYPEOF(h.manufacturer_code))'');
    populated_manufacturer_code_pcnt := AVE(GROUP,IF(h.manufacturer_code = (TYPEOF(h.manufacturer_code))'',0,100));
    maxlength_manufacturer_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufacturer_code)));
    avelength_manufacturer_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufacturer_code)),h.manufacturer_code<>(typeof(h.manufacturer_code))'');
    populated_manufacturer_name_cnt := COUNT(GROUP,h.manufacturer_name <> (TYPEOF(h.manufacturer_name))'');
    populated_manufacturer_name_pcnt := AVE(GROUP,IF(h.manufacturer_name = (TYPEOF(h.manufacturer_name))'',0,100));
    maxlength_manufacturer_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufacturer_name)));
    avelength_manufacturer_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufacturer_name)),h.manufacturer_name<>(typeof(h.manufacturer_name))'');
    populated_model_cnt := COUNT(GROUP,h.model <> (TYPEOF(h.model))'');
    populated_model_pcnt := AVE(GROUP,IF(h.model = (TYPEOF(h.model))'',0,100));
    maxlength_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model)));
    avelength_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model)),h.model<>(typeof(h.model))'');
    populated_model_year_cnt := COUNT(GROUP,h.model_year <> (TYPEOF(h.model_year))'');
    populated_model_year_pcnt := AVE(GROUP,IF(h.model_year = (TYPEOF(h.model_year))'',0,100));
    maxlength_model_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_year)));
    avelength_model_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_year)),h.model_year<>(typeof(h.model_year))'');
    populated_model_desc_cnt := COUNT(GROUP,h.model_desc <> (TYPEOF(h.model_desc))'');
    populated_model_desc_pcnt := AVE(GROUP,IF(h.model_desc = (TYPEOF(h.model_desc))'',0,100));
    maxlength_model_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_desc)));
    avelength_model_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model_desc)),h.model_desc<>(typeof(h.model_desc))'');
    populated_collateral_count_cnt := COUNT(GROUP,h.collateral_count <> (TYPEOF(h.collateral_count))'');
    populated_collateral_count_pcnt := AVE(GROUP,IF(h.collateral_count = (TYPEOF(h.collateral_count))'',0,100));
    maxlength_collateral_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.collateral_count)));
    avelength_collateral_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.collateral_count)),h.collateral_count<>(typeof(h.collateral_count))'');
    populated_manufactured_year_cnt := COUNT(GROUP,h.manufactured_year <> (TYPEOF(h.manufactured_year))'');
    populated_manufactured_year_pcnt := AVE(GROUP,IF(h.manufactured_year = (TYPEOF(h.manufactured_year))'',0,100));
    maxlength_manufactured_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufactured_year)));
    avelength_manufactured_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.manufactured_year)),h.manufactured_year<>(typeof(h.manufactured_year))'');
    populated_new_used_cnt := COUNT(GROUP,h.new_used <> (TYPEOF(h.new_used))'');
    populated_new_used_pcnt := AVE(GROUP,IF(h.new_used = (TYPEOF(h.new_used))'',0,100));
    maxlength_new_used := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_used)));
    avelength_new_used := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.new_used)),h.new_used<>(typeof(h.new_used))'');
    populated_serial_number_cnt := COUNT(GROUP,h.serial_number <> (TYPEOF(h.serial_number))'');
    populated_serial_number_pcnt := AVE(GROUP,IF(h.serial_number = (TYPEOF(h.serial_number))'',0,100));
    maxlength_serial_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.serial_number)));
    avelength_serial_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.serial_number)),h.serial_number<>(typeof(h.serial_number))'');
    populated_property_desc_cnt := COUNT(GROUP,h.property_desc <> (TYPEOF(h.property_desc))'');
    populated_property_desc_pcnt := AVE(GROUP,IF(h.property_desc = (TYPEOF(h.property_desc))'',0,100));
    maxlength_property_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_desc)));
    avelength_property_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_desc)),h.property_desc<>(typeof(h.property_desc))'');
    populated_borough_cnt := COUNT(GROUP,h.borough <> (TYPEOF(h.borough))'');
    populated_borough_pcnt := AVE(GROUP,IF(h.borough = (TYPEOF(h.borough))'',0,100));
    maxlength_borough := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.borough)));
    avelength_borough := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.borough)),h.borough<>(typeof(h.borough))'');
    populated_block_cnt := COUNT(GROUP,h.block <> (TYPEOF(h.block))'');
    populated_block_pcnt := AVE(GROUP,IF(h.block = (TYPEOF(h.block))'',0,100));
    maxlength_block := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.block)));
    avelength_block := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.block)),h.block<>(typeof(h.block))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_collateral_address_cnt := COUNT(GROUP,h.collateral_address <> (TYPEOF(h.collateral_address))'');
    populated_collateral_address_pcnt := AVE(GROUP,IF(h.collateral_address = (TYPEOF(h.collateral_address))'',0,100));
    maxlength_collateral_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.collateral_address)));
    avelength_collateral_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.collateral_address)),h.collateral_address<>(typeof(h.collateral_address))'');
    populated_air_rights_indc_cnt := COUNT(GROUP,h.air_rights_indc <> (TYPEOF(h.air_rights_indc))'');
    populated_air_rights_indc_pcnt := AVE(GROUP,IF(h.air_rights_indc = (TYPEOF(h.air_rights_indc))'',0,100));
    maxlength_air_rights_indc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_rights_indc)));
    avelength_air_rights_indc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_rights_indc)),h.air_rights_indc<>(typeof(h.air_rights_indc))'');
    populated_subterranean_rights_indc_cnt := COUNT(GROUP,h.subterranean_rights_indc <> (TYPEOF(h.subterranean_rights_indc))'');
    populated_subterranean_rights_indc_pcnt := AVE(GROUP,IF(h.subterranean_rights_indc = (TYPEOF(h.subterranean_rights_indc))'',0,100));
    maxlength_subterranean_rights_indc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subterranean_rights_indc)));
    avelength_subterranean_rights_indc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subterranean_rights_indc)),h.subterranean_rights_indc<>(typeof(h.subterranean_rights_indc))'');
    populated_easment_indc_cnt := COUNT(GROUP,h.easment_indc <> (TYPEOF(h.easment_indc))'');
    populated_easment_indc_pcnt := AVE(GROUP,IF(h.easment_indc = (TYPEOF(h.easment_indc))'',0,100));
    maxlength_easment_indc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.easment_indc)));
    avelength_easment_indc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.easment_indc)),h.easment_indc<>(typeof(h.easment_indc))'');
    populated_volume_cnt := COUNT(GROUP,h.volume <> (TYPEOF(h.volume))'');
    populated_volume_pcnt := AVE(GROUP,IF(h.volume = (TYPEOF(h.volume))'',0,100));
    maxlength_volume := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.volume)));
    avelength_volume := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.volume)),h.volume<>(typeof(h.volume))'');
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_tmsid_pcnt *   0.00 / 100 + T.Populated_rmsid_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_static_value_pcnt *   0.00 / 100 + T.Populated_date_vendor_removed_pcnt *   0.00 / 100 + T.Populated_date_vendor_changed_pcnt *   0.00 / 100 + T.Populated_filing_jurisdiction_pcnt *   0.00 / 100 + T.Populated_orig_filing_number_pcnt *   0.00 / 100 + T.Populated_orig_filing_type_pcnt *   0.00 / 100 + T.Populated_orig_filing_date_pcnt *   0.00 / 100 + T.Populated_orig_filing_time_pcnt *   0.00 / 100 + T.Populated_filing_number_pcnt *   0.00 / 100 + T.Populated_filing_number_indc_pcnt *   0.00 / 100 + T.Populated_filing_type_pcnt *   0.00 / 100 + T.Populated_filing_date_pcnt *   0.00 / 100 + T.Populated_filing_time_pcnt *   0.00 / 100 + T.Populated_filing_status_pcnt *   0.00 / 100 + T.Populated_status_type_pcnt *   0.00 / 100 + T.Populated_page_pcnt *   0.00 / 100 + T.Populated_expiration_date_pcnt *   0.00 / 100 + T.Populated_contract_type_pcnt *   0.00 / 100 + T.Populated_vendor_entry_date_pcnt *   0.00 / 100 + T.Populated_vendor_upd_date_pcnt *   0.00 / 100 + T.Populated_statements_filed_pcnt *   0.00 / 100 + T.Populated_continuious_expiration_pcnt *   0.00 / 100 + T.Populated_microfilm_number_pcnt *   0.00 / 100 + T.Populated_amount_pcnt *   0.00 / 100 + T.Populated_irs_serial_number_pcnt *   0.00 / 100 + T.Populated_effective_date_pcnt *   0.00 / 100 + T.Populated_signer_name_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_filing_agency_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_duns_number_pcnt *   0.00 / 100 + T.Populated_cmnt_effective_date_pcnt *   0.00 / 100 + T.Populated_description_pcnt *   0.00 / 100 + T.Populated_collateral_desc_pcnt *   0.00 / 100 + T.Populated_prim_machine_pcnt *   0.00 / 100 + T.Populated_sec_machine_pcnt *   0.00 / 100 + T.Populated_manufacturer_code_pcnt *   0.00 / 100 + T.Populated_manufacturer_name_pcnt *   0.00 / 100 + T.Populated_model_pcnt *   0.00 / 100 + T.Populated_model_year_pcnt *   0.00 / 100 + T.Populated_model_desc_pcnt *   0.00 / 100 + T.Populated_collateral_count_pcnt *   0.00 / 100 + T.Populated_manufactured_year_pcnt *   0.00 / 100 + T.Populated_new_used_pcnt *   0.00 / 100 + T.Populated_serial_number_pcnt *   0.00 / 100 + T.Populated_property_desc_pcnt *   0.00 / 100 + T.Populated_borough_pcnt *   0.00 / 100 + T.Populated_block_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_collateral_address_pcnt *   0.00 / 100 + T.Populated_air_rights_indc_pcnt *   0.00 / 100 + T.Populated_subterranean_rights_indc_pcnt *   0.00 / 100 + T.Populated_easment_indc_pcnt *   0.00 / 100 + T.Populated_volume_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'tmsid','rmsid','process_date','static_value','date_vendor_removed','date_vendor_changed','filing_jurisdiction','orig_filing_number','orig_filing_type','orig_filing_date','orig_filing_time','filing_number','filing_number_indc','filing_type','filing_date','filing_time','filing_status','status_type','page','expiration_date','contract_type','vendor_entry_date','vendor_upd_date','statements_filed','continuious_expiration','microfilm_number','amount','irs_serial_number','effective_date','signer_name','title','filing_agency','address','city','state','county','zip','duns_number','cmnt_effective_date','description','collateral_desc','prim_machine','sec_machine','manufacturer_code','manufacturer_name','model','model_year','model_desc','collateral_count','manufactured_year','new_used','serial_number','property_desc','borough','block','lot','collateral_address','air_rights_indc','subterranean_rights_indc','easment_indc','volume','persistent_record_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_tmsid_pcnt,le.populated_rmsid_pcnt,le.populated_process_date_pcnt,le.populated_static_value_pcnt,le.populated_date_vendor_removed_pcnt,le.populated_date_vendor_changed_pcnt,le.populated_filing_jurisdiction_pcnt,le.populated_orig_filing_number_pcnt,le.populated_orig_filing_type_pcnt,le.populated_orig_filing_date_pcnt,le.populated_orig_filing_time_pcnt,le.populated_filing_number_pcnt,le.populated_filing_number_indc_pcnt,le.populated_filing_type_pcnt,le.populated_filing_date_pcnt,le.populated_filing_time_pcnt,le.populated_filing_status_pcnt,le.populated_status_type_pcnt,le.populated_page_pcnt,le.populated_expiration_date_pcnt,le.populated_contract_type_pcnt,le.populated_vendor_entry_date_pcnt,le.populated_vendor_upd_date_pcnt,le.populated_statements_filed_pcnt,le.populated_continuious_expiration_pcnt,le.populated_microfilm_number_pcnt,le.populated_amount_pcnt,le.populated_irs_serial_number_pcnt,le.populated_effective_date_pcnt,le.populated_signer_name_pcnt,le.populated_title_pcnt,le.populated_filing_agency_pcnt,le.populated_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_county_pcnt,le.populated_zip_pcnt,le.populated_duns_number_pcnt,le.populated_cmnt_effective_date_pcnt,le.populated_description_pcnt,le.populated_collateral_desc_pcnt,le.populated_prim_machine_pcnt,le.populated_sec_machine_pcnt,le.populated_manufacturer_code_pcnt,le.populated_manufacturer_name_pcnt,le.populated_model_pcnt,le.populated_model_year_pcnt,le.populated_model_desc_pcnt,le.populated_collateral_count_pcnt,le.populated_manufactured_year_pcnt,le.populated_new_used_pcnt,le.populated_serial_number_pcnt,le.populated_property_desc_pcnt,le.populated_borough_pcnt,le.populated_block_pcnt,le.populated_lot_pcnt,le.populated_collateral_address_pcnt,le.populated_air_rights_indc_pcnt,le.populated_subterranean_rights_indc_pcnt,le.populated_easment_indc_pcnt,le.populated_volume_pcnt,le.populated_persistent_record_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_tmsid,le.maxlength_rmsid,le.maxlength_process_date,le.maxlength_static_value,le.maxlength_date_vendor_removed,le.maxlength_date_vendor_changed,le.maxlength_filing_jurisdiction,le.maxlength_orig_filing_number,le.maxlength_orig_filing_type,le.maxlength_orig_filing_date,le.maxlength_orig_filing_time,le.maxlength_filing_number,le.maxlength_filing_number_indc,le.maxlength_filing_type,le.maxlength_filing_date,le.maxlength_filing_time,le.maxlength_filing_status,le.maxlength_status_type,le.maxlength_page,le.maxlength_expiration_date,le.maxlength_contract_type,le.maxlength_vendor_entry_date,le.maxlength_vendor_upd_date,le.maxlength_statements_filed,le.maxlength_continuious_expiration,le.maxlength_microfilm_number,le.maxlength_amount,le.maxlength_irs_serial_number,le.maxlength_effective_date,le.maxlength_signer_name,le.maxlength_title,le.maxlength_filing_agency,le.maxlength_address,le.maxlength_city,le.maxlength_state,le.maxlength_county,le.maxlength_zip,le.maxlength_duns_number,le.maxlength_cmnt_effective_date,le.maxlength_description,le.maxlength_collateral_desc,le.maxlength_prim_machine,le.maxlength_sec_machine,le.maxlength_manufacturer_code,le.maxlength_manufacturer_name,le.maxlength_model,le.maxlength_model_year,le.maxlength_model_desc,le.maxlength_collateral_count,le.maxlength_manufactured_year,le.maxlength_new_used,le.maxlength_serial_number,le.maxlength_property_desc,le.maxlength_borough,le.maxlength_block,le.maxlength_lot,le.maxlength_collateral_address,le.maxlength_air_rights_indc,le.maxlength_subterranean_rights_indc,le.maxlength_easment_indc,le.maxlength_volume,le.maxlength_persistent_record_id);
  SELF.avelength := CHOOSE(C,le.avelength_tmsid,le.avelength_rmsid,le.avelength_process_date,le.avelength_static_value,le.avelength_date_vendor_removed,le.avelength_date_vendor_changed,le.avelength_filing_jurisdiction,le.avelength_orig_filing_number,le.avelength_orig_filing_type,le.avelength_orig_filing_date,le.avelength_orig_filing_time,le.avelength_filing_number,le.avelength_filing_number_indc,le.avelength_filing_type,le.avelength_filing_date,le.avelength_filing_time,le.avelength_filing_status,le.avelength_status_type,le.avelength_page,le.avelength_expiration_date,le.avelength_contract_type,le.avelength_vendor_entry_date,le.avelength_vendor_upd_date,le.avelength_statements_filed,le.avelength_continuious_expiration,le.avelength_microfilm_number,le.avelength_amount,le.avelength_irs_serial_number,le.avelength_effective_date,le.avelength_signer_name,le.avelength_title,le.avelength_filing_agency,le.avelength_address,le.avelength_city,le.avelength_state,le.avelength_county,le.avelength_zip,le.avelength_duns_number,le.avelength_cmnt_effective_date,le.avelength_description,le.avelength_collateral_desc,le.avelength_prim_machine,le.avelength_sec_machine,le.avelength_manufacturer_code,le.avelength_manufacturer_name,le.avelength_model,le.avelength_model_year,le.avelength_model_desc,le.avelength_collateral_count,le.avelength_manufactured_year,le.avelength_new_used,le.avelength_serial_number,le.avelength_property_desc,le.avelength_borough,le.avelength_block,le.avelength_lot,le.avelength_collateral_address,le.avelength_air_rights_indc,le.avelength_subterranean_rights_indc,le.avelength_easment_indc,le.avelength_volume,le.avelength_persistent_record_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 62, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.tmsid),TRIM((SALT311.StrType)le.rmsid),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.static_value),TRIM((SALT311.StrType)le.date_vendor_removed),TRIM((SALT311.StrType)le.date_vendor_changed),TRIM((SALT311.StrType)le.filing_jurisdiction),TRIM((SALT311.StrType)le.orig_filing_number),TRIM((SALT311.StrType)le.orig_filing_type),TRIM((SALT311.StrType)le.orig_filing_date),TRIM((SALT311.StrType)le.orig_filing_time),TRIM((SALT311.StrType)le.filing_number),TRIM((SALT311.StrType)le.filing_number_indc),TRIM((SALT311.StrType)le.filing_type),TRIM((SALT311.StrType)le.filing_date),TRIM((SALT311.StrType)le.filing_time),TRIM((SALT311.StrType)le.filing_status),TRIM((SALT311.StrType)le.status_type),TRIM((SALT311.StrType)le.page),TRIM((SALT311.StrType)le.expiration_date),TRIM((SALT311.StrType)le.contract_type),TRIM((SALT311.StrType)le.vendor_entry_date),TRIM((SALT311.StrType)le.vendor_upd_date),TRIM((SALT311.StrType)le.statements_filed),TRIM((SALT311.StrType)le.continuious_expiration),TRIM((SALT311.StrType)le.microfilm_number),TRIM((SALT311.StrType)le.amount),TRIM((SALT311.StrType)le.irs_serial_number),TRIM((SALT311.StrType)le.effective_date),TRIM((SALT311.StrType)le.signer_name),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.filing_agency),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.duns_number),TRIM((SALT311.StrType)le.cmnt_effective_date),TRIM((SALT311.StrType)le.description),TRIM((SALT311.StrType)le.collateral_desc),TRIM((SALT311.StrType)le.prim_machine),TRIM((SALT311.StrType)le.sec_machine),TRIM((SALT311.StrType)le.manufacturer_code),TRIM((SALT311.StrType)le.manufacturer_name),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.model_year),TRIM((SALT311.StrType)le.model_desc),TRIM((SALT311.StrType)le.collateral_count),TRIM((SALT311.StrType)le.manufactured_year),TRIM((SALT311.StrType)le.new_used),TRIM((SALT311.StrType)le.serial_number),TRIM((SALT311.StrType)le.property_desc),TRIM((SALT311.StrType)le.borough),TRIM((SALT311.StrType)le.block),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.collateral_address),TRIM((SALT311.StrType)le.air_rights_indc),TRIM((SALT311.StrType)le.subterranean_rights_indc),TRIM((SALT311.StrType)le.easment_indc),TRIM((SALT311.StrType)le.volume),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,62,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 62);
  SELF.FldNo2 := 1 + (C % 62);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.tmsid),TRIM((SALT311.StrType)le.rmsid),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.static_value),TRIM((SALT311.StrType)le.date_vendor_removed),TRIM((SALT311.StrType)le.date_vendor_changed),TRIM((SALT311.StrType)le.filing_jurisdiction),TRIM((SALT311.StrType)le.orig_filing_number),TRIM((SALT311.StrType)le.orig_filing_type),TRIM((SALT311.StrType)le.orig_filing_date),TRIM((SALT311.StrType)le.orig_filing_time),TRIM((SALT311.StrType)le.filing_number),TRIM((SALT311.StrType)le.filing_number_indc),TRIM((SALT311.StrType)le.filing_type),TRIM((SALT311.StrType)le.filing_date),TRIM((SALT311.StrType)le.filing_time),TRIM((SALT311.StrType)le.filing_status),TRIM((SALT311.StrType)le.status_type),TRIM((SALT311.StrType)le.page),TRIM((SALT311.StrType)le.expiration_date),TRIM((SALT311.StrType)le.contract_type),TRIM((SALT311.StrType)le.vendor_entry_date),TRIM((SALT311.StrType)le.vendor_upd_date),TRIM((SALT311.StrType)le.statements_filed),TRIM((SALT311.StrType)le.continuious_expiration),TRIM((SALT311.StrType)le.microfilm_number),TRIM((SALT311.StrType)le.amount),TRIM((SALT311.StrType)le.irs_serial_number),TRIM((SALT311.StrType)le.effective_date),TRIM((SALT311.StrType)le.signer_name),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.filing_agency),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.duns_number),TRIM((SALT311.StrType)le.cmnt_effective_date),TRIM((SALT311.StrType)le.description),TRIM((SALT311.StrType)le.collateral_desc),TRIM((SALT311.StrType)le.prim_machine),TRIM((SALT311.StrType)le.sec_machine),TRIM((SALT311.StrType)le.manufacturer_code),TRIM((SALT311.StrType)le.manufacturer_name),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.model_year),TRIM((SALT311.StrType)le.model_desc),TRIM((SALT311.StrType)le.collateral_count),TRIM((SALT311.StrType)le.manufactured_year),TRIM((SALT311.StrType)le.new_used),TRIM((SALT311.StrType)le.serial_number),TRIM((SALT311.StrType)le.property_desc),TRIM((SALT311.StrType)le.borough),TRIM((SALT311.StrType)le.block),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.collateral_address),TRIM((SALT311.StrType)le.air_rights_indc),TRIM((SALT311.StrType)le.subterranean_rights_indc),TRIM((SALT311.StrType)le.easment_indc),TRIM((SALT311.StrType)le.volume),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.tmsid),TRIM((SALT311.StrType)le.rmsid),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.static_value),TRIM((SALT311.StrType)le.date_vendor_removed),TRIM((SALT311.StrType)le.date_vendor_changed),TRIM((SALT311.StrType)le.filing_jurisdiction),TRIM((SALT311.StrType)le.orig_filing_number),TRIM((SALT311.StrType)le.orig_filing_type),TRIM((SALT311.StrType)le.orig_filing_date),TRIM((SALT311.StrType)le.orig_filing_time),TRIM((SALT311.StrType)le.filing_number),TRIM((SALT311.StrType)le.filing_number_indc),TRIM((SALT311.StrType)le.filing_type),TRIM((SALT311.StrType)le.filing_date),TRIM((SALT311.StrType)le.filing_time),TRIM((SALT311.StrType)le.filing_status),TRIM((SALT311.StrType)le.status_type),TRIM((SALT311.StrType)le.page),TRIM((SALT311.StrType)le.expiration_date),TRIM((SALT311.StrType)le.contract_type),TRIM((SALT311.StrType)le.vendor_entry_date),TRIM((SALT311.StrType)le.vendor_upd_date),TRIM((SALT311.StrType)le.statements_filed),TRIM((SALT311.StrType)le.continuious_expiration),TRIM((SALT311.StrType)le.microfilm_number),TRIM((SALT311.StrType)le.amount),TRIM((SALT311.StrType)le.irs_serial_number),TRIM((SALT311.StrType)le.effective_date),TRIM((SALT311.StrType)le.signer_name),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.filing_agency),TRIM((SALT311.StrType)le.address),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.duns_number),TRIM((SALT311.StrType)le.cmnt_effective_date),TRIM((SALT311.StrType)le.description),TRIM((SALT311.StrType)le.collateral_desc),TRIM((SALT311.StrType)le.prim_machine),TRIM((SALT311.StrType)le.sec_machine),TRIM((SALT311.StrType)le.manufacturer_code),TRIM((SALT311.StrType)le.manufacturer_name),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.model_year),TRIM((SALT311.StrType)le.model_desc),TRIM((SALT311.StrType)le.collateral_count),TRIM((SALT311.StrType)le.manufactured_year),TRIM((SALT311.StrType)le.new_used),TRIM((SALT311.StrType)le.serial_number),TRIM((SALT311.StrType)le.property_desc),TRIM((SALT311.StrType)le.borough),TRIM((SALT311.StrType)le.block),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.collateral_address),TRIM((SALT311.StrType)le.air_rights_indc),TRIM((SALT311.StrType)le.subterranean_rights_indc),TRIM((SALT311.StrType)le.easment_indc),TRIM((SALT311.StrType)le.volume),IF (le.persistent_record_id <> 0,TRIM((SALT311.StrType)le.persistent_record_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),62*62,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'tmsid'}
      ,{2,'rmsid'}
      ,{3,'process_date'}
      ,{4,'static_value'}
      ,{5,'date_vendor_removed'}
      ,{6,'date_vendor_changed'}
      ,{7,'filing_jurisdiction'}
      ,{8,'orig_filing_number'}
      ,{9,'orig_filing_type'}
      ,{10,'orig_filing_date'}
      ,{11,'orig_filing_time'}
      ,{12,'filing_number'}
      ,{13,'filing_number_indc'}
      ,{14,'filing_type'}
      ,{15,'filing_date'}
      ,{16,'filing_time'}
      ,{17,'filing_status'}
      ,{18,'status_type'}
      ,{19,'page'}
      ,{20,'expiration_date'}
      ,{21,'contract_type'}
      ,{22,'vendor_entry_date'}
      ,{23,'vendor_upd_date'}
      ,{24,'statements_filed'}
      ,{25,'continuious_expiration'}
      ,{26,'microfilm_number'}
      ,{27,'amount'}
      ,{28,'irs_serial_number'}
      ,{29,'effective_date'}
      ,{30,'signer_name'}
      ,{31,'title'}
      ,{32,'filing_agency'}
      ,{33,'address'}
      ,{34,'city'}
      ,{35,'state'}
      ,{36,'county'}
      ,{37,'zip'}
      ,{38,'duns_number'}
      ,{39,'cmnt_effective_date'}
      ,{40,'description'}
      ,{41,'collateral_desc'}
      ,{42,'prim_machine'}
      ,{43,'sec_machine'}
      ,{44,'manufacturer_code'}
      ,{45,'manufacturer_name'}
      ,{46,'model'}
      ,{47,'model_year'}
      ,{48,'model_desc'}
      ,{49,'collateral_count'}
      ,{50,'manufactured_year'}
      ,{51,'new_used'}
      ,{52,'serial_number'}
      ,{53,'property_desc'}
      ,{54,'borough'}
      ,{55,'block'}
      ,{56,'lot'}
      ,{57,'collateral_address'}
      ,{58,'air_rights_indc'}
      ,{59,'subterranean_rights_indc'}
      ,{60,'easment_indc'}
      ,{61,'volume'}
      ,{62,'persistent_record_id'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    IL_Main_Fields.InValid_tmsid((SALT311.StrType)le.tmsid),
    IL_Main_Fields.InValid_rmsid((SALT311.StrType)le.rmsid),
    IL_Main_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    IL_Main_Fields.InValid_static_value((SALT311.StrType)le.static_value),
    IL_Main_Fields.InValid_date_vendor_removed((SALT311.StrType)le.date_vendor_removed),
    IL_Main_Fields.InValid_date_vendor_changed((SALT311.StrType)le.date_vendor_changed),
    IL_Main_Fields.InValid_filing_jurisdiction((SALT311.StrType)le.filing_jurisdiction),
    IL_Main_Fields.InValid_orig_filing_number((SALT311.StrType)le.orig_filing_number),
    IL_Main_Fields.InValid_orig_filing_type((SALT311.StrType)le.orig_filing_type),
    IL_Main_Fields.InValid_orig_filing_date((SALT311.StrType)le.orig_filing_date),
    IL_Main_Fields.InValid_orig_filing_time((SALT311.StrType)le.orig_filing_time),
    IL_Main_Fields.InValid_filing_number((SALT311.StrType)le.filing_number),
    IL_Main_Fields.InValid_filing_number_indc((SALT311.StrType)le.filing_number_indc),
    IL_Main_Fields.InValid_filing_type((SALT311.StrType)le.filing_type),
    IL_Main_Fields.InValid_filing_date((SALT311.StrType)le.filing_date),
    IL_Main_Fields.InValid_filing_time((SALT311.StrType)le.filing_time),
    IL_Main_Fields.InValid_filing_status((SALT311.StrType)le.filing_status),
    IL_Main_Fields.InValid_status_type((SALT311.StrType)le.status_type),
    IL_Main_Fields.InValid_page((SALT311.StrType)le.page),
    IL_Main_Fields.InValid_expiration_date((SALT311.StrType)le.expiration_date),
    IL_Main_Fields.InValid_contract_type((SALT311.StrType)le.contract_type),
    IL_Main_Fields.InValid_vendor_entry_date((SALT311.StrType)le.vendor_entry_date),
    IL_Main_Fields.InValid_vendor_upd_date((SALT311.StrType)le.vendor_upd_date),
    IL_Main_Fields.InValid_statements_filed((SALT311.StrType)le.statements_filed),
    IL_Main_Fields.InValid_continuious_expiration((SALT311.StrType)le.continuious_expiration),
    IL_Main_Fields.InValid_microfilm_number((SALT311.StrType)le.microfilm_number),
    IL_Main_Fields.InValid_amount((SALT311.StrType)le.amount),
    IL_Main_Fields.InValid_irs_serial_number((SALT311.StrType)le.irs_serial_number),
    IL_Main_Fields.InValid_effective_date((SALT311.StrType)le.effective_date),
    IL_Main_Fields.InValid_signer_name((SALT311.StrType)le.signer_name),
    IL_Main_Fields.InValid_title((SALT311.StrType)le.title),
    IL_Main_Fields.InValid_filing_agency((SALT311.StrType)le.filing_agency),
    IL_Main_Fields.InValid_address((SALT311.StrType)le.address),
    IL_Main_Fields.InValid_city((SALT311.StrType)le.city),
    IL_Main_Fields.InValid_state((SALT311.StrType)le.state),
    IL_Main_Fields.InValid_county((SALT311.StrType)le.county),
    IL_Main_Fields.InValid_zip((SALT311.StrType)le.zip),
    IL_Main_Fields.InValid_duns_number((SALT311.StrType)le.duns_number),
    IL_Main_Fields.InValid_cmnt_effective_date((SALT311.StrType)le.cmnt_effective_date),
    IL_Main_Fields.InValid_description((SALT311.StrType)le.description),
    IL_Main_Fields.InValid_collateral_desc((SALT311.StrType)le.collateral_desc),
    IL_Main_Fields.InValid_prim_machine((SALT311.StrType)le.prim_machine),
    IL_Main_Fields.InValid_sec_machine((SALT311.StrType)le.sec_machine),
    IL_Main_Fields.InValid_manufacturer_code((SALT311.StrType)le.manufacturer_code),
    IL_Main_Fields.InValid_manufacturer_name((SALT311.StrType)le.manufacturer_name),
    IL_Main_Fields.InValid_model((SALT311.StrType)le.model),
    IL_Main_Fields.InValid_model_year((SALT311.StrType)le.model_year),
    IL_Main_Fields.InValid_model_desc((SALT311.StrType)le.model_desc),
    IL_Main_Fields.InValid_collateral_count((SALT311.StrType)le.collateral_count),
    IL_Main_Fields.InValid_manufactured_year((SALT311.StrType)le.manufactured_year),
    IL_Main_Fields.InValid_new_used((SALT311.StrType)le.new_used),
    IL_Main_Fields.InValid_serial_number((SALT311.StrType)le.serial_number),
    IL_Main_Fields.InValid_property_desc((SALT311.StrType)le.property_desc),
    IL_Main_Fields.InValid_borough((SALT311.StrType)le.borough),
    IL_Main_Fields.InValid_block((SALT311.StrType)le.block),
    IL_Main_Fields.InValid_lot((SALT311.StrType)le.lot),
    IL_Main_Fields.InValid_collateral_address((SALT311.StrType)le.collateral_address),
    IL_Main_Fields.InValid_air_rights_indc((SALT311.StrType)le.air_rights_indc),
    IL_Main_Fields.InValid_subterranean_rights_indc((SALT311.StrType)le.subterranean_rights_indc),
    IL_Main_Fields.InValid_easment_indc((SALT311.StrType)le.easment_indc),
    IL_Main_Fields.InValid_volume((SALT311.StrType)le.volume),
    IL_Main_Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,62,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := IL_Main_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_tmsid','invalid_rmsid','invalid_8pastdate','Unknown','Unknown','Unknown','invalid_filing_jurisdiction','invalid_orig_filing_number','invalid_orig_filing_type','invalid_orig_filing_date','invalid_orig_filing_time','invalid_filing_number','Unknown','invalid_filing_type','invalid_filing_date','invalid_filing_time','invalid_empty','invalid_empty','invalid_numeric_blank','invalid_expiration_date','invalid_empty','invalid_empty','invalid_empty','invalid_numeric_blank','invalid_boolean_yn_blank','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','Unknown','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','Unknown','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,IL_Main_Fields.InValidMessage_tmsid(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_rmsid(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_static_value(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_date_vendor_removed(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_date_vendor_changed(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_filing_jurisdiction(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_orig_filing_number(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_orig_filing_type(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_orig_filing_date(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_orig_filing_time(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_filing_number(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_filing_number_indc(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_filing_type(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_filing_date(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_filing_time(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_filing_status(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_status_type(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_page(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_expiration_date(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_contract_type(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_vendor_entry_date(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_vendor_upd_date(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_statements_filed(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_continuious_expiration(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_microfilm_number(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_amount(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_irs_serial_number(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_effective_date(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_signer_name(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_title(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_filing_agency(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_address(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_city(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_state(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_county(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_zip(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_duns_number(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_cmnt_effective_date(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_description(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_collateral_desc(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_prim_machine(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_sec_machine(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_manufacturer_code(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_manufacturer_name(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_model(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_model_year(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_model_desc(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_collateral_count(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_manufactured_year(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_new_used(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_serial_number(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_property_desc(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_borough(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_block(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_lot(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_collateral_address(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_air_rights_indc(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_subterranean_rights_indc(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_easment_indc(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_volume(TotalErrors.ErrorNum),IL_Main_Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_UCCV2, IL_Main_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
