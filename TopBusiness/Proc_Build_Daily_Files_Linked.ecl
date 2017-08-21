import tools;

export Proc_Build_Daily_Files_Linked(Interface_AsMasters.Linked.Base in_masters,string version) := function
	
	tools.mac_WriteFile(FilenamesDaily(version).Bankruptcy.Main.Linked.New,in_masters.As_Bankruptcy_Master,Build_Base_Bankruptcy_Main_File,pShouldExport := false);
	tools.mac_WriteFile(FilenamesDaily(version).Bankruptcy.Party.New,in_masters.As_Bankruptcy_Master_Party,Build_Base_Bankruptcy_Party_File,pShouldExport := false);

	return
		if(tools.fun_IsValidVersion(version)
			,sequential(
				parallel(
					Build_Base_Bankruptcy_Main_File,
					Build_Base_Bankruptcy_Party_File),
				PromoteDaily(version).buildfiles.New2Built
			)		
			,output('No Valid version parameter passed, skipping BRM.Proc_Build_Daily_Files_Linked atribute')
		);

end;
