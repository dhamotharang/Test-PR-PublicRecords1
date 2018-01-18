IMPORT Address, BatchDatasets;

EXPORT IParam := MODULE
  // Need to use BatchDatasets instead of BatchShare because of industry_class needed by DID lookup
  EXPORT BatchParams := INTERFACE (BatchDatasets.IParams.BatchParams)
    EXPORT boolean   AppendBest := true;
    EXPORT boolean   TestVelocityRules := false;
 	  EXPORT UNSIGNED3 DIDScoreThreshold;
    EXPORT unsigned6 GlobalCompanyId;     // company (agency)
    EXPORT unsigned2 IndustryType;        // company (agency) program i.e. SNAP, TANF, Medicaid, etc..
    EXPORT unsigned6 ProductCode;
    EXPORT string    AgencyVerticalType;  // agency vertical type i.e. Tax, Health, Labor, etc..
    EXPORT string18  AgencyCounty;        // agency location
    EXPORT string2   AgencyState;         // agency location
    EXPORT integer 	 MaxVelocities;
    EXPORT string 	  FraudPlatform;
			 EXPORT boolean  	ReturnDetailedRoyalties;
  END;

  // **************************************************************************************
  //   This is where the service options should be read from #store.
  //   The module parameter should be passed along to the underlying attributes.
  // **************************************************************************************      
  EXPORT getBatchParams() := FUNCTION
    
    base_params := BatchDatasets.IParams.getBatchParams();
    in_mod := MODULE(PROJECT(base_params, BatchParams, OPT))        

      EXPORT boolean   TestVelocityRules	:= false: STORED('TestVelocityRules'); // this option is internal to roxie. added to toggle between test/actual velocity rules. 
      EXPORT boolean   AppendBest 				:= true	: STORED('AppendBest');
   	  EXPORT unsigned3 DIDScoreThreshold  := 80		: STORED('DIDScoreThreshold');
      EXPORT unsigned6 GlobalCompanyId    := 0		: STORED('GlobalCompanyId');
      EXPORT unsigned2 IndustryType       := 0		: STORED('IndustryType');
      EXPORT unsigned6 ProductCode        := 0		: STORED('ProductCode');
      EXPORT string 	 AgencyVerticalType := ''		: STORED('VerticalType');
      EXPORT string18  AgencyCounty       := ''		: STORED('AgencyCounty');
      EXPORT string2   AgencyState        := ''		: STORED('AgencyState');
			
      EXPORT integer   MaxVelocities      := FraudGovPlatform_Services.Constants.MAX_VELOCITIES : STORED('MaxVelocities');
      EXPORT string    FraudPlatform			:= FraudGovPlatform_Services.Constants.FRAUD_PLATFORM : STORED('FraudPlatform');
						EXPORT BOOLEAN   ReturnDetailedRoyalties := false : STORED('ReturnDetailedRoyalties');
    END;
	
    RETURN in_mod;
	
  END;  

END;