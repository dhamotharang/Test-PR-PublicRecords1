IMPORT tools, _control, STD, NeustarWireless;

EXPORT SprayFile(string version) :=
FUNCTION
		
	LandingZone := IF(_control.thisenvironment.name='Dataland', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata11);
	FileDirectory := '/data/hds_2/neustar_wireless/data/';
	FileToSpray := 'Wireless2_' + version + '.txt';

	spry_raw:=DATASET([

			{pServerIP															// SourceIP
			,pDirectory															// SourceDirectory
			,'Wireless2_*.txt'						 					// directory_filter
			,0																			// record_size
			,Anchor.thor_cluster+'in::email::Anchor::@version@'	// Thor_filename_template
			,[{Anchor.thor_cluster+'in::email::Anchor'}]				// dSuperfilenames
			,pGroupName															// fun_Groupname
			,pVersionDate														// FileDate
			,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 														// file_type
			,''																			// sourceRowTagXML
			,																				// sourceMaxRecordSize
			,'|'																		// sourceCsvSeparate
			,'\\n' 																	// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,TRUE 																	// compress
			,TRUE 																	// ShouldOverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE 																	// ShouldSprayMultipleFilesAs1
			}
	], tools.Layout_Sprays.Info);
	
RETURN tools.fun_Spray
				( 
					spry_raw			// pSprayInformation
					, 						// pSprayInfoSuperfile
					,							// pSprayInfoLogicalfile
					,pOverwrite 	// pOverwrite
					,							// pReplicate
					,TRUE					// pAddCounter
					,pIsTesting		// pIsTesting
					,							// pEmailNotificationList
					,'Neustar Wireless Phones Spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
				);

END;

