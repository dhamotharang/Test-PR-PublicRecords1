IMPORT $, doxie, iesp, Royalty;

out_rec := record(iesp.peoplereport.t_PeopleReportIndividual)
    dataset(Royalty.Layouts.Royalty) EmailV2Royalties;
end;

// accepts atmost one DID, actually
EXPORT out_rec FinderReport (
  dataset (doxie.layout_references) dids,
  $.IParam._finderreport mod_finder,
  boolean IsFCRA = false) := FUNCTION

  mod_access := PROJECT (mod_finder, doxie.IDataAccess);

  // DID should be atmost one (do we keep layout_references for legacyt reasons?)
  did := dids[1].did;
  // person records
  pers := $.person_records (dids, mod_access, PROJECT (mod_finder, $.IParam.personal), IsFCRA);

  p_addresses  := choosen (pers.SubjectAddressesSlim,  iesp.Constants.BR.MaxAddress);
  p_akas       := choosen (project(pers.Akas,iesp.bps_share.t_BpsReportIdentity),iesp.Constants.BR.MaxAKA);
  p_imposters  := choosen (pers.Imposters,  iesp.Constants.BR.MaxImposters);
  p_relatives  := choosen (pers.RelativesSlim (exists (Addresses)), iesp.constants.BR.MaxRelatives);
  p_associates := choosen (pers.AssociatesSlim(exists (Addresses)), iesp.constants.BR.MaxAssociates);
  p_neighbors  := choosen (pers.NeighborsSlim (exists (NeighborAddresses)), iesp.constants.BR.MaxNeighborhood);

  pplus := $.phonesplus_records (dids, PROJECT (mod_finder, $.IParam.phonesplus), IsFCRA);
  p_phonesplus_v2  := choosen (pplus.phonesplus_v2,  iesp.constants.BR.MaxPhonesPlus);
  old_phones := old_phones_records ();
  p_hist       := choosen (old_phones.oldphones, iesp.constants.BR.MaxPhonesHistorical);
  p_hist_2     := choosen (old_phones.oldphones_2, iesp.constants.BR.MaxPhonesHistorical);

  // "single source" person's data
  vehs := $.vehicle_records (dids, PROJECT (mod_finder, $.IParam.vehicles), IsFCRA).vehicles;
  p_vehicles   := choosen (vehs, iesp.Constants.BR.MaxVehicles);
  proflic := $.proflic_records (dids, PROJECT (mod_finder, $.IParam.proflic), IsFCRA);

  p_proflic    := choosen (proflic.proflicenses_v2, iesp.constants.BR.MaxProfLicenses);
  bankrpt := $.bankruptcy_records (dids, mod_access, PROJECT (mod_finder, $.IParam.bankruptcy, OPT), IsFCRA);
  p_bankruptcy := choosen (bankrpt.bankruptcy, iesp.Constants.BR.MaxBankruptcies);
  p_at_work    := choosen ($.peopleatwork_records (dids, PROJECT (mod_finder, $.IParam.peopleatwork, OPT), IsFCRA), iesp.Constants.BR.MaxPeopleAtWork);
  p_corp_aff   := choosen ($.corpaffiliation_records (dids, PROJECT (mod_finder, $.IParam.corpaffil), IsFCRA), iesp.Constants.BR.MaxCorpAffiliations);

  p_dlsr := choosen (pers.dlsr, 1);
  p_drivers    := choosen (pers.driver_licenses, iesp.Constants.BR.MaxDLs);
  emailsV2     := $.emailV2_records(dids, PROJECT (mod_finder, $.IParam.emails));
  p_emailsV2    := choosen (emailsV2.EmailV2Records, iesp.Constants.SMART.MaxEmails);
  // -----------------------------------------------------------------------
  // COUNTS (cannot use doxie.key_did_lookups_v2 -- not always in sync);
  // something similar to doxie.MAC_Add_WeAlsoFound can be used here,
  // but some particular data (Bankruptcy, for instance) are missing in doxie.MAC_Add_WeAlsoFound
  // TODO: All "counts" logic must be eventually moved to corresponding data attribute(s),
  // this service must not know anything about underlying data.
  // -----------------------------------------------------------------------
  cnt := $.counts (dids, mod_access, PROJECT (mod_finder, $.IParam.count_param, OPT), IsFCRA);

  // Combine all them together
  out_rec Format () := TRANSFORM
    Self.UniqueId := intformat (did, 12, 1);

    Self.HasBankruptcy := exists (p_bankruptcy);
    Self.HasProperty := cnt.property.exists;
    Self.HasCorporateAffiliation := exists (p_corp_aff);

    // also found
    Self.AlsoFound := IF (mod_finder.include_alsofound,
      ROW ({exists (p_at_work), exists (p_vehicles), exists (p_phonesplus_v2), exists (p_proflic), exists (p_dlsr)}, iesp.peoplereport.t_PeopleReportAlsoFound));

    Self.BpsReportAddresses2 := IF (mod_finder.include_bpsaddress, GLOBAL (p_addresses));
    Self.AKAs                := IF (mod_finder.include_akas, GLOBAL (p_akas));
    Self.Imposters           := IF (mod_finder.include_imposters, GLOBAL (p_imposters));
    Self.Relatives2          := IF (mod_finder.include_relatives, GLOBAL (p_relatives));
    Self.Associates2         := IF (mod_finder.include_associates, GLOBAL (p_associates));
    Self.Neighbors2          := IF (mod_finder.include_neighbors, GLOBAL (p_neighbors));

    Self.PhonesPluses       := IF (mod_finder.include_phonesplus, GLOBAL (p_phonesplus_v2));
    Self.OldPhones          := IF (mod_finder.include_oldphones, GLOBAL (p_hist));
    Self.OldPhones2         := IF (mod_finder.include_oldphones, GLOBAL (p_hist_2));

    Self.Vehicles           := IF (mod_finder.include_motorvehicles, GLOBAL (p_vehicles));
    Self.ProfessionalLicenses := IF (mod_finder.include_proflicenses, GLOBAL (p_proflic));
    Self.Bankruptcies       := IF (mod_finder.include_bankruptcy, GLOBAL (p_bankruptcy));
    Self.PeopleAtWorks      := IF (mod_finder.include_peopleatwork, GLOBAL (p_at_work));
    Self.DriverLicenses     := IF (mod_finder.include_driverslicenses, GLOBAL (p_drivers));
    Self.CorporateAffiliations := IF (mod_finder.include_corpaffiliations, GLOBAL (p_corp_aff));
    Self.Emails             := IF (mod_finder.include_email, GLOBAL (p_emailsV2));
    self.EmailV2Royalties   := IF (mod_finder.include_email, GLOBAL (emailsv2.EmailV2Royalties));
    END;

  // is supposed to produce one row only (usebestdid = true)
  individual := dataset ([Format ()]);

  return individual;
end;
