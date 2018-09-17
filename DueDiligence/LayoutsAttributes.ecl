EXPORT LayoutsAttributes := MODULE

  //These are used stricly to calculate the attribute values in getBusKRI
  EXPORT BusinessAttributeValues := RECORD
    /* BusAssetOwnProperty */
		UNSIGNED6 	PropTaxValue;                                       //populated in DueDiligence.getBusProperty
		UNSIGNED2 	CurrPropOwnedCount;                                 //populated in DueDiligence.getBusProperty
		UNSIGNED2 	CountSoldProp;                                      //populated in DueDiligence.getBusProperty
    /* BusAssetOwnWatercraft */ 
		UNSIGNED2 	WatercraftCount;                                    //populated in DueDiligence.getSharedWatercraft 
		UNSIGNED2  	Watercraftlength;                                   //populated in DueDiligence.getSharedWatercraft 
    /* BusAssetOwnAircraft */
		UNSIGNED2 	AircraftCount;                                      //populated in DueDiligence.getBusAircraft
    /* BusAssetOwnVehicle */
		UNSIGNED3 	VehicleCount;                                       //populated in DueDiligence.getBusVehicle
		UNSIGNED6  	VehicleBaseValue;
    /*BusSOSAgeRange*/  
		UNSIGNED4  	sosIncorporationDate;										            //populated in DueDiligence.getBusSOSDetail
		BOOLEAN   	noSOSFilingEver;												            //populated in DueDiligence.getBusSOSDetail
    /*BusPublicRecordAgeRange*/ 	
		UNSIGNED4 	busnHdrDtFirstSeen;											            //populated in DueDiligence.getBusHeader
		UNSIGNED3 	srcCount;																            //populated in DueDiligence.getBusHeader  This is a count of ALL Sources
    /*BusValidityRisk*/
		UNSIGNED2 	sosAddrLocationCount;										            //populated in DueDiligence.getBusSOSDetail
		UNSIGNED2 	hdAddrCount;														            //populated in DueDiligence.getBusHeader 
		UNSIGNED2 	creditSrcCnt;														            //populated in DueDiligence.getBusHeader  This is a count of Credit Bureaus
		BOOLEAN     noFein;																	            //populated in DueDiligence.getBusHeader			
		BOOLEAN     busRegHit;															            //populated in DueDiligence.getBusRegistration
    /*BusStabilityRisk*/
    BOOLEAN			sosAllDissolveInactiveSuspend;					            //populated in DueDiligence.getBusSOSDetail
    BOOLEAN			sosHasAtleastOneDissolvedFiling;				            //populated in DueDiligence.getBusSOSDetail					
		BOOLEAN			sosHasAtleastOneInactiveFiling;					            //populated in DueDiligence.getBusSOSDetail			
		BOOLEAN			sosHasAtleastOneSuspendedFiling;				            //populated in DueDiligence.getBusSOSDetail	
		BOOLEAN			sosHasAtleastOneOtherStatusFiling;			            //populated in DueDiligence.getBusSOSDetail		
		BOOLEAN			sosHasAtleastOneActiveFiling;						            //populated in DueDiligence.getBusSOSDetail
		UNSIGNED4   sosLastReinstateDate;										            //populated in DueDiligence.getBusSOSDetail
		UNSIGNED4   firstReportedAtInputAddress;						            //populated in DueDiligence.getBusSOSDetail
    BOOLEAN			feinIsSSN;															            //populated in DueDiligence.getBusAsInd
    BOOLEAN			busIsSOHO;															            //populated in DueDiligence.getBusAsInd
    BOOLEAN     inputAddressVerified;                		            //populated in DueDiligence.getBusHeader
    BOOLEAN			cmra;																		            //populated in DueDiligence.getBusAddrData
		BOOLEAN			vacant;																	            //populated in DueDiligence.getBusAddrData
		BOOLEAN			notFoundInHeader;												            //populated in DueDiligence.getBusHeader
    /*BusStructureType*/
		STRING60    hdBusnType;															            //populated in DueDiligence.getBusHeader
		STRING60    adrBusnType;														            //populated in DueDiligence.getBusAddrData
    /*BusShellShelfRisk*/
		UNSIGNED3 	numOfBusFoundAtAddr;										            //populated in DueDiligence.getBusAddrData
		UNSIGNED3		numOfBusIncInStateLooseLaws;						            //populated in DueDiligence.getBusAddrData
		UNSIGNED3		numOfBusNoReportedFein;									            //populated in DueDiligence.getBusAddrData
		UNSIGNED4 	busnHdrDtFirstSeenNonCredit;						            //populated in DueDiligence.getBusHeader
		UNSIGNED2 	shellHdrSrcCnt;													            //populated in DueDiligence.getBusHeader
		BOOLEAN			incorpWithLooseLaws;										            //populated in DueDiligence.getBusHeader, DueDiligence.getBusSOSDetail, DueDiligence.getBusAddrData
		BOOLEAN			privatePostExists;											            //populated in DueDiligence.getBusAddrData
		BOOLEAN			mailDropExists;													            //populated in DueDiligence.getBusAddrData
		BOOLEAN			remailerExists;													            //populated in DueDiligence.getBusAddrData
		BOOLEAN			storageFacilityExists;								            	//populated in DueDiligence.getBusAddrData
		BOOLEAN			undeliverableSecRangeExists;						            //populated in DueDiligence.getBusAddrData
		BOOLEAN			registeredAgentExists;									            //populated in DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		BOOLEAN 		atleastOneAgentSameAddrAsBus;						            //populated in DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		BOOLEAN     agentShelfBusn;													            //populated in DueDiligence.getBusAddrData
		BOOLEAN		  agentPotentialNIS;											            //populated in DueDiligence.getBusAddrData
    /*BusExecutiveOfficersRisk*/
		UNSIGNED3		numOfBusExecs;												            	//populated in DueDiligence.getBusExec
		BOOLEAN			atleastOneActiveLawAcctExec;					            	//populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneActiveFinRealEstateExec;		            	//populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneActiveMedicalExec;						            //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneActiveBlastPilotExec;					            //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveLawAcctExec;					            //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveFinRealEstateExec;		            //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveMedicalExec;					            //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveBlastPilotExec;				            //populated in DueDiligence.getBusProfLic
    /*BusLegalEventType*/
		BOOLEAN			atleastOneBEOInCategory9;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory8;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory7;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory6;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory5;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory4;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory3;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory2;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			BEOsHaveNoConvictionsOrCategoryHits;                //populated in DueDiligence.getBusLegalEvents
    /*BusUSResidency*/
		BOOLEAN		  atleastOneBEOInvalidSSN;
		BOOLEAN		  atleastOneBEOAssocITINOrImmigrantSSN;
		BOOLEAN		  atleastOneBEODOBPriorToParentSSN;
		BOOLEAN     atleastOneBEOParentWithITINOrImmigrantSSN;
		BOOLEAN		  atleastOneBEONoParentsOrNeitherHaveSSNITIN;
		BOOLEAN		  atleastOneBEOPublicRecordsLess3YrsWithNoVote;
		BOOLEAN		  atleastOneBEOPublicRecordsBetween3And10YrsWithNoVote;
		BOOLEAN		  atleastOneBEOPublicRecordsMoreThan10YrsWithNoVote;
		BOOLEAN		  atleastOneBEOOrParentRegisteredVoter;
    /* Criminal Evidence flags*/                                    
		BOOLEAN     BEOevidenceOfCurrentIncarcerationOrParole;        // Level 9
		BOOLEAN     BEOevidenceOfFelonyConvictionInLastNYR;           // Level 8 
		BOOLEAN     BEOevidenceOfFelonyConvictionOlderNYR;            // Level 7
		BOOLEAN     BEOevidenceOfPreviousIncarceration;               // Level 6
		BOOLEAN     BEOevidenceOfUncatagorizedConvictionInLastNYR;    // Level 5
		BOOLEAN     BEOevidenceOfMisdeameanorConvictionInLastNYR;     // Level 4
		BOOLEAN     BEOevidenceOfUncatagorizedConvictionOlderNYR;     // Level 3
		BOOLEAN     BEOevidenceOfMisdeameanorConvictionOlderNYR;      // Level 2
    BOOLEAN     BEONoEvidenceOfStateCriminal;
  END;
  
  
  //These are used stricly to calculate the attribute values in getIndKRI
  EXPORT PersonAttributeValues := RECORD
    /*PerAssetOwnWatercraft*/ 
		UNSIGNED2 	watercraftCount;                                  //populated in DueDiligence.getSharedWatercraft 
		UNSIGNED2  	watercraftLength;                                 //populated in DueDiligence.getSharedWatercraft 
    /*PerUSResidency*/
		UNSIGNED4 	firstReportedDate;															  //populated in DueDiligence.getIndHeader
		BOOLEAN		  registeredVoter;															    //populated in DueDiligence.getIndHeader
		BOOLEAN			stateVotingSourceAvailable;										    //populated in DueDiligence.getIndHeader
		BOOLEAN			hasSSN;																				    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			hasITIN;																			    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			hasImmigrantSSN;															    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			validSSN;																			    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			hasParent;																		    //populated in DueDiligence.getIndRelatives
		BOOLEAN			atleastOneParentHasSSN;												    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			atleastOneParentHasITIN;											    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			atleastOneParentHasImmigrantSSN;							    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			atleastOneParentIsRegisteredVoter;					      //populated in DueDiligence.getIndHeader
		UNSIGNED4		mostRecentParentSSNIssuanceDate;							    //populated in DueDiligecne.getIndSSNData
    /*PerLegalEventType*/
		BOOLEAN			atleastOneCategory9;
		BOOLEAN			atleastOneCategory8;
		BOOLEAN			atleastOneCategory7;
		BOOLEAN			atleastOneCategory6;
		BOOLEAN			atleastOneCategory5;
		BOOLEAN			atleastOneCategory4;
		BOOLEAN			atleastOneCategory3;
		BOOLEAN			atleastOneCategory2;
    /*PerCivilLegalEvent*/
    BOOLEAN     tenPlusLiensJudgementsEvictionsPast3Yrs;
    BOOLEAN     five2NineLiensJudgementsEvictionsPast3Yrs;
    BOOLEAN     three2FourLiensJudgementsEvictionsPast3Yrs;
    BOOLEAN     one2TwoLiensJudgementsEvictionsPast3Yrs;
    BOOLEAN     tenPlusLiensJudgementsEvictionsOver3Yrs;
    BOOLEAN     five2NineLiensJudgementsEvictionsOver3Yrs;
    BOOLEAN     three2FourLiensJudgementsEvictionsOver3Yrs;
    BOOLEAN     one2TwoLiensJudgementsEvictionsOver3Yrs;
    /*PerStateLegalEvent*/
    BOOLEAN     currentIncarcerationOrParole;
    BOOLEAN     felonyPast3Yrs;
    BOOLEAN     felonyOver3Yrs;
    BOOLEAN     previousIncarceration;
    BOOLEAN     uncategorizedConvictionPast3Yrs;
    BOOLEAN     misdemeanorConvictionPast3Yrs;
    BOOLEAN     uncategorizedConvictionOver3Yrs;
    BOOLEAN     misdemeanorConvictionOver3Years;
    /*PerAssetOwnProperty*/
    UNSIGNED2   ownedPropCount;                                 //populated in DueDiligence.getIndProperty
    /*PerAccessToFundsProperty*/
    UNSIGNED6   totalAssesedValue;                              //populated in DueDiligence.getIndProperty
    UNSIGNED2   previouslyOwnedPropCount;                       //populated in DueDiligence.getIndProperty
    /*PerProfessional License*/
    BOOLEAN			atleastOneActiveLawAcct;					            	//populated in DueDiligence.getIndProfessionalData
		BOOLEAN			atleastOneActiveFinRealEstate;		            	//populated in DueDiligence.getIndProfessionalData
		BOOLEAN			atleastOneActiveMedical;						            //populated in DueDiligence.getIndProfessionalData
		BOOLEAN			atleastOneActiveBlastPilot;					            //populated in DueDiligence.getIndProfessionalData
		BOOLEAN			atleastOneInactiveLawAcct;					            //populated in DueDiligence.getIndProfessionalData
		BOOLEAN			atleastOneInactiveFinRealEstate;		            //populated in DueDiligence.getIndProfessionalData
		BOOLEAN			atleastOneInactiveMedical;					            //populated in DueDiligence.getIndProfessionalData
		BOOLEAN			atleastOneInactiveBlastPilot;				            //populated in DueDiligence.getIndProfessionalData
    /*PerAccessToFundsIncome*/
    UNSIGNED3   estimatedIncome;                                //populated in DueDiligence.getIndEstimatedIncome
    /*PerAssetOwnVehicle*/
		UNSIGNED2 	VehicleCount;                                   //populated in DueDiligence.getIndVehicle
		UNSIGNED6  	VehicleBaseValue;
    /*PerAgeRange*/
    INTEGER1   estimatedAge;
  END;

END;