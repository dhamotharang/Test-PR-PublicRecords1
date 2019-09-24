import doxie, Tools, BIPV2, dx_Database_USA, RoxieKeyBuild, dops, DOPSGrowthCheck;

export Build_Keys(string pversion) :=
module

 		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Database_USA.Key_LinkIds.Key
																							 ,Database_USA.Files().Base.Built
																							 ,dx_Database_USA.Names().LinkIds.QA
																							 ,dx_Database_USA.Names(pversion,false).LinkIds.New
																							 ,BuildLinkIdsKey);  
																							 
		 //DOPSGrowthCheck 
		 GetDops:=dops.GetDeployedDatasets('P','B','N');
	 	 OnlyDatabase_USA:=GetDops(datasetname='DatabaseUSAKeys');
			
		 father_pversion := OnlyDatabase_USA[1].buildversion;
		 filename        := '~thor_data400::key::Database_USA::'+pversion+'::linkids';
		 father_filename := '~thor_data400::key::Database_USA::'+father_pversion+'::linkids';
		 set of string key_Database_USA_InputSet:=['ultid','orgid','seleid','proxid','powid','empid','dotid'];
		 DeltaCommands:=sequential(
			DOPSGrowthCheck.CalculateStats('DatabaseUSAKeys','dx_Database_USA.Key_LinkIds.Key','key_Database_USA',filename,'did','record_sid','','','','',pversion,father_pversion),
			DOPSGrowthCheck.DeltaCommand(filename,father_filename,'DatabaseUSAKeys','key_Database_USA','dx_Database_USA.Key_LinkIds.Key','record_sid',pversion,father_pversion,key_Database_USA_InputSet),
			DOPSGrowthCheck.ChangesByField(filename,father_filename,'DatabaseUSAKeys','key_Database_USA','dx_Database_USA.Key_LinkIds.Key','record_sid','',pversion,father_pversion),
			DopsGrowthCheck.PersistenceCheck(filename,father_filename,'DatabaseUSAKeys','key_Database_USA','dx_Database_USA.Key_LinkIds.Key','record_sid',key_Database_USA_InputSet,key_Database_USA_InputSet,pversion,father_pversion),
			);

	export full_build :=
	
	sequential(
	    BuildLinkIdsKey
		 ,Promote(pversion).BuildFiles.New2Built
  	 //,DeltaCommands  //Commented out because it accesses DOPs but the Database_USAKey package is not in DOPs yet.
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Database_USA.Build_Keys atribute')
	);

end;  