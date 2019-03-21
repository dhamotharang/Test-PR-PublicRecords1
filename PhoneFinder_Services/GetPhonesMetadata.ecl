IMPORT Advo,DID_Add, Gateway, Inquiry_AccLogs,MDR,PhoneFinder_Services,PhoneFraud,PhonesInfo,Phones,Risk_Indicators, std, ut;

EXPORT GetPhonesMetadata(DATASET(PhoneFinder_Services.Layouts.PhoneFinder.Final) dInRecs, 
													 PhoneFinder_Services.iParam.ReportParams inMod, 
													 DATASET(Gateway.Layouts.Config) dGateways, 
													 DATASET(PhoneFinder_Services.Layouts.BatchInAppendDID) dInBestInfo,
													 DATASET(PhoneFinder_Services.Layouts.SubjectPhone) subjectInfo,
                           BOOLEAN isBatch = FALSE) :=
	FUNCTION
	
	// ---------------------------------------------------------------------------------------------------------
	// ****************************************Process Location*************************************************
	// ---------------------------------------------------------------------------------------------------------																
	PhoneFinder_Services.Layouts.PhoneFinder.Final UpdatePrimaryAddress (PhoneFinder_Services.Layouts.PhoneFinder.Final l, dInBestInfo r) := TRANSFORM
		bestMatch := l.acctno=r.acctno and (l.did=r.did OR l.batch_in.did = r.did);
		SELF.prim_range 	:= IF(bestMatch,r.prim_range,l.prim_range);
		SELF.predir 			:= IF(bestMatch,r.predir,l.predir);
		SELF.prim_name 		:= IF(bestMatch,r.prim_name,l.prim_name);
		SELF.suffix 			:= IF(bestMatch,r.addr_suffix,l.suffix);
		SELF.postdir 			:= IF(bestMatch,r.postdir,l.postdir);
		SELF.sec_range 		:= IF(bestMatch,r.sec_range,l.sec_range);
		SELF.city_name 		:= IF(bestMatch,r.p_city_name,l.city_name);
		SELF.st 					:= IF(bestMatch,r.st,l.st);
		SELF.zip 					:= IF(bestMatch,r.z5,l.zip);
		SELF.did 					:= IF(bestMatch,r.did,l.did);
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
															LEFT.dt_first_seen <= RIGHT.search_info.datetime[1..8],
															GROUP,
															getInquiries(LEFT,ROWS(RIGHT)),
															LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));			
	dSearchRecswInquiryDaily	:= DENORMALIZE(dSearchRecswInqHistory,InquiryDaily,
															KEYED(LEFT.phone=RIGHT.phone10) AND
															LEFT.dt_first_seen <= RIGHT.search_info.datetime[1..8],
															GROUP,
															getInquiries(LEFT,ROWS(RIGHT)),
															LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));	
															
		
  dInqdeltabase_in := project(dedup(dSearchRecswInquiryDaily(phone <> ''), phone),
		                               transform(PhoneFinder_Services.Layouts.DeltaInquiryDataRecord, self := left));
		
		//Check if realtime data was requested
	dDeltabaseinquired := PhoneFinder_Services.GetPhoneInquiries_Deltabase(dInqdeltabase_in,PhoneFinder_Services.Constants.SQLSelectLimit,dGateways);																			
		
	//Join available realtime ports. Deact data is NOT available in realtime	
	dDeltabaseInquiredRecs := JOIN(dSearchRecswInquiryDaily,dDeltabaseinquired, 
													LEFT.phone = RIGHT.phone,
												  TRANSFORM(RECORDOF(LEFT), SELF.RecordsReturned := RIGHT.RecordsReturned, SELF := LEFT),
												  LEFT OUTER, LIMIT(PhoneFinder_Services.Constants.MetadataLimit,SKIP));
												 
	dPhoneInquiryRecs       := If(inMod.UseDeltabase, dDeltabaseInquiredRecs, dSearchRecswInquiryDaily);
	
	// we use Inquiry Recs only when RI = 30(30	Phone # has had “Input A” search requests within the past “Input B” days	) is active
	dPhoneInquiryRecs_final := IF(EXISTS(inMod.RiskIndicators(Active AND RiskId = 30)), 
	                           PROJECT(dPhoneInquiryRecs, PhoneFinder_Services.Layouts.PhoneFinder.Final),
	                           PROJECT(dSearchRecswAddrType, PhoneFinder_Services.Layouts.PhoneFinder.Final)); 
	
	// Adding Ported data
		PhoneFinder_Services.Layouts.PhoneFinder.Final UpdatePhonePortedInfo(PhoneFinder_Services.Layouts.PhoneFinder.Final l,PhoneFinder_Services.Layouts.PhoneFinder.Final r) := TRANSFORM 
		
			SELF.PortingCode        := r.PortingCode;
			SELF.PortingCount       := r.PortingCount;
			SELF.PortingHistory     := r.PortingHistory;	
			SELF.FirstPortedDate    := r.FirstPortedDate;		
			SELF.LastPortedDate     := r.LastPortedDate;
			SELF.NoContractCarrier  := r.NoContractCarrier;
			SELF.Prepaid				        := r.Prepaid;
			SELF.ActivationDate     := r.ActivationDate;
			SELF.DisconnectDate     := r.DisconnectDate;
			SELF.serviceType  	     := r.serviceType;
			SELF.RealTimePhone_Ext.ServiceClass := r.RealTimePhone_Ext.ServiceClass;
			SELF.COC_description   := r.COC_description;
			SELF.PortingStatus     := r.PortingStatus;	
			SELF := l;
			SELF := [];
	END;
	dPhoneInfoWPorting 		:= JOIN(dPhoneInquiryRecs_final,dInRecs,
															LEFT.acctno	= RIGHT.acctno AND
															LEFT.phone 	= RIGHT.phone,
															UpdatePhonePortedInfo(LEFT,RIGHT),
															LEFT OUTER, KEEP(1),
															LIMIT(0));
	
	dPortedRecs := IF(inMod.TransactionType=PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT, 
	                  dPhoneInfoWPorting, 
										          dPhoneInquiryRecs_final);
	
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
	dPhoneInfoWSpoofing		:= JOIN(dPortedRecs,spoofInfowHistory,
															LEFT.acctno	= RIGHT.acctno AND
															LEFT.did		= RIGHT.did AND
															LEFT.phone 	= RIGHT.phone,
															mergeSpoof(LEFT,RIGHT),
															LEFT OUTER, KEEP(1),
															LIMIT(0));
		
		// original approach : display Spoofing when IncludePhoneMetadata and transaction type = ultimate and phoneriskassesment
	 //Re-design approach: display Spoofing info when IncludeSpoofing = true												
	 dPhoneInfoUpdate_Spoofing := IF(inMod.ReturnSpoofingInfo AND EXISTS(spoofInfo),
																																										dPhoneInfoWSpoofing,dPortedRecs);															
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
		
	dPhoneInfowOTP		:= JOIN(dPhoneInfoUpdate_Spoofing,dvalidOTPwHistory,
															LEFT.acctno	= RIGHT.acctno AND
															LEFT.did		= RIGHT.did AND
															LEFT.phone 	= RIGHT.phone,
															mergeOTP(LEFT,RIGHT),
															LEFT OUTER, KEEP(1),
															LIMIT(0));	
	 // original approach : display OTP when IncludePhoneMetadata
	 //Re-design approach: display OTP info when IncludeOTP = true
	dPhoneInfoUpdate_OTP := IF(inMod.ReturnOTPInfo AND EXISTS(dvalidOTP), dPhoneInfowOTP, dPhoneInfoUpdate_Spoofing);
	// ---------------------------------------------------------------------------------------------------------
	// ****************************************Process PRIs****************************************************
	// ---------------------------------------------------------------------------------------------------------																
	primaryPhoneSource := [PhoneFinder_Services.Constants.PhoneSource.Waterfall,PhoneFinder_Services.Constants.PhoneSource.QSentGateway];				
	 // original approach : display RI's when IncludePhoneMetadata and transaction type = premium,ultimate and phoneriskassesment
	 //Re-design approach: display RI's info when IncludeRiskIndicators = true
	displayPRI := isBatch AND inMod.IncludeRiskIndicators AND EXISTS(inMod.RiskIndicators(Active));
	call_fowarded := PhoneFinder_Services.Functions.CallForwardingDesc(1);	// FORWARDED
	PhoneFinder_Services.Layouts.PhoneFinder.Final rollMetadata(PhoneFinder_Services.Layouts.PhoneFinder.Final l,
																																PhoneFinder_Services.Layouts.PhoneFinder.Final r) := TRANSFORM
			SELF.dt_first_seen				:= (STRING)ut.Min2((INTEGER)l.dt_first_seen,(INTEGER)r.dt_first_seen);
			SELF.dt_last_seen					:= (STRING)MAX((INTEGER)l.dt_last_seen,(INTEGER)r.dt_last_seen);
			SELF.listing_type_bus			:= IF(l.listing_type_bus='',r.listing_type_bus,l.listing_type_bus);
			SELF.coc_description			:= IF(l.coc_description='',r.coc_description,l.coc_description);
			SELF.phonestatus	:= IF(l.phonestatus = PhoneFinder_Services.Constants.PhoneStatus.NotAvailable,r.phonestatus,l.phonestatus);
			// preserve address type since recs with zero DIDs are blank
			SELF.primary_address_type := IF(l.primary_address_type='',r.primary_address_type,l.primary_address_type); 
			SELF.typeflag							:= IF(r.typeflag = 'P',l.typeflag,r.typeflag);										
			SELF.deceased							:= IF(r.deceased = 'Y',r.deceased,l.deceased);										
			SELF.phone_source					:= IF(l.phone_source IN primaryPhoneSource,l.phone_source,r.phone_source); //more efficiently account for the subject
			SELF.PhoneOwnershipIndicator := l.PhoneOwnershipIndicator or r.PhoneOwnershipIndicator; // retaining values for a phone
			SELF.CallForwardingIndicator := IF(l.CallForwardingIndicator = call_fowarded, l.CallForwardingIndicator , r.CallForwardingIndicator);
			
			SELF.imsi_changedate := IF(l.imsi_changedate = '', r.imsi_changedate, l.imsi_changedate);
	        SELF.imsi_ActivationDate := IF(l.imsi_ActivationDate ='', r.imsi_ActivationDate, l.imsi_ActivationDate);
	        SELF.iccid_seensince := IF(l.iccid_seensince='', r.iccid_seensince, l.iccid_seensince);
	        SELF.imsi_seensince := IF(l.imsi_seensince='', r.imsi_seensince, l.imsi_seensince);
	        SELF.imei_seensince := IF(l.imei_seensince='', r.imei_seensince, l.imei_seensince);
	        SELF.imei_changedate := IF(l.imei_changedate='', r.imei_changedate, l.imei_changedate);
			SELF.loststolen_date := IF(l.loststolen_date='', r.loststolen_date, l.loststolen_date);
	        SELF.loststolen := IF(l.loststolen = 0, r.loststolen, l.loststolen);
			SELF.iccid_changedthis_time := IF(l.iccid_changedthis_time = 0, r.iccid_changedthis_time, l.iccid_changedthis_time);
			SELF.imsi_changedthis_time :=  IF(l.imsi_changedthis_time = 0, r.imsi_changedthis_time, l.imsi_changedthis_time);
			SELF.imei_changedthis_time :=  IF(l.imei_changedthis_time = 0, r.imei_changedthis_time, l.imei_changedthis_time);
			
			SELF               				:= l;
	END;
	dRolledMetadataRecs:= ROLLUP(SORT(dPhoneInfoUpdate_OTP,acctno,did,phone,typeflag=Phones.Constants.TypeFlag.DataSource_PV,-dt_last_seen,dt_first_seen,phone_source),
														LEFT.acctno=RIGHT.acctno AND
														LEFT.did=RIGHT.did AND
														LEFT.phone=RIGHT.phone,
														rollMetadata(LEFT,RIGHT));
															
	dSortedPhoneRecs 	:= SORT(dRolledMetadataRecs,acctno,did=0,phone='', 
																								IF(batch_in.did !=0,did != batch_in.did,FALSE), //if PII search populate that requested DID to top
																								-isprimaryphone,typeflag=Phones.Constants.TypeFlag.DataSource_PV,penalt,
																										-dt_last_seen,(UNSIGNED)dt_first_seen=0,dt_first_seen,phone_source, record);
																
	dPrimaryPhoneRecs 	:= DEDUP(dSortedPhoneRecs((did = batch_in.did  AND isprimaryphone) OR batch_in.homephone<>''),acctno);
		PhoneFinder_Services.Layouts.PhoneFinder.Final getPRIs(PhoneFinder_Services.Layouts.PhoneFinder.Final l):= TRANSFORM
			priResult := PhoneFinder_Services.GetPRIValue(l,inMod);
			SELF.confidencescore := 1;	//repurpose to temporarily label the primaryRecords
			SELF:= priResult;
	END;
	dPrimaryPhone_wRiskValues := PROJECT(dPrimaryPhoneRecs,getPRIs(LEFT));	
	dPhoneRecswSubjectPRIs 		:= DEDUP(SORT(dSortedPhoneRecs + dPrimaryPhone_wRiskValues,acctno,seq,-PhoneRiskIndicator,record),acctno,seq);
	dsortedPhoneswSubjectPRIs 	:= SORT(dPhoneRecswSubjectPRIs,acctno,phone='',typeflag=Phones.Constants.TypeFlag.DataSource_PV,-phone_score,
																														-dt_last_seen,dt_first_seen);	
		
   // when requested, perform PRI verification on other phones.		
	// Other phones are only provided for PII searches
	dOtherPhones := dsortedPhoneswSubjectPRIs(PhoneRiskIndicator='' AND batch_in.homephone='');
	PhoneFinder_Services.Layouts.PhoneFinder.Final getOtherPRI(PhoneFinder_Services.Layouts.PhoneFinder.Final l):=TRANSFORM
	otherPhonePRI := PhoneFinder_Services.GetPRIValue(l,inMod);
			// PF CR#1: no longer processing otherphones based on prior phone failures
			// getPRI := l.acctno = '' OR l.PhoneRiskIndicator = PhoneFinder_Services.Constants.RiskIndicator[PhoneFinder_Services.Constants.RiskLevel.FAILED];
			// SELF.PhoneRiskIndicator := otherPhonePRI.PhoneRiskIndicator; 
			// SELF.OTPRIFailed			  := otherPhonePRI.OTPRIFailed;
			SELF.confidencescore := 2;
			SELF := otherPhonePRI;
	END;
	
	 // original approach : display otherphones RI's when IncludePhoneMetadata and IncludeOtherPhoneRiskIndicators
	 //Re-design approach: display otherphones RI's when IncludeRiskIndicators = true
	dOtherPhones_wRiskValues := IF(inMod.IncludeOtherPhoneRiskIndicators AND EXISTS(dOtherPhones), //check if PRI for other phones are required
																								PROJECT(dOtherPhones,getOtherPRI(LEFT)));
		
	// PRIResults := IF(EXISTS(dOtherPhones_wRiskValues)
													// ,DEDUP(SORT(PhoneRecswSubjectPRIs + dOtherPhones_wRiskValues,acctno,seq,-PhoneRiskIndicator,record),acctno,seq)
													// ,dPhoneRecswSubjectPRIs);	
	PRIResults :=	dPrimaryPhone_wRiskValues + dOtherPhones_wRiskValues;										
	//We report PRI for each phone						
	PhoneAlerts := DEDUP(SORT(PRIResults,acctno,phone,confidencescore,-EXISTS(Alerts),PhoneRiskIndicator='', -dt_last_seen,dt_first_seen,-phone_score),acctno,phone);
		
	PhoneFinder_Services.Layouts.PhoneFinder.Final mergePRI (PhoneFinder_Services.Layouts.PhoneFinder.Final l,
																															PhoneFinder_Services.Layouts.PhoneFinder.Final r):= TRANSFORM
			SELF.PhoneRiskIndicator := r.PhoneRiskIndicator;
			SELF.OTPRIFailed				:= r.OTPRIFailed;
			SELF.Alerts							:= r.Alerts;
			SELF:=l;
	END;			
	dPhoneInfowPRI:= 	JOIN(dPhoneInfoUpdate_OTP,PhoneAlerts,
														LEFT.acctno	= RIGHT.acctno AND
														LEFT.phone 	= RIGHT.phone,
														mergePRI(LEFT,RIGHT), LEFT OUTER, ALL);
														
	MetadataResults:= IF(displayPRI,dPhoneInfowPRI,dPhoneInfoUpdate_OTP);
		
	
  #IF(PhoneFinder_Services.Constants.Debug.PhoneMetadata)		
 		 OUTPUT(dInRecs,NAMED('dInRecs'));												
 		 OUTPUT(dInBestInfo,NAMED('dInBestInfo'));												
   	OUTPUT(dSearchRecs,NAMED('dSearchRecs_metadata'));												
   	OUTPUT(phoneStateUpdate,NAMED('phoneStateUpdate'));												
    OUTPUT(bestInfo,NAMED('bestInfo'));												
    OUTPUT(phonewBestAddr,NAMED('phonewBestAddr'));												
    OUTPUT(ds_zip,NAMED('ds_zip'));												
    OUTPUT(ds_cityState,NAMED('ds_cityState'));												
    OUTPUT(dSearchRecswAddrType,NAMED('dSearchRecswAddrType'));												
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
		// OUTPUT(dedupOTPs,NAMED('dedupOTPs'));		
		// OUTPUT(dvalidOTP,NAMED('dvalidOTP'));		
		// OUTPUT(dvalidOTPwHistory,NAMED('dvalidOTPwHistory'));			
		// OUTPUT(dPhoneInfowOTP,NAMED('dPhoneInfowOTP'));				
		OUTPUT(dPhoneInfoUpdate_OTP,NAMED('dPhoneInfoUpdate_OTP'));				
		OUTPUT(drolledMetadataRecs,NAMED('rolledMetadataRecs'));	
		OUTPUT(dSortedPhoneRecs,NAMED('SortedPhoneRecs'));	
		// OUTPUT(SortedIdentity,NAMED('SortedIdentity'));	
		// OUTPUT(SortedPhone,NAMED('SortedPhone'));	
		OUTPUT(dPrimaryPhoneRecs,NAMED('PrimaryPhoneRecs'));	
		OUTPUT(dPrimaryPhone_wRiskValues,NAMED('dPrimaryPhone_wRiskValues'));	
		OUTPUT(dotherPhones,NAMED('otherPhones'));	
		OUTPUT(dsortedPhoneswSubjectPRIs,NAMED('sortedPhoneswSubjectPRIs'));	
		OUTPUT(dotherPhones_wRiskValues,NAMED('otherPhones_wRiskValues'));		
		// OUTPUT(dPRIResults,NAMED('PRIResults'));		
		OUTPUT(PhoneAlerts,NAMED('PhoneAlerts'));		
		OUTPUT(dPhoneInfowPRI,NAMED('dPhoneInfowPRI'));		
		OUTPUT(MetadataResults,NAMED('MetadataResults'));		
	#END;

	RETURN  SORT(MetadataResults, acctno, seq);
		
	END;