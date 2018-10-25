IMPORT lib_fileservices,_control,lib_stringlib,Versioncontrol,emdeon, ut, tools;

EXPORT fSprayDd(

	STRING		pVersion              = '',
	BOOLEAN   pUseProd              = FALSE,
	//STRING		pServerIP							= _control.IPAddress.bctlpedata10,
	STRING		pServerIP							= 'bctlpedata10.risk.regn.net',
	STRING		pRawfile							= '*.dat',
	STRING		pDirectory						= '/data/run_enclarity/emdeon/input/',
	STRING		pGroupName						= IF((tools._Constants.IsDataland),'thor40_241','thor400_44'),
	BOOLEAN		pIsTesting						= FALSE,
	BOOLEAN		pOverwrite						= TRUE,
	STRING		pNameOutput						= 'Emdeon Claims Source Files Info Spray Report'

) := FUNCTION

	remoteDir := pVersion[1..4] + '_' + pVersion[5..6];

	//fileList := NOTHOR(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata10, pDirectory + remoteDir + '/', pRawfile)) :INDEPENDENT;
	fileList := NOTHOR(FileServices.RemoteDirectory(pServerIP, pDirectory + remoteDir + '/', pRawfile)) :INDEPENDENT;
		//(name[7..8] IN ['01']) :INDEPENDENT;

	filesSorted := SORT(fileList,name);

	d := PROJECT(filesSorted
							,TRANSFORM(VersionControl.Layout_Sprays.Info
								,SELF :=
										ROW(
													{
													pServerIP
													,pDirectory + LEFT.name[1..4] + '_' + LEFT.name[5..6]          
													,LEFT.name                           
													,0                                                     
													,'~enclarity_emdeon::in::claims::' + LEFT.name[1..8]
													,[{Emdeon.Filenames(pVersion,pUseProd).claims_lInputPreTemplate}]    
													,pGroupName
													,pVersion
													,'[0-9]{8}'
													,'VARIABLE'
													,''
													,10000
													,'|'
													}
													, VersionControl.Layout_Sprays.Info);
							));

	sprayFiles := VersionControl.fSprayInputFiles(d);

	outputWork := IF (EXISTS(fileList),
			sprayFiles
			,OUTPUT('No Files To Spray',NAMED('No_Files_To_Spray'))
	);

	RETURN outputWork;

END;