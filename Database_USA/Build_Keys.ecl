import doxie, Tools, BIPV2, dx_Database_USA, RoxieKeyBuild, dops, DOPSGrowthCheck;

export Build_Keys(string pversion) :=
module

 		// RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Database_USA.Key_LinkIds.Key
																							 // ,Database_USA.Files().Base.Built
																							 // ,dx_Database_USA.Names().LinkIds.QA
																							 // ,dx_Database_USA.Names(pversion,false).LinkIds.New
																							 // ,BuildLinkIdsKey);  
																							 
 		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Database_USA.Key_did
																							 ,Database_USA.Files().Base.Built(did > 0)
																							 ,dx_Database_USA.Names().did.QA
																							 ,dx_Database_USA.Names(pversion,false).did.New
																							 ,BuildDidKey);  				 
																			
																							 
		//DOPSGrowthCheck 
		GetDops:=dops.GetDeployedDatasets('P','B','N');
		OnlyDatabase_USA:=GetDops(datasetname='DatabaseUSAKeys');
			
		father_pversion := OnlyDatabase_USA[1].buildversion;
		filename        := '~thor_data400::key::Database_USA::'+pversion+'::did';
		father_filename := '~thor_data400::key::Database_USA::'+father_pversion+'::did';
		set of string key_Database_USA_InputSet:=['did'];
		DeltaCommands:=sequential(
			DOPSGrowthCheck.CalculateStats('DatabaseUSAKeys','dx_Database_USA.Key_did','key_Database_USA',filename,'did','record_sid','','','','',pversion,father_pversion),
			DOPSGrowthCheck.DeltaCommand(filename,father_filename,'DatabaseUSAKeys','key_Database_USA','dx_Database_USA.Key_did','record_sid',pversion,father_pversion,key_Database_USA_InputSet),
			DOPSGrowthCheck.ChangesByField(filename,father_filename,'DatabaseUSAKeys','key_Database_USA','dx_Database_USA.Key_did','record_sid','',pversion,father_pversion),
			DopsGrowthCheck.PersistenceCheck(filename,father_filename,'DatabaseUSAKeys','key_Database_USA','dx_Database_USA.Key_did','record_sid',key_Database_USA_InputSet,key_Database_USA_InputSet,pversion,father_pversion),
			);

		export full_build :=
	
			sequential(
									//Commenting out LinkIDkey logic. This key will be released later. 
									// BuildLinkIdsKey
									// ,
									BuildDidKey
									,Promote(pversion).BuildFiles.New2Built
									//,DeltaCommands  //Commented out because it accesses DOPs but the Database_USAKey package is not in DOPs yet.
								);
		
		export All :=
			if(tools.fun_IsValidVersion(pversion)
				,full_build
				,output('No Valid version parameter passed, skipping Database_USA.Build_Keys atribute')
				);

end;  