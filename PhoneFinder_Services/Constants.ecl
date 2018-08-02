﻿IMPORT iesp, Gateway, MDR, ut;
EXPORT Constants :=
MODULE

	EXPORT UNSIGNED1 MaxDIDs             := 100;
	EXPORT UNSIGNED2 MaxGongPhones       := 2000;
	EXPORT UNSIGNED1 MaxPhones           := 100;
	EXPORT UNSIGNED1 MaxGatewayMatches   := 100;
	EXPORT UNSIGNED1 MaxTUGatewayResults := 30;
	EXPORT UNSIGNED1 MaxPhoneMatches     := 10;
	EXPORT UNSIGNED1 MaxRoyalties        := 11; 
	EXPORT INTEGER   MaxOtherPhones      := 5; // MaxOtherPhones default
	
	
	// Phone Porting 
	EXPORT UNSIGNED1 MaxPortedMatches    	 := 100;	
	EXPORT UNSIGNED1 MaxSpoofedMatches     := 100;	
	EXPORT UNSIGNED1 MaxOTPMatches     		 := 100;	
	EXPORT UNSIGNED1 MaxOTPBatch	     		 := 30;	
	EXPORT UNSIGNED1 PortingMarginOfError  := 5; 	// plus or minus 5 days from the date fields
	EXPORT UNSIGNED  MetadataLimit 			 	 := 10000;  
	EXPORT UNSIGNED1 MaxAlertCategories 	 := 3;  
	EXPORT UNSIGNED1 SQLSelectLimit			 	 := 100;  // Limit SQL select for each phone
	EXPORT UNSIGNED1 gatewayTimeout			 	 := 2;  
	EXPORT UNSIGNED1 gatewayRetries			 	 := 0;  
	EXPORT UNSIGNED1 NoPenalty           := 0;
	EXPORT UNSIGNED1 LIBD_LastActivityThreshold           := 60;

	// Enum for TransactionType and Phone source
	EXPORT TransType   := ENUM(Basic = 0,Premium = 1,Ultimate = 2, PhoneRiskAssessment = 3);
 SHARED TransTypeCodes := DATASET([
       {TransType.Basic, 'BASIC'},
       {TransType.Premium, 'PREMIUM'},
       {TransType.Ultimate, 'ULTIMATE'},                    
       {TransType.PhoneRiskAssessment, 'PHONERISKASSESSMENT'}
       ], {unsigned1 tcode; string ttype;});

TransCodeTypeDCT := DICTIONARY(TransTypeCodes, {tcode => ttype}); 
EXPORT MapTransCode2Type(UNSIGNED1 t) := TransCodeTypeDCT[t].ttype;

TransTypeCodeDCT := DICTIONARY(TransTypeCodes, {ttype => tcode}); 
EXPORT MapTransType2Code(STRING t) := TransTypeCodeDCT[ut.CleanSpacesAndUpper(t)].tcode;

