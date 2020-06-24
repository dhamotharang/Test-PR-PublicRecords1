IMPORT doxie, Models, Residency_Services, Royalty;

EXPORT BatchRecords(DATASET(Residency_Services.Layouts.Batch_in) ds_batch_in,
                    Residency_Services.IParam.BatchParams mod_params_in,
                    BOOLEAN DEBUGMODEL = FALSE
                   ) := FUNCTION

  ds_BestInfo := Residency_Services.fn_getBestInfo(ds_batch_in, mod_params_in);

  // If the input criteria did not result in an entity/person/did being found,
  // then pull those records out now and we will add them back in later.
  ds_BestInfo_ids_found    := ds_BestInfo(Entity_NotFound  = 'N');
  ds_batch_in_ids_notfound := ds_BestInfo(Entity_NotFound != 'N');

  // Note: the requirements say to get the "Best" address plus the "top 3", but to get the top 3
  // we really have to get the top 4 because there is a really good chance that the "best" address
  // would be in the top 3 if we only got 3.  Hence we really need to get the top 4.
  ds_Top4Addrs    := Residency_Services.fn_getTop4Addrs(ds_BestInfo_ids_found);

  ds_DedupedAddrs := Residency_Services.Functions.DedupeAddrs(ds_BestInfo_ids_found,
                                                              ds_Top4Addrs,
                                                              ds_batch_in);

  // Project all of the deduped top 4 addrs unto the layout needed in most of the functions below.
  // Then sort/dedup to 1 unique did per acctno.
  // NOTE: should already only be 1 did per acctno; the did first obtained in fn_getBestInfo.
  //       But just to be safe sort by acctno and descending did (to put any non-zero ones first).
  ds_ddaddrs_acctno_did_psd := DEDUP(SORT(PROJECT(ds_DedupedAddrs, doxie.layout_references_acctno),
                                          acctno, -did),
                                     acctno);

  // Get records for individual sources, using deduped acctno/did ds from above
  DL_Recs       := Residency_Services.fn_getDL(ds_ddaddrs_acctno_did_psd);
  PL_recs       := Residency_Services.fn_getPL(ds_ddaddrs_acctno_did_psd, mod_params_in);
  HF_recs       := Residency_Services.fn_getHuntFish(ds_ddaddrs_acctno_did_psd, mod_params_in);
  Util_recs     := Residency_Services.fn_getUtil(ds_ddaddrs_acctno_did_psd, mod_params_in);
  Wcraft_recs   := Residency_Services.fn_getWC(ds_ddaddrs_acctno_did_psd, mod_params_in);
  Aircraft_recs := Residency_Services.fn_getAircraft(ds_ddaddrs_acctno_did_psd, mod_params_in);
  BK_recs       := Residency_Services.fn_getBankruptcy(ds_ddaddrs_acctno_did_psd);
  LJ_recs       := Residency_Services.fn_getLJ(ds_ddaddrs_acctno_did_psd, mod_params_in);
  Fclosure_recs := Residency_Services.fn_getForeclosure(ds_ddaddrs_acctno_did_psd, mod_params_in);
  PAW_recs      := Residency_Services.fn_getPAW(ds_ddaddrs_acctno_did_psd, mod_params_in);
  Voter_Recs    := Residency_Services.fn_getVoters(ds_ddaddrs_acctno_did_psd, mod_params_in);
  PPlus_recs    := Residency_Services.fn_getPhonesPlus(ds_ddaddrs_acctno_did_psd, mod_params_in);

  // These functions need more than just acctno & did, so use all deduped addrs
  Prop_recs     := Residency_Services.fn_getProperty(ds_DedupedAddrs);
  Veh_recs      := Residency_Services.fn_getVehicles(ds_DedupedAddrs, mod_params_in);
  BIPrecs 			:= Residency_Services.fn_getBIP(ds_DedupedAddrs);

  // Determine source counts
  Residency_Services.Functions.mac_getCountsExpired(Dl_Recs, DLCounts, ds_DedupedAddrs, DL_in_cnt, DL_out_cnt, DL_in_expired_flag, DL_out_expired_flag, DL_in_dt,DL_out_dt);
  Residency_Services.Functions.mac_getCounts(PL_recs, PLCounts, DLCounts, ProfLic_in_cnt, ProfLic_out_cnt);
  Residency_Services.Functions.mac_getCounts(HF_recs, HFCounts, PLCounts, HuntFish_in_cnt, HuntFish_out_cnt);
  Residency_Services.Functions.mac_getCounts(Util_recs, UtilCounts, HFCounts, Utility_in_cnt, Utility_out_cnt);
  proprecsforcounts := PROJECT(Prop_recs,TRANSFORM(Residency_Services.Layouts.Int_Service_OUTPUT, SELF :=LEFT));
  Residency_Services.Functions.mac_getCounts(proprecsforcounts, PropCounts, UtilCounts, Property_in_cnt, Property_out_cnt);
  HomesteadCounts := Residency_Services.fn_getPropertyCounts(Prop_recs, PropCounts);
  Residency_Services.Functions.mac_getCountsExpired(Wcraft_recs, WcraftCounts, HomesteadCounts, Watercraft_in_cnt, Watercraft_out_cnt, Watercraft_in_expired_flag, Watercraft_out_expired_flag, Watercraft_in_dt,Watercraft_out_dt);
  Residency_Services.Functions.mac_getCounts(Aircraft_recs, AircraftCounts, WcraftCounts, Aircraft_in_cnt, Aircraft_out_cnt);
  Residency_Services.Functions.mac_getCounts(BK_recs, BKCounts, AircraftCounts, Bankruptcy_in_cnt, Bankruptcy_out_cnt);
  Residency_Services.Functions.mac_getCounts(LJ_recs, LJCounts, BKCounts, LienJudg_in_cnt, LienJudg_out_cnt);
  Residency_Services.Functions.mac_getCounts(Fclosure_recs, FclosureCounts, LJCounts, Foreclosure_in_cnt, Foreclosure_out_cnt);
  Residency_Services.Functions.mac_getCounts(PAW_recs, PAWCounts, FclosureCounts, PAW_in_cnt, PAW_out_cnt);
  Residency_Services.Functions.mac_getCountsExpired(Voter_Recs, VoterCounts, PAWCounts, Voter_in_cnt, voter_out_cnt, Voter_in_expired_flag, Voter_out_expired_flag, Voter_in_last,Voter_out_last);
  Residency_Services.Functions.mac_getCounts(PPlus_recs, PPlusCounts, VoterCounts, Phone_in_cnt, Phone_out_cnt);
  VehCounts := Residency_Services.fn_getCountsbyAddr(Veh_recs.Results, PPlusCounts);
  Residency_Services.Functions.mac_getCounts(BIPrecs, BIPcounts, VehCounts, Business_in_cnt, Business_out_cnt);
  VOOrecs := Residency_Services.fn_getVOO(BIPcounts, mod_params_in);
  IIDrecs := Residency_Services.fn_getIID(VOOrecs, mod_params_in);

  // join/transform ds of batch input to ds out of fn_getIID to attach original input
  // address fields (re-named as batch_in_*) as needed by the model.
  Residency_Services.Layouts.Model_in_Layout tf_preptomodel (ds_batch_in L,
                                                             IIDrecs R ) := TRANSFORM
    // Set these special input address fields first, due to input address field names
    // conflicting with address field names going into model.
    SELF.batch_in_prim_range  := L.prim_range;
    SELF.batch_in_predir      := L.predir;
    SELF.batch_in_prim_name   := L.prim_name;
    SELF.batch_in_addr_suffix := L.addr_suffix;
    SELF.batch_in_postdir     := L.postdir;
    SELF.batch_in_unit_desig  := L.unit_desig;
    SELF.batch_in_sec_range   := L.sec_range;
    SELF.batch_in_p_city_name := L.p_city_name;
    SELF.batch_in_st          := L.st;
    SELF.batch_in_z5          := L.z5;
    SELF.batch_in_zip4        := L.zip4;
    SELF.batch_in_county_name := L.county_name;
    // Next set the best/top3 addresses fields names going into model
    SELF.prim_range  := R.prim_range;
    SELF.predir      := R.predir;
    SELF.prim_name   := R.prim_name;
    SELF.addr_suffix := R.addr_suffix;
    SELF.postdir     := R.postdir;
    SELF.unit_desig  := R.unit_desig;
    SELF.sec_range   := R.sec_range;
    SELF.p_city_name := R.p_city_name;
    SELF.st          := R.st;
    SELF.z5          := R.z5;
    SELF.zip4        := R.zip4;
    SELF.county_name := R.county_name;
    SELF := L;  // all other Left/batch_in fields
    SELF := R;  // all other Right/Model_in_Layout fields
  END;

  ds_batchtomodel_all :=  JOIN(ds_batch_in, IIDrecs,
                                 LEFT.acctno =RIGHT.acctno,
                               tf_preptomodel(LEFT,RIGHT),
                               LEFT OUTER // will include any passed in ds_batch_in recs even if
                                          // they did not resolve to an identity;
                                          // so filter them out below before inputting to model
                              );

  // Pass recs where the entity/identity was found into the modelling ECL function
  // Alias ds name to assist in model debugging/output
  ds_batch_into_model := ds_batchtomodel_all(Entity_NotFound = 'N'); // chg join above & remove filter???

  ds_out_of_model := Models.RA1607_0_1(ds_batch_into_model, DEBUGMODEL);

  // In case special debug model is used, sort/dedup to only keep the 1 record per acctno with
  // the highest "total_pts" field value because the model in "debug" mode will return more than
  // 1 rec per acctno and we want to mimic the dedup/sort coding in the model.
  ds_out_of_model_db_dd := DEDUP(SORT(ds_out_of_model,acctno,-total_pts), acctno);

  ds_out_of_model_1_rec := IF(DEBUGMODEL,ds_out_of_model_db_dd, ds_out_of_model);

  // Project ds of ids not found onto the model out layout so it can be combined below
  ds_ids_nf_in_model_out := PROJECT(ds_batch_in_ids_notfound,
                                    TRANSFORM(Models.Layout_Residency_Batch.Layout_Debug,
                                      // Set these first, due to input address field names
                                      // conflicting with address field names going into model.
                                      SELF.batch_in_prim_range  := LEFT.prim_range;
                                      SELF.batch_in_predir      := LEFT.predir;
                                      SELF.batch_in_prim_name   := LEFT.prim_name;
                                      SELF.batch_in_addr_suffix := LEFT.addr_suffix;
                                      SELF.batch_in_postdir     := LEFT.postdir;
                                      SELF.batch_in_unit_desig  := LEFT.unit_desig;
                                      SELF.batch_in_sec_range   := LEFT.sec_range;
                                      SELF.batch_in_p_city_name := LEFT.p_city_name;
                                      SELF.batch_in_st          := LEFT.st;
                                      SELF.batch_in_z5          := LEFT.z5;
                                      SELF.batch_in_zip4        := LEFT.zip4;
                                      SELF.batch_in_county_name := LEFT.county_name;
                                      SELF.RB_score    := 0; // set to 0 since id not found
                                      SELF := LEFT;
                                      SELF := [];
                                   ));

  ds_ids_nf_added_back := SORT(ds_out_of_model_1_rec + ds_ids_nf_in_model_out, acctno);

  // Prep ds out of model plus ids not found added, to the final batch output layout
  ds_prepped_batch_out := Residency_Services.Functions.preptobatch(ds_ids_nf_added_back);

  rec_final := RECORD
      DATASET(Residency_Services.Layouts.Batch_out) Records;
      DATASET(Royalty.Layouts.RoyaltyForBatch) Royalties;
  END;

  ds_final_records := DATASET([{ds_prepped_batch_out,
                                veh_recs.Royalties}
                              ],rec_final);

  // For debugging, uncomment as needed
  // OUTPUT(ds_batch_in,               NAMED('BR_ds_batch_in'));
  // OUTPUT(ds_BestInfo,               NAMED('ds_BestInfo'));
  // OUTPUT(ds_BestInfo_ids_found,     NAMED('ds_Bestinfo_ids_found'));
  // OUTPUT(ds_batch_in_ids_notfound,  NAMED('ds_batch_in_ids_notfound'));
  // OUTPUT(ds_Top4Addrs,              NAMED('ds_Top4Addrs'));
  // OUTPUT(ds_DedupedAddrs,           NAMED('ds_DedupedAddrs'));
  // OUTPUT(ds_ddaddrs_acctno_did_psd, NAMED('ds_ddaddrs_acctno_did_psd'));
  // OUTPUT(ds_ddaddrs_did_psd,        NAMED('ds_ddaddrs_did_psd'));

  // OUTPUT(DL_recs,          NAMED('DL_recs'));
  // OUTPUT(PL_recs,          NAMED('PL_recs'));
  // OUTPUT(HF_recs,          NAMED('HF_recs'));
  // OUTPUT(Util_recs,        NAMED('Util_recs'));
  // OUTPUT(Wcraft_recs,      NAMED('Wcraft_recs'));
  // OUTPUT(Aircraft_recs,    NAMED('Aircraft_recs'));
  // OUTPUT(BK_recs,          NAMED('BK_recs'));
  // OUTPUT(LJ_recs,          NAMED('LJ_recs'));
  // OUTPUT(Fclosure_recs,    NAMED('Fclosure_recs'));
  // OUTPUT(PAW_recs,         NAMED('PAW_recs'));
  // OUTPUT(Voter_recs,       NAMED('voter_recs'));
  // OUTPUT(PPlus_recs,       NAMED('PPlus_recs'));
  // OUTPUT(Prop_recs,        NAMED('Prop_recs'));
  // OUTPUT(Veh_recs.Results, NAMED('veh_recs_results'));
  // OUTPUT(BIPrecs,          NAMED('BIPrecs'));

  // OUTPUT(DLCounts,          NAMED('DLCounts'));
  // OUTPUT(PLCounts,          NAMED('PLCounts'));
  // OUTPUT(HFCounts,          NAMED('HFCounts'));
  // OUTPUT(UtilCounts,        NAMED('UtilCounts'));
  // OUTPUT(proprecsforcounts, NAMED('proprecsforcounts'));
  // OUTPUT(PropCounts,        NAMED('PropCounts'));
  // OUTPUT(HomesteadCounts,   NAMED('HomesteadCounts'));
  // OUTPUT(WcraftCounts,      NAMED('WcraftCounts'));
  // OUTPUT(AircraftCounts,    NAMED('AircraftCounts'));
  // OUTPUT(BKCounts,          NAMED('BKCounts'));
  // OUTPUT(LJCounts,          NAMED('LJCounts'));
  // OUTPUT(FclosureCounts,    NAMED('FclosureCounts'));
  // OUTPUT(PAWCounts,         NAMED('PAWCounts'));
  // OUTPUT(VoterCounts,       NAMED('VoterCounts'));
  // OUTPUT(PPlusCounts,       NAMED('PPlusCounts'));
  // OUTPUT(VehCounts,         NAMED('VehCounts'));
  // OUTPUT(BIPcounts,         NAMED('BIPcounts'));
  // OUTPUT(VOOrecs,           NAMED('VOOrecs'));
  // OUTPUT(IIDrecs,           NAMED('IIDrecs'));

  // OUTPUT(ds_batchtomodel_all,          NAMED('ds_batchtomodel_all'));
  // OUTPUT(DEBUGMODEL,                   NAMED('DEBUGMODEL'));
  IF(DEBUGMODEL,OUTPUT(ds_batch_into_model, NAMED('ds_batch_into_model')));
  IF(DEBUGMODEL,OUTPUT(ds_out_of_model,     NAMED('ds_out_of_model')));
  // OUTPUT(ds_out_of_model_db_dd,        NAMED('ds_out_of_model_db_dd'));
  // OUTPUT(ds_out_of_model_1_rec,        NAMED('ds_out_of_model_1_rec'));
   // OUTPUT(ds_ids_nf_in_model_out,       NAMED('ds_ids_nf_in_model_out'));
  // OUTPUT(ds_ids_nf_added_back,         NAMED('ds_ids_nf_added_back'));
  // OUTPUT(ds_prepped_batch_out,         NAMED('ds_prepped_batch_out'));
  // OUTPUT(ds_final_records,             NAMED('ds_final_records'));

  RETURN ds_final_records;

END;
