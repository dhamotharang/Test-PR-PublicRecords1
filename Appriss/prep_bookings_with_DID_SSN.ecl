import crim_common, DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville;

ds_clean_bookings:=prep_norm_bookings_from_raw;



lMatchSet := ['S','A','D'];

did_Add.MAC_Match_Flex//_Sensitive  // NOTE <- removed sensitive macro 4/15/2008
	(ds_clean_bookings, lMatchSet,						
	 ap_ssn, date_of_birth, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, state, fake_phone_field, 
	 did,
	 layout_prep_booking_rec, //bookings_rec_norm,
	 false, fake_DID_Score_field,
	 75,						//dids with a score below here will be dropped
	 ds_bookings_with_did
	)

DID_Add.MAC_Add_SSN_By_DID(ds_bookings_with_did, did, ssn, ds_bookings_with_ssn)


export prep_bookings_with_DID_SSN := ds_bookings_with_ssn : persist(cluster_name+'::persist::appriss_bookings_with_DID_SSN');