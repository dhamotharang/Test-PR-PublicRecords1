IMPORT Advo,DID_Add, Gateway, Inquiry_AccLogs,MDR,PhoneFinder_Services,PhoneFraud,PhonesInfo,Phones,Risk_Indicators, std, ut;
	EXPORT GetPhonesMetadata(DATASET(PhoneFinder_Services.Layouts.PhoneFinder.Final) dSearchRecs0, 
													 PhoneFinder_Services.iParam.ReportParams inMod, 
													 DATASET(Gateway.Layouts.Config) dGateways, 
													 DATASET(PhoneFinder_Services.Layouts.BatchInAppendDID) dInBestInfo,
													 DATASET(PhoneFinder_Services.Layouts.BatchInAppendDID) dInPhone,
													 DATASET(PhoneFinder_Services.Layouts.PortedMetadata) accu_rpt = DATASET([],PhoneFinder_Services.Layouts.PortedMetadata)) :=
	FUNCTION

  displayAll := inMod.TransactionType in [PhoneFinder_Services.Constants.TransType.PREMIUM,
																						PhoneFinder_Services.Constants.TransType.ULTIMATE,
																						PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT];	
	
  dInRecs	:= IF(inMod.TransactionType=PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT,
																PROJECT(dInPhone,TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.Final,
																																SELF.acctno:=LEFT.acctno, 
																																SELF.seq:=LEFT.seq, 
																																SELF.phone:=LEFT.homephone, 
																																SELF.batch_in.homephone:=LEFT.homephone, 
																																SELF:=[])),
																dSearchRecs0);	
	
  //phone searches do not generate other phones related to the subject, hence all phone searches are subject related.
	needPortingInfo 	:= IF(inMod.SubjectMetadataOnly,dInRecs(isprimaryphone OR batch_in.homephone<>''),dInRecs);

	//reduce layout by selecting necessary fields
	PhoneFinder_Services.Layouts.SubjectPhone getSubjectPhone(needPortingInfo l) := TRANSFORM
			SELF.acctno := l.acctno;
			SELF.did := l.did;
			SELF.phone := l.phone;
			//If phone record occurs after first_seen minus 5 days the date field in the port/spoof table will associate active with subject.
			SELF.FirstSeenDate := IF((UNSIGNED)l.dt_first_seen<> 0,(UNSIGNED)ut.date_math(l.dt_first_seen, -PhoneFinder_Services.Constants.PortingMarginOfError),0);
			SELF.LastSeenDate  := IF((UNSIGNED)l.dt_last_seen <> 0,(UNSIGNED)ut.date_math(l.dt_last_seen, PhoneFinder_Services.Constants.PortingMarginOfError), 0); 
	END;
	dsSubjects := PROJECT(needPortingInfo,getSubjectPhone(LEFT));			
			
		//rollup to get comprehensive port period
	PhoneFinder_Services.Layouts.SubjectPhone rollSubject(PhoneFinder_Services.Layouts.SubjectPhone l,PhoneFinder_Services.Layouts.SubjectPhone r) := TRANSFORM
			SELF.FirstSeenDate := ut.Min2(l.FirstSeenDate,r.FirstSeenDate);
			SELF               := l;
	END;
	subjectInfo:= ROLLUP(SORT(dsSubjects,acctno,did,phone,-LastSeenDate,FirstSeenDate),
														LEFT.acctno=RIGHT.acctno AND
														LEFT.did=RIGHT.did AND
														LEFT.phone=RIGHT.phone,
														rollSubject(LEFT,RIGHT));	
	// ---------------------------------------------------------------------------------------------------------
	// ****************************************Process Location*************************************************
	// ---------------------------------------------------------------------------------------------------------																
	PhoneFinder_Services.Layouts.PhoneFinder.Final UpdatePrimaryAddress (PhoneFinder_Services.Layouts.PhoneFinder.Final l, dInBestInfo r) := TRANSFORM
		bestMatch := l.acctno=r.acctno and l.did=r.did;
		SELF.prim_range 	:= IF(bestMatch,r.prim_range,l.prim_range);
		SELF.predir 			:= IF(bestMatch,r.predir,l.predir);
		SELF.prim_name 		:= IF(bestMatch,r.prim_name,l.prim_name);
		SELF.suffix 			:= IF(bestMatch,r.addr_suffix,l.suffix);
		SELF.postdir 			:= IF(bestMatch,r.postdir,l.postdir);
		SELF.sec_range 		:= IF(bestMatch,r.sec_range,l.sec_range);
		SELF.city_name 		:= IF(bestMatch,r.p_city_name,l.city_name);
		SELF.st 					:= IF(bestMatch,r.st,l.st);
		SELF.zip 					:= IF(bestMatch,r.z5,l.zip);
		SELF.phone_vendor	:= IF(bestMatch,'BA',l.phone_vendor); // identify info as coming from best rec, is not display in final output
		SELF.isprimaryphone := l.isprimaryphone;
		SELF := l;
	END; // Update Best identity to match final output to ensure PRI below is based on final display 

	dSearchRecs 			:=	JOIN(SORT(dInRecs,acctno,-isprimaryphone,did,-dt_last_seen,dt_first_seen),dInBestInfo,
															LEFT.acctno = RIGHT.acctno AND
															(	(LEFT.did = RIGHT.did AND LEFT.batch_in.homephone <>'') OR 
																(LEFT.batch_in.did = RIGHT.did AND LEFT.isprimaryphone)),
															UpdatePrimaryAddress(LEFT,RIGHT),
															LEFT OUTER,
															KEEP(1),LIMIT(0));
													
	phoneStateUpdate  := JOIN(dSearchRecs, risk_indicators.Key_Telcordia_tds,
											KEYED(LEFT.phone[1..3]=RIGHT.npa) AND 
											KEYED(LEFT.phone[4..6]=RIGHT.nxx),
											TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.Final,
																SELF.PhoneState:=RIGHT.state,
																SELF:=LEFT,
																SELF:=[]),
											LEFT OUTER, LIMIT(0), KEEP(1));		
	bestinfo:= PhoneFinder_Services.Functions.GetBestInfo(PROJECT(phoneStateUpdate,
																																TRANSFORM(PhoneFinder_Services.Layouts.BatchInAppendDID, 
																																SELF.DOB := (STRING)LEFT.DOB,
																																SELF.DOD := (STRING)LEFT.DOD,
																																SELF:=LEFT,SELF:=[])));	
											
	bestAddrRec := RECORD
		PhoneFinder_Services.Layouts.PhoneFinder.Final;
			STRING10  	best_prim_range 		:= '';
			STRING2   	best_predir     		:= '';
			STRING28  	best_prim_name  		:= '';
			STRING4   	best_addr_suffix 		:= '';
			STRING2   	best_postdir    		:= '';			
			STRING8   	best_sec_range  	 	:= '';
			STRING25  	best_city_name			:= '';
			STRING2   	best_st          		:= '';
			STRING5   	best_z5      		  	:= '';
	END;

	bestAddrRec updateBestAddr (PhoneFinder_Services.Layouts.PhoneFinder.Final l, PhoneFinder_Services.Layouts.BatchInAppendDID r):=TRANSFORM
			SELF.best_prim_range 		:= r.prim_range;
			SELF.best_predir     		:= r.predir;
			SELF.best_prim_name  		:= r.prim_name;
			SELF.best_addr_suffix 	:= r.addr_suffix;
			SELF.best_postdir    		:= r.postdir;			
			SELF.best_sec_range  	 	:= r.sec_range;
			SELF.best_city_name			:= r.p_city_name;
			SELF.best_st          	:= r.st;
			SELF.best_z5      		  := r.z5;	
			SELF.tnt 								:= MAP((UNSIGNED)l.did = 0 => '',
																		(DID_Add.Address_Match_Score(l.prim_range, l.prim_name, l.sec_range, l.zip, 
																		r.prim_range, r.prim_name, r.sec_range, r.z5) BETWEEN 76 AND 254)
																		AND l.prim_range=r.prim_range =>'C',
																		'H');
			SELF.Deceased           := IF(r.dod != '','Y','N');																
			SELF:= l;
	END;
	phonewBestAddr:= JOIN(phoneStateUpdate, bestInfo, // compare best address for all identities
												LEFT.acctno=RIGHT.acctno AND
												LEFT.did=RIGHT.did,
												updateBestAddr(LEFT, RIGHT),
												LEFT OUTER, LIMIT(0), KEEP(1));							
											
	//Look up data by address (using zip)
	ds_zip := join(phonewBestAddr,Advo.Key_Addr1,
			KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_z5 !='' AND LEFT.best_z5 = RIGHT.zip ,LEFT.zip != '' AND LEFT.zip = RIGHT.zip)) AND
			KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_prim_range = RIGHT.prim_range, LEFT.prim_range = RIGHT.prim_range)) AND
			KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_prim_name = RIGHT.prim_name,LEFT.prim_name = RIGHT.prim_name)) AND
			KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_addr_suffix = RIGHT.addr_suffix,LEFT.suffix = RIGHT.addr_suffix)) AND
			KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_predir = RIGHT.predir,LEFT.predir = RIGHT.predir)) AND
			KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_postdir = RIGHT.postdir,LEFT.postdir = RIGHT.postdir)),
			// AND
			// KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_sec_range = RIGHT.sec_range, LEFT.sec_range = RIGHT.sec_range)),
			TRANSFORM(bestAddrRec,
				SELF.primary_address_type := Advo.Lookup_Descriptions.fn_resbus_mixed(RIGHT.Residential_Or_Business_Ind),
				SELF := LEFT),LEFT OUTER,
			LIMIT(0),KEEP(1));
			
	//  Look up data by address (using City/State)
	ds_cityState := join(ds_zip(TRIM(primary_address_type)=''),Advo.Key_Addr2,
													KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_st != '' AND LEFT.best_city_name != '' AND LEFT.best_st = RIGHT.st,
																					 LEFT.st != '' AND LEFT.city_name != '' AND LEFT.st = RIGHT.st)) AND
													KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_city_name = RIGHT.v_city_name,LEFT.city_name = RIGHT.v_city_name)) AND
													KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_prim_range = RIGHT.prim_range,LEFT.prim_range = RIGHT.prim_range)) AND
													KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_prim_name = RIGHT.prim_name,LEFT.prim_name = RIGHT.prim_name)), 
													// AND											
													// KEYED(IF(LEFT.best_prim_range <> '', LEFT.best_sec_range = RIGHT.sec_range,LEFT.sec_range = RIGHT.sec_range)),
													TRANSFORM(bestAddrRec,
																		SELF.primary_address_type := Advo.Lookup_Descriptions.fn_resbus_mixed(RIGHT.Residential_Or_Business_Ind),
																		SELF := LEFT),LEFT OUTER,
													LIMIT(0),KEEP(1));								
	dSearchRecswAddrType:=ds_zip(TRIM(primary_address_type)<>'')+ds_cityState;

	// ---------------------------------------------------------------------------------------------------------
	// ****************************************Process Phone Inquiry********************************************
	// ---------------------------------------------------------------------------------------------------------	

	InquiryHistory:=Inquiry_AccLogs.Key_Inquiry_Phone;	
	InquiryDaily:=Inquiry_AccLogs.Key_Inquiry_Phone_Update;	
	bestAddrRec getInquiries(dSearchRecswAddrType l, DATASET(RECORDOF(InquiryDaily)) r ):= TRANSFORM
		SELF.InquiryDates := DEDUP(SORT(l.InquiryDates + PROJECT(r,TRANSFORM({STRING17 InquiryDate}
																						,SELF.InquiryDate:=LEFT.search_info.datetime)),InquiryDate),InquiryDate);
		SELF := l;

	END;

	dSearchRecswInqHistory	:= DENORMALIZE(dSearchRecswAddrType,InquiryHistory,
															KEYED(LEFT.phone=RIGHT.phone10) AND
															LEFT.dt_first_seen <= RIGHT.search_info.datetime[1..8] AND
															STD.Str.Find(TRIM(RIGHT.search_info.function_description,ALL),'PHONEFINDER')>0,
															GROUP,
															getInquiries(LEFT,ROWS(RIGHT)),
															LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));			
	dSearchRecswLocInfo	:= DENORMALIZE(dSearchRecswInqHistory,InquiryDaily,
															KEYED(LEFT.phone=RIGHT.phone10) AND
															LEFT.dt_first_seen <= RIGHT.search_info.datetime[1..8] AND
															STD.Str.Find(TRIM(RIGHT.search_info.function_description,ALL),'PHONEFINDER')>0,
															GROUP,
															getInquiries(LEFT,ROWS(RIGHT)),
															LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));						
	// ---------------------------------------------------------------------------------------------------------
	// ****************************************Process PORTS****************************************************
	// ---------------------------------------------------------------------------------------------------------
		//Based on subject info get ALL ports and CURRENT deact records
	dPorted	:= JOIN(subjectInfo, PhonesInfo.Key_Phones.Ported_Metadata,
										KEYED(LEFT.phone = RIGHT.phone) AND
										((LEFT.FirstSeenDate <= RIGHT.port_start_dt) OR 	
											(LEFT.FirstSeenDate <= RIGHT.dt_last_reported) OR 	
											(RIGHT.deact_code=PhoneFinder_Services.Constants.PortingStatus.Disconnected AND RIGHT.is_deact='Y')),
										 LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));		
	
	//Check if realtime data was requested
	dDeltabasePorted := PhoneFinder_Services.GetPortedPhones_Deltabase(subjectInfo,PhoneFinder_Services.Constants.SQLSelectLimit,dGateways);																			
		
	//Join available realtime ports. Deact data is NOT available in realtime	
	dDeltabasewSubject := JOIN(subjectInfo,dDeltabasePorted, 
													LEFT.phone = RIGHT.phone AND
													RIGHT.source IN MDR.sourceTools.set_PhonesPorted AND
													LEFT.FirstSeenDate <= RIGHT.port_start_dt,
													KEEP(PhoneFinder_Services.Constants.MaxPortedMatches),LIMIT(0));
													
	//Join to Accudata OCN porting 												
	dAccudata := JOIN(subjectInfo, accu_rpt,
													LEFT.phone = RIGHT.phone AND
													LEFT.FirstSeenDate <= RIGHT.port_start_dt,
													KEEP(PhoneFinder_Services.Constants.MaxPortedMatches),LIMIT(0));											
										
	// Get the latest phone activities per acctno, per did 				
	dPortedPhones := TOPN(GROUP(SORT(dPorted + dAccudata + IF(EXISTS(subjectInfo) AND inMod.UseDeltabase,dDeltabasewSubject),   //combine results
																	acctno, did, phone,MAX(-dt_last_reported,-port_start_dt)),acctno, did, phone)
																	,PhoneFinder_Services.Constants.MaxPortedMatches,acctno,did,phone,MAX(-dt_last_reported,-port_start_dt)); 
																	
		// There are 4 sources in PhonesInfo.Key_Phones.Ported_Metadata - PK,PJ,PB,PX. 
		// PB records will NOT have a port_start_dt and are base records created for gong and phonesplus records without any ports.
		// PX records will NOT have a port_start_dt and represents disconnect activities.
		// Both PB and PX will be ordered by dt_last_reported.
		// PK and PJ represents actual moves between carriers record by port_start_dt. These records will have a zero dt_last_reported value
	sortedPorts  := GROUP(SORT(dPortedPhones,acctno,did,phone,port_start_dt=0,port_start_dt,spid,-deact_start_dt,-dt_last_reported)
																,acctno,did,phone,spid);

	//select necessary fields
	portedRec := RECORD
			sortedPorts.acctno;
			sortedPorts.did;
			sortedPorts.phone;
			sortedPorts.spid;
			sortedPorts.source;
			sortedPorts.operator_fullname;
			
			// is_ported 									:= MAX(GROUP,sortedPorts.is_ported);
			UNSIGNED1 PortingCount 			:= (UNSIGNED)(sortedPorts.source IN MDR.sourceTools.set_PhonesPorted);
			UNSIGNED4 FirstPortedDate 	:= sortedPorts.port_start_dt;
			UNSIGNED4 LastPortedDate  	:= MAX(MAX(GROUP, sortedPorts.port_end_dt),MAX(GROUP, sortedPorts.port_start_dt));
			UNSIGNED4 PortStartDate 		:= sortedPorts.port_start_dt;
			UNSIGNED4 PortEndDate  			:= MAX(MAX(GROUP, sortedPorts.port_end_dt),MAX(GROUP, sortedPorts.port_start_dt));			
			UNSIGNED4 ActivationDate 		:= MAX(GROUP, sortedPorts.react_start_dt);		//for PFv2 - activation data not ready
			UNSIGNED4 DisconnectDate 		:= MAX(GROUP, sortedPorts.deact_start_dt);			
			BOOLEAN   NoContractCarrier := MAX(GROUP, (integer) sortedPorts.high_risk_indicator) >0;
			BOOLEAN   Prepaid 					:= MAX(GROUP, (integer) sortedPorts.prepaid) > 0;
			UNSIGNED4 dt_last_reported	:= MAX(GROUP, sortedPorts.dt_last_reported);
			BOOLEAN 	is_deact 					:= MAX(GROUP,sortedPorts.is_deact)='Y';
			UNSIGNED1 serviceType					:= MAX(GROUP, (integer) sortedPorts.serv);
		
 END;	
	dPorts:= UNGROUP(TABLE(sortedPorts(source <> MDR.sourceTools.src_Phones_Disconnect),portedRec));		
	dDisconnects:= UNGROUP(TABLE(sortedPorts(source=MDR.sourceTools.src_Phones_Disconnect),portedRec));		
  dPortedInfo   := dPorts+ dDisconnects;
	
  Porting_layout := RECORD
			portedRec;
			PhoneFinder_Services.Layouts.PhoneFinder.Porting;
	END;		
	transformPort := PROJECT(dPortedInfo, TRANSFORM(Porting_layout, 
																						SELF.PortingHistory:=IF(LEFT.PortingCount > 0,PROJECT(LEFT,TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.PortHistory, 
																										SELF.PortStartDate 		:= LEFT.PortStartDate,
																										SELF.PortEndDate 			:= LEFT.PortEndDate,
																										SELF.ServiceProvider 	:= TRIM(LEFT.operator_fullname,LEFT,RIGHT)))),														
																						SELF:=LEFT,
																						SELF:=[]));
	//The carrier often sends updates which are identified by repeated spids based on the sequencing of FirstPortedDate			
	Porting_layout rollports(transformPort l, transformPort r) := TRANSFORM
			// Use to identify most current phone values - distinguishing btw PB (using dt_last_reported) and actual port records received (using port dates).
			mostCurrent := MAX(l.LastPortedDate, l.dt_last_reported) > MAX(r.LastPortedDate, r.dt_last_reported);
			
			SELF.PortingCount 		 := IF(l.spid<>r.spid AND r.source<>MDR.sourceTools.src_Phones_Disconnect, 
																	 l.PortingCount+r.PortingCount,l.PortingCount);
			SELF.PortingHistory 	 := IF(r.source NOT IN [MDR.sourceTools.src_Phones_Disconnect,MDR.sourceTools.src_Phones_LIDB],
																										l.PortingHistory+r.PortingHistory,l.PortingHistory);					
			SELF.LastPortedDate 	 := MAX(l.LastPortedDate,r.LastPortedDate);
			SELF.ActivationDate 	 := MAX(l.ActivationDate,r.ActivationDate);	
			SELF.DisconnectDate 	 := MAX(l.DisconnectDate,r.DisconnectDate);																				
			SELF.is_deact		 			 := MAX(l.is_deact,r.is_deact);
			SELF.serviceType		 	 := IF(mostCurrent,l.serviceType,r.serviceType);
			SELF.Prepaid				 	 := IF(mostCurrent,l.Prepaid,r.Prepaid);
			SELF.NoContractCarrier := IF(mostCurrent,l.NoContractCarrier,r.NoContractCarrier);
			SELF.spid				 			 := IF(mostCurrent,l.spid,r.spid);
			SELF := l;
	END;
	dPortedRolled		:= ROLLUP(SORT(transformPort,acctno,did,phone,FirstPortedDate=0,FirstPortedDate),
															LEFT.acctno = RIGHT.acctno AND
															LEFT.DID		= RIGHT.DID AND
															LEFT.phone 	= RIGHT.phone,
															rollports(LEFT, RIGHT));	

		//Final results joined with original dataset
	PhoneFinder_Services.Layouts.PhoneFinder.Final UpdatePhoneInfo(dSearchRecswLocInfo l,Porting_layout r) := TRANSFORM 
			hasPort:= r.PortingCount > 0;
			hasMetadata:= l.phone=r.phone;
			SELF.PortingCode    := MAP(hasPort => 'Ported', 
																 (NOT inMod.SubjectMetadataOnly OR l.isprimaryphone OR l.batch_in.homephone<>'')=> 'Not Ported',
																 '');
			SELF.PortingCount    := IF(displayAll,r.PortingCount,l.PortingCount);
			SELF.PortingHistory  := IF(displayAll,CHOOSEN(SORT(r.PortingHistory,-PortEndDate),PhoneFinder_Services.Constants.MaxPortedMatches),l.PortingHistory);	
			SELF.FirstPortedDate := IF(displayAll,r.FirstPortedDate,l.FirstPortedDate);		
			SELF.LastPortedDate  := IF(displayAll,r.LastPortedDate,l.LastPortedDate);
			SELF.NoContractCarrier  := IF(displayAll,r.NoContractCarrier,l.NoContractCarrier);
			SELF.Prepaid				 := IF(displayAll,r.Prepaid,l.Prepaid);
			Phone_Status         := PhoneFinder_Services.Functions.PhoneStatusDesc((INTEGER)l.RealTimePhone_Ext.StatusCode);
			SELF.ActivationDate  := IF(Phone_Status = PhoneFinder_Services.Constants.PhoneStatus.Active, r.ActivationDate, 0);
			SELF.DisconnectDate  := IF(Phone_Status = PhoneFinder_Services.Constants.PhoneStatus.INACTIVE, r.DisconnectDate, 0);
			// Override TU data to use LIBD and Port data when available
			SELF.serviceType  	 := r.serviceType;
			SELF.RealTimePhone_Ext.ServiceClass := IF(hasMetadata,(STRING)r.serviceType,l.RealTimePhone_Ext.ServiceClass);
			SELF.COC_description := IF(hasMetadata,PhoneFinder_Services.Functions.ServiceClassDesc(r.serviceType),l.COC_description);
			SELF.PortingStatus   := '';
			
			// Temporarily remove until better disconnect data is obtained
  /*		IF(r.DisconnectDate >= r.ActivationDate AND r.is_deact,PhoneFinder_Services.Constants.PhoneStatus.Inactive,
																																											PhoneFinder_Services.Constants.PhoneStatus.Active);
			//override existing statuscode if porting data indicate phone is inactive to resolve conflicting report.
			updTURecs := SELF.PortingStatus = PhoneFinder_Services.Constants.PhoneStatus.Inactive;
			SELF.realtimephone_ext.statuscode := IF(updTURecs,PhoneFinder_Services.Constants.PhoneInactiveStatus,l.realtimephone_ext.statuscode);
			SELF.realtimephone_ext.statuscode_desc := IF(updTURecs,PhoneFinder_Services.Constants.PhoneStatus.Inactive,l.realtimephone_ext.statuscode_desc);
			SELF.realtimephone_ext.statuscode_flag := IF(updTURecs,'',l.realtimephone_ext.statuscode_flag);
			SELF.realtimephone_ext.statuscode_flagdesc := IF(updTURecs,'',l.realtimephone_ext.statuscode_flagdesc);
	*/	
			SELF := l;
			SELF := [];
	END;
	dPhoneInfoWPorting 		:= JOIN(dSearchRecswLocInfo,dPortedRolled,
															LEFT.acctno	= RIGHT.acctno AND
															LEFT.did		= RIGHT.did AND
															LEFT.phone 	= RIGHT.phone,
															UpdatePhoneInfo(LEFT,RIGHT),
															LEFT OUTER, KEEP(1),
															LIMIT(0));
	// ---------------------------------------------------------------------------------------------------------
	// ****************************************Process SPOOFs***************************************************
	// ---------------------------------------------------------------------------------------------------------											
	//Get Spoofed phones													
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
															LEFT.acctno	= RIGHT.acctno AND
															LEFT.did		= RIGHT.did AND
															LEFT.phone 	= RIGHT.phone,
															GROUP,
															getSpoofHistory(LEFT,ROWS(RIGHT)));
															
		//Spoof results joined with original dataset
	PhoneFinder_Services.Layouts.PhoneFinder.Final mergeSpoof(PhoneFinder_Services.Layouts.PhoneFinder.Final l,spoof_layout r) := TRANSFORM
			SELF.acctno	:= l.acctno;
			SELF.did		:= l.did;
			SELF.phone 	:= l.phone;
			SELF := r;
			SELF := l;
	END;
	dPhoneInfoWSpoofing		:= JOIN(dPhoneInfoWPorting,spoofInfowHistory,
															LEFT.acctno	= RIGHT.acctno AND
															LEFT.did		= RIGHT.did AND
															LEFT.phone 	= RIGHT.phone,
															mergeSpoof(LEFT,RIGHT),
															LEFT OUTER, KEEP(1),
															LIMIT(0));
	dPhoneInfoUpdate := IF(EXISTS(spoofInfo) AND inMod.TransactionType IN [PhoneFinder_Services.Constants.TransType.ULTIMATE,
																																					 PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT],
																																										dPhoneInfoWSpoofing,dPhoneInfoWPorting);															
	// ---------------------------------------------------------------------------------------------------------
	// ****************************************Process OTPs****************************************************
	// ---------------------------------------------------------------------------------------------------------	
	
	//Get OTP records													
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
																acctno, did, phone, -event_date, transaction_id),acctno, did, phone, event_date, transaction_id); 	
	dedupOTPs := 	SORT(DEDUP(SORT(dOTPPhones, acctno, did, phone, otp_id,
															STD.Str.ToLowerCase(function_name) NOT IN PhoneFinder_Services.Constants.OTPVerifyTransactions,-verify_passed),
															acctno, did, phone, otp_id),
											acctno, did, phone,-event_date);														
	dsOTPHistory := PROJECT(dedupOTPs,TRANSFORM({PhoneFinder_Services.Layouts.SubjectPhone,PhoneFinder_Services.Layouts.PhoneFinder.OTPs}, 
																									SELF.OTPStatus:= IF(STD.Str.ToLowerCase(LEFT.function_name) IN PhoneFinder_Services.Constants.OTPVerifyTransactions,
																																			LEFT.verify_passed,FALSE), 
																									SELF.EventDate:= LEFT.event_date, SELF:=LEFT));
	//select necessary fields
	OTPRec := RECORD
			dOTPPhones.acctno;
			dOTPPhones.did;
			dOTPPhones.phone;
			BOOLEAN OTP := dOTPPhones.transaction_id <> '';
			UNSIGNED4 OTPCount := COUNT(GROUP,dOTPPhones.transaction_id<>'');
			UNSIGNED4 FirstOTPDate := (UNSIGNED)MIN(GROUP, dOTPPhones.event_date);
			UNSIGNED4 LastOTPDate  := (UNSIGNED)dOTPPhones.event_date;
			BOOLEAN LastOTPStatus := IF(STD.Str.ToLowerCase(dOTPPhones.function_name) IN PhoneFinder_Services.Constants.OTPVerifyTransactions,
																					dOTPPhones.verify_passed, FALSE);	
	END;
	dvalidOTP:= TABLE(GROUP(dedupOTPs,acctno, did, phone),OTPRec);	
		
	{OTPRec, PhoneFinder_Services.Layouts.PhoneFinder.OneTimePassword} getOTPHistory (dvalidOTP l, DATASET(RECORDOF(dsOTPHistory)) r) := TRANSFORM
			SELF.OTPHistory := PROJECT(r, TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.OTPs, SELF:=LEFT));
			SELF := l;
	END;		
		
	dvalidOTPwHistory := DENORMALIZE(dvalidOTP,dsOTPHistory,
															LEFT.acctno	= RIGHT.acctno AND
															LEFT.did		= RIGHT.did AND
															LEFT.phone 	= RIGHT.phone,
															GROUP,
															getOTPHistory(LEFT,ROWS(RIGHT)));
																																												
	//Append OTP results
	PhoneFinder_Services.Layouts.PhoneFinder.Final mergeOTP(PhoneFinder_Services.Layouts.PhoneFinder.Final l,dvalidOTPwHistory r) := TRANSFORM
			SELF.OTP 						:= IF(displayAll,r.OTP,false);
			SELF.OTPCount 			:= IF(displayAll,r.OTPCount,0);
			SELF.FirstOTPDate 	:= IF(displayAll,r.FirstOTPDate,0);
			SELF.LastOTPDate	 	:= IF(displayAll,r.LastOTPDate,0);
			SELF.LastOTPStatus 	:= IF(displayAll,r.LastOTPStatus,false);
			SELF.OTPHistory		 	:= IF(displayAll,CHOOSEN(SORT(r.OTPHistory,-EventDate),PhoneFinder_Services.Constants.MaxOTPMatches),
																					DATASET([],PhoneFinder_Services.Layouts.PhoneFinder.OTPs));
			SELF := l;
			SELF := [];
	END;
		
	dPhoneInfowOTP		:= JOIN(dPhoneInfoUpdate,dvalidOTPwHistory,
															LEFT.acctno	= RIGHT.acctno AND
															LEFT.did		= RIGHT.did AND
															LEFT.phone 	= RIGHT.phone,
															mergeOTP(LEFT,RIGHT),
															LEFT OUTER, KEEP(1),
															LIMIT(0));	
													
	// ---------------------------------------------------------------------------------------------------------
	// ****************************************Process PRIs****************************************************
	// ---------------------------------------------------------------------------------------------------------																
	primaryPhoneSource := [PhoneFinder_Services.Constants.PhoneSource.Waterfall,PhoneFinder_Services.Constants.PhoneSource.QSentGateway];															
		displayPRI := displayAll AND EXISTS(inMod.RiskIndicators(Active));
		
		PhoneFinder_Services.Layouts.PhoneFinder.Final rollMetadata(PhoneFinder_Services.Layouts.PhoneFinder.Final l,
																																PhoneFinder_Services.Layouts.PhoneFinder.Final r) := TRANSFORM
			SELF.dt_first_seen				:= (STRING)ut.Min2((INTEGER)l.dt_first_seen,(INTEGER)r.dt_first_seen);
			SELF.dt_last_seen					:= (STRING)MAX((INTEGER)l.dt_last_seen,(INTEGER)r.dt_last_seen);
			SELF.listing_type_bus			:= IF(l.listing_type_bus='',r.listing_type_bus,l.listing_type_bus);
			SELF.coc_description			:= IF(l.coc_description='',r.coc_description,l.coc_description);
			SELF.realtimephone_ext.statuscode	:= IF(l.realtimephone_ext.statuscode='',r.realtimephone_ext.statuscode,l.realtimephone_ext.statuscode);
			// preserve address type since recs with zero DIDs are blank
			SELF.primary_address_type := IF(l.primary_address_type='',r.primary_address_type,l.primary_address_type); 
			SELF.typeflag							:= IF(r.typeflag = 'P',l.typeflag,r.typeflag);										
			SELF.deceased							:= IF(r.deceased = 'Y',r.deceased,l.deceased);										
			SELF.phone_source					:= IF(l.phone_source IN primaryPhoneSource,l.phone_source,r.phone_source); //more efficiently account for the subject
			SELF               				:= l;
		END;
		rolledMetadataRecs:= ROLLUP(SORT(dPhoneInfowOTP,acctno,did,phone,typeflag=Phones.Constants.TypeFlag.DataSource_PV,-dt_last_seen,dt_first_seen,phone_source),
														LEFT.acctno=RIGHT.acctno AND
														LEFT.did=RIGHT.did AND
														LEFT.phone=RIGHT.phone,
														rollMetadata(LEFT,RIGHT));
															
		SortedPhoneRecs 	:= SORT(rolledMetadataRecs,acctno,did=0,phone='', 
																								IF(batch_in.did !=0,did != batch_in.did,FALSE), //if PII search populate that requested DID to top
																								-isprimaryphone,typeflag=Phones.Constants.TypeFlag.DataSource_PV,penalt,
																										-dt_last_seen,(UNSIGNED)dt_first_seen=0,dt_first_seen,phone_source, record);
																
		PrimaryPhoneRecs 	:= DEDUP(SortedPhoneRecs((did = batch_in.did  AND isprimaryphone) OR batch_in.homephone<>''),acctno);
		PhoneFinder_Services.Layouts.PhoneFinder.Final getPRIs(PhoneFinder_Services.Layouts.PhoneFinder.Final l):= TRANSFORM
			priResult := PhoneFinder_Services.GetPRIValue(l,inMod);
			SELF.confidencescore := 1;	//repurpose to temporarily label the primaryRecords
			SELF:= priResult;
		END;
		dPrimaryPhone_wRiskValues := PROJECT(PrimaryPhoneRecs,getPRIs(LEFT));	
		PhoneRecswSubjectPRIs 		:= DEDUP(SORT(SortedPhoneRecs + dPrimaryPhone_wRiskValues,acctno,seq,-PhoneRiskIndicator,record),acctno,seq);
		sortedPhoneswSubjectPRIs 	:= SORT(PhoneRecswSubjectPRIs,acctno,phone='',typeflag=Phones.Constants.TypeFlag.DataSource_PV,-phone_score,
																														-dt_last_seen,dt_first_seen);	
		
		// when requested, perform PRI verification on other phones.		
		// Other phones are only provided for PII searches
		otherPhones := sortedPhoneswSubjectPRIs(PhoneRiskIndicator='' AND batch_in.homephone='');
	
		PhoneFinder_Services.Layouts.PhoneFinder.Final getOtherPRI(PhoneFinder_Services.Layouts.PhoneFinder.Final l):=TRANSFORM
			otherPhonePRI := PhoneFinder_Services.GetPRIValue(l,inMod);
			// PF CR#1: no longer processing otherphones based on prior phone failures
			// getPRI := l.acctno = '' OR l.PhoneRiskIndicator = PhoneFinder_Services.Constants.RiskIndicator[PhoneFinder_Services.Constants.RiskLevel.FAILED];
			// SELF.PhoneRiskIndicator := otherPhonePRI.PhoneRiskIndicator; 
			// SELF.OTPRIFailed			  := otherPhonePRI.OTPRIFailed;
			SELF.confidencescore := 2;
			SELF := otherPhonePRI;
		END;
		otherPhones_wRiskValues := IF(inMod.IncludeOtherPhoneRiskIndicators AND EXISTS(otherPhones), //check if PRI for other phones are required
																								PROJECT(otherPhones,getOtherPRI(LEFT)));
		
		// PRIResults := IF(EXISTS(otherPhones_wRiskValues)
													// ,DEDUP(SORT(PhoneRecswSubjectPRIs + otherPhones_wRiskValues,acctno,seq,-PhoneRiskIndicator,record),acctno,seq)
													// ,PhoneRecswSubjectPRIs);	
		PRIResults :=	dPrimaryPhone_wRiskValues + otherPhones_wRiskValues;										
		//We report PRI for each phone						
		PhoneAlerts := DEDUP(SORT(PRIResults,acctno,phone,confidencescore,-EXISTS(Alerts),PhoneRiskIndicator='', -dt_last_seen,dt_first_seen,-phone_score),acctno,phone);
		
		PhoneFinder_Services.Layouts.PhoneFinder.Final mergePRI (PhoneFinder_Services.Layouts.PhoneFinder.Final l,
																															PhoneFinder_Services.Layouts.PhoneFinder.Final r):= TRANSFORM
			SELF.PhoneRiskIndicator := r.PhoneRiskIndicator;
			SELF.OTPRIFailed				:= r.OTPRIFailed;
			SELF.Alerts							:= r.Alerts;
			SELF:=l;
		END;			
		dPhoneInfowPRI:= 	JOIN(dPhoneInfowOTP,PhoneAlerts,
														LEFT.acctno	= RIGHT.acctno AND
														LEFT.phone 	= RIGHT.phone,
														mergePRI(LEFT,RIGHT), LEFT OUTER, ALL);
														
		MetadataResults:= IF(displayPRI,dPhoneInfowPRI,dPhoneInfowOTP);
		
		#IF(PhoneFinder_Services.Constants.Debug.PhoneMetadata)		
		OUTPUT(dSearchRecs0,NAMED('dSearchRecs0'));												
		OUTPUT(dSearchRecs,NAMED('dSearchRecs'));												
		OUTPUT(phoneStateUpdate,NAMED('phoneStateUpdate'));												
		OUTPUT(bestInfo,NAMED('bestInfo'));												
		OUTPUT(phonewBestAddr,NAMED('phonewBestAddr'));												
		OUTPUT(ds_zip,NAMED('ds_zip'));												
		OUTPUT(ds_cityState,NAMED('ds_cityState'));												
		OUTPUT(dSearchRecswAddrType,NAMED('dSearchRecswAddrType'));												
		OUTPUT(dSearchRecswLocInfo,NAMED('dSearchRecswLocInfo'));												
		// OUTPUT(dssubjects,NAMED('dsSubjects'));												
		// OUTPUT(subjectInfo,NAMED('subjectInfo'));												
		// OUTPUT(dPorted,NAMED('dPorted'));												
		// OUTPUT(dDeltabasePorted,NAMED('dDeltabasePorted'));												
		// OUTPUT(sortedPorts,NAMED('sortedPorts'));												
		OUTPUT(dPortedInfo,NAMED('dPortedInfo'));																						
		OUTPUT(dPortedPhones,NAMED('dPortedPhones'));											
		OUTPUT(transformPort,NAMED('transformPort'));																							
		OUTPUT(dPortedRolled,NAMED('dPortedRolled'));												
		OUTPUT(dPhoneInfoWPorting,NAMED('dPhoneInfoWPorting'));												
		// OUTPUT(dDeltabaseSpoofed,NAMED('dDeltabaseSpoofed'));												
		// OUTPUT(dSpoofedPhones,NAMED('dSpoofedPhones'));		
		// OUTPUT(dSpoof,NAMED('dSpoof'));		
		// OUTPUT(transformSpoof,NAMED('transformSpoof'));		
		// OUTPUT(spoofInfo,NAMED('spoofInfo'));		
		// OUTPUT(spoofInfowHistory,NAMED('spoofInfowHistory'));	
		OUTPUT(dPhoneInfoUpdate,NAMED('dPhoneInfoUpdate'));	
		// OUTPUT(dOTP,NAMED('dOTPIndex'));		
		// OUTPUT(dDeltaOTPwSubject,NAMED('dDeltaOTPwSubject'));		
		// OUTPUT(dOTPPhones,NAMED('dOTPPhones'));		
		// OUTPUT(dedupOTPs,NAMED('dedupOTPs'));		
		// OUTPUT(dvalidOTP,NAMED('dvalidOTP'));		
		// OUTPUT(dvalidOTPwHistory,NAMED('dvalidOTPwHistory'));		
		// OUTPUT(dPhoneInfoUpdate,NAMED('dPhoneInfoUpdate'));		
		OUTPUT(dPhoneInfowOTP,NAMED('dPhoneInfowOTP'));				
		OUTPUT(rolledMetadataRecs,NAMED('rolledMetadataRecs'));	
		OUTPUT(SortedPhoneRecs,NAMED('SortedPhoneRecs'));	
		// OUTPUT(SortedIdentity,NAMED('SortedIdentity'));	
		// OUTPUT(SortedPhone,NAMED('SortedPhone'));	
		OUTPUT(PrimaryPhoneRecs,NAMED('PrimaryPhoneRecs'));	
		OUTPUT(dPrimaryPhone_wRiskValues,NAMED('dPrimaryPhone_wRiskValues'));	
		OUTPUT(otherPhones,NAMED('otherPhones'));	
		OUTPUT(sortedPhoneswSubjectPRIs,NAMED('sortedPhoneswSubjectPRIs'));	
		OUTPUT(otherPhones_wRiskValues,NAMED('otherPhones_wRiskValues'));		
		// OUTPUT(PRIResults,NAMED('PRIResults'));		
		OUTPUT(PhoneAlerts,NAMED('PhoneAlerts'));		
		OUTPUT(dPhoneInfowPRI,NAMED('dPhoneInfowPRI'));		
		OUTPUT(MetadataResults,NAMED('MetadataResults'));		
	#END;
	
		RETURN SORT(MetadataResults,acctno,seq);	
		
	END;	