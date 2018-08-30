IMPORT Doxie,Gateway,Phones,ut;

lBatchIn       := PhoneFinder_Services.Layouts.BatchInAppendDID;
lCommon        := PhoneFinder_Services.Layouts.PhoneFinder.Common;
lFinal         := PhoneFinder_Services.Layouts.PhoneFinder.Final;

qSentPhones   := PhoneFinder_Services.GetQSentPhones;

EXPORT GetPhones( DATASET(lBatchIn)                        dIn,
									PhoneFinder_Services.iParam.ReportParams inMod,
									DATASET(Gateway.Layouts.Config)          dGateways = DATASET([],Gateway.Layouts.Config)) :=
FUNCTION
	targusGateway := dGateways(inMod.useTargus and Gateway.Configuration.isTargus(servicename))[1];
	qSentPVSGateway  := dGateways(inMod.IncludeTransUnionPVS and Gateway.Configuration.isQSentV2(servicename))[1];
	
	// Create module with autokey paramaters to pass to the batch function
	akMod := MODULE(PROJECT(inMod,PhoneFinder_Services.iParam.AKParams,OPT))
		EXPORT SET OF STRING1 skip_set := ['B'];
		EXPORT BOOLEAN WorkHard        := TRUE;
		EXPORT BOOLEAN UseAllLookups   := FALSE;
	END;
	
	// Phonesplus data
	dPhonesPlus_ := Phones.Functions.GetPhonesPlusData(dIn,akMod,MDR.SourceTools.src_Phones_Plus,FALSE,TRUE,inMod.IsPhone7Search);
	dPhonesPlus  := PROJECT(dPhonesPlus_,
													TRANSFORM(lCommon,
																		SELF.phone_source := PhoneFinder_Services.Constants.PhoneSource.PhonesPlus,
																		SELF := LEFT));
	
	// Last resort (Wired assets) data
	dLastResort_ := IF(inMod.useLastResort,
											Phones.Functions.GetPhonesPlusData(dIn,akMod,MDR.SourceTools.src_wired_Assets_Royalty,FALSE,TRUE,inMod.IsPhone7Search));
	dLastResort  := PROJECT(dLastResort_,
													TRANSFORM(lCommon,
																		SELF.phone_source := PhoneFinder_Services.Constants.PhoneSource.LastResort,
																		SELF := LEFT));
	
	// Inhouse QSent data
	dInHouseQSent_ := IF(inMod.useInHouseQSent,
												Phones.Functions.GetPhonesPlusData(dIn,akMod,MDR.SourceTools.src_InHouse_QSent,FALSE,TRUE,inMod.IsPhone7Search));
	dInHouseQSent  := PROJECT(dInHouseQSent_,
														TRANSFORM(lCommon,
																			SELF.phone_source := PhoneFinder_Services.Constants.PhoneSource.InHouseQSent,
																			SELF := LEFT));
	
	// Gong data
	dGong := PhoneFinder_Services.GetGongPhones(dIn,inMod);
	
	// Targus gateway data
	dTargus := IF(inMod.useTargus and targusGateway.url != '',
								PhoneFinder_Services.GetTargusPhones(dIn,inMod,TRUE,targusGateway));
	
	// Combine all the phone sources
	dPhoneRecsCombined := dPhonesPlus + dLastResort + dInHouseQSent + dGong + dTargus;
	
	dPhoneRecsCombinedSort  := SORT(dPhoneRecsCombined,
																	batch_in.acctno,phone,IF(lname != '',lname,listed_name),fname,prim_range,prim_name,zip,
																	penalt,MAP(Phonesplus_v2.IsCell(append_phone_type) => 1,vendor_id = 'TG' => 2,vendor_id = 'GH' => 3,4),-ConfidenceScore,
																	-dt_last_seen,IF(activeflag = 'Y',0,1),doxie.tnt_score(tnt),dt_first_seen);
	
	lCommon tPhoneRollup(lCommon le,lCommon ri) :=
	TRANSFORM
		SELF.dt_first_seen := (STRING)ut.Min2((INTEGER)le.dt_first_seen,(INTEGER)ri.dt_first_seen);
		SELF.dt_last_seen  := IF(le.dt_last_seen != '' and le.dt_last_seen >= ri.dt_last_seen,le.dt_last_seen,ri.dt_last_seen);
		SELF               := le;
	END;
	
	dPhoneRecsCombinedDedup := ROLLUP(dPhoneRecsCombinedSort,
																		tPhoneRollup(LEFT,RIGHT),
																		batch_in.acctno,phone,IF(lname != '',lname,listed_name),fname,prim_range,prim_name,zip);

	// Append carrier info from telcordia
	dPhoneCarrierInfo := PhoneFinder_Services.Functions.GetPhoneCarrierInfo(dPhoneRecsCombinedDedup);
	
	lFinal tReformat2Common(dPhoneCarrierInfo pInput) :=
	TRANSFORM
		SELF.acctno            := pInput.batch_in.acctno;
		SELF.typeflag          := MAP(pInput.src != MDR.SourceTools.src_Gong_phone_append                                               => Phones.Constants.TypeFlag.NonDirectoryAssistance, 
																	pInput.src = MDR.SourceTools.src_Gong_phone_append and pInput.tnt = Phones.Constants.TNT.History  => Phones.Constants.TypeFlag.DirectoryAssistance_Disconnected, 
																	pInput.src = MDR.SourceTools.src_Gong_phone_append and pInput.tnt != Phones.Constants.TNT.History => Phones.Constants.TypeFlag.DirectoryAssistance,
																	'');
		SELF.dial_indicator    := MAP(pInput.dial_ind = '1' => 'Y',
																	pInput.dial_ind = '0' => 'N',
																	'');
		SELF.phone_region_city := pInput.carrier_city;
		SELF.phone_region_st   := pInput.carrier_state;
		SELF.telcordia_only    := pInput.listed_name = '' and pInput.prim_name = '';
		SELF.dod               := 0;
		SELF.deceased          := '';
		SELF.ssnmatch          := '';
		SELF.RealTimePhone_Ext := [];
		SELF                   := pInput;
		SELF                   := [];
	END;
	
	dReformat2Common := PROJECT(dPhoneCarrierInfo,tReformat2Common(LEFT));
	
	// QSent gateway data
	dQSentPVS := IF(inMod.IncludeTransUnionPVS, qSentPhones.GetQSentPVSData(dIn,inMod,homephone,acctno,,qSentPVSGateway));
	
	// No need to send to gateway again if we didn't get a hit for PVS since TU does hit the SS gateway if no hits found in their database	
	// If data source returned from QSent is 'PV' (typeFlag = 'P'), no need to hit the gateway again for phone details
	dQSentPrimaryPhoneDetails   := dQSentPVS(typeflag = Phones.Constants.TypeFlag.DataSource_PV);
	dQSentPrimaryPhoneNoDetails := dQSentPVS(typeflag = Phones.Constants.TypeFlag.DataSource_iQ411);
	
	// If data source is not 'PV', call the gateway again with the primary phone number using service type 'PVSD' to get the phone info	
	dQSentAppendPrimaryPhoneDetails := IF(EXISTS(dQSentPrimaryPhoneNoDetails),
																				qSentPhones.GetQSentPVSData(dQSentPrimaryPhoneNoDetails,
																																		inMod,batch_in.homephone,batch_in.acctno,
																																		TRUE,qSentPVSGateway));
	
	dQSentCombined := dQSentPrimaryPhoneDetails + dQSentPrimaryPhoneNoDetails + dQSentAppendPrimaryPhoneDetails;
	
	// Get QSent gateway records only for ultimate transaction type
	dQSentRecs := IF(inMod.IncludeTransUnionPVS and qSentPVSGateway.url != '',dQSentCombined);
	
	dInhousePhoneDetail	:= PhoneFinder_Services.GetPhoneDetails(PROJECT(dIn,TRANSFORM(Phones.Layouts.PhoneAttributes.BatchIn,
																																											SELF.acctno:=LEFT.acctno,SELF.phoneno:=LEFT.homephone,SELF:=[])), dGateways, inMod);
																																																																																				
	dPhoneDetailWBatchIn := JOIN(dInhousePhoneDetail, dIn,
																																					LEFT.acctno = RIGHT.acctno,
																			                TRANSFORM(lFinal,
																			                SELF.isPrimaryPhone := TRUE, SELF.batch_in := RIGHT, SELF := LEFT));
																																																																						
 //use inhouse metada (metadata index, att libd, carrier reference index)
	dPhoneDetail := IF(inMod.UseInHousePhoneMetadata, dPhoneDetailWBatchIn, dQSentRecs);

	// Combine all the sources
	dPhonesCombined := dReformat2Common + dPhoneDetail;
	
	dPhoneRecs := PROJECT(dPhonesCombined, TRANSFORM(lFinal,
																					                       SELF.phonestatus :=  PhoneFinder_Services.Functions.PhoneStatusDesc((INTEGER)LEFT.realtimephone_ext.statuscode), 
																																             SELF := LEFT));
		
	// Debug
	#IF(PhoneFinder_Services.Constants.Debug.PhoneNoSearch)
		OUTPUT(dPhonesPlus,NAMED('dPhonesPlus'),EXTEND);
		OUTPUT(dLastResort,NAMED('dLastResort'),EXTEND);
		OUTPUT(dInHouseQSent,NAMED('dInHouseQSent'),EXTEND);
		OUTPUT(dGong,NAMED('dGong'),EXTEND);
		#IF(PhoneFinder_Services.Constants.Debug.Targus)
			OUTPUT(dTargus,NAMED('dTargus'),EXTEND);
		#END
		OUTPUT(dPhoneRecsCombined,NAMED('dPhoneRecsCombined'),EXTEND);
		OUTPUT(dPhoneRecsCombinedDedup,NAMED('dPhoneRecsCombinedDedup'),EXTEND);
		OUTPUT(dPhoneCarrierInfo,NAMED('dPhoneCarrierInfo'),EXTEND);
		OUTPUT(dReformat2Common,NAMED('dReformat2Common'),EXTEND);
		#IF(PhoneFinder_Services.Constants.Debug.QSent)
			OUTPUT(dQSentPVS,NAMED('dQSentPVS'),EXTEND);
			OUTPUT(dQSentPrimaryPhoneDetails,NAMED('dQSentPrimaryPhoneDetails'),EXTEND);
			OUTPUT(dQSentPrimaryPhoneNoDetails,NAMED('dQSentPrimaryPhoneNoDetails'),EXTEND);
			OUTPUT(dQSentAppendPrimaryPhoneDetails,NAMED('dQSentAppendPrimaryPhoneDetails'),EXTEND);
			OUTPUT(dQSentCombined,NAMED('dQSentCombined'),EXTEND);
		#END
	#END
	
	RETURN dPhoneRecs;
END;