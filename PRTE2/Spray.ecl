IMPORT $, STD, tools;

EXPORT Spray(
	STRING  pversion  = '',    //filedate from pFilename
	STRING  pFilename = '',    //name on linux box
	STRING  pLogicalname = '', //name on thor
	STRING  pDatasetName = '',
	BOOLEAN pShouldSprayMultipleFilesAs1 = false,
	STRING  pServerIP = prte2._Constants().sServerIP,
	STRING  pDirectory = prte2._Constants().sDirectory,
	STRING  pFiletype = '.txt',
	//STRING  pGroupName = tools.fun_Clustername_DFU(),
	STRING  pGroupName = thorlib.group(),
	BOOLEAN pIsTesting = false,
	BOOLEAN pOverwrite = false,
	BOOLEAN pExistSprayed = prte2.Flags(pLogicalname).ExistCurrentSprayed,
	STRING  pNameOutput = prte2._Dataset().Name + '::' + pLogicalname + ' Spray Info',
	BOOLEAN pShouldClearSuperfileFirst = true
) := FUNCTION

	FilesToSpray := DATASET(
		[
			{
				pServerIP,
				pDirectory,
				IF(STD.STR.CONTAINS(pFilename, pFiletype, TRUE),pFilename,pFilename + pFiletype),
				0,
				prte2.Filenames(pLogicalname,pversion,pDatasetName).input.template,
				[ {prte2.Filenames(pLogicalname,,pDatasetName).input.root} ],
				pGroupName,
				'',
				'[0-9]{8}',
				'VARIABLE',
				'',
				prte2._Dataset().max_record_size,
				'\t'
			}
		], 
	tools.Layout_Sprays.Info);

	RETURN IF( 
		NOT pExistSprayed, tools.fun_Spray(
			FilesToSpray,
			,
			,
			pOverwrite,
			,
			false,
			pIsTesting,
			,
			pFilename + ' ' + pversion,
			pNameOutput,
			pShouldClearSuperfileFirst,
			,
			,
			pShouldSprayMultipleFilesAs1), 
		OUTPUT('File: '+pExistSprayed+' already exists on in superfile.')
	);
END;