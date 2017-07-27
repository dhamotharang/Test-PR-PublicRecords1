IMPORT iesp, Gateway;
EXPORT Constants :=
MODULE

	EXPORT UNSIGNED1 MaxDIDs             := 100;
	EXPORT UNSIGNED2 MaxGongPhones       := 2000;
	EXPORT UNSIGNED1 MaxPhones           := 100;
	EXPORT UNSIGNED1 MaxGatewayMatches   := 100;
	EXPORT UNSIGNED1 MaxTUGatewayResults := 30;
	EXPORT UNSIGNED1 MaxPhoneMatches     := 10;
	EXPORT UNSIGNED1 MaxRoyalties        := 8; // accudata ocn royalty
	
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
	
	// Enum for TransactionType and Phone source
	EXPORT TransType   := ENUM(Basic = 0,Premium = 1,Ultimate = 2, PhoneRiskAssessment = 3);
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
		EXPORT UNSIGNED1 MetronetLimit			 := 3;
		EXPORT UNSIGNED1 MaxPhones 					 := 6;
		EXPORT UNSIGNED1 MaxSubjects         := 5;
		EXPORT UNSIGNED1 MaxPremiumSource    := 3; 
		EXPORT UNSIGNED1 MaxSectionLimit	   := 35; 
	END;
	
	// Porting phones constants
	EXPORT PortingStatus:=
	MODULE
		EXPORT Disconnected := 'DE'; //SU-suspend
	END;
	
	EXPORT SET OF STRING OTPVerifyTransactions := ['mfaverifyotp','mfaverifyotponce'];
	EXPORT SET OF STRING RiskIndicator := ['PASS','WARN','FAIL'];
	EXPORT RiskLevel		 := ENUM(PASS=1,WARN=2,FAILED=3);
	EXPORT UNSIGNED1 OTPRiskLimit := 5;
	EXPORT UNSIGNED1 InquiryDayLimit := 1;
	EXPORT defaultRules	 := DATASET([{'Phone Association','H','1','0','No Identity',0,0,true,true}],iesp.phonefinder.t_PhoneFinderRiskIndicator);
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
		
	EXPORT PhoneRiskAssessmentGateways  := [Gateway.Constants.ServiceName.PhonesMetaData, Gateway.Constants.ServiceName.AccuDataOCN]; // phonerisk assessment gateways
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
END;