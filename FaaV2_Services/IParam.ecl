IMPORT BatchShare, BIPV2, STD, gateway, FFD, FCRA;

EXPORT IParam := MODULE

	EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParamsV2, FCRA.iRules)
		export string1   BIPFetchLevel := '';
	END;

	EXPORT getBatchParams(boolean isFCRA = FALSE) := FUNCTION
		
		base_params := BatchShare.IParam.getBatchParamsV2();
	
		string1 sBIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID	 : STORED('BIPFetchLevel');
		
		faa_batch_params := MODULE(PROJECT(base_params, BatchParams, opt))
			export string1 BIPFetchLevel := STD.Str.touppercase(sBIPFetchLevel);
			export dataset (Gateway.layouts.config) gateways := gateway.Configuration.get();
			export INTEGER8 FFDOptionsMask := IF(isFCRA, FFD.FFDMask.Get(), 0);
			export INTEGER FCRAPurpose := IF(isFCRA, FCRA.FCRAPurpose.Get(), 0);
		END;		

		RETURN faa_batch_params;
	END;		
	
END;