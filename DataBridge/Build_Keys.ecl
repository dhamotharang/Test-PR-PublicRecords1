import doxie, Tools, BIPV2, dx_DataBridge, RoxieKeyBuild, dops, DOPSGrowthCheck;

export Build_Keys(string pversion) :=
module

 		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_DataBridge.Key_LinkIds.Key
																							 ,DataBridge.Files().Base.Built
																							 ,dx_DataBridge.keynames().LinkIds.QA
																							 ,dx_DataBridge.keynames(pversion,false).LinkIds.New
																							 ,BuildLinkIdsKey);  
																							 
		 //DOPSGrowthCheck 
		 GetDops:=dops.GetDeployedDatasets('P','B','F');
	 	 OnlyDataBridge:=GetDops(datasetname='DataBridgeKeys');
			
		 father_pversion := OnlyDataBridge[1].buildversion;
		 filename        := '~thor_data400::key::databridge::'+pversion+'::linkids';
		 father_filename := '~thor_data400::key::databridge::'+father_pversion+'::linkids';
		 set of string key_DataBridge_InputSet:=['ultid','orgid','seleid','proxid','powid','empid','dotid'];
		 DeltaCommands:=sequential(
			DOPSGrowthCheck.CalculateStats('DataBridgeKeys','dx_DataBridge.Key_LinkIds.Key','key_DataBridge',filename,'did','record_sid','','','','',pversion,father_pversion),
			DOPSGrowthCheck.DeltaCommand(filename,father_filename,'DataBridgeKeys','key_DataBridge','dx_DataBridge.Key_LinkIds.Key','record_sid',pversion,father_pversion,key_DataBridge_InputSet),
			DOPSGrowthCheck.ChangesByField(filename,father_filename,'DataBridgeKeys','key_DataBridge','dx_DataBridge.Key_LinkIds.Key','record_sid','',pversion,father_pversion),
			DopsGrowthCheck.PersistenceCheck(filename,father_filename,'DataBridgeKeys','key_DataBridge','dx_DataBridge.Key_LinkIds.Key','record_sid',key_DataBridge_InputSet,key_DataBridge_InputSet,pversion,father_pversion),
			);

	export full_build :=
	
	sequential(
	    BuildLinkIdsKey
		 ,Promote(pversion).BuildFiles.New2Built
  	 //,DeltaCommands  //Commented out because it accesses DOPs but the DataBridgeKey package is not in DOPs yet.
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping DataBridge.Build_Keys atribute')
	);

end;