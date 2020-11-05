IMPORT  Gateway, MDR, PhoneFinder_Services, STD, ut, Phones;

EXPORT GetPhonesPortedMetadata(DATASET(PhoneFinder_Services.Layouts.PhoneFinder.Final) dSearchRecs0,
													     PhoneFinder_Services.iParam.SearchParams inMod,
													     DATASET(Gateway.Layouts.Config) dGateways,
													     DATASET(	PhoneFinder_Services.Layouts.SubjectPhone) subjectInfo,
													     DATASET(PhoneFinder_Services.Layouts.PortedMetadata) accu_rpt = DATASET([], PhoneFinder_Services.Layouts.PortedMetadata)) :=
FUNCTION

  currentDate := (STRING)STD.Date.Today();

  //Based on subject info get ALL ports and CURRENT deact records
  dInPhones := DEDUP(SORT(PROJECT(subjectInfo, TRANSFORM(Phones.Layouts.PhoneAttributes.BatchIn, SELF.phoneno := LEFT.Phone, SELF := [])), phoneno), phoneno);
  in_mod := MODULE(Phones.IParam.BatchParams)
  EXPORT UNSIGNED	max_age_days := Phones.Constants.PhoneAttributes.LastActivityThreshold;
  EXPORT BOOLEAN AllowPortingData := inMod.AllowPortingData;
  END;
  dsPhonesmetadata:= PROJECT(Phones.GetPhoneMetadata_wLERG6(dInPhones, in_mod), TRANSFORM(Phones.Layouts.portedMetadata_Main, SELF := LEFT));

  dPorted	:= JOIN(subjectInfo, dsPhonesmetadata,
                 (LEFT.phone = RIGHT.phone) AND
                  ((LEFT.FirstSeenDate <= RIGHT.port_start_dt) OR
                    (LEFT.FirstSeenDate <= RIGHT.dt_last_reported) OR
                    (RIGHT.deact_code=PhoneFinder_Services.Constants.PortingStatus.Disconnected AND RIGHT.is_deact='Y')),
                    LIMIT(PhoneFinder_Services.Constants.MetadataLimit, SKIP));

  //Check if realtime data was requested
  dDeltabasePorted := PhoneFinder_Services.GetPortedPhones_Deltabase(subjectInfo, PhoneFinder_Services.Constants.SQLSelectLimit, dGateways);

  //Join available realtime ports. Deact data is NOT available in realtime
  dDeltabasewSubject := JOIN(subjectInfo, dDeltabasePorted,
                              LEFT.phone = RIGHT.phone AND
                              RIGHT.source IN MDR.sourceTools.set_PhonesPorted AND
                              LEFT.FirstSeenDate <= RIGHT.port_start_dt,
                              KEEP(PhoneFinder_Services.Constants.MaxPortedMatches), LIMIT(0));

  //Join to Accudata OCN porting
  dAccudata := JOIN(subjectInfo, accu_rpt,
                    LEFT.phone = RIGHT.phone AND
                    LEFT.FirstSeenDate <= RIGHT.port_start_dt,
                    KEEP(PhoneFinder_Services.Constants.MaxPortedMatches), LIMIT(0));

  // Get the latest phone activities per acctno, per did
  dPortedPhones := TOPN(GROUP(SORT(dPorted + dAccudata + IF(EXISTS(subjectInfo) AND inMod.UseDeltabase, dDeltabasewSubject),   //combine results
                              acctno, phone, MAX(-dt_last_reported, -port_start_dt)), acctno, phone),
                        PhoneFinder_Services.Constants.MaxPortedMatches, acctno, phone, MAX(-dt_last_reported, -port_start_dt));

  // There are 4 sources in Ported_Metadata - PK, PB, PX, L6.
  // PB records will NOT have a port_start_dt and are base records created for gong and phonesplus records without any ports.
  // PX records will NOT have a port_start_dt and represents disconnect activities.
  // Both PB and PX will be ordered by dt_last_reported.
  // PK represents actual moves between carriers record by port_start_dt. These records will have a zero dt_last_reported value
  // L6 gives carrier information
  sortedPorts  := GROUP(SORT(dPortedPhones, acctno, phone, port_start_dt=0, port_start_dt, spid, -deact_start_dt, -dt_last_reported),
                        acctno, phone, spid);

	// select necessary fields
  portedRec :=
  RECORD
    sortedPorts.acctno;
    sortedPorts.did;
    sortedPorts.phone;
    sortedPorts.spid;
    sortedPorts.source;
    sortedPorts.operator_fullname;

    UNSIGNED1 PortingCount 			:= (UNSIGNED)(sortedPorts.source IN MDR.sourceTools.set_PhonesPorted);
    UNSIGNED4 FirstPortedDate 	:= sortedPorts.port_start_dt;
    UNSIGNED4 LastPortedDate  	:= MAX(MAX(GROUP, sortedPorts.port_end_dt), MAX(GROUP, sortedPorts.port_start_dt));
    UNSIGNED4 PortStartDate 		:= sortedPorts.port_start_dt;
    UNSIGNED4 PortEndDate  			:= MAX(MAX(GROUP, sortedPorts.port_end_dt), MAX(GROUP, sortedPorts.port_start_dt));
    UNSIGNED4 ActivationDate 		:= MAX(GROUP, sortedPorts.react_start_dt);		//for PFv2 - activation data not ready
    UNSIGNED4 DisconnectDate 		:= MAX(GROUP, sortedPorts.deact_start_dt);
    BOOLEAN   NoContractCarrier := MAX(GROUP, (integer) sortedPorts.high_risk_indicator) >0;
    BOOLEAN   Prepaid 					:= MAX(GROUP, (integer) sortedPorts.prepaid) > 0;
    UNSIGNED4 dt_last_reported	:= MAX(GROUP, sortedPorts.dt_last_reported);
  END;

  disconnects_src := [MDR.sourceTools.src_Phones_Disconnect, MDR.sourceTools.src_Phones_Gong_History_Disconnect];
  dPorts := UNGROUP(TABLE(sortedPorts(source NOT IN [disconnects_src, MDR.sourceTools.src_Phones_Lerg6, MDR.sourceTools.src_PhoneFraud_OTP, MDR.sourceTools.src_Phones_LIDB]), portedRec));
  dDisconnects := UNGROUP(TABLE(sortedPorts(source IN disconnects_src), portedRec));
  dPortedInfo := dPorts + dDisconnects;

  Porting_layout := RECORD
			portedRec;
			PhoneFinder_Services.Layouts.PhoneFinder.Porting;
	END;

	transformPort := PROJECT(dPortedInfo,
                            TRANSFORM(Porting_layout,
                                      SELF.PortingHistory := IF(LEFT.PortingCount > 0,
                                                                PROJECT(LEFT,
                                                                        TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.PortHistory,
                                                                                  SELF.PortStartDate 		:= LEFT.PortStartDate,
                                                                                  SELF.PortEndDate 			:= LEFT.PortEndDate,
                                                                                  SELF.ServiceProvider 	:= TRIM(LEFT.operator_fullname, LEFT, RIGHT)))),
                                      SELF := LEFT,
                                      SELF := []));                            

	// The carrier often sends updates which are identified by repeated spids based on the sequencing of FirstPortedDate
	Porting_layout rollports(transformPort l, transformPort r) := TRANSFORM
    // Use to identify most current phone values - distinguishing btw PB (using dt_last_reported) and actual port records received (using port dates).
    mostCurrent := MAX(l.LastPortedDate, l.dt_last_reported) > MAX(r.LastPortedDate, r.dt_last_reported);

    SELF.PortingCount 		 := IF(l.spid <> r.spid AND r.source NOT IN disconnects_src,
                                  l.PortingCount + r.PortingCount, l.PortingCount);
    PortingHistory         := l.PortingHistory + r.PortingHistory;                              
    SELF.PortingHistory 	 := IF(r.source NOT IN disconnects_src,
                                                  PortingHistory(PortStartDate <> 0 AND PortEndDate <> 0), l.PortingHistory);
    SELF.LastPortedDate 	 := MAX(l.LastPortedDate, r.LastPortedDate);
    SELF.ActivationDate 	 := MAX(l.ActivationDate, r.ActivationDate);
    SELF.DisconnectDate 	 := MAX(l.DisconnectDate, r.DisconnectDate);
    SELF.Prepaid				 	 := IF(mostCurrent, l.Prepaid, r.Prepaid);
    SELF.NoContractCarrier := IF(mostCurrent, l.NoContractCarrier, r.NoContractCarrier);
    SELF.spid				 			 := IF(mostCurrent, l.spid, r.spid);
    SELF := l;
	END;

  // Should be rolled up on acctno, phone NOT acctno, did, phone
	dPortedDisconnectRolled		:= ROLLUP(SORT(transformPort, acctno, phone, FirstPortedDate=0, FirstPortedDate),
															LEFT.acctno = RIGHT.acctno AND
															LEFT.phone 	= RIGHT.phone,
															rollports(LEFT, RIGHT));

		//Final results joined with original dataset
	PhoneFinder_Services.Layouts.PhoneFinder.Final UpdatePhoneInfo(dSearchRecs0 l, dPortedDisconnectRolled r) := TRANSFORM
    hasPort := r.PortingCount > 0;
    // hasMetadata := l.phone=r.phone;
    SELF.PortingCode    := MAP(hasPort => 'Ported',
                                (NOT inMod.SubjectMetadataOnly OR l.isprimaryphone)=> 'Not Ported',
                                '');
    SELF.PortingCount    := IF(inMod.ReturnPortingInfo, r.PortingCount, l.PortingCount);
    SELF.PortingHistory  := IF(inMod.ReturnPortingInfo, CHOOSEN(SORT(DEDUP(r.PortingHistory, RECORD, ALL), -PortEndDate), PhoneFinder_Services.Constants.MaxPortedMatches), l.PortingHistory);
    SELF.FirstPortedDate := IF(inMod.ReturnPortingInfo, r.FirstPortedDate, l.FirstPortedDate);
    SELF.LastPortedDate  := IF(inMod.ReturnPortingInfo, r.LastPortedDate, l.LastPortedDate);
    SELF.NoContractCarrier  := IF(inMod.ReturnPortingInfo, r.NoContractCarrier, l.NoContractCarrier);
    SELF.Prepaid				 := IF(inMod.ReturnPortingInfo AND l.isprimaryphone, r.Prepaid, l.Prepaid); //Right has no information about other phones, also, prepaid info should only be shown for ReturnPortingInfo
    // deact_thresholdcheck := Std.Date.IsValidDate(r.DisconnectDate) AND (ut.DaysApart((STRING)r.DisconnectDate, currentDate) <= PhoneFinder_Services.Constants.PortingStatus.DisconnectedPhoneThreshold);
    SELF.PhoneStatus     :=  l.PhoneStatus;
    SELF.ActivationDate  := IF(l.PhoneStatus = PhoneFinder_Services.Constants.PhoneStatus.Active, r.ActivationDate, 0);
    SELF.DisconnectDate  := IF(l.PhoneStatus = PhoneFinder_Services.Constants.PhoneStatus.INACTIVE, r.DisconnectDate, 0);
    // Override TU data to use LIBD and Port data when available
    //Commenting out for now since we get this information in getPhonedetails
    // SELF.serviceType  	 := r.serviceType;
    // SELF.RealTimePhone_Ext.ServiceClass := IF(hasMetadata, (STRING)r.serviceType, l.RealTimePhone_Ext.ServiceClass);
    // SELF.COC_description := l.COC_description;
    SELF.PortingStatus   := '';
		/*
    // Temporarily remove until better disconnect data is obtained
    IF(r.DisconnectDate >= r.ActivationDate AND r.is_deact, PhoneFinder_Services.Constants.PhoneStatus.Inactive,
                                                                                    PhoneFinder_Services.Constants.PhoneStatus.Active);
    //override existing statuscode if porting data indicate phone is inactive to resolve conflicting report.
    updTURecs := SELF.PortingStatus = PhoneFinder_Services.Constants.PhoneStatus.Inactive;
    SELF.realtimephone_ext.statuscode := IF(updTURecs, PhoneFinder_Services.Constants.PhoneInactiveStatus, l.realtimephone_ext.statuscode);
    SELF.realtimephone_ext.statuscode_desc := IF(updTURecs, PhoneFinder_Services.Constants.PhoneStatus.Inactive, l.realtimephone_ext.statuscode_desc);
    SELF.realtimephone_ext.statuscode_flag := IF(updTURecs, '', l.realtimephone_ext.statuscode_flag);
    SELF.realtimephone_ext.statuscode_flagdesc := IF(updTURecs, '', l.realtimephone_ext.statuscode_flagdesc);
    */
    SELF := l;
    SELF := [];
	END;

	dPhoneMetadataWPorting := JOIN(dSearchRecs0, dPortedDisconnectRolled,
                                  LEFT.acctno	= RIGHT.acctno AND
                                  LEFT.phone 	= RIGHT.phone,
                                  UpdatePhoneInfo(LEFT, RIGHT),
                                  LEFT OUTER, KEEP(1),
                                  LIMIT(0));

  #IF(PhoneFinder_Services.Constants.Debug.PhoneMetadata)
	    OUTPUT(dPorted, NAMED('dPorted'));
	    OUTPUT(dDeltabasePorted, NAMED('dDeltabasePorted'));
	    OUTPUT(dPortedInfo, NAMED('dPortedInfo'));
	    OUTPUT(dPortedPhones, NAMED('dPortedPhones_getportedmetadata'));
		   OUTPUT(transformPort, NAMED('transformPort'));
		   OUTPUT(dPortedDisconnectRolled, NAMED('dPortedDisconnectRolled'));
	    OUTPUT(dphonemetadataWPorting, NAMED('dphonemetadataWPorting'));
	#END;

	RETURN dPhoneMetadataWPorting;

END;