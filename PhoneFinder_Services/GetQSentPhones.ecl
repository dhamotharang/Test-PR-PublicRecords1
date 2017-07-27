IMPORT Address,AutoStandardI,BatchServices,Doxie_Raw,Gateway,iesp,Phones,Risk_Indicators,std,PhoneFinder_Services;

globalMod := AutoStandardI.GlobalModule();

lBatchIn       := PhoneFinder_Services.Layouts.BatchInAppendDID;
lFinal         := PhoneFinder_Services.Layouts.PhoneFinder.Final;
lExcludePhones := PhoneFinder_Services.Layouts.PhoneFinder.ExcludePhones;
lPPResponse    := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;

EXPORT GetQSentPhones :=
MODULE

	// QSent gateway data - PVS or PVSD
	EXPORT GetQSentPVSData( dIn,
													inMod,
													fldPhone,
													fldAcctNo,
													getPhoneDetails = FALSE,
													pGateway) :=
	FUNCTIONMACRO
		IMPORT AutoStandardI,BatchServices,Doxie_Raw,Gateway,iesp,Phones,Risk_Indicators,std,ut;
		
		globalMod := AutoStandardI.GlobalModule();
		
		timeoutSecs  := 5; // gateway timeout
		
		l_BtchIn     := PhoneFinder_Services.Layouts.BatchInAppendDID;
		l_Final      := PhoneFinder_Services.Layouts.PhoneFinder.Final;
		l_PPResponse := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;
		today 	 		 := (string) STD.Date.Today();
		// Keep only one record per acctno
		dInDedup := DEDUP(SORT(dIn,acctno),acctno);
	
		// Temporary layout
		#IF(getPhoneDetails)
			rQSent_Layout :=
			RECORD(l_Final)
				DATASET(l_PPResponse) qsent_recs;
			END;
		#ELSE
			rQSent_Layout :=
			RECORD
				DATASET(l_PPResponse) qsent_recs;
				l_BtchIn              batch_in;
			END;
		#END
		
		// Input phone number is populated
		rQSent_Layout tGetPVSData(dInDedup pInput) :=
		TRANSFORM
			tmpMod := MODULE(PROJECT(globalMod,BatchServices.RealTimePhones_Params.params,OPT))
												EXPORT STRING15  Phone                  := pInput.fldPhone;
												EXPORT STRING30  FirstName              := '';
												EXPORT STRING30  LastName               := '';
												EXPORT STRING200 Addr                   := '';
												EXPORT STRING25  City                   := '';
												EXPORT STRING2   State                  := '';
												EXPORT STRING6   Zip                    := '';
												EXPORT STRING11  SSN                    := '';
												EXPORT BOOLEAN   FailOnError            := FALSE;
												EXPORT STRING5   ServiceType            := IF(getPhoneDetails,
																																			Phones.Constants.ServiceType.PVSD,
																																			Phones.Constants.ServiceType.PVS);
												EXPORT UNSIGNED1 RecordCount            := PhoneFinder_Services.Constants.MaxTUGatewayResults;
												EXPORT STRING20  AcctNo                 := pInput.fldAcctNo;
												EXPORT STRING	   EspTransactionId       := pGateway.TransactionId;
												EXPORT BOOLEAN   TUGatewayPhoneticMatch := inMod.PhoneticMatch;
												EXPORT BOOLEAN   UseQSENTV2             := TRUE;
								END;
			SELF.qsent_recs := Doxie_Raw.RealTimePhones_Raw(DATASET(pGateway),timeoutSecs,,tmpMod,inMod.UseQSent,TRUE);
			#IF(getPhoneDetails)
				SELF := pInput;
			#ELSE
				SELF.batch_in := pInput;
			#END
		END;
		dPVSRecs := PROJECT(dInDedup,tGetPVSData(LEFT));
		
		// Normalize the qsent gateway records to flatten the child dataset
		l_Final tNormPVSRecs(rQSent_Layout le,l_PPResponse ri) :=
		TRANSFORM
			#IF(getPhoneDetails)
				SELF.acctno         := le.acctno;
				SELF.isPrimaryPhone := le.isPrimaryPhone;
			#ELSE
				SELF.acctno         := le.batch_in.acctno;
			#END
			SELF.phone_source     := PhoneFinder_Services.Constants.PhoneSource.QSentGateway;
			SELF.dt_first_seen    := iesp.ECL2ESP.t_DateToString8(ri.RealTimePhone_Ext.ListingCreationDate);
			SELF.dt_last_seen     := today;
			SELF.did              := (UNSIGNED)ri.did;
			SELF.telcordia_only   := ri.telcordia_only = 'Y';
			fn_len := length(trim(ri.fname));
      fn_parsed := if(fn_len > 3 and ri.fname[fn_len-1] = ' ', ri.fname[1..fn_len-2], ri.fname);
   		SELF.fname            := fn_parsed;
			SELF                  := ri;
			SELF                  := le;
			SELF                  := [];
		END;
		
		dNormPVSRecs := NORMALIZE(dPVSRecs,LEFT.qsent_recs,tNormPVSRecs(LEFT,RIGHT));
		
 		// Debug
   	#IF(PhoneFinder_Services.Constants.Debug.QSent)
			#IF(getPhoneDetails)
				OUTPUT(dIn,NAMED('dPVSD_In'),OVERWRITE);
				OUTPUT(dPVSRecs,NAMED('dPVSDRecs'),OVERWRITE);
				OUTPUT(dNormPVSRecs,NAMED('dNormPVSDRecs'),OVERWRITE);
			#ELSE
				OUTPUT(dIn,NAMED('dPVS_In'),OVERWRITE);
				OUTPUT(dPVSRecs,NAMED('dPVSRecs'),OVERWRITE);
				OUTPUT(dNormPVSRecs,NAMED('dNormPVSRecs'),OVERWRITE);
			#END
		#END
		
		RETURN dNormPVSRecs;
	ENDMACRO;
	
	// QSent gateway data - iQ411
	EXPORT GetQSentiQ411Data( DATASET(lBatchIn)                        dIn,
														DATASET(lExcludePhones)                  dExcludePhones,
														PhoneFinder_Services.iParam.ReportParams inMod,
														Gateway.Layouts.Config                   pGateway) :=
	FUNCTION
	
		timeoutSecs  := 5; // gateway timeout
		
		// Temporary layout
		rQSent_Layout :=
		RECORD
			DATASET(lPPResponse) qsent_recs;
			lBatchIn             batch_in;
		END;
		today 	 := (string) STD.Date.Today();
		// Rule 1 - SSN and last name
		rQSent_Layout tGetIQ411Rule1Data(dIn pInput) :=
		TRANSFORM
			dPhones := PROJECT( dExcludePhones(acctno = pInput.acctno),
													TRANSFORM(iesp.share.t_StringArrayItem,SELF.Value := LEFT.phone));
			
			tmpMod := MODULE(PROJECT(globalMod,BatchServices.RealTimePhones_Params.params,OPT))
												EXPORT STRING15                              Phone                  := '';
												EXPORT STRING30                              FirstName              := '';
												EXPORT STRING30                              LastName               := pInput.name_last;
												EXPORT STRING200                             Addr                   := '';
												EXPORT STRING25                              City                   := '';
												EXPORT STRING2                               State                  := '';
												EXPORT STRING6                               Zip                    := '';
												EXPORT STRING11                              SSN                    := IF(pInput.ssn != '',INTFORMAT((INTEGER)pInput.ssn,9,1),'');
												EXPORT BOOLEAN                               FailOnError            := FALSE;
												EXPORT STRING5                               ServiceType            := Phones.Constants.ServiceType.IQ411;
												EXPORT UNSIGNED1                             RecordCount            := PhoneFinder_Services.Constants.MaxTUGatewayResults;
												EXPORT STRING20                              AcctNo                 := pInput.acctno;
												EXPORT STRING	                               EspTransactionId       := pGateway.TransactionId;
												EXPORT BOOLEAN                               TUGatewayPhoneticMatch := inMod.PhoneticMatch;
												EXPORT BOOLEAN                               UseQSentV2             := TRUE;
												EXPORT DATASET(iesp.share.t_StringArrayItem) ExcludedPhones         := dPhones;
								END;
			SELF.qsent_recs := Doxie_Raw.RealTimePhones_Raw(DATASET(pGateway),timeoutSecs,,tmpMod,inMod.UseQSent,TRUE);
			SELF.batch_in   := pInput;
		END;
		
		dIQ411Rule1Recs := PROJECT(dIn,tGetIQ411Rule1Data(LEFT));
		
		// Rule 2 - Last name and SSN Last 4
		rQSent_Layout tGetIQ411Rule2Data(dIQ411Rule1Recs pInput) :=
		TRANSFORM
			dPhones := PROJECT( dExcludePhones(acctno = pInput.batch_in.acctno),
													TRANSFORM(iesp.share.t_StringArrayItem,SELF.Value := LEFT.phone));
			
			tmpMod := MODULE(PROJECT(globalMod,BatchServices.RealTimePhones_Params.params,OPT))
												EXPORT STRING15                              Phone                  := '';
												EXPORT STRING30                              FirstName              := '';
												EXPORT STRING30                              LastName               := pInput.batch_in.name_last;
												EXPORT STRING200                             Addr                   := '';
												EXPORT STRING25                              City                   := '';
												EXPORT STRING2                               State                  := '';
												EXPORT STRING6                               Zip                    := '';
												EXPORT STRING11                              SSN                    := IF(pInput.batch_in.ssn != '',INTFORMAT((INTEGER)pInput.batch_in.ssn[6..9],9,1),'');
												EXPORT BOOLEAN                               FailOnError            := FALSE;
												EXPORT STRING5                               ServiceType            := Phones.Constants.ServiceType.IQ411;
												EXPORT UNSIGNED1                             RecordCount            := PhoneFinder_Services.Constants.MaxTUGatewayResults;
												EXPORT STRING20                              AcctNo                 := pInput.batch_in.acctno;
												EXPORT STRING	                               EspTransactionId       := pGateway.TransactionId;
												EXPORT BOOLEAN                               TUGatewayPhoneticMatch := inMod.PhoneticMatch;
												EXPORT BOOLEAN                               UseQSentV2             := TRUE;
												EXPORT DATASET(iesp.share.t_StringArrayItem) ExcludedPhones         := dPhones;
								END;
			SELF.qsent_recs := Doxie_Raw.RealTimePhones_Raw(DATASET(pGateway),timeoutSecs,,tmpMod,inMod.UseQSent,TRUE);
			SELF				    := pInput;
		END;
		
		dIQ411Rule2Recs := IF(EXISTS(dIQ411Rule1Recs(~EXISTS(qsent_recs))),
													PROJECT(dIQ411Rule1Recs(~EXISTS(qsent_recs)),tGetIQ411Rule2Data(LEFT)));
		
		// Rule 3 - Last name amd address
		rQSent_Layout tGetIQ411Rule3Data(dIQ411Rule2Recs pInput) :=
		TRANSFORM
			dPhones := PROJECT( dExcludePhones(acctno = pInput.batch_in.acctno),
													TRANSFORM(iesp.share.t_StringArrayItem,SELF.Value := LEFT.phone));
			
			tmpMod := MODULE(PROJECT(globalMod,BatchServices.RealTimePhones_Params.params,OPT))
												EXPORT STRING15                              Phone                  := '';
												EXPORT STRING30                              FirstName              := '';
												EXPORT STRING30                              LastName               := pInput.batch_in.name_last;
												EXPORT STRING200                             Addr                   := Address.Addr1FromComponents( pInput.batch_in.prim_range,
																																																														pInput.batch_in.predir,
																																																														pInput.batch_in.prim_name,
																																																														pInput.batch_in.addr_suffix,
																																																														pInput.batch_in.postdir,
																																																														pInput.batch_in.unit_desig,
																																																														pInput.batch_in.sec_range);
												EXPORT STRING25                              City                   := pInput.batch_in.p_city_name;
												EXPORT STRING2                               State                  := pInput.batch_in.st;
												EXPORT STRING6                               Zip                    := pInput.batch_in.z5;
												EXPORT STRING11                              SSN                    := '';
												EXPORT BOOLEAN                               FailOnError            := FALSE;
												EXPORT STRING5                               ServiceType            := Phones.Constants.ServiceType.IQ411;
												EXPORT UNSIGNED1                             RecordCount            := PhoneFinder_Services.Constants.MaxTUGatewayResults;
												EXPORT STRING20                              AcctNo                 := pInput.batch_in.acctno;
												EXPORT STRING	                               EspTransactionId       := pGateway.TransactionId;
												EXPORT BOOLEAN                               TUGatewayPhoneticMatch := inMod.PhoneticMatch;
												EXPORT BOOLEAN                               UseQSentV2             := TRUE;
												EXPORT DATASET(iesp.share.t_StringArrayItem) ExcludedPhones         := dPhones;
								END;
			SELF.qsent_recs := Doxie_Raw.RealTimePhones_Raw(DATASET(pGateway),timeoutSecs,,tmpMod,inMod.UseQSent,TRUE);											
			SELF				    := pInput;
		END;
		
		dIQ411Rule3Recs := IF(EXISTS(dIQ411Rule2Recs(~EXISTS(qsent_recs))),
													PROJECT(dIQ411Rule2Recs(~EXISTS(qsent_recs)),tGetIQ411Rule3Data(LEFT)));
		
		dIQ411Combined := dIQ411Rule1Recs(EXISTS(qsent_recs)) + dIQ411Rule2Recs(EXISTS(qsent_recs)) + dIQ411Rule3Recs;
		
		// NORMALIZE the qsent gateway records to flatten the child DATASET
		lFinal tNormIQ411Recs(rQSent_Layout le,lPPResponse ri,INTEGER cnt) :=
		TRANSFORM
			SELF.acctno         := le.batch_in.acctno;
			SELF.dt_first_seen  := iesp.ECL2ESP.t_DateToString8(ri.RealTimePhone_Ext.ListingCreationDate);
			SELF.dt_last_seen   := today[1..6] + '00';
			SELF.phone_source   := PhoneFinder_Services.Constants.PhoneSource.QSentGateway;
			SELF.did            := (UNSIGNED)ri.did;
			SELF.telcordia_only := ri.telcordia_only = 'Y';
			SELF.sort_order     := cnt;
			SELF.isPrimaryPhone := (cnt = 1);
 			fn_len := length(trim(ri.fname));
      fn_parsed := if(fn_len > 3 and ri.fname[fn_len-1] = ' ', ri.fname[1..fn_len-2], ri.fname);
   		SELF.fname          := fn_parsed;
			SELF                := ri;
			SELF                := le;
			SELF                := [];
		END;
		
		dNormIQ411Recs := NORMALIZE(dIQ411Combined,LEFT.qsent_recs,tNormIQ411Recs(LEFT,RIGHT,COUNTER));
		
		// Debug
		#IF(PhoneFinder_Services.Constants.Debug.QSent)
			OUTPUT(dIn,NAMED('dQSentIQ411_In'));
			OUTPUT(dIQ411Rule1Recs,NAMED('dIQ411Rule1Recs'));
			OUTPUT(dIQ411Rule2Recs,NAMED('dIQ411Rule2Recs'));
			OUTPUT(dIQ411Rule3Recs,NAMED('dIQ411Rule3Recs'));
			OUTPUT(dIQ411Combined,NAMED('dIQ411Combined'));
			OUTPUT(dNormIQ411Recs,NAMED('dNormIQ411Recs'));
		#END
		
		RETURN dNormIQ411Recs;
	END;

END;