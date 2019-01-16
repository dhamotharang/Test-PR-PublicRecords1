
IMPORT BatchShare;

EXPORT BeneficiaryRiskScore_Interfaces := MODULE
	
	EXPORT IRestrictionParams := INTERFACE (BatchShare.IParam.BatchParams)
		EXPORT BOOLEAN dppa_ok        := false;
		EXPORT BOOLEAN ViewDebugs     := false;
	END;	
	
	EXPORT IInstantIDConfig := INTERFACE
		EXPORT BOOLEAN isFCRA;
		EXPORT BOOLEAN ln_branded;
		EXPORT BOOLEAN isUtility;
		EXPORT BOOLEAN ofac_only;
		EXPORT BOOLEAN suppressNearDups;
		EXPORT BOOLEAN require2ele;
		EXPORT BOOLEAN from_biid;
		EXPORT BOOLEAN excludeWatchlists;
		EXPORT BOOLEAN from_IT1O;
		EXPORT UNSIGNED1 ofac_version;
		EXPORT BOOLEAN include_ofac;
		EXPORT BOOLEAN include_additional_watchlists;
		EXPORT REAL watchlist_threshold;
		EXPORT INTEGER2 dob_radius;
		EXPORT BOOLEAN includeRelativeInfo;
		EXPORT BOOLEAN includeDLInfo;
		EXPORT BOOLEAN includeVehInfo;
		EXPORT BOOLEAN includeDerogInfo;
		EXPORT BOOLEAN nugen;	
	END;
	
	// An instantiation of the Interface above. There can be other instantiations for different
	// configurations or purposes. The values assigned below are obtained from Risk_Indicators.Boca_Shell.
	EXPORT modInstantIDConfigDefault(IRestrictionParams	restrictions, unsigned1 ofac_version_ = 1, boolean include_ofac_ = false, real global_watchlist_threshold_ = 0.84) := MODULE(IInstantIDConfig)
		EXPORT BOOLEAN isFCRA              := FALSE;
		EXPORT BOOLEAN ln_branded          := FALSE;
		EXPORT BOOLEAN isUtility           := restrictions.industryclass = 'UTILI';
		EXPORT BOOLEAN ofac_only           := TRUE;
		EXPORT BOOLEAN suppressNearDups    := FALSE;
		EXPORT BOOLEAN require2ele         := FALSE;
		EXPORT BOOLEAN from_biid           := FALSE;
		EXPORT BOOLEAN excludeWatchlists   := FALSE;
		EXPORT BOOLEAN from_IT1O           := FALSE;
		EXPORT UNSIGNED1 ofac_version      := ofac_version_;
		EXPORT BOOLEAN include_ofac        := include_ofac_;
		EXPORT BOOLEAN include_additional_watchlists := FALSE;
		EXPORT REAL watchlist_threshold    := global_watchlist_threshold_;
		EXPORT INTEGER2 dob_radius         := -1;
		EXPORT BOOLEAN includeRelativeInfo := TRUE;
		EXPORT BOOLEAN includeDLInfo       := TRUE;
		EXPORT BOOLEAN includeVehInfo      := TRUE;
		EXPORT BOOLEAN includeDerogInfo    := TRUE;
		EXPORT BOOLEAN nugen               := TRUE;	
	END;
	
	EXPORT ISearchSubject := INTERFACE
		// Record-level or SearchBy fields
		EXPORT STRING30  acctno;   
    EXPORT UNSIGNED4 seq;
		EXPORT UNSIGNED3 history_date;        
		EXPORT STRING20	 historyDateTimeStamp;
		EXPORT STRING20  did_value;       
    EXPORT STRING100 full_name_value;
		EXPORT STRING30  first_name_value;           
		EXPORT STRING30  middle_name_value;           
		EXPORT STRING30  last_name_value;           
		EXPORT STRING5   name_suffix_value;          
		EXPORT STRING120 addr1_value;    
		EXPORT STRING100 addr2_value;
		EXPORT STRING25  city_value;            
		EXPORT STRING2   state_value;           
		EXPORT STRING5   zip_value;    
		EXPORT STRING25  country_value;       
		EXPORT STRING9   ssn_value;           
		EXPORT STRING8   dob_value;           
		EXPORT UNSIGNED1 age_value;           
		EXPORT STRING20  dl_number_value;     
		EXPORT STRING2   dl_state_value;      
		EXPORT STRING100 email_value;         
		EXPORT STRING45  ip_value;            
		EXPORT STRING10  phone_value;         
		EXPORT STRING10  wphone_value;        
		EXPORT STRING100 employer_name_value;  
		EXPORT STRING30  prev_lname_value;  
		EXPORT STRING30  case_number;
		EXPORT STRING20  benefit_claim_amount;
		EXPORT STRING2   benefits_issued_state;
		EXPORT STRING8   date_applied_for_benefits;
		EXPORT STRING20  mvr_vehicle_value;
		EXPORT STRING5   number_mvrs_reported;
		EXPORT STRING5   number_properties_reported;
		EXPORT STRING5   number_adults_in_household;
		EXPORT STRING100 filler_field_1;
	END;
	
	EXPORT IInputOptions_BocaShell := INTERFACE
		// Options: filter by date_last_seen
		EXPORT UNSIGNED3 LastSeenThreshold; 
	
		// Options: bocashell things
		EXPORT BOOLEAN   Exclude_Relatives;
		EXPORT BOOLEAN   Include_Score;
		EXPORT BOOLEAN   ADL_Based_Shell;     
		EXPORT BOOLEAN   Remove_Fares;
		EXPORT BOOLEAN   IncludeDLverification;
		EXPORT UNSIGNED1 append_best;
		
		// Query behavior
		EXPORT UNSIGNED1 bsversion;            // BocaShell version
		EXPORT UNSIGNED8 bsOptions;            // BocaShell options
		EXPORT STRING    RealTimePermissibleUse;             
		
		// NOTES:
		// 1. The Gateways param is handled by the call to Gateway.Configuration.Get().
		// 2. Permissions and Restrictions are handled by BatchParams, defined above.
	END;
	
	EXPORT IInputOptions_PostBeneficiaryFraud := INTERFACE
		EXPORT UNSIGNED1 RelativeDepthLevel;  
		EXPORT BOOLEAN   Current_Only;
		EXPORT UNSIGNED2 Date_Cutoff;
		EXPORT BOOLEAN   Include_All;                        
		EXPORT BOOLEAN   Include_Relative_And_Associates;    
		EXPORT BOOLEAN   Include_Drivers_License;            
		EXPORT BOOLEAN   Include_Property;                   
		EXPORT BOOLEAN   Include_In_House_Motor_Vehicle;     
		EXPORT BOOLEAN   Include_Real_Time_Motor_Vehicle;    
		EXPORT BOOLEAN   Include_Watercraft_And_Aircraft;    
		EXPORT BOOLEAN   Include_Professional_License;       
		EXPORT BOOLEAN   Include_Business_Affiliations;      
		EXPORT BOOLEAN   Include_People_At_Work;             
		EXPORT BOOLEAN   Include_Bankruptcy_Liens_Judgements;
		EXPORT BOOLEAN   Include_Criminal_SOFR;              
		EXPORT BOOLEAN   Include_UCC_Filings;
		EXPORT BOOLEAN   Include_In_House_Motor_Vehicle2;     
		EXPORT BOOLEAN   Include_Real_Time_Motor_Vehicle2; 
	END;
END;
