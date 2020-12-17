IMPORT $, Phones, Risk_Indicators, Std;

EXPORT GetPhonesFinal(DATASET($.Layouts.PhoneFinder.Final) dSearchResults,
                      $.iParam.SearchParams                inMod,
                      BOOLEAN                              isPrimaryPhone = FALSE) :=
FUNCTION
  // Primary phones
  dPhoneSlim := PROJECT(dSearchResults(phone != ''),
                        TRANSFORM($.Layouts.PhoneFinder.PhoneSlim,
                                  SELF.orig_phone    := LEFT.phone,
                                  SELF.phone_state   := LEFT.phoneState,
                                  SELF.ListingType   := $.Functions.GetListingType( LEFT.RealTimePhone_Ext.ListingType,
                                                                                    LEFT.listing_type_bus,
                                                                                    LEFT.listing_type_gov,
                                                                                    LEFT.listing_type_res);
                                  SELF.ListingName 	 := IF(LEFT.listed_name != '', LEFT.listed_name, LEFT.RealTimePhone_Ext.ListingName);
                                  SELF.dt_first_seen := (UNSIGNED4)LEFT.dt_first_seen,
                                  SELF.dt_last_seen  := (UNSIGNED4)LEFT.dt_last_seen,
                                  SELF.PortingCode   := LEFT.PortingCode,
                                  SELF             	 := LEFT.RealTimePhone_Ext,
                                  SELF             	 := LEFT));

  // Get the state where the phone account is opened
  dPhoneState  := JOIN(dPhoneSlim,
                        Risk_Indicators.Key_Telcordia_tds,
                        KEYED(LEFT.phone[1..3]=RIGHT.npa) AND
                        KEYED(LEFT.phone[4..6]=RIGHT.nxx),
                        TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.PhoneSlim,
                                  SELF.phone_state := RIGHT.state,
                                  SELF             := LEFT),
                        LEFT OUTER, LIMIT(0), KEEP(1));

  // creates a more consistent output by matching the logic in GetIdentitiesFinal
  dPhoneSort := SORT(dPhoneState(typeflag != Phones.Constants.TypeFlag.DataSource_PV),
                      acctno, phone, -dt_last_seen, dt_first_seen);

  $.Layouts.PhoneFinder.PhoneSlim tPhoneRollup($.Layouts.PhoneFinder.PhoneSlim le, $.Layouts.PhoneFinder.PhoneSlim ri) :=
  TRANSFORM
    SELF.dt_first_seen           := IF(le.dt_first_seen != 0 AND le.dt_first_seen <= ri.dt_first_seen, le.dt_first_seen, ri.dt_first_seen);
    SELF.dt_last_seen            := IF(le.dt_last_seen <= Std.Date.Today() AND le.dt_last_seen >= ri.dt_last_seen, le.dt_last_seen, ri.dt_last_seen);
    SELF.ListingName             := IF(le.ListingName != '', le.ListingName, ri.ListingName);
    SELF.coc_description         := MAP(le.coc_description != '' AND ri.coc_description != '' AND le.coc_description != ri.coc_description => PhoneFinder_Services.Constants.PhoneType.Other,
                                        le.coc_description = ''                                                                            => ri.coc_description,
                                        le.coc_description = ri.coc_description OR ri.coc_description = ''                                 => le.coc_description,
                                        PhoneFinder_Services.Constants.PhoneType.Other);
    SELF.ListingType             := IF(le.ListingType != '', le.ListingType, ri.ListingType);
    SELF.PhoneStatus             := IF(le.PhoneStatus = $.Constants.PhoneStatus.NotAvailable, ri.PhoneStatus, le.PhoneStatus);
    SELF.Prepaid                 := IF(le.Prepaid , le.Prepaid, ri.Prepaid);
    SELF.PhoneOwnershipIndicator := le.PhoneOwnershipIndicator OR ri.PhoneOwnershipIndicator; // only valid for other phones
    SELF.CallForwardingIndicator := IF(ri.CallForwardingIndicator = '' OR le.CallForwardingIndicator = $.Functions.CallForwardingDesc(1),
                                        le.CallForwardingIndicator,
                                        ri.CallForwardingIndicator);
    SELF.carrier_name            := IF(le.carrier_name != '', le.carrier_name, ri.carrier_name);
    SELF.phone_region_city       := IF(le.phone_region_city != '', le.phone_region_city, ri.phone_region_city);
    SELF.phone_region_st         := IF(le.phone_region_st != '', le.phone_region_st, ri.phone_region_st);
    SELF.imsi_changedate         := IF(le.imsi_changedate = '', ri.imsi_changedate, le.imsi_changedate);
    SELF.imsi_ActivationDate     := IF(le.imsi_ActivationDate ='', ri.imsi_ActivationDate, le.imsi_ActivationDate);
    SELF.iccid_seensince         := IF(le.iccid_seensince='', ri.iccid_seensince, le.iccid_seensince);
    SELF.imsi_seensince          := IF(le.imsi_seensince='', ri.imsi_seensince, le.imsi_seensince);
    SELF.imei_seensince          := IF(le.imei_seensince='', ri.imei_seensince, le.imei_seensince);
    SELF.imei_changedate         := IF(le.imei_changedate='', ri.imei_changedate, le.imei_changedate);
    SELF.loststolen_date         := IF(le.loststolen_date='', ri.loststolen_date, le.loststolen_date);
    SELF.loststolen              := IF(le.loststolen = 0, ri.loststolen, le.loststolen);
    SELF.iccid_changedthis_time  := IF(le.iccid_changedthis_time = 0, ri.iccid_changedthis_time, le.iccid_changedthis_time);
    SELF.imsi_changedthis_time   := IF(le.imsi_changedthis_time = 0, ri.imsi_changedthis_time, le.imsi_changedthis_time);
    SELF.imei_changedthis_time   := IF(le.imei_changedthis_time = 0, ri.imei_changedthis_time, le.imei_changedthis_time);
    SELF.sim_Tenure_MinDays      := IF(le.sim_Tenure_MinDays != 0, le.sim_Tenure_MinDays, ri.sim_Tenure_MinDays);
    SELF.sim_Tenure_MaxDays      := IF(le.sim_Tenure_MaxDays != 0, le.sim_Tenure_MaxDays, ri.sim_Tenure_MaxDays);
    SELF.imei_Tenure_MinDays     := IF(le.imei_Tenure_MinDays != 0, le.imei_Tenure_MinDays, ri.imei_Tenure_MinDays);
    SELF.imei_Tenure_MaxDays     := IF(le.imei_Tenure_MaxDays != 0, le.imei_Tenure_MaxDays, ri.imei_Tenure_MaxDays);
    SELF.phn_src_all             := le.phn_src_all + ri.phn_src_all;
    SELF                         := le;
  END;

  dPhoneRollup := ROLLUP(dPhoneSort,
                          LEFT.acctno = RIGHT.acctno AND
                          LEFT.phone  = RIGHT.phone,
                          tPhoneRollup(LEFT, RIGHT));

  // Overwrite the primary phone details with the phone detail information from TU
  dPrimaryPhoneDetail := dPhoneSlim(typeflag = Phones.Constants.TypeFlag.DataSource_PV);

  $.Layouts.PhoneFinder.PhoneSlim tOverwriteWithTU($.Layouts.PhoneFinder.PhoneSlim le, $.Layouts.PhoneFinder.PhoneSlim ri) :=
  TRANSFORM
    SELF.acctno                  := le.acctno;
    SELF.phone                   := le.phone;
    SELF.phone_state             := le.phone_state;
    SELF.phone_source            := IF(ri.phone != '', ri.phone_source, le.phone_source);
    SELF.subj_phone_type_new     := IF(ri.phone != '', ri.subj_phone_type_new, le.subj_phone_type_new);
    SELF.typeflag                := IF(ri.phone != '', ri.typeflag, le.typeflag);
    SELF.Phonestatus		         := IF(ri.phone != '', ri.Phonestatus, le.Phonestatus);
    SELF.PortingCode             := IF(ri.phone != '', ri.PortingCode, le.PortingCode);
    SELF.ListingType             := IF(ri.ListingType != '', ri.ListingType, le.ListingType);
    SELF.coc_description         := IF(ri.coc_description != '', ri.coc_description, le.coc_description);
    SELF.carrier_name            := MAP(ri.operatingcompany.name != ''=> ri.operatingcompany.name,
                                        ri.carrier_name != ''=> ri.carrier_name,
                                        le.carrier_name);
    SELF.phone_region_city       := MAP(ri.operatingcompany.address.city != '' => ri.operatingcompany.address.city,
                                        ri.phone_region_city != ''=> ri.phone_region_city,
                                        le.phone_region_city);
    SELF.phone_region_st         := MAP(ri.operatingcompany.address.state != '' => ri.operatingcompany.address.state,
                                        ri.phone_region_st != ''=> ri.phone_region_st,
                                        le.phone_region_st);
    SELF.PortingCount            := le.PortingCount;
    SELF.PortingHistory          := le.PortingHistory;
    SELF.PortingStatus           := le.PortingStatus;
    SELF.FirstPortedDate         := le.FirstPortedDate;
    SELF.LastPortedDate          := le.LastPortedDate;
    SELF.ActivationDate          := IF(ri.phone != '', ri.ActivationDate, le.ActivationDate);
    SELF.DisconnectDate          := IF(ri.phone != '', ri.DisconnectDate, le.DisconnectDate);
    SELF.Prepaid                 := le.Prepaid;
    SELF.NoContractCarrier       := le.NoContractCarrier;
    SELF.Spoof                   := le.Spoof;
    SELF.Destination             := le.Destination;
    SELF.Source                  := le.Source;
    SELF.FirstEventSpoofedDate   := le.FirstEventSpoofedDate;
    SELF.LastEventSpoofedDate    := le.LastEventSpoofedDate;
    SELF.TotalSpoofedCount       := le.TotalSpoofedCount;
    SELF.SpoofingHistory         := le.SpoofingHistory;
    SELF.OTP                     := le.OTP;
    SELF.OTPCount                := le.OTPCount;
    SELF.FirstOTPDate            := le.FirstOTPDate;
    SELF.LastOTPDate             := le.LastOTPDate;
    SELF.LastOTPStatus           := le.LastOTPStatus;
    SELF.OTPHistory              := le.OTPHistory;
    SELF.PhoneRiskIndicator      := le.PhoneRiskIndicator;
    SELF.OTPRIFailed             := le.OTPRIFailed;
    SELF.Alerts                  := le.Alerts;
    SELF.RecordsReturned         := le.RecordsReturned;
    SELF.InquiryDates            := le.InquiryDates;
    SELF.PhoneOwnershipIndicator := le.PhoneOwnershipIndicator;
    SELF.CallForwardingIndicator := le.CallForwardingIndicator;
    SELF.imsi_seensince          := le.imsi_seensince;
    SELF.imsi_changedate         := le.imsi_changedate;
    SELF.imsi_ActivationDate     := le.imsi_ActivationDate;
    SELF.imsi_changedthis_time   := le.imsi_changedthis_time;
    SELF.iccid_changedthis_time  := le.iccid_changedthis_time;
    SELF.iccid_seensince         := le.iccid_seensince;
    SELF.imei_seensince          := le.imei_seensince;
    SELF.imei_changedate         := le.imei_changedate;
    SELF.imei_changedthis_time   := le.imei_changedthis_time;
    SELF.loststolen              := le.loststolen;
    SELF.loststolen_date         := le.loststolen_date;
    SELF.sim_Tenure_MinDays      := IF(le.sim_Tenure_MinDays = 0, ri.sim_Tenure_MinDays, le.sim_Tenure_MinDays);
    SELF.sim_Tenure_MaxDays      := IF(le.sim_Tenure_MaxDays = 0, ri.sim_Tenure_MaxDays, le.sim_Tenure_MaxDays);
    SELF.imei_Tenure_MinDays     := IF(le.imei_Tenure_MinDays = 0, ri.imei_Tenure_MinDays, le.imei_Tenure_MinDays);
    SELF.imei_Tenure_MaxDays     := IF(le.imei_Tenure_MaxDays = 0, ri.imei_Tenure_MaxDays, le.imei_Tenure_MaxDays);
    SELF.phn_src_all             := le.phn_src_all + ri.phn_src_all;
    SELF                         := ri;
  END;

  dPhoneDetail := JOIN( dPhoneRollup,
                        dPrimaryPhoneDetail,
                        LEFT.acctno = RIGHT.acctno AND
                        LEFT.phone  = RIGHT.phone,
                        tOverwriteWithTU(LEFT, RIGHT),
                        LEFT OUTER,
                        LIMIT(0), KEEP(1));

  // To preserve single records coming from Qsent PVS (type flag P)
  dTUPhonesOnly := JOIN(dPrimaryPhoneDetail,
                        dPhoneDetail,
                        LEFT.acctno = RIGHT.acctno AND
                        LEFT.phone  = RIGHT.phone,
                        TRANSFORM($.Layouts.PhoneFinder.PhoneSlim,
                                  SELF                 := LEFT),
                        LEFT ONLY);

  dAllPhonesDetail := IF(isPrimaryPhone,
                          dPhoneDetail + dTUPhonesOnly,
                          UNGROUP(TOPN(GROUP(dPhoneState, acctno), PhoneFinder_Services.Constants.WFConstants.MaxSectionLimit, acctno, -phone_score)));

  #IF(PhoneFinder_Services.Constants.Debug.Main)
      OUTPUT(dPhoneSlim, NAMED('dPhoneSlim_Final'), EXTEND);
      OUTPUT(dPhoneState, NAMED('dPhoneState_Final'), EXTEND);
      OUTPUT(dPhoneSort, NAMED('dPhoneSort_Final'), EXTEND);
      OUTPUT(dPhoneRollup, NAMED('dPhoneRollup_Final'), EXTEND);
      OUTPUT(dPrimaryPhoneDetail, NAMED('dPrimaryPhoneDetail_Final'), EXTEND);
      OUTPUT(dPhoneDetail, NAMED('dPhoneDetail_Final'), EXTEND);
      OUTPUT(dTUPhonesOnly, NAMED('dTUPhonesOnly_Final'), EXTEND);
      OUTPUT(dAllPhonesDetail, NAMED('dAllPhonesDetail_Final'), EXTEND);
    #END

  RETURN dAllPhonesDetail;
END;