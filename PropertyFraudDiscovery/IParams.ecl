IMPORT BatchShare,Relationship;

EXPORT IParams := MODULE

	EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParamsV2,Relationship.IParams.relationshipParams)
		EXPORT INTEGER  NumberPropertyYears := 0;
		EXPORT INTEGER  NumberInterval1Years := 0;
		EXPORT INTEGER  NumberInterval2Years := 0;
	END;

	// **************************************************************************************
	//   This is where the service options should be read from #store.
	//	 The module parameter should be passed along to the underlying attributes.
	// **************************************************************************************			
	EXPORT getBatchParams() := FUNCTION
			PFDC := PropertyFraudDiscovery.Constants;

			base_params := BatchShare.IParam.getBatchParamsV2();
			// Project the base params to read shared parameters from store. If necessary, you may 
			// redefine default values for common parameters and/or define default values for domain-
			// specific parameters
			tmp_mod := MODULE(PROJECT(base_params,BatchParams,OPT))				
				EXPORT INTEGER NumberPropertyYears := PFDC.NumberPropertyYears : STORED('NumberPropertyYears');
				EXPORT INTEGER NumberInterval1Years := PFDC.NumberInterval1Years : STORED('NumberInterval1Years');
				EXPORT INTEGER NumberInterval2Years := PFDC.NumberInterval2Years : STORED('NumberInterval2Years');
			END;

			inMod:=Relationship.IParams.getParams(tmp_mod,BatchParams);

			RETURN inMod;
		END;

END;