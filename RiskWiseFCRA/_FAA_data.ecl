IMPORT faa, FCRA, doxie, ut;

boolean IsFCRA := true;
MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;
// FAA data has aircraft number as internal id

// returns FAA aircrafts main data, aircraft details, and engine info by DID
EXPORT _FAA_data (dataset (doxie.layout_references) in_dids, 
                  dataset (fcra.Layout_override_flag) flag_file, unsigned1 year_limit = 0) := MODULE

  // get aircrafts IDs; overrides are not required on FCRA side
  nrec := record
	  unsigned6 aircraft_id;
    // string8  n_number;
  end;

  key_did := faa.key_aircraft_did (IsFCRA); 
  ids := join (in_dids, key_did,
               keyed(left.did = right.did),
               transform (nrec, Self.aircraft_id := Right.aircraft_id),
               ATMOST (ut.limits.AIRCRAFTS_PER_DID));

  // Get main (registration) records
  // FCRA: overrides
  correct_air_pid := SET (flag_file (file_id = FCRA.FILE_ID.AIRCRAFT), record_id);
  correct_air_ffid := SET (flag_file (file_id = FCRA.FILE_ID.AIRCRAFT), flag_file_id);

  // need registration records for "this" subject only.
  air_main := join (ids, faa.key_aircraft_id (IsFCRA), 
                    keyed (left.aircraft_id = right.aircraft_id) and
                    // (dateVal = 0 OR (unsigned3)(right.date_first_seen[1..6]) <= dateVal) and
                    ((string)right.persistent_record_id not in correct_air_pid),
                    transform (faa.layout_aircraft_registration_out_Persistent_ID, Self := Right),
                    keep (1), limit (0));

  // overrides
  air_override := CHOOSEN (fcra.key_override_faa.aircraft (keyed (flag_file_id IN correct_air_ffid)), MAX_OVERRIDE_LIMIT);
  // put overrides into same layout, combine main data and overrides;
  air_override_st := project (air_override, transform (faa.layout_aircraft_registration_out_Persistent_ID, Self := Left));
  // it used to return a single record per aircraft;
  // since we may expose all registration records in other products, now it returns all records
  ac1 := sort(air_main + air_override_st, n_number, -date_last_seen);	
	
	todaysdate := ut.GetDate;
	//if called from benefitassessment_batchservicefcra, we only want records from the last 7 years
	ac_filtered := ac1(ut.fn_date_is_ok(todaysdate, date_last_seen, year_limit));

	EXPORT aircrafts := if(year_limit=0, ac1, ac_filtered);

  // slim down to just the codes to fetch detailed aircraft and engine information
  shared codes_rec := record
    aircrafts.mfr_mdl_code;
    aircrafts.eng_mfr_mdl;
  end;
  shared aircraft_codes := project (aircrafts, codes_rec); // should have unique codes

  // Get aircarfts' detailed info
  // overrides
  air_info_rec := faa.layout_aircraft_info;

  correct_air_info := SET (flag_file (file_id = FCRA.FILE_ID.AIRCRAFT_DETAILS), record_id);
  correct_air_info_ffid := SET (flag_file (file_id = FCRA.FILE_ID.AIRCRAFT_DETAILS), flag_file_id);

  // TODO: what's with the codes translations?
// doxie_crs.layout_FAR_aircraft get_craft_info(key_aircraft_info le) := transform
  // self.engine_type_mapped := codes.FAA_AIRCRAFT_REF.TYPE_ENGINE(le.type_engine);
  // self.aircraft_type_mapped := codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(le.type_aircraft);
  // self.category_mapped := codes.FAA_AIRCRAFT_REF.AIRCRAFT_CATEGORY_CODE(le.aircraft_category_code);
  // self.amateur_certification_mapped := codes.FAA_AIRCRAFT_REF.AMATEUR_CERTIFICATION_CODE(le.amateur_certification_code);
  // self.aircraft_weight_mapped := Codes.KeyCodes('FAA_AIRCRAFT_REF','AIRCRAFT_WEIGHT',,le.AIRCRAFT_WEIGHT);
  // self := le;
// end;

  // at most one match is expected, so I can do it within the join (without rollup)
  air_info := JOIN (dedup (sort (aircraft_codes, mfr_mdl_code), mfr_mdl_code), faa.key_aircraft_info (IsFCRA),
                    keyed (Left.mfr_mdl_code = Right.code) and
                    (right.code not in correct_air_info),
                    transform (air_info_rec, Self := Right),
                    keep (1), LIMIT (0));

  // overrides
  air_info_override := CHOOSEN (fcra.key_override_faa.aircraft_details (keyed (flag_file_id IN correct_air_info_ffid)), MAX_OVERRIDE_LIMIT);
  EXPORT aircraft_details := air_info + project (air_info_override, air_info_rec);

  // Get detailed engine info  
  // overrides
  engine_rec := faa.layout_engine_info;

  correct_air_engine := SET (flag_file (file_id = FCRA.FILE_ID.AIRCRAFT_ENGINE), record_id);
  correct_air_engine_ffid := SET (flag_file (file_id = FCRA.FILE_ID.AIRCRAFT_ENGINE), flag_file_id);

  // TODO: again, codes translations  
  // doxie_crs.layout_FAR_engine get_engine_info(key_engine_info le) := transform
    // self.engine_type_mapped := codes.FAA_AIRCRAFT_REF.TYPE_ENGINE(le.type_engine);
    // self := le;
  // end;

  air_engine_info := JOIN (dedup (sort (aircraft_codes, eng_mfr_mdl), eng_mfr_mdl), faa.key_engine_info (IsFCRA),
                           keyed (Left.eng_mfr_mdl = Right.code) and
                           (right.code not in correct_air_engine),
                           transform (engine_rec, Self := Right),
                           keep (1), limit (0));

  // overrides
  air_engine_override := CHOOSEN (fcra.key_override_faa.aircraft_engine (keyed (flag_file_id IN correct_air_engine_ffid)), MAX_OVERRIDE_LIMIT);
  EXPORT aircraft_engine := air_engine_info + project (air_engine_override, engine_rec);


// ==========================================================
// ================     Pilots' licenses     ================
// ==========================================================

  // Pilots' main registration records

  // get pilots IDs; overrides are not required on FCRA side
  pilot_rec := faa.layout_airmen_Persistent_ID;

  // persistent_record_id is used for identifying exactly a record which needs to be suppressed or corrected
  correct_pilot_id := SET (flag_file (file_id = FCRA.FILE_ID.PILOT_REGISTRATION), record_id);
  correct_pilot_ffid := SET (flag_file (file_id = FCRA.FILE_ID.PILOT_REGISTRATION), flag_file_id);

  // did-index has full payload of the pilots' registration data (i.e. same as key_airmen_rid).
  pilots_raw := join (in_dids, faa.key_airmen_did (isFCRA),
                      keyed (left.did  = right.did) and
                      ((string)Right.persistent_record_id not in correct_pilot_id),
                      transform (pilot_rec, self := right, 
											self := []),//temporary fix to bypass having to fill in source. We should remove this fix for the next release [today is 2/2]
                      limit (ut.limits.AIRMAN_PER_DID, skip));

  // overrides
  pilot_override := CHOOSEN (fcra.key_override_faa.airmen_reg (keyed (flag_file_id IN correct_pilot_ffid)),
                             FCRA.compliance.MAX_OVERRIDE_LIMIT);

  // put overrides into same layout, combine main data and overrides;
  pilot_override_st := project (pilot_override, transform(pilot_rec, self := left, self := []));

  EXPORT pilot_registrations := sort (pilots_raw + pilot_override_st, -date_last_seen);


  // Pilots' certificates
  // implementation is the same as in FaaV2_PilotServices/Raw/GetRawCert, but I'm not fond of its interface: input layouts

  // take only unique records: certificate is defined by "unique_id" and "letter_code"
  uid_rec := record
    faa.layout_airmen_Persistent_ID.unique_id;
    faa.layout_airmen_Persistent_ID.letter_code;
  end;		 
  uids := dedup (project (pilot_registrations, uid_rec), all);

  correct_cert_id := SET (flag_file (file_id = FCRA.FILE_ID.PILOT_CERTIFICATE), record_id);
  correct_cert_ffid := SET (flag_file (file_id = FCRA.FILE_ID.PILOT_CERTIFICATE), flag_file_id);

  cert_rec := faa.layout_airmen_certificate_out;
  cert_raw := join (uids, faa.key_airmen_certs (IsFCRA),
                    keyed (left.unique_id = right.uid) and
                    (left.letter_code = Right.letter) and
                    ((string) Right.persistent_record_id not in correct_cert_id),
                    transform (cert_rec, Self := Right),
                    LIMIT (ut.limits.AIRMAN_CERTIFICATES_MAX, SKIP));
								
			 // deduped2 := dedup(sort(raw, unique_id, record), unique_id, record);
   
  // overrides
  cert_override := CHOOSEN (fcra.key_override_faa.airmen_cert (keyed (flag_file_id IN correct_cert_ffid)),
                            FCRA.compliance.MAX_OVERRIDE_LIMIT);
   
  // put overrides into same layout, combine main data and overrides;
  cert_override_st := project (cert_override, cert_rec);//transform (rec_cert,Self.uid := LEft.unique_id, Self := Left));

  export pilot_certificates := cert_raw + cert_override_st;

END;
