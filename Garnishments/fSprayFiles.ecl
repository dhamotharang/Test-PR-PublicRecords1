import tools, _control;

export fSprayFiles(

	 string			pversion
	,string			pDirectory					= '/data/prod_data_build_10/production_data/business_headers/garnishments/'
	,string			pServerIP						= _control.IPAddress.edata11
	,string			pFilename						= '*ADD'
	,string			pGroupName					= _dataset().groupname																		
	,boolean		pIsTesting					= false
	,boolean		pOverwrite					= false		

) :=
function

	FilesToSpray := DATASET([

	 	{pServerIP																			//SourceIP															;
	 	,pDirectory                                     //SourceDirectory												;
	 	,pFilename                                      //directory_filter				:= '*'				;
	 	,sizeof(layouts.input.sprayed)                  //record_size							:= 0					;
	 	,Filenames(pversion).input.logical				      //Thor_filename_template								;
	 	,[{Filenames(pversion).input.sprayed}]     			//dSuperfilenames												;
	 	,pGroupName                                     //GroupName								:= ;
	 	}

	], tools.Layout_Sprays.Info);

	return tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Dataset().Name + ' ' + pversion);

end;
