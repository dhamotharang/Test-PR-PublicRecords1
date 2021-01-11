IMPORT doxie, Gateway, Phones, PhoneFinder_Services, STD, ut;

EXPORT GetZumigoIdentity_Records(DATASET(PhoneFinder_Services.Layouts.PhoneFinder.Final) dPhoneRecs,
                                 DATASET(PhoneFinder_Services.Layouts.BatchInAppendDID)  dInBestInfo,
                                 PhoneFinder_Services.iParam.SearchParams                inMod,
                                 DATASET(Gateway.Layouts.Config)                         dGateways) :=

MODULE

  SHARED mod_access := PROJECT(inMod, doxie.IDataAccess);

  SHARED dWirelessPhones := dPhoneRecs(phone <> '' AND (isPrimaryPhone OR inMod.TransactionType = PhoneFinder_Services.Constants.TransType.PhoneRiskAssessment) AND COC_description = PhoneFinder_Services.Constants.PhoneType.Wireless);

  // sending in best identities name/addr to first wireless phone
  rPfSeardchtype_Layout :=
  RECORD(PhoneFinder_Services.Layouts.PhoneFinder.Final)
    BOOLEAN isPiiSearch;
  END;

  rPfSeardchtype_Layout in_addr(PhoneFinder_Services.Layouts.PhoneFinder.Final l,
                                PhoneFinder_Services.Layouts.BatchInAppendDID r) :=
  TRANSFORM
    BOOLEAN isBestInfoAvail := r.did != 0;

    SELF.isPiiSearch := isBestInfoAvail;
    SELF.phone       := l.phone;
    SELF.fname       := IF(isBestInfoAvail, r.name_first, l.fname);
    SELF.mname       := IF(isBestInfoAvail, r.name_middle, l.mname);
    SELF.lname       := IF(isBestInfoAvail, r.name_last, l.lname);
    SELF.prim_range  := IF(isBestInfoAvail, r.prim_range, l.prim_range);
    SELF.predir      := IF(isBestInfoAvail, r.predir, l.predir);
    SELF.prim_name   := IF(isBestInfoAvail, r.prim_name, l.prim_name);
    SELF.suffix      := IF(isBestInfoAvail, r.addr_suffix, l.suffix);
    SELF.postdir     := IF(isBestInfoAvail, r.postdir, l.postdir);
    SELF.unit_desig  := IF(isBestInfoAvail, r.unit_desig, l.unit_desig);
    SELF.sec_range   := IF(isBestInfoAvail, r.sec_range, l.sec_range);
    SELF.city_name   := IF(isBestInfoAvail, r.p_city_name, l.city_name);
    SELF.st          := IF(isBestInfoAvail, r.st, l.st);
    SELF.zip         := IF(isBestInfoAvail, r.z5, l.zip);
    SELF.zip4        := IF(isBestInfoAvail, r.zip4, l.zip4);
    SELF             := l;
  END;

  SHARED dWirelessPhonesBestInfo := JOIN(dWirelessPhones, dInBestInfo, LEFT.acctno = RIGHT.acctno, in_addr(LEFT,RIGHT), LIMIT(0), KEEP(1), LEFT OUTER);

  Ph_Wireless_Ddp := DEDUP(SORT(PROJECT(dWirelessPhonesBestInfo(~isPiiSearch), PhoneFinder_Services.Layouts.PhoneFinder.Final),
                                acctno, phone, fname, lname, prim_range, prim_name, city_name, st, zip),
                            acctno, phone, fname, lname, prim_range, prim_name, city_name, st, zip);

  // for phone search, we are sending upto 10 different identities per acct, by picking recent ones.
  SHARED PhoneSrch_wireless := TOPN(GROUP(SORT(Ph_Wireless_Ddp, acctno, -dt_last_seen, dt_first_seen, seq), acctno), 10, acctno);

  // for pii search, sending in one primary wireless phone, if available, else one other phone per acct
  // sorting other phones(non primary) by score and dates
  PII_wireless := DEDUP(SORT(PROJECT(dWirelessPhonesBestInfo(isPiiSearch), PhoneFinder_Services.Layouts.PhoneFinder.Final),
                              acctno, IF(isPrimaryPhone, 0, 1), IF(typeflag = Phones.Constants.TypeFlag.DataSource_PV, 0, 1), -phone_score, -dt_last_seen, dt_first_seen),
                        acctno);

  Phones_wireless := PII_wireless + PhoneSrch_wireless;

  Phones.Layouts.ZumigoIdentity.subjectVerificationRequest toZin(PhoneFinder_Services.Layouts.PhoneFinder.Final l) :=
  TRANSFORM
    SELF.acctno          := l.acctno;
    SELF.sequence_number := l.seq;
    SELF.phone           := l.phone;
    SELF.lexid           := l.did;
    SELF.nametype        := 'FULL NAME';
    SELF.first_name      := l.fname;
    SELF.last_name       := l.lname;
    SELF.addresstype     := 'FULL ADDRESS';
    SELF.prim_range      := l.prim_range;
    SELF.predir          := l.predir;
    SELF.prim_name       := l.prim_name;
    SELF.addr_suffix     := l.suffix;
    SELF.postdir         := l.postdir;
    SELF.unit_desig      := l.unit_desig;
    SELF.sec_range       := l.sec_range;
    SELF.p_city_name     := l.city_name;
    SELF.st              := l.st;
    SELF.z5              := l.zip;
    SELF.zip4            := l.zip4;
    SELF.county_name     := l.county_name;
    SELF                 := [];
  END;

  SHARED Zum_inrecs := PROJECT(Phones_wireless, toZin(LEFT));

  SHARED Zum_inMod := MODULE(Phones.IParam.inZumigoParams)
    EXPORT STRING20 Usecase              := PhoneFinder_Services.Constants.ZumigoConstants.Usecase;
    EXPORT STRING3  productCode          := PhoneFinder_Services.Constants.ZumigoConstants.productCode;
    EXPORT STRING8  billingId            := inMod.billingId;
    EXPORT STRING20 productName          := PhoneFinder_Services.Constants.ZumigoConstants.productName;

    EXPORT BOOLEAN NameAddressValidation := inMod.IncludeNameAddressValidation;
    EXPORT BOOLEAN CallHandlingInfo      := inMod.IncludeCallHandlingInfo;
    EXPORT BOOLEAN DeviceInfo            := inMod.IncludeDeviceInfo;
    EXPORT BOOLEAN DeviceHistory         := inMod.IncludeDeviceHistory;
    EXPORT BOOLEAN DeviceChangeInfo      := inMod.IncludeDeviceChangeInfo;
    EXPORT STRING10 optInType            := PhoneFinder_Services.Constants.ZumigoConstants.optInType;
    EXPORT STRING5  optInMethod          := PhoneFinder_Services.Constants.ZumigoConstants.optInMethod;
    EXPORT STRING3  optinDuration        := PhoneFinder_Services.Constants.ZumigoConstants.optinDuration;
    EXPORT STRING   optinId              := IF(Phones.Constants.Debug.Testing, '1', inMod.billingId);
    EXPORT STRING   optInVersionId       := '';
    EXPORT STRING15 optInTimestamp       := (STRING)STD.Date.CurrentDate(TRUE)+' '+(STRING)INTFORMAT(STD.Date.CurrentTime(TRUE),6,1);
    EXPORT DATASET(Gateway.Layouts.Config) gateways := dGateways(Gateway.Configuration.IsZumigoIdentity(servicename));
  END;

  Zumigo_Response := Phones.GetZumigoIdentity(Zum_inrecs, Zum_inMod, mod_access, FALSE, FALSE);

  // getting zumigo error-free response
  EXPORT Zumigo_Hist := Zumigo_Response(source = Phones.Constants.GatewayValues.ZumigoIdentity AND device_mgmt_status = '');

  PhoneFinder_Services.Layouts.PhoneFinder.Final toZumValidated(PhoneFinder_Services.Layouts.PhoneFinder.Final l, Phones.Layouts.ZumigoIdentity.zOut r) :=
  TRANSFORM
    SELF.CallForwardingIndicator := IF(Zum_inMod.CallHandlingInfo AND r.acctno <>'', PhoneFinder_Services.Functions.CallForwardingDesc(r.call_forwarding),''); //get call forwarded value only when CallHandlingInfo is selected and a right record exists
    SELF.rec_source              := r.source; // for royalty count
    SELF.imsi_changedate         := r.imsi_changedate;
    SELF.imsi_ActivationDate     := r.imsi_ActivationDate;
    SELF.iccid_changedthis_time  := r.iccid_changedthis_time;
    SELF.iccid_seensince         := r.iccid_seensince;
    SELF.imsi_changedthis_time   := r.imsi_changedthis_time;
    SELF.imei_changedthis_time   := r.imei_changed_this_time;
    SELF.imsi_seensince          := r.imsi_seensince;
    SELF.imei_seensince          := r.imei_seensince;
    SELF.imei_changedate         := r.imei_changedate;
    SELF.imei_ActivationDate     := r.imei_ActivationDate;
    SELF.loststolen              := r.loststolen;
    SELF.loststolen_date         := r.loststolen_date;
    SELF.imsi_Tenure_MinDays     := IF(r.sim_Tenure_MinDays != 0, r.sim_Tenure_MinDays, r.imsi_Tenure_MinDays); //Temporary patch until the Gateway ESP is released with new changes.
    SELF.imsi_Tenure_MaxDays     := IF(r.sim_Tenure_MaxDays != 0, r.sim_Tenure_MaxDays, r.imsi_Tenure_MaxDays);
    SELF.imei_Tenure_MinDays     := r.imei_Tenure_MinDays;
    SELF.imei_Tenure_MaxDays     := r.imei_Tenure_MaxDays;
    SELF.sim_Tenure_MinDays      := IF(r.sim_Tenure_MinDays != 0, r.sim_Tenure_MinDays, r.imsi_Tenure_MinDays);
    SELF.sim_Tenure_MaxDays      := IF(r.sim_Tenure_MaxDays != 0, r.sim_Tenure_MaxDays, r.imsi_Tenure_MaxDays);

    BOOLEAN IsValidated          := (r.first_name_score BETWEEN Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MIN AND Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MAX) AND
                                    (r.last_name_score BETWEEN Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MIN AND Phones.Constants.Zumigo_NameAddr_Validation_Threshold_MAX);

    SELF.PhoneOwnershipIndicator := IsValidated;
    SELF.dt_last_seen            := IF(IsValidated, (STRING)STD.Date.Today(), l.dt_last_seen);
    dMNO_srcs                      := l.phn_src_all + DATASET(['MNO'], $.Layouts.PhoneFinder.src_rec);
    SELF.phn_src_all             := IF(IsValidated, dMNO_srcs, l.phn_src_all);
    SELF                         := l;
  END;

  EXPORT Zumigo_GLI := JOIN(dPhoneRecs, Zumigo_Hist,
                              LEFT.acctno = RIGHT.acctno AND
                              LEFT.seq    = RIGHT.sequence_number AND
                              LEFT.phone  = RIGHT.submitted_phonenumber,
                              toZumValidated(LEFT, RIGHT),
                              LEFT OUTER, KEEP(1),
                              LIMIT(0));
END;
