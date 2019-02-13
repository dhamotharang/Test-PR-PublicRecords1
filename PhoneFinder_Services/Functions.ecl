IMPORT Address,Autokey_batch,Doxie,iesp,MDR,NID,Phones,PhoneFinder_Services,std,ut;

pfLayouts     := PhoneFinder_Services.Layouts;
lBatchInAcctno:= pfLayouts.BatchInAppendAcctno;
lBatchInDID   := pfLayouts.BatchInAppendDID;
lFinal        := pfLayouts.PhoneFinder.Final;
lIdentitySlim := pfLayouts.PhoneFinder.IdentitySlim;
lIdentityIesp := pfLayouts.PhoneFinder.IdentityIesp;

EXPORT Functions :=
MODULE

 EXPORT GetSubjectInfo(DATASET(PhoneFinder_Services.Layouts.PhoneFinder.Final) dInRecs,
											           PhoneFinder_Services.iParam.ReportParams      inMod) := FUNCTION

	
  //phone searches do not generate other phones related to the subject, hence all phone searches are subject related.
	 dNeedPortingInfo 	:= IF(inMod.SubjectMetadataOnly,dInRecs(isprimaryphone OR batch_in.homephone<>''),dInRecs);

	 //reduce layout by selecting necessary fields
	 PhoneFinder_Services.Layouts.SubjectPhone getSubjectPhone(dNeedPortingInfo l) := TRANSFORM
			SELF.acctno := l.acctno;
			SELF.did := l.did;
			SELF.phone := l.phone;
			//If phone record occurs after first_seen minus 5 days the date field in the port/spoof table will associate active with subject.
			SELF.FirstSeenDate := IF((UNSIGNED)l.dt_first_seen<> 0,(UNSIGNED)ut.date_math(l.dt_first_seen, -PhoneFinder_Services.Constants.PortingMarginOfError),0);
			SELF.LastSeenDate  := IF((UNSIGNED)l.dt_last_seen <> 0,(UNSIGNED)ut.date_math(l.dt_last_seen, PhoneFinder_Services.Constants.PortingMarginOfError), 0); 
	 END;
	 dsSubjects := PROJECT(dNeedPortingInfo,getSubjectPhone(LEFT));			
			
		//rollup to get comprehensive port period
	 PhoneFinder_Services.Layouts.SubjectPhone rollSubject(PhoneFinder_Services.Layouts.SubjectPhone l,PhoneFinder_Services.Layouts.SubjectPhone r) := TRANSFORM
			SELF.FirstSeenDate := ut.Min2(l.FirstSeenDate,r.FirstSeenDate);
			SELF               := l;
	 END;
	
  dSubjectInfo:= ROLLUP(SORT(dsSubjects,acctno,did,phone,-LastSeenDate,FirstSeenDate),
														LEFT.acctno=RIGHT.acctno AND
														LEFT.did=RIGHT.did AND
														LEFT.phone=RIGHT.phone,
														rollSubject(LEFT,RIGHT));	
														
	 RETURN dSubjectInfo;
	
 END;
 
	EXPORT STRING ServiceClassDesc(STRING pServiceClass) := CASE(pServiceClass,
																																'0' => PhoneFinder_Services.Constants.PhoneType.Landline,
																																'1' => PhoneFinder_Services.Constants.PhoneType.Wireless,
																																'2' => PhoneFinder_Services.Constants.PhoneType.VoIP,
																																PhoneFinder_Services.Constants.PhoneType.Other);
	
	EXPORT STRING PhoneStatusDesc(INTEGER pPhoneStatus):= MAP(pPhoneStatus IN [10,11,12,13,20,21,22,23] => PhoneFinder_Services.Constants.PhoneStatus.Active,
																														pPhoneStatus IN [30,31,32,33]             => PhoneFinder_Services.Constants.PhoneStatus.Inactive,
																														PhoneFinder_Services.Constants.PhoneStatus.NotAvailable);
	
	EXPORT STRING AddressTypeDesc(STRING pAddressType) := CASE(pAddressType,
																															'F' => 'FIRM',
																															'G' => 'GENERAL DELIVERY',
																															'H' => 'MULTI-DWELLING RESIDENTIAL OR OFFICE BUILDING',
																															'M' => 'MILITARY',
																															'P' => 'POST OFFICE BOX',
																															'R' => 'RURAL ROUTE OR HIGHWAY CONTRACT',
																															'S' => 'STREET ADDRESS',
																															'U' => 'UNKNOWN',
																															'');
	EXPORT STRING CallForwardingDesc(INTEGER pCallFwd) := CASE(pCallFwd,
																																0 => 'NOT FORWARDED',
																																1 => 'FORWARDED',
																																'');
	// Best info
	EXPORT GetBestInfo(DATASET(lBatchInDID) dIn) :=
	FUNCTION

	  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ());

		dids := DEDUP(SORT(PROJECT(dIn,doxie.layout_references),did),did);
		
		dBestRecs := Doxie.best_records(dids, includeDOD:=true, modAccess := mod_access);
		
		lBatchInDID tGetBestInfo(dIn le,dBestRecs ri) :=
		TRANSFORM
			SELF.acctno      := le.acctno;
			SELF.name_first  := ri.fname;
			SELF.name_middle := ri.mname;
			SELF.name_last   := ri.lname;
			SELF.addr_suffix := ri.suffix;
			SELF.p_city_name := ri.city_name;
			SELF.z5          := ri.zip;
			SELF.ssn         := (STRING)ri.ssn;
			SELF.dob         := (STRING)ri.dob;
			SELF             := ri;
			SELF             := le;
		END;
		
		dBestInfo := JOIN(dIn,
											dBestRecs,
											LEFT.did = RIGHT.did,
											tGetBestInfo(LEFT,RIGHT),
											LEFT OUTER,
											LIMIT(0),keep(1));
		
		RETURN dBestInfo;
	END;
	
	// Function to check IF name is populated
	EXPORT isNamePopulated(iesp.share.t_Name pName) := pName.Full	!=	'' or pName.Last != '';
	
	// Function to check IF address is populated
	EXPORT isAddrPopulated(iesp.share.t_Address pAddr) :=
	FUNCTION
		STRING	vStreetAddress			:=	Address.Addr1FromComponents(	pAddr.StreetNumber,
																																	pAddr.StreetPreDirection,
																																	pAddr.StreetName,
																																	pAddr.StreetSuffix,
																																	pAddr.StreetPostDirection,
																																	pAddr.UnitDesignation,
																																	pAddr.UnitNumber
																																);
		STRING	vStreetAddressl			:=	IF(pAddr.StreetAddress1	=	'',vStreetAddress,pAddr.StreetAddress1);
		STRING	vStreetAddressFull	:=	STRINGlib.STRINGcleanspaces(vStreetAddressl	+	' '	+	pAddr.StreetAddress2);
		STRING	vCityStateZip				:=	IF(	pAddr.StatecityZip	!=	'',
																				pAddr.StateCityZip,
																				Address.Addr2FromComponents(pAddr.city,pAddr.state,pAddr.zip5)
																			);
		
		BOOLEAN vAddrPopulated      := vStreetAddressFull != '' and vCityStateZip != '';
		
		RETURN vAddrPopulated;
	END;
	
	// Function to append carrier information
	EXPORT GetPhoneCarrierInfo(dIn) :=
	FUNCTIONMACRO
		IMPORT risk_indicators;
		
		rAppendCarrierInfo :=
		RECORD
			RECORDOF(dIn);
			PhoneFinder_Services.Layouts.CarrierInfo.Base;
		END;
		
		dTelcoridaTPM := JOIN(dIn,
													risk_indicators.Key_Telcordia_tpm,
															KEYED(LEFT.phone[1..3] = RIGHT.npa)
													and KEYED(LEFT.phone[4..6] = RIGHT.nxx)
													and KEYED(LEFT.phone[7]    = RIGHT.tb),
													LEFT OUTER,
													KEEP(1),LIMIT(0));
		
		dTelcorida    := JOIN(dTelcoridaTPM,
													risk_indicators.Key_Telcordia_tds,
															KEYED(LEFT.phone[1..3] = RIGHT.npa)
													and KEYED(LEFT.phone[4..6] = RIGHT.nxx)
													and LEFT.phone[7] = RIGHT.tb,
													LEFT OUTER,
													KEEP(1),LIMIT(0));
		
		rAppendCarrierInfo tFormat(dTelcorida pInput) :=
		TRANSFORM
			vCOCTypeUpper := STRINGlib.STRINGtouppercase(pInput.COCType);
			vSSCTypeUpper := STRINGlib.STRINGtouppercase(pInput.SSC);
			
			BOOLEAN vCell :=      (vCOCTypeUpper in ['EOC','PMC','RCC','SP1','SP2','VOI'])
												and (     stringlib.stringfind(vSSCTypeUpper,'C',1) > 0
															or  stringlib.stringfind(vSSCTypeUpper,'R',1) > 0
															or  stringlib.stringfind(vSSCTypeUpper,'S',1) > 0
														);
			
			BOOLEAN vPage :=      vCOCTypeUpper in ['EOC','PMC','RCC','SP1','SP2','VOI']
												and stringlib.stringfind(vSSCTypeUpper,'B',1) > 0;
			
			BOOLEAN vVOIP := vCOCTypeUpper = 'VOI' or stringlib.stringfind(vSSCTypeUpper,'V',1) > 0;
			
			STRING vTypeDesc := MAP(vCell                 => PhoneFinder_Services.Constants.PhoneType.Wireless,
															vPage                 => PhoneFinder_Services.Constants.PhoneType.Pager,
															vVOIP                 => PhoneFinder_Services.Constants.PhoneType.VoIP,
															vCOCTypeUpper = 'EOC' => PhoneFinder_Services.Constants.PhoneType.LandLine,
															PhoneFinder_Services.Constants.PhoneType.Other);
			
			SELF.carrier_name    := pInput.ocn;
			SELF.carrier_city    := pInput.city;
			SELF.carrier_state   := pInput.state;
			SELF.carrier_type    := pInput.COCType;
			SELF.coc_description := vTypeDesc;
			SELF.ssc_description := CASE(pInput.ssc,
																		'A' => 'INTRALATA USE ONLY',
																		'B' => 'PAGING SERVICES',
																		'C' => 'CELLULAR SERVICES',
																		'I' => 'PSEUDO 800 SERVICE CODE',
																		'J' => 'EXTENDED/EXPANDED CALLING SCOPE',
																		'M' => 'LOCAL MASS CALLING CODE',
																		'N' => 'N/A',
																		'O' => 'OTHER',
																		'R' => 'TWO-WAY CONVENTIONAL MOBILE RADIO',
																		'S' => 'MISCELLANEOUS SERVICES',
																		'T' => 'TIME',
																		'W' => 'WEATHER',
																		'X' => 'LOCAL EXCHANGE INTRALATA SPECIAL BILLING OPTION',
																		'Z' => 'SELECTIVE LOCAL EXCHANGE INTRALATA SPECIAL BILLING OPTION',
																		'8' => 'PUERTO RICO and U.S. VIRGIN ISLANDS CODES',
																		'');
			SELF                 := pInput;
		END;
		
		dCarrierInfo := PROJECT(dTelcorida,tFormat(LEFT));
		
		RETURN dCarrierInfo;
	ENDMACRO;
	
	// Listing Type
	EXPORT GetListingType(STRING pListingType,STRING pListingTypeBus,STRING pListingTypeGov,STRING pListingTypeRes) :=
	FUNCTION
		RETURN MAP( pListingType = 'BR'                                                       => PhoneFinder_Services.Constants.ListingType.BusGovRes,
								pListingType = 'BG'                                                       => PhoneFinder_Services.Constants.ListingType.BusGov,
								pListingType = 'RS'                                                       => PhoneFinder_Services.Constants.ListingType.Residential,
								pListingTypeBus = 'B' and pListingTypeGov = 'G' and pListingTypeRes = 'R' => PhoneFinder_Services.Constants.ListingType.BusGovRes,   // ListingType for TU takes preference over in-house
								pListingTypeBus = 'B' and pListingTypeGov = 'G'                           => PhoneFinder_Services.Constants.ListingType.BusGov,      // ListingType for TU takes preference over in-house
								pListingTypeBus = 'B'                                                     => PhoneFinder_Services.Constants.ListingType.Business,
								pListingTypeGov = 'G'                                                     => PhoneFinder_Services.Constants.ListingType.Government,
								pListingTypeRes = 'R'                                                     => PhoneFinder_Services.Constants.ListingType.Residential, // ListingType for TU takes preference over in-house
								'');
	END;
	
	// Clean and uppercase the fields
	SHARED UppercaseFields(dIn,dOut)	:=
	MACRO
		LOADXML('<xml/>');

		#EXPORTXML(doCleanFieldMetaInfo,RECORDOF(dIn));
		
		#UNIQUENAME(fnClean)
		%fnClean%(string x) := ut.CleanSpacesAndUpper(x);
		
		#UNIQUENAME(tCleanFields)
		RECORDOF(dIn)	%tCleanFields%(dIn pInput) :=
		TRANSFORM
			#IF(%'doCleanFieldText'% = '')
				#DECLARE(doCleanField)
				#DECLARE(doCleanFieldText)
				#DECLARE(datasetStartCount)
				#DECLARE(datasetEndCount)
			#END
			
			#SET(doCleanField,TRUE)
			#SET(doCleanFieldText,FALSE)
			#SET(datasetStartCount,0)
			#SET(datasetEndCount,0)
			
			#FOR(doCleanFieldMetaInfo)
				#FOR(Field)
					#IF(stringlib.stringfind(%'@isDataset'%,'1',1) != 0 or stringlib.stringfind(%'@isRecord'%,'1',1) != 0)
						#SET(doCleanField,FALSE)
						#APPEND(doCleanFieldText,'')
						#SET(datasetStartCount,%datasetStartCount% + 1)
					#ELSEIF(stringlib.stringfind(%'@isEnd'%,'1',1) != 0)
						#SET(datasetEndCount,%datasetEndCount% + 1)
						#IF(%datasetEndCount% = %datasetStartCount%)
							#SET(doCleanField,TRUE)
						#END
						#APPEND(doCleanFieldText,'')
					#ELSEIF(%doCleanField%	and	%'@type'% = 'string')
						#SET(doCleanFieldText,'SELF.' + %'@name'%)
						#APPEND(doCleanFieldText,' := ' + %'fnClean'% + '(pInput.')
						#APPEND(doCleanFieldText,%'@name'%)
						#APPEND(doCleanFieldText,')')
						%doCleanFieldText%;
					#ELSE
						#APPEND(doCleanFieldText,'')
					#END
				#END
			#END
			SELF := pInput;
		END;

		dOut := PROJECT(dIn,%tCleanFields%(LEFT));
	ENDMACRO;
	
	// Is minimum info populated to get a DID
	SHARED noDIDWithMinInfo(UNSIGNED did,
													STRING lname,STRING fname,
													STRING ssn,
													STRING prim_range,STRING prim_name,STRING zip,STRING city,STRING st) :=
	FUNCTION
		RETURN (did = 0) and (ssn != '' or
						(lname != '' and fname != '' and prim_range != '' and prim_name != '' and (zip != '' or (city != '' and st != ''))));
		END;
	
	// Append DIDs to the search results which didn't have a DID
	EXPORT AppendDIDs(DATASET(lFinal) dIn) :=
	FUNCTION
		dInSeq := UNGROUP(PROJECT(GROUP(dIn,acctno,ALL),TRANSFORM(lFinal,SELF.seq := COUNTER,SELF := LEFT)));
		
		// Convert fields to uppercase
		UppercaseFields(dInSeq,dInUppercase);
		
		// Get DIDs for records that have enough information
		dInNoDIDs := dInUppercase(noDIDWithMinInfo(did,lname,fname,ssn,prim_range,prim_name,zip,city_name,st));
		
		Autokey_batch.Layouts.rec_inBatchMaster tFormat2DIDReady(dInNoDIDs pInput) :=
		TRANSFORM
			SELF.name_first  := pInput.fname;
			SELF.name_middle := pInput.mname;
			SELF.name_last   := pInput.lname;
			SELF.addr_suffix := pInput.suffix;
			SELF.homephone   := pInput.phone;
			SELF.p_city_name := pInput.city_name;
			SELF.z5          := pInput.zip;
			SELF.dob         := (STRING)pInput.dob;
			SELF             := pInput;
			SELF             := [];
		END;
		
		dFormat2DIDReady := PROJECT(dInNoDIDs,tFormat2DIDReady(LEFT));
		
		dGetDIDs := PhoneFinder_Services.GetDIDs(dFormat2DIDReady)(did_count = 1); //Filter out records which got multiple DIDs
		
		lFinal tAppendDID(dInUppercase le,dGetDIDs ri) :=
		TRANSFORM
			SELF.did := IF(le.did != 0,le.did,ri.did);
			SELF     := le;
		END;
		
		dAppendDIDs := JOIN(dInUppercase,
												dGetDIDs,
												LEFT.acctno = RIGHT.acctno and
												LEFT.seq    = RIGHT.seq,
												tAppendDID(LEFT,RIGHT),
												LEFT OUTER,
												LIMIT(0),KEEP(1)); //only one DID per acctno
		
		#IF(PhoneFinder_Services.Constants.Debug.Intermediate)
			OUTPUT(dInSeq,NAMED('dInSeq'),EXTEND);
			OUTPUT(dInUppercase,NAMED('dInUppercase'),EXTEND);
			OUTPUT(dInNoDIDs,NAMED('dInNoDIDs'),EXTEND);
			OUTPUT(dFormat2DIDReady,NAMED('dFormat2DIDReady'),EXTEND);
			OUTPUT(dGetDIDs,NAMED('dGetDIDs'),EXTEND);
		#END
		
		RETURN dAppendDIDs;
	END;
	
	
	
	// Primary phone info
	EXPORT GetPhoneInfo(dIn,inMod) :=
	FUNCTIONMACRO
		lpf := PhoneFinder_Services.Layouts;
		dPhoneSlim := PROJECT(dIn(phone != ''),
													TRANSFORM(lpf.PhoneFinder.PhoneSlim,
																		SELF.orig_phone  := LEFT.batch_in.homephone,
																		SELF.ListingType := PhoneFinder_Services.Functions.GetListingType(LEFT.RealTimePhone_Ext.ListingType,
																																																			LEFT.listing_type_bus,
																																																			LEFT.listing_type_gov,
																																																			LEFT.listing_type_res);
																		SELF.ListingName 	 := if (LEFT.listed_name != '', LEFT.listed_name, LEFT.RealTimePhone_Ext.ListingName);
																		SELF.dt_first_seen := (UNSIGNED4)LEFT.dt_first_seen,
																		SELF.dt_last_seen  := (UNSIGNED4)LEFT.dt_last_seen,
																		SELF.PortingCode	 := LEFT.PortingCode,
																		SELF.PortingHistory:= LEFT.PortingHistory,
																		SELF             	 := LEFT.RealTimePhone_Ext,
																		SELF             	 := LEFT));
		
		//creates a more consistent output by matching the logic in GetIdentityInfo
		dPhoneSort := SORT(dPhoneSlim(typeflag != Phones.Constants.TypeFlag.DataSource_PV)
																	,acctno,phone,-dt_last_seen,dt_first_seen); 

		lpf.PhoneFinder.PhoneSlim tPhoneRollup(lpf.PhoneFinder.PhoneSlim le,lpf.PhoneFinder.PhoneSlim ri) :=
		TRANSFORM
			SELF.coc_description := MAP(le.coc_description != '' and ri.coc_description != '' and le.coc_description != ri.coc_description => PhoneFinder_Services.Constants.PhoneType.Other,
																	le.coc_description = ''                                                                            => ri.coc_description,
																	le.coc_description = ri.coc_description or ri.coc_description = ''                                 => le.coc_description,
																	PhoneFinder_Services.Constants.PhoneType.Other);
			SELF.ListingType     := IF(le.ListingType != '',le.ListingType,ri.ListingType);
			SELF.phoneriskindicator	:= IF(EXISTS(le.alerts),le.phoneriskindicator,ri.phoneriskindicator);
			SELF.otprifailed				:= IF(EXISTS(le.alerts),le.otprifailed,ri.otprifailed);
			SELF.alerts							:= IF(EXISTS(le.alerts),le.alerts,ri.alerts);
			SELF.CallForwardingIndicator := IF(ri.CallForwardingIndicator = '' or le.CallForwardingIndicator = PhoneFinder_Services.Functions.CallForwardingDesc(1),
			                                   le.CallForwardingIndicator , 
			                                   ri.CallForwardingIndicator);
			SELF.PhoneStatus	            := IF(le.phonestatus = PhoneFinder_Services.Constants.PhoneStatus.NotAvailable,ri.phonestatus,le.phonestatus);
      SELF.carrier_name                := IF(le.carrier_name != '', le.carrier_name, ri.carrier_name);
      SELF.phone_region_city           := IF(le.phone_region_city != '', le.phone_region_city, ri.phone_region_city);
      SELF.phone_region_st             := IF(le.phone_region_st != '', le.phone_region_st, ri.phone_region_st);   
    
			SELF                 		         := le;
		END;		
		dPhoneRollup := ROLLUP(dPhoneSort,
														LEFT.acctno = RIGHT.acctno and
														LEFT.phone  = RIGHT.phone,
														tPhoneRollup(LEFT,RIGHT));
		
		// Overwrite the primary phone details with the phone detail information from TU
			dPrimaryPhoneDetail := dPhoneSlim(typeflag = Phones.Constants.TypeFlag.DataSource_PV);
			
			lpf.PhoneFinder.PhoneSlim tOverwriteWithTU(dPhoneRollup le,dPrimaryPhoneDetail ri) :=
			TRANSFORM
				SELF.acctno            := le.acctno;
				SELF.phone             := le.phone;
				SELF.phone_source      := IF(ri.phone != '',ri.phone_source,le.phone_source);
				SELF.typeflag          := IF(ri.phone != '',ri.typeflag,le.typeflag);
				SELF.PortingCode       := IF(ri.phone != '',ri.PortingCode,le.PortingCode);
				SELF.PortingCount      := IF(ri.phone != '',ri.PortingCount,le.PortingCount);
				SELF.PortingHistory    := IF(ri.phone != '',ri.PortingHistory,le.PortingHistory);
				SELF.PortingStatus		   := IF(ri.phone != '',ri.PortingStatus,le.PortingStatus);
				SELF.FirstPortedDate	  := IF(ri.phone != '',ri.FirstPortedDate,le.FirstPortedDate);
				SELF.LastPortedDate		  := IF(ri.phone != '',ri.LastPortedDate,le.LastPortedDate);
				SELF.Phonestatus		  := IF(ri.phone != '',ri.Phonestatus,le.Phonestatus);
				SELF.ActivationDate		  := IF(ri.phone != '',ri.ActivationDate,le.ActivationDate);
				SELF.DisconnectDate		  := IF(ri.phone != '',ri.DisconnectDate,le.DisconnectDate);
				SELF.Prepaid		 			     := IF(ri.phone != '',ri.Prepaid,le.Prepaid);
				SELF.NoContractCarrier := IF(ri.phone != '',ri.NoContractCarrier,le.NoContractCarrier);
				SELF.Spoof						       := IF(ri.phone != '',ri.Spoof,le.Spoof);
				SELF.Destination			    := IF(ri.phone != '',ri.Destination,le.Destination);
				SELF.Source						      := IF(ri.phone != '',ri.Source,le.Source);
				SELF.FirstEventSpoofedDate := IF(ri.phone != '',ri.FirstEventSpoofedDate,le.FirstEventSpoofedDate);
				SELF.LastEventSpoofedDate  := IF(ri.phone != '',ri.LastEventSpoofedDate,le.LastEventSpoofedDate);
				SELF.TotalSpoofedCount := IF(ri.phone != '',ri.TotalSpoofedCount,le.TotalSpoofedCount);
				SELF.SpoofingHistory	 := IF(ri.phone != '',ri.SpoofingHistory,le.SpoofingHistory);
				SELF.OTP							       := IF(ri.phone != '',ri.OTP,le.OTP);
				SELF.OTPCount					    := IF(ri.phone != '',ri.OTPCount,le.OTPCount);
				SELF.FirstOTPDate			  := IF(ri.phone != '',ri.FirstOTPDate,le.FirstOTPDate);
				SELF.LastOTPDate			   := IF(ri.phone != '',ri.LastOTPDate,le.LastOTPDate);
				SELF.LastOTPStatus		  := IF(ri.phone != '',ri.LastOTPStatus,le.LastOTPStatus);
				SELF.OTPHistory	 			  := IF(ri.phone != '',ri.OTPHistory,le.OTPHistory);
				SELF.PhoneRiskIndicator:= IF(ri.phone != '',ri.PhoneRiskIndicator,le.PhoneRiskIndicator);
				SELF.OTPRIFailed			 := IF(ri.phone != '',ri.OTPRIFailed,le.OTPRIFailed);
				SELF.Alerts						   := IF(ri.phone != '',ri.Alerts,le.Alerts);				
				SELF.ListingType       := IF(ri.ListingType != '',ri.ListingType,le.ListingType);
				SELF.coc_description   := IF(ri.ServiceClass != '',
																			PhoneFinder_Services.Functions.ServiceClassDesc(ri.ServiceClass),
																			le.coc_description);
				SELF.carrier_name      := MAP(ri.operatingcompany.name != ''=> ri.operatingcompany.name,
                                      ri.carrier_name != ''=> ri.carrier_name,
                                      le.carrier_name);
				SELF.phone_region_city := MAP(ri.operatingcompany.address.city != '' => ri.operatingcompany.address.city,
                                      ri.phone_region_city != ''=> ri.phone_region_city,
                                      le.phone_region_city);
				SELF.phone_region_st   := MAP(ri.operatingcompany.address.state != '' => ri.operatingcompany.address.state,
                                      ri.phone_region_st != ''=> ri.phone_region_st,
                                      le.phone_region_st);
				SELF.CallForwardingIndicator                   :=  le.CallForwardingIndicator;
				SELF                   := ri;
			END;
			
			dPhoneDetail_ := JOIN(dPhoneRollup,
														dPrimaryPhoneDetail,
														LEFT.acctno = RIGHT.acctno and
														LEFT.phone  = RIGHT.phone,
														tOverwriteWithTU(LEFT,RIGHT),
														LEFT OUTER,
														LIMIT(0),KEEP(1));
														
			// To preserve single records coming from Qsent PVS(type flag P ) 
			dTUPhonesOnly := JOIN(dPrimaryPhoneDetail, dPhoneDetail_, 
			                     LEFT.acctno = RIGHT.acctno and 
													            LEFT.phone  = RIGHT.phone, 
																		       TRANSFORM(lpf.PhoneFinder.PhoneSlim,
 																					    SELF.coc_description   := IF(LEFT.ServiceClass != '', 
   																						                             PhoneFinder_Services.Functions.ServiceClassDesc(LEFT.ServiceClass), LEFT.coc_description);
                       SELF := LEFT),
																		       LEFT ONLY);
			
		 dAllPhonesDetail_ := dPhoneDetail_ + dTUPhonesOnly;
		 dPhoneDetail := IF(EXISTS(dPhoneRollup),dAllPhonesDetail_,dPrimaryPhoneDetail);
		
		lpf.PhoneFinder.PhoneIesp tFormat2IespPhone(lpf.PhoneFinder.PhoneSlim pInput) :=
		TRANSFORM
			SELF.Number                           := pInput.phone;
			SELF._Type                            := pInput.coc_description;
			SELF.Carrier                          := pInput.carrier_name;
			SELF.CarrierCity                      := pInput.phone_region_city;
			SELF.CarrierState                     := pInput.phone_region_st;
			SELF.PortingCode	                     := pInput.PortingCode;
			SELF.PortingCount                     := pInput.PortingCount;
			SELF.FirstPortedDate                  := iesp.ECL2ESP.toDate(pInput.FirstPortedDate);
			SELF.LastPortedDate                   := iesp.ECL2ESP.toDate(pInput.LastPortedDate);	
			Phone_Status                          :=  pInput.PhoneStatus;
			SELF.ActivationDate 									:= IF(Phone_Status = PhoneFinder_Services.Constants.PhoneStatus.Active,
			                                         iesp.ECL2ESP.toDate(pInput.ActivationDate));			
			SELF.DisconnectDate 									:= IF(Phone_Status = PhoneFinder_Services.Constants.PhoneStatus.INACTIVE,
			                                            iesp.ECL2ESP.toDate(pInput.DisconnectDate));
			SELF.Prepaid		 			 								           := pInput.Prepaid;
			SELF.NoContractCarrier 								       := pInput.NoContractCarrier;			
			SELF.PortingStatus                    := pInput.PortingStatus;
			SELF.PortingHistory                   := PROJECT(pInput.PortingHistory,TRANSFORM(iesp.phonefinder.t_PortingHistory,
																																				SELF.PortStartDate 	:= iesp.ECL2ESP.toDate(LEFT.PortStartDate),
																																				SELF.PortEndDate  	:= iesp.ECL2ESP.toDate(LEFT.PortEndDate),
																																				SELF:=LEFT));			
			SELF.SpoofingData.Spoof               := PROJECT(pInput.Spoof,TRANSFORM(iesp.phonefinder.t_SpoofCommon,
																																				SELF.FirstSpoofedDate 	:= iesp.ECL2ESP.toDate(LEFT.FirstSpoofedDate),
																																				SELF.LastSpoofedDate  	:= iesp.ECL2ESP.toDate(LEFT.LastSpoofedDate),
																																				SELF:=LEFT));
			SELF.SpoofingData.Destination         := PROJECT(pInput.Destination,TRANSFORM(iesp.phonefinder.t_SpoofCommon,
																																				SELF.FirstSpoofedDate 	:= iesp.ECL2ESP.toDate(LEFT.FirstSpoofedDate),
																																				SELF.LastSpoofedDate  	:= iesp.ECL2ESP.toDate(LEFT.LastSpoofedDate),
																																				SELF:=LEFT));
			SELF.SpoofingData.Source			        := PROJECT(pInput.Source,TRANSFORM(iesp.phonefinder.t_SpoofCommon,
																																				SELF.FirstSpoofedDate 	:= iesp.ECL2ESP.toDate(LEFT.FirstSpoofedDate),
																																				SELF.LastSpoofedDate  	:= iesp.ECL2ESP.toDate(LEFT.LastSpoofedDate),
																																				SELF:=LEFT));		
			SELF.SpoofingData.FirstEventSpoofedDate						:= iesp.ECL2ESP.toDate(pInput.FirstEventSpoofedDate);																																				
			SELF.SpoofingData.LastEventSpoofedDate 						:= iesp.ECL2ESP.toDate(pInput.LastEventSpoofedDate);																																				
			SELF.SpoofingData.TotalSpoofedCount 							:= pInput.TotalSpoofedCount;
			SELF.SpoofingData.SpoofingHistory	 		:= PROJECT(pInput.SpoofingHistory,TRANSFORM(iesp.phonefinder.t_SpoofHistory,
																																				SELF.EventDate  	:= iesp.ECL2ESP.toDatestring8(LEFT.EventDate),
																																				SELF:=LEFT));	
			SELF.OneTimePassword.FirstOTPDate			:= iesp.ECL2ESP.toDate(pInput.FirstOTPDate);
			SELF.OneTimePassword.LastOTPDate			:= iesp.ECL2ESP.toDate(pInput.LastOTPDate);
			SELF.OneTimePassword.OTP							:= pInput.OTP;
			SELF.OneTimePassword.OTPCount					:= pInput.OTPCount;
			SELF.OneTimePassword.LastOTPStatus		:= pInput.LastOTPStatus;
			SELF.OneTimePassword.OTPHistory	 			:= PROJECT(pInput.OTPHistory,TRANSFORM(iesp.phonefinder.t_OTPHistory,
																																				SELF.EventDate  	:= iesp.ECL2ESP.toDatestring8(LEFT.EventDate),
																																				SELF:=LEFT));			
			SELF.PhoneRiskIndicator								:= pInput.PhoneRiskIndicator;
			SELF.OTPRIFailed											:= pInput.OTPRIFailed;
			SELF.Alerts						 								:= PROJECT(pInput.Alerts,iesp.phonefinder.t_PhoneFinderAlert);
			SELF.PhoneStatus                      := Phone_Status;
			SELF.MSA                              := pInput.MetroStatAreaCode;
			SELF.CMSA                             := pInput.ConsMetroStatAreaCode;
			SELF.FIPS                             := pInput.CountyCode;
			SELF.CarrierRouteZoneCode             := pInput.SortZone;
			SELF.GeoLocation                      := ROW({pInput.Latitude,pInput.Longitude},iesp.share.t_GeoLocation);
			SELF.AddressType                      := PhoneFinder_Services.Functions.AddressTypeDesc(pInput.AddressType);
			SELF.CallerID                         := pInput.GenericName;
			SELF.OperatingCompany.CompanyNumber   := pInput.OperatingCompany.Number;
			SELF.OperatingCompany.Name            := pInput.OperatingCompany.Name;
			SELF.OperatingCompany.Address         := PROJECT(pInput.OperatingCompany.Address,
																												TRANSFORM(iesp.share.t_Address,SELF := LEFT,SELF := []));
			SELF.OperatingCompany.AffiliatedTo    := pInput.OperatingCompany.AffiliatedTo;
			SELF.OperatingCompany.ContactName     := PROJECT(pInput.OperatingCompany.Contact.Name,
																												TRANSFORM(iesp.share.t_Name,
																																	SELF.Full   := LEFT.fullname,
																																	SELF.First  := LEFT.fname,
																																	SELF.Middle := LEFT.mname,
																																	SELF.Last   := LEFT.lname,
																																	SELF.Suffix := LEFT.name_suffix,
																																	SELF.Prefix := LEFT.name_prefix));
			SELF.OperatingCompany.ContactAddress  := PROJECT(pInput.OperatingCompany.Contact.Address,
																												TRANSFORM(iesp.share.t_Address,SELF := LEFT,SELF := []));
			SELF.OperatingCompany.Email           := pInput.OperatingCompany.Contact.Email;
			SELF.OperatingCompany.ContactPhone    :=  pInput.OperatingCompany.PhoneInfo.PhoneNPA
																							+ pInput.OperatingCompany.PhoneInfo.PhoneNXX
																							+ pInput.OperatingCompany.PhoneInfo.PhoneLine;
			SELF.OperatingCompany.ContactPhoneExt := pInput.OperatingCompany.PhoneInfo.PhoneExt;
			SELF.OperatingCompany.Fax             :=  pInput.OperatingCompany.PhoneInfo.FaxNPA
																							+ pInput.OperatingCompany.PhoneInfo.FaxNXX
																							+ pInput.OperatingCompany.PhoneInfo.FaxLine;																		
			SELF.CallForwardingIndicator          := pInput.CallForwardingIndicator;
			SELF                                  := pInput;
			SELF																	:= [];
		END;
		
		dPhoneIesp := PROJECT(SORT(dPhoneDetail,acctno,-phone_score),tFormat2IespPhone(LEFT));
		// to process super rule -1 for no phone recs
		dNophoneIesp := PROJECT(dIn(phone = ''), TRANSFORM(lpf.PhoneFinder.PhoneIesp, SELF.PhoneRiskIndicator := LEFT.PhoneRiskIndicator,
		                                                SELF.Alerts	:= PROJECT(LEFT.Alerts,iesp.phonefinder.t_PhoneFinderAlert) , SELF := []));
		
	  dPhoneIesp_Final := dPhoneIesp + dNophoneIesp;
		
	  #IF(PhoneFinder_Services.Constants.Debug.Intermediate)
 			  OUTPUT(dPhoneSlim,NAMED('dPhoneSlim_Primary'),EXTEND);
   			OUTPUT(dPhoneSort,NAMED('dPhoneSort_Primary'),EXTEND);
   			OUTPUT(dPhoneRollup,NAMED('dPhoneRollup_Primary'),EXTEND);			
   			OUTPUT(dPrimaryPhoneDetail,NAMED('dPrimaryPhoneDetail_Primary'),EXTEND);
   			OUTPUT(dPhoneDetail_,NAMED('dPhoneDetail_'),EXTEND);		
			  OUTPUT(dTUPhonesOnly,NAMED('dTUPhonesOnly'),EXTEND);				
   		  OUTPUT(dAllPhonesDetail_,NAMED('dAllPhonesDetail_'),EXTEND);			
   		  OUTPUT(dPhoneDetail,NAMED('dPhoneDetail_Primary'),EXTEND);
        OUTPUT(dPhoneIesp,NAMED('dPhoneIesp_Primary'),EXTEND);
			  OUTPUT(dPhoneIesp_Final,NAMED('dPhoneIesp_Final'),EXTEND);
		 #END

		RETURN dPhoneIesp_Final;
	ENDMACRO;
	
	// Other phone info
	EXPORT GetOtherInfo(dIn,inMod) :=
	FUNCTIONMACRO
		IMPORT std, ut;
		lpf := PhoneFinder_Services.Layouts;
		today:= (STRING)Std.Date.Today();
		dPhoneSlim := PROJECT(dIn(phone != ''),
													TRANSFORM(lpf.PhoneFinder.PhoneSlim,
																		SELF.orig_phone  := LEFT.batch_in.homephone,
																		SELF.ListingType := PhoneFinder_Services.Functions.GetListingType(LEFT.RealTimePhone_Ext.ListingType,
																																																			LEFT.listing_type_bus,
																																																			LEFT.listing_type_gov,
																																																			LEFT.listing_type_res);
																		SELF.ListingName 	 := if (LEFT.listed_name != '', LEFT.listed_name, LEFT.RealTimePhone_Ext.ListingName);
																		SELF.dt_first_seen := (UNSIGNED4)LEFT.dt_first_seen,
																		SELF.dt_last_seen  := (UNSIGNED4)LEFT.dt_last_seen,
																		SELF.PortingCode   := LEFT.PortingCode,
																		SELF             	 := LEFT.RealTimePhone_Ext,
																		SELF             	 := LEFT));
		
		dPhoneSort := SORT(dPhoneSlim(typeflag != Phones.Constants.TypeFlag.DataSource_PV),acctno,phone);
		
		lpf.PhoneFinder.PhoneSlim tPhoneRollup(lpf.PhoneFinder.PhoneSlim le,lpf.PhoneFinder.PhoneSlim ri) :=
		TRANSFORM
			SELF.coc_description := MAP(le.coc_description != '' and ri.coc_description != '' and le.coc_description != ri.coc_description => PhoneFinder_Services.Constants.PhoneType.Other,
																	le.coc_description = ''                                                                            => ri.coc_description,
																	le.coc_description = ri.coc_description or ri.coc_description = ''                                 => le.coc_description,
																	PhoneFinder_Services.Constants.PhoneType.Other);
			SELF.ListingType     := IF(le.ListingType != '',le.ListingType,ri.ListingType);
			SELF.PhoneOwnershipIndicator := le.PhoneOwnershipIndicator or ri.PhoneOwnershipIndicator;
			SELF.CallForwardingIndicator := IF(ri.CallForwardingIndicator = '' or le.CallForwardingIndicator = PhoneFinder_Services.Functions.CallForwardingDesc(1),
			                                   le.CallForwardingIndicator , 
			                                   ri.CallForwardingIndicator);
			SELF.PhoneStatus	            := IF(le.phonestatus = PhoneFinder_Services.Constants.PhoneStatus.NotAvailable,ri.phonestatus,le.phonestatus);
			SELF                 := le;
		END;
		
		dPhoneRollup := ROLLUP(dPhoneSort,
														LEFT.acctno = RIGHT.acctno and
														LEFT.phone  = RIGHT.phone,
														tPhoneRollup(LEFT,RIGHT));

		dLimitOthers := TOPN(GROUP(dPhoneRollup,acctno),PhoneFinder_Services.Constants.WFConstants.MaxSectionLimit,acctno,-phone_score);										
		
		lpf.PhoneFinder.OtherPhoneIesp tFormat2IespPhone(lpf.PhoneFinder.PhoneSlim pInput) :=
		TRANSFORM
			SELF.Number                           := pInput.phone;
			SELF._Type                            := pInput.coc_description;
			SELF.Carrier                          := pInput.carrier_name;
			SELF.CarrierCity                      := pInput.phone_region_city;
			SELF.CarrierState                     := pInput.phone_region_st;
			SELF.PortingCode	                     := pInput.PortingCode;
			SELF.LastPortedDate	                  := iesp.ECL2ESP.toDate(pInput.LastPortedDate);
			SELF.PhoneRiskIndicator	              := pInput.PhoneRiskIndicator;
			SELF.OTPRIFailed	              			    := pInput.OTPRIFailed;
			SELF.PhoneStatus                      := pInput.PhoneStatus, 			                                         
			SELF.Address       := iesp.ECL2ESP.SetAddress(pInput.prim_name,pInput.prim_range,
																										pInput.predir,pInput.postdir,pInput.suffix,
																										pInput.unit_desig,pInput.sec_range,
																										pInput.city_name,pInput.st,pInput.zip,
																										pInput.zip4,pInput.county_name);
			SELF.DateFirstSeen := iesp.ECL2ESP.toDate(pInput.dt_first_seen);
			SELF.DateLastSeen  := iesp.ECL2ESP.toDate(pInput.dt_last_seen);
			SELF.MonthsWithPhone := IF(pInput.dt_first_seen != 0 AND pInput.dt_last_seen != 0,
															(STRING)ROUND(ut.DaysApart(((STRING)pInput.dt_last_seen)[1..6]+'01',((STRING)pInput.dt_first_seen)[1..6]+'01')/(365/12)),
															'');
			SELF.MonthsSinceLastSeen := IF(pInput.dt_last_seen != 0,
															(STRING)ROUND(ut.DaysApart((today)[1..6]+'01',((STRING)pInput.dt_last_seen)[1..6]+'01')/(365/12)),
															'');
			SELF.PhoneOwnershipIndicator           := pInput.PhoneOwnershipIndicator;												
			SELF.CallForwardingIndicator          := pInput.CallForwardingIndicator;
			SELF                                  := pInput;
			SELF																	:= [];
		END;
		
		dPhoneIesp := PROJECT(dLimitOthers,tFormat2IespPhone(LEFT));

	  #IF(PhoneFinder_Services.Constants.Debug.Intermediate)
				OUTPUT(dPhoneSlim,NAMED('dPhoneSlim'),EXTEND);
   	OUTPUT(dPhoneRollup,NAMED('dPhoneRollup'),EXTEND);
				OUTPUT(dPhoneIesp,NAMED('dPhoneIesp'),EXTEND);		
		#END

		RETURN UNGROUP(dPhoneIesp);
	ENDMACRO;
	
	// Identity info
	EXPORT GetIdentityInfo(DATASET(lFinal) dIn,BOOLEAN isPhoneSearch) :=
	FUNCTION
		today:= (STRING)Std.Date.Today();
		dIdentitySlim := PROJECT(dIn((lname != '' or listed_name != '') and typeflag != Phones.Constants.TypeFlag.DataSource_PV),
															TRANSFORM(lIdentitySlim,
																				SELF.dt_first_seen := IF(LENGTH(TRIM(LEFT.dt_first_seen)) = 8,
																																	(INTEGER)LEFT.dt_first_seen,(INTEGER)(LEFT.dt_first_seen + '00')),
																				SELF.dt_last_seen  := IF(LENGTH(TRIM(LEFT.dt_last_seen)) = 8,
																																	(INTEGER)LEFT.dt_last_seen,(INTEGER)(LEFT.dt_last_seen + '00')),
																				SELF               := LEFT));
		
		// Rollup
		lIdentitySlim tIdentityRollup(lIdentitySlim le,lIdentitySlim ri) :=
		TRANSFORM
			SELF.dt_first_seen := ut.Min2(le.dt_first_seen, ri.dt_first_seen);
			SELF.dt_last_seen  := IF(le.dt_last_seen <= (INTEGER)today and le.dt_last_seen >= ri.dt_last_seen,
																le.dt_last_seen,
																ri.dt_last_seen);
			SELF.PhoneOwnershipIndicator := le.PhoneOwnershipIndicator or ri.PhoneOwnershipIndicator;												
			SELF               := le;
		END;
		
		dIdentityDIDSort   := SORT(dIdentitySlim(did != 0),acctno,did, IF(PhoneOwnershipIndicator,0,1), -dt_last_seen,dt_first_seen);
		dIdentityDIDRollUp := ROLLUP(dIdentityDIDSort,tIdentityRollup(LEFT,RIGHT),acctno,did);
		
		dIdentityNoDIDSort   := SORT(dIdentitySlim(did = 0),acctno, IF(PhoneOwnershipIndicator,0,1), -dt_last_seen,dt_first_seen,RECORD);
		dIdentityNoDIDRollup := ROLLUP(dIdentityNoDIDSort,tIdentityRollup(LEFT,RIGHT),EXCEPT phone_source,penalt,dt_first_seen,dt_last_seen);
		
		// Combine and dedup the data
		dIdentityCombined := dIdentityDIDRollUp & dIdentityNoDIDRollup;
		
		// Depending on the type of search, restrict the number of records to the max counts
		vMaxCount := IF(isPhoneSearch,iesp.Constants.Phone_Finder.MaxIdentities,iesp.Constants.Phone_Finder.MaxPhoneHistory);
		
		dIdentityTopn := DEDUP(SORT(dIdentityCombined,acctno,did=0,penalt,IF(PhoneOwnershipIndicator,0,1),-dt_last_seen,dt_first_seen,phone_source),acctno,KEEP(vMaxCount));
		
		// Format to iesp
		lIdentityIesp tFormat2IespIdentity(lIdentitySlim pInput) :=
		TRANSFORM
			vFullName      := IF( pInput.fname != '' or pInput.lname != '',
														Address.NameFromComponents(pInput.fname,pInput.mname,pInput.lname,pInput.name_suffix),
														pInput.listed_name);
			vStreetAddress := Address.Addr1FromComponents(pInput.prim_range,pInput.predir,pInput.prim_name,pInput.suffix,
																										pInput.postdir,pInput.unit_desig,pInput.sec_range);
			vCityStZip     := Address.Addr2FromComponentsWithZip4(pInput.city_name,pInput.st,pInput.zip,pInput.zip4);
			
			SELF.UniqueId                          := (STRING)pInput.did;
			SELF.Deceased                          := pInput.deceased;
			SELF.Name                              := iesp.ECL2ESP.SetName( pInput.fname,
																																			pInput.mname,
																																			pInput.lname,
																																			pInput.name_suffix,
																																			'',
																																			vFullName);
			SELF.RecentAddress                     := iesp.ECL2ESP.SetAddress(pInput.prim_name,pInput.prim_range,
																																				pInput.predir,pInput.postdir,pInput.suffix,
																																				pInput.unit_desig,pInput.sec_range,
																																				pInput.city_name,pInput.st,pInput.zip,
																																				pInput.zip4,pInput.county_name,'',
																																				vStreetAddress[1..60],vStreetAddress[61..],
																																				vCityStZip);
			SELF.PrimaryAddressType								 := pInput.primary_address_type;																				
			SELF.RecordType												 := pInput.TNT;																				
			SELF.FirstSeenWithPrimaryPhone         := iesp.ECL2ESP.toDate(pInput.dt_first_seen);
			SELF.LastSeenWithPrimaryPhone          := iesp.ECL2ESP.toDate(pInput.dt_last_seen);
			SELF.TimeWithPrimaryPhone              := IF(pInput.dt_first_seen != 0 and pInput.dt_last_seen != 0,
																								(STRING)ROUND(ut.DaysApart(((STRING)pInput.dt_last_seen)[1..6]+'01',((STRING)pInput.dt_first_seen)[1..6]+'01')/(365/12)),
																										'');
			SELF.TimeSinceLastSeenWithPrimaryPhone := IF(pInput.dt_last_seen != 0,
																									(STRING)ROUND(ut.DaysApart((today)[1..6]+'01',((STRING)pInput.dt_last_seen)[1..6]+'01')/(365/12)),
																										'');
			SELF.PhoneOwnershipIndicator           := pInput.PhoneOwnershipIndicator;
			SELF                                   := pInput;
			SELF																	 := [];
		END;
		
		dIdentityIesp := PROJECT(dIdentityTopn,tFormat2IespIdentity(LEFT));

	 #IF(PhoneFinder_Services.Constants.Debug.Intermediate)
			OUTPUT(dIdentitySlim,NAMED('dIdentitySlim'),EXTEND);
			OUTPUT(dIdentityDIDRollUp,NAMED('dIdentityDIDRollUp'),EXTEND);
			OUTPUT(dIdentityNoDIDRollUp,NAMED('dIdentityNoDIDRollUp'),EXTEND);
			OUTPUT(dIdentityCombined,NAMED('dIdentityCombined'),EXTEND);
			OUTPUT(dIdentityTopn,NAMED('dIdentityTopn'),EXTEND);
			OUTPUT(dIdentityIesp,NAMED('dIdentityIesp'),EXTEND);
		#END		
		
		RETURN dIdentityIesp;
	END;
	
	// Format search results to IESP layout
	EXPORT FormatResults2IESP(pSearchBy, inMod, dInBestInfo, dSearchResultsUnfiltered, isPhoneSearch) :=
	FUNCTIONMACRO
		IMPORT Address,Doxie,iesp,Suppress, ut;
	dSearchResults := dSearchResultsUnfiltered; // temp change until Product verifies impact of the filter
	//PFP2 1.6.3 and 1.6.4 remove Nonpublished and records without names for all versions of PhoneFinder
	// dSearchResults := dSearchResultsUnfiltered(realtimephone_ext.NonPublished<>'Y' AND (listed_name<>'' OR lname <>'' OR fname<>'')); 

	// IF(NOT EXISTS(dSearchResults) AND NOT (inMod.VerifyPhoneIsActive OR inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress),FAIL(10,doxie.ErrorCodes(10)));
		#IF(isPhoneSearch)
			dSearchResultsPrimaryPhone := dSearchResults;
			
			dIdentitiesInfo   := PhoneFinder_Services.Functions.GetIdentityInfo(dSearchResultsPrimaryPhone,isPhoneSearch);
			dPrimaryPhoneInfo := PhoneFinder_Services.Functions.GetPhoneInfo(dSearchResultsUnfiltered,inMod);
		#ELSE
			dSearchResultsPrimaryPhoneUnfiltered := dSearchResultsUnfiltered(isPrimaryPhone);
			dSearchResultsPrimaryPhone := dSearchResults(isPrimaryPhone);
			dSearchResultsOtherPhones  := dSearchResults(~isPrimaryPhone);
			
			dPhoneHistRecs    := dSearchResultsPrimaryPhone;
			dPrimaryPhoneRecs := dSearchResultsPrimaryPhoneUnfiltered(phone_source in [PhoneFinder_Services.Constants.PhoneSource.Waterfall,
																																				PhoneFinder_Services.Constants.PhoneSource.QSentGateway]);
			
			dIdentitiesInfo   := PhoneFinder_Services.Functions.GetIdentityInfo(dPhoneHistRecs,isPhoneSearch);
			dPrimaryPhoneInfo := PhoneFinder_Services.Functions.GetPhoneInfo(dPrimaryPhoneRecs,inMod);
			dOtherPhoneInfo   := PhoneFinder_Services.Functions.GetOtherInfo(dSearchResultsOtherPhones,inMod);
		#END
		// start phone verification
		doVerify := inMod.VerifyPhoneIsActive OR inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress;

		phoneEntered := pSearchBy.PhoneNumber != ''; 
		
		vmod := PROJECT(inMod, $.IParam.PhoneVerificationParams, OPT);   
		vRec := PhoneFinder_Services.GetVerifiedRecs(vmod).verify(dIdentitiesInfo, pSearchBy, (STRING)dInBestInfo[1].did);
																
		hasMatch := EXISTS(vRec);
										
		dPrimaryPhoneInfo xFormDetails() := TRANSFORM
			SELF.ListingType := dPrimaryPhoneInfo[1].ListingType;
			SELF._Type := dPrimaryPhoneInfo[1]._Type;
			SELF.VerificationStatus.PhoneVerificationDescription :=
														MAP(~phoneEntered => PhoneFinder_Services.Constants.VerifyMessage.PhoneNotEntered,
																inMod.VerifyPhoneNameAddress AND hasMatch => PhoneFinder_Services.Constants.VerifyMessage.PhoneMatchesNameAddress,
																inMod.VerifyPhoneName AND hasMatch => PhoneFinder_Services.Constants.VerifyMessage.PhoneMatchesName,
																(inMod.VerifyPhoneNameAddress AND ~hasMatch) OR 
																	(inMod.VerifyPhoneName AND ~hasMatch) => PhoneFinder_Services.Constants.VerifyMessage.PhoneCannotBeVerified,
																inMod.VerifyPhoneIsActive AND hasMatch => PhoneFinder_Services.Constants.VerifyMessage.PhoneIsActive,
																inMod.VerifyPhoneIsActive AND ~hasMatch => PhoneFinder_Services.Constants.VerifyMessage.PhoneNotActive,
																'');

		  SELF.VerificationStatus.PhoneVerified := hasMatch AND (inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress OR inMod.VerifyPhoneIsActive);
			// SELF := []; //Release 3 req 1.11 - now returning all fields for verification searches
			SELF:=dPrimaryPhoneInfo[1];
		END;
		
		dPrimaryPhoneInfo2 := IF(doVerify, DATASET([xFormDetails()]), dPrimaryPhoneInfo);

		dIdentitiesInfo xFormIdentity(vRec le) := TRANSFORM
		  
			SELF.FirstSeenWithPrimaryPhone := le.FirstSeenWithPrimaryPhone;
			SELF.LastSeenWithPrimaryPhone := le.LastSeenWithPrimaryPhone;
			SELF:= le;
			SELF := [];
			
		END;		
		vrec_identities := PROJECT(vRec, xFormIdentity(LEFT));
  
  dIdentitiesInfo2 := IF(doVerify and exists(vrec_identities), vrec_identities, dIdentitiesInfo);	
		/* End phone verification */
 		Suppress.MAC_Suppress(dInBestInfo, dBestInfoSuppress,
   													inMod.ApplicationType,Suppress.Constants.LinkTypes.DID,did,'','',FALSE,'',TRUE);	
   											
   		iesp.phonefinder.t_PhoneIdentityInfo tPrimaryIdentity(dBestInfoSuppress le,dIdentitiesInfo ri) :=
   		TRANSFORM
   			vFullName      := Address.NameFromComponents(le.name_first,le.name_middle,le.name_last,le.name_suffix);
   			vStreetAddress := Address.Addr1FromComponents(le.prim_range,le.predir,le.prim_name,le.addr_suffix,
   																										le.postdir,le.unit_desig,le.sec_range);
   			vCityStZip     := Address.Addr2FromComponentsWithZip4(le.p_city_name,le.st,le.z5,le.zip4);
   			
   			SELF.UniqueID                          := INTFORMAT(le.did,12,1);
   			SELF.Name                              := iesp.ECL2ESP.SetName(le.name_first,le.name_middle,le.name_last,le.name_suffix,'',vFullName);
   			SELF.RecentAddress                     := iesp.ECL2ESP.SetAddress(le.prim_name,le.prim_range,le.predir,le.postdir,
   																																				le.addr_suffix,le.unit_desig,le.sec_range,le.p_city_name,
   																																				le.st,le.z5,le.zip4,'','',vStreetAddress[1..60],vStreetAddress[61..],vCityStZip);
   			SELF.PrimaryAddressType								 := ri.PrimaryAddressType;																																	
   			SELF.RecordType												 := ri.RecordType;																																	
   			SELF.Deceased                          := IF((Integer)le.dod != 0,'Y','N'); 
   			SELF.FirstSeenWithPrimaryPhone         := ri.FirstSeenWithPrimaryPhone;
   			SELF.LastSeenWithPrimaryPhone          := ri.LastSeenWithPrimaryPhone;
   			SELF.TimeWithPrimaryPhone              := ri.TimeWithPrimaryPhone;
   			SELF.TimeSinceLastSeenWithPrimaryPhone := ri.TimeSinceLastSeenWithPrimaryPhone;
   			SELF.PhoneOwnershipIndicator           := ri.PhoneOwnershipIndicator;
   		END;
   		
   		dPrimaryIdentity := JOIN( dBestInfoSuppress,
   															dIdentitiesInfo2,
   															LEFT.acctno = RIGHT.acctno and
   															LEFT.did    = (UNSIGNED)RIGHT.UniqueId,
   															tPrimaryIdentity(LEFT,RIGHT),
   															LEFT OUTER,
   															LIMIT(0),KEEP(1));				
   
   		iesp.phonefinder.t_PhoneFinderSearchRecord tFormat2PhoneFinderSearch() :=
   		TRANSFORM
   			SELF.Identities          := IF(isPhoneSearch,
   																			SORT(PROJECT(dIdentitiesInfo2,iesp.phonefinder.t_PhoneIdentityInfo),IF(PhoneOwnershipIndicator,0,1),-iesp.ECL2ESP.DateToInteger(LastSeenWithPrimaryPhone)),
   																			dPrimaryIdentity);
   			SELF.PrimaryPhoneDetails := PROJECT(dPrimaryPhoneInfo2,iesp.phonefinder.t_PhoneFinderDetailedInfo)[1];	
   			SELF.PhonesHistory       := IF(~isPhoneSearch,
   																			SORT(PROJECT(dIdentitiesInfo2,
   																										TRANSFORM(iesp.phonefinder.t_PhoneFinderHistory,
   																															SELF.Address   := LEFT.RecentAddress,
   																															SELF.FirstSeen := LEFT.FirstSeenWithPrimaryPhone,
   																															SELF.LastSeen  := LEFT.LastSeenWithPrimaryPhone,
   																															SELF           := LEFT)),
   																						-iesp.ECL2ESP.DateToInteger(LastSeen)));
   			#IF(~isPhoneSearch)
   				SELF.OtherPhones       := PROJECT(dOtherPhoneInfo,iesp.phonefinder.t_PhoneFinderInfo);
   			#END
   			SELF                     := [];
   		END;
   		
   		dFormat2PhoneFinderSearch := DATASET([tFormat2PhoneFinderSearch()]);
   		Records   := IF(EXISTS(dSearchResults) OR doVerify,dFormat2PhoneFinderSearch);
   
   	// Debug
   		#IF(PhoneFinder_Services.Constants.Debug.Main)
   			#IF(isPhoneSearch)
   				OUTPUT(dIdentitiesInfo,NAMED('dIdentitiesInfo_PhoneSearch'));
   				OUTPUT(dPrimaryPhoneInfo,NAMED('dPrimaryPhoneInfo_PhoneSearch'));
   				OUTPUT(dFormat2PhoneFinderSearch,NAMED('dFormat2PhoneFinderSearch_PhoneSearch'));
   				OUTPUT(dInNoPhoneBestInfo,NAMED('dInNoPhoneBestInfo'));
   			#ELSE
   				OUTPUT(dPhoneHistRecs,NAMED('dPhoneHistRecs'));
   				OUTPUT(dPrimaryPhoneRecs,NAMED('dPrimaryPhoneRecs'));
   				OUTPUT(dIdentitiesInfo,NAMED('dIdentitiesInfo'));
   				OUTPUT(dBestInfoSuppress,NAMED('dBestInfoSuppress'));
   				OUTPUT(dIdentitiesInfo2,NAMED('dIdentitiesInfo2'));
   				OUTPUT(dPrimaryPhoneInfo,NAMED('dPrimaryPhoneInfo'));
   				OUTPUT(dOtherPhoneInfo,NAMED('dOtherPhoneInfo'));
   				OUTPUT(dFormat2PhoneFinderSearch,NAMED('dFormat2PhoneFinderSearch'));
   			#END
   		#END

		RETURN Records;
	ENDMACRO;
	
	// Format search results to batch layout
	EXPORT FormatResults2Batch(dIn,inMod,dinBestInfo,dSearchResultsUnfiltered,isPhoneSearch) :=
	FUNCTIONMACRO
		IMPORT Address,Doxie,iesp,Suppress;
	dSearchResults := dSearchResultsUnfiltered; // temp change until Product verifies impact of the filter

	//PFP2 1.6.3 and 1.6.4 remove Nonpublished and records without names for all versions of PhoneFinder			
	// dSearchResults := dSearchResultsUnfiltered(realtimephone_ext.NonPublished<>'Y' AND (listed_name<>'' OR lname <>'' OR fname<>'')); 			
		pf := PhoneFinder_Services.Layouts;
		
		#IF(isPhoneSearch)
			dSearchResultsPrimaryPhone := dSearchResults;
			
			dIdentitiesInfo   := PhoneFinder_Services.Functions.GetIdentityInfo(dSearchResultsPrimaryPhone,isPhoneSearch);
			dPrimaryPhoneInfo := PhoneFinder_Services.Functions.GetPhoneInfo(dSearchResultsUnfiltered,inMod);
		#ELSE
			dSearchResultsPrimaryPhoneUnfiltered := dSearchResultsUnfiltered(isPrimaryPhone);
			dSearchResultsPrimaryPhone := dSearchResults(isPrimaryPhone);
			dSearchResultsOtherPhones  := dSearchResults(~isPrimaryPhone);
			
			dPhoneHistRecs    := dSearchResultsPrimaryPhone;
			dPrimaryPhoneRecs := dSearchResultsPrimaryPhoneUnfiltered(phone_source in [PhoneFinder_Services.Constants.PhoneSource.Waterfall,
																																				PhoneFinder_Services.Constants.PhoneSource.QSentGateway]);
			
			dIdentitiesInfo   := PhoneFinder_Services.Functions.GetIdentityInfo(dPhoneHistRecs,isPhoneSearch);
			dPrimaryPhoneInfo := PhoneFinder_Services.Functions.GetPhoneInfo(dPrimaryPhoneRecs,inMod);
			dOtherPhoneInfo   := PhoneFinder_Services.Functions.GetOtherInfo(dSearchResultsOtherPhones,inMod);
		#END
	 
		doVerification := inMod.VerifyPhoneName OR inMod.VerifyPhoneNameAddress;
			
		vmod := PROJECT(inMod, $.IParam.PhoneVerificationParams, OPT);
		verifiedRecs := PhoneFinder_Services.GetVerifiedRecs(vmod).verifyBatch(dIdentitiesInfo, dIn);
		
  PhoneFinder_Services.Layouts.PhoneFinder.PhoneIesp tPhoneInfo2(recordof(dIn) le, PhoneFinder_Services.Layouts.PhoneFinder.PhoneIesp ri) := TRANSFORM
   SELF.acctno := le.acctno;
   SELF.Number := le.phone;            
   SELF.VerificationStatus.PhoneVerificationDescription := MAP(le.phone = '' => PhoneFinder_Services.Constants.VerifyMessage.PhoneNotEntered,
                                                               ri.acctno = '' => PhoneFinder_Services.Constants.VerifyMessage.PhoneCannotBeVerified, '');   
   SELF.VerificationStatus.PhoneVerified := le.phone <> '';   
   SELF := ri;
  END;

   dPhoneswVerificationStatus :=  JOIN(dIn, dPrimaryPhoneInfo,
   								        LEFT.acctno = RIGHT.acctno,
   								        tPhoneInfo2(LEFT, RIGHT),
   								        LEFT OUTER, LIMIT(0),KEEP(1));
				
 		 PhoneFinder_Services.Layouts.PhoneFinder.PhoneIesp updateVerificationStatus(PhoneFinder_Services.Layouts.PhoneFinder.PhoneIesp le, PhoneFinder_Services.Layouts.PhoneFinder.IdentityIesp ri) := TRANSFORM
   		  HasMatch := ri.acctno != '' AND le.VerificationStatus.PhoneVerificationDescription = '';
   		  SELF.VerificationStatus.PhoneVerificationDescription := MAP(le.Number = '' => PhoneFinder_Services.Constants.VerifyMessage.PhoneNotEntered,
   																inMod.VerifyPhoneNameAddress AND   HasMatch=> PhoneFinder_Services.Constants.VerifyMessage.PhoneMatchesNameAddress,
   																inMod.VerifyPhoneName AND HasMatch => PhoneFinder_Services.Constants.VerifyMessage.PhoneMatchesName,
   																PhoneFinder_Services.Constants.VerifyMessage.PhoneCannotBeVerified);
   
   		  SELF.VerificationStatus.PhoneVerified := HasMatch AND doVerification;
   		  SELF               := le;
   		END;
   		
   		verifiedPhoneInfo :=   JOIN(dPhoneswVerificationStatus, VerifiedRecs,
   								           LEFT.acctno = RIGHT.acctno,
   								           updateVerificationStatus(LEFT, RIGHT),
   								           LEFT OUTER, LIMIT(0),KEEP(1));	

  dPrimaryPhoneInfo2 := IF(doVerification, VerifiedPhoneInfo, dPrimaryPhoneInfo);												
		
		pf.PhoneFinder.TempOut tFormat2Denorm(pf.BatchInAppendAcctno pInput) :=
		TRANSFORM
			SELF := pInput;
			SELF := [];
		END;
		
		dFormat2Denorm := PROJECT(dIn,tFormat2Denorm(LEFT));
		// Denormalize identities
		pf.PhoneFinder.TempOut tDenormIdentity(pf.PhoneFinder.TempOut le,pf.PhoneFinder.IdentityIesp ri) :=
		TRANSFORM
			SELF.identity_info := le.identity_info +
														ROW({ ri.UniqueID,ri.Deceased,
																	{ri.Name.Full,ri.Name.First,ri.Name.Middle,ri.Name.Last,ri.Name.Suffix,ri.Name.Prefix},
																	{ ri.RecentAddress.StreetNumber,ri.RecentAddress.StreetPreDirection,ri.RecentAddress.StreetName,
																		ri.RecentAddress.StreetSuffix,ri.RecentAddress.StreetPostDirection,ri.RecentAddress.UnitDesignation,
																		ri.RecentAddress.UnitNumber,ri.RecentAddress.StreetAddress1,ri.RecentAddress.StreetAddress2,
																		ri.RecentAddress.City,ri.RecentAddress.State,ri.RecentAddress.Zip5,ri.RecentAddress.Zip4,
																		ri.RecentAddress.County,ri.RecentAddress.PostalCode,ri.RecentAddress.StateCityZip},
																	{ri.FirstSeenWithPrimaryPhone.Year,ri.FirstSeenWithPrimaryPhone.Month,ri.FirstSeenWithPrimaryPhone.Day},
																	{ri.LastSeenWithPrimaryPhone.Year,ri.LastSeenWithPrimaryPhone.Month,ri.LastSeenWithPrimaryPhone.Day},
																	ri.TimeWithPrimaryPhone,ri.TimeSinceLastSeenWithPrimaryPhone,ri.PrimaryAddressType,ri.RecordType,ri.phoneownershipindicator},
																iesp.phonefinder.t_PhoneIdentityInfo);
			SELF               := le;
			SELF               := [];
		END;
		
  dIdentitiesInfo xFormIdentity(PhoneFinder_Services.Layouts.PhoneFinder.IdentityIesp le) := TRANSFORM  
				
    SELF.FirstSeenWithPrimaryPhone := le.FirstSeenWithPrimaryPhone;
	   SELF.LastSeenWithPrimaryPhone := le.LastSeenWithPrimaryPhone;
	   SELF:= le;
        
		END;
    
  final_verifiedRecs := PROJECT(verifiedRecs, xFormIdentity(LEFT));  
		
  unverified_recs :=   JOIN(dIdentitiesInfo, final_verifiedRecs,
   							                  LEFT.acctno = RIGHT.acctno and
   							                  LEFT.phone  = RIGHT.phone,
   							                  TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.IdentityIesp, SELF := LEFT),
   							                  LEFT ONLY); 
                                                      
  final_vrec_identities :=  unverified_recs + final_verifiedRecs;                                                  
	 
	dIdentitiesInfo2 := IF(doVerification and exists(final_vrec_identities), final_vrec_identities, dIdentitiesInfo);
	 /* End phone verification */		
		
		dIdentityDenorm := DENORMALIZE( dFormat2Denorm,
																		dIdentitiesInfo2,
																		LEFT.acctno = RIGHT.acctno,
																		tDenormIdentity(LEFT,RIGHT));
		
		#IF(~isPhoneSearch)
			// Denormalize phones
			pf.PhoneFinder.TempOut tDenormPhones( pf.PhoneFinder.TempOut le,pf.PhoneFinder.OtherPhoneIesp ri) :=
			TRANSFORM
				SELF.other_phones := le.other_phones +
															ROW(transform (iesp.phonefinder.t_PhoneFinderInfo, Self := ri));
				SELF              := le;
				SELF              := [];
			END;
			
			dPhonesDenorm := DENORMALIZE(dIdentityDenorm,
																		dOtherPhoneInfo,
																		LEFT.acctno = RIGHT.acctno,
																		tDenormPhones(LEFT,RIGHT));
		#END
		
		// Primary phone info
		pf.PhoneFinder.TempOut tPhoneInfo(pf.PhoneFinder.TempOut le,pf.PhoneFinder.PhoneIesp ri) :=
		TRANSFORM

			SELF.identity_info := SORT(le.identity_info, IF(PhoneOwnershipIndicator,0,1), -iesp.ECL2ESP.DateToInteger(LastSeenWithPrimaryPhone));
			SELF.phone_info    := ri;
			SELF               := le;
		END;
		
		#IF(isPhoneSearch)
			dDenormAll := dIdentityDenorm;
		#ELSE
			dDenormAll := dPhonesDenorm;
		#END
		
		dPhoneIdentity := JOIN( dDenormAll,
														dPrimaryPhoneInfo2,
														LEFT.acctno = RIGHT.acctno,
														tPhoneInfo(LEFT,RIGHT),
														LEFT OUTER,
														LIMIT(0),KEEP(1)); //Only one record per acctno exists on the left and right
		// Primary identity
		#IF(isPhoneSearch)
			dFormat2BatchReady := dPhoneIdentity;
		#ELSE			
			Suppress.MAC_Suppress(dinBestInfo, dBestInfoSuppress,
													inMod.ApplicationType,Suppress.Constants.LinkTypes.DID,did,'','',FALSE,'',TRUE);			
			pf.PhoneFinder.Tempout tPrimaryIdentityIesp(dBestInfoSuppress le,dIdentitiesInfo ri) :=
			TRANSFORM
				vFullName      := Address.NameFromComponents(le.name_first,le.name_middle,le.name_last,le.name_suffix);
				vStreetAddress := Address.Addr1FromComponents(le.prim_range,le.predir,le.prim_name,le.addr_suffix,
																											le.postdir,le.unit_desig,le.sec_range);
				vCityStZip     := Address.Addr2FromComponentsWithZip4(le.p_city_name,le.st,le.z5,le.zip4);
				
				SELF.acctno                                             := le.acctno;
				SELF.primary_identity.UniqueID                          := INTFORMAT(le.did,12,1);
				SELF.primary_identity.Name                              := iesp.ECL2ESP.SetName(le.name_first,le.name_middle,le.name_last,le.name_suffix,'',vFullName);
				SELF.primary_identity.RecentAddress                     := iesp.ECL2ESP.SetAddress( le.prim_name,le.prim_range,le.predir,le.postdir,
																																														le.addr_suffix,le.unit_desig,le.sec_range,
																																														le.p_city_name,le.st,le.z5,le.zip4,'','',
																																														vStreetAddress[1..60],vStreetAddress[61..],
																																														vCityStZip);
				SELF.primary_identity.PrimaryAddressType								:= ri.PrimaryAddressType;																																										
				SELF.primary_identity.RecordType												:= ri.RecordType;																																										
				SELF.primary_identity.Deceased                          := IF((Integer)le.dod != 0,'Y','N');
				SELF.primary_identity.FirstSeenWithPrimaryPhone         := ri.FirstSeenWithPrimaryPhone;
				SELF.primary_identity.LastSeenWithPrimaryPhone          := ri.LastSeenWithPrimaryPhone;
				SELF.primary_identity.TimeWithPrimaryPhone              := ri.TimeWithPrimaryPhone;
				SELF.primary_identity.TimeSinceLastSeenWithPrimaryPhone := ri.TimeSinceLastSeenWithPrimaryPhone;
				SELF.primary_identity.PhoneOwnershipIndicator           := ri.PhoneOwnershipIndicator;
				SELF                                                    := [];
			END;
			
			dPrimaryIdentityIesp := JOIN(dBestInfoSuppress,
																		dIdentitiesInfo2,
																		LEFT.acctno = RIGHT.acctno and
																		LEFT.did    = (UNSIGNED)RIGHT.UniqueId,
																		tPrimaryIdentityIesp(LEFT,RIGHT),
																		LEFT OUTER,
																		LIMIT(0),KEEP(1));
			
			pf.PhoneFinder.TempOut tPrimaryIdentity(dPhoneIdentity le,dPrimaryIdentityIesp ri) :=
			TRANSFORM
				SELF.primary_identity := ri.primary_identity;
				SELF                  := le;
			END;
			
			dPrimaryIdentity := JOIN(dPhoneIdentity,
									dPrimaryIdentityIesp,
									LEFT.acctno = RIGHT.acctno,
									tPrimaryIdentity(LEFT,RIGHT),
									FULL OUTER,
									LIMIT(1,SKIP));
			
			dFormat2BatchReady := dPrimaryIdentity;
		#END
		
		LOADXML('<xml/>');
		#EXPORTXML(dFileMetaInfo,pf.PhoneFinder.BatchOut)
		#DECLARE(i)
		#DECLARE(j)
		#DECLARE(p)
		#DECLARE(s)
		#DECLARE(o)
		#DECLARE(a)
		#DECLARE(IdentityInfo)
		#DECLARE(OtherPhones)
		#DECLARE(PortingHistory)
		#DECLARE(SpoofingHistory)
		#DECLARE(OTPHistory)
		#DECLARE(Alerts)
		
		#SET(i,1)
		#SET(j,1)
		#SET(p,1)
		#SET(s,1)
		#SET(o,1)
		#SET(a,1)
		#SET(IdentityInfo,'')
		#SET(OtherPhones,'')
		#SET(PortingHistory,'')
		#SET(SpoofingHistory,'')
		#SET(OTPHistory,'')
		#SET(Alerts,'')
		
		#IF(isPhoneSearch)
			#LOOP
				#IF(%i% > iesp.Constants.Phone_Finder.MaxIdentities)
					#BREAK
				#ELSE
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_DID := IF((UNSIGNED)pInput.identity_info[' + %'i'% + '].UniqueID != 0,INTFORMAT((UNSIGNED)pInput.identity_info[' + %'i'% + '].UniqueID,12,1),\'\');\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_Full := pInput.identity_info[' + %'i'% + '].Name.Full;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_First := pInput.identity_info[' + %'i'% + '].Name.First;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_Middle := pInput.identity_info[' + %'i'% + '].Name.Middle;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_Last := pInput.identity_info[' + %'i'% + '].Name.Last;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_Suffix := pInput.identity_info[' + %'i'% + '].Name.Suffix;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_Deceased := pInput.identity_info[' + %'i'% + '].Deceased;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_StreetNumber := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetNumber;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_StreetPreDirection := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetPreDirection;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_StreetName := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetName;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_StreetSuffix := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetSuffix;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_StreetPostDirection := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetPostDirection;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_UnitDesignation := pInput.identity_info[' + %'i'% + '].RecentAddress.UnitDesignation;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_UnitNumber := pInput.identity_info[' + %'i'% + '].RecentAddress.UnitNumber;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_City := pInput.identity_info[' + %'i'% + '].RecentAddress.City;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_State := pInput.identity_info[' + %'i'% + '].RecentAddress.State;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_Zip5 := pInput.identity_info[' + %'i'% + '].RecentAddress.Zip5;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_Zip4 := pInput.identity_info[' + %'i'% + '].RecentAddress.Zip4;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_County := pInput.identity_info[' + %'i'% + '].RecentAddress.County;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_PrimaryAddressType := pInput.identity_info[' + %'i'% + '].PrimaryAddressType;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_RecordType := pInput.identity_info[' + %'i'% + '].RecordType;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_FirstSeenWithPrimaryPhone := iesp.ECL2ESP.t_DateToString8(pInput.identity_info[' + %'i'% + '].FirstSeenWithPrimaryPhone);\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_LastSeenWithPrimaryPhone := iesp.ECL2ESP.t_DateToString8(pInput.identity_info[' + %'i'% + '].LastSeenWithPrimaryPhone);\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_TimeWithPrimaryPhone := pInput.identity_info[' + %'i'% + '].TimeWithPrimaryPhone;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_TimeSinceLastSeenWithPrimaryPhone := pInput.identity_info[' + %'i'% + '].TimeSinceLastSeenWithPrimaryPhone;\n')
					#APPEND(IdentityInfo,'SELF.Identity' + %'i'% + '_PhoneOwnershipIndicator := pInput.identity_info[' + %'i'% + '].PhoneOwnershipIndicator;\n')
					
					#SET(i,%i% + 1)
				#END
			#END
			
		#ELSE
			#LOOP
				#IF(%i% > iesp.Constants.Phone_Finder.MaxPhoneHistory)
					#BREAK
				#ELSE
					// Loop for populating the phone history section
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_Full := pInput.identity_info[' + %'i'% + '].Name.Full;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_First := pInput.identity_info[' + %'i'% + '].Name.First;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_Middle := pInput.identity_info[' + %'i'% + '].Name.Middle;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_Last := pInput.identity_info[' + %'i'% + '].Name.Last;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_Suffix := pInput.identity_info[' + %'i'% + '].Name.Suffix;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_StreetNumber := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetNumber;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_StreetPreDirection := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetPreDirection;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_StreetName := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetName;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_StreetSuffix := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetSuffix;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_StreetPostDirection := pInput.identity_info[' + %'i'% + '].RecentAddress.StreetPostDirection;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_UnitDesignation := pInput.identity_info[' + %'i'% + '].RecentAddress.UnitDesignation;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_UnitNumber := pInput.identity_info[' + %'i'% + '].RecentAddress.UnitNumber;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_City := pInput.identity_info[' + %'i'% + '].RecentAddress.City;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_State := pInput.identity_info[' + %'i'% + '].RecentAddress.State;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_Zip5 := pInput.identity_info[' + %'i'% + '].RecentAddress.Zip5;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_Zip4 := pInput.identity_info[' + %'i'% + '].RecentAddress.Zip4;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_County := pInput.identity_info[' + %'i'% + '].RecentAddress.County;\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_FirstSeen := iesp.ECL2ESP.t_DateToString8(pInput.identity_info[' + %'i'% + '].FirstSeenWithPrimaryPhone);\n')
					#APPEND(IdentityInfo,'SELF.PhoneHist' + %'i'% + '_LastSeen := iesp.ECL2ESP.t_DateToString8(pInput.identity_info[' + %'i'% + '].LastSeenWithPrimaryPhone);\n')
					
					#SET(i,%i% + 1)
				#END
			#END				
			
			// Loop for populating other phones section
			#LOOP
				#IF(%j% > iesp.Constants.Phone_Finder.MaxOtherPhones)
					#BREAK
				#ELSE
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_PhoneNumber := pInput.other_phones[' + %'j'% + '].Number;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_PhoneType := pInput.other_phones[' + %'j'% + ']._Type;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_Carrier := pInput.other_phones[' + %'j'% + '].Carrier;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_CarrierCity := pInput.other_phones[' + %'j'% + '].CarrierCity;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_CarrierState := pInput.other_phones[' + %'j'% + '].CarrierState;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_PhoneStatus := pInput.other_phones[' + %'j'% + '].PhoneStatus;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_PortCode := pInput.other_phones[' + %'j'% + '].PortingCode;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_PhoneRiskIndicator := pInput.other_phones[' + %'j'% + '].PhoneRiskIndicator;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_OTPRIFailed := pInput.other_phones[' + %'j'% + '].OTPRIFailed;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_LastPortedDate := iesp.ECL2ESP.t_DateToString8(pInput.other_phones[' + %'j'% + '].LastPortedDate);\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_ListingName := pInput.other_phones[' + %'j'% + '].ListingName;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_StreetNumber := pInput.other_phones[' + %'j'% + '].Address.StreetNumber;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_StreetPreDirection := pInput.other_phones[' + %'j'% + '].Address.StreetPreDirection;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_StreetName := pInput.other_phones[' + %'j'% + '].Address.StreetName;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_StreetSuffix := pInput.other_phones[' + %'j'% + '].Address.StreetSuffix;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_StreetPostDirection := pInput.other_phones[' + %'j'% + '].Address.StreetPostDirection;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_UnitDesignation := pInput.other_phones[' + %'j'% + '].Address.UnitDesignation;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_UnitNumber := pInput.other_phones[' + %'j'% + '].Address.UnitNumber;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_City := pInput.other_phones[' + %'j'% + '].Address.City;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_State := pInput.other_phones[' + %'j'% + '].Address.State;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_Zip5 := pInput.other_phones[' + %'j'% + '].Address.Zip5;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_Zip4 := pInput.other_phones[' + %'j'% + '].Address.Zip4;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_County := pInput.other_phones[' + %'j'% + '].Address.County;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_DateFirstSeen := iesp.ECL2ESP.t_DateToString8(pInput.other_phones[' + %'j'% + '].DateFirstSeen);\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_DateLastSeen := iesp.ECL2ESP.t_DateToString8(pInput.other_phones[' + %'j'% + '].DateLastSeen);\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_MonthsWithPhone := pInput.other_phones[' + %'j'% + '].MonthsWithPhone;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_MonthsSinceLastSeen := pInput.other_phones[' + %'j'% + '].MonthsSinceLastSeen;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_PhoneOwnershipIndicator := pInput.other_phones[' + %'j'% + '].PhoneOwnershipIndicator;\n')
					#APPEND(OtherPhones,'SELF.OtherPhone' + %'j'% + '_CallForwardingIndicator := pInput.other_phones[' + %'j'% + '].CallForwardingIndicator;\n')
					#SET(j,%j% + 1)
				#END
			#END		
			
		#END

		#LOOP
			#IF(%p% > iesp.Constants.Phone_Finder.MaxPorts)
				#BREAK
			#ELSE
				// Loop for populating the porting history section
				#APPEND(PortingHistory,'SELF.PortingHistory' + %'p'% + '_ServiceProvider := pInput.phone_info.PortingHistory[' + %'p'% + '].ServiceProvider;\n')
				#APPEND(PortingHistory,'SELF.PortingHistory' + %'p'% + '_PortStartDate := iesp.ECL2ESP.t_DateToString8(pInput.phone_info.PortingHistory[' + %'p'% + '].PortStartDate);\n')
				#APPEND(PortingHistory,'SELF.PortingHistory' + %'p'% + '_PortEndDate := iesp.ECL2ESP.t_DateToString8(pInput.phone_info.PortingHistory[' + %'p'% + '].PortEndDate);\n')
				
				#SET(p,%p% + 1)
			#END
		#END	
	
		#LOOP
			#IF(%s% > iesp.Constants.Phone_Finder.MaxSpoofs)
				#BREAK
			#ELSE
				// Loop for populating the Spoofing history section
				#APPEND(SpoofingHistory,'SELF.SpoofingHistory' + %'s'% + '_PhoneOrigin := pInput.phone_info.SpoofingData.SpoofingHistory[' + %'s'% + '].PhoneOrigin;\n')
				#APPEND(SpoofingHistory,'SELF.SpoofingHistory' + %'s'% + '_EventDate := iesp.ECL2ESP.t_DateToString8(pInput.phone_info.SpoofingData.SpoofingHistory[' + %'s'% + '].EventDate);\n')
				
				#SET(s,%s% + 1)
			#END
		#END		

		#LOOP
			#IF(%o% > PhoneFinder_Services.Constants.MaxOTPBatch)
				#BREAK
			#ELSE
				// Loop for populating the OTP history section
				#APPEND(OTPHistory,'SELF.OTPHistory' + %'o'% + '_OTPStatus := pInput.phone_info.OneTimePassword.OTPHistory[' + %'o'% + '].OTPStatus;\n')
				#APPEND(OTPHistory,'SELF.OTPHistory' + %'o'% + '_EventDate := iesp.ECL2ESP.t_DateToString8(pInput.phone_info.OneTimePassword.OTPHistory[' + %'o'% + '].EventDate);\n')
				
				#SET(o,%o% + 1)
			#END
		#END	
		
		#LOOP
			#IF(%a% > PhoneFinder_Services.Constants.MaxAlertCategories)
				#BREAK
			#ELSE
				// Loop for populating the Spoofing history section
				#APPEND(Alerts,'SELF.Alerts' + %'a'% + '_Flag := pInput.phone_info.Alerts[' + %'a'% + '].Flag;\n')
				#APPEND(Alerts,'SELF.Alerts' + %'a'% + '_Messages := pInput.phone_info.Alerts[' + %'a'% + '].Messages[1].value + \n'+
																														'pInput.phone_info.Alerts[' + %'a'% + '].Messages[2].value + \n'+
																														'pInput.phone_info.Alerts[' + %'a'% + '].Messages[3].value + \n'+
																														'pInput.phone_info.Alerts[' + %'a'% + '].Messages[4].value + \n'+
																														'pInput.phone_info.Alerts[' + %'a'% + '].Messages[5].value;\n')				
				#SET(a,%a% + 1)
			#END
		#END	

		// Convert to batch out layout
		pf.PhoneFinder.BatchOut tFormat2Batch(dFormat2BatchReady pInput) :=
		TRANSFORM
			phoneInfo := pInput.phone_info;
			porting		:= phoneInfo.PortingHistory;
			spoofing	:= phoneInfo.SpoofingData;
			ocInfo    := phoneInfo.OperatingCompany;
			
			%IdentityInfo%
			#IF(~isPhoneSearch)
				SELF.Identity1_DID                               := pInput.primary_identity.UniqueID;
				SELF.Identity1_Full                              := pInput.primary_identity.Name.Full;
				SELF.Identity1_First                             := pInput.primary_identity.Name.First;
				SELF.Identity1_Middle                            := pInput.primary_identity.Name.Middle;
				SELF.Identity1_Last                              := pInput.primary_identity.Name.Last;
				SELF.Identity1_Suffix                            := pInput.primary_identity.Name.Suffix;
				SELF.Identity1_Deceased                          := pInput.primary_identity.Deceased;
				SELF.Identity1_StreetNumber                      := pInput.primary_identity.RecentAddress.StreetNumber;
				SELF.Identity1_StreetPreDirection                := pInput.primary_identity.RecentAddress.StreetPreDirection;
				SELF.Identity1_StreetName                        := pInput.primary_identity.RecentAddress.StreetName;
				SELF.Identity1_StreetSuffix                      := pInput.primary_identity.RecentAddress.StreetSuffix;
				SELF.Identity1_StreetPostDirection               := pInput.primary_identity.RecentAddress.StreetPostDirection;
				SELF.Identity1_UnitDesignation                   := pInput.primary_identity.RecentAddress.UnitDesignation;
				SELF.Identity1_UnitNumber                        := pInput.primary_identity.RecentAddress.UnitNumber;
				SELF.Identity1_City                              := pInput.primary_identity.RecentAddress.City;
				SELF.Identity1_State                             := pInput.primary_identity.RecentAddress.State;
				SELF.Identity1_Zip5                              := pInput.primary_identity.RecentAddress.Zip5;
				SELF.Identity1_Zip4                              := pInput.primary_identity.RecentAddress.Zip4;
				SELF.Identity1_County                            := pInput.primary_identity.RecentAddress.County;
				SELF.Identity1_PrimaryAddressType                := pInput.primary_identity.PrimaryAddressType;
				SELF.Identity1_RecordType	                       := pInput.primary_identity.RecordType;
				SELF.Identity1_FirstSeenWithPrimaryPhone         := iesp.ECL2ESP.t_DateToString8(pInput.primary_identity.FirstSeenWithPrimaryPhone);
				SELF.Identity1_LastSeenWithPrimaryPhone          := iesp.ECL2ESP.t_DateToString8(pInput.primary_identity.LastSeenWithPrimaryPhone);
				SELF.Identity1_TimeWithPrimaryPhone              := pInput.primary_identity.TimeWithPrimaryPhone;
				SELF.Identity1_TimeSinceLastSeenWithPrimaryPhone := pInput.primary_identity.TimeSinceLastSeenWithPrimaryPhone;
				SELF.Identity1_PhoneOwnershipIndicator           := pInput.primary_identity.PhoneOwnershipIndicator;
				%OtherPhones%
			#END
			%PortingHistory%
			%SpoofingHistory%
			%OTPHistory%
			%Alerts%
			SELF.ContactName_Full                   := ocInfo.ContactName.Full;
			SELF.ContactName_First                  := ocInfo.ContactName.First;
			SELF.ContactName_Middle                 := ocInfo.ContactName.Middle;
			SELF.ContactName_Last                   := ocInfo.ContactName.Last;
			SELF.ContactName_Suffix                 := ocInfo.ContactName.Suffix;
			SELF.ContactName_Prefix                 := ocInfo.ContactName.Prefix;
			SELF.ContactAddress_StreetNumber        := ocInfo.ContactAddress.StreetNumber;
			SELF.ContactAddress_StreetPreDirection  := ocInfo.ContactAddress.StreetPreDirection;
			SELF.ContactAddress_StreetName          := ocInfo.ContactAddress.StreetName;
			SELF.ContactAddress_StreetSuffix        := ocInfo.ContactAddress.StreetSuffix;
			SELF.ContactAddress_StreetPostDirection := ocInfo.ContactAddress.StreetPostDirection;
			SELF.ContactAddress_UnitDesignation     := ocInfo.ContactAddress.UnitDesignation;
			SELF.ContactAddress_UnitNumber          := ocInfo.ContactAddress.UnitNumber;
			SELF.ContactAddress_StreetAddress1      := ocInfo.ContactAddress.StreetAddress1;
			SELF.ContactAddress_StreetAddress2      := ocInfo.ContactAddress.StreetAddress2;
			SELF.ContactAddress_City                := ocInfo.ContactAddress.City;
			SELF.ContactAddress_State               := ocInfo.ContactAddress.State;
			SELF.ContactAddress_Zip5                := ocInfo.ContactAddress.Zip5;
			SELF.ContactAddress_Zip4                := ocInfo.ContactAddress.Zip4;
			SELF.ContactAddress_County              := ocInfo.ContactAddress.County;
			SELF.ContactAddress_PostalCode          := ocInfo.ContactAddress.PostalCode;
			SELF.ContactAddress_StateCityZip        := ocInfo.ContactAddress.StateCityZip;
			SELF.FirstPortedDate                    := iesp.ECL2ESP.DateToInteger(phoneInfo.FirstPortedDate);
			SELF.LastPortedDate                     := iesp.ECL2ESP.DateToInteger(phoneInfo.LastPortedDate);
			SELF.ActivationDate                     := iesp.ECL2ESP.DateToInteger(phoneInfo.ActivationDate);
			SELF.DisconnectDate                     := iesp.ECL2ESP.DateToInteger(phoneInfo.DisconnectDate);
			SELF.Spoof_Spoofed                      := spoofing.Spoof.Spoofed;
			SELF.Spoof_SpoofedCount                 := spoofing.Spoof.SpoofedCount;
			SELF.Spoof_FirstSpoofedDate             := iesp.ECL2ESP.DateToInteger(spoofing.Spoof.FirstSpoofedDate);
			SELF.Spoof_LastSpoofedDate              := iesp.ECL2ESP.DateToInteger(spoofing.Spoof.LastSpoofedDate);
			SELF.Destination_Spoofed                := spoofing.Destination.Spoofed;
			SELF.Destination_SpoofedCount           := spoofing.Destination.SpoofedCount;
			SELF.Destination_FirstSpoofedDate       := iesp.ECL2ESP.DateToInteger(spoofing.Destination.FirstSpoofedDate);
			SELF.Destination_LastSpoofedDate        := iesp.ECL2ESP.DateToInteger(spoofing.Destination.LastSpoofedDate);		
			SELF.Source_Spoofed                	    := spoofing.Source.Spoofed;
			SELF.Source_SpoofedCount           	    := spoofing.Source.SpoofedCount;
			SELF.Source_FirstSpoofedDate       	    := iesp.ECL2ESP.DateToInteger(spoofing.Source.FirstSpoofedDate);
			SELF.Source_LastSpoofedDate        	    := iesp.ECL2ESP.DateToInteger(spoofing.Source.LastSpoofedDate);				
			SELF.FirstEventSpoofedDate              := iesp.ECL2ESP.DateToInteger(spoofing.FirstEventSpoofedDate);				
			SELF.LastEventSpoofedDate               := iesp.ECL2ESP.DateToInteger(spoofing.LastEventSpoofedDate);				
			SELF.TotalSpoofedCount                  := spoofing.TotalSpoofedCount;
			SELF.OTPMatch                           := phoneInfo.OneTimePassword.OTP;
			SELF.OTPCount                           := phoneInfo.OneTimePassword.OTPCount;
			SELF.LastOTPStatus                      := phoneInfo.OneTimePassword.LastOTPStatus;
			SELF.FirstOTPDate                       := iesp.ECL2ESP.DateToInteger(phoneInfo.OneTimePassword.FirstOTPDate);					
			SELF.LastOTPDate                        := iesp.ECL2ESP.DateToInteger(phoneInfo.OneTimePassword.LastOTPDate);					
			SELF.PhoneRiskIndicator                 := phoneInfo.PhoneRiskIndicator;					
			SELF.OTPRIFailed                        := phoneInfo.OTPRIFailed;	
			SELF.CallForwardingIndicator            := phoneInfo.CallForwardingIndicator;				
			SELF.PhoneVerificationDescription       := phoneInfo.VerificationStatus.PhoneVerificationDescription;
			SELF.PhoneVerified                      := phoneInfo.VerificationStatus.PhoneVerified;				
			SELF                                    := phoneInfo.GeoLocation;
			SELF                                    := ocInfo.Address;
			SELF                                    := ocInfo;
			SELF                                    := phoneInfo;
			SELF                                    := spoofing;
			SELF                                    := pInput;
			SELF                                    := [];
		END;
		
		dFormat2BatchOut := PROJECT(dFormat2BatchReady,tFormat2Batch(LEFT));
