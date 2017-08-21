import _control,lib_fileservices,lib_stringlib,lib_thorlib,prte_csv,tools,versioncontrol;

export SprayFiles(string pversion 		= ''
								 ,string dataset_name = prte_csv._Dataset().name
								 )
:= module

	export Create_Input_Superfiles(string pname) :=	function
		/* 
			Creates an empty superfile; The false optional parameter indicates whether the sub-files 
      must be sequentiallynumbered; The last optional parameter is missing and defaults to false
			indicating that an error is posted if the superfile already exists.
		*/
		CreateInputSuper := apply(prte_csv.filenames(pname,,dataset_name).Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name));
		/* 
			Checks the existence of the superfile "sprayed"; if the superfile doesn't exist it CreateSuper is called
			(see above).
		*/								
		CreateInputSuperfileIfNotExist := if(NOT FileServices.SuperFileExists(prte_csv.filenames(pname,,dataset_name).input.sprayed),CreateInputSuper);
	
		return nothor(CreateInputSuperfileIfNotExist);
	end;


	export Clear_Input_Superfiles(string pname) :=	function	
		/* 
			Removes the filename from all the superfiles the file is attached to.
		*/
		all_subfilenames := DATASET([{prte_csv._Dataset().thor_cluster_files+'in::'+dataset_name+'::'+pname+'::'+pversion+'::data'}], Tools.Layout_Names);
		
		return nothor(Tools.fun_ClearfilesFromSupers(all_subfilenames, false));
	end;


	export Create_Base_Superfiles(string pname)	:=	function
		/* 
			Creates an empty superfile; The false optional parameter indicates whether the sub-files 
      must be sequentiallynumbered; The last optional parameter is missing and defaults to false
			indicating that an error is posted if the superfile already exists.
		*/
		CreateBaseSuper	 := nothor(apply(prte_csv.filenames(pname,,dataset_name).Base.dAll_filenames, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))));
		/* 
			Checks the existence of the superfile; if the superfile doesn't exist it CreateSuper is called
			(see above).
		*/								
		CreateBaseSuperfileIfNotExist := if(NOT FileServices.SuperFileExists(prte_csv.filenames(pname,,dataset_name).Base.qa),CreateBaseSuper);
		
		return nothor(CreateBaseSuperfileIfNotExist);		
	end;


	export Spray_Raw_Data( string		pFilename			= '' //group's file name on linux box
												,string		pLogicalname	= '' //group's file name on thor
												,string		pServerIP			= prte_csv._Constants().sServerIP
												,string		pDirectory		= prte_csv._Constants().sDirectory
												,string		pFiletype			= '.csv'
												,string		pGroupName		= prte_csv._Dataset().groupname																		
												,boolean	pIsTesting		= false
												,boolean	pOverwrite		= true		
												) := function		
												
		sFileMask					:= '*'+pFilename+'*':STORED(pFilename + '-Filename');

		dFilesToProcess		:= FileServices.RemoteDirectory(prte_csv._Constants().sServerIP,prte_csv._Constants().sDirectory,sFileMask);

		sLogicalFilename	:= prte_csv.Filenames(pLogicalname,pversion,dataset_name).input.logical;

		bAlreadySprayed		:= if(FileServices.FileExists(sLogicalFilename),true,false):STORED(pFilename +'-CK if AlreadySprayed');

		if(bAlreadySprayed,
			output('File: '+sLogicalFilename+' already exists on THOR; File: '+sLogicalFilename+' not re-sprayed.'),
			prte.Spray(pversion,sFileMask,pLogicalname,pServerIP,pDirectory,pFiletype,pGroupName,pIsTesting,pOverwrite,bAlreadySprayed,dataset_name)
			);
			
		return if(nothor(FileServices.FileExists(sLogicalFilename)),sLogicalFilename,'');	
		
	end; //end Spray_Raw_Data


	export Add_to_Superfiles(string pname)	:=	function
	  addSuper := sequential(
							FileServices.StartSuperFileTransaction(),
							FileServices.ClearSuperFile(prte_csv.Filenames(pname,,dataset_name).Input.Sprayed),
							FileServices.AddSuperFile(prte_csv.Filenames(pname,,dataset_name).Input.Sprayed,prte_csv.Filenames(pname,pversion,dataset_name).input.logical),
							FileServices.FinishSuperFiletransaction()
							);
		return addSuper;
	end;	//end Add_to_Superfiles
	
end;  //end SprayFiles
