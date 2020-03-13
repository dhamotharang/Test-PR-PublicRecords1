IMPORT BatchShare, Gateway, Std, Suppress, iesp;

EXPORT IParams := MODULE

	SHARED CNST:=HomesteadExemptionV2_Services.Constants;

	EXPORT Params := INTERFACE(BatchShare.IParam.BatchParams)
		EXPORT UNSIGNED3 DidScoreThreshold := 0;
		EXPORT UNSIGNED3 MaxProperties := 0;
		EXPORT STRING4 TaxYear := '';
		EXPORT STRING2 TaxState := '';
		EXPORT BOOLEAN IncludeRealTimeVehicles := FALSE;
		EXPORT STRING RealTimePermissibleUse := '';
		EXPORT BOOLEAN IncludePrevOwnedProps := FALSE;
	END;

	EXPORT getParams() := FUNCTION
		bs_mod := BatchShare.IParam.getBatchParams();

		UNSIGNED3 propCount := CNST.DEFAULT_PROPERTIES : STORED('MaxProperties');

		RETURN MODULE(PROJECT(bs_mod,Params,OPT))
			EXPORT UNSIGNED3 DidScoreThreshold := CNST.SCORE_THRESHOLD : STORED('DidScoreThreshold');
			EXPORT UNSIGNED3 MaxProperties := MIN(MAX(propCount,CNST.MIN_PROPERTIES),CNST.MAX_PROPERTIES);
			EXPORT STRING4 TaxYear := (STRING)Std.Date.Year(Std.Date.Today()) : STORED('TaxYear');
			EXPORT STRING2 TaxState := '' : STORED('TaxState');
			EXPORT BOOLEAN IncludeRealTimeVehicles := FALSE : STORED('IncludeRealTimeVehicles');
			EXPORT STRING RealTimePermissibleUse := '' : STORED('RealTimePermissibleUse');
			EXPORT BOOLEAN IncludePrevOwnedProps := FALSE : STORED('IncludePrevOwnedProps');
			EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
		END;
	END;

	EXPORT SetInputUser(iesp.share.t_User user) := FUNCTION
		iesp.ECL2ESP.SetInputUser(user);
		BOOLEAN LnBranded:=GLOBAL(user).LnBranded;
		#STORED('LnBranded',LnBranded);
		RETURN OUTPUT(DATASET([],{INTEGER x}),NAMED('__internal__'),EXTEND);
	END;

	EXPORT SetInputOptions(iesp.Homestead_Exemption_Search.t_HomesteadExemptionSearchOption options) := FUNCTION
		INTEGER incomingThreshold:=GLOBAL(options).DidScoreThreshold;
		DidScoreThreshold:=IF(incomingThreshold>0,incomingThreshold,CNST.SCORE_THRESHOLD);
		#STORED('DidScoreThreshold',DidScoreThreshold);
		INTEGER incomingProperties:=GLOBAL(options).MaxProperties;
		INTEGER propCount:=IF(incomingProperties<CNST.MIN_PROPERTIES,CNST.DEFAULT_PROPERTIES,incomingProperties);
		MaxProperties:=MIN(MAX(propCount,CNST.MIN_PROPERTIES),CNST.MAX_PROPERTIES);
		#STORED('MaxProperties',MaxProperties);
		BOOLEAN IncludeRealTimeVehicles:=GLOBAL(options).IncludeRealTimeVehicles;
		#STORED('IncludeRealTimeVehicles',IncludeRealTimeVehicles);
		STRING RealTimePermissibleUse:=GLOBAL(options).RealTimePermissibleUse;
		#STORED('RealTimePermissibleUse',RealTimePermissibleUse);
		RETURN OUTPUT(DATASET([],{INTEGER x}),NAMED('__internal__'),EXTEND);
	END;

END;
