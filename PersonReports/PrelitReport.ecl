﻿IMPORT $, doxie, iesp, FCRA, FFD, Gateway, PersonReports;

// returns extended structure to allow for different versions of data.
out_rec := personreports.layouts.CommonPreLitigationReportIndividual;

// accepts atmost one DID, actually
EXPORT PrelitReport (
  dataset (doxie.layout_references) dids,
  PersonReports.IParam._prelitreport mod_prelit,
  boolean IsFCRA = false) := FUNCTION

  //Convert to the old _report style module: $.input._prelitreport
  mod_access := PROJECT (mod_prelit, doxie.IDataAccess);
  param := MODULE (PROJECT (mod_prelit, $.IParam.old_prelitreport))
    $.input.mac_copy_report_fields(mod_prelit);
  END;

  // DID should be atmost one (do we keep layout_references for legacyt reasons?)
  did := dids[1].did;

  // Suppression/correction data (FCRA side only)
  ds_best := project(dids,transform(doxie.layout_best,self:=left,self:=[]));
  
  //FFD 
  boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(mod_prelit.FFDOptionsMask);
  gateways := Gateway.Configuration.Get();
  
  // 1) we are using the subject DID rather than the Best DID 
  ds_dids := dataset([{FFD.Constants.SingleSearchAcctno,(unsigned)did}],FFD.Layouts.DidBatch);
  
  // 2) Call the person context    
  pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, gateways, FFD.Constants.DataGroupSet.PrelitReport, mod_prelit.FFDOptionsMask));

  // 3) Slim down the PersonContext         
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);  
  
  ds_flags := if (IsFCRA, FFD.GetFlagFile (ds_best, pc_recs));

  // person records 
  pers := PersonReports.Person_records (dids, mod_access,
                                        PROJECT (mod_prelit, PersonReports.IParam.personal, OPT),
                                        IsFCRA,
                                        ds_flags, 
                                        slim_pc_recs(DataGroup = FFD.Constants.DataGroups.HDR));

  p_addresses   := choosen (pers.SubjectAddressesSlim,  iesp.Constants.BR.MaxAddress);

  // prelit uses DL version v2
  //iesp.bps_share.t_BpsReportIdentity SwitchDL (iesp.bps_share.t_BpsReportIdentity L, integer C) := transform
  personreports.layouts.CommonPreLitigationReportIdentity SwitchDL (personreports.layouts.CommonPreLitigationReportIdentity L, integer C) := transform
    Self.DriverLicenses2 := if (C = 1, pers.driver_licenses_v2, dataset ([], iesp.driverlicense2.t_DLEmbeddedReport2Record));
    Self.DriverLicenses := [];
    Self := L;
    Self := [];
  end;
  p_akas        := project (choosen (pers.Akas, iesp.Constants.BR.MaxAKA), SwitchDL (Left, Counter));
  p_imposters   := choosen (pers.Imposters,  iesp.Constants.BR.MaxImposters);
  p_relatives   := choosen (pers.RelativesSlim,  iesp.constants.BR.MaxRelatives);
  p_associates  := choosen (pers.AssociatesSlim, iesp.constants.BR.MaxAssociates);
  
  pplus := PersonReports.phonesplus_records(dids, PROJECT (mod_prelit, $.IParam.phonesplus, OPT), IsFCRA);
  p_phonesplus  := choosen (pplus.phonesplus,  iesp.constants.BR.MaxPhonesPlus);

  proflic := PersonReports.proflic_records(dids, PROJECT(mod_prelit, $.IParam.proflic), IsFCRA);
  p_proflic     := choosen (proflic.proflicenses_v2, iesp.constants.BR.MaxProfLicenses);

  bankrpt := PersonReports.bankruptcy_records(dids,
                                              mod_access, 
                                              PROJECT(mod_prelit, $.IParam.bankruptcy),
                                              IsFCRA, 
                                              ds_flags, 
                                              mod_prelit.non_subject_suppression, 
                                              slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Bankruptcy));
                                                                      
  p_bankruptcy_v1  := if (mod_prelit.bankruptcy_version = 1, choosen (bankrpt.bankruptcy, iesp.Constants.BR.MaxBankruptcies));
  p_bankruptcy_v3  := if (mod_prelit.bankruptcy_version = 3, choosen (bankrpt.bankruptcy_v3, iesp.Constants.BR.MaxBankruptcies));

  p_liens := PersonReports.lienjudgment_records (dids, 
                                                module (project (param, PersonReports.input.liens, opt)) end, 
                                                IsFCRA, 
                                                ds_flags, 
                                                slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Liens));

  p_liens_v1    := if (mod_prelit.liensjudgments_version = 1, choosen (p_liens.liensjudgment, iesp.Constants.BR.MaxLiensJudgments));
  p_liens_v2    := if (mod_prelit.liensjudgments_version = 2, choosen (p_liens.liensjudgment_v2, iesp.Constants.BR.MaxLiensJudgments));

  // asset data
  p_assessments := choosen(PersonReports.property_records(dids,
                                                          mod_access ,
                                                          PROJECT(mod_prelit, $.IParam.property), 
                                                          IsFCRA, ds_flags, 
                                                          slim_pc_recs(DataGroup IN [FFD.Constants.DataGroups.ASSESSMENT,
                                                                        FFD.Constants.DataGroups.PROPERTY_SEARCH]
                            )).prop_assessments, iesp.Constants.BR.MaxAssessments);
                            
  p_deeds := choosen(PersonReports.property_records(dids, 
                                                    mod_access ,
                                                    PROJECT(mod_prelit, $.IParam.property), 
                                                    IsFCRA, 
                                                    ds_flags, 
                                                    slim_pc_recs(DataGroup IN [FFD.Constants.DataGroups.DEED,
                                                                  FFD.Constants.DataGroups.PROPERTY_SEARCH]
                      )).prop_deeds_all, iesp.Constants.BR.MaxDeeds);

  uccs := PersonReports.ucc_records(dids, module (project (param, PersonReports.input.ucc, opt)) end, IsFCRA);
  p_uccs        := choosen (uccs.ucc_v2, iesp.Constants.BR.MaxUCCFilings);

  vehs := PersonReports.vehicle_records(dids, module (project (param, input.vehicles)) end, IsFCRA);
  p_vehicles    := choosen (vehs.vehicles, iesp.Constants.BR.MaxVehicles);

  p_watercrafts := choosen(PersonReports.watercraft_records(dids, 
                          module (project (param, PersonReports.input.watercrafts)) end, 
                          IsFCRA,
                          true,
                          ds_flags, 
                          slim_pc_recs(DataGroup IN FFD.Constants.DataGroupSet.Watercraft
                          )).wtr_recs, iesp.Constants.BR.MaxWatercrafts);

  p_at_work     := choosen (PersonReports.peopleatwork_records (dids, PROJECT (mod_prelit, $.IParam.peopleatwork, OPT), IsFCRA), iesp.Constants.BR.MaxPeopleAtWork);

  // -----------------------------------------------------------------------
  // COUNTS (cannot use doxie.key_did_lookups_v2 -- not always in sync);
  // something similar to doxie.MAC_Add_WeAlsoFound can be used here, 
  // but some particular data (Bankruptcy, for instance) are missing in doxie.MAC_Add_WeAlsoFound
  // TODO: All "counts" logic must be eventually moved to corresponding data attribute(s),
  // this service must not know anything about underlying data.
  // -----------------------------------------------------------------------
  cnt := PersonReports.counts (dids, mod_access, PROJECT(mod_prelit, $.IParam.count_param), IsFCRA, ds_flags);
  // special patch for DL:
  p_dlsr := choosen (pers.dlsr, 1);


  // Combine all them together
  out_rec Format () := TRANSFORM
    Self.UniqueId := intformat (did, 12, 1);
    Self.Probability := ''; //?

    Self.HasBankruptcy := (~IsFCRA and exists (p_bankruptcy_v1)) or (IsFCRA and exists (p_bankruptcy_v3));
    Self.HasProperty := exists (p_deeds) or exists (p_assessments);
    //TODO:
    Self.HasCorporateAffiliation := cnt.corp.exists; 

    // also found
    Self.AlsoFound := IF (mod_prelit.include_alsofound, 
      ROW ({exists (p_relatives), exists (p_associates), exists (p_phonesplus), exists (p_dlsr)}, iesp.prelitigationreport.t_PrelitigationReportAlsoFound));

    Self.Relatives          := IF (mod_prelit.include_relatives,  p_relatives);
    Self.Associates         := IF (mod_prelit.include_associates, p_associates);
    Self.PhonesPluses       := IF (mod_prelit.include_phonesplus, p_phonesplus);

    Self.Vehicles           := IF (mod_prelit.include_motorvehicles, p_vehicles);
    Self.UCCFilings         := IF (mod_prelit.include_uccfilings, p_uccs);
    Self.Imposters          := IF (mod_prelit.include_imposters, p_imposters);
    Self.AKAs               := IF (mod_prelit.include_akas, p_akas);
    Self.BpsReportAddresses2 := IF (mod_prelit.include_bpsaddress, p_addresses);

    Self.WaterCrafts        := IF (mod_prelit.include_watercrafts, p_watercrafts);
    Self.AssessRecords      := IF (mod_prelit.include_properties, p_assessments);
    Self.DeedRecords        := IF (mod_prelit.include_properties, p_deeds);
    Self.Bankruptcies       := IF (mod_prelit.include_bankruptcy, p_bankruptcy_v1);
    Self.Bankruptcies3      := IF (mod_prelit.include_bankruptcy, p_bankruptcy_v3);
    Self.PeopleAtWorks      := IF (mod_prelit.include_peopleatwork, p_at_work);
    Self.ProfessionalLicenses := IF (mod_prelit.include_proflicenses, p_proflic);
    Self.LiensJudgments     := IF (mod_prelit.include_liensjudgments, p_liens_v1);
    Self.LiensJudgments2    := IF (mod_prelit.include_liensjudgments, p_liens_v2);
  END;

  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, mod_prelit.FCRAPurpose, mod_prelit.FFDOptionsMask)[1];
  suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;

  // is supposed to produce one row only (usebestdid = true)
  individual_results := dataset ([Format ()]);
  individual := if(suppress_results_due_alerts, dataset ([], out_rec), individual_results);

  consumer_statements := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
  consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, mod_prelit.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
  FFD.MAC.PrepareResultRecord(individual, individual_combined, consumer_statements, consumer_alerts, 
                             out_rec);
  
/*         output(pc_recs,named('pc_recs'));
           output(ShowConsumerStatements,named('ShowConsumerStatements'));
           output(p_liens_v2 ,named('LiensJudgments2'));
           output(p_bankruptcy_v3 ,named('Bankruptcies3'));
           output(p_watercrafts,named('WaterCrafts'));
           output(p_assessments,named('AssessRecords'));
           output(p_deeds,named('DeedRecords'));
           output(p_akas,named('AKAs'));
*/


  
  return individual_combined;

end;
