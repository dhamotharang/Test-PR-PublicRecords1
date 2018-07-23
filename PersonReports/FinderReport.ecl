IMPORT doxie, iesp, D2C;

out_rec := iesp.peoplereport.t_PeopleReportIndividual;

// accepts atmost one DID, actually
EXPORT out_rec FinderReport (
  dataset (doxie.layout_references) dids,
  PersonReports.input._finderreport param,
  boolean IsFCRA = false) := FUNCTION

  // DID should be atmost one (do we keep layout_references for legacyt reasons?)
  did := dids[1].did;
  isCNSMR := param.IndustryClass = D2C.Constants.Is_CNSMR;
  // person records 
  pers := Person_records (dids, module (project (param, input.personal, opt)) end, IsFCRA);

  p_addresses  := choosen (pers.SubjectAddressesSlim,  iesp.Constants.BR.MaxAddress);
  p_akas       := choosen (project(pers.Akas,iesp.bps_share.t_BpsReportIdentity),iesp.Constants.BR.MaxAKA);
  p_imposters  := choosen (pers.Imposters,  iesp.Constants.BR.MaxImposters);
  p_relatives  := choosen (pers.RelativesSlim (exists (Addresses)), iesp.constants.BR.MaxRelatives);
  p_associates := choosen (pers.AssociatesSlim(exists (Addresses)), iesp.constants.BR.MaxAssociates);
  p_neighbors  := choosen (pers.NeighborsSlim (exists (NeighborAddresses)), iesp.constants.BR.MaxNeighborhood);

  pplus := PersonReports.phonesplus_records (dids, module (project (param, input.phonesplus,  opt)) end, IsFCRA);
  p_phonesplus_v2  := choosen (pplus.phonesplus_v2,  iesp.constants.BR.MaxPhonesPlus);
  old_phones := old_phones_records ();
  p_hist       := choosen (old_phones.oldphones, iesp.constants.BR.MaxPhonesHistorical);
  p_hist_2     := choosen (old_phones.oldphones_2, iesp.constants.BR.MaxPhonesHistorical);

  // "single source" person's data
  vehs := if(~isCNSMR, vehicle_records (dids, module (project (param, input.vehicles)) end, IsFCRA).vehicles);
  p_vehicles   := choosen (vehs, iesp.Constants.BR.MaxVehicles);
  proflic := proflic_records (dids, module (project (param, input.proflic, opt)) end, IsFCRA);
  p_proflic    := choosen (proflic.proflicenses_v2, iesp.constants.BR.MaxProfLicenses);
  bankrpt := bankruptcy_records (dids, module (project (param, input.bankruptcy, opt)) end, IsFCRA);
  p_bankruptcy := choosen (bankrpt.bankruptcy, iesp.Constants.BR.MaxBankruptcies);
  p_at_work    := choosen (peopleatwork_records    (dids, module (project (param, input.peopleatwork, opt)) end, IsFCRA), iesp.Constants.BR.MaxPeopleAtWork);
  p_corp_aff   := choosen (corpaffiliation_records (dids, module (project (param, input.corpaffil)) end, IsFCRA), iesp.Constants.BR.MaxCorpAffiliations);

  p_dlsr := choosen (pers.dlsr, 1);
  p_drivers    := choosen (pers.driver_licenses, iesp.Constants.BR.MaxDLs);

  // -----------------------------------------------------------------------
  // COUNTS (cannot use doxie.key_did_lookups_v2 -- not always in sync);
  // something similar to doxie.MAC_Add_WeAlsoFound can be used here, 
  // but some particular data (Bankruptcy, for instance) are missing in doxie.MAC_Add_WeAlsoFound
  // TODO: All "counts" logic must be eventually moved to corresponding data attribute(s),
  // this service must not know anything about underlying data.
  // -----------------------------------------------------------------------
  cnt := counts (dids, project (param, input.count_param, opt), IsFCRA);

  // Combine all them together
  out_rec Format () := TRANSFORM
    Self.UniqueId := intformat (did, 12, 1);

    Self.HasBankruptcy := exists (p_bankruptcy);
    Self.HasProperty := cnt.property.exists;
    Self.HasCorporateAffiliation := exists (p_corp_aff);

    // also found
    Self.AlsoFound := IF (param.include_alsofound, 
      ROW ({exists (p_at_work), exists (p_vehicles), exists (p_phonesplus_v2), exists (p_proflic), exists (p_dlsr)}, iesp.peoplereport.t_PeopleReportAlsoFound));

    Self.BpsReportAddresses2 := IF (param.include_bpsaddress, GLOBAL (p_addresses));
    Self.AKAs                := IF (param.include_akas, GLOBAL (p_akas));
    Self.Imposters           := IF (param.include_imposters, GLOBAL (p_imposters));
    Self.Relatives2          := IF (param.include_relatives, GLOBAL (p_relatives));
    Self.Associates2         := IF (param.include_associates, GLOBAL (p_associates));
    Self.Neighbors2          := IF (param.include_neighbors, GLOBAL (p_neighbors));

    Self.PhonesPluses       := IF (param.include_phonesplus, GLOBAL (p_phonesplus_v2));
    Self.OldPhones          := IF (param.include_oldphones, GLOBAL (p_hist));
    Self.OldPhones2         := IF (param.include_oldphones, GLOBAL (p_hist_2));

    Self.Vehicles           := IF (param.include_motorvehicles, GLOBAL (p_vehicles));
    Self.ProfessionalLicenses := IF (param.include_proflicenses, GLOBAL (p_proflic));
    Self.Bankruptcies       := IF (param.include_bankruptcy, GLOBAL (p_bankruptcy));
    Self.PeopleAtWorks      := IF (param.include_peopleatwork, GLOBAL (p_at_work));
    Self.DriverLicenses     := IF (param.include_driverslicenses, GLOBAL (p_drivers));
    Self.CorporateAffiliations := IF (param.include_corpaffiliations, GLOBAL (p_corp_aff));
  END;

  // is supposed to produce one row only (usebestdid = true)
  individual := dataset ([Format ()]);
  
  return individual;
end;
