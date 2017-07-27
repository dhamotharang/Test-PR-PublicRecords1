import doxie, doxie_crs, WatercraftV2_services, VehicleV2_Services, UCCv2_Services, liensv2_services, 
Bankruptcyv2_services, LN_PropertyV2_Services, Corrections, ut, alerts;

export alert_calcs(boolean useCurVersion = true) := MODULE

	// shorter names
	shared layout_hashval := alerts.layouts.layout_hashval;
	shared layout_report_hash := alerts.layouts.layout_report_hash;
	shared layout_report_hashes_ext := doxie_crs.alert_layouts_ext.layout_report_hashes_ext;
	shared layout_report_hash_seq := doxie_crs.alert_layouts_ext.layout_report_hash_seq;
	
	// use input hashes to determine what the previously stored version was for each dataset
	shared in_hashes := alerts.inputs.input_hashes;
	
	// commoned up code for Functions below
	shared processReportAlerts(ds, trans, ver) := MACRO
		hashvals := PROJECT(ds, trans(LEFT));
		RETURN DATASET([{ver, SUM(hashvals,hashval)}], layout_report_hash);
	ENDMACRO;

  // hash calculation logic for each particular data type

	//
	// Best Info hashes
	//
	layout_hashval calcNameHashVals(doxie_crs.layout_best_information l) := TRANSFORM
		SELF.hashval := HASH64((>data<)l.title, (>data<)l.fname, (>data<)l.mname, (>data<)l.lname, (>data<)l.suffix);
    //qstring5 title := ''; qstring20 fname:=''; qstring20 mname:=''; qstring20 lname:=''; qstring5 name_suffix:='';
	END;

  DATASET(layout_report_hash) calcNameHashes(DATASET(doxie_crs.layout_best_information) recs) := FUNCTION
		processReportAlerts(recs,calcNameHashVals,alert_versions.oldNameHashVersion)
	END;

	// version 2 -- 'title' is no longer a material field
	layout_hashval calcNameHashValsV2(doxie_crs.layout_best_information l) := TRANSFORM
		SELF.hashval := HASH64((>data<)l.fname, (>data<)l.mname, (>data<)l.lname, (>data<)l.suffix);
    // qstring20 fname:=''; qstring20 mname:=''; qstring20 lname:=''; qstring5 name_suffix:='';
	END;

  DATASET(layout_report_hash) calcNameHashesV2(DATASET(doxie_crs.layout_best_information) recs) := FUNCTION
		processReportAlerts(recs,calcNameHashValsV2,alert_versions.nameHashVersion)
	END;


  layout_hashval calcSSNHashVals(doxie_crs.layout_best_information l) := TRANSFORM
		SELF.hashval := HASH64((>data<)l.ssn);  // ssn_unmasked instead?
		//qstring9 ssn := '';
	END;

  DATASET(layout_report_hash) calcSSNHashes(DATASET(doxie_crs.layout_best_information) recs) := FUNCTION
		processReportAlerts(recs,calcSSNHashVals,alert_versions.ssnHashVersion)
	END;

  layout_hashval calcStatusHashVals(doxie_crs.layout_best_information l) := TRANSFORM
		SELF.hashval := HASH64((>data<)l.dod);  // does this need to use any HRI info?
		//qstring8 DOD := '';
	END;

  DATASET(layout_report_hash) calcStatusHashes(DATASET(doxie_crs.layout_best_information) recs) := FUNCTION
		processReportAlerts(recs,calcStatusHashVals,alert_versions.statusHashVersion)
	END;

  layout_hashval calcAddressHashVals(doxie_crs.layout_best_information l) := TRANSFORM
		SELF.hashval := HASH64((>data<)l.prim_range, l.predir, (>data<)l.prim_name, (>data<)l.suffix,
		                       l.postdir, (>data<)l.sec_range, (>data<)l.city_name, l.st, (>data<)l.zip);
    //qstring10 prim_range:=''; string2 predir:=''; qstring28 prim_name:=''; qstring4 suffix:='';
    //string2 postdir:=''; qstring8 sec_range:=''; qstring25 city_name:=''; string2 st:=''; qstring5 zip:='';
	END;
	
  DATASET(layout_report_hash) calcAddressHashes(DATASET(doxie_crs.layout_best_information) recs) := FUNCTION
		processReportAlerts(recs,calcAddressHashVals,alert_versions.addressHashVersion)
	END;

  layout_hashval calcPhoneHashVals(Doxie.layout_best l) := TRANSFORM
		SELF.hashval := HASH64((>data<)l.phone);
		//qstring10 phone := '';
	END;

  DATASET(layout_report_hash) calcPhoneHashes(DATASET(doxie_crs.layout_best_information) recs) := FUNCTION
		processReportAlerts(recs,calcPhoneHashVals,alert_versions.phoneHashVersion)
	END;
	
  layout_report_hash_seq calcListedPhoneHashVals(doxie_crs.verifiedPhones().RecordLayout l, unsigned2 cnt, unsigned1 ver) := TRANSFORM
		SELF.version := ver;
		SELF.hashval := (STRING25) HASH64(l.listed_phone); //STRING10	listed_phone := '';
		SELF.alertSeq := cnt;
	END;

  DATASET(layout_report_hash_seq) calcListedPhoneHashes(DATASET(doxie_crs.verifiedPhones().RecordLayout) phones) := FUNCTION
		hashvals := PROJECT(phones, calcListedPhoneHashVals(LEFT, COUNTER, alert_versions.listedPhoneHashVersion)); 
		RETURN hashvals;
	END;
	
	//
	// Asset Hashes
	//
  layout_report_hash_seq calcAircHashVals(doxie_crs.layout_Faa_Aircraft_records l, unsigned2 cnt) := TRANSFORM
		// waiting for final instructions from content council
		SELF.version := alert_versions.aircHashVersion;
		SELF.hashval := (string) HASH64(l.n_number,l.serial_number,l.name,l.street,l.street2,l.city,l.state,l.zip_code);
		SELF.alertSeq := cnt;
	END; // no fields of qstring type

  layout_hashval calcBoatOwnerHashes(WatercraftV2_services.layouts.owner_report_rec l) := TRANSFORM
		SELF.hashval := HASH64(l.orig_address_1,l.orig_address_2,l.orig_name,l.orig_fein,l.orig_ssn);
	END; // no fields of qstring type

  layout_report_hash_seq calcBoatHashVals(WatercraftV2_services.layouts.report_out l, unsigned2 cnt) := TRANSFORM
		SELF.version := alert_versions.boatHashVersion;
		SELF.hashval := (string) (HASH64(l.hull_number) + SUM(PROJECT(l.owners, calcBoatOwnerHashes(LEFT)), hashval));
		SELF.alertSeq := cnt;
	END;// no fields of qstring type
	
  layout_hashval calcMVROwnerHashes(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_owner l) := TRANSFORM
		SELF.hashval := HASH64(l.fname,l.mname,l.lname,l.prim_range,l.prim_name,l.sec_range,l.v_city_name,l.st,l.zip5); 
	END;// no fields of qstring type

  layout_hashval calcMVRRegistrantHashes(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_registrant l) := TRANSFORM
		SELF.hashval := HASH64(l.fname,l.mname,l.lname,l.prim_range,l.prim_name,l.sec_range,l.v_city_name,l.st,l.zip5); 
	END;// no fields of qstring type

  layout_report_hash_seq calcMVRHashVals(vehiclev2_services.Layout_Report l, unsigned2 cnt) := TRANSFORM
		l_owners := project(l.owners, transform(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_owner,
																						self.append_did := (integer)left.append_did,
																						self.append_bdid := (integer)left.append_bdid,
																						self := left));
		l_registrants := project(l.registrants, transform(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_registrant,
																						self.append_did := (integer)left.append_did,
																						self.append_bdid := (integer)left.append_bdid,																						
																						self := left));
		SELF.version := alert_versions.vehicleHashVersion;
		SELF.hashval := (string) (HASH64(l.vin) +
										SUM(PROJECT(l_owners, calcMVROwnerHashes(LEFT)),hashval) +
										SUM(PROJECT(l_registrants, calcMVRRegistrantHashes(LEFT)),hashval));
		SELF.alertSeq := cnt;
	END;// no fields of qstring type

	DATASET(layout_report_hash) calcAssetHashes(DATASET(doxie_crs.layout_Faa_Aircraft_records) airc,
																							DATASET(WatercraftV2_services.layouts.report_out) boats,
																							DATASET(vehiclev2_services.Layout_Report) vehicles) := FUNCTION
		hashvals := PROJECT(PROJECT(airc, calcAircHashVals(LEFT,COUNTER)),TRANSFORM(layout_hashval, SELF.hashval := (unsigned8) LEFT.hashval)) + 
								PROJECT(PROJECT(boats, calcBoatHashVals(LEFT,COUNTER)),TRANSFORM(layout_hashval,SELF.hashval := (unsigned8) LEFT.hashval)) + 
								PROJECT(PROJECT(vehicles, calcMVRHashVals(LEFT,COUNTER)),TRANSFORM(layout_hashval,SELF.hashval := (unsigned8) LEFT.hashval));
		res := DATASET([{alert_versions.assetHashVersion, SUM(hashvals,hashval)}], layout_report_hash);
		return res;													 
  END;

	// Aircraft, Boats, Vehicles (replacement for Asset grouping)

	DATASET(layout_report_hash_seq) calcAircHashes(DATASET(doxie_crs.layout_Faa_Aircraft_records) airc) := FUNCTION
		hashvals := PROJECT(airc, calcAircHashVals(LEFT,COUNTER));
		return hashvals;													 
  END;
	
	DATASET(layout_report_hash_seq) calcBoatHashes(DATASET(WatercraftV2_services.layouts.report_out) boats) := FUNCTION
		hashvals := PROJECT(boats, calcBoatHashVals(LEFT,COUNTER));
		return hashvals;													 
  END;

	DATASET(layout_report_hash_seq) calcVehicleHashes(DATASET(vehiclev2_services.Layout_Report) vehicles) := FUNCTION
		hashvals := PROJECT(vehicles, calcMVRHashVals(LEFT,COUNTER));
		return hashvals;													 
  END;

	//
	// License Hashes
	//
	layout_hashval calcProLicHashVals(doxie_crs.layout_PL_Records l) := TRANSFORM
		// waiting for final instructions from content council
		SELF.hashval := HASH64(l.orig_license_number,l.status,l.company_name,l.orig_name,
										    	 l.orig_addr_1,l.orig_addr_2,l.orig_addr_3,l.orig_addr_4,
													 l.orig_city,l.orig_st,l.orig_zip);
	END;// no fields of qstring type

  layout_hashval calcHuntLicHashVals(doxie_crs.layout_hunting_records l) := TRANSFORM
		// waiting for final instructions from content council
		SELF.hashval := HASH64(l.lname_in,l.fname_in,l.mname_in,l.HuntFishPerm,
										  		 l.prim_range,l.predir,l.prim_name,l.suffix,l.postdir,l.sec_range,
													 l.city_name,l.st,l.zip);
	END;// no fields of qstring type

  layout_hashval calcPilotLicHashVals(doxie_crs.layout_pilot_records l) := TRANSFORM
		// waiting for final instructions from content council -- no cert_class or rating	
		SELF.hashval := HASH64(l.orig_fname,l.orig_lname,l.street1,l.street2,l.region,
											 		 l.city,l.state,l.zip_code,l.med_class,l.med_date,l.med_exp_date);
	END;// no fields of qstring type

  layout_hashval calcDriversLicHashVals(doxie.dl_search_records l) := TRANSFORM
		SELF.hashval := HASH64((>data<)l.dl_number, (>data<)l.fname, (>data<)l.mname, (>data<)l.lname,
		                       (>data<)l.prim_range, (>data<)l.predir, (>data<)l.prim_name, (>data<)l.suffix,
		                       (>data<)l.postdir, (>data<) l.sec_range,
													 (>data<)l.v_city_name, (>data<)l.st, (>data<)l.zip5,
													 l.dob, l.race, l.sex_flag);
