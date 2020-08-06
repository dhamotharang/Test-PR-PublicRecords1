IMPORT  _control, std, tools;

EXPORT Spray(
	 STRING		pversion			    = ''
	,STRING		pServerIP			    = _control.IPAddress.bctlpedata11
	,STRING		pDirectory		    = '/data/hds_180/Equifax_Business_Data' + pversion[1..8]
	,STRING		pFileName			    = ''	
	,STRING   pFileNameContacts = ''
	,STRING		pGroupName		    = STD.System.Thorlib.Group( )	
	,BOOLEAN	pIsTesting		    = FALSE
	,BOOLEAN	pOverwrite		    = FALSE
	,BOOLEAN	pExistSprayed	    = _Flags.ExistCurrentSprayed
	,BOOLEAN	pContactsExistSprayed = _Flags.ExistContactsCurrentSprayed
	,STRING		pNameOutput		    = _Constants().Name + ' Spray Info'	
  ) := FUNCTION
	
	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFileName                               // FILENAME
	 	,0                                       // RECORD SIZE
	 	,Filenames(pversion).Input.Companies.logical       // THOR FILENAME TEMPLATE
	 	,[ {Filenames().Input.Companies.sprayed}	]        // SUPERFILE NAME
	 	,pGroupName                              // GROUPNAME
		,''                                      // FILEDATE
		,'[0-9]{8}'                              // DATE REGULAR EXPRESSION
		,'VARIABLE'                              // CAN BE 'VARIABLE', OR 'XML'
		,''                                      // SOURCE TAG IF DATA IS XML
		,_Constants().max_record_size            // MAX RECORD SIZE
	 	}], tools.Layout_Sprays.Info);
	ContactFilesToSpray := DATASET([
			{pServerIP
			,pDirectory
			,pFilenameContacts
			,0
			,Filenames(pversion).input.Contacts.logical
			,[ {Filenames().input.Contacts.sprayed	}	]
			,pGroupName
			,''
			,'[0-9]{8}'
			,'VARIABLE'
			,''
			,_Constants().max_record_size
			,'|,|","|'
			,'\\n,\\r\\n,\\r'
			,'"'
	 	}
	], tools.Layout_Sprays.Info);
		
	RETURN parallel(
						IF( pDirectory != '' AND NOT pExistSprayed,
						  tools.fun_Spray(FilesToSpray,,,pOverwrite,,FALSE,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput)),
						IF( pDirectory != '' AND NOT pContactsExistSprayed,	
						  tools.fun_Spray(ContactFilesToSpray,,,pOverwrite,,FALSE,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput))
						)
						;

END;
														
						


