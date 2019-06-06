IMPORT BatchShare, FCRA, FFD, Gateway, Suppress;

EXPORT IParams := MODULE

	EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParamsV2,FCRA.iRules)
		EXPORT UNSIGNED3 DidScoreThreshold := BatchShare.Constants.Defaults.DidScoreThreshold;
	END;

	EXPORT getBatchParams() := FUNCTION
		bs_mod := BatchShare.IParam.getBatchParamsV2();

		RETURN MODULE(PROJECT(bs_mod,BatchParams,OPT))
			EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get();
			EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get();
			EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
			EXPORT UNSIGNED3 DidScoreThreshold := BatchShare.Constants.Defaults.DidScoreThreshold : STORED('DidScoreThreshold');
		END;
	END;

END;