EXPORT PhoneSource := ENUM(UNSIGNED1,Waterfall,QSentGateway,TargusGateway,ExpFileOne,Gong,PhonesPlus,InHouseQSent,LastResort);
	
	// Phone types
	EXPORT PhoneType :=
	MODULE
		EXPORT Landline := 'LANDLINE';
		EXPORT Wireless := 'POSSIBLE WIRELESS';
		EXPORT Pager    := 'PAGER';
		EXPORT VoIP     := 'POSSIBLE VoIP';
		EXPORT Other    := 'OTHER/UNKNOWN';
	END;
	EXPORT serviceType   := ENUM(LandLine = 0,Wireless = 1,VOIP = 2,Unknown = 3);
	EXPORT STRING PhoneActiveStatus := '13'; //'Active-Unknown Line Type'
	EXPORT STRING PhoneInactiveStatus := '33'; //'Inactive-Unknown Line Type'
	EXPORT PhoneStatus := 
		MODULE
			EXPORT Inactive := 'INACTIVE';
			EXPORT Active 	:= 'ACTIVE';
			EXPORT NotAvailable 	:= 'NOT AVAILABLE';
		END;
	
	// Listing types
	EXPORT ListingType :=
	MODULE
		EXPORT Business    := 'BUSINESS';
		EXPORT Government  := 'GOVERNMENT';
		EXPORT Residential := 'RESIDENTIAL';
		EXPORT BusGov      := 'BUSINESS AND GOVERNMENT';
		EXPORT BusGovRes   := 'BUSINESS, GOVERNMENT AND RESIDENTIAL';
	END;
	
	// Waterfall phones constants
	EXPORT WFConstants :=
	MODULE
		EXPORT UNSIGNED1 MaxPhones 					 := 6;
		EXPORT UNSIGNED1 MaxSubjects         := 5;
		EXPORT UNSIGNED1 MaxPremiumSource    := 2; //PHPR-95 update to return 2 equifax phones
		EXPORT UNSIGNED1 MaxSectionLimit	   := 35; 
	END;
	
	// Ported metadata phones constants
	EXPORT PortingStatus:=
	MODULE
		EXPORT Disconnected := 'DE'; //SU-suspend
		EXPORT UNSIGNED1 DisconnectedPhoneThreshold := 180; // no of days threshold for phone disconnect status
	END;
	
	EXPORT SET OF STRING OTPVerifyTransactions := ['mfaverifyotp','mfaverifyotponce'];
	EXPORT SET OF STRING RiskIndicator := ['PASS','WARN','FAIL'];
	EXPORT RiskLevel		 := ENUM(PASS=1,WARN=2,FAILED=3);
	EXPORT UNSIGNED1 OTPRiskLimit := 5;
	EXPORT UNSIGNED1 InquiryDayLimit := 1;
	EXPORT defaultRules	 := DATASET([{'Phone Association','H','1','0','No Identity',0,0,true,true}, {'Phone Association','H','1','-1','No phone associated with subject',0,0,true,true}],
	                                iesp.phonefinder.t_PhoneFinderRiskIndicator);
	EXPORT SET OF STRING enumCategory := ['Phone Association','Phone Activity','Phone Criteria'];
	
	EXPORT SpoofPhoneOrigin :=
		MODULE 
			EXPORT STRING1 Spoofed 			:= 'S';
			EXPORT STRING1 Destination 	:= 'D';
			EXPORT STRING1 Source 			:= 'C';
		END;

	EXPORT MaxCheckIdentities := 10;

  EXPORT VerifyMessage :=
		MODULE 
			EXPORT PhoneCannotBeVerified := 'Input phone number cannot be verified';
			EXPORT PhoneNotEntered := 'No phone number was entered';
			EXPORT PhoneMatchesNameAddress := 'Input phone number matches name and address';
			EXPORT PhoneMatchesName := 'Input phone number matches name';
			EXPORT PhoneIsActive := 'Input phone number is verified as Active for the defined threshold period';
			EXPORT PhoneNotActive := 'Input phone number is NOT verified as Active for the defined threshold period';
		END;
		
	EXPORT VARSTRING ErrorCodes(INTEGER c) :=
		CASE(c,	100 => 'More than one verification type selected',
						101 => 'No Phone number was entered for the verification request',
					'Unspecified Failure');
		
	EXPORT PhoneRiskAssessmentGateways  := [Gateway.Constants.ServiceName.PhonesMetaData, Gateway.Constants.ServiceName.AccuDataOCN,
                                            Gateway.Constants.ServiceName.ZumigoIdentity]; // phonerisk assessment gateways
	// Debugging
	EXPORT Debug :=
	MODULE
		EXPORT Main         := FALSE;
		EXPORT Intermediate := FALSE;
		EXPORT PhoneNoSearch:= FALSE;
		EXPORT PIISearch    := FALSE;
		EXPORT Waterfall    := FALSE;
		EXPORT Gong         := FALSE;
		EXPORT QSent        := FALSE;
		EXPORT Targus       := FALSE;
		EXPORT PhoneMetadata:= FALSE;
	END;
	
	EXPORT ZumigoConstants := MODULE
		EXPORT STRING20 Usecase     := 'FCIP';
		EXPORT STRING3 	productCode := 'ACC';
		EXPORT STRING20 productName := 'PHONE FINDER';
		EXPORT STRING10 optInType   := 'Whitelist';
		EXPORT STRING5 	optInMethod := 'TCO';
		EXPORT STRING3 	optinDuration := 'ONG';
	END;
	
	EXPORT ConsentLevels := MODULE
	  EXPORT UNSIGNED1 SingleConsumer := 2;
	  EXPORT UNSIGNED1 FullConsumer   := 3;
	END;
	
	EXPORT RiskRules := MODULE
	  EXPORT UNSIGNED1 SimCardInfo  := 35;
	  EXPORT UNSIGNED1 DeviceInfo   := 36;
	END;
	
	// Batch only
	EXPORT BatchRestrictedDirectMarketingSourcesSet :=  
	                                    [MDR.sourceTools.src_AL_Experian_Veh,                                    
	                                     MDR.SourceTools.src_Voters_v2,	
																			 MDR.SourceTools.src_Wither_and_Die, 
																			 MDR.SourceTools.src_AK_Watercraft,
																			 MDR.SourceTOols.src_AK_Experian_Veh, 
																			 MDR.SourceTools.src_CO_Experian_Veh, 
																			 MDR.SourceTools.src_CO_Experian_DL, 
																			 MDR.SourceTools.src_CT_Experian_Veh, 
																			 MDR.SourceTools.src_CT_DL,           
																			 MDR.SourceTools.src_DE_Experian_Veh, 
																			 MDR.SourceTools.src_DE_Experian_DL,  
																			 MDR.SourceTools.src_DC_Experian_Veh, 
																			 MDR.SourceTools.src_FL_Experian_Veh, 
																			 MDR.SourceTOols.src_FL_Veh,          
																			 MDR.SourceTOols.src_FL_Watercraft,   
																			 MDR.SourceTOols.src_FL_Veh,         
																			 MDR.SourceTools.src_FL_DL,          
																			 MDR.SourceTools.src_ID_Experian_DL,  
																			 MDR.SourceTOols.src_ID_Veh,           
																				MDR.SourceTools.src_ID_Experian_Veh, 
																				MDR.SourceTOols.src_IL_Experian_Veh, 
																				MDR.SourceTOols.src_IL_Experian_DL, 
																				MDR.SourceTools.src_KS_Watercraft,
																				MDR.SourceTools.src_KY_Watercraft, 
																				MDR.SourceTools.src_KY_Experian_Veh, 
																				MDR.SourceTools.src_KY_Veh,        
																				MDR.SourceTools.src_KY_Watercraft,
																				MDR.SourceTools.src_KY_Experian_DL, 
																				MDR.SourceTools.src_LA_Experian_DL, 
																				MDR.SourceTools.src_LA_Experian_Veh, 
																				MDR.SourceTools.src_LA_DL,          
																				MDR.SourceTools.src_ME_DL,          
																				MDR.SourceTools.src_ME_Veh,          
																				MDR.SourceTools.src_ME_Experian_Veh, 
																				MDR.SourceTools.src_MD_Experian_DL, 
																				MDR.SourceTools.src_MD_Watercraft, 
																				MDR.SourceTools.src_MD_Experian_Veh, 
																				MDR.SourceTools.src_MA_DL,          
																				MDR.SourceTools.src_MA_Experian_Veh,
																				MDR.SourceTools.src_MI_Watercraft,
																				MDR.SourceTools.src_MI_Experian_Veh, 
																				MDR.SourceTools.src_MI_DL,           
																				MDR.SourceTools.src_MN_Veh,          
																				MDR.SourceTools.src_MN_Experian_Veh,
																			   MDR.SourceTools.src_MN_DL  , 
																				 MDR.SourceTools.src_MS_Experian_DL  , 
																				 MDR.SourceTools.src_MS_Experian_Veh , 
																				 MDR.SourceTools.src_MS_Veh, 
																				 MDR.SourceTools.src_MS_Veh, 
																				 MDR.SourceTools.src_MO_Experian_Veh, 
																				 MDR.SourceTools.src_MO_Veh,          
																				 MDR.SourceTools.src_MO_Watercraft,
																				 MDR.SourceTools.src_MT_Watercraft, 
																				 MDR.SourceTools.src_MT_Experian_Veh, 
																				 MDR.SourceTools.src_MT_Veh,
																				 MDR.SourceTools.src_NE_Veh,
																				 MDR.SourceTools.src_NE_Watercraft,
																				 MDR.SourceTools.src_NV_Experian_Veh, 
																				 MDR.SourceTools.src_NV_Veh, 
																				 MDR.SourceTools.src_NV_DL ,
																				 MDR.SourceTools.src_NH_Watercraft,
																				 MDR.SourceTools.src_NH_Experian_DL,
																				 MDR.SourceTools.src_NM_Experian_Veh,
																				 MDR.SourceTools.src_NY_Experian_Veh, 
																				 MDR.SourceTools.src_EMerge_CCW,
																				 MDR.SourceTools.src_NC_Veh, 
																				 MDR.SourceTools.src_ND_Experian_DL, 
																				 MDR.SourceTools.src_ND_Experian_Veh , 
																				 MDR.SourceTools.src_ND_Veh , 
																				 MDR.SourceTools.src_ND_Watercraft,
																				 MDR.SourceTools.src_OH_Experian_Veh, 
																				 MDR.SourceTools.src_OH_Veh,
																				 MDR.SourceTools.src_OH_DL,
																				 MDR.SourceTools.src_OK_Experian_Veh , 
																				 MDR.SourceTools.src_SC_Experian_Veh , 
																				 MDR.SourceTools.src_SC_Watercraft, 
																				 MDR.SourceTools.src_Professional_License, 
																				 MDR.SourceTools.src_SC_Experian_DL,
																				 MDR.SourceTools.src_TN_DL,
																				 MDR.SourceTools.src_TN_Experian_Veh, 
																				 MDR.SourceTools.src_TX_DL,																			
																				 MDR.SourceTools.src_TX_Veh, 
																				 MDR.SourceTools.src_TX_Experian_Veh, 
																				 MDR.SourceTools.src_UT_Watercraft, 
																				 MDR.SourceTools.src_UT_Experian_Veh , 
																				 MDR.SourceTools.src_VA_Watercraft ,
																				 MDR.SourceTools.src_WA_Watercraft , 
																				 MDR.SourceTools.src_WI_Veh ,
																				 MDR.SourceTools.src_WV_DL , 
																				 MDR.SourceTools.src_WI_Experian_Veh, 
																				 MDR.SourceTools.src_WI_DL , 
																				 MDR.SourceTools.src_WY_DL, 
																				 MDR.SourceTools.src_WY_Experian_Veh , 
																				 MDR.SourceTools.src_WY_Veh , 
																				 MDR.SourceTools.src_Targus_White_pages, 
																				 MDR.SourceTools.src_LnPropV2_Fares_Asrs , 
																				 MDR.SourceTools.src_Foreclosures , 
																				 MDR.SourceTools.src_Equifax , 
																				 MDR.SourceTools.src_EBR , 
																				 MDR.SourceTools.src_Experian_Credit_Header  , 
																				 MDR.SourceTools.src_Certegy ,
																				 MDR.SourceTools.src_Yellow_Pages ,
																				 MDR.SourceTools.src_Wired_Assets_Email , 
																				 MDR.SourceTools.src_TUCS_Ptrack , 
																				 MDR.SourceTools.src_Entiera ,
																				 MDR.SourceTools.src_Wired_Assets_Owned, 
																				 MDR.SourceTools.src_TU_CreditHeader 
																				 ];
END;