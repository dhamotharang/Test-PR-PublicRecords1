IMPORT BatchShare, FCRA, FFD, Gateway;

EXPORT IParams := MODULE

  EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParams,FCRA.iRules)
    EXPORT UNSIGNED3 DidScoreThreshold := BatchShare.Constants.Defaults.DidScoreThreshold;
  END;

  EXPORT getBatchParams() := FUNCTION
    bs_mod := BatchShare.IParam.getBatchParams();

    RETURN MODULE(PROJECT(bs_mod,BatchParams,OPT))
      EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get();
      EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get();
      EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
      EXPORT UNSIGNED3 DidScoreThreshold := BatchShare.Constants.Defaults.DidScoreThreshold : STORED('DidScoreThreshold');
    END;
  END;

END;
