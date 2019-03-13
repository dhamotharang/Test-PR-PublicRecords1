EXPORT configFunctions := MODULE
	IMPORT FraudGovPlatform_Analytics;
		
	EXPORT getHpccConnection(BOOLEAN runProd, BOOLEAN newVersion) := FUNCTION
	
		hpccConnection 			:= MAP(runProd AND newVersion => FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionProd, 
			// runProd AND ~newVersion  => FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionProdQa, //use this once Drea is done
			runProd AND ~newVersion  => FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionProd, //remove this once Drea is done
			~runProd AND newVersion => FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionQa,
			// FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionQaDev //use this once Drea is done
			FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionQa //remove this once Drea is done
			);
	
	RETURN hpccConnection;
	END;
	
	EXPORT getDspToUse(BOOLEAN runProd) := FUNCTION
		dspToUse	:= IF(runProd, FraudGovPlatform_Analytics.Constants.RampsWebServices.DspProd, FraudGovPlatform_Analytics.Constants.RampsWebServices.DspQa);
	RETURN dspToUse;
	END;
END;