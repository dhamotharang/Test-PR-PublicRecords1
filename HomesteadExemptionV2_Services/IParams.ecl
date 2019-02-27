IMPORT BatchShare, Gateway, Std, Suppress;

EXPORT IParams := MODULE

	EXPORT Params := INTERFACE(BatchShare.IParam.BatchParamsV2)
		EXPORT UNSIGNED3 DidScoreThreshold := 0;
		EXPORT UNSIGNED3 MaxProperties := 0;
		EXPORT STRING4 TaxYear := '';
		EXPORT STRING2 TaxState := '';
		EXPORT BOOLEAN IncludeRealTimeVehicles := FALSE;
		EXPORT STRING RealTimePermissibleUse := '';
		EXPORT BOOLEAN IncludePrevOwnedProps := FALSE;
	END;

	EXPORT getParams() := FUNCTION
		bs_mod := BatchShare.IParam.getBatchParamsV2();

		UNSIGNED3 propCount := HomesteadExemptionV2_Services.Constants.DEFAULT_PROPERTIES : STORED('MaxProperties');

		RETURN MODULE(PROJECT(bs_mod,Params,OPT))
			EXPORT UNSIGNED3 DidScoreThreshold := HomesteadExemptionV2_Services.Constants.SCORE_THRESHOLD : STORED('DidScoreThreshold');
			EXPORT UNSIGNED3 MaxProperties := MIN(MAX(propCount,HomesteadExemptionV2_Services.Constants.MIN_PROPERTIES),HomesteadExemptionV2_Services.Constants.MAX_PROPERTIES);
			EXPORT STRING4 TaxYear := (STRING)Std.Date.Year(Std.Date.Today()) : STORED('TaxYear');
			EXPORT STRING2 TaxState := '' : STORED('TaxState');
			EXPORT BOOLEAN IncludeRealTimeVehicles := FALSE : STORED('IncludeRealTimeVehicles');
			EXPORT STRING RealTimePermissibleUse := '' : STORED('RealTimePermissibleUse');
			EXPORT BOOLEAN IncludePrevOwnedProps := FALSE : STORED('IncludePrevOwnedProps');
			EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
		END;
	END;

END;
