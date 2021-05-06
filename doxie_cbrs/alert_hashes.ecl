// rename this -- something more along the lines of Report_alert_module

IMPORT doxie_cbrs, doxie, ut, Alerts;
  
EXPORT alert_hashes(DATASET(doxie_cbrs.layout_report) rpt_records) := MODULE
  // may need to add these hashes to the input set if they are being accumulated
  // for versioning, need to be able to pass version number to alert_calcs module

  // when versioning is needed, need to calculate hashes based on the input version of each
  // section; then need to separately calculate output hashes based on current version
  EXPORT output_hashes := PROJECT(rpt_records, doxie_cbrs.alert_calcs(TRUE).calcHashes(LEFT));

  // for now, just use output_hashes for comparison
  SHARED cmp_hashes := output_hashes;
  
  SHARED in_hashes := alerts.inputs.input_hashes;
  
  alerts.layouts.layout_report_hash getRes(alerts.layouts.layout_report_hash l, alerts.layouts.layout_report_hash r) := TRANSFORM
    SELF.version := IF(l.version <> 0, l.version, r.version);
    SELF.hashval := IF(l.hashval <> '', l.hashval, r.hashval);
  END;
  
  SHARED BOOLEAN compareHashes(DATASET(alerts.layouts.layout_report_hash) in_h,
                               DATASET(alerts.layouts.layout_report_hash) cmp_h) := FUNCTION
    // return TRUE any time there is a difference between input and calculated hashvals
    diffs := JOIN(in_h, cmp_h, LEFT.hashval = RIGHT.hashval, getRes(LEFT, RIGHT), full only);
    RETURN (EXISTS(diffs));
  END;

  SHARED alerts.layouts.layout_report_hash newRec(alerts.layouts.layout_report_hash r) := TRANSFORM
    SELF := R;
  END;
  
  SHARED in_name_h := NORMALIZE(in_hashes, LEFT.name_hashes, newRec(RIGHT));
  SHARED in_address_h := NORMALIZE(in_hashes, LEFT.address_hashes, newRec(RIGHT));
  SHARED in_asset_h := NORMALIZE(in_hashes, LEFT.asset_hashes, newRec(RIGHT));
  SHARED in_prop_h := NORMALIZE(in_hashes, LEFT.prop_hashes, newRec(RIGHT));
  SHARED in_bkrp_h := NORMALIZE(in_hashes, LEFT.bkrp_hashes, newRec(RIGHT));
  SHARED in_ucc_h := NORMALIZE(in_hashes, LEFT.ucc_hashes, newRec(RIGHT));
  SHARED in_lien_h := NORMALIZE(in_hashes, LEFT.lien_hashes, newRec(RIGHT));
  SHARED in_license_h := NORMALIZE(in_hashes, LEFT.license_hashes, newRec(RIGHT));
  SHARED in_corp_h := NORMALIZE(in_hashes, LEFT.corp_hashes, newRec(RIGHT));
  
  SHARED cmp_name_h := NORMALIZE(cmp_hashes, LEFT.name_hashes, newRec(RIGHT));
  SHARED cmp_address_h := NORMALIZE(cmp_hashes, LEFT.address_hashes, newRec(RIGHT));
  SHARED cmp_asset_h := NORMALIZE(cmp_hashes, LEFT.asset_hashes, newRec(RIGHT));
  SHARED cmp_prop_h := NORMALIZE(cmp_hashes, LEFT.prop_hashes, newRec(RIGHT));
  SHARED cmp_bkrp_h := NORMALIZE(cmp_hashes, LEFT.bkrp_hashes, newRec(RIGHT));
  SHARED cmp_ucc_h := NORMALIZE(cmp_hashes, LEFT.ucc_hashes, newRec(RIGHT));
  SHARED cmp_lien_h := NORMALIZE(cmp_hashes, LEFT.lien_hashes, newRec(RIGHT));
  SHARED cmp_license_h := NORMALIZE(cmp_hashes, LEFT.license_hashes, newRec(RIGHT));
  SHARED cmp_corp_h := NORMALIZE(cmp_hashes, LEFT.corp_hashes, newRec(RIGHT));
      
  SHARED BOOLEAN nameChanges := alerts.inputs.trackName AND compareHashes(in_name_h, cmp_name_h);
  SHARED BOOLEAN addressChanges := alerts.inputs.trackAddress AND compareHashes(in_address_h, cmp_address_h);
  SHARED BOOLEAN assetChanges := alerts.inputs.trackAsset AND compareHashes(in_asset_h, cmp_asset_h);
  SHARED BOOLEAN propChanges := alerts.inputs.trackProperty AND compareHashes(in_prop_h, cmp_prop_h);
  SHARED BOOLEAN bkrpChanges := alerts.inputs.trackBankruptcy AND compareHashes(in_bkrp_h, cmp_bkrp_h);
  SHARED BOOLEAN uccChanges := alerts.inputs.trackUCC AND compareHashes(in_ucc_h, cmp_ucc_h);
  SHARED BOOLEAN lienChanges := alerts.inputs.trackLiens AND compareHashes(in_lien_h, cmp_lien_h);
  SHARED BOOLEAN licenseChanges := alerts.inputs.trackLicense AND compareHashes(in_license_h, cmp_license_h);
  SHARED BOOLEAN corpChanges := alerts.inputs.trackCorp AND compareHashes(in_corp_h, cmp_corp_h);

  doxie_cbrs.layout_report pruneUnchanged(doxie_cbrs.layout_report l) := TRANSFORM
    SELF.aircrafts := IF(assetChanges, l.aircrafts);
    SELF.watercrafts := IF(assetChanges, l.watercrafts);
    SELF.motor_vehicles_v2 := IF(assetChanges, l.motor_vehicles_v2);
    SELF.property_v2 := IF(propChanges, l.property_v2);
    SELF.bankruptcy_v2 := IF(bkrpChanges, l.bankruptcy_v2);
    SELF.liens_judgments_v2 := PROJECT(DATASET([{0}],{UNSIGNED a}), TRANSFORM(RECORDOF(l.liens_judgments_v2),
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
  
  // formerly EXPORT sendResults := ~return_hashes OR hashmap <> 0;
  EXPORT sendResults := IF(~alerts.inputs.return_hashes, TRUE, NOFOLD(IF(hashmap <> 0, TRUE,FALSE)));
  
  // formerly EXPORT sendHashes := return_hashes and hashmap <> 0;
  EXPORT sendHashes := IF(alerts.inputs.return_hashes, NOFOLD(IF(hashmap <> 0, TRUE, FALSE)), FALSE);
END;
