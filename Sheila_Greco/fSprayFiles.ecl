import Versioncontrol, _control;

export fSprayFiles(

	 string		pServerIP		= _control.IPAddress.bctlpedata10
	,string		pDirectory	= '/data/load01/sheila_greco/'
	,string		pFilename		= '*xml'
	,string		pversion
	,string		pGroupName	= _dataset.groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false																															

) :=
function

	FilesToSpray := DATASET([

	 	{
			 pServerIP
			,pDirectory
			,'*COM*xml'
			,0
			,Filenames().input.Companies.new(pversion)
			,[{Filenames().input.Companies.sprayed}]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Dataset.max_record_size
			,''
			,'\r\n'
			,''	
	 	}

	 	,{
			 pServerIP
			,pDirectory
			,'*CON*xml'
			,0
			,Filenames().input.Contacts.new(pversion)
			,[{Filenames().input.Contacts.sprayed}]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Dataset.max_record_size
			,''
			,'\r\n'
			,''	
	 	}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Dataset.Name + ' ' + pversion);

end;
