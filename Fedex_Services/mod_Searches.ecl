import gong_services, doxie, business_header,
  autokey, doxie_cbrs, AutoStandardI, CanadianPhones,
  can_ph, Business_Header_SS, fedex, autokeyb2, Suppress;


export mod_Searches :=
MODULE;
//***** INPUTS
SHARED mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
shared dppa_purpose := mod_access.dppa;
shared score_threshold_value := AutoStandardI.InterfaceTranslator.score_threshold_value.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.score_threshold_value.params));
shared dppa_ok := mod_access.isValidDPPA();


//***** FEDEX NO-HIT FILE
t := fedex.fedex_autokey_constants.autokey_qa_Keyname2;
ak := autokeyb2.get_IDs (t, , fedex.fedex_autokey_constants.autokey_skip_set, true, true, CAN_PH.MFetch);
AutokeyB2.mac_get_payload(ak,t,fedex.fedex_autokey_constants.autokey_dataset2,byak,did)
export FedexNoHit := byak;


//***** CANADA
ck := CanadianPhones.key_fdids;
cids := CAN_PH.Get_IDs(workhard := true, nofail := true);
export Canada :=
  join(
    cids,
    ck,
    keyed(left.id = right.fdid),
    transform(
      recordof(ck),
      self := right
    ),
    keep(1)
  );
// CanadianPhonesV1Keys and CanadianPhonesV1Keys are out of scope for CCPA phase-I, when DID field is added to these keys
// FDID should be changed to valid DID and Source suppression can be uncommented
// export Canada := Suppress.MAC_SuppressSource(can_all, mod_access, fdid);
// doxie.compliance.logSoldToSources (Canada, mod_access, fdid);

//***** GONG
results := gong_services.Fetch_Gong_History(,//Dataset(doxie.layout_references) indids = dummydidDS,
  mod_access,
  noFail := true,//boolean noFail=false,
  SuppressNoncurrent := true,
  AllowLeadingLnameMatch := AutoKey.skipSetTools(fedex_services.Contants.autokey_skipset).AddZipL,
  AllowFallBack := fedex_services.Contants.AllowGongFallBack
);

results_fil := doxie.compliance.MAC_FilterOutMinors (results, , , mod_access.show_minors);
export GongSearch := results_fil;


//***** PHONES+
results := doxie.MAC_Get_GLB_DPPA_PhonesPlus(
  dataset([], doxie.layout_references),
  mod_access,
  true,//is_roxie=false,
  false); //skipAutokeys = false,
results_fil := doxie.compliance.MAC_FilterOutMinors (results, , , mod_access.show_minors);
export PhonesPlusSearch := results_fil;


//***** BUSINESS
bizrec := record
  unsigned6 BDID;
  UNSIGNED1 score := 0;
end;

gbdids :=
  Business_Header.doxie_get_bdids_plus(
    forceLocal := true,
    nofail := true,
    use_exec_search := false,
    score_results := true
  );

byz := Business_Header.Fetch_ZipPRLName(nofail := true);

bdids :=
  (
    project(
      gbdids,
      bizrec
    ) +
    project(
      byz,
      transform(
        bizrec,
        self.bdid := left.did,
        self.score := 100  //may need to calculate more meaningful score
      )
    )
  )
  (score >= fedex_services.Contants.min_BusinessSearchScore);   //filter both result sets

doxie_cbrs.mac_best_records(bdids, bestf, mod_access)


//** if this company has used the input phone, sub that in for the best phone

kp := Business_Header_SS.Key_BH_Phone;
bdid_phones :=   //these are the bdids that have used the phone which was input by the user
  dedup(
    project(
      limit(
        kp(Fedex_Services.Inputs.valid_phone and keyed(phone = (unsigned)Fedex_Services.Inputs.phone)),
        5000,  //this is what get_bdids uses as a limit when reading this index
        skip
      ),
      {kp.phone, kp.bdid}
    ),
    bdid,
    all
  );

export BusinessSearch :=
  join(
    bestf,
    bdid_phones,
    left.bdid = right.bdid,  //right is deduped on bdid so that only one record matches
    transform(
      recordof(bestf),
      self.phone := if(right.phone > 0, (typeof(left.phone))right.phone, left.phone),  //the actual substitution
      self := left
    ),
    left outer
  );



//***** HEADER
results := doxie.header_records(include_Dailies := true, allow_wildcard := false,daily_autokey_skipset := fedex_services.Contants.autokey_skipset, noFail := true);
results_fil := doxie.compliance.MAC_FilterOutMinors (results, , , mod_access.show_minors);
export HeaderSearch := results_fil;


END;
