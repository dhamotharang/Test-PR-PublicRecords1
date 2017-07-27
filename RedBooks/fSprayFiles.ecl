import Versioncontrol, RedBooks, _control;
export fSprayFiles ( STRING pVendorFileType
                    ,STRING pServerIP		= _control.IPAddress.edata14
	                  ,STRING pDirectory		= '' 
	                  ,STRING pFilename		
	                  ,STRING pversion 		= ''
	                  ,STRING pGroupName		= RedBooks._dataset.groupname) :=
FUNCTION

	SHARED INTEGER RecordLength		:= 350;//sizeof(RedBooks.Layouts.Pre_Standardize.Layout_Combined); 

  FilesToSpray := DATASET([
	 	{pServerIP    
	 	,pDirectory  //SourceDirectory
	 	,pFilename   //directory_filter
	 	,RecordLength // record_size
	    ,_Dataset.thor_cluster_Files +'in::RedBooks::' + pVersion + '::' + pVendorFileType
	  ,[{_Dataset.thor_cluster_Files +'in::RedBooks::Sprayed::' + pVendorFileType}] 
	 //RedBooks.Filenames(pversion).input.new(pversion) //Thor_filename_template
	 //	,[{RedBooks.Filenames(pversion).input.pVendorFileType.sprayed}] //dSuperfilenames	
	 	,pGroupName 
		,''
		,''
		,'FIXED'
		,''
		,8192
		, ''
	 	}

	], VersionControl.Layout_Sprays.Info);

	RETURN VersionControl.fSprayInputFiles(FilesToSpray,,,true,,,,,RedBooks._Dataset.Name + ' ' + pVendorFileType);

END;