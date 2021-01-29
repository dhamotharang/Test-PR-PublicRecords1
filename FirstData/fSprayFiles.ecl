IMPORT FirstData, VersionControl, tools, STD;

srcCSVseparator := ',';
srcCSVterminator := '\\n,\\r\\n';
srcCSVquote := '"';


EXPORT fSprayFiles(
	STRING  pVersionDate = (STRING)STD.Date.Today(),
	STRING  pServer = Constants(pVersionDate).serverIP,
	STRING  pDir = Constants(pVersionDate).Directory + pVersionDate + '/',
	STRING  pFilename = '*csv',
	STRING  pContacts,
	STRING  pGroupName = _Dataset().pGroupname,
	BOOLEAN pIsTesting = FALSE,
	BOOLEAN pOverwrite = TRUE,
	STRING  pNameOutput = 'FirstData Spray Info'
) := FUNCTION

	/*
	 * SourceIP
	 * SourceDirectory
	 * directory_filter
	 * FirstData
	 * record_size
	 * Thor_filename_template
	 * dSuperfilenames
	 * fun_Groupname
	 * FileDate
	 * date_regex
	 * file_type
	 * sourceRowTagXML
	 * sourceMaxRecordSize
	 * sourceCsvSeparate
	 * sourceCsvTerminate
	 * sourceCsvQuote
	 * compress
	 * shouldoverwrite
	 * ShouldSprayZeroByteFiles
	 * ShouldSprayMultipleFilesAs1
	 */
	spry_raw:=DATASET([
		{
			pServer,
			pDir,
			'*csv',
			0,
			Filenames(pVersionDate).input.raw.new(pVersionDate),
			[ {Filenames(pVersionDate).input.raw.sprayed}],
			pGroupName,
			pVersionDate,
			'[0-9]{8}',
			'VARIABLE',
			'',
			_Dataset().pMaxRecordSize,
			srcCSVseparator,
			srcCSVterminator,
			srcCSVquote,
			TRUE,
			pOverwrite,
			FALSE,
			FALSE
		}
	], tools.Layout_Sprays.Info);

	/*
	 * pSprayInformation
	 * pSprayInfoSuperfile
	 * pSprayInfoLogicalfile
	 * pOverwrite
	 * pReplicate
	 * pAddCounter
	 * pIsTesting
	 * pEmailNotificationList
	 * pEmailSubjectDataset
	 * pOutputName
	 * pShouldClearSuperfileFirst
	 * pSplitEmails
	 * pShouldSprayZeroByteFiles
	 * pShouldSprayMultipleFilesAs1
	 */
	RETURN tools.fun_Spray ( 
		spry_raw,
		,
		,
		pOverwrite,
		,
		TRUE,
		pIsTesting,
		pContacts,
		'FirstData spray' + ' ' + pVersionDate,
		pNameOutput,
		TRUE,
		FALSE,
		FALSE,
		FALSE
	);

END;
