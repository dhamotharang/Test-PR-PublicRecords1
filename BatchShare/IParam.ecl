import $, doxie, suppress, Gateway, STD;

/*
**************************************************************************************
	IMPORTANT: Please do not import/use attributes from GlobalModule/Autostandard here.
**************************************************************************************
*/

export IParam := module
	
	// **************************************************************************************
	//   This should work as the base for all batch params.
	// **************************************************************************************
  export masking := interface
    export string6 ssn_mask := 'NONE';
    export boolean mask_dl := false;
    export unsigned1 dob_mask := suppress.Constants.dateMask.NONE;
  end;

  // 2 interfaces to replace AutoStandardI / DataRestrictionI.params and PermissionI_Tools; with defaults
  // almost same as in PersonReports; //TODO: find out a common place for defining such interfaces
  export restrictions := INTERFACE
    export string DataRestrictionMask := Constants.Defaults.DataRestrictionMask;
    export string DataPermissionMask  := Constants.Defaults.DataPermissionMask;
    export boolean ignoreFares        := false;
    export boolean ignoreFidelity     := false;
		export string5  industryclass     := '';	// D2C - consumer restriction
  end;

  export permissions := INTERFACE
    export boolean AllowAll := false;
    export boolean AllowGLB := false;
    export boolean AllowDPPA := false;
    export unsigned1 GLBPurpose := Constants.Defaults.GLBPurpose;
    export unsigned1 DPPAPurpose := Constants.Defaults.DPPAPurpose;
    export boolean IncludeMinors := false;
  end;

	export BatchParams := interface (restrictions, permissions, masking) 																	
		export string32 	ApplicationType 		:= Constants.Defaults.ApplicationType;
		export unsigned2	PenaltThreshold			:= Constants.Defaults.PenaltThreshold;
		export unsigned8 	MaxResults 					:= Constants.Defaults.MaxResults;	
		export unsigned8 	MaxResultsPerAcct 	:= Constants.Defaults.MaxResultsPerAcctno;	
		export boolean 		ReturnCurrentOnly		:= false;
		export boolean 		RunDeepDive					:= false;
		export boolean 	 	ReturnDetailedRoyalties := false;	
    // FCRA queries need to make a remote call to append DIDs, if not provided in the input 
    export dataset (Gateway.Layouts.Config) gateways := dataset ([], Gateway.Layouts.Config);
	end;

  // an (optional) convenience method for initializing most common input criteria
	export getBatchParams() := 
	
	function
		in_mod := module(BatchParams)		
			export unsigned1	GLBPurpose				:= Constants.Defaults.GLBPurpose 					: stored('GLBPurpose');
			export unsigned1	DPPAPurpose				:= Constants.Defaults.DPPAPurpose 				: stored('DPPAPurpose');
			export string32 	ApplicationType 	:= Constants.Defaults.ApplicationType 		: stored('ApplicationType');
			export unsigned2	PenaltThreshold		:= Constants.Defaults.PenaltThreshold 		: stored('PenaltThreshold');
			export unsigned8 	MaxResults        := Constants.Defaults.MaxResults 					: stored('MaxResults');
			export unsigned8 	MaxResultsPerAcct := Constants.Defaults.MaxResultsPerAcctno : stored('Max_Results_Per_Acct');
			export boolean 		ReturnCurrentOnly := false 																	: stored('Return_Current_Only');			
			export boolean 		RunDeepDive     	:= false 																	: stored('Run_Deep_Dive');			
			export boolean 	 	ReturnDetailedRoyalties := false														: stored('ReturnDetailedRoyalties');
      export string DataRestrictionMask := Constants.Defaults.DataRestrictionMask   : stored('DataRestrictionMask');
      export string DataPermissionMask  := Constants.Defaults.DataPermissionMask    : stored('DataPermissionMask');
			export string6 ssn_mask := Constants.Defaults.SSNMask : stored('SSNMask');
      // NB: other fields are unlikely to be used
			string5 _industryclass := '' : stored('IndustryClass'); // added for D2C restrictions
			export string5 industryclass := STD.Str.ToUpperCase(Std.Str.CleanSpaces(_industryclass));
		END;
		
		return in_mod;
	end;	


// =====================================================================================
// This is a copy of the above, with the only exception of shared batch interface
// being inherited from doxie.IDataAccess. All new batch services should be using 
// this interface, all the existing ones will be gradually switched to it as well.
// (Upon completion we may want to rename "batch" back to the "BatchParams", if desired.)
// =====================================================================================

  EXPORT BatchParamsV2 := INTERFACE (doxie.IDataAccess)
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
  EXPORT getBatchParamsV2() := FUNCTION
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
    in_mod := MODULE(PROJECT (mod_access, BatchParamsV2, OPT))
      EXPORT unsigned2 PenaltThreshold   := $.Constants.Defaults.PenaltThreshold     : stored('PenaltThreshold');
      EXPORT unsigned8 MaxResults        := $.Constants.Defaults.MaxResults          : stored('MaxResults');
      EXPORT unsigned8 MaxResultsPerAcct := $.Constants.Defaults.MaxResultsPerAcctno : stored('Max_Results_Per_Acct');
      EXPORT boolean   ReturnCurrentOnly := FALSE                                  : stored('Return_Current_Only');
      EXPORT boolean   RunDeepDive       := FALSE                                  : stored('Run_Deep_Dive');
      EXPORT boolean   ReturnDetailedRoyalties := FALSE                            : stored('ReturnDetailedRoyalties');
    END;

    RETURN in_mod;
  END;

  // Temporarily, to assist the move to the new interface:
  // a service using IDataAccess compatible interface can easily convert it
  // to call provedures expecting older 'BatchParam' module.
  EXPORT ConvertToLegacy(mod) := FUNCTIONMACRO
    IMPORT Gateway;
    local batch_mod := MODULE (BatchShare.IParam.BatchParams)
      //data-access part:
      EXPORT unsigned1 GLBPurpose := mod.glb;
      EXPORT unsigned1 DPPAPurpose := mod.dppa;
      EXPORT string DataPermissionMask := mod.DataRestrictionMask;
      EXPORT string DataRestrictionMask := mod.DataPermissionMask;
      EXPORT string5 IndustryClass := mod.industry_class;
      EXPORT string32 ApplicationType := mod.application_type;
      EXPORT boolean IncludeMinors := mod.show_minors;
      EXPORT string6 ssn_mask := mod.ssn_mask;
      EXPORT boolean mask_dl := mod.dl_mask = 1;
      EXPORT unsigned1 dob_mask := mod.dob_mask;
      //batch part:
      EXPORT unsigned2 PenaltThreshold      := mod.PenaltThreshold;
      EXPORT unsigned8 MaxResults           := mod.MaxResults;
      EXPORT unsigned8 MaxResultsPerAcct    := mod.MaxResultsPerAcct;
      EXPORT boolean   ReturnCurrentOnly    := mod.ReturnCurrentOnly;
      EXPORT boolean   RunDeepDive          := mod.RunDeepDive;
      EXPORT boolean   ReturnDetailedRoyalties := mod.ReturnDetailedRoyalties;
      EXPORT DATASET (Gateway.Layouts.Config) gateways := mod.gateways;
    END;
		RETURN batch_mod;
	ENDMACRO;

END;
