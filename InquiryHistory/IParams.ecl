IMPORT AutoStandardI, FFD, FCRA, Gateway, iesp;

EXPORT IParams := MODULE

  EXPORT IParam := INTERFACE(FCRA.iRules)
    EXPORT DATASET(Gateway.Layouts.Config) gateways;
    EXPORT BOOLEAN ReturnSuppressed := FALSE; 
    EXPORT BOOLEAN ReturnDisputed := FALSE;
    EXPORT BOOLEAN SkipPersonContextCall := FALSE;
  END;

  EXPORT GetParams(iesp.fcrainquiryhistory.t_FCRAInquiryHistoryOption options) := FUNCTION
  
    inmod := MODULE  (PROJECT(AutoStandardI.GlobalModule(), IParam, opt))  
      EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
      EXPORT BOOLEAN ReturnDisputed := options.ReturnDisputedRecords;
      EXPORT BOOLEAN ReturnSuppressed := options.ReturnSuppressedRecords;
      EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get(options.FCRAPurpose);  // currently not used by the query
      EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get(options.FFDOptionsMask);  // currently not used by the query
    END;
    
    RETURN inmod;
  END;
  

END;