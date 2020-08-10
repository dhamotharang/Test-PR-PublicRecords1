IMPORT alerts, Bankruptcyv2_services, doxie_cbrs, liensv2_services, LN_PropertyV2_Services, 
       UCCv2_Services, VehicleV2_Services, WatercraftV2_services;

export alert_calcs(boolean curVersion = true) := MODULE

	// shorter names
	shared layout_hashval := alerts.layouts.layout_hashval;
	shared layout_report_hash := alerts.layouts.layout_report_hash;
	shared layout_report_hashes := alerts.layouts.layout_report_hashes;
	
	// version numbers
	shared unsigned1 nameHashVersion := 1;
	shared unsigned1 addressHashVersion := 1;
	shared unsigned1 assetHashVersion := 1;
	shared unsigned1 licenseHashVersion := 1;
	shared unsigned1 corpHashVersion := 1;
	
	// commoned up code for Functions below
	shared processReportAlerts(ds, trans, ver) := MACRO
		hashvals := PROJECT(ds, trans(LEFT));
		RETURN DATASET([{ver, SUM(hashvals,hashval)}], layout_report_hash);
	ENDMACRO;

  // hash calculation logic for each particular data type

	//
	// Best Info hashes
	//
	layout_hashval calcNameHashVals(recordof(doxie_cbrs.all_base_records_prs().best_information) l) := TRANSFORM
		SELF.hashval := HASH64((>data<)l.company_name);
	END;

  DATASET(layout_report_hash) calcNameHashes(DATASET(recordof(doxie_cbrs.all_base_records_prs().best_information)) recs) := FUNCTION
		processReportAlerts(recs,calcNameHashVals,nameHashVersion)
	END;

  layout_hashval calcAddressHashVals(recordof(doxie_cbrs.all_base_records_prs().best_information) l) := TRANSFORM
		SELF.hashval := HASH64((>data<)l.prim_range, l.predir,(>data<)l.prim_name,(>data<)l.addr_suffix,l.postdir,(>data<)l.sec_range,
		                       (>data<)l.city,l.state,l.zip);
	END; // predir, postdir, state, zip are regular strings, all others qstrings.
	
  DATASET(layout_report_hash) calcAddressHashes(DATASET(recordof(doxie_cbrs.all_base_records_prs().best_information)) recs) := FUNCTION
		processReportAlerts(recs,calcAddressHashVals,addressHashVersion)
	END;

	//
	// Asset Hashes
	//
  layout_hashval calcAircHashVals(recordof(doxie_cbrs.all_base_records_prs().aircrafts) l) := TRANSFORM
		// waiting for final instructions from content council
		SELF.hashval := HASH64(l.n_number,l.serial_number,l.name,l.street,l.street2,l.city,l.state,l.zip_code);
	END; // no fields of qstring type

	// WatercraftV2_Services.Layouts
  layout_hashval calcBoatOwnerHashes(WatercraftV2_services.Layouts.owner_report_rec l) := TRANSFORM
		SELF.hashval := HASH64(l.orig_address_1,l.orig_address_2,l.orig_name,l.orig_fein,l.orig_ssn);
	END; // no fields of qstring type

  layout_hashval calcBoatHashVals(recordof(doxie_cbrs.all_base_records_prs().watercrafts) l) := TRANSFORM
		SELF.hashval := HASH64(l.hull_number) + SUM(PROJECT(l.owners, calcBoatOwnerHashes(LEFT)), hashval);
	END; // no fields of qstring type
	
  layout_hashval calcMVROwnerHashes(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_owner l) := TRANSFORM
		SELF.hashval := HASH64(l.fname,l.mname,l.lname,l.prim_range,l.prim_name,l.sec_range,l.v_city_name,l.st,l.zip5); 
	END; // no fields of qstring type

  layout_hashval calcMVRRegistrantHashes(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_registrant l) := TRANSFORM
		SELF.hashval := HASH64(l.fname,l.mname,l.lname,l.prim_range,l.prim_name,l.sec_range,l.v_city_name,l.st,l.zip5); 
	END; // no fields of qstring type

  layout_hashval calcMVRHashVals(recordof(doxie_cbrs.all_base_records_prs().motor_vehicles_v2) l) := TRANSFORM
		l_owners := project(l.owners, transform(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_owner,
																						self.append_did := (integer)left.append_did,
																						self.append_bdid := (integer)left.append_bdid,
																						self := left));
		l_registrants := project(l.registrants, transform(VehicleV2_services.Layout_vehicle_party_out.layout_vehicle_party_registrant,
																						self.append_did := (integer)left.append_did,
																						self.append_bdid := (integer)left.append_bdid,																						
																						self := left));
		SELF.hashval := HASH64(l.vin) +
										SUM(PROJECT(l_owners, calcMVROwnerHashes(LEFT)),hashval) +
										SUM(PROJECT(l_registrants, calcMVRRegistrantHashes(LEFT)),hashval);
	END; // no fields of qstring type

	DATASET(layout_report_hash) calcAssetHashes(DATASET(recordof(doxie_cbrs.all_base_records_prs().aircrafts)) airc,
																							DATASET(recordof(doxie_cbrs.all_base_records_prs().watercrafts)) boats,
																							DATASET(recordof(doxie_cbrs.all_base_records_prs().motor_vehicles_v2)) vehicles) := FUNCTION
		hashvals := PROJECT(airc, calcAircHashVals(LEFT)) + 
								PROJECT(boats, calcBoatHashVals(LEFT)) + 
								PROJECT(vehicles, calcMVRHashVals(LEFT));
		res := DATASET([{assetHashVersion, SUM(hashvals,hashval)}], layout_report_hash);
		return res;													 
  END;

	//
	// License Hashes
	//
	// Prof_License.layout_proflic_out
	layout_hashval calcProLicHashVals(recordof(doxie_cbrs.all_base_records_prs().professional_licenses) l) := TRANSFORM
		// waiting for final instructions from content council
		SELF.hashval := HASH64(l.orig_license_number,l.status,l.company_name,l.orig_name,
										    	 l.orig_addr_1,l.orig_addr_2,l.orig_addr_3,l.orig_addr_4,
													 l.orig_city,l.orig_st,l.orig_zip); 
	END; // no fields of qstring type

	DATASET(layout_report_hash) calcLicenseHashes(DATASET(recordof(doxie_cbrs.all_base_records_prs().professional_licenses)) prolic) := FUNCTION
		hashvals := PROJECT(prolic,calcProLicHashVals(LEFT));
		res := DATASET([{licenseHashVersion, SUM(hashvals,hashval)}], layout_report_hash);
		return res;													 
  END; 
	
	// Corp Hashes 
	// Corp2_services.layout_corps_out
  layout_hashval calcProfileHashVals(recordof(doxie_cbrs.all_base_records_prs().Profile_Information) l) := TRANSFORM
		SELF.hashval := HASH64(l.corp_legal_name,l.corp_status_desc);
	END; // no fields of qstring type

	// doxie_cbrs.registered_agents_records
  layout_hashval calcRegAgentHashVals(recordof(doxie_cbrs.all_base_records_prs().Registered_Agents) l) := TRANSFORM
		SELF.hashval := HASH64(l.corp_ra_name,(>data<)l.prim_range,l.predir,(>data<)l.prim_name,l.postdir,(>data<)l.sec_range,(>data<)l.city,l.state,(>data<)l.zip);
	END; // corp_ra_name, predir, postdir, state are regular strings; all others qstrings.

	DATASET(layout_report_hash) calcCorpHashes(DATASET(recordof(doxie_cbrs.all_base_records_prs().Profile_Information)) pr,
																						 DATASET(recordof(doxie_cbrs.all_base_records_prs().Registered_Agents)) ra) := FUNCTION
		hashvals := PROJECT(pr, calcProfileHashVals(LEFT)) + 
								PROJECT(ra, calcRegAgentHashVals(LEFT));
		res := DATASET([{corpHashVersion, SUM(hashvals,hashval)}], layout_report_hash);
		return res;													 
  END;
	
  export layout_report_hashes calcHashes(doxie_cbrs.layout_report l) := TRANSFORM
	  SELF.name_hashes := calcNameHashes(l.best_information);
	  SELF.address_hashes := calcAddressHashes(l.best_information);

		// as each underlying source is re-written, replace with calls to appropriate alert modules
	  SELF.asset_hashes := calcAssetHashes(l.aircrafts, l.watercrafts,l.motor_vehicles_v2);
	  SELF.prop_hashes := LN_PropertyV2_Services.alert.report_alerts(LN_PropertyV2_Services.resultFmt.widerOutToNarrowOut(l.property_V2));
	  SELF.license_hashes := calcLicenseHashes(l.professional_licenses);
																						 //l.concealed_weapon_licenses_children
																						 //l.pilot_certificates_children,
																						 
	  SELF.bkrp_hashes := BankruptcyV2_Services.alert.report_alerts(l.bankruptcy_v2);
	  SELF.ucc_hashes := UCCV2_Services.alert.report_alerts(l.liens_judgments_v2[1].uccs);
	  SELF.lien_hashes := LiensV2_Services.alert.report_alerts(l.liens_judgments_v2[1].judgment_liens);
		SELF.corp_hashes := calcCorpHashes(l.Profile_Information, l.Registered_Agents);
		SELF := [];
  END;

END;