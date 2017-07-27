import Versioncontrol, _control;

export fSprayFiles(

	 string			pversion
	,string			pDirectory					= '/prod_data_build_10/production_data/business_headers/martindale_hubbell/data'
	,string			pServerIP						= _control.IPAddress.edata10
	,string			pFilename						= '2*xml'
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
	 	,0                                              //record_size							:= 0					;
	 	,Filenames(pversion).input.template				      //Thor_filename_template								;
	 	,[{Filenames(pversion).input.sprayed}]     			//dSuperfilenames												;
	 	,pGroupName                                     //GroupName								:= VersionControl.Groupname();
		,''                                             //FileDate							:= ''						;
		,'[0-9]{8}'                                     //date_regex						:= '[0-9]{8}'		;
		,'XML'                                     			//file_type							:= 'FIXED'			;  			// CAN BE 'VARIABLE', OR 'XML'
		,'DOCUMENT'                                     //sourceRowTagXML				:= ''						;
		,pMaxRecordSize                      						//sourceMaxRecordSize		:= 8192					;
	 	}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Dataset().Name + ' ' + pversion);

end;
