import prof_licenseV2, riskwise, ut, risk_indicators, dx_prof_license_mari, doxie, Suppress, data_services, AML;

export IndProfLic(DATASET(Layouts.AMLExecLayoutV2) ExecIds,
                           doxie.IDataAccess mod_access,
                           boolean isFCRA = false
                           ) := FUNCTION

data_environment :=  data_services.data_env.GetEnvFCRA(isFCRA);

//version 2
Layout_PL_Plus := RECORD
  unsigned6 did;
  unsigned4 seq;
  boolean HRProfLicProv;
  boolean professional_license_flag := false;
  string60 license_type := '';
  unsigned1 proflic_count := 0;
  unsigned date_most_recent := 0;
  string50 prolic_key;
END;

Layout_PL_Plus_CCPA := RECORD
  unsigned4 global_sid;
  Layout_PL_Plus;
END;

checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;

keyProfLicDID := prof_licenseV2.Key_Proflic_Did ();

Layout_PL_Plus_CCPA PL_nonFCRA(ExecIds le, keyProfLicDID rt) := transform
  hit := trim(rt.prolic_key)!='';  // check to see that we have a good record
  licenseType := trim(trim(rt.license_type), left);
  myGetDate := risk_indicators.iid_constants.myGetDate(le.historydate);
  self.HRProfLicProv := if(hit and licenseType in AML.AMLConstants.setHRProfLic, 1, 0);
  self.prolic_key := rt.prolic_key;
  self.did := le.assocdid;
  self.professional_license_flag := hit;
  self.license_type := licenseType;
  self.date_most_recent := (integer)rt.date_last_seen;
  Self.proflic_count := if(rt.prolic_key<>'', 1, 0);
  self.global_sid := rt.global_sid;
  self := le;
  self := [];
end;
license_recs_unsuppressed := join(ExecIds, keyProfLicDID,
                      trim(right.prolic_key)!='' and
                      keyed(right.did = left.assocdid) and
                      (unsigned)right.date_first_seen[1..6] < left.historydate,
                      PL_nonFCRA(left,right), left outer,
                      atmost(right.did = left.assocdid, riskwise.max_atmost));

license_recs_flagged := Suppress.MAC_FlagSuppressedSource(license_recs_unsuppressed, mod_access, data_env := data_environment);

license_recs := PROJECT(license_recs_flagged, TRANSFORM(Layout_PL_Plus,
  self.HRProfLicProv :=  IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.HRProfLicProv);
  self.prolic_key :=  IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.prolic_key);
  self.date_most_recent :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.date_most_recent);
  self.professional_license_flag :=  IF(left.is_suppressed, false, left.professional_license_flag);
  self.license_type :=  IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.license_type);
  self.proflic_count := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.proflic_count);
  SELF := LEFT;
));

LicensesSD := dedup(sort(license_recs, seq, did, prolic_key, -date_most_recent), seq, did, prolic_key);


key_main := dx_prof_license_mari.key_did(data_environment) ;
rec_main := recordof (key_main);


raw_data_unsuppressed := join (ExecIds, key_main,
    keyed (left.assocdid = right.s_did) and
    (unsigned)right.date_first_seen[1..6] < left.historydate and
    right.std_source_upd not in risk_indicators.iid_constants.restricted_Mari_vendor_set,
    transform (Layout_PL_Plus_CCPA,
      hit := right.license_nbr<>'';
      licenseType := trim(trim(right.std_license_desc), left);
      self.did := left.assocdid;
      self.prolic_key := right.license_nbr;
      self.professional_license_flag := hit;
      Self.proflic_count := if(right.license_nbr<>'', 1, 0);
      self.date_most_recent := (integer)right.date_last_seen;
      self.HRProfLicProv :=    if(hit and licenseType in AML.AMLConstants.setHRProfLic, 1, 0);
      self.license_type := licenseType;
      self.global_sid := right.global_sid;
      self := left),
    atmost( keyed(left.assocdid = right.s_did), riskwise.max_atmost),
    keep(100)
  );

raw_data := Suppress.Suppress_ReturnOldLayout(raw_data_unsuppressed, mod_access, Layout_PL_Plus, data_environment := data_environment);

sorted_mari := dedup(sort(raw_data, seq, did, prolic_key, -date_most_recent), seq, did, prolic_key);

CombProfLic := Sort(LicensesSD + sorted_mari, seq, did);

Layout_PL_Plus roll_licenses(Layout_PL_Plus le, Layout_PL_Plus rt) := transform
  self.professional_license_flag := le.professional_license_flag or rt.professional_license_flag;
  self.proflic_count := le.proflic_count+IF(le.prolic_key=rt.prolic_key,0,rt.proflic_count);
  self.HRProfLicProv := if(le.HRProfLicProv, le.HRProfLicProv, rt.HRProfLicProv);
  self := rt;
end;

rolled_licenses := rollup(CombProfLic,  roll_licenses(left,right), left.seq = right.seq and left.did = right.did);

// output(ExecIds, named('ExecIds'), overwrite);
// output(license_recs, named('license_recs'), overwrite);
// output(sorted_mari, named('sorted_mari'), overwrite);

return rolled_licenses;

end;
