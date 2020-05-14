EXPORT configFunctions := MODULE
	IMPORT FraudGovPlatform_Analytics;
		
	EXPORT getHpccConnection(BOOLEAN runProd, BOOLEAN newVersion, BOOLEAN updateROSE = FALSE) := FUNCTION
	
		hpccConnection 			:= MAP(updateROSE => FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionDev,
			runProd AND newVersion => FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionProd, 
			// runProd AND ~newVersion  => FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionProdQa, //use this once Drea is done
			runProd AND ~newVersion  => FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionProd, //remove this once Drea is done
			~runProd AND newVersion => FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionQa,
			// FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionQaDev //use this once Drea is done
			FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionQa //remove this once Drea is done
			);
	
	RETURN hpccConnection;
	END;
	
	EXPORT getDspToUse(BOOLEAN runProd, BOOLEAN updateROSE = FALSE, BOOLEAN forceDspQa = FALSE) := FUNCTION
		dspToUse	:= MAP(updateROSE => FraudGovPlatform_Analytics.Constants.RampsWebServices.DspQa, //DSP QA for ROSE environment
			runProd    => FraudGovPlatform_Analytics.Constants.RampsWebServices.DspProd, //DSP Prod for Prod
      forceDspQa => FraudGovPlatform_Analytics.Constants.RampsWebServices.DspQa, //Force DSP QA
			FraudGovPlatform_Analytics.Constants.RampsWebServices.DspCert); //DSP Cert for RIN Cert
	RETURN dspToUse;
	END;
END;