EXPORT GetPhonesMetadata(dInRecs,
                         inMod,
                         dGateways,
                         dInBestInfo,
                         subjectInfo) :=
FUNCTIONMACRO
  IMPORT Advo, AutoStandardI, Doxie, DID_Add, Gateway, Inquiry_AccLogs, PhoneFinder_Services, PhoneFraud,
        Phones, Risk_Indicators, Suppress, std, ut;

  SHARED mod_access := MODULE(doxie.IDataAccess)
    EXPORT glb := inMod.GLBPurpose;
    EXPORT dppa := inMod.DPPAPurpose;
    EXPORT Industry_Class := inMod.IndustryClass;
    EXPORT Application_Type := inMod.ApplicationType;
    EXPORT DataPermissionMask := inMod.DataPermissionMask;
    EXPORT DataRestrictionMask := inMod.DataRestrictionMask;
    EXPORT ssn_mask := inMod.DOBMask;
    EXPORT dob_mask := Suppress.date_mask_math.MaskIndicator(inMod.DOBMask);
    EXPORT show_minors := inMod.includeMinors;
  END;

  // ---------------------------------------------------------------------------------------------------------
  // ****************************************Process Phone Inquiry********************************************
  // ---------------------------------------------------------------------------------------------------------
  InquiryHistory := Inquiry_AccLogs.Key_Inquiry_Phone;
  InquiryDaily := Inquiry_AccLogs.Key_Inquiry_Phone_Update;

  PhoneFinder_Services.Layouts.PhoneFinder.Final getInquiries(dInRecs l, DATASET(RECORDOF(InquiryDaily)) r ):= TRANSFORM
    SELF.InquiryDates := DEDUP(SORT(l.InquiryDates + PROJECT(r, TRANSFORM({STRING17 InquiryDate}, SELF.InquiryDate := LEFT.search_info.datetime)),
                                    InquiryDate),InquiryDate);
    SELF := l;
  END;

  //Denormalize causes issues extracting key fields needed for suppression.
  //Instead, grab the records from the key which match the join condition
  InquiryHistoryJoined := JOIN(dInRecs, InquiryHistory,
                                KEYED(LEFT.phone = RIGHT.phone10) AND
                                LEFT.dt_first_seen <= RIGHT.search_info.datetime[1..8],
                                TRANSFORM(RIGHT), LIMIT(PhoneFinder_Services.Constants.MetadataLimit, SKIP));

  InquiryHistorySuppressed := Suppress.MAC_SuppressSource(InquiryHistoryJoined, mod_access, person_q.appended_ADL, ccpa.global_sid);

  dSearchRecswInqHistory := DENORMALIZE(dInRecs, InquiryHistorySuppressed,
                                        LEFT.phone = RIGHT.phone10 AND
                                        LEFT.dt_first_seen <= RIGHT.search_info.datetime[1..8],
                                        GROUP,
                                        getInquiries(LEFT,ROWS(RIGHT)),
                                        LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));

  InquiryDailyJoined := JOIN(dSearchRecswInqHistory, InquiryDaily,
                              KEYED(LEFT.phone = RIGHT.phone10) AND LEFT.dt_first_seen <= RIGHT.search_info.datetime[1..8],
                              TRANSFORM(RIGHT), LIMIT(PhoneFinder_Services.Constants.MetadataLimit, SKIP));

  InquiryDailySuppressed := Suppress.MAC_SuppressSource(InquiryDailyJoined, mod_access, person_q.appended_ADL, ccpa.global_sid);

  dSearchRecswInquiryDaily := DENORMALIZE(dSearchRecswInqHistory, InquiryDailySuppressed,
                                          LEFT.phone = RIGHT.phone10 AND
                                          LEFT.dt_first_seen <= RIGHT.search_info.datetime[1..8],
                                          GROUP,
                                          getInquiries(LEFT,ROWS(RIGHT)),
                                          LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));

  dInqdeltabase_in := PROJECT(DEDUP(SORT(dSearchRecswInquiryDaily(phone <> ''), phone), phone),
                              TRANSFORM(PhoneFinder_Services.Layouts.DeltaInquiryDataRecord, SELF := LEFT));

  // Check if realtime data was requested
  dDeltabaseinquired := PhoneFinder_Services.GetPhoneInquiries_Deltabase(dInqdeltabase_in,PhoneFinder_Services.Constants.SQLSelectLimit,dGateways);

  // Join available realtime ports. Deact data is NOT available in realtime
  dDeltabaseInquiredRecs := JOIN(dSearchRecswInquiryDaily,dDeltabaseinquired,
                                  LEFT.phone = RIGHT.phone,
                                  TRANSFORM(RECORDOF(LEFT), SELF.RecordsReturned := RIGHT.RecordsReturned, SELF := LEFT),
                                  LEFT OUTER, LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));

  dPhoneInquiryRecs := IF(inMod.UseDeltabase, dDeltabaseInquiredRecs, dSearchRecswInquiryDaily);

  // we use Inquiry Recs only when RI = 30(30	Phone # has had “Input A” search requests within the past “Input B” days	) is active
  dPhoneInquiryRecs_final := IF(EXISTS(inMod.RiskIndicators(Active AND RiskId = 30)), dPhoneInquiryRecs, dInRecs);

  // Adding Ported data
  PhoneFinder_Services.Layouts.PhoneFinder.Final UpdatePhonePortedInfo(PhoneFinder_Services.Layouts.PhoneFinder.Final l,PhoneFinder_Services.Layouts.PhoneFinder.Final r) := TRANSFORM
    SELF.PortingCode        := r.PortingCode;
    SELF.PortingCount       := r.PortingCount;
    SELF.PortingHistory     := r.PortingHistory;
    SELF.FirstPortedDate    := r.FirstPortedDate;
    SELF.LastPortedDate     := r.LastPortedDate;
    SELF.NoContractCarrier  := r.NoContractCarrier;
    SELF.Prepaid            := r.Prepaid;
    SELF.ActivationDate     := r.ActivationDate;
    SELF.DisconnectDate     := r.DisconnectDate;
    SELF.serviceType        := r.serviceType;
    SELF.RealTimePhone_Ext.ServiceClass := r.RealTimePhone_Ext.ServiceClass;
    SELF.COC_description    := r.COC_description;
    SELF.PortingStatus      := r.PortingStatus;
    SELF := l;
    SELF := [];
  END;

  dPhoneInfoWPorting := JOIN(dPhoneInquiryRecs_final,dInRecs,
                              LEFT.acctno = RIGHT.acctno AND
                              LEFT.phone  = RIGHT.phone,
                              UpdatePhonePortedInfo(LEFT,RIGHT),
                              LEFT OUTER, KEEP(1),
                              LIMIT(0));

  dPortedRecs := IF(inMod.TransactionType=PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT, dPhoneInfoWPorting, dPhoneInquiryRecs_final);

  // ---------------------------------------------------------------------------------------------------------
  // ****************************************Process SPOOFs***************************************************
  // ---------------------------------------------------------------------------------------------------------
  // Get Spoofed phones
  dSpoofed	:= JOIN(subjectInfo, PhoneFraud.Key_Spoofing,
                      KEYED(LEFT.phone = RIGHT.phone) AND
                      LEFT.FirstSeenDate <= (UNSIGNED) RIGHT.event_date,
                      LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));

  //Get realtime spoofing data
  dDeltabaseSpoofed := PhoneFinder_Services.GetSpoofedPhones_Deltabase(subjectInfo,PhoneFinder_Services.Constants.SQLSelectLimit,dGateways);

  //Join available realtime spoofs
  dDeltaSpoofwSubject := JOIN(subjectInfo,dDeltabaseSpoofed,
                                LEFT.phone = RIGHT.phone AND
                                LEFT.FirstSeenDate <= (UNSIGNED) RIGHT.event_date,
                                LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));

  dSpoofedPhones := DEDUP(SORT(UNGROUP(dSpoofed + IF(EXISTS(subjectInfo) AND inMod.UseDeltabase,dDeltaSpoofwSubject)),   //combine results
                                acctno, did, phone, phone_origin, (UNSIGNED)event_date=0, event_date, id),
                            acctno, did, phone, phone_origin, event_date, id);

  dsSpoofHistory := PROJECT(dSpoofedPhones,TRANSFORM({PhoneFinder_Services.Layouts.SubjectPhone,PhoneFinder_Services.Layouts.PhoneFinder.SpoofHistory},
                                                    SELF.EventDate := LEFT.event_date, SELF.PhoneOrigin := LEFT.phone_origin, SELF:=LEFT));
  //select necessary fields
  spoofRec := RECORD
    dSpoofedPhones.acctno;
    dSpoofedPhones.did;
    dSpoofedPhones.phone;
    dSpoofedPhones.phone_origin;
    BOOLEAN Spoofed := dSpoofedPhones.phone_origin <> '';
    UNSIGNED4 SpoofedCount := COUNT(GROUP,dSpoofedPhones.phone_origin<>'');
    UNSIGNED4 TotalSpoofedCount := COUNT(GROUP,dSpoofedPhones.phone_origin<>'');
    UNSIGNED4 FirstSpoofedDate := (UNSIGNED)dSpoofedPhones.event_date;
    UNSIGNED4 LastSpoofedDate := (UNSIGNED)MAX(GROUP, dSpoofedPhones.event_date);
    UNSIGNED4 FirstEventSpoofedDate := (UNSIGNED)dSpoofedPhones.event_date;
    UNSIGNED4 LastEventSpoofedDate := (UNSIGNED)MAX(GROUP, dSpoofedPhones.event_date);
  END;

  dSpoof:= TABLE(GROUP(dSpoofedPhones,acctno, did, phone, phone_origin),spoofRec);

  spoof_layout := RECORD
      PhoneFinder_Services.Layouts.SubjectPhone;
      PhoneFinder_Services.Layouts.PhoneFinder.SpoofingData;
  END;
  transformSpoof := PROJECT(dSpoof, TRANSFORM(spoof_layout,
                                                SELF.Spoof:=IF(LEFT.phone_origin=PhoneFinder_Services.Constants.SpoofPhoneOrigin.SPOOFED,
                                                        PROJECT(LEFT,TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.SpoofCommon,SELF:= LEFT))),
                                                SELF.Destination:=IF(LEFT.phone_origin=PhoneFinder_Services.Constants.SpoofPhoneOrigin.DESTINATION,
                                                        PROJECT(LEFT,TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.SpoofCommon,SELF:= LEFT))),
                                                SELF.Source:=IF(LEFT.phone_origin=PhoneFinder_Services.Constants.SpoofPhoneOrigin.SOURCE,
                                                        PROJECT(LEFT,TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.SpoofCommon,SELF:= LEFT))),
                                                SELF:=LEFT,
                                                SELF:=[]));

  spoof_layout rollSpoofing (spoof_layout l, spoof_layout r):= TRANSFORM
      SELF.TotalSpoofedCount := l.TotalSpoofedCount + r.TotalSpoofedCount;
      SELF.FirstEventSpoofedDate := MIN(l.FirstEventSpoofedDate,r.FirstEventSpoofedDate);
      SELF.LastEventSpoofedDate := MAX(l.LastEventSpoofedDate,r.LastEventSpoofedDate);
      SELF.Spoof := IF(l.spoof.spoofed,l.spoof,r.spoof);
      SELF.Destination := IF(l.Destination.spoofed,l.Destination,r.Destination);
      SELF.Source := IF(l.Source.spoofed,l.Source,r.Source);
      SELF := l;
      SELF := [];
  END;
  spoofInfo := ROLLUP(transformSpoof, rollSpoofing(LEFT,RIGHT), acctno, did, phone);

  spoof_layout getSpoofHistory (spoof_layout l, DATASET(RECORDOF(dsSpoofHistory)) r) := TRANSFORM
      SELF.SpoofingHistory := PROJECT(CHOOSEN(SORT(r,-EventDate),PhoneFinder_Services.Constants.MaxSpoofedMatches),
                                                                  PhoneFinder_Services.Layouts.PhoneFinder.SpoofHistory);
      SELF := l;
  END;

  spoofInfowHistory := DENORMALIZE(spoofInfo,dsSpoofHistory,
                              LEFT.acctno = RIGHT.acctno AND
                              LEFT.did    = RIGHT.did AND
                              LEFT.phone  = RIGHT.phone,
                              GROUP,
                              getSpoofHistory(LEFT,ROWS(RIGHT)));

    //Spoof results joined with original dataset
  PhoneFinder_Services.Layouts.PhoneFinder.Final mergeSpoof(PhoneFinder_Services.Layouts.PhoneFinder.Final l,spoof_layout r) := TRANSFORM
    SELF.acctno := l.acctno;
    SELF.did    := l.did;
    SELF.phone  := l.phone;
    SELF := r;
    SELF := l;
  END;

  dPhoneInfoWSpoofing		:= JOIN(dPortedRecs,spoofInfowHistory,
                              LEFT.acctno	= RIGHT.acctno AND
                              LEFT.did		= RIGHT.did AND
                              LEFT.phone 	= RIGHT.phone,
                              mergeSpoof(LEFT,RIGHT),
                              LEFT OUTER, KEEP(1),
                              LIMIT(0));

  // original approach : display Spoofing when IncludePhoneMetadata and transaction type = ultimate and phoneriskassesment
  // Re-design approach: display Spoofing info when IncludeSpoofing = true
  dPhoneInfoUpdate_Spoofing := IF(inMod.ReturnSpoofingInfo AND EXISTS(spoofInfo), dPhoneInfoWSpoofing, dPortedRecs);

  // ---------------------------------------------------------------------------------------------------------
  // ****************************************Process OTPs****************************************************
  // ---------------------------------------------------------------------------------------------------------
  // Get OTP records
  dOTP	:= JOIN(subjectInfo, PhoneFraud.Key_OTP,
                  KEYED(LEFT.phone = RIGHT.otp_phone) AND
                  LEFT.FirstSeenDate <= (UNSIGNED) RIGHT.event_date,
                  LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));

  //Get realtime OTP data
  dDeltabaseOTP := PhoneFinder_Services.GetOTPPhones_Deltabase(subjectInfo,PhoneFinder_Services.Constants.SQLSelectLimit,dGateways);

  //Join available realtime OTPs
  dDeltaOTPwSubject := JOIN(subjectInfo,dDeltabaseOTP,
                              LEFT.phone = RIGHT.otp_phone AND
                              LEFT.FirstSeenDate <= (UNSIGNED) RIGHT.event_date,
                              LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));

  dOTPPhones := DEDUP(SORT(UNGROUP(dOTP + IF(EXISTS(subjectInfo) AND inMod.UseDeltabase,dDeltaOTPwSubject)),   //combine results
                                acctno, phone, -event_date, transaction_id),acctno, phone, event_date, transaction_id);

  dedupOTPs := 	SORT(DEDUP(SORT(dOTPPhones, acctno, phone, otp_id,
                              STD.Str.ToLowerCase(function_name) NOT IN PhoneFinder_Services.Constants.OTPVerifyTransactions,-verify_passed),
                              acctno, phone, otp_id),
                      acctno, phone,-event_date);

  dsOTPHistory := PROJECT(dedupOTPs,TRANSFORM({PhoneFinder_Services.Layouts.SubjectPhone,PhoneFinder_Services.Layouts.PhoneFinder.OTPs},
                                                  SELF.OTPStatus:= IF(STD.Str.ToLowerCase(LEFT.function_name) IN PhoneFinder_Services.Constants.OTPVerifyTransactions,
                                                                      LEFT.verify_passed,FALSE),
                                                  SELF.EventDate:= LEFT.event_date, SELF:=LEFT));
  //select necessary fields
  OTPRec := RECORD
      dOTPPhones.acctno;
      dOTPPhones.phone;
      BOOLEAN OTP := dOTPPhones.transaction_id <> '';
      UNSIGNED4 OTPCount := COUNT(GROUP,dOTPPhones.transaction_id<>'');
      UNSIGNED4 FirstOTPDate := (UNSIGNED)MIN(GROUP, dOTPPhones.event_date);
      UNSIGNED4 LastOTPDate  := (UNSIGNED)dOTPPhones.event_date;
      BOOLEAN LastOTPStatus := IF(STD.Str.ToLowerCase(dOTPPhones.function_name) IN PhoneFinder_Services.Constants.OTPVerifyTransactions,
                                          dOTPPhones.verify_passed, FALSE);
  END;
  dvalidOTP:= TABLE(GROUP(dedupOTPs,acctno, phone),OTPRec);

  {OTPRec, PhoneFinder_Services.Layouts.PhoneFinder.OneTimePassword} getOTPHistory (dvalidOTP l, DATASET(RECORDOF(dsOTPHistory)) r) := TRANSFORM
      SELF.OTPHistory := PROJECT(r, TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.OTPs, SELF:=LEFT));
      SELF := l;
  END;

  dvalidOTPwHistory := DENORMALIZE(dvalidOTP,dsOTPHistory,
                              LEFT.acctno	= RIGHT.acctno AND
                              LEFT.phone 	= RIGHT.phone,
                              GROUP,
                              getOTPHistory(LEFT,ROWS(RIGHT)));

  //Append OTP results
  PhoneFinder_Services.Layouts.PhoneFinder.Final mergeOTP(PhoneFinder_Services.Layouts.PhoneFinder.Final l,dvalidOTPwHistory r) := TRANSFORM
      SELF.OTP 						     := IF(inMod.ReturnOTPInfo,r.OTP,false);
      SELF.OTPCount 			   := IF(inMod.ReturnOTPInfo,r.OTPCount,0);
      SELF.FirstOTPDate 	 := IF(inMod.ReturnOTPInfo,r.FirstOTPDate,0);
      SELF.LastOTPDate	 	 := IF(inMod.ReturnOTPInfo,r.LastOTPDate,0);
      SELF.LastOTPStatus 	:= IF(inMod.ReturnOTPInfo,r.LastOTPStatus,false);
      SELF.OTPHistory		  	:= IF(inMod.ReturnOTPInfo,CHOOSEN(SORT(r.OTPHistory,-EventDate),PhoneFinder_Services.Constants.MaxOTPMatches),
                                          DATASET([],PhoneFinder_Services.Layouts.PhoneFinder.OTPs));
      SELF := l;
      SELF := [];
  END;

  dPhoneInfowOTP := JOIN(dPhoneInfoUpdate_Spoofing,dvalidOTPwHistory,
                          LEFT.acctno	= RIGHT.acctno AND
                          LEFT.phone 	= RIGHT.phone,
                          mergeOTP(LEFT,RIGHT),
                          LEFT OUTER, KEEP(1),
                          LIMIT(0));

  // original approach : display OTP when IncludePhoneMetadata
  // Re-design approach: display OTP info when IncludeOTP = true
  dPhoneInfoUpdate_OTP := IF(inMod.ReturnOTPInfo AND EXISTS(dvalidOTP), dPhoneInfowOTP, dPhoneInfoUpdate_Spoofing);

  #IF(PhoneFinder_Services.Constants.Debug.PhoneMetadata)
    OUTPUT(dInRecs,NAMED('dInRecs'));
    OUTPUT(dInBestInfo,NAMED('dInBestInfo'));
   	OUTPUT(dSearchRecs,NAMED('dSearchRecs_metadata'));
   	// OUTPUT(phoneStateUpdate,NAMED('phoneStateUpdate'));
    // OUTPUT(bestInfo,NAMED('bestInfo'));
    // OUTPUT(phonewBestAddr,NAMED('phonewBestAddr'));
    // OUTPUT(ds_zip,NAMED('ds_zip'));
    // OUTPUT(ds_cityState,NAMED('ds_cityState'));
    // OUTPUT(dSearchRecswAddrType,NAMED('dSearchRecswAddrType'));
    OUTPUT(dPhoneInquiryRecs_final,NAMED('dPhoneInquiryRecs_final'));
    OUTPUT(dPhoneInfoWPorting,NAMED('dPhoneInfoWPorting'));
    OUTPUT(dPortedRecs,NAMED('dPortedRecs'));
		// OUTPUT(dssubjects,NAMED('dsSubjects'));
		// OUTPUT(subjectInfo,NAMED('subjectInfo'));
		// OUTPUT(dDeltabaseSpoofed,NAMED('dDeltabaseSpoofed'));
		// OUTPUT(dSpoofedPhones,NAMED('dSpoofedPhones'));
		// OUTPUT(dSpoof,NAMED('dSpoof'));
		// OUTPUT(transformSpoof,NAMED('transformSpoof'));
		// OUTPUT(spoofInfo,NAMED('spoofInfo'));
		// OUTPUT(spoofInfowHistory,NAMED('spoofInfowHistory'));
	  OUTPUT(dPhoneInfoUpdate_Spoofing,NAMED('dPhoneInfoUpdate_Spoofing'));
		// OUTPUT(dOTP,NAMED('dOTPIndex'));
		// OUTPUT(dDeltaOTPwSubject,NAMED('dDeltaOTPwSubject'));
		// OUTPUT(dOTPPhones,NAMED('dOTPPhones'));
		OUTPUT(dedupOTPs,NAMED('dedupOTPs'));
		OUTPUT(dsOTPHistory,NAMED('dsOTPHistory'));
		OUTPUT(dvalidOTP,NAMED('dvalidOTP'));
		OUTPUT(dvalidOTPwHistory,NAMED('dvalidOTPwHistory'));
		OUTPUT(dPhoneInfowOTP,NAMED('dPhoneInfowOTP'));
		OUTPUT(dPhoneInfoUpdate_OTP,NAMED('dPhoneInfoUpdate_OTP'));
	#END;

	RETURN SORT(dPhoneInfoUpdate_OTP, acctno, seq);

	ENDMACRO;