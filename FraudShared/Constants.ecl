// IMPORT FraudDefenseNetwork, FraudGovPlatform;

EXPORT Constants() := MODULE

	EXPORT Platform := MODULE
		EXPORT FDN := 'FDN';  //FraudDefenseNetwork._Dataset().Name;
		EXPORT FraudGov	:= 'FraudGov'; //FraudGovPlatform._Dataset().Name;
	END;

END;