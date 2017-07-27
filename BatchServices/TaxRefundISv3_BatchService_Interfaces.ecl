import iesp;
EXPORT TaxRefundISv3_BatchService_Interfaces := MODULE

	EXPORT Input := INTERFACE
		// common input options	
		EXPORT string32 ApplicationType;  		
		EXPORT unsigned1 DPPAPurpose;
		EXPORT unsigned1 GLBPurpose;
		EXPORT string DataPermission;
		EXPORT string DataRestriction;
		EXPORT string5  IndustryClass;
		EXPORT boolean IncludeBlankDOD;
		EXPORT boolean PhoneticMatch; 
		EXPORT boolean AllowNickNames; 
		EXPORT boolean IncludeMinors := false; 
		// TRIS specific, v2 & v3 common input options ---v
		EXPORT string120 append_l; //Append allows all Best Info to return
		EXPORT string120 verify_l;
		EXPORT string2 input_state;
		EXPORT boolean isInputState(string2 st) := st = input_state or input_state = '' or st = '';
		EXPORT unsigned2 BestSSNScoreMin;
		EXPORT unsigned2 BestNameScoreMin;
		EXPORT string20  ModelName;        
		EXPORT string30  FilterRule;
		EXPORT boolean   GetSSNBest := true;
		// TRIS specific, new v3 only input options ---v
		EXPORT string3   ScoreCut;          // 0-999; default 0
		EXPORT unsigned2 DIDScoreThreshold; // 0-100; default 80
		EXPORT string30  Creditor;
		EXPORT unsigned3 RefundThreshold;   // 0-0000000; default 0
		// TRIS v3 specific, new 2015 enhancements input options ---v
		EXPORT boolean   IncludeIPAddrGW;    // defaults to true in TaxRefundISv3_BatchService
		EXPORT boolean   IncludeDebtEvasion; // defaults to true in TaxRefundISv3_BatchService
		// TRIS v3.1 with fdn
		EXPORT boolean includeDependantID;   // default false
		EXPORT Integer IPAddrExceedsRange; // default 100
		EXPORT unsigned6  GlobalCompanyId;
		EXPORT unsigned2 IndustryType;
		EXPORT unsigned6 ProductCode;
		// TRIS v3.1 add HRI codes as comma separated list parameters (defaults can be found in BatchServices.TaxRefundISv3_BatchService
		EXPORT string AddressRiskHRICodes;		
		EXPORT string IdentityRiskHRICodes;		
		EXPORT string ReportOnlyHRICodes;
		EXPORT string AllHRICodes;
	END;
END;
