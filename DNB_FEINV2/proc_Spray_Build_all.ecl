IMPORT STD, orbit_report, RoxieKeybuild, Scrubs, Scrubs_DNB_FEIN, tools, dops;

EXPORT proc_Spray_Build_all(
	STRING  hostname,
	STRING  absolutePath,
	STRING  glob,
	INTEGER recordsize,
	STRING  version,
	STRING  addresses,
	STRING  cluster = 'Thor400_44'
) := FUNCTION

	CreateSuperIfNotExist := IF(NOT STD.File.SuperFileExists('~thor_data400::in::dnbfeinv2::fein'), STD.File.CreateSuperFile('~thor_data400::in::dnbfeinv2::fein'));
	
	CheckLogical := IF(
		NOT STD.File.FileExists('~thor_data400::in::dnbfeinv2::'+version+'::raw'),
		SEQUENTIAL(
			STD.File.SprayFixed(
				hostname,
				IF(REGEXFIND('/$', absolutePath), absolutePath, absolutePath + '/') + glob,
				recordsize,
				cluster,
				'~thor_data400::in::dnbfeinv2::'+version+'::raw',
				-1,,,
				true,
				true
			),
			IF(
				STD.File.FindSuperFileSubName('~thor_data400::in::dnbfeinv2::fein', '~thor_data400::in::dnbfeinv2::'+version+'::raw') = 0,
				SEQUENTIAL(
					STD.File.StartSuperFileTransaction(),
					STD.File.ClearSuperFile('~thor_data400::in::dnbfeinv2::fein',true),
					STD.File.AddSuperFile('~thor_data400::in::dnbfeinv2::fein', '~thor_data400::in::dnbfeinv2::'+version+'::raw'),
					STD.File.FinishSuperFileTransaction()
				)
			)
		)
	) : 
		FAILURE(Send_Email(version, addresses, 'The DNB_FEINV2.proc_Spray_Build_all failed in the checkLogical:14 process.').build_failure);

	// Thor Build
	dnb_feinv2.proc_build_all(version, addresses, doBuild); 

	// generate XML report.
	orbit_report.FEIN_Stats(getretval);

	doAll := SEQUENTIAL(
		CreateSuperIfNotExist,
		checkLogical,
		dobuild,
		getretval
	) : SUCCESS(Send_Email(version, addresses).Build_Success), FAILURE(Send_Email(version, addresses).Build_Failure);

	RETURN doAll;

END;
