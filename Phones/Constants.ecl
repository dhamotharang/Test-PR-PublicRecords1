// Constants accross different phone services
IMPORT MDR;
EXPORT Constants :=
MODULE
	EXPORT UNSIGNED  MAX_RECORDS := 10000;
	EXPORT UNSIGNED  STRING_MATCH_THRESHOLD := 2; 
  // PhonesPlusV2 special text to indicate "Insurance Verified and moved from below to above the line".
	EXPORT InsVeriBelow := 'Ins-Verified-Below';

	// Default confidence score threshold for phones
	EXPORT PhoneConfidenceScore := 11;

	// Type flag
	EXPORT TypeFlag :=
	MODULE
		EXPORT NonDirectoryAssistance           := 'N';
		EXPORT DirectoryAssistance_Disconnected := 'D';
		EXPORT DirectoryAssistance              := 'G';
		EXPORT DataSource_PV                    := 'P';
		EXPORT DataSource_iQ411                 := 'I';
		EXPORT AccuData_OCN                     := 'A';  // ACCUDATA_OCN GATEWAY
	END;
	// for accurint comp report redesign
	// PhoneType
	EXPORT PhoneType := module
		export Residential := 'Residential';
		export Business    := 'Business';
		export Government  := 'Government';
	END;

//NewType
	EXPORT NewType := module
		export Current 				 := 'Current DA';
		export Possible 			 := 'Possible non-DA';
	END;
	// for accurint comp report redesign - end
	// TNT flag
	EXPORT TNT :=
	MODULE
		// Bullseye - Is currently the best address and is a DID match to the gong file.
		// The ultimate, full phone verification and other records pointing at that being best address too
		EXPORT Bullseye := 'B';

		// Verified is currently the best address and is a HHID match to the gong file
		// Other records support this as the best address and the HOUSEHOLD has a phone registered at this line. Will pick up women with different lname to husbands
		EXPORT Verified := 'V';

		// Current is best address but not validated by the gong file
		// Self evident, works even when there is no phone indicator
		EXPORT Current := 'C';

		// Probable is not currently the best address, but is did verified or hhid verified with a dt_last_seen within 6 months
		// Most likely because the best address is a mailing (only) address. This annotates the address with the active phone line out of lived in addresses
		EXPORT Probable := 'P';

		// Relative is not currently the best address, and has a dt_last_seen > 6 months ago but is HHID verified
		// Probably identifies a situation where a family member moved out of the address
		EXPORT Relative := 'R';

		// Historic is not the best address and is not HHID or DID verified
		EXPORT History := 'H';
	END;

	// QSent Gateway Service Type
	EXPORT ServiceType :=
	MODULE
		EXPORT PVS   := 'PVS';
		EXPORT PVSD  := 'PVSD';
		EXPORT IQ411 := 'iQ411';
	END;

	// Targus Gateway search type
	EXPORT TargusType :=
	MODULE
		EXPORT WirelessConnectionSearch 	:= 'W';
		EXPORT ConfirmConnect 				:= 'C';
		EXPORT PhoneDataExpress				:= 'P';
		EXPORT VerifyExpress				:= 'V';
		EXPORT NameVerification 			:= 'N';	// E3220, used by Riskwise
	END;

	// Phone listing type
	EXPORT ListingType :=
	MODULE
		EXPORT Residential := 'R';
		EXPORT Business    := 'B';
		EXPORT Government  := 'G';
	END;

		// COCType
	EXPORT COCType :=
	MODULE
		EXPORT EndofOfficeCode		:= 'EOC';
		EXPORT PublicMobileCarrier  := 'PMC';
		EXPORT RadioCommonCarrier  	:= 'RCC';
		EXPORT ServiceProvider1   	:= 'SP1';
		EXPORT ServiceProvider2	  	:= 'SP2';
	END;

		// Special Service Codes (SSCs)
	EXPORT SSC :=
	MODULE
		EXPORT Intralata 	 	:= 'A'; //Only within Local access and transport area(LATA) - the NXX or thousand blocks assigned
		EXPORT Paging    		:= 'B';
		EXPORT Cellular  		:= 'C';
		EXPORT Pseudo800 		:= 'I';
		EXPORT Extended  		:= 'J'; //NXX and/or thousands block has an extended/expanded local Calling area
		EXPORT LocalMassCalling := 'M';
		EXPORT NotApplicable  	:= 'N'; //No SSC needed eg. POTS,900 Service, Test Code, and 500 Personal Communication Services (PCS)
		EXPORT Other			:= 'O'; //restrictions and/or special services not defined by other SSC
		EXPORT Radio			:= 'R'; //Two-way Conventional Mobile Radio - pre-cellphone technology
		EXPORT MiscServices		:= 'S'; //Miscellaneous Services - non-500 PCS, Voice Mail, etc.
		EXPORT Time				:= 'T'; //Time of day announcement
		EXPORT VOIP				:= 'V'; //Internet Protocol Voice Enabled Services
		EXPORT Weather			:= 'W'; //Weather announcement
		EXPORT Exchange			:= 'X'; //Local Exchange - LEC IntraLATA special billing option on a LATA-wide basis
		EXPORT SelectiveLocal  	:= 'Z'; //LEC IntraLATA special billing option on a SELECTIVE Exchange basis
		EXPORT PRnUSVI			:= '8'; //Puerto Rico and U.S. Virgin Islands
	END;

	// Phone types
	EXPORT PhoneServiceType :=
	MODULE
		EXPORT Landline := 'LANDLINE';
		EXPORT Wireless := 'WIRELESS';
		EXPORT VoIP     := 'VOIP';
		EXPORT Other    := 'UNKNOWN';
	END;

	EXPORT PhoneStatus :=
	MODULE
		EXPORT ACTIVE 		:= 'active';
		EXPORT CANCELLED 	:= 'cancelled';
		EXPORT SUSPENDED    := 'suspended';
	END;	

	EXPORT GatewayValues :=
	MODULE
		 EXPORT STRING AccuDataLNP  := 'LNP'; // local number poratability data - AccuData gateway transaction type
	  	EXPORT STRING AccuDataCNAM := 'CNM2'; // Retrieve Calling Name for phone number
		EXPORT UNSIGNED1 SQLSelectLimit			 	 := 100;  // Limit SQL select for each phone
		EXPORT UNSIGNED1 requestTimeout			 	 := 5;
		EXPORT UNSIGNED1 requestRetries			 	 := 0;
		EXPORT UNSIGNED1 MaxRecords					 := 5;
		EXPORT STRING 	 DELTA_ATT_DQ_IRS			 := 'ATT_DQ_IRS';
		EXPORT STRING 	 QueryType_ATT_DQ_IRS	 	 := 'DQ_IRS';
		EXPORT STRING 	 ZumigoIdentity				 := 'Zumigo_GLI';
		EXPORT STRING 	 ClientIDPrefix				 := 'LEXISNEXIS_';
		EXPORT UNSIGNED1 MaxZumigoRequest			 := 15;
		EXPORT STRING 	 TimeoutMessage 			 := 'timeout expired';
	END;
	// Zumigo Input Values
	EXPORT ZumigoInputOptions :=
	MODULE
		EXPORT STRING OptInType := 'WHITELIST';
		EXPORT OptInMethod := ['TCO','MA','TCP','IVR','SMS','TCPA','ONE','OTHER'];
		EXPORT TCPA_OptInMethod := 'TCPA';
		EXPORT OptInDuration := ['ONE','ONG'];
		EXPORT ONE_OptInDuration := 'ONE'; 
	END;

	EXPORT UNSIGNED1 Zumigo_NameAddr_Validation_Threshold_MIN :=80;
	EXPORT UNSIGNED1 Zumigo_NameAddr_Validation_Threshold_MAX :=100;
	EXPORT UNSIGNED1 ZumigoMaxValidation := 15;
	// Debug
	EXPORT Debug :=
	MODULE
		EXPORT AccuDataCNAM := FALSE;
		EXPORT LNData := FALSE;
		EXPORT PhonesPlus := FALSE;
		EXPORT PhoneMetadata_wLIDB := FALSE;
		EXPORT PhoneAttributes_Main := FALSE;
		EXPORT Zumigo := FALSE;
		EXPORT STRING InternalTestClientID := 'LEXISNEXIS';
		EXPORT testing := FALSE;
	END;

	//Phone Ownership (Phone Attributes) and Phone Finder
	EXPORT PhoneAttributes :=
	MODULE
		EXPORT MaxRecsPerPhone 		:= 500; //Actual limit as of 4/18/2016 is 57 - W20160418-095049
		EXPORT LastActivityThreshold:= 90; //tolerance threshold for record age
		EXPORT PORTED_PHONE			:= 'C';
		EXPORT DISCONNECTED			:= 'D';
		EXPORT PORTED_LINE			:= 'L';
		EXPORT REACTIVATED			:= 'R';
		EXPORT NUMBER_SWAPPED		:= 'DS'; // swap identifies both a disconnect and a number swap
		EXPORT SUSPENDED				:= 'U';
		EXPORT LIDB_VERFICATION	:= 'V';
		EXPORT ATT_LIDB_RealTime:=  'PR'; // use to identify ATT gateway records for royalty
		EXPORT ATT_LIDB_Delta		:=  'PD'; // temporarily used to distinguish deltabase records
		EXPORT ATT_LIDB_SRC			:= MDR.sourceTools.src_Phones_LIDB;
		EXPORT set_ATT_LIDB			:= [ATT_LIDB_SRC,ATT_LIDB_RealTime];
		EXPORT ICONECTIV_SRC		:= MDR.sourceTools.src_PhonesPorted_iConectiv;
		EXPORT DISCONNECT_SRC		:= MDR.sourceTools.src_Phones_Disconnect;
		EXPORT GONG_DISCONNECT_SRC	:= MDR.sourceTools.src_Phones_Gong_History_Disconnect;
		EXPORT SUSPENDED_CODE		:= 'SU';
		EXPORT DISCONNECTED_CODE:= 'DE';

	END;
 	
END;