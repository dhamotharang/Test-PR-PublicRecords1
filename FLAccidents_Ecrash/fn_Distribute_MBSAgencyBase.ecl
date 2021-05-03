EXPORT fn_Distribute_MBSAgencyBase(STRING ProductName,
                                   DATASET(Layout_MBSAgency.agency) pMBSAgencyBase = Files_MBSAgency.DS_BASE_AGENCY) := FUNCTION

  DS_BASE := pMBSAgencyBase;

  OrbitWorkunitProfileName := OrbitConstants(ProductName).ProfileWorkunitName;

	tbl_DS_BASE := TABLE(DS_BASE,
		{DS_BASE
    ,populated_agency_id := IF(LENGTH(TRIM(agency_id)) > 0,'Y','N')
    ,populated_agency_name := IF(LENGTH(TRIM(agency_name)) > 0,'Y','N')
    ,populated_agency_state_abbr := IF(LENGTH(TRIM(agency_state_abbr)) > 0,'Y','N')
    ,populated_agency_ori := IF(LENGTH(TRIM(agency_ori)) > 0,'Y','N')
    ,populated_allow_open_search := IF(LENGTH(TRIM(allow_open_search)) > 0,'Y','N')
    ,populated_append_overwrite_flag := IF(LENGTH(TRIM(append_overwrite_flag)) > 0,'Y','N')
    ,populated_drivers_exchange_flag := IF(LENGTH(TRIM(drivers_exchange_flag)) > 0,'Y','N')
    ,populated_source_id := IF(LENGTH(TRIM(source_id)) > 0,'Y','N')
    ,populated_orig_source_start_date := IF(LENGTH(TRIM(orig_source_start_date)) > 0,'Y','N')
    ,populated_source_start_date := IF(source_start_date > 0,'Y','N')
    ,populated_orig_source_end_date := IF(LENGTH(TRIM(orig_source_end_date)) > 0,'Y','N')
    ,populated_source_end_date := IF(source_end_date > 0,'Y','N')
    ,populated_orig_source_termination_date :=  IF(LENGTH(TRIM(orig_source_termination_date)) > 0,'Y','N')
    ,populated_source_termination_date := IF(source_termination_date > 0,'Y','N')
    ,populated_source_resale_allowed := IF(LENGTH(TRIM(source_resale_allowed)) > 0,'Y','N')
    ,populated_source_auto_renew := IF(LENGTH(TRIM(source_auto_renew)) > 0,'Y','N')
    ,populated_source_allow_sale_of_component_data := IF(LENGTH(TRIM(source_allow_sale_of_component_data)) > 0,'Y','N')
    ,populated_source_allow_extract_of_vehicle_data := IF(LENGTH(TRIM(source_allow_extract_of_vehicle_data)) > 0,'Y','N')
	});

	DistBase := DISTRIBUTION(tbl_DS_BASE
		// ALL VALUE DISTRIBUTIONS
    ,agency_state_abbr
    ,append_overwrite_flag
    ,drivers_exchange_flag
    ,source_id
		
		// POPULATED Y/N DISTRIBUTIONS
    ,populated_agency_id
    ,populated_agency_name
    ,populated_agency_state_abbr
    ,populated_agency_ori
    ,populated_allow_open_search
    ,populated_append_overwrite_flag
    ,populated_drivers_exchange_flag
    ,populated_source_id
    ,populated_orig_source_start_date
    ,populated_source_start_date
    ,populated_orig_source_end_date
    ,populated_source_end_date
		,populated_orig_source_termination_date
    ,populated_source_termination_date
    ,populated_source_resale_allowed
    ,populated_source_auto_renew
    ,populated_source_allow_sale_of_component_data
    ,populated_source_allow_extract_of_vehicle_data
	,NAMED(OrbitWorkunitProfileName));

  RETURN DistBase;

END;