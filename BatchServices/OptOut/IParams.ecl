IMPORT BatchShare, Gateway;

  EXPORT IParams := MODULE

    EXPORT BatchParams := INTERFACE(BatchShare.IParam.BatchParams)
      EXPORT UNSIGNED1 Score_Threshold;
      EXPORT BOOLEAN AllowTestSuppression;
    END;

    // Function to initalize the params
    EXPORT getBatchParams() := FUNCTION
      BaseBatchParams := BatchShare.IParam.getBatchParams();
      
      inMod := MODULE(PROJECT(BaseBatchParams, BatchParams, OPT))
        EXPORT UNSIGNED1 Score_Threshold := BatchShare.Constants.Defaults.didScoreThreshold;
        EXPORT BOOLEAN AllowTestSuppression := FALSE : STORED('AllowTestSuppression');
      END;
      
      RETURN inMod;
    END;

  END;
