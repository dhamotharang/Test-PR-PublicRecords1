IMPORT doxie, Foreclosure_Services, Residency_Services, ut;

EXPORT fn_getForeclosure(DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids,
                         Residency_Services.IParam.BatchParams in_mod) := FUNCTION

  // Project input onto layout needed by Foreclosure_Services.Raw.byDIDs, also stripping off the acctno
  ds_forec_in := PROJECT(ds_in_acctnos_dids, doxie.layout_references);

  ds_forec_in_dd := DEDUP(SORT(ds_forec_in, did), did);

  ds_fids := Foreclosure_Services.Raw.byDIDs(ds_forec_in_dd);

  ds_forec_raw_recs := Foreclosure_Services.Raw.GetRawRecs(ds_fids, in_mod.industry_class);

  rec_forec_wdid := RECORD
    UNSIGNED8 did;
    Foreclosure_Services.Layouts.Rawrec;
  END;

  ds_forec_wdid := JOIN(ds_forec_raw_recs,ds_fids,
                          LEFT.foreclosure_id = RIGHT.fid,
                        TRANSFORM(rec_forec_wdid,
                          SELF.did := RIGHT.did,
                          SELF := LEFT));

  TodaysDate := Residency_Services.Constants.TodaysDate;

  ds_forec_fltrd := ds_forec_wdid(ut.DaysApart(recording_date, TodaysDate)
                                  <  Residency_Services.Constants.Days_in_Year);

  Residency_Services.Layouts.Int_Service_output  tf_output(ds_forec_fltrd l,
                                                           ds_in_acctnos_dids r) := TRANSFORM
    SELF.acctno       := r.acctno;
    SELF.did          := r.did;
    SELF.expired_flag := 'N';
    SELF.st           := l.situs1_st; // Situs1 has foreclosed property addr, Situs2 has Owner Mailing addr
    SELF.county_name  := Residency_Services.functions.get_county_name(l.situs1_st,l.situs1_fipscounty);
  END;

  ds_forec_ret := JOIN (ds_forec_fltrd, ds_in_acctnos_dids,
                          LEFT.did = RIGHT.did,
                       tf_output(LEFT,RIGHT));

  // OUTPUT(ds_acct_did_dd,    NAMED('ds_acct_did_dd'))
  // OUTPUT(ds_forec_in,       NAMED('ds_forec_in'))
  // OUTPUT(ds_forec_in_dd,    NAMED('ds_forec_in_dd'))
  // OUTPUT(ds_fids,           NAMED('ds_fids'))
  // OUTPUT(ds_forec_raw_recs, NAMED('ds_forec_raw_recs'));
  // OUTPUT(ds_forec_wdid,     NAMED('ds_forec_wdid'));
  // OUTPUT(ds_forec_fltrd,    NAMED('ds_forec_fltrd'));

  RETURN ds_forec_ret;

END;
