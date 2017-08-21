import Versioncontrol, _control;

export fSprayFiles(

	 string			pversion
	,string			pDirectory					= '/prod_data_build_13/eval_data/jprichard/'
	,string			pServerIP						= _control.IPAddress.edata10
	,string			pFilename						= '*d00'
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
	 	,sizeof(layouts.input.sprayed)                	//record_size							:= 0					;
	 	,Filenames(pversion).input.logical				      //Thor_filename_template								;
	 	,[{Filenames(pversion).input.sprayed}]     			//dSuperfilenames												;
	 	,pGroupName                                     //GroupName								:= VersionControl.Groupname();
		,''
		,'[0-9]{8}'		
	 	}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Dataset().Name + ' ' + pversion);

end;
