import TopBusiness_External,tools;

export Proc_Build_Files_Linkage(Interface_AsMasters.Linkage.Base in_masters,string version) := function
	
	tools.mac_WriteFile(Filenames(version).Match.Linked.New,in_masters.As_Match_Master,Build_Base_Match_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Linking.Linked.New,in_masters.As_Linking_Master,Build_Base_Linking_File,pShouldExport := false);

	return
		if(tools.fun_IsValidVersion(version)
			,sequential(
				TopBusiness_External.Proc_Build_Files_External(in_masters.As_Linking_Master,version),
				parallel(
					Build_Base_Match_File,
					Build_Base_Linking_File),
				Promote(version).buildfiles.New2Built
			)		
			,output('No Valid version parameter passed, skipping BRM.Proc_Build_Files_Linkage atribute')
		);

end;