// OUTPUT(dFormat2BatchReady);		
		//Debug
		#IF(PhoneFinder_Services.Constants.Debug.Main)
			#IF(isPhoneSearch)
				OUTPUT(dIdentitiesInfo,NAMED('dIdentitiesInfo_PhoneSearch'));
				OUTPUT(dPrimaryPhoneInfo,NAMED('dPrimaryPhoneInfo_PhoneSearch'));
				OUTPUT(dIdentityDenorm,NAMED('dIdentityDenorm_PhoneSearch'));
				OUTPUT(dDenormAll,NAMED('dDenormAll_PhoneSearch'));
				OUTPUT(dPhoneIdentity,NAMED('dPhoneIdentity_PhoneSearch'));
				OUTPUT(dFormat2BatchReady,NAMED('dFormat2BatchReady_PhoneSearch'));
				OUTPUT(verifiedRecs,NAMED('verifiedRecs_PhoneSearch'));
				OUTPUT(verified_PrimaryPhoneInfo,NAMED('verified_PrimaryPhoneInfo'));
 			#ELSE				
   				OUTPUT(dIdentitiesInfo,NAMED('dIdentitiesInfo'));
   				OUTPUT(dPrimaryPhoneInfo,NAMED('dPrimaryPhoneInfo'));
   				OUTPUT(dIdentityDenorm,NAMED('dIdentityDenorm'));
   				OUTPUT(dOtherPhoneInfo,NAMED('dOtherPhoneInfo'));
   				OUTPUT(dPhonesDenorm,NAMED('dPhonesDenorm'));
   				OUTPUT(dDenormAll,NAMED('dDenormAll'));
   				OUTPUT(dPhoneIdentity,NAMED('dPhoneIdentity'));
   				OUTPUT(dPrimaryIdentityIesp,NAMED('dPrimaryIdentityIesp'));
   				OUTPUT(dPrimaryIdentity,NAMED('dPrimaryIdentity'));
   				OUTPUT(dFormat2BatchReady,NAMED('dFormat2BatchReady'));
   				OUTPUT(dFormat2BatchOut,NAMED('dFormat2BatchOut'));

			#END
		#END

		RETURN dFormat2BatchOut;
	ENDMACRO;
END;
