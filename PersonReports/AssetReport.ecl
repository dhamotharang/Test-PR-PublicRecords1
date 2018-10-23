IMPORT doxie, iesp,fcra, FFD, Gateway, PersonReports;

out_rec := personreports.layouts.CommonAssetReportIndividual;

// accepts atmost one DID, actually
EXPORT  AssetReport (
  dataset (doxie.layout_references) dids,
  PersonReports.input._assetreport param,
  boolean IsFCRA = false) := FUNCTION

 // DID should be atmost one (do we keep layout_references for legacy reasons?)
  did := dids[1].did;

  // Suppression/correction data (FCRA side only)
  ds_best := project(dids,transform(doxie.layout_best,self:=left,self:=[]));
  
  //FFD 
  boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(param.FFDOptionsMask);

  // we are using the subject DID rather than the Best DID 
  ds_dids := dataset([{FFD.Constants.SingleSearchAcctno,(unsigned)did}],FFD.Layouts.DidBatch);
  
  // Call the person context  and filter out consumer statements if they were not requested  
  pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, Gateway.Configuration.Get(),
                                               FFD.Constants.DataGroupSet.AssetReport, param.FFDOptionsMask));

  // Slim down the PersonContext         
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);  

  ds_flags := if (IsFCRA, FFD.GetFlagFile(ds_best, pc_recs));

  // person records 
  pers := PersonReports.Person_records (dids, module (project (param, PersonReports.input.personal, opt)) end, IsFCRA, ds_flags, slim_pc_recs(DataGroup = FFD.Constants.DataGroups.HDR));
  
   p_addresses  := choosen (pers.SubjectAddressesSlim,  iesp.Constants.BR.MaxAddress);
   p_akas       := project (choosen (pers.Akas, iesp.Constants.BR.MaxAKA), 
                             transform( personreports.layouts.CommonAssetReportIdentity,
                               self := left,
                               self := []
                                       )); // TODO change 
  p_imposters  := choosen (pers.Imposters,  iesp.Constants.BR.MaxImposters);
  p_relatives  := choosen (pers.Relatives,  iesp.constants.BR.MaxRelatives);
  p_associates := choosen (pers.Associates, iesp.constants.BR.MaxAssociates);

  pplus := PersonReports.phonesplus_records (dids, module (project (param, PersonReports.input.phonesplus, opt)) end, IsFCRA);
  p_phonesplus  := choosen (pplus.phonesplus,  iesp.constants.BR.MaxPhonesPlus);

  proflic := PersonReports.proflic_records (dids, module (project (param, PersonReports.input.proflic, opt)) end, IsFCRA);
  p_proflic     := choosen (proflic.proflicenses_v2, iesp.constants.BR.MaxProfLicenses);
  
  pilots := PersonReports.faacert_records (dids, module (project (param, PersonReports.input.faacerts)) end, IsFCRA, ds_flags, 
                                          slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Pilot));
  p_faa_cert    := choosen (pilots.assetreport_view, iesp.constants.BR.MaxFaaCertificates);

  //asset data
  vehs := PersonReports.vehicle_records (dids, module (project (param, PersonReports.input.vehicles)) end, IsFCRA);
  p_vehicles    := choosen (vehs.vehicles, iesp.Constants.BR.MaxVehicles);
  
  uccs := PersonReports.ucc_records (dids, module (project (param, PersonReports.input.ucc)) end, IsFCRA);
  p_uccs        := choosen (uccs.ucc_v2, iesp.Constants.BR.MaxUCCFilings);

  p_watercrafts := choosen (PersonReports.watercraft_records(dids, module (project (param, PersonReports.input.watercrafts))       end, IsFCRA,true,ds_flags, 
                          slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Watercraft)
                                     ).wtr_recs, iesp.Constants.BR.MaxWatercrafts);
                                     
  p_assessments := choosen (PersonReports.property_records(dids, module (project (param, PersonReports.input.property)) end, IsFCRA, ds_flags, 
                          slim_pc_recs(DataGroup IN [FFD.Constants.DataGroups.ASSESSMENT,
                                                   FFD.Constants.DataGroups.PROPERTY_SEARCH]
                                     )).prop_assessments, iesp.Constants.BR.MaxAssessments);
  p_deeds       := choosen (PersonReports.property_records(dids, module (project (param, PersonReports.input.property)) end, IsFCRA, ds_flags, 
                          slim_pc_recs(DataGroup IN [FFD.Constants.DataGroups.DEED,
                                                   FFD.Constants.DataGroups.PROPERTY_SEARCH]
                                     )).prop_deeds_all, iesp.Constants.BR.MaxDeeds);
                                     
  p_aircrafts   := choosen (PersonReports.aircraft_records(dids, module (project (param, PersonReports.input.aircrafts)) end, IsFCRA, ds_flags, 
                          slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Aircraft
                                     )), iesp.Constants.BR.MaxAircrafts);
  p_paw         := choosen (PersonReports.peopleatwork_records(dids, module (project (param, PersonReports.input.peopleatwork, opt)) end, IsFCRA), iesp.Constants.BR.MaxPeopleAtWork);

  // -----------------------------------------------------------------------
  // COUNTS (cannot use doxie.key_did_lookups_v2 -- not always in sync);
  // something similar to doxie.MAC_Add_WeAlsoFound can be used here, 
  // but some particular data (Bankruptcy, for instance) are missing in doxie.MAC_Add_WeAlsoFound
  // TODO: All "counts" logic must be eventually moved to corresponding data attribute(s),
  // this service must not know anything about underlying data.
  // -----------------------------------------------------------------------

  bankrpt := PersonReports.bankruptcy_records (dids, module (project (param, PersonReports.input.bankruptcy, opt)) end, 
                                              IsFCRA, ds_flags, param.non_subject_suppression, 
                                              slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Bankruptcy));
  
  cnt := PersonReports.Counts(dids, project (param, PersonReports.input.count_param), IsFCRA);
  
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
    Self.AlsoFound := IF (param.Include_AlsoFound, 
      ROW ({exists (p_relatives), exists (p_associates), exists (p_phonesplus), exists (p_proflic), 
            exists (p_dlsr), exists (p_paw)}, iesp.assetreport.t_AssetReportAlsoFound));

    Self.Relatives          := IF (param.include_relatives, p_relatives);
    Self.Associates         := IF (param.include_associates, p_associates);
    Self.PhonesPluses       := IF (param.include_phonesplus, p_phonesplus);
    Self.ProfessionalLicenses := IF (param.include_proflicenses, p_proflic);
      
    Self.Aircrafts          := IF (param.include_faaaircrafts, p_aircrafts);
    Self.Vehicles           := IF (param.include_motorvehicles, p_vehicles);
    Self.UCCFilings         := IF (param.include_uccfilings, p_uccs);
    Self.Imposters          := IF (param.include_imposters, p_imposters);
    Self.AKAs               := IF (param.include_akas, p_akas);
    Self.BpsReportAddresses2 := IF (param.include_bpsaddress, p_addresses);
    Self.FAACertifications  := IF (param.include_faacertificates, p_faa_cert);
    Self.WaterCrafts        := IF (param.include_watercrafts, p_watercrafts);
    Self.AssessRecords      := IF (param.include_properties, p_assessments);
    Self.DeedRecords        := IF (param.include_properties, p_deeds);
    Self.PeopleAtWorks      := IF (param.include_peopleatwork, p_paw);
    SELF := [];
  END;

  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, param.FCRAPurpose, param.FFDOptionsMask)[1];
  suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;

  // is supposed to produce one row only (usebestdid = true)
  individual_results := dataset ([Format ()]);
  individual := if(suppress_results_due_alerts, dataset ([], out_rec), individual_results);
   
  consumer_statements := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);

  consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, param.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);

  FFD.MAC.PrepareResultRecord(individual, individual_combined, consumer_statements, consumer_alerts, 
                             out_rec);
  
/*    FFD
      output(slim_pc_recs,named('slim_pc_recs'));
      output(p_aircrafts,named('Aircrafts'));
      output(p_akas,named('AKAs'));
      output(p_faa_cert,named('FAACertifications'));
      output(p_watercrafts,named('WaterCrafts'));
      output(p_assessments,named('AssessRecords'));
      output(p_deeds,named('DeedRecords'));
      
     
     output(ShowConsumerStatements,named('AR_ShowConsumerStatements'));
*/

  return individual_combined;
end;
