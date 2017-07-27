// rename this -- something more along the lines of Report_alert_module

import doxie, ut, Alerts;
	
export alert_hashes(DATASET(doxie_crs.layout_report) rpt_records) := MODULE
  // may need to add these hashes to the input set if they are being accumulated
	// for versioning, need to be able to pass version number to alert_calcs module
	
	// for versioning purposes, need to calculate hashes for comparison based on the input version of each section
  shared tmp_hashes := PROJECT(rpt_records, alert_calcs(false).calcHashes(LEFT));

	shared empty_hash(unsigned1 ver) := DATASET([{ver, (string25) 0}], alerts.layouts.layout_report_hash); 

	shared alerts.layouts.layout_report_hashes slimHashes(tmp_hashes l) := TRANSFORM
		SELF.listedphone_hashes := PROJECT(l.listedPhone_hashes, alerts.layouts.layout_report_hash);
		
		// for new hash datasets, want to return a versioned, zero-value hash (rather than an empty set)
		// this allows for easier differentiation of a version change
		tmp_crim := PROJECT(l.crim_hashes, alerts.layouts.layout_report_hash);
		SELF.crim_hashes := IF(exists(tmp_crim), tmp_crim, empty_hash(alert_versions.crimHashVersion));
		tmp_airc := PROJECT(l.airc_hashes, alerts.layouts.layout_report_hash);
		SELF.airc_hashes := IF(exists(tmp_airc), tmp_airc, empty_hash(alert_versions.aircHashVersion));
		tmp_boat := PROJECT(l.boat_hashes, alerts.layouts.layout_report_hash);
		SELF.boat_hashes := IF(exists(tmp_boat), tmp_boat, empty_hash(alert_versions.boatHashVersion));
		tmp_veh := PROJECT(l.vehicle_hashes, alerts.layouts.layout_report_hash);
		SELF.vehicle_hashes := IF(exists(tmp_veh), tmp_veh, empty_hash(alert_versions.vehicleHashVersion));
		SELF := l;
	END;
	
	shared cmp_hashes := PROJECT(tmp_hashes, slimHashes(LEFT));
	
	// calculate the output hashes using the up-to-date version
	shared tmp_output_hashes := PROJECT(rpt_records, alert_calcs(true).calcHashes(LEFT));
	export output_hashes := PROJECT(tmp_output_hashes, slimHashes(LEFT));
	
	shared in_hashes := alerts.inputs.input_hashes;
		
	shared DATASET(alerts.layouts.layout_report_hash) newHashes(
															 DATASET(alerts.layouts.layout_report_hash) in_h, 
															 DATASET(alerts.layouts.layout_report_hash) cmp_h) := FUNCTION
	  // return calculated hashvals that differ from the existing hashvals
		diffs := join(in_h, cmp_h, LEFT.hashval = RIGHT.hashval, 
									TRANSFORM(alerts.layouts.layout_report_hash, SELF := RIGHT), right only);
		RETURN diffs;
	END;

	shared alerts.layouts.layout_report_hash newRec(alerts.layouts.layout_report_hash r) := TRANSFORM
		SELF := R;
	END;

	shared DATASET(doxie_crs.alert_layouts_ext.layout_report_hash_seq) newHashesSeq(
															 DATASET(alerts.layouts.layout_report_hash) in_h, 
															 DATASET(doxie_crs.alert_layouts_ext.layout_report_hash_seq) cmp_h) := FUNCTION
	  // return calculated hashvals and seq nums that differ from the existing hashvals
		diffs := join(in_h, cmp_h, LEFT.hashval = RIGHT.hashval, 
									TRANSFORM(doxie_crs.alert_layouts_ext.layout_report_hash_seq, SELF := RIGHT), right only);
		RETURN diffs;
	END;

	shared doxie_crs.alert_layouts_ext.layout_report_hash_seq newRecSeq(
						doxie_crs.alert_layouts_ext.layout_report_hash_seq r) := TRANSFORM
		SELF := R;
	END;
	
	shared in_name_h := NORMALIZE(in_hashes, LEFT.name_hashes, newRec(RIGHT));
	shared in_ssn_h := NORMALIZE(in_hashes, LEFT.ssn_hashes, newRec(RIGHT));
	shared in_status_h := NORMALIZE(in_hashes, LEFT.status_hashes, newRec(RIGHT));
	shared in_address_h := NORMALIZE(in_hashes, LEFT.address_hashes, newRec(RIGHT));
	shared in_phone_h := NORMALIZE(in_hashes, LEFT.phone_hashes, newRec(RIGHT));
	shared in_listedphone_h := NORMALIZE(in_hashes, LEFT.listedphone_hashes, newRec(RIGHT));
	shared in_asset_h := NORMALIZE(in_hashes, LEFT.asset_hashes, newRec(RIGHT));
	shared in_prop_h := NORMALIZE(in_hashes, LEFT.prop_hashes, newRec(RIGHT));
	shared in_bkrp_h := NORMALIZE(in_hashes, LEFT.bkrp_hashes, newRec(RIGHT));
	shared in_ucc_h := NORMALIZE(in_hashes, LEFT.ucc_hashes, newRec(RIGHT));
	shared in_lien_h := NORMALIZE(in_hashes, LEFT.lien_hashes, newRec(RIGHT));
	shared in_license_h := NORMALIZE(in_hashes, LEFT.license_hashes, newRec(RIGHT));
	shared in_crim_h := NORMALIZE(in_hashes, LEFT.crim_hashes, newRec(RIGHT));
	shared in_sexoff_h := NORMALIZE(in_hashes, LEFT.sexoff_hashes, newRec(RIGHT));
	shared in_airc_h := NORMALIZE(in_hashes, LEFT.airc_hashes, newRec(RIGHT));
	shared in_boat_h := NORMALIZE(in_hashes, LEFT.boat_hashes, newRec(RIGHT));
	shared in_vehicle_h := NORMALIZE(in_hashes, LEFT.vehicle_hashes, newRec(RIGHT));
	
	shared cmp_name_h := NORMALIZE(cmp_hashes, LEFT.name_hashes, newRec(RIGHT));
	shared cmp_ssn_h := NORMALIZE(cmp_hashes, LEFT.ssn_hashes, newRec(RIGHT));
	shared cmp_status_h := NORMALIZE(cmp_hashes, LEFT.status_hashes, newRec(RIGHT));
	shared cmp_address_h := NORMALIZE(cmp_hashes, LEFT.address_hashes, newRec(RIGHT));
	shared cmp_phone_h := NORMALIZE(cmp_hashes, LEFT.phone_hashes, newRec(RIGHT));
	shared cmp_asset_h := NORMALIZE(cmp_hashes, LEFT.asset_hashes, newRec(RIGHT));
	shared cmp_prop_h := NORMALIZE(cmp_hashes, LEFT.prop_hashes, newRec(RIGHT));
	shared cmp_bkrp_h := NORMALIZE(cmp_hashes, LEFT.bkrp_hashes, newRec(RIGHT));
	shared cmp_ucc_h := NORMALIZE(cmp_hashes, LEFT.ucc_hashes, newRec(RIGHT));
	shared cmp_lien_h := NORMALIZE(cmp_hashes, LEFT.lien_hashes, newRec(RIGHT));
	shared cmp_license_h := NORMALIZE(cmp_hashes, LEFT.license_hashes, newRec(RIGHT));
	shared cmp_sexoff_h := NORMALIZE(cmp_hashes, LEFT.sexoff_hashes, newRec(RIGHT));

	// new style, with seq numbers
	shared cmp_listedphone_h := NORMALIZE(tmp_hashes, LEFT.listedphone_hashes, newRecSeq(RIGHT));
	shared cmp_crim_h := NORMALIZE(tmp_hashes, LEFT.crim_hashes, newRecSeq(RIGHT));
	shared cmp_airc_h := NORMALIZE(tmp_hashes, LEFT.airc_hashes, newRecSeq(RIGHT));
	shared cmp_boat_h := NORMALIZE(tmp_hashes, LEFT.boat_hashes, newRecSeq(RIGHT));
	shared cmp_vehicle_h := NORMALIZE(tmp_hashes, LEFT.vehicle_hashes, newRecSeq(RIGHT));

	shared in_asset_ver := in_asset_h[1].version;
	shared in_crim_ver := in_crim_h[1].version;
	shared in_airc_ver := in_airc_h[1].version;
	shared in_boat_ver := in_boat_h[1].version;
	shared in_vehicle_ver := in_vehicle_h[1].version;
	shared in_name_ver := in_name_h[1].version;

	shared nameDiffs := newHashes(in_name_h, cmp_name_h);
	shared ssnDiffs := newHashes(in_ssn_h, cmp_ssn_h);
	shared statusDiffs := newHashes(in_status_h, cmp_status_h);
	shared addressDiffs := newHashes(in_address_h, cmp_address_h);
	shared phoneDiffs := newHashes(in_phone_h, cmp_phone_h);
	shared assetDiffs := newHashes(in_asset_h, cmp_asset_h);
	shared propDiffs := newHashes(in_prop_h, cmp_prop_h);
	shared bkrpDiffs := newHashes(in_bkrp_h, cmp_bkrp_h);
	shared uccDiffs := newHashes(in_ucc_h, cmp_ucc_h);
	shared lienDiffs := newHashes(in_lien_h, cmp_lien_h);
	shared licenseDiffs := newHashes(in_license_h, cmp_license_h);
	shared sexOffDiffs := newHashes(in_sexoff_h, cmp_sexoff_h);

	// new style, with seq numbers
	shared listedphoneDiffs := newHashesSeq(in_listedphone_h, cmp_listedphone_h);
	shared crimDiffs := newHashesSeq(in_crim_h, cmp_crim_h);
	shared aircDiffs := newHashesSeq(in_airc_h, cmp_airc_h);
	shared boatDiffs := newHashesSeq(in_boat_h, cmp_boat_h);
	shared vehicleDiffs := newHashesSeq(in_vehicle_h, cmp_vehicle_h);
	
	shared boolean nameChanges := alerts.inputs.trackName and exists(nameDiffs);
	shared boolean ssnChanges := alerts.inputs.trackSSN and exists(ssnDiffs);
	shared boolean statusChanges := alerts.inputs.trackStatus and exists(statusDiffs);
	shared boolean addressChanges := alerts.inputs.trackAddress and exists(addressDiffs);
	shared boolean phoneChanges := alerts.inputs.trackPhone and exists(phoneDiffs);
	shared boolean listedphoneChanges := alerts.inputs.trackListedPhone and exists(listedphoneDiffs);
	shared boolean assetChanges := alerts.inputs.trackAsset and exists(assetDiffs) and in_asset_ver <> 0;
	shared boolean propChanges := alerts.inputs.trackProperty and exists(propDiffs);
	shared boolean bkrpChanges := alerts.inputs.trackBankruptcy and exists(bkrpDiffs);
	shared boolean uccChanges := alerts.inputs.trackUCC and exists(uccDiffs);
	shared boolean lienChanges := alerts.inputs.trackLiens and exists(lienDiffs);
	shared boolean licenseChanges := alerts.inputs.trackLicense and exists(licenseDiffs);
	shared boolean crimChanges := alerts.inputs.trackCriminal and exists(crimDiffs) and in_crim_ver <> 0;
	shared boolean sexOffChanges := alerts.inputs.trackSexOffender and exists(sexOffDiffs);
	shared boolean aircChanges := alerts.inputs.trackAsset and exists(aircDiffs) and (in_airc_ver <> 0 or AssetChanges);
	shared boolean boatChanges := alerts.inputs.trackAsset and exists(boatDiffs) and (in_boat_ver <> 0 or AssetChanges);
	shared boolean vehicleChanges := alerts.inputs.trackAsset and exists(vehicleDiffs) and (in_vehicle_ver <> 0 or AssetChanges);

	// common macro for pruning the unchanged records from a dataset
	shared mac_prune(in_ds, changes, diffs, out_ds) := MACRO
			
		#uniquename(rec_plus_seq)
		%rec_plus_seq% := RECORD(in_ds),
			unsigned2 alertSeq;
		END;
		
		#uniquename(addSeq)
		%rec_plus_seq% %addSeq%(recordof(in_ds) l, unsigned2 cnt) := TRANSFORM
			SELF.alertSeq := cnt;
			SELF := l;
		END;
		
		#uniquename(in_ds_cnt)
		%in_ds_cnt% := PROJECT(in_ds, %addSeq%(LEFT,COUNTER));
		
		out_ds := IF(changes, JOIN(diffs, %in_ds_cnt%, LEFT.alertSeq = RIGHT.alertSeq, 
																TRANSFORM(recordof(in_ds), SELF := RIGHT)));
	ENDMACRO;
	
	shared doxie_crs.layout_best_information pruneBest(doxie_crs.layout_best_information l) := TRANSFORM
		SELF.fname := IF(nameChanges, l.fname, '');
		SELF.mname := IF(nameChanges, l.mname, '');
		SELF.lname := IF(nameChanges, l.lname, '');
		SELF.prim_range := IF(addressChanges, l.prim_range, '');
		SELF.predir := IF(addressChanges, l.predir, '');
		SELF.prim_name := IF(addressChanges, l.prim_name, '');
		SELF.suffix := IF(addressChanges, l.suffix, '');
		SELF.postdir := IF(addressChanges, l.postdir,'');
		SELF.unit_desig := IF(addressChanges, l.unit_desig, '');
		SELF.sec_range := IF(addressChanges, l.sec_range, '');
		SELF.city_name := IF(addressChanges, l.city_name,'');
		SELF.st := IF(addressChanges, l.st,'');
		SELF.zip := IF(addressChanges, l.zip,'');
		SELF.zip4 := IF(addressChanges, l.zip4,'');
		SELF.addr_dt_last_seen := IF(addressChanges, l.addr_dt_last_seen,0);
		SELF.DOD := IF(statusChanges, l.DOD,'');
		SELF.ssn := IF(ssnChanges, l.ssn,'');
		SELF.ssn_unmasked := IF(ssnChanges, l.ssn_unmasked,'');
		SELF.phone := IF(phoneChanges, l.phone,'');
		
		// only return the phones that changed
	  mac_prune(l.phones,listedPhoneChanges,listedphoneDiffs,listedPhonePruned);
		SELF.phones := listedPhonePruned;
		SELF := l;
	END;

  doxie_crs.layout_report pruneUnchanged(doxie_crs.layout_report l) := TRANSFORM
		SELF.best_information_children := PROJECT(l.best_information_children, pruneBest(LEFT));
	  
		mac_prune(l.pilot_aircraft_children,aircChanges,aircDiffs,aircPruned);
		SELF.pilot_aircraft_children := aircPruned;
	 
	  mac_prune(l.watercraft_children,boatChanges,boatDiffs,boatPruned);
		SELF.watercraft_children := boatPruned;
		
	  mac_prune(l.vehicle2_children,vehicleChanges,vehicleDiffs,vehiclePruned);
		SELF.vehicle2_children := vehiclePruned;

		SELF.propertyV2_children := IF(propChanges, l.propertyV2_children);
		SELF.bankruptcies_v2_children := IF(bkrpChanges, l.bankruptcies_v2_children);
		SELF.uccv2_children := IF(uccChanges, l.uccv2_children);
		SELF.liens_judgements_v2_children := IF(lienChanges, l.liens_judgements_v2_children);
		SELF.professional_licenses_children := IF(licenseChanges, l.professional_licenses_children);
		SELF.hunting_licenses_children := IF(licenseChanges, l.hunting_licenses_children);
		SELF.pilot_licenses_children := IF(licenseChanges, l.pilot_licenses_children);
		//SELF.drivers_licenses2_children := IF(licenseChanges, l.drivers_licenses2_children);
		//comparisons not yet being made on driversV2
		SELF.drivers_licenses_children := IF(licenseChanges, l.drivers_licenses_children);
		
	  mac_prune(l.doc_children,crimChanges,crimDiffs,crimPruned);
		SELF.doc_children := crimPruned;

		SELF.sex_offenses_children := IF(sexOffChanges, l.sex_offenses_children);
		SELF := l;
	END;

  EXPORT changed_sections := PROJECT(rpt_records, pruneUnchanged(LEFT));

  // create a bitmap value so that clients can know which sections changed
  EXPORT hashmap := IF(nameChanges,ut.bit_set(0,0),0) +
                    IF(ssnChanges,ut.bit_set(0,1),0) +
                    IF(statusChanges,ut.bit_set(0,2),0) +
                    IF(addressChanges,ut.bit_set(0,3),0) +
                    IF(phoneChanges,ut.bit_set(0,4),0) +
                    IF(assetChanges or aircChanges or boatChanges or vehicleChanges,ut.bit_set(0,5),0) +
                    IF(propChanges,ut.bit_set(0,6),0) +
                    IF(bkrpChanges,ut.bit_set(0,7),0) +
                    IF(uccChanges,ut.bit_set(0,8),0) +
                    IF(lienChanges,ut.bit_set(0,9),0) +
                    IF(licenseChanges,ut.bit_set(0,10),0) +
                    IF(crimChanges,ut.bit_set(0,11),0) +
                    IF(sexOffChanges,ut.bit_set(0,12),0) +
                    IF(listedPhoneChanges,ut.bit_set(0,13),0) +
                    IF(aircChanges,ut.bit_set(0,14),0) +
                    IF(boatChanges,ut.bit_set(0,15),0) +
                    IF(vehicleChanges,ut.bit_set(0,16),0);
	
	//recommendation from Gavin in an attempt to prevent hashmap from being evaluated if return_hashes not requested
	//if (a, nofold(if (b, x, y)), y)
	
	// formerly    EXPORT sendResults := ~return_hashes OR hashmap <> 0;
	EXPORT sendResults := IF(~alerts.inputs.return_hashes, true, nofold(IF(hashmap <> 0, true,false)));
	
	// formerly    EXPORT sendHashes := return_hashes and hashmap <> 0;
	EXPORT sendHashes := IF(alerts.inputs.return_hashes, nofold(IF(hashmap <> 0, true, false)), false);
	
	// check to see if hashes need to be sent because of a versioning change, even if there were no changes in the report
	hashVersionChange := in_asset_ver <> alert_versions.assetHashVersion or
											 in_crim_ver <> alert_versions.crimHashVersion or
											 in_airc_ver <> alert_versions.aircHashVersion or
											 in_boat_ver <> alert_versions.boatHashVersion or
											 in_vehicle_ver <> alert_versions.vehicleHashVersion or
											 in_name_ver <> alert_versions.nameHashVersion;
											 
	EXPORT versionChange := IF(alerts.inputs.return_hashes, hashVersionChange, false);
END;
