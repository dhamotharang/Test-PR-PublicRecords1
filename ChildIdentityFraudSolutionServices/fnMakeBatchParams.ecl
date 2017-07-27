import ChildIdentityFraudSolutionServices;
EXPORT fnMakeBatchParams() := functionmacro

	BatchParams := module(ChildIdentityFraudSolutionServices.IParam.BatchParams)
		export string DataPermissionMask  := glbMod.DataPermissionMask;
		export string DataRestrictionMask := glbMod.DataRestrictionMask;
		export boolean ignoreFares := glbMod.ignoreFares;
		export boolean ignoreFidelity:= false;
		export boolean AllowAll := false;
		export boolean AllowGLB := false;
		export boolean AllowDPPA := false;
		export unsigned1 GLBPurpose := glbMod.GLBPurpose;
		export unsigned1 DPPAPurpose := glbMod.DPPAPurpose;
		export boolean IncludeMinors := TRUE; //glbMod.IncludeMinors;							
		export string32 	ApplicationType 		:= glbMod.ApplicationType;
		export unsigned2	PenaltThreshold			:= 20;
		export unsigned8 	MaxResults 					:= glbMod.MaxResults;	
		export boolean 	 	ReturnDetailedRoyalties := false;
		export unsigned2 TaxYearsToIgnore := ChildIdentityFraudSolutionServices.Constants.Defaults.TaxYearsToIgnore; //2:STORED('TaxYearsToIgnore'); 
		export unsigned2 ScoreThreshold := ChildIdentityFraudSolutionServices.Constants.ScoreThreshold; //glbMod.ScoreThreshold : STORED('ScoreThreshold');
		export string RealTimePermissibleUse := '':STORED('RealTimePermissibleUse') ;
		export dataset (Gateway.Layouts.Config) gateways :=  Gateway.Configuration.Get(); // dataset ([], Gateway.Layouts.Config);
	end;
	return BatchParams;				
endmacro;