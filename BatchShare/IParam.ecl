import $, doxie, Gateway;

/*
**************************************************************************************
	IMPORTANT: Please do not import/use attributes from GlobalModule/Autostandard here.
**************************************************************************************
*/

export IParam := module
	
	// **************************************************************************************
	//   This should work as the base for all batch params.
	// **************************************************************************************

  EXPORT BatchParams := INTERFACE (doxie.IDataAccess)
    EXPORT unsigned2 PenaltThreshold      := $.Constants.Defaults.PenaltThreshold;
    EXPORT unsigned8 MaxResults           := $.Constants.Defaults.MaxResults;
    EXPORT unsigned8 MaxResultsPerAcct    := $.Constants.Defaults.MaxResultsPerAcctno;
    EXPORT boolean   ReturnCurrentOnly    := FALSE;
    EXPORT boolean   RunDeepDive          := FALSE;
    EXPORT boolean   ReturnDetailedRoyalties := FALSE;
    // FCRA queries need to make a remote call to append DIDs, if not provided in the input
    EXPORT DATASET (Gateway.Layouts.Config) gateways := DATASET ([], Gateway.Layouts.Config);
  END;

  // an (optional) convenience method for initializing most common input criteria
  EXPORT getBatchParams() := FUNCTION
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
    in_mod := MODULE(PROJECT (mod_access, BatchParams, OPT))
      EXPORT unsigned2 PenaltThreshold   := $.Constants.Defaults.PenaltThreshold     : stored('PenaltThreshold');
      EXPORT unsigned8 MaxResults        := $.Constants.Defaults.MaxResults          : stored('MaxResults');
      EXPORT unsigned8 MaxResultsPerAcct := $.Constants.Defaults.MaxResultsPerAcctno : stored('Max_Results_Per_Acct');
      EXPORT boolean   ReturnCurrentOnly := FALSE                                  : stored('Return_Current_Only');
      EXPORT boolean   RunDeepDive       := FALSE                                  : stored('Run_Deep_Dive');
      EXPORT boolean   ReturnDetailedRoyalties := FALSE                            : stored('ReturnDetailedRoyalties');
    END;

    RETURN in_mod;
  END;

END;
