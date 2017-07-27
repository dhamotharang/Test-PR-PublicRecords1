IMPORT Doxie, Gateway, Iesp, Phones, PhonesInfo, STD, UT;

EXPORT GetPhoneMetadata_wLIDB(DATASET(Phones.Layouts.PhoneAttributes.BatchIn) dBatchPhonesIn,
	Phones.IParam.PhoneAttributes.BatchParams in_mod) := FUNCTION
	Consts 					:= Phones.Constants.PhoneAttributes;
	Layout_BatchOut := Phones.Layouts.PhoneAttributes.BatchOut;
	Layout_BatchRaw	:= Phones.Layouts.PhoneAttributes.Raw;
	today 	 				:= STD.Date.Today();
	

	//Get phone data from Roxie
	dPortedMetadataPhones := JOIN(dBatchPhonesIn, PhonesInfo.Key_Phones.Ported_Metadata,
	KEYED(LEFT.phoneno = RIGHT.phone),
	TRANSFORM(Layout_BatchRaw,
		SELF.acctno := LEFT.acctno,
		SELF				:= RIGHT),
	LIMIT(0), KEEP(Consts.MaxRecsPerPhone));
	
	// Check deltabase for new acquired data
	phoneRec := {STRING10 phone};
	listOfPhones := PROJECT(DEDUP(SORT(dBatchPhonesIn,phoneno),phoneno),TRANSFORM(phoneRec,SELF.phone:=LEFT.phoneno));
	
	dGateways 		 := in_mod.gateways;
	deltaATTPhones := Phones.GetATTPhones_Deltabase(listOfPhones,,dGateways);
	filteredDeltaATTPhones := DEDUP(SORT(deltaATTPhones(reply_code<>'' AND account_owner<>'' AND carrier_name<>'' AND carrier_category<>'' AND
																											local_area_transport_area<>'' AND point_code<>'')
																			,acctno,phone,-vendor_last_reported_dt,-vendor_last_reported_time),acctno,phone);
	
	dPortedDeltaPhones := JOIN(dBatchPhonesIn, filteredDeltaATTPhones,
		LEFT.phoneno = RIGHT.phone,
		TRANSFORM(Layout_BatchRaw,
			SELF.acctno := LEFT.acctno,
			SELF.phone  := LEFT.phoneno,
			SELF				:= RIGHT),
		LIMIT(0), KEEP(Consts.MaxRecsPerPhone));		

	// Combine thor and deltabase to eliminate duplicates
	dPortedPhones  := DEDUP(SORT(dPortedMetadataPhones + dPortedDeltaPhones,
																	acctno,phone,-dt_last_reported,-port_start_dt,-port_start_time,-swap_start_dt,-swap_start_time,-deact_start_dt,-deact_start_time,-react_start_dt,-react_start_time,reference_id),
																	acctno,phone, dt_last_reported, port_start_dt, port_start_time, swap_start_dt, swap_start_time, deact_start_dt, deact_start_time, react_start_dt, react_start_time,reference_id);	

	// identify latest records per phone that need real time update
	latestPhoneRecs := DEDUP(SORT(dPortedPhones,phone,-MAX(dt_last_reported,port_start_dt, swap_start_dt, deact_start_dt, react_start_dt)),phone);
	outdatedLIDB    := (UNSIGNED)ut.date_math((STRING)today, -in_mod.max_lidb_age_days);
	oldOrIncompleteRecs	  := latestPhoneRecs(MAX( dt_last_reported,port_start_dt, swap_start_dt, deact_start_dt, react_start_dt) 
																										<= outdatedLIDB //old records
																					OR(source <> Consts.ATT_LIDB_Delta AND (line='' OR serv=''))); //missing line and serv types	
														
	// identify phone for which no data was acquired
	noDataPhones 	:= JOIN(listOfPhones,PROJECT(latestPhoneRecs,phoneRec),
												LEFT.phone=RIGHT.phone,
												LEFT ONLY);
	attLIBD_enabled := in_mod.use_realtime_lidb AND ~Doxie.DataRestriction.isATT_LIDBRestricted(in_mod.DataRestrictionMask);
	needRealtimeUpdate := IF(attLIBD_enabled,noDataPhones + PROJECT(oldOrIncompleteRecs,phoneRec)); 
	
	// get real time LIDB data
	attGateway  := dGateways(Gateway.Configuration.IsAttIapQuery(servicename))[1];
	iesp.att_iap.t_IapResponseMessage getRealTimeLIDB (phoneRec l) := TRANSFORM
		in_response := Gateway.Soapcall_ATTPhoneSearch(l.phone,attGateway,attLIBD_enabled)[1];
		realTimeRec := PROJECT(DATASET(in_response.response.ATTMessage), TRANSFORM(iesp.att_iap.t_IapResponseMessage, SELF:=LEFT, SELF:=[]));		
		SELF.AttResponse:=PROJECT(realTimeRec[1].AttResponse, TRANSFORM(iesp.att_iap.t_IapResponseData, SELF:=LEFT, SELF:=[]));
		SELF.EchoData := PROJECT(realTimeRec[1].EchoData, TRANSFORM(iesp.att_iap.t_IapEchoData, SELF:=LEFT, SELF:=[]));
		SELF:=[]
	END;	
	realTimeLIDB:= IF(EXISTS(needRealtimeUpdate) AND attGateway.url<>'',PROJECT(DEDUP(needRealtimeUpdate,phone,ALL), getRealTimeLIDB(LEFT)));
	
	Layout_BatchRaw transformRealTimeLIDB (iesp.att_iap.t_IapResponseMessage l) := TRANSFORM
		eventDate := IF(l.ATTResponse.Status='OK',today,0);
		SELF.phone := l.EchoData.Custom1; 
		SELF.source := Consts.ATT_LIDB_RealTime; // identifier to track royalties for RealTime ATT
		SELF.dt_first_reported := eventDate;
		SELF.dt_last_reported := eventDate;
		SELF.reply_code := l.ATTResponse.InformationRetrievalResponse.DataGatewayReplyCode;
		SELF.account_owner := l.ATTResponse.InformationRetrievalResponse.AccountOwner;
		SELF.carrier_name := l.ATTResponse.InformationRetrievalResponse.CarrierName;
		SELF.carrier_category := l.ATTResponse.InformationRetrievalResponse.Category;
		SELF.local_area_transport_area := l.ATTResponse.InformationRetrievalResponse.LocalAccessAndTransport;
		SELF.point_code := l.ATTResponse.InformationRetrievalResponse.PointCode;
		SELF:=[];
	END;
	dsRealTimeLIDB:= PROJECT(realTimeLIDB, transformRealTimeLIDB(LEFT))(phone<>'');
	dsUpdatedLIDB := JOIN(dBatchPhonesIn, dsRealTimeLIDB,
												LEFT.phoneno = RIGHT.phone,
												TRANSFORM(Layout_BatchRaw,
												SELF.acctno:=LEFT.acctno,
												SELF.phone:=LEFT.phoneno,
												SELF:=RIGHT,
												SELF:=[]),
												LIMIT(0),KEEP(Consts.MaxRecsPerPhone));
	// update carrier reference info											
	dPortedPhoneswLineType := JOIN(IF(EXISTS(dsRealTimeLIDB),dsUpdatedLIDB + dPortedPhones,dPortedPhones), 
																 PhonesInfo.Key_Source_Reference.ocn_name,
																	KEYED(LEFT.account_owner = RIGHT.ocn) AND
																	PhonesInfo._Functions.fn_standardName(LEFT.carrier_name) = RIGHT.name AND
																	RIGHT.is_current,
																	TRANSFORM(Layout_BatchRaw,SELF.serv:=RIGHT.serv,
																														SELF.line:=RIGHT.line,
																														SELF.spid:=RIGHT.spid,
																														SELF.operator_fullname:=RIGHT.operator_full_name,
																														SELF.source := IF(LEFT.source=Consts.ATT_LIDB_Delta,Consts.ATT_LIDB_SRC,LEFT.source),
																														SELF:=LEFT,SELF:=[]),
																	LEFT OUTER, LIMIT(0), KEEP(1));	
	#IF(Phones.Constants.Debug.PhoneMetadata_wLIDB)																	
		output(dGateways, named('dGateways'));
		output(listOfPhones, named('listOfPhones'));
		output(dBatchPhonesIn, named('dBatchPhonesIn'));
		output(deltaATTPhones, named('deltaATTPhones'));
		output(dPortedDeltaPhones, named('dPortedDeltaPhones'));
		output(dPortedMetadataPhones, named('dPortedMetadataPhones'));
		output(dPortedPhones, named('dPortedPhones'));
		output(latestPhoneRecs, named('latestPhoneRecs'));		
		output(outdatedLIDB, named('outdatedLIDB'));	
		output(noDataPhones, named('noDataPhones'));	
		output(oldOrIncompleteRecs, named('oldOrIncompleteRecs'));	
		output(needRealtimeUpdate, named('needRealtimeUpdate'));		
		output(attGateway, named('attGateway'));	
		output(realTimeLIDB, named('realTimeLIDB'));	
		output(dsRealTimeLIDB, named('dsRealTimeLIDB'));	
		output(dsUpdatedLIDB, named('dsUpdatedLIDB'));	
		output(dPortedPhoneswLineType, named('dPortedPhoneswLineType'));
	#END
	RETURN dPortedPhoneswLineType;

END;