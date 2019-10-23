IMPORT lib_fileservices,tools, std;

EXPORT SprayFiles := module;

	EXPORT Clear_Input_Superfiles(string pLogicalname, string pdataset_name) := function
		all_subfilenames := DATASET([{prte2._Dataset().thor_cluster_files + 'in::' + pdataset_name + '::@version@' + '::' + pLogicalname}], Tools.Layout_Names);

		RETURN NOTHOR(Tools.fun_ClearfilesFromSupers(all_subfilenames, false));
	END;

	EXPORT Spray_Raw_Data( 
		STRING pFilename = '',
		STRING pLogicalname = '',
		STRING pDataset_name = '',
		BOOLEAN pShouldSprayMultipleFilesAs1 = false,
		STRING pServerIP = prte2._Constants().sServerIP,
		STRING pDirectory = prte2._Constants().sDirectory,
		STRING pFiletype = '.txt',
		//STRING pGroupName = tools.fun_Clustername_DFU(),
		STRING pGroupName = thorlib.group(),
		BOOLEAN pIsTesting = false,
		BOOLEAN pOverwrite = false
	) := FUNCTION

		sFileMask := IF(REGEXFIND('prte__\\w+__\\w+_(_\\d{1,}__)?\\d{8}(\\w{1})?\\.txt',pFilename),pFilename,'*'+pFilename+'*'):STORED(pFilename + '-Filename');
		//sFileMask := IF(REGEXFIND('prte__\\w+__\\w+__\\d{1,}__\\d{8}\\.txt',pFilename),pFilename,'prte__'+pFilename+'__*__[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].txt'):STORED(pFilename + '-Filename');
		dFilesToProcess := STD.File.RemoteDirectory(pServerIP,pDirectory,sFileMask);
		OUTPUT(dFilesToProcess);

		pversion := IF(REGEXFIND('\\d{8}',dFilesToProcess[1].name),regexfind('\\d{8}',dFilesToProcess[1].name,0),(STRING)Std.Date.Today());

		sLogicalFilename := prte2.Filenames(pLogicalname,pversion, pdataset_name).input.logical;
		OUTPUT(sLogicalFilename);

		bAlreadySprayed	:= if(FileServices.FileExists(sLogicalFilename),true,false):STORED(pFilename +'-CK if AlreadySprayed');
		OUTPUT(bAlreadySprayed);

		IF( NOT bAlreadySprayed,
			prte2.Spray(pversion,sFileMask,pLogicalname,pdataset_name,pShouldSprayMultipleFilesAs1,pServerIP,pDirectory,pFiletype,pGroupName,pIsTesting,pOverwrite,bAlreadySprayed),
			OUTPUT('File: '+sLogicalFilename+' already exists on THOR; File: '+sLogicalFilename+' not re-sprayed.')
		);

		RETURN IF(NOTHOR(FileServices.FileExists(sLogicalFilename)),sLogicalFilename,'');

	END;

END;