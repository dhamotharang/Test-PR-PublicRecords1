// -----------------------------------------------------------------------------------------------------------
// DESCRIPTION: Derive data from utility records for the provided DIDs. 
// -----------------------------------------------------------------------------------------------------------
IMPORT doxie, doxie_crs, utilfile, ut, Census_data, suppress; 

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

    //--------------------------------------------------------------------------------------------------------
    // Get a flattened verion of the service address information to dedup later on.
    //--------------------------------------------------------------------------------------------------------
    SELF.service_addr_type       := IF (is_Service_Address, L.addr_type, '');
    SELF.service_prim_range      := IF (is_Service_Address, L.prim_range, '');
    SELF.service_predir          := IF (is_Service_Address, L.predir, '');
    SELF.service_prim_name       := IF (is_Service_Address, L.prim_name, '');
    SELF.service_addr_suffix     := IF (is_Service_Address, L.addr_suffix, '');
    SELF.service_postdir         := IF (is_Service_Address, L.postdir, '');
    SELF.service_unit_desig      := IF (is_Service_Address, L.unit_desig, '');
    SELF.service_sec_range       := IF (is_Service_Address, L.sec_range, '');
    SELF.service_city            := IF (is_Service_Address, L.p_city_name, '');
    SELF.service_state           := IF (is_Service_Address, L.st, '');
    SELF.service_zip             := IF (is_Service_Address, L.zip, '');
    SELF.service_zip4            := IF (is_Service_Address, L.zip4, '');
    SELF.service_county_name     := IF (is_Service_Address, county_name, '');

    //--------------------------------------------------------------------------------------------------------
    // Get a flattened verion of the billing address information to dedup later on.
    //--------------------------------------------------------------------------------------------------------
    SELF.billing_addr_type       := IF (is_Billing_Address, L.addr_type, '');
    SELF.billing_prim_range      := IF (is_Billing_Address, L.prim_range, '');
    SELF.billing_predir          := IF (is_Billing_Address, L.predir, '');
    SELF.billing_prim_name       := IF (is_Billing_Address, L.prim_name, '');
    SELF.billing_addr_suffix     := IF (is_Billing_Address, L.addr_suffix, '');
    SELF.billing_postdir         := IF (is_Billing_Address, L.postdir, '');
    SELF.billing_unit_desig      := IF (is_Billing_Address, L.unit_desig, '');
    SELF.billing_sec_range       := IF (is_Billing_Address, L.sec_range, '');
    SELF.billing_city            := IF (is_Billing_Address, L.p_city_name, '');
    SELF.billing_state           := IF (is_Billing_Address, L.st, '');
    SELF.billing_zip             := IF (is_Billing_Address, L.zip, '');
    SELF.billing_zip4            := IF (is_Billing_Address, L.zip4, '');
    SELF.billing_county_name     := IF (is_Billing_Address, county_name, '');

    SELF := L;
    SELF := []; // to null out any unassigned fields

  END;

  crs_utils := PROJECT(utils_by_did, transform_Address_Type(LEFT));

  sorted_crs_utils := SORT(crs_utils, exchange_serial_number, -record_date);

  //----------------------------------------------------------------------------------------------------------
  // Combine matching Billing and Service records - This is the case for when there is a matching billing 
  // B record and a corresponding service S record.
  //----------------------------------------------------------------------------------------------------------
  util_crs_layout combine_Billing_and_Service_Utils (util_crs_layout L, util_crs_layout R) := TRANSFORM

    SELF.is_service_addr_set := L.is_service_addr_set OR R.is_service_addr_set;
    SELF.is_billing_addr_set := L.is_billing_addr_set OR R.is_billing_addr_set;

    //--------------------------------------------------------------------------------------------------------
    // Combine the addresses subsets together to create the full complliment of botht the Billing and the 
    // Service addresses in this one record.
    //--------------------------------------------------------------------------------------------------------
    SELF.address_recs                    := L.address_recs + R.address_recs;
    
    //--------------------------------------------------------------------------------------------------------
    // Propagate the flattened service address values over for deduping later on.
    //--------------------------------------------------------------------------------------------------------
    SELF.service_addr_type       := IF (L.is_service_addr_set, L.service_addr_type, IF (R.is_service_addr_set, R.service_addr_type, ''));
    SELF.service_prim_range      := IF (L.is_service_addr_set, L.service_prim_range, IF (R.is_service_addr_set, R.service_prim_range, ''));
    SELF.service_predir          := IF (L.is_service_addr_set, L.service_predir, IF (R.is_service_addr_set, R.service_predir, ''));
    SELF.service_prim_name       := IF (L.is_service_addr_set, L.service_prim_name, IF (R.is_service_addr_set, R.service_prim_name, ''));
    SELF.service_addr_suffix     := IF (L.is_service_addr_set, L.service_addr_suffix, IF (R.is_service_addr_set, R.service_addr_suffix, ''));
    SELF.service_postdir         := IF (L.is_service_addr_set, L.service_postdir, IF (R.is_service_addr_set, R.service_postdir, ''));
    SELF.service_unit_desig      := IF (L.is_service_addr_set, L.service_unit_desig, IF (R.is_service_addr_set, R.service_unit_desig, ''));
    SELF.service_sec_range       := IF (L.is_service_addr_set, L.service_sec_range, IF (R.is_service_addr_set, R.service_sec_range, ''));
    SELF.service_city            := IF (L.is_service_addr_set, L.service_city, IF (R.is_service_addr_set, R.service_city, ''));
    SELF.service_state           := IF (L.is_service_addr_set, L.service_state, IF (R.is_service_addr_set, R.service_state, ''));
    SELF.service_zip             := IF (L.is_service_addr_set, L.service_zip, IF (R.is_service_addr_set, R.service_zip, ''));
    SELF.service_zip4            := IF (L.is_service_addr_set, L.service_zip4, IF (R.is_service_addr_set, R.service_zip4, ''));
    SELF.service_county_name     := IF (L.is_service_addr_set, L.service_county_name, IF (R.is_service_addr_set, R.service_county_name, ''));

    //--------------------------------------------------------------------------------------------------------
    // Propagate the flattened billing address values over for deduping later on.
    //--------------------------------------------------------------------------------------------------------
    SELF.billing_addr_type       := IF (L.is_billing_addr_set, L.billing_addr_type, IF (R.is_billing_addr_set, R.billing_addr_type, ''));
    SELF.billing_prim_range      := IF (L.is_billing_addr_set, L.billing_prim_range, IF (R.is_billing_addr_set, R.billing_prim_range, ''));
    SELF.billing_predir          := IF (L.is_billing_addr_set, L.billing_predir, IF (R.is_billing_addr_set, R.billing_predir, ''));
    SELF.billing_prim_name       := IF (L.is_billing_addr_set, L.billing_prim_name, IF (R.is_billing_addr_set, R.billing_prim_name, ''));
    SELF.billing_addr_suffix     := IF (L.is_billing_addr_set, L.billing_addr_suffix, IF (R.is_billing_addr_set, R.billing_addr_suffix, ''));
    SELF.billing_postdir         := IF (L.is_billing_addr_set, L.billing_postdir, IF (R.is_billing_addr_set, R.billing_postdir, ''));
    SELF.billing_unit_desig      := IF (L.is_billing_addr_set, L.billing_unit_desig, IF (R.is_billing_addr_set, R.billing_unit_desig, ''));
    SELF.billing_sec_range       := IF (L.is_billing_addr_set, L.billing_sec_range, IF (R.is_billing_addr_set, R.billing_sec_range, ''));
    SELF.billing_city            := IF (L.is_billing_addr_set, L.billing_city, IF (R.is_billing_addr_set, R.billing_city, ''));
    SELF.billing_state           := IF (L.is_billing_addr_set, L.billing_state, IF (R.is_billing_addr_set, R.billing_state, ''));
    SELF.billing_zip             := IF (L.is_billing_addr_set, L.billing_zip, IF (R.is_billing_addr_set, R.billing_zip, ''));
    SELF.billing_zip4            := IF (L.is_billing_addr_set, L.billing_zip4, IF (R.is_billing_addr_set, R.billing_zip4, ''));
    SELF.billing_county_name     := IF (L.is_billing_addr_set, L.billing_county_name, IF (R.is_billing_addr_set, R.billing_county_name, ''));

    SELF.debug := 'BILLING/SERVICE ROLLUP Match';
    
    SELF := L;

  END;

  //----------------------------------------------------------------------------------------------------------
  // Combine Billing with Service entries, based on the exchange serial nummber and ID (The ID indentifies 
  // the data LexisNexis processing job). 
  //----------------------------------------------------------------------------------------------------------
  combined_crs_utils := ROLLUP(sorted_crs_utils, 
                               LEFT.exchange_serial_number = RIGHT.exchange_serial_number AND 
                               LEFT.id = RIGHT.id,
                               combine_Billing_and_Service_Utils(LEFT, RIGHT));

  //----------------------------------------------------------------------------------------------------------
  // Compare the flattened address data for both service and billing addresses to identify equivalent 
  // addresses.
  //----------------------------------------------------------------------------------------------------------
  are_Addresses_Equal(util_crs_layout L, util_crs_layout R) := 
      L.service_prim_range = R.service_prim_range AND
      L.service_predir = R.service_predir AND
      L.service_prim_name = R.service_prim_name AND
      L.service_addr_suffix = R.service_addr_suffix AND
      L.service_postdir = R.service_postdir AND
      L.service_unit_desig = R.service_unit_desig AND
      L.service_sec_range = R.service_sec_range AND
      L.service_city = R.service_city AND
      L.service_state = R.service_state AND
      L.service_zip = R.service_zip AND
      L.service_zip4 = R.service_zip4 AND
      L.service_county_name = R.service_county_name AND
      L.billing_prim_range = R.billing_prim_range AND
      L.billing_predir = R.billing_predir AND
      L.billing_prim_name = R.billing_prim_name AND
      L.billing_addr_suffix = R.billing_addr_suffix AND
      L.billing_postdir = R.billing_postdir AND
      L.billing_unit_desig = R.billing_unit_desig AND
      L.billing_sec_range = R.billing_sec_range AND
      L.billing_city = R.billing_city AND
      L.billing_state = R.billing_state AND
      L.billing_zip = R.billing_zip AND
      L.billing_zip4 = R.billing_zip4 AND
      L.billing_county_name = R.billing_county_name;
  
  //----------------------------------------------------------------------------------------------------------
  // Dedup on exchange_serial_number AND addresses to remove duplicates (A product of the same record from 
  // the same source imported at a different time). 
  //----------------------------------------------------------------------------------------------------------
  crs_util_dedup := DEDUP(combined_crs_Utils, 
                          LEFT.exchange_serial_number = RIGHT.exchange_serial_number AND 
                          are_Addresses_Equal(LEFT, RIGHT)
                          );

  crs_util_sorted := SORT(crs_util_dedup, -record_date);
  
  //----------------------------------------------------------------------------------------------------------
  // Project the resultant data into a layout to be used by the caller.
  //----------------------------------------------------------------------------------------------------------
  util_crs_layout_return util_crs_slim_and_mask(util_crs_layout L) := TRANSFORM
  
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
  // OUTPUT (crs_util_dedup, NAMED('crs_util_dedup')); 
  // OUTPUT (crs_util_sorted, NAMED('crs_util_sorted')); 
  // OUTPUT (return_Data, NAMED('return_Data'));

  RETURN IF(industry_class_val <> 'UTILI' AND glb_ok, return_Data);

END;