// qstring14 dl_number; qstring20 fname; qstring20 mname; qstring20 lname;
// qstring10 prim_range; qstring2 predir; qstring28 prim_name; qstring4 suffix;
// qstring2 postdir; qstring8 sec_range;
// qstring25 v_city_name; qstring2 st; qstring5 zip5; 
// unsigned4 dob; string1 race := ''; string1 sex_flag := '';
	END;

	DATASET(layout_report_hash) calcLicenseHashes(DATASET(doxie_crs.layout_PL_Records) prolic,
																								DATASET(doxie_crs.layout_hunting_records) hunt,
																								DATASET(doxie_crs.layout_pilot_records) pilots,
																								DATASET(recordof(doxie.dl_search_records)) dls) := FUNCTION
		hashvals := PROJECT(prolic,calcProLicHashVals(LEFT)) + 
								PROJECT(hunt,calcHuntLicHashVals(LEFT)) + 
								PROJECT(pilots,calcPilotLicHashVals(LEFT)) + 
								PROJECT(dls,calcDriversLicHashVals(LEFT));
		res := DATASET([{alert_versions.licenseHashVersion, SUM(hashvals,hashval)}], layout_report_hash);
		return res;													 
  END;
	
	// Criminal records

  layout_hashval calcCrimAkaHashes(doxie.Layout_AKA l) := TRANSFORM
		SELF.hashval := HASH64(l.lname,l.fname,l.mname);
	END;// no fields of qstring type
	
  layout_hashval calcCrimOffenseHashes(doxie.Layout_Offense_Seq l) := TRANSFORM
		SELF.hashval := HASH64(l.off_date,l.arr_date,l.arr_disp_date,l.ct_disp_dt);
	END;// no fields of qstring type

  layout_hashval calcCrimCourtHashes(corrections.layout_CourtOffenses l) := TRANSFORM
		SELF.hashval := HASH64(l.off_date,l.arr_date,l.arr_disp_date,l.court_disp_date,l.sent_date,l.sent_jail);
	END;// no fields of qstring type
	
  layout_hashval calcCrimPunishmentHashes(corrections.Layout_CrimPunishment l) := TRANSFORM
		SELF.hashval := HASH64(l.par_st_dt,l.par_sch_end_dt,l.par_act_end_dt);
	END;// no fields of qstring type

  layout_hashval calcCrimActivityHashes(corrections.Layout_Activity l) := TRANSFORM
		SELF.hashval := HASH64(l.event_date);
	END;// no fields of qstring type

	layout_report_hash_seq calcCrimHashVals(doxie.Layout_DOCSearch_raw l, unsigned2 cnt) := TRANSFORM
		SELF.version := alert_versions.crimHashVersion;
		SELF.hashval := (string) (HASH64(l.lname,l.fname,l.mname,l.case_date) +
										SUM(PROJECT(l.akas, calcCrimAkaHashes(LEFT)),hashval) +
										SUM(PROJECT(l.doc_offenses, calcCrimOffenseHashes(LEFT)),hashval) +
										SUM(PROJECT(l.court_offenses, calcCrimCourtHashes(LEFT)),hashval) +
										SUM(PROJECT(l.paroles, calcCrimPunishmentHashes(LEFT)),hashval) +
										SUM(PROJECT(l.prisonTerms, calcCrimPunishmentHashes(LEFT)),hashval) +
										SUM(PROJECT(l.activities, calcCrimActivityHashes(LEFT)),hashval));
		SELF.alertSeq := cnt;
	END;// no fields of qstring type
	
	DATASET(layout_report_hash_seq) calcCrimHashes(DATASET(doxie.Layout_DOCSearch_raw) crim) := FUNCTION
		hashvals := PROJECT(crim, calcCrimHashVals(LEFT,COUNTER));
		return hashvals;													 
  END;

	obsoleteHash(unsigned1 ver) := DATASET([{ver, 0}], layout_report_hash);

  export layout_report_hashes_ext calcHashes(doxie_crs.layout_report l) := TRANSFORM
		// name hashes versioned
	  SELF.name_hashes := if(in_hashes[1].name_hashes[1].version = alert_versions.nameHashVersion or useCurVersion,
													 calcNameHashesV2(l.best_information_children),
													 calcNameHashes(l.best_information_children));
	  SELF.ssn_hashes := calcSSNHashes(l.best_information_children);  // need to include imposters?
	  SELF.status_hashes := calcStatusHashes(l.best_information_children);
	  SELF.address_hashes := calcAddressHashes(l.best_information_children);
	  SELF.phone_hashes := calcPhoneHashes(l.best_information_children);
		SELF.listedphone_hashes := calcListedPhoneHashes(l.best_information_children[1].phones);

		// as each underlying source is re-written, replace with calls to appropriate alert modules
		
		// asset_hashes are obsolete now, replaced by individual hashes for each asset subsection
		// to allow for more granular pruning of unchanged items.
		// This can be removed once all outstanding alerts have been converted to the new treatment of 
		// aircraft, watercraft, and vehicles.
	  SELF.asset_hashes := if(in_hashes[1].asset_hashes[1].version = alert_versions.assetHashVersion or useCurVersion, 
														obsoleteHash(alert_versions.assetHashVersion),
														calcAssetHashes(l.pilot_aircraft_children, l.watercraft_children,l.vehicle2_children));
	  SELF.prop_hashes := LN_PropertyV2_Services.alert.report_alerts(LN_PropertyV2_Services.resultFmt.crsToNarrowOut(l.propertyV2_children));
	  SELF.license_hashes := calcLicenseHashes(l.professional_licenses_children,
																						 l.hunting_licenses_children,
																						 l.pilot_licenses_children,
																						 l.drivers_licenses_children);
																						 //l.concealed_weapon_licenses_children
																						 //l.pilot_certificates_children,
    // none of the following 4 has qstrings
	  SELF.bkrp_hashes := BankruptcyV2_Services.alert.report_alerts(l.bankruptcies_v2_children);
	  SELF.ucc_hashes := UCCV2_Services.alert.report_alerts(l.uccv2_children);
	  SELF.lien_hashes := LiensV2_Services.alert.report_alerts(l.liens_judgements_v2_children);
 	  SELF.sexoff_hashes := doxie.SexOffender_alert_report.report_alerts(l.sex_offenses_children);

		// since these are new, the prior version is empty;
		// producing the current hashvals here allows us to prevent sending an alert the first time
	  SELF.crim_hashes := calcCrimHashes(l.doc_children);  
		SELF.airc_hashes := calcAircHashes(l.pilot_aircraft_children);
		SELF.boat_hashes := calcBoatHashes(l.watercraft_children);
		SELF.vehicle_hashes := calcVehicleHashes(l.vehicle2_children);
		SELF := [];
  END;

END;