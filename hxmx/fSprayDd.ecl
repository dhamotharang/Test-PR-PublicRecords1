
IMPORT lib_fileservices,_control,lib_stringlib,Versioncontrol,emdeon, ut, tools, std;

EXPORT fSprayDd(

	STRING		pVersion              = '',
	STRING    pHxOrMx               = 'hx',
	BOOLEAN   pUseProd              = FALSE,
	STRING		pServerIP							= _control.IPAddress.bctlpedata10,
	STRING		pRawfile							= '*.txt',
	STRING		pDirectory						= '/data/run_enclarity/hxmx/input/',
	STRING		pGroupName						= IF((tools._Constants.IsDataland),'thor40_241','thor400_44'),
	BOOLEAN		pIsTesting						= FALSE,
	BOOLEAN		pOverwrite						= TRUE,
	STRING		pNameOutput						= 'Symphony Claims Source Files Info Spray Report'

) := FUNCTION

	upperX := STD.Str.ToUpperCase(pHxOrMx);
	lowerX := STD.Str.ToLowerCase(pHxOrMx);
	
	remoteDateFolder := pVersion[1..4] + '_' + pVersion[5..6];
	
	thorFolder := MAP(lowerX = 'hx' => hxmx.Filenames(pVersion,pUseProd).hx_lInputTemplate, 
										hxmx.Filenames(pVersion,pUseProd).mx_lInputTemplate);

	fileList := NOTHOR(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata10, pDirectory + remoteDateFolder + '/', '*' + upperX + pRawfile)):INDEPENDENT;
			// (name[30..31] IN ['29','30','31'])

	filesSorted := SORT(fileList,name);

	d := PROJECT(filesSorted
							,TRANSFORM(VersionControl.Layout_Sprays.Info
								,SELF :=
										ROW(
													{
													pServerIP
													,pDirectory + remoteDateFolder          
													,LEFT.name                           
													,0                                                     
													,'~thor400_data::in::hxmx::' + LEFT.name[24..31] + '_' + lowerX + '_claims'  
													,[{thorFolder}]    
													,pGroupName
													,remoteDateFolder
													,'[0-9]{8}'
													,'VARIABLE'
													,''
													,10000
													,'|'
													}
													, VersionControl.Layout_Sprays.Info);
							));

	sprayFiles := VersionControl.fSprayInputFiles(d);

	// outputWork := IF (COUNT(fileList) > 0,
			// sprayFiles
			// ,OUTPUT('No Files To Spray',NAMED('No_Files_To_Spray'))
	// );

	RETURN sprayFiles;

END;