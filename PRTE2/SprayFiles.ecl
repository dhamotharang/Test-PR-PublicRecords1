import lib_fileservices,tools, std;

EXPORT SprayFiles := module;

export Clear_Input_Superfiles(string pLogicalname, string pdataset_name) :=	function	
		/* 
			Removes the filename from all the superfiles the file is attached to.
		*/
		all_subfilenames := DATASET([{prte2._Dataset().thor_cluster_files + 'in::' + pdataset_name + '::@version@' + '::' + pLogicalname}], Tools.Layout_Names);
		;
		
		return nothor(Tools.fun_ClearfilesFromSupers(all_subfilenames, false));
	end; //end clear-input_superfiles


export Spray_Raw_Data(  
											 string		pFilename			= '' //group's file name on linux box
											,string		pLogicalname	= '' //group's file name on thor
											,string   pDataset_name = ''
											,boolean	pShouldSprayMultipleFilesAs1	= false
											,string		pServerIP			= prte2._Constants().sServerIP
											,string		pDirectory		= prte2._Constants().sDirectory
											,string		pFiletype			= '.txt'
											,string		pGroupName		= tools.fun_Clustername_DFU()		
											,boolean	pIsTesting		= false
											,boolean	pOverwrite		= false		
										) := function		
												
		sFileMask					:= '*'+pFilename+'*':STORED(pFilename + '-Filename');
    
		
		dFilesToProcess		:= FileServices.RemoteDirectory(prte2._Constants().sServerIP,prte2._Constants().sDirectory,sFileMask);
    output(dFilesToProcess);

		pversion := IF(regexfind('[[:digit:]]{8}',dFilesToProcess[1].name),regexfind('[[:digit:]]{8}',dFilesToProcess[1].name,0),(STRING)Std.Date.Today());
		
		sLogicalFilename	:= prte2.Filenames(pLogicalname,pversion, pdataset_name).input.logical;
		output(sLogicalFilename);
    		
		bAlreadySprayed		:= if(FileServices.FileExists(sLogicalFilename),true,false):STORED(pFilename +'-CK if AlreadySprayed');
    output(bAlreadySprayed);
		
    // clear_superfile := Clear_Input_Superfiles(pLogicalname, pdataset_name);
   
		if( not bAlreadySprayed,
				prte2.Spray(pversion,sFileMask,pLogicalname,pdataset_name,pShouldSprayMultipleFilesAs1,pServerIP,pDirectory,pFiletype,pGroupName,pIsTesting,pOverwrite,bAlreadySprayed),
					output('File: '+sLogicalFilename+' already exists on THOR; File: '+sLogicalFilename+' not re-sprayed.')
			);

		return if(nothor(FileServices.FileExists(sLogicalFilename)),sLogicalFilename,'');	
		
	end; //end Spray_Raw_Data
	
end;	
	
