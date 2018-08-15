IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

EXPORT CommonBusiness := MODULE

	// Grabs just the linking ID's and Unique Seq Number - this is needed to use the BIP kFetch2
	EXPORT GetLinkIDs(DATASET(DueDiligence.Layouts.Busn_Internal) BusnData) := FUNCTION
		
		linkIDsOnly := PROJECT(BusnData, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
																								SELF.UniqueID		:= LEFT.seq;
																								SELF.PowID			:= LEFT.Busn_info.BIP_IDs.PowID.LinkID;
																								SELF.PowScore		:= LEFT.Busn_info.BIP_IDs.PowID.Score;
																								SELF.PowWeight	:= LEFT.Busn_info.BIP_IDs.PowID.Weight;
																								
																								SELF.ProxID			:= LEFT.Busn_info.BIP_IDs.ProxID.LinkID;
																								SELF.ProxScore	:= LEFT.Busn_info.BIP_IDs.ProxID.Score;
																								SELF.ProxWeight	:= LEFT.Busn_info.BIP_IDs.ProxID.Weight;
																								
																								SELF.SeleID			:= LEFT.Busn_info.BIP_IDs.SeleID.LinkID;
																								SELF.SeleScore	:= LEFT.Busn_info.BIP_IDs.SeleID.Score;
																								SELF.SeleWeight	:= LEFT.Busn_info.BIP_IDs.SeleID.Weight;
																								
																								SELF.OrgID			:= LEFT.Busn_info.BIP_IDs.OrgID.LinkID;
																								SELF.OrgScore		:= LEFT.Busn_info.BIP_IDs.OrgID.Score;
																								SELF.OrgWeight	:= LEFT.Busn_info.BIP_IDs.OrgID.Weight;
																								
																								SELF.UltID			:= LEFT.Busn_info.BIP_IDs.UltID.LinkID;
																								SELF.UltScore		:= LEFT.Busn_info.BIP_IDs.UltID.Score;
																								SELF.UltWeight	:= LEFT.Busn_info.BIP_IDs.UltID.Weight;
																								
																								SELF := []; )); // Don't populate DotID or EmpID
		
		RETURN linkIDsOnly;
	END;
	
	// Grabs just the linking ID's without Unique Seq Number - this is needed to use the BIP kFetch
	EXPORT GetLinkIDsForKFetch(DATASET(DueDiligence.Layouts.Busn_Internal) BusnData) := FUNCTION
		
		linkIDsOnlyForKFetch := PROJECT(GetLinkIDs(BusnData), TRANSFORM(BIPV2.IDlayouts.l_xlink_ids, SELF := LEFT;));
		
		RETURN linkIDsOnlyForKFetch;
	END;
	
	//copied/modified from 	Business_Risk_BIP.Common.AppendSeq2
	//datasetToJoinTo must be of DueDiligence.Layouts.Busn_Internal structure
	//(or at a minimum have the same structure for link ids, seq, and history date)
	EXPORT AppendSeq(rawData, datasetToJoinTo, rawIncludesUniqueID) := FUNCTIONMACRO
		
		//create the where clause based on if rawData has uniqueID or not
		LOCAL whereClause := 'LEFT.UltID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND ' +
										'LEFT.OrgID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND ' +
										'LEFT.SeleID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID' + 
										IF(rawIncludesUniqueID, ' AND LEFT.uniqueID = RIGHT.seq', DueDiligence.Constants.EMPTY);
				
		//if rawData has uniqueID field, assuming unquieness - otherwise remove duplicate rows
		//should only have duplicate rows if a given business was added to the file twice
		LOCAL uniqueRawRows := IF(rawIncludesUniqueID = FALSE, DEDUP(rawData, ALL), rawData);
		
		LOCAL joinResult := JOIN(uniqueRawRows, datasetToJoinTo, 
												#EXPAND(whereClause), 
												TRANSFORM({RECORDOF(LEFT), UNSIGNED4 seq, UNSIGNED4 historyDate},
																	SELF.seq := RIGHT.seq;
																	SELF.historyDate := RIGHT.historyDate;
																	SELF := LEFT), 
												FEW); 
												
		RETURN joinResult;										
	ENDMACRO;
	
		
	EXPORT rollSicNaicBySeqAndBIP(inquiredBusiness, inputDataset) := FUNCTIONMACRO
		//grab existing SIC and NAIC codes from the inquired business
		normSicNaics := NORMALIZE(inquiredBusiness, LEFT.SicNaicSources, TRANSFORM({UNSIGNED4 seq, UNSIGNED6 ultID, UNSIGNED6 orgID, UNSIGNED6 seleID, UNSIGNED4 DateFirstSeen,
																																														UNSIGNED4 DateLastSeen, STRING10 NAICCode, STRING10 SICCode, BOOLEAN IsPrimary, STRING3 source},
																																								SELF.seq := LEFT.seq;
																																								SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																																								SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																																								SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																																								SELF := RIGHT;
																																								SELF := LEFT;
																																								SELF := [];));		
																																								
		//Add those already retrieved with those that we just found
		allCodes := normSicNaics + inputDataset;	
		
		//sort and grab combined info and remove duplictes
		sortedTempOutput := SORT(allCodes, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), SICCode, NAICCode, DateFirstSeen);
		rollTempOutput := ROLLUP(sortedTempOutput,
															LEFT.seq = RIGHT.seq AND
															LEFT.ultID = RIGHT.ultID AND
															LEFT.orgID = RIGHT.orgID AND
															LEFT.seleID = RIGHT.seleID AND
															LEFT.SICCode = RIGHT.SICCode AND
															LEFT.NAICCode = RIGHT.NAICCode AND
															LEFT.source = RIGHT.source,
															TRANSFORM({RECORDOF(LEFT)},
																				SELF.DateFirstSeen := IF(LEFT.DateFirstSeen = 0, RIGHT.DateFirstSeen, MIN(LEFT.DateFirstSeen, RIGHT.DateFirstSeen));
																				SELF.DateLastSeen := MAX(LEFT.DateLastSeen, RIGHT.DateLastSeen);
																				SELF.IsPrimary := LEFT.IsPrimary OR RIGHT.IsPrimary;
																				SELF := LEFT;));

		sortTemp := SORT(rollTempOutput, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -isPrimary, SICCode, NAICCode);
		groupSort := GROUP(sortTemp, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
																				
																				
		DueDiligence.LayoutsInternal.SicNaicLayout getMaxSicNaics(groupSort rto, INTEGER c) := TRANSFORM, SKIP(c > DueDiligence.Constants.MAX_SIC_NAIC)
			SELF.sources := PROJECT(rto, TRANSFORM(DueDiligence.Layouts.LayoutSICNAIC,
			
																							sic := TRIM(LEFT.SICCode, ALL);
																							lengthOfSic := LENGTH(sic);
																							
																							SELF.SICIndustry := MAP(sic = DueDiligence.Constants.EMPTY => sic,
																																			sic IN DueDiligence.Constants.CIB_SIC_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL,
																																			sic IN DueDiligence.Constants.CIB_SIC_NON_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL,
																																			sic IN DueDiligence.Constants.MSB_SIC => DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS,
																																			sic IN DueDiligence.Constants.NBFI_SIC => DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS,
																																			sic IN DueDiligence.Constants.CASGAM_SIC => DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING,
																																			sic IN DueDiligence.Constants.LEGTRAV_SIC => DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL,
																																			sic IN DueDiligence.Constants.AUTO_SIC => DueDiligence.Constants.INDUSTRY_AUTOMOTIVE,
																																			DueDiligence.Constants.INDUSTRY_OTHER);
																																																																							
																							SELF.SICRiskLevel := MAP(sic = DueDiligence.Constants.EMPTY => sic,
																																				lengthOfSic = 2 AND sic IN DueDiligence.Constants.SIC_LENGTH_2_RISK_HIGH => DueDiligence.Constants.RISK_LEVEL_HIGH,
																																				lengthOfSic = 4 AND (sic IN DueDiligence.Constants.SIC_LENGTH_4_RISK_HIGH OR 
																																															sic[1..2] IN DueDiligence.Constants.SIC_FIRST_2_STAR_RISK_HIGH) => DueDiligence.Constants.RISK_LEVEL_HIGH,
																																				lengthOfSic = 6 AND (sic IN DueDiligence.Constants.SIC_LENGTH_6_RISK_HIGH OR 
																																															sic[1..2] IN DueDiligence.Constants.SIC_FIRST_2_STAR_RISK_HIGH OR
																																															sic[1..4] IN DueDiligence.Constants.SIC_FIRST_4_STAR_RISK_HIGH) => DueDiligence.Constants.RISK_LEVEL_HIGH,
																																				lengthOfSic = 8 AND (sic IN DueDiligence.Constants.SIC_LENGTH_8_RISK_HIGH OR
																																															sic[1..2] IN DueDiligence.Constants.SIC_FIRST_2_STAR_RISK_HIGH OR
																																															sic[1..4] IN DueDiligence.Constants.SIC_FIRST_4_STAR_RISK_HIGH OR
																																															sic[1..6] IN DueDiligence.Constants.SIC_FIRST_6_STAR_RISK_HIGH) => DueDiligence.Constants.RISK_LEVEL_HIGH,
																																				DueDiligence.Constants.RISK_LEVEL_LOW);
																																			
																							naic := TRIM(LEFT.NAICCode, ALL);
																							naic2 := naic[1..2];
																							
																							SELF.NAICIndustry := MAP(naic = DueDiligence.Constants.EMPTY => naic,
																																			naic IN DueDiligence.Constants.CIB_NAICS_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL,
																																			naic IN DueDiligence.Constants.CIB_NAICS_NON_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL,
																																			naic IN DueDiligence.Constants.MSB_NAICS => DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS,
																																			naic IN DueDiligence.Constants.NBFI_NAICS => DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS,
																																			naic IN DueDiligence.Constants.CASGAM_NAISC => DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING,
																																			naic IN DueDiligence.Constants.LEGTRAV_NAISC => DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL,
																																			naic IN DueDiligence.Constants.AUTO_NAISC => DueDiligence.Constants.INDUSTRY_AUTOMOTIVE,
																																			DueDiligence.Constants.INDUSTRY_OTHER);
																																			
																							SELF.NAICRiskLevel := MAP(naic = DueDiligence.Constants.EMPTY => naic,
																																				naic2 IN DueDiligence.Constants.NAICS_RISK_HIGH OR
																																				naic IN DueDiligence.Constants.NAICS_RISK_HIGH_EXCEP => DueDiligence.Constants.RISK_LEVEL_HIGH,
																																				naic2 IN DueDiligence.Constants.NAICS_RISK_MED => DueDiligence.Constants.RISK_LEVEL_MEDIUM,
																																				naic2 IN DueDiligence.Constants.NAICS_RISK_LOW => DueDiligence.Constants.RISK_LEVEL_LOW,
																																				DueDiligence.Constants.RISK_LEVEL_UNKNOWN);
																							SELF := LEFT;
																							SELF :=[];));
			SELF := rto;
			SELF := [];
		END;


		projectSources := PROJECT(groupSort, getMaxSicNaics(LEFT, COUNTER));
																																																					
		sortSources := SORT(projectSources, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
		finalRoll := ROLLUP(sortSources,
												LEFT.seq = RIGHT.seq AND
												LEFT.ultID = RIGHT.ultID AND
												LEFT.orgID = RIGHT.orgID AND
												LEFT.seleID = RIGHT.seleID,
												TRANSFORM(DueDiligence.LayoutsInternal.SicNaicLayout,
																	SELF.sources := LEFT.sources + RIGHT.sources;
																	SELF := LEFT;));
	
		RETURN finalRoll;

	ENDMACRO;
	
	//either sourceFieldName or sourceName field should be populated
	EXPORT getSicNaicCodes(InDataset, SourceFieldName, SourceName, SicNaicsField, IsSicField, PrimaryField, DateFirstSeenName, DateLastSeenName) := FUNCTIONMACRO
	
		temp := TABLE(InDataset,{seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()),
														 UNSIGNED4 DateFirstSeen := MIN(GROUP, DateFirstSeenName),
														 UNSIGNED4 DateLastSeen := MAX(GROUP, DateLastSeenName),
														 STRING10 NAICCode := IF(IsSicField, DueDiligence.Constants.EMPTY, (STRING)SicNaicsField),
														 STRING10 SICCode := IF(IsSicField, (STRING)SicNaicsField, DueDiligence.Constants.EMPTY),
														 BOOLEAN IsPrimary := PrimaryField,
														 STRING3 Source := IF(SourceName = DueDiligence.Constants.EMPTY, SourceFieldName, SourceName)},
                  #if(SourceName = DueDiligence.Constants.EMPTY)
                    seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), (STRING)SicNaicsField, SourceFieldName);
                  #else           
                    seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), (STRING)SicNaicsField);
                  #end
													 
		filterSic := temp(SICCode <> DueDiligence.Constants.EMPTY);
		filterNaic := temp(NAICCode <> DueDiligence.Constants.EMPTY);
		
		results := IF(IsSicField, filterSic, filterNaic);

		RETURN results;
	
	ENDMACRO;
	
	EXPORT GetCleanBIPShell(DATASET(DueDiligence.Layouts.CleanedData) cleanInput) := FUNCTION

		cleanedInput := PROJECT(cleanInput, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																									SELF.Seq := LEFT.inputecho.seq;
																									SELF.Clean_Input.Seq := LEFT.inputecho.seq;
																									SELF.Clean_Input.AcctNo := LEFT.inputecho.business.accountNumber;
																									
																									//get the cleaned business data
																									cleanData := LEFT.cleanedInput.business;
																									//get the cleaned business address data
																									cleanAddress := cleanData.address;
																									
																									SELF.Clean_Input.CompanyName := cleanData.companyName;
																									SELF.Clean_Input.AltCompanyName := cleanData.altCompanyName;
																									SELF.Clean_Input.FEIN := cleanData.fein;
																									SELF.Clean_Input.Phone10 := cleanData.phone;
																									
																									SELF.Clean_Input.StreetAddress1 := cleanAddress.streetAddress1;
																									SELF.Clean_Input.StreetAddress2 := cleanAddress.streetAddress2;
																									SELF.Clean_Input.Prim_Range := cleanAddress.prim_range;
																									SELF.Clean_Input.Predir := cleanAddress.predir;
																									SELF.Clean_Input.Prim_Name := cleanAddress.prim_name;
																									SELF.Clean_Input.Addr_Suffix := cleanAddress.addr_suffix;
																									SELF.Clean_Input.Postdir := cleanAddress.postdir;
																									SELF.Clean_Input.Unit_Desig := cleanAddress.unit_desig;
																									SELF.Clean_Input.Sec_Range := cleanAddress.sec_range;
																									SELF.Clean_Input.City := cleanAddress.city;  // use v_city_name 90..114 to match all other scoring products
																									SELF.Clean_Input.State := cleanAddress.state;
																									SELF.Clean_Input.Zip := cleanAddress.zip5 + cleanAddress.zip4;
																									SELF.Clean_Input.Zip5 := cleanAddress.zip5;
																									SELF.Clean_Input.Zip4 := cleanAddress.zip4;
																									SELF.Clean_Input.Lat := cleanAddress.geo_lat;
																									SELF.Clean_Input.Long := cleanAddress.geo_long;
																									SELF.Clean_Input.Addr_Type := cleanAddress.rec_type;
																									SELF.Clean_Input.Addr_Status := cleanAddress.err_stat;
																									SELF.Clean_Input.County := cleanAddress.county;
																									SELF.Clean_Input.Geo_Block := cleanAddress.geo_blk;
																									
																									//set BIP IDs if we have them
																									SELF.Clean_Input.PowID := cleanData.BIP_IDs.PowID.LinkID;
																									SELF.Clean_Input.ProxID := cleanData.BIP_IDs.ProxID.LinkID;
																									SELF.Clean_Input.SeleID := cleanData.BIP_IDs.SeleID.LinkID;
																									SELF.Clean_Input.OrgID := cleanData.BIP_IDs.OrgID.LinkID;
																									SELF.Clean_Input.UltID := cleanData.BIP_IDs.UltID.LinkID;
																								
																									SELF.Clean_Input.HistoryDate := LEFT.cleanedInput.historyDateYYYYMMDD;
																									SELF.Clean_Input := cleanData; // Fill out the remaining fields with what was passed in
																									
																									SELF := [];)); // None of the remaining attributes have been populated yet));
		
		RETURN cleanedInput;
	END;
	
	
	EXPORT GetBusInternalBIPShell(DATASET(DueDiligence.Layouts.Busn_Internal) businessInput) := FUNCTION

		busInternal := PROJECT(businessInput, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																										SELF.Seq := LEFT.seq;
																										SELF.Clean_Input.Seq := LEFT.seq;
																										SELF.Clean_Input.AcctNo := LEFT.busn_info.accountNumber;
																										
																										//get the business data
																										busInfo := LEFT.busn_info;
																										//get the business address data
																										busAddress := busInfo.address;
																										
																										SELF.Clean_Input.CompanyName := busInfo.companyName;
																										SELF.Clean_Input.AltCompanyName := busInfo.altCompanyName;
																										SELF.Clean_Input.FEIN := busInfo.fein;
																										SELF.Clean_Input.Phone10 := busInfo.phone;
																										
																										SELF.Clean_Input.StreetAddress1 := busAddress.streetAddress1;
																										SELF.Clean_Input.StreetAddress2 := busAddress.streetAddress2;
																										SELF.Clean_Input.Prim_Range := busAddress.prim_range;
																										SELF.Clean_Input.Predir := busAddress.predir;
																										SELF.Clean_Input.Prim_Name := busAddress.prim_name;
																										SELF.Clean_Input.Addr_Suffix := busAddress.addr_suffix;
																										SELF.Clean_Input.Postdir := busAddress.postdir;
																										SELF.Clean_Input.Unit_Desig := busAddress.unit_desig;
																										SELF.Clean_Input.Sec_Range := busAddress.sec_range;
																										SELF.Clean_Input.City := busAddress.city;  // use v_city_name 90..114 to match all other scoring products
																										SELF.Clean_Input.State := busAddress.state;
																										SELF.Clean_Input.Zip := busAddress.zip5 + busAddress.zip4;
																										SELF.Clean_Input.Zip5 := busAddress.zip5;
																										SELF.Clean_Input.Zip4 := busAddress.zip4;
																										SELF.Clean_Input.Lat := busAddress.geo_lat;
																										SELF.Clean_Input.Long := busAddress.geo_long;
																										SELF.Clean_Input.Addr_Type := busAddress.rec_type;
																										SELF.Clean_Input.Addr_Status := busAddress.err_stat;
																										SELF.Clean_Input.County := busAddress.county;
																										SELF.Clean_Input.Geo_Block := busAddress.geo_blk;
																										
																										//set BIP IDs if we have them
																										SELF.Clean_Input.PowID := busInfo.BIP_IDs.PowID.LinkID;
																										SELF.Clean_Input.ProxID := busInfo.BIP_IDs.ProxID.LinkID;
																										SELF.Clean_Input.SeleID := busInfo.BIP_IDs.SeleID.LinkID;
																										SELF.Clean_Input.OrgID := busInfo.BIP_IDs.OrgID.LinkID;
																										SELF.Clean_Input.UltID := busInfo.BIP_IDs.UltID.LinkID;
																									
																										SELF.Clean_Input.HistoryDate := LEFT.historydate;
																										SELF.Clean_Input := busInfo; // Fill out the remaining fields with what was passed in
																										
																										SELF := [];)); // None of the remaining attributes have been populated yet));
		
		RETURN busInternal;
	END;
	
	EXPORT getExecs(DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus) := FUNCTION

		party := NORMALIZE(inquiredBus, LEFT.execs, TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
																													SELF.party := RIGHT;
																													SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																													SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																													SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																													SELF := LEFT;
																													SELF := [];));
	
		RETURN party;
	END;
	
  
  EXPORT getDIDLessExecs(DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus) := FUNCTION

		DIDLessparty := NORMALIZE(inquiredBus, LEFT.DIDlessExecs, TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
																													SELF.party := RIGHT;
																													SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																													SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																													SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																													SELF := LEFT;
																													SELF := [];));
	
		RETURN DIDLessparty;
	END;
  
  
  
  
	EXPORT getRegisteredAgents(DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus) := FUNCTION
		
		agent := NORMALIZE(inquiredBus, LEFT.registeredAgents, TRANSFORM(DueDiligence.LayoutsInternal.Agent,
																																			SELF.agent.addressMatchesInquiredBusiness := LEFT.busn_info.address.prim_range = RIGHT.prim_range AND
                                                                                                                    LEFT.busn_info.address.predir = RIGHT.predir AND
                                                                                                                    LEFT.busn_info.address.prim_name = RIGHT.prim_name AND
                                                                                                                    LEFT.busn_info.address.addr_suffix = RIGHT.addr_suffix AND
                                                                                                                    LEFT.busn_info.address.postdir = RIGHT.postdir AND
                                                                                                                    LEFT.busn_info.address.unit_desig = RIGHT.unit_desig AND
                                                                                                                    LEFT.busn_info.address.sec_range = RIGHT.sec_range AND
                                                                                                                    LEFT.busn_info.address.city = RIGHT.city AND
                                                                                                                    LEFT.busn_info.address.state = RIGHT.state AND
                                                                                                                    LEFT.busn_info.address.zip5 = RIGHT.zip5;
                                                                      SELF.agent := RIGHT;
																																			SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																																			SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																																			SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                                      
																																			SELF := LEFT;
																																			SELF := [];));
		
		RETURN agent;
	END;
  
  EXPORT getInquiredChildDataset(inquiredBus, dsNameFromInquired) := FUNCTIONMACRO
    child := NORMALIZE(inquiredBus, dsNameFromInquired, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, RECORDOF(RIGHT)},
                                                                      SELF.seq := LEFT.seq;
                                                                      SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                                      SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                                      SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                                      SELF := RIGHT;
                                                                      SELF := [];));
		
		RETURN child;
  ENDMACRO;
	
	EXPORT getOperatingLocations(DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus) := FUNCTION
		
		locations := NORMALIZE(inquiredBus, LEFT.operatingLocations, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, RECORDOF(RIGHT)},
																																						SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																																						SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																																						SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																																						SELF := RIGHT;
																																						SELF := LEFT;
																																						SELF := [];));
		
		RETURN locations;
	END;
	
	// ******************************************************************************************************** //
	// Replace/Overlay the Executives info on the Business Internal with the updatedExec information collected  //
	// ******************************************************************************************************** // 
	EXPORT ReplaceExecs(DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus,
											DATASET(DueDiligence.LayoutsInternal.RelatedParty) UpdateExecs) := FUNCTION

		 // Define a layout just for this FUNCTION                              //  
		 ExecsChildRollUPLayout    := RECORD
				DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;                           //*  This is the unique ID of the parent  
				DATASET(DueDiligence.Layouts.RelatedParty) ExecutiveInfo;
		 END;														 

		 // Populate the a new DATASET to be used in the ROLLUP                  //  	
		 ExecutivePreSort  := PROJECT(UpdateExecs, TRANSFORM(ExecsChildRollUPLayout,
																				SELF.ExecutiveInfo := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.RelatedParty,
																																						 SELF := LEFT.party;));
																				SELF := LEFT;));
									 
		 // SORT the Executive Prep in seq, ulti etc. sequence For the ROLLUP!!!!!//
		 ExecutiveSort  := SORT(ExecutivePreSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

		 // RollUp all of the Executives into a Normalized Dataset              // 
		 // Create a Parent Row of seq, ultid, orgid, seleid, powid and proxid  //
		 //                                                                     //
		 ExecutiveDataset  :=   
				ROLLUP(ExecutiveSort,
						LEFT.seq          = RIGHT.seq
								 AND
						LEFT.UltID        = RIGHT.UltID
								 AND
						LEFT.OrgID        = RIGHT.OrgID
								 AND
						LEFT.SeleID       = RIGHT.SeleID,
																	 // And create children rows of executives  //
																		TRANSFORM (ExecsChildRollUPLayout ,
																							 SELF.ExecutiveInfo    := LEFT.ExecutiveInfo + RIGHT.ExecutiveInfo; 
																							 SELF                := LEFT));
								 
	 
		 /* DENORMALIZE/JOIN and the BusnData(parentrecordset) with the Legal Events(childrecordset)  */   															 															
		 ReplaceBusnExecsWithNewInfo := DENORMALIZE(inquiredBus, ExecutiveDataset,
																									/* WHERE */ 
																								 LEFT.seq                             = RIGHT.seq
																											AND
																								 LEFT.Busn_info.BIP_IDS.UltID.LinkID  = RIGHT.UltID
																											AND
																								 LEFT.Busn_info.BIP_IDS.OrgID.LinkID  = RIGHT.OrgID
																											AND
																								 LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.SeleID,  
																								 GROUP,
																								 
																								 /* Update the Parent dataset  From the Left */  
																								 TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
																											SELF.seq                              := LEFT.seq; 
																											SELF.Busn_info.BIP_IDS.UltID.LinkID   := LEFT.Busn_info.BIP_IDS.UltID.LinkID; 
																											/* Overlay the Child dataset From the Right   */  
																											SELF.Execs                            := RIGHT.ExecutiveInfo;                                             
																											SELF                                  := LEFT,
																											SELF                                  := []));

			 
		
		 RETURN ReplaceBusnExecsWithNewInfo;
	END; 

		
	EXPORT AddAgents(DATASET(DueDiligence.LayoutsInternal.Agent) agents, DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus) := FUNCTION
		
		inquiredBusAgents := getRegisteredAgents(inquiredBus);
		
		allAgents := inquiredBusAgents + agents;
		
		//remove duplicates per address - but keep the most recent record
		addressSort := SORT(allAgents, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), agent.prim_range, agent.prim_name, agent.addr_suffix, agent.predir, agent.postdir, agent.zip5, -agent.dateLastSeen);

		rollAddress := ROLLUP(addressSort,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID AND
													LEFT.agent.prim_range = RIGHT.agent.prim_range AND
													LEFT.agent.prim_name = RIGHT.agent.prim_name AND
													LEFT.agent.addr_suffix = RIGHT.agent.addr_suffix AND
													LEFT.agent.predir = RIGHT.agent.predir AND
													LEFT.agent.postdir = RIGHT.agent.postdir AND
													LEFT.agent.zip5 = RIGHT.agent.zip5,
													TRANSFORM(RECORDOF(LEFT),
																		SELF.agent.source := IF(LEFT.agent.source = RIGHT.agent.source, LEFT.agent.source, DueDiligence.Constants.SOURCE_BOTH_SOS_BUSINESS_REGISTRATION);
																		SELF := LEFT;));
		
		
		
		sortAgents := SORT(rollAddress, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), -agent.dateLastSeen);
		groupAgents := GROUP(sortAgents, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
    
    maxAgents := DEDUP(groupAgents, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), KEEP(DueDiligence.Constants.MAX_REGISTERED_AGENTS));
		
		formatAgents := PROJECT(UNGROUP(maxAgents), TRANSFORM(DueDiligence.LayoutsInternal.AgentLayout,
                                                           SELF.agents := DATASET([TRANSFORM(DueDiligence.Layouts.LayoutAgent,
                                                                                              SELF := LEFT.agent;
                                                                                              SELF := [];)]);
                                                           SELF := LEFT;));
		
		sortMaxAgents := SORT(formatAgents, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
		
		rollAgents := ROLLUP(sortMaxAgents,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,
													TRANSFORM(DueDiligence.LayoutsInternal.AgentLayout,
																		SELF.agents := LEFT.agents + RIGHT.agents;
																		SELF := LEFT;));
																		
		addRegisteredAgents := JOIN(inquiredBus, rollAgents,
																LEFT.seq = RIGHT.seq AND
																LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
																TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																					SELF.registeredAgentExists := LEFT.registeredAgentExists OR EXISTS(RIGHT.agents);
																					SELF.registeredAgents := RIGHT.agents;
																					SELF := LEFT;),
																LEFT OUTER);
																											
		RETURN addRegisteredAgents;
	END;
	
	EXPORT AddOperatingLocations(DATASET(DueDiligence.LayoutsInternal.OperatingLocationLayout) locations, DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus, STRING caller) := FUNCTION
																											
		existingAddrs := NORMALIZE(inquiredBus, LEFT.operatingLocations,
																	TRANSFORM(DueDiligence.LayoutsInternal.OperatingLocationLayout,
																	     SELF.seq   := LEFT.seq;
																						SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																						SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																						SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																						SELF.locAddrs := DATASET([TRANSFORM(DueDiligence.Layouts.CommonGeographicLayout,
																																									SELF := RIGHT;
																																									SELF := [];)])[1];
																						SELF := LEFT;
																						SELF := [];));
																											
		allAddrs := existingAddrs + locations;
		
		//grab all unique addresses
		sortAllAddrs := SORT(allAddrs, seq, ultID, locaddrs[1].prim_range, locaddrs[1].prim_name, locaddrs[1].zip5, -locaddrs[1].dateLastSeen);

		//make sure our counts get added from the passed in call - those added to the inquired business counts would be 0
    addCounts := ROLLUP(sortAllAddrs, 
												LEFT.seq = RIGHT.seq AND
												LEFT.ultID = RIGHT.ultID AND
												LEFT.locaddrs[1].prim_range = RIGHT.locaddrs[1].prim_range AND
												LEFT.locaddrs[1].prim_name = RIGHT.locaddrs[1].prim_name AND
												LEFT.locaddrs[1].zip5 = RIGHT.locaddrs[1].zip5,
												TRANSFORM(RECORDOF(LEFT),
																	SELF.addrCount := LEFT.addrCount + RIGHT.addrCount;
																	SELF := LEFT;));
												
		sortCounts := SORT(addCounts, seq, ultID, -locaddrs[1].dateLastSeen);
    
    rollAddr := ROLLUP(sortCounts,
												LEFT.seq = RIGHT.seq AND
												LEFT.ultID = RIGHT.ultID,
												TRANSFORM({RECORDOF(LEFT)},
																	SELF.addrCount := LEFT.addrCount + RIGHT.addrCount;
																	SELF.locAddrs := LEFT.locAddrs + RIGHT.locAddrs;
																	SELF := LEFT;));
																											
		addOperatingLocations := JOIN(inquiredBus, rollAddr,
																	LEFT.seq = RIGHT.seq AND
																	LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																	LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																	LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
																	TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																						SELF.hdAddrCount := IF(caller = DueDiligence.Constants.SOURCE_BUSINESS_CORP, LEFT.hdAddrCount, RIGHT.addrCount);
																						SELF.SOSAddrLocationCount := IF(caller = DueDiligence.Constants.SOURCE_BUSINESS_CORP, RIGHT.addrCount, LEFT.SOSAddrLocationCount);
																						SELF.operatingLocations := RIGHT.locAddrs[1..DueDiligence.Constants.MAX_OPERATING_LOCATIONS];
																						SELF := LEFT;),
																	LEFT OUTER);	
															
		RETURN addOperatingLocations;
	END;

	
	EXPORT GetChildAsInquired(inquiredBus, dsNameFromInquired, relationshipToInquired) := FUNCTIONMACRO
		newInquired := NORMALIZE(inquiredBus, LEFT.dsNameFromInquired, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                                                              SELF.seq := LEFT.seq;
                                                                              SELF.historyDate := LEFT.historyDate;
                                                                              SELF.Busn_info.BIP_IDS.UltID.LinkID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                                              SELF.Busn_info.BIP_IDS.OrgID.LinkID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                                              SELF.Busn_info.BIP_IDS.SeleID.LinkID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                                              SELF.Busn_info.BIP_IDS.ProxID.LinkID := LEFT.Busn_info.BIP_IDS.ProxID.LinkID;
                                                                              SELF.Busn_info.BIP_IDS.PowID.LinkID := LEFT.Busn_info.BIP_IDS.PowID.LinkID;
                                                                              SELF.relatedDegree := relationshipToInquired;
                                                                              SELF.Busn_info.address.prim_range := RIGHT.prim_range;
                                                                              SELF.Busn_info.address.predir := RIGHT.predir;
                                                                              SELF.Busn_info.address.prim_name := RIGHT.prim_name;
                                                                              SELF.Busn_info.address.addr_suffix := RIGHT.addr_suffix;
                                                                              SELF.Busn_info.address.postdir := RIGHT.postdir;
                                                                              SELF.Busn_info.address.unit_desig := RIGHT.unit_desig;
                                                                              SELF.Busn_info.address.sec_range := RIGHT.sec_range;
                                                                              SELF.Busn_info.address.city := RIGHT.city;
                                                                              SELF.Busn_info.address.state := RIGHT.state;
                                                                              SELF.Busn_info.address.zip5 := RIGHT.zip5;
                                                                              SELF.Busn_info.address.zip4 := RIGHT.zip4;
                                                                              SELF.setUniquePowIDs := LEFT.setUniquePowIDs;
                                                                              SELF.atleastOneAgentSameAddrAsBus := LEFT.busn_info.address.prim_range = RIGHT.prim_range AND
                                                                                                                    LEFT.busn_info.address.predir = RIGHT.predir AND
                                                                                                                    LEFT.busn_info.address.prim_name = RIGHT.prim_name AND
                                                                                                                    LEFT.busn_info.address.addr_suffix = RIGHT.addr_suffix AND
                                                                                                                    LEFT.busn_info.address.postdir = RIGHT.postdir AND
                                                                                                                    LEFT.busn_info.address.unit_desig = RIGHT.unit_desig AND
                                                                                                                    LEFT.busn_info.address.sec_range = RIGHT.sec_range AND
                                                                                                                    LEFT.busn_info.address.city = RIGHT.city AND
                                                                                                                    LEFT.busn_info.address.state = RIGHT.state AND
                                                                                                                    LEFT.busn_info.address.zip5 = RIGHT.zip5;
                                                                              SELF := []));
																																	
		RETURN newInquired;	
	ENDMACRO;
  
  
  EXPORT ReaddOperatingLocations(inquiredBusDS, operatingLocationDS, operatingLocationDSFieldName) := FUNCTIONMACRO
   
    //rollup the operating location to the inquired business level to add back
    rollOpLocations := ROLLUP(operatingLocationDS,
                              #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                              TRANSFORM({RECORDOF(LEFT)},
                                          SELF.operatingLocationDSFieldName := LEFT.operatingLocationDSFieldName + RIGHT.operatingLocationDSFieldName;
                                          SELF := LEFT));
    
                        
    //reAdd operating locations
    readdOperatingLocation := JOIN(inquiredBusDS, rollOpLocations,
                                    #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                                    TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                              SELF.operatingLocations := RIGHT.operatingLocationDSFieldName;
                                              SELF := LEFT;),
                                    LEFT OUTER);
                                    
    RETURN readdOperatingLocation;                                

  ENDMACRO;

  
  EXPORT GetSOSStatuses(sosRecord) := FUNCTIONMACRO
     corpStatusDescUC := STD.Str.ToUpperCase(sosRecord.corp_status_desc);
     filingStatus := MAP(business_header.is_ActiveCorp(sosRecord.record_type, sosRecord.corp_status_cd, sosRecord.corp_status_desc) => DueDiligence.Constants.CORP_STATUS_ACTIVE,
                          STD.Str.Find(CorpStatusDescUC, 'GOOD STANDING', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_ACTIVE,
                          STD.Str.Find(CorpStatusDescUC, 'INACTIVE', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_INACTIVE,
                          STD.Str.Find(CorpStatusDescUC, 'DISSOLV', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_DISSOLVED,
                          STD.Str.Find(CorpStatusDescUC, 'DISSOLUTION', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_DISSOLVED,
                          STD.Str.Find(CorpStatusDescUC, 'REINSTAT', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_REINSTATE,
                          STD.Str.Find(CorpStatusDescUC, 'SUSPEN', 1) != DueDiligence.Constants.NUMERIC_ZERO => DueDiligence.Constants.CORP_STATUS_SUSPEND,
                          DueDiligence.Constants.COPR_STATUS_OTHER);
                                    
     RETURN filingStatus;
  ENDMACRO;
  
  EXPORT AddHeaderSources(sourceData, inquiredBus, inquiredBusFieldToPopulate) := FUNCTIONMACRO
  
     sortSrc := SORT(sourceData, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), source, dt_first_seen, dt_vendor_first_reported);
     rollSrc := ROLLUP(sortSrc,
                       #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                       LEFT.source = RIGHT.source,
                       TRANSFORM({RECORDOF(LEFT)},
                                 SELF.dt_first_seen := IF(LEFT.dt_first_seen = DueDiligence.Constants.NUMERIC_ZERO, RIGHT.dt_first_seen, LEFT.dt_first_seen);
                                 SELF.dt_last_seen := MAX(LEFT.dt_last_seen, RIGHT.dt_last_seen);
                                 SELF := LEFT));
                                       
                                       
     //limit the number of sources
     DueDiligence.LayoutsInternal.SourceLayout getMaxBureaus(rollSrc rs, INTEGER bureauCnt) := TRANSFORM, SKIP(bureauCnt > DueDiligence.Constants.MAX_BUREAUS)

         SELF.sources := DATASET([TRANSFORM(DueDiligence.Layouts.BusSourceLayout,
                                                      
                                  nameAndType := DueDiligence.translationSource.mapCategoryAndRecordTypeFromCode(rs.source);
                                  
                                  SELF.source := rs.source;
                                  SELF.sourceName := nameAndType.category;
                                  SELF.sourceType := nameAndType.recordType;
                                  SELF.firstReported := rs.dt_first_seen;
                                  SELF.lastReported  := rs.dt_last_seen;
                                  SELF := [];)]);
         SELF := rs;
         SELF := [];
     END;
     
     recentSrc := SORT(rollSrc, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -dt_last_seen);
     maxSrc := PROJECT(recentSrc, getMaxBureaus(LEFT, COUNTER));
                                                           
                                                           
     //sort bureau sources to keep all rows for a LINKID together 
     sortProjectSrc := SORT(maxSrc, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
     rollProjectSrc := ROLLUP(sortProjectSrc,
                               #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                               TRANSFORM({RECORDOF(LEFT)},
                                         SELF.sources := LEFT.sources + RIGHT.sources;
                                         SELF := LEFT));
                                               
     addHeaderSrc := JOIN(inquiredBus, rollProjectSrc,
                           #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                           TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                     SELF.inquiredBusFieldToPopulate := RIGHT.sources;                 
                                     SELF := LEFT),
                           LEFT OUTER);

     RETURN addHeaderSrc;   
  ENDMACRO;
  
	EXPORT GetMaxSources(inquiredBus, maxResults) := FUNCTIONMACRO
     
     ListOfBusSources := NORMALIZE(inquiredBus, LEFT.bureauReporting + LEFT.sourcesReporting, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DueDiligence.Layouts.BusSourceLayout},																												
                                                                            SELF.seq := LEFT.seq;
                                                                            SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                                            SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                                            SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID; 
                                                                            SELF := RIGHT;
                                                                            SELF := [];)); 
	
     sortSourceList := SORT(ListOfBusSources, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -lastReported);
     groupSources := GROUP(sortSourceList, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
     
     DueDiligence.LayoutsInternalReport.ListOfBusSourceLayout getMaxSources(sortSourceList ssl, Integer srcCount) := TRANSFORM, SKIP(srcCount > maxResults)
          SELF.sources := PROJECT(ssl, TRANSFORM(iesp.duediligencebusinessreport.t_DDRReportingSources,
                                                  SELF.SourceName := LEFT.sourceName;                      
                                                  SELF.SourceType := LEFT.sourceType;
                                                  SELF.FirstReported.Year := (unsigned4)((STRING)LEFT.firstreported)[1..4];  //YYYY
                                                  SELF.FirstReported.Month := (unsigned2)((STRING)LEFT.firstreported)[5..6];  //MM
                                                  SELF.FirstReported.Day := (unsigned2)((STRING)LEFT.firstreported)[7..8];  //DD
                                                  SELF.LastReported.Year := (unsigned4)((STRING)LEFT.lastreported)[1..4];
                                                  SELF.LastReported.Month := (unsigned2)((STRING)LEFT.lastreported)[5..6];
                                                  SELF.LastReported.Day := (unsigned2)((STRING)LEFT.lastreported)[7..8]; 
                                                  SELF := [];));
          SELF := ssl;
          SELF := [];
     END;  
	 
    
		sources := UNGROUP(PROJECT(groupSources, getMaxSources(LEFT, COUNTER)));
    
    sortSources := SORT(sources, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
    rollSources := ROLLUP(sortSources,
                          #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.sources := LEFT.sources + RIGHT.sources;
                                    SELF := LEFT;));
                                    
                                    
	
		RETURN rollSources;
	ENDMACRO;  
	
END;