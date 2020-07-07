IMPORT $, doxie, iesp, FFD, Gateway, PersonReports;

out_rec := personreports.layouts.CommonAssetReportIndividual;

// accepts atmost one DID, actually
EXPORT AssetReport (
  dataset (doxie.layout_references) dids,
  $.IParam._assetreport mod_asset,
  boolean IsFCRA = false) := FUNCTION

  mod_access := PROJECT (mod_asset, doxie.IDataAccess);

  // DID should be atmost one (do we keep layout_references for legacy reasons?)
  did := dids[1].did;

  // Suppression/correction data (FCRA side only)
  ds_best := project(dids,transform(doxie.layout_best,self:=left,self:=[]));
  
  //FFD 
  boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(mod_asset.FFDOptionsMask);

  // we are using the subject DID rather than the Best DID 
  ds_dids := dataset([{FFD.Constants.SingleSearchAcctno,(unsigned)did}],FFD.Layouts.DidBatch);
  
  // Call the person context  and filter out consumer statements if they were not requested  
  pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, Gateway.Configuration.Get(),
                                               FFD.Constants.DataGroupSet.AssetReport, mod_asset.FFDOptionsMask));

  // Slim down the PersonContext         
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);  

  ds_flags := if (IsFCRA, FFD.GetFlagFile(ds_best, pc_recs));

  // person records 
  pers := PersonReports.Person_records (dids, mod_access, PROJECT (mod_asset, $.IParam.personal, OPT), IsFCRA, ds_flags, slim_pc_recs(DataGroup = FFD.Constants.DataGroups.HDR));
  
   p_addresses  := choosen (pers.SubjectAddressesSlim,  iesp.Constants.BR.MaxAddress);
   p_akas       := project (choosen (pers.Akas, iesp.Constants.BR.MaxAKA), 
                             transform( personreports.layouts.CommonAssetReportIdentity,
                               self := left,
                               self := []
                                       )); // TODO change 
  p_imposters  := choosen (pers.Imposters,  iesp.Constants.BR.MaxImposters);
  p_relatives  := choosen (pers.Relatives,  iesp.constants.BR.MaxRelatives);
  p_associates := choosen (pers.Associates, iesp.constants.BR.MaxAssociates);

  pplus := PersonReports.phonesplus_records (dids, PROJECT (mod_asset, $.IParam.phonesplus, OPT), IsFCRA);
  p_phonesplus  := choosen (pplus.phonesplus,  iesp.constants.BR.MaxPhonesPlus);

  proflic := PersonReports.proflic_records (dids, PROJECT (mod_asset, $.IParam.proflic), IsFCRA);
  p_proflic     := choosen (proflic.proflicenses_v2, iesp.constants.BR.MaxProfLicenses);
  
  pilots := PersonReports.faacert_records (dids, PROJECT (mod_asset, $.IParam.faacerts), IsFCRA, ds_flags, 
                                          slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Pilot));
  p_faa_cert    := choosen (pilots.assetreport_view, iesp.constants.BR.MaxFaaCertificates);

  //asset data
  vehs := PersonReports.vehicle_records (dids, PROJECT (mod_asset, $.IParam.vehicles), IsFCRA);
  p_vehicles    := choosen (vehs.vehicles, iesp.Constants.BR.MaxVehicles);
  
  uccs := PersonReports.ucc_records (dids, PROJECT (mod_asset, $.IParam.ucc), IsFCRA);
  p_uccs        := choosen (uccs.ucc_v2, iesp.Constants.BR.MaxUCCFilings);

  p_watercrafts := choosen (PersonReports.watercraft_records(dids, PROJECT (mod_asset, $.IParam.watercrafts), IsFCRA,true,ds_flags, 
                          slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Watercraft)
                                     ).wtr_recs, iesp.Constants.BR.MaxWatercrafts);
                                     
  p_assessments := choosen (PersonReports.property_records(dids, mod_access, PROJECT (mod_asset, $.IParam.property), IsFCRA, ds_flags, 
                          slim_pc_recs(DataGroup IN [FFD.Constants.DataGroups.ASSESSMENT,
                                                   FFD.Constants.DataGroups.PROPERTY_SEARCH]
                                     )).prop_assessments, iesp.Constants.BR.MaxAssessments);
  p_deeds       := choosen (PersonReports.property_records(dids, mod_access, PROJECT (mod_asset, $.IParam.property), IsFCRA, ds_flags, 
                          slim_pc_recs(DataGroup IN [FFD.Constants.DataGroups.DEED,
                                                   FFD.Constants.DataGroups.PROPERTY_SEARCH]
                                     )).prop_deeds_all, iesp.Constants.BR.MaxDeeds);
                                     
  p_aircrafts   := choosen (PersonReports.aircraft_records(dids, PROJECT (mod_asset, $.IParam.aircrafts), IsFCRA, ds_flags, 
                          slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Aircraft
                                     )), iesp.Constants.BR.MaxAircrafts);

  
  p_paw         := choosen (PersonReports.peopleatwork_records(dids, PROJECT (mod_asset, $.IParam.peopleatwork), IsFCRA), iesp.Constants.BR.MaxPeopleAtWork);
  
 
  // -----------------------------------------------------------------------
  // COUNTS (cannot use doxie.key_did_lookups_v2 -- not always in sync);
  // something similar to doxie.MAC_Add_WeAlsoFound can be used here, 
  // but some particular data (Bankruptcy, for instance) are missing in doxie.MAC_Add_WeAlsoFound
  // TODO: All "counts" logic must be eventually moved to corresponding data attribute(s),
  // this service must not know anything about underlying data.
  // -----------------------------------------------------------------------

  bankrpt := PersonReports.bankruptcy_records (dids, mod_access, PROJECT (mod_asset, $.IParam.bankruptcy), 
                                              IsFCRA, ds_flags, mod_asset.non_subject_suppression, 
                                              slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Bankruptcy));
  
  cnt := PersonReports.Counts(dids, mod_access, PROJECT (mod_asset, $.IParam.count_param), IsFCRA);
  
  // special patch for DL:
  p_dlsr := choosen (pers.dlsr, 1);

  // Combine all them together
  out_rec Format () := TRANSFORM
    Self.UniqueId := intformat (did, 12, 1);
    Self.Probability := ''; //?
    Self.HasBankruptcy := if (isFCRA, exists(bankrpt.bankruptcy_v3), cnt.bankruptcy.exists);
    Self.HasProperty := exists (p_deeds) or  exists (p_assessments);

    Self.HasCorporateAffiliation := cnt.corp.exists;

    // also found
    Self.AlsoFound := IF (mod_asset.Include_AlsoFound, 
      ROW ({exists (p_relatives), exists (p_associates), exists (p_phonesplus), exists (p_proflic), 
            exists (p_dlsr), exists (p_paw)}, iesp.assetreport.t_AssetReportAlsoFound));

    Self.Relatives          := IF (mod_asset.include_relatives, p_relatives);
    Self.Associates         := IF (mod_asset.include_associates, p_associates);
    Self.PhonesPluses       := IF (mod_asset.include_phonesplus, p_phonesplus);
    Self.ProfessionalLicenses := IF (mod_asset.include_proflicenses, p_proflic);
      
    Self.Aircrafts          := IF (mod_asset.include_faaaircrafts, p_aircrafts);
    Self.Vehicles           := IF (mod_asset.include_motorvehicles, p_vehicles);
    Self.UCCFilings         := IF (mod_asset.include_uccfilings, p_uccs);
    Self.Imposters          := IF (mod_asset.include_imposters, p_imposters);
    Self.AKAs               := IF (mod_asset.include_akas, p_akas);
    Self.BpsReportAddresses2 := IF (mod_asset.include_bpsaddress, p_addresses);
    Self.FAACertifications  := IF (mod_asset.include_faacertificates, p_faa_cert);
    Self.WaterCrafts        := IF (mod_asset.include_watercrafts, p_watercrafts);
    Self.AssessRecords      := IF (mod_asset.include_properties, p_assessments);
    Self.DeedRecords        := IF (mod_asset.include_properties, p_deeds);
    Self.PeopleAtWorks      := IF (mod_asset.include_peopleatwork, p_paw);
    SELF := [];
  END;

  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, mod_asset.FCRAPurpose, mod_asset.FFDOptionsMask)[1];
  suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;

  // is supposed to produce one row only (usebestdid = true)
  individual_results := dataset ([Format ()]);
  individual := if(suppress_results_due_alerts, dataset ([], out_rec), individual_results);
   
  consumer_statements := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);

  consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, mod_asset.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);

  FFD.MAC.PrepareResultRecord(individual, individual_combined, consumer_statements, consumer_alerts, 
                             out_rec);
  
  return individual_combined;
end;
