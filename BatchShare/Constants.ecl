import AutoStandardI;

export Constants := module

	export Defaults := module
		export unsigned1	GLBPurpose 						:= 8;
		export unsigned1	DPPAPurpose 					:= 0;
		export string32		ApplicationType 			:= '';
		export unsigned2	PenaltThreshold 			:= 20;
		export unsigned8 	MaxResults 						:= 2000;
		export unsigned8 	MaxResultsPerAcctno 	:= 20;
    export string DataRestrictionMask := '1    0'; // same (wrong) way as defined in AutoStandardI/GlobalModule;
    export string DataPermissionMask  := AutoStandardI.Constants.DataPermissionMask_default;
    export string6 SSNMask := 'NONE';
    export unsigned didScoreThreshold := 80;
	end;

	export Limits := module
		export integer MAX_JOIN_LIMIT := 10000;
	end;
	
	export Valid_Min_Cri := ENUM(UNSIGNED1,
	                             DID=1
															,DID_OR_Name_Address=2
															,DID_OR_Name_WITH_DOB_OR_SSN=3
															,DID_OR_Name_Address_WITH_DOB_OR_SSN=4
															);
															
	export UNSIGNED1 ValidInput := 0;
	
	//the services below are batch services that don't have the word 'batch' in their name.
	//all new batch services should mention 'batch' in their name
	//**ALL LOWERCASE
	export SET OF STRING SET_BatchServices_named_without_batch :=
											['censusbureau.censusbureau_phone_service',
											 'clickdata.clickdata_bests_service',
											 'enhancedcampaign.service_campaignanalyzer', //in the Alpharetta repository
											 'iss_core.service_iss']; //in the Alpharetta repository

end;	