EXPORT MAC_Add_WeAlsoFound(inputs, outputs, mod_access, enableNationalAccidents=FALSE, enableExtraAccidents=FALSE) :=
MACRO

  IMPORT doxie, WatercraftV2_Services, Email_Data, paw_services, Prof_LicenseV2,
         FLAccidents_eCrash, Accident_Services, Relationship, std, ut, D2C, Suppress;

  Relationship.mac_read_application_type(); // this declares 'ApplicationType' as well, but it's no used.

  isCNSMR := mod_access.isConsumer();

  //Counts are only performed on first input row.
  udid := (unsigned6)inputs[1].did;
  comp_prop_count := doxie.Fn_comp_prop_count(udid,,,,mod_access.ln_branded,mod_access.probation_override);
  veh_cnt := doxie.Fn_veh_count(udid,mod_access);
  dl_cnt := doxie.Fn_dl_count(udid,mod_access.date_threshold,mod_access.dppa,mod_access.glb,mod_access.ln_branded,mod_access.probation_override);
  paw_count := paw_services.PAW_Raw.getPAWcount(udid,mod_access.glb,mod_access.dppa,255);

  vess_count := COUNT(CHOOSEN(dedup(sort(WatercraftV2_Services.WatercraftV2_raw.Report_View.by_did(dataset([{udid}], Doxie.layout_references)),
    watercraft_key, state_origin), watercraft_key, state_origin),255));

  email_count := IF(EXISTS(Email_Data.Key_Did(
    KEYED(udid=did) AND ~(isCNSMR AND email_src IN D2C.Constants.EmailRestrictedSources))),1,0);

  //PhonePlus Count------------------------------------------------------------------
  phplus_key := doxie.MAC_Get_GLB_DPPA_PhonesPlus(dataset ([{udid}], doxie.layout_references), mod_access,
    TRUE, TRUE,,,,,,
    TRUE); // skip penalizing;

  // Need to apply the same deduping / filtering as in doxie.phone_noreconn_search.
  // Same filter is used in doxie.phone_noreconn_search so a change in either file necessitates keeping
  // the filters on phonerecs attribute below in sync with logic in doxie.phone_noreconn_search.
  // activeflag='' means "exclude current Gong".
  phone_recs := dedup (phplus_key (activeflag=''), phone,
    if(lname<>'',lname, listed_name), fname, prim_range, prim_name, zip, ALL);

  phonesplus_count := count(CHOOSEN (phone_recs, 255));
  //PhonePlus Count End------------------------------------------------------------------

  //Prof Licenses Count---------------------------------------------------------------
  tmpproflicenseList := CHOOSEN(Prof_LicenseV2.Key_Proflic_Did() (keyed(did=udid)), 255);
  suppressed_tmpproflicenseList := Suppress.MAC_SuppressSource(tmpproflicenseList, mod_access);
  Doxie.compliance.logSoldToSources(suppressed_tmpproflicenseList, mod_access);

  PlList := PROJECT(suppressed_tmpproflicenseList, TRANSFORM({RECORDOF(LEFT); STRING20 TmpLicenseNumber;},
    // remove leading 0's then remove '-' chars in any place
    tmp1 := REGEXREPLACE('^[0]*', trim(left.Orig_license_number, left, right), '');
    SELF.TmpLicenseNumber :=  std.str.FindReplace(tmp1,'-',''),
  SELF := LEFT));

  SlimPlList := DEDUP(SORT(PlList, did, tmpLicenseNumber, source_st), did, tmpLicenseNumber, source_st);
  slim_countPL := PROJECT(SlimPlList, TRANSFORM(recordof(Prof_LicenseV2.Key_Proflic_Did()), SELF := LEFT));
  prof_count := COUNT(slim_countPL); //choosen done on attr above so ok here.
  //End Prof Licenses Count---------------------------------------------------------

  //Relative and Associates Count----------------------------------------------
  Relationship.Layout_GetRelationship.DIDs_layout prep_did() := TRANSFORM
    SELF.did := udid;
    SELF := [];
  END;

  did_rec := DATASET ([prep_did()]);
  all_assoct := Relationship.proc_GetRelationshipNeutral(
    DID_ds := did_rec,
    RelativeFlag := TRUE,
    AssociateFlag := TRUE,
    AllFlag := FALSE,
    TransactionalOnlyFlag := FALSE,
    MaxCount := 510,
    doSkip := TRUE,
    HighConfidenceRelatives := HighConfidenceRelatives_Value,
    HighConfidenceAssociates:= HighConfidenceAssociates_Value,
    RelLookbackMonths := RelLookbackMonths_Value).result;

  rel_count   := count(CHOOSEN(all_assoct (isRelative),255));
  assoc_count := count(CHOOSEN(all_assoct (~isRelative),255));
  //End Relative and Associates Count----------------------------------------------

  //Accident counts----------------------------------------------------------------
  accidents_ecrash := JOIN(CHOOSEN(FLAccidents_eCrash.Key_eCrashV2_did(KEYED(l_did=udid)),ut.limits.ACCIDENTS_PER_DID),
    FLAccidents_eCrash.Key_eCrash2v, LEFT.accident_nbr=RIGHT.l_acc_nbr,LEFT OUTER,KEEP(1),LIMIT(0));

    //Blanking out to be compliant with D2C; Key data should not go through
    accidents := IF(~isCNSMR, accidents_ecrash);
    accidentNbrs := DEDUP(SORT(accidents,accident_nbr,report_code),accident_nbr,report_code);
    FLAccident_count := COUNT(CHOOSEN(accidentNbrs(report_code IN Accident_Services.Constants.FLAccident_source),255));
    NtlAccident_count := IF(enableNationalAccidents,COUNT(CHOOSEN(accidentNbrs(report_code IN Accident_Services.Constants.NtlAccident_source),255)),0);
    eCrashAccident_count := IF(enableExtraAccidents,COUNT(CHOOSEN(accidentNbrs(report_code IN Accident_Services.Constants.eCrashAccident_source),255)),0);
  //End accident counts ------------------------------------------------------------

  inputs add_counts(inputs l) := TRANSFORM
    SELF.comp_prop_count := comp_prop_count;
    SELF.veh_cnt :=  veh_cnt;
    SELF.dl_cnt  :=  dl_cnt;
    SELF.rel_count := rel_count;
    SELF.assoc_count := assoc_count;
    SELF.prof_count := prof_count;
    SELF.paw_count := paw_count;
    SELF.vess_count := vess_count;
    SELF.email_count := email_count;
    SELF.phonesplus_count := phonesplus_count;
    SELF.accident_count := FLAccident_count+NtlAccident_count+eCrashAccident_count;
    SELF := l;
  END;

  // calculated for the first row only on purpose: otherwise same (heavy) processing will be executed multiple times
  outputs := PROJECT(CHOOSEN(inputs, 1), add_counts(LEFT)) & inputs[2..];

ENDMACRO;
