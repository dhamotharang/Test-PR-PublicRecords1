IMPORT $, Phones, Std;

EXPORT GetPhonesFinal(DATASET($.Layouts.PhoneFinder.Final) dSearchResults,
                      $.iParam.ReportParams                inMod,
                      BOOLEAN                              isPrimaryPhone = FALSE) :=
FUNCTION  
  // Primary phones
  dPhoneSlim := PROJECT(dSearchResults(phone != ''),
                        TRANSFORM($.Layouts.PhoneFinder.PhoneSlim,
                                  SELF.orig_phone    := LEFT.batch_in.homephone,
                                  SELF.ListingType   := $.Functions.GetListingType( LEFT.RealTimePhone_Ext.ListingType,
                                                                                    LEFT.listing_type_bus,
                                                                                    LEFT.listing_type_gov,
                                                                                    LEFT.listing_type_res);
                                  SELF.ListingName 	 := IF(LEFT.listed_name != '', LEFT.listed_name, LEFT.RealTimePhone_Ext.ListingName);
                                  SELF.dt_first_seen := (UNSIGNED4)LEFT.dt_first_seen,
                                  SELF.dt_last_seen  := (UNSIGNED4)LEFT.dt_last_seen,
                                  SELF             	 := LEFT.RealTimePhone_Ext,
                                  SELF             	 := LEFT));
  
  // creates a more consistent output by matching the logic in GetIdentitiesFinal
  dPhoneSort := SORT(dPhoneSlim(typeflag != Phones.Constants.TypeFlag.DataSource_PV), 
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
    SELF.PhoneStatus	           := IF(le.PhoneStatus = $.Constants.PhoneStatus.NotAvailable, ri.PhoneStatus, le.PhoneStatus);
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
    SELF                 		     := le;
  END;

  dPhoneRollup := ROLLUP(dPhoneSort,
                          LEFT.acctno = RIGHT.acctno AND
                          LEFT.phone  = RIGHT.phone, 
                          tPhoneRollup(LEFT, RIGHT));
  
  // Overwrite the primary phone details with the phone detail information from TU
  dPrimaryPhoneDetail := dPhoneSlim(typeflag = Phones.Constants.TypeFlag.DataSource_PV);
  
  $.Layouts.PhoneFinder.PhoneSlim tOverwriteWithTU(dPhoneRollup le, dPrimaryPhoneDetail ri) :=
  TRANSFORM
    SELF.acctno                  := le.acctno;
    SELF.phone                   := le.phone;
    SELF.phone_source            := IF(ri.phone != '', ri.phone_source, le.phone_source);
    SELF.typeflag                := IF(ri.phone != '', ri.typeflag, le.typeflag);
    SELF.PortingCode             := IF(ri.phone != '', ri.PortingCode, le.PortingCode);
    SELF.PortingCount            := IF(ri.phone != '', ri.PortingCount, le.PortingCount);
    SELF.PortingHistory          := IF(ri.phone != '', ri.PortingHistory, le.PortingHistory);
    SELF.PortingStatus		       := IF(ri.phone != '', ri.PortingStatus, le.PortingStatus);
    SELF.FirstPortedDate	       := IF(ri.phone != '', ri.FirstPortedDate, le.FirstPortedDate);
    SELF.LastPortedDate		       := IF(ri.phone != '', ri.LastPortedDate, le.LastPortedDate);
    SELF.Phonestatus		         := IF(ri.phone != '', ri.Phonestatus, le.Phonestatus);
    SELF.ActivationDate		       := IF(ri.phone != '', ri.ActivationDate, le.ActivationDate);
    SELF.DisconnectDate		       := IF(ri.phone != '', ri.DisconnectDate, le.DisconnectDate);
    SELF.Prepaid		 			       := IF(ri.phone != '', ri.Prepaid, le.Prepaid);
    SELF.NoContractCarrier       := IF(ri.phone != '', ri.NoContractCarrier, le.NoContractCarrier);
    SELF.Spoof						       := IF(ri.phone != '', ri.Spoof, le.Spoof);
    SELF.Destination			       := IF(ri.phone != '', ri.Destination, le.Destination);
    SELF.Source						       := IF(ri.phone != '', ri.Source, le.Source);
    SELF.FirstEventSpoofedDate   := IF(ri.phone != '', ri.FirstEventSpoofedDate, le.FirstEventSpoofedDate);
    SELF.LastEventSpoofedDate    := IF(ri.phone != '', ri.LastEventSpoofedDate, le.LastEventSpoofedDate);
    SELF.TotalSpoofedCount       := IF(ri.phone != '', ri.TotalSpoofedCount, le.TotalSpoofedCount);
    SELF.SpoofingHistory	       := IF(ri.phone != '', ri.SpoofingHistory, le.SpoofingHistory);
    SELF.OTP							       := IF(ri.phone != '', ri.OTP, le.OTP);
    SELF.OTPCount					       := IF(ri.phone != '', ri.OTPCount, le.OTPCount);
    SELF.FirstOTPDate			       := IF(ri.phone != '', ri.FirstOTPDate, le.FirstOTPDate);
    SELF.LastOTPDate			       := IF(ri.phone != '', ri.LastOTPDate, le.LastOTPDate);
    SELF.LastOTPStatus		       := IF(ri.phone != '', ri.LastOTPStatus, le.LastOTPStatus);
    SELF.OTPHistory	 			       := IF(ri.phone != '', ri.OTPHistory, le.OTPHistory);
    SELF.PhoneRiskIndicator      := IF(ri.phone != '', ri.PhoneRiskIndicator, le.PhoneRiskIndicator);
    SELF.OTPRIFailed             := IF(ri.phone != '', ri.OTPRIFailed, le.OTPRIFailed);
    SELF.Alerts						       := IF(ri.phone != '', ri.Alerts, le.Alerts);
    SELF.ListingType             := IF(ri.ListingType != '', ri.ListingType, le.ListingType);
    SELF.coc_description         := IF(ri.ServiceClass != '',
                                        $.Functions.ServiceClassDesc(ri.ServiceClass),
                                        le.coc_description);
    SELF.carrier_name            := MAP(ri.operatingcompany.name != ''=> ri.operatingcompany.name,
                                        ri.carrier_name != ''=> ri.carrier_name,
                                        le.carrier_name);
    SELF.phone_region_city       := MAP(ri.operatingcompany.address.city != '' => ri.operatingcompany.address.city,
                                        ri.phone_region_city != ''=> ri.phone_region_city,
                                        le.phone_region_city);
    SELF.phone_region_st         := MAP(ri.operatingcompany.address.state != '' => ri.operatingcompany.address.state,
                                        ri.phone_region_st != ''=> ri.phone_region_st,
                                        le.phone_region_st);
    SELF.CallForwardingIndicator := le.CallForwardingIndicator;
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
                                  SELF.coc_description := IF(LEFT.ServiceClass != '', $.Functions.ServiceClassDesc(LEFT.ServiceClass), LEFT.coc_description),
                                  SELF                 := LEFT),
                        LEFT ONLY);
    
  dAllPhonesDetail := IF(isPrimaryPhone,
                          dPhoneDetail + dTUPhonesOnly,
                          UNGROUP(TOPN(GROUP(dPhoneRollup, acctno), PhoneFinder_Services.Constants.WFConstants.MaxSectionLimit, acctno, -phone_score)));
  
  #IF(PhoneFinder_Services.Constants.Debug.Intermediate)
      OUTPUT(dPhoneSlim, NAMED('dPhoneSlim_Primary'), EXTEND);
      OUTPUT(dPhoneSort, NAMED('dPhoneSort_Primary'), EXTEND);
      OUTPUT(dPhoneRollup, NAMED('dPhoneRollup_Primary'), EXTEND);
      OUTPUT(dPrimaryPhoneDetail, NAMED('dPrimaryPhoneDetail_Primary'), EXTEND);
      OUTPUT(dPhoneDetail, NAMED('dPhoneDetail'), EXTEND);
      OUTPUT(dTUPhonesOnly, NAMED('dTUPhonesOnly'), EXTEND);
      OUTPUT(dAllPhonesDetail, NAMED('dAllPhonesDetail'), EXTEND);
    #END

  RETURN dAllPhonesDetail;
END;