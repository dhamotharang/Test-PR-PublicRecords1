import Versioncontrol, _control;

export fSprayFiles(

	 string			pversion
	,string			pDirectory					= '/data/prod_data_build_10/production_data/business_headers/one_click_data/data/'
	,string			pServerIP						= _control.IPAddress.bctlpedata11
	,string			pFilename						= '*csv'
	,string			pGroupName					= _dataset().groupname																		
	,boolean		pIsTesting					= false
	,boolean		pOverwrite					= false		
	,unsigned8	pMaxRecordSize			= _Dataset().max_record_size

) :=
function

	FilesToSpray := DATASET([

	 	{pServerIP																			//SourceIP															;
	 	,pDirectory                                     //SourceDirectory												;
	 	,pFilename                                      //directory_filter				:= '*'				;
	 	,0                 															//record_size							:= 0					;
	 	,Filenames().input.template				     					//Thor_filename_template								;
	 	,[{Filenames(pversion).input.sprayed}]     			//dSuperfilenames												;
	 	,pGroupName                                     //GroupName								:= VersionControl.Groupname();
		,''
		,'[0-9]{8}'		
		,'VARIABLE'
	 	}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Dataset().Name + ' ' + pversion);

end;