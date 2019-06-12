IMPORT doxie, doxie_raw, Residency_Services, STD, ut;

EXPORT fn_getPL(DATASET(doxie.layout_references_acctno) ds_in_acctnos_dids,
                        Residency_Services.IParam.BatchParams mod_params_in) := FUNCTION

  // Project input onto layout needed by Doxie_Raw.PL_Raw, also stripping off the acctno
  PL_In := PROJECT(ds_in_acctnos_dids, doxie.layout_references);

  Ded_PL_In := DEDUP(SORT(PL_In, did), did);

  PL_recs := Doxie_Raw.PL_Raw(Ded_PL_In, mod_params_in);

  TodaysDate := Residency_Services.Constants.TodaysDate;

  PL_fltrd := PL_recs(ut.DaysApart(date_last_seen, TodaysDate)
                       < Residency_Services.Constants.Days_in_Year AND
                      STD.Str.ToUpperCase(status)='ACTIVE');

  PL_ded := DEDUP(SORT(PL_fltrd, did, license_number,-date_last_seen), did, license_number);

  PLwacctno := JOIN(PL_ded, ds_in_acctnos_dids,
                      (UNSIGNED6)LEFT.did = RIGHT.did,
                    TRANSFORM(Residency_Services.Layouts.Int_Service_output,
                      SELF.acctno       := RIGHT.acctno,
                      SELF.did          := RIGHT.did,
                      SELF.expired_flag := 'N',
                      SELF.county_name  := LEFT.county_name,
                      SELF.st           := LEFT.st
                    ));

  RETURN PLwacctno;

END;
