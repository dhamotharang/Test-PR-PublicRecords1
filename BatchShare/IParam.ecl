import suppress, Gateway, STD;

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
		
end;