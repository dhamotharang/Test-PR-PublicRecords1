IMPORT BKForeclosure, Property, STD;

/**
 * parameter: string: pVersion       : The version of the build.
 * parameter: string: pHostname      : The hostname on which the source data resides.
 * parameter: string: pSource        : The absolute path to the source data.
 * parameter: string: pGroup         : The name of the node group running the workunit
 * parameter: set   : setRefreshGlobs: A set of globs that will be used in a wild card spray
 * parameter: set   : setDeleteGlobs : A set of globs that will be used in a wild card spray
 * parameter: set   : setUpdateGlobs : A set of globs that will be used in a wild card spray
 */
EXPORT Spray_All(
	STRING  pVersion,
	STRING  pHostname,
	STRING  pSource,
	STRING  pGroup = STD.System.Thorlib.Group(),
	BOOLEAN pSpray = FALSE,
	STRING  pGlob = 'REOOut.txt', 
	SET OF  STRING setRefreshGlobs = [ '*_NOD_Orphan_Refresh_*.txt', '*_NOD_Refresh_*.txt', '*_REO_Orphan_Refresh_*.txt', '*_REO_Refresh_*.txt' ],
	SET OF  STRING setDeleteGlobs = [ 'NOD_Update_Delete_*.txt', 'REO_Update_Delete_*.txt' ],
	SET OF  STRING setUpdateGlobs = [ '*_NOD_Update_*.txt', '*_REO_Update_*.txt']
) := MODULE

	//Folder date is a day after version date
	SHARED version := STD.Date.AdjustDate((integer)pVersion,,,-1);
	SHARED maxRecordSize := 8192;

	//Clear all superfiles. Input files are large so previous logical input files need to be deleted each build
	Clear_Supers := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_nod_orphan'),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_reo_orphan'),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_nod'),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_reo'),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::Update_Nod'),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::Update_Reo'),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::delete_nod'),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::delete_reo'),
		STD.File.FinishSuperFileTransaction()
	);

	Spray_Files := PARALLEL(
		BKForeclosure.Spray_UpdateFile(
			(STRING)version,
			pHostname,
			pSource,
			setUpdateGlobs,
			pGroup,
			maxRecordSize
		).SprayFile,
		BKForeclosure.Spray_DeleteFile(
			(STRING)version,
			pHostname,
			pSource,
			setDeleteGlobs,
			pGroup,
			maxRecordSize
		).SprayFile,
		BKForeclosure.Spray_RefreshFile(
			(STRING)version,
			pHostname,
			pSource,
			setRefreshGlobs,
			pGroup,
			maxRecordSize
		).SprayFile,
		IF(pSpray,
			Property.spray_Foreclosure_Raw(
				pVersion,
				pHostname,
				pVersion,
				pGroup,
				pSource + '/' + pGlob
			)
		);
	);

	//Add inputs to combined superfile
	dsAll := BKForeclosure.fGetInputFile(pVersion).do_all;

	EXPORT spray_file := SEQUENTIAL(
		Clear_Supers,
		Spray_Files,
		dsAll
	);

END;
