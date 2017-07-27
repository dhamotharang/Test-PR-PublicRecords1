// rename this -- something more along the lines of Report_alert_module

import doxie, ut, Alerts;
	
export alert_hashes(DATASET(doxie_cbrs.layout_report) rpt_records) := MODULE
  // may need to add these hashes to the input set if they are being accumulated
	// for versioning, need to be able to pass version number to alert_calcs module

	// when versioning is needed, need to calculate hashes based on the input version of each 
	// section; then need to separately calculate output hashes based on current version
  EXPORT output_hashes := PROJECT(rpt_records, alert_calcs(true).calcHashes(LEFT));

	// for now, just use output_hashes for comparison
	shared cmp_hashes := output_hashes;
	
	shared in_hashes := alerts.inputs.input_hashes;
	
	alerts.layouts.layout_report_hash getRes(alerts.layouts.layout_report_hash l, alerts.layouts.layout_report_hash r) := TRANSFORM
		SELF.version := IF(l.version <> 0, l.version, r.version);
		SELF.hashval := IF(l.hashval <> '', l.hashval, r.hashval);
	END;
	
	shared boolean compareHashes(DATASET(alerts.layouts.layout_report_hash) in_h, 
															 DATASET(alerts.layouts.layout_report_hash) cmp_h) := FUNCTION
	  // return TRUE any time there is a difference between input and calculated hashvals
		diffs := join(in_h, cmp_h, LEFT.hashval = RIGHT.hashval, getRes(LEFT, RIGHT), full only);
		RETURN (exists(diffs));
	END;

	shared alerts.layouts.layout_report_hash newRec(alerts.layouts.layout_report_hash r) := TRANSFORM
		SELF := R;
	END;
	
	shared in_name_h := NORMALIZE(in_hashes, LEFT.name_hashes, newRec(RIGHT));
	shared in_address_h := NORMALIZE(in_hashes, LEFT.address_hashes, newRec(RIGHT));
	shared in_asset_h := NORMALIZE(in_hashes, LEFT.asset_hashes, newRec(RIGHT));
	shared in_prop_h := NORMALIZE(in_hashes, LEFT.prop_hashes, newRec(RIGHT));
	shared in_bkrp_h := NORMALIZE(in_hashes, LEFT.bkrp_hashes, newRec(RIGHT));
	shared in_ucc_h := NORMALIZE(in_hashes, LEFT.ucc_hashes, newRec(RIGHT));
	shared in_lien_h := NORMALIZE(in_hashes, LEFT.lien_hashes, newRec(RIGHT));
	shared in_license_h := NORMALIZE(in_hashes, LEFT.license_hashes, newRec(RIGHT));
	shared in_corp_h := NORMALIZE(in_hashes, LEFT.corp_hashes, newRec(RIGHT));
	
	shared cmp_name_h := NORMALIZE(cmp_hashes, LEFT.name_hashes, newRec(RIGHT));
	shared cmp_address_h := NORMALIZE(cmp_hashes, LEFT.address_hashes, newRec(RIGHT));
	shared cmp_asset_h := NORMALIZE(cmp_hashes, LEFT.asset_hashes, newRec(RIGHT));
	shared cmp_prop_h := NORMALIZE(cmp_hashes, LEFT.prop_hashes, newRec(RIGHT));
	shared cmp_bkrp_h := NORMALIZE(cmp_hashes, LEFT.bkrp_hashes, newRec(RIGHT));
	shared cmp_ucc_h := NORMALIZE(cmp_hashes, LEFT.ucc_hashes, newRec(RIGHT));
	shared cmp_lien_h := NORMALIZE(cmp_hashes, LEFT.lien_hashes, newRec(RIGHT));
	shared cmp_license_h := NORMALIZE(cmp_hashes, LEFT.license_hashes, newRec(RIGHT));
	shared cmp_corp_h := NORMALIZE(cmp_hashes, LEFT.corp_hashes, newRec(RIGHT));
			
	shared boolean nameChanges := alerts.inputs.trackName and compareHashes(in_name_h, cmp_name_h);
	shared boolean addressChanges := alerts.inputs.trackAddress and compareHashes(in_address_h, cmp_address_h);
	shared boolean assetChanges := alerts.inputs.trackAsset and compareHashes(in_asset_h, cmp_asset_h);
	shared boolean propChanges := alerts.inputs.trackProperty and compareHashes(in_prop_h, cmp_prop_h);
	shared boolean bkrpChanges := alerts.inputs.trackBankruptcy and compareHashes(in_bkrp_h, cmp_bkrp_h);
	shared boolean uccChanges := alerts.inputs.trackUCC and compareHashes(in_ucc_h, cmp_ucc_h);
	shared boolean lienChanges := alerts.inputs.trackLiens and compareHashes(in_lien_h, cmp_lien_h);
	shared boolean licenseChanges := alerts.inputs.trackLicense and compareHashes(in_license_h, cmp_license_h);
	shared boolean corpChanges := alerts.inputs.trackCorp and compareHashes(in_corp_h, cmp_corp_h);

  doxie_cbrs.layout_report pruneUnchanged(doxie_cbrs.layout_report l) := TRANSFORM
		SELF.aircrafts := IF(assetChanges, l.aircrafts);
		SELF.watercrafts := IF(assetChanges, l.watercrafts);
		SELF.motor_vehicles_v2 := IF(assetChanges, l.motor_vehicles_v2);
		SELF.property_v2 := IF(propChanges, l.property_v2);
		SELF.bankruptcy_v2 := IF(bkrpChanges, l.bankruptcy_v2);
		SELF.liens_judgments_v2 := PROJECT(DATASET([{0}],{unsigned a}), TRANSFORM(RECORDOF(l.liens_judgments_v2),
		SELF.uccs := IF(uccChanges, l.liens_judgments_v2[1].uccs),
		SELF.judgment_liens := IF(lienChanges, l.liens_judgments_v2[1].judgment_liens)));
		SELF.professional_licenses := IF(licenseChanges, l.professional_licenses);
		SELF.Profile_Information := IF(corpChanges, l.Profile_Information);
		SELF.Registered_Agents := IF(corpChanges, l.Registered_Agents);
		SELF := l;
	END;

  EXPORT changed_sections := PROJECT(rpt_records, pruneUnchanged(LEFT));

  // create a bitmap value so that clients can know which sections changed
  EXPORT hashmap := IF(nameChanges,ut.bit_set(0,0),0) +
                    IF(addressChanges,ut.bit_set(0,3),0) +
                    IF(assetChanges,ut.bit_set(0,5),0) +
                    IF(propChanges,ut.bit_set(0,6),0) +
                    IF(bkrpChanges,ut.bit_set(0,7),0) +
                    IF(uccChanges,ut.bit_set(0,8),0) +
                    IF(lienChanges,ut.bit_set(0,9),0) +
                    IF(licenseChanges,ut.bit_set(0,10),0) +
										IF(corpChanges,ut.bit_set(0,13),0);
	
	//recommendation from Gavin in an attempt to prevent hashmap from being evaluated if return_hashes not requested
	//if (a, nofold(if (b, x, y)), y)
	
	// formerly    EXPORT sendResults := ~return_hashes OR hashmap <> 0;
	EXPORT sendResults := IF(~alerts.inputs.return_hashes, true, nofold(IF(hashmap <> 0, true,false)));
	
	// formerly    EXPORT sendHashes := return_hashes and hashmap <> 0;
	EXPORT sendHashes := IF(alerts.inputs.return_hashes, nofold(IF(hashmap <> 0, true, false)), false);
END;
