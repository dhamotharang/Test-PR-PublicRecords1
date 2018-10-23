// -----------------------------------------------------------------------------------------------------------
// DESCRIPTION: Derive data from utility records for the provided DIDs. 
// -----------------------------------------------------------------------------------------------------------
IMPORT Census_data, doxie, doxie_crs, iesp, suppress, utilfile, ut; 

EXPORT Util_records (DATASET(doxie.layout_references) ds_dids_in,
                     STRING6 ssn_mask_value, 
                     BOOLEAN dl_mask_value, 
                     UNSIGNED1 GLB_Purpose, 
                     STRING5 industry_class_val) := FUNCTION 

  util_DID_key := Utilfile.Key_DID;
	util_crs_layout := doxie_crs.layout_utility.record_layout;
	util_crs_address_layout := doxie_crs.layout_utility.address_layout;
	util_crs_layout_return := doxie_crs.layout_utility.record_layout_slim;
	
  sorted_dids := SORT(ds_dids_in, did);
  unique_dids := DEDUP(sorted_dids, did); 

  //----------------------------------------------------------------------------------------------------------
  // Get the raw utility records based upon the given DIDs.
  //----------------------------------------------------------------------------------------------------------
	utils_by_did := JOIN(unique_dids, 
                       util_DID_key,
                       KEYED(LEFT.did = RIGHT.s_did),
                       TRANSFORM(RIGHT),
                       LIMIT(ut.limits.DEFAULT, SKIP));

  //----------------------------------------------------------------------------------------------------------
  // Build the address record that will be aggregated with other addresses and placed within the returned 
  // utility record
  //----------------------------------------------------------------------------------------------------------
  util_crs_address_layout set_Address(RECORDOF(util_DID_key) L, STRING18 county_name) := TRANSFORM

    SELF.city            := L.p_city_name;
    SELF.state           := L.st;
    SELF.county_name     := county_name;
    SELF := L;

  END;
  
  //----------------------------------------------------------------------------------------------------------
  // First pass is to build a dataset of records with the data we need and, most importantly, placing the
  // address information from the utility record into the record layout we will aggregate later with
  // "similar" related utility records.
  //----------------------------------------------------------------------------------------------------------
  string1 BILLING_VALUE := 'B';
  string1 SERVICE_VALUE := 'S';
  string1 BOTH_VALUE := 'M';
  
  util_crs_layout transform_Address_Type(RECORDOF(util_DID_key) L) := TRANSFORM

    //--------------------------------------------------------------------------------------------------------
    // NOTE: If addr_dual=M (match for both), it implies that the Billing and Service addresses both 
    // exist are identical.
    //--------------------------------------------------------------------------------------------------------
    is_Service_Address := (L.addr_type = SERVICE_VALUE) OR (L.addr_dual = BOTH_VALUE);
    is_Billing_Address := (L.addr_type = BILLING_VALUE) OR (L.addr_dual = BOTH_VALUE);

    county_name := Census_data.Key_Fips2County(KEYED(L.st = state_code AND L.county[3..5] = county_fips))[1].county_name;

    SELF.id                              := L.id;
    SELF.exchange_serial_number          := L.exchange_serial_number;
    SELF.util_type                       := L.util_type;
    
    SELF.util_category                   := MAP( ((L.util_type='1') OR (L.util_type='C') OR (L.util_type='E') OR
                                                  (L.util_type='G') OR (L.util_type='O') OR (L.util_type='P') OR
                                                  (L.util_type='W')
                                                 ) => 'INFRASTRUCTURE',
                                                 ((L.util_type='2') OR (L.util_type='A') OR (L.util_type='D') OR
                                                  (L.util_type='D') OR (L.util_type='F') OR (L.util_type='H') OR
                                                  (L.util_type='I') OR (L.util_type='L') OR (L.util_type='N') OR
                                                  (L.util_type='S') OR (L.util_type='U') OR (L.util_type='V') OR
                                                  (L.util_type='X')
                                                 ) => 'CONVENIENCE',
                                                 ((L.util_type='3') OR (L.util_type='Z')) => 'MISCELLANEOUS', 
                                                 '');
                                                 
    SELF.util_type_description           := MAP( (L.util_type='A') => 'PAGING', 
                                                 (L.util_type='C') => 'COAL', 
                                                 (L.util_type='D') => 'LONG DISTANCE PHONE', 
                                                 (L.util_type='E') => 'ELECTRIC', 
                                                 (L.util_type='F') => 'LOCAL PHONE', 
                                                 (L.util_type='G') => 'GAS', 
                                                 (L.util_type='H') => 'PCS', 
                                                 (L.util_type='I') => 'CELLULAR PHONE', 
                                                 (L.util_type='L') => 'LINE LEASING', 
                                                 (L.util_type='N') => 'INTERNET', 
                                                 (L.util_type='O') => 'OIL', 
                                                 (L.util_type='P') => 'PROPANE GAS', 
                                                 (L.util_type='S') => 'SATELLITE', 
                                                 (L.util_type='U') => 'PAID TV', 
                                                 (L.util_type='V') => 'CABLE EQUIPMENT', 
                                                 (L.util_type='W') => 'WATER', 
                                                 (L.util_type='Z') => 'OTHER', 
                                                 '');
    
    SELF.connect_date                    := L.connect_date;
    SELF.date_first_seen                 := L.date_first_seen;
    SELF.record_date                     := L.record_date;
    SELF.title                           := L.title;
    SELF.fname                           := L.fname;
    SELF.mname                           := L.mname;
    SELF.lname                           := L.lname;
    SELF.name_suffix                     := L.name_suffix;
    SELF.ssn                             := L.ssn;
    SELF.dob                             := L.dob;
    SELF.drivers_license_state_code      := L.drivers_license_state_code;
    SELF.drivers_license                 := L.drivers_license;
    SELF.is_service_addr_set             := is_Service_Address;
    SELF.is_billing_addr_set             := is_Billing_Address;
    
    //--------------------------------------------------------------------------------------------------------
    // Add the address information to the results target address subset.
    //--------------------------------------------------------------------------------------------------------
    SELF.address_recs                    := PROJECT(L, set_Address(L, county_name));

    SELF := L;
    SELF := []; // to null out any unassigned fields
  END;

  crs_utils := PROJECT(utils_by_did, transform_Address_Type(LEFT));

  sorted_crs_utils := SORT(crs_utils, exchange_serial_number, util_type, IF(is_service_addr_set, 0, 1), IF(is_billing_addr_set, 0, 1), -record_date);

  //----------------------------------------------------------------------------------------------------------
  // Combine matching Billing and Service records - This is the case for when there is a matching billing 
  // B record and a corresponding service S record.
  //----------------------------------------------------------------------------------------------------------
  sorted_crs_utils_grp := GROUP(sorted_crs_utils, exchange_serial_number, util_type);

  util_crs_layout_return combine_Billing_and_Service_Utils (util_crs_layout L, DATASET(util_crs_layout) R) := TRANSFORM

    //--------------------------------------------------------------------------------------------------------
    // Combine the addresses subsets together to create the full complliment of both the Billing and the 
    // Service addresses in this one record.
    //--------------------------------------------------------------------------------------------------------
    SELF.address_recs                    := CHOOSEN(DEDUP(SORT(R.address_recs, addr_type, prim_name, prim_range, addr_suffix, sec_range, city, state, zip),
                                                    addr_type, prim_name, prim_range, addr_suffix, sec_range, city, state, zip),
                                                    iesp.Constants.BR.MaxUtilAddresses);
    SELF := L;

  END;

  //----------------------------------------------------------------------------------------------------------
  // Combine Billing with Service entries, based on the exchange serial nummber and ID (The ID indentifies 
  // the data LexisNexis processing job). 
  //----------------------------------------------------------------------------------------------------------
  combined_crs_utils := ROLLUP(sorted_crs_utils_grp, 
                               GROUP,
                               combine_Billing_and_Service_Utils(LEFT, ROWS(LEFT)));

  crs_util_sorted := SORT(combined_crs_utils, -record_date);
  
  //----------------------------------------------------------------------------------------------------------
  // Project the resultant data into a layout to be used by the caller.
  //----------------------------------------------------------------------------------------------------------
  util_crs_layout_return util_crs_slim_and_mask(util_crs_layout_return L) := TRANSFORM
  
    SELF.ssn                := Suppress.ssn_mask(L.ssn, ssn_mask_value);
    SELF.drivers_license    := IF (dl_mask_value, Suppress.dl_mask(L.drivers_license), L.drivers_license);

    SELF := L;
    
  END;

  return_Data := PROJECT(crs_util_sorted, util_crs_slim_and_mask(LEFT));
   
  //----------------------------------------------------------------------------------------------------------
  // Determine the GLB permission requested in addition to the GLB level of the caller.
  //----------------------------------------------------------------------------------------------------------
  glb_ok := ut.PermissionTools.glb.ok(GLB_Purpose);
  
  //----------------------------------------------------------------------------------------------------------
  // DEBUG
  //----------------------------------------------------------------------------------------------------------
  // OUTPUT (glb_ok, NAMED('glb_ok'));
  // OUTPUT (industry_class_val, NAMED('industry_class_val'));
  // doxie.MAC_Selection_Declare();
  // OUTPUT (Include_Them_All, NAMED('Include_Them_All'));
  // OUTPUT (Include_Utility, NAMED('Include_Utility'));
  // OUTPUT (unique_dids, NAMED('unique_dids'));
  // OUTPUT (utils_by_did, NAMED('utils_by_did'));
  // OUTPUT (crs_utils, NAMED('crs_utils')); 
  // OUTPUT (sorted_crs_utils, NAMED('sorted_crs_utils')); 
  // OUTPUT (combined_crs_utils, NAMED('combined_crs_utils'));
  // OUTPUT (crs_util_sorted, NAMED('crs_util_sorted')); 
  // OUTPUT (return_Data, NAMED('return_Data'));

  RETURN IF(industry_class_val <> 'UTILI' AND glb_ok, return_Data);

END;