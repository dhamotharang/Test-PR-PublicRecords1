IMPORT STD;

EXPORT ProcBuildSpray(
	STRING pHostname,
	STRING pAbsolutePath,
	STRING pVersion,
	STRING pCluster = STD.System.Thorlib.Group()
) := MODULE
	SHARED vSprayFailureMsg := 'A failure occured while attempting to SPRAY data for ';
	SHARED vSuperFileTransactionFailureMsg := 'Super file transactions failed for ';
	SHARED vSuccessMsg := 'Data successfully SPRAYED for ';

	SHARED fSprayUpFixed(
		STRING pRawData,
		INTEGER pRecordSize,
		STRING pLogicalInFile
	) := FUNCTION
		RETURN STD.File.SprayFixed(
			pHostname,
			pRawData,
			pRecordSize,
			pCluster,
			pLogicalInFile,
			replicate := TRUE
		);
	END;

	SHARED fSprayUpDelimited(
		STRING pRawData,
		STRING pLogicalInFile
	) := FUNCTION
		RETURN STD.File.SprayDelimited(
			pHostname,
			pRawData,
			,,,,
			pCluster,
			pLogicalInFile,
			replicate := TRUE
		);
	END;

	SHARED fSuperFileTransaction(
		STRING pSuperInFile,
		STRING pLogicalInFile
	) := FUNCTION
		RETURN SEQUENTIAL(
			STD.File.StartSuperFileTransaction(),
			STD.File.ClearSuperFile(pSuperInFile),
			STD.File.AddSuperFile(pSuperInFile, pLogicalInFile),
			STD.File.FinishSuperFileTransaction()
		);
	END;

	SHARED doSprayUpDelimited(
		STRING pRawData,
		STRING pLogicalInFile,
		STRING pSuperInFile,
		STRING pCity
	) := FUNCTION
		spray := fSprayUpDelimited(
			pRawData,
			pLogicalInFile
		):FAILURE(
			OUTPUT(vSprayFailureMsg + pCity)
		);
		addSuper := fSuperFileTransaction(
			pSuperInFile,
			pLogicalInFile
		):FAILURE(
			OUTPUT(vSuperFileTransactionFailureMsg + pCity)
		);
		RETURN SEQUENTIAL(
			spray,
			addSuper,
			OUTPUT(vSuccessMsg + pCity)
		);
	END;

	SHARED doSprayUpFixed(
		STRING pRawData,
		INTEGER pRecordSize,
		STRING pLogicalInFile,
		STRING pSuperInFile,
		STRING pCity
	) := FUNCTION
		spray := fSprayUpFixed(
			pRawData,
			pRecordSize,
			pLogicalInFile
		):FAILURE(
			OUTPUT(vSprayFailureMsg + pCity)
		);
		addSuper := fSuperFileTransaction(
			pSuperInFile,
			pLogicalInFile
		):FAILURE(
			OUTPUT(vSuperFileTransactionFailureMsg + pCity)
		);
		RETURN SEQUENTIAL(
			spray,
			addSuper,
			OUTPUT(vSuccessMsg + pCity)
		);
	END;

	SHARED doSprayUp(
		STRING pCity,
		STRING pFileMask,
		STRING pLogicalInFile,
		STRING pSuperInFile,
		INTEGER pRecordSize = 0, 
		BOOLEAN pIsDelimited = TRUE
	) := FUNCTION
		RETURN IF(
			pIsDelimited,
			doSprayUpDelimited(
				pAbsolutePath + '/' + pFileMask,
				pLogicalInFile,
				pSuperInFile,
				pCity
			),
			doSprayUpFixed(
				pAbsolutePath + '/' + pFileMask,
				pRecordSize,
				pLogicalInFile,
				pSuperInFile,
				pCity
			)
		);
	END;
	
	EXPORT sprayFresno(
		STRING pFileMask = 'ca_fresno_en_*_civilcaseindex.csv'
	) := doSprayUp(
		'Fresno',
		pFileMask,
		'~thor_data400::in::civil::ca_fresno_thru_' + pVersion,
		'~thor_data400::in::civil::ca_fresno'
	);
	
	EXPORT sprayKern(
		STRING pFileMask = 'ca_kern_en_*.odyssey_joboutput_*.csv'
	) := doSprayUp(
		'Kern',
		pFileMask,
		'~thor_data400::in::civil::ca_kern_thru_' + pVersion,
		'~thor_data400::in::civil::ca_kern_new'
	);

	EXPORT sprayLosAngeles(
		STRING pFileMask = 'ca_los_angeles_en_Superior_Civ_*.txt',
		INTEGER pRecordSize = 144
	) := doSprayUp(
		'Los Angeles',
		pFileMask,	
		'~thor_data400::in::civil::ca_los_angeles_thru_' + pVersion,
		'~thor_data400::in::civil::ca_los_angeles_new',
		pRecordSize,
		FALSE
	);

	EXPORT sprayMarin(
		STRING pFileMask = 'ca_marin_pn_civilpublicindex_quarterly.csv'
	) := doSprayUp(
		'Marin',
		pFileMask,	
		'~thor_data400::in::civil::ca_marin_' + pVersion,
		'~thor_data400::in::civil::ca_marin'
	);

	EXPORT spraySanBernardino(
		STRING pFileMask = 'ca_san_bernardino_en_*Quarter*_*.txt',
		INTEGER pRecordSize = 144
	) := doSprayUp(
		'San Bernardino',
		pFileMask,
		'~thor_data400::in::civil::ca_san_bernardino_thru_' + pVersion,
		'~thor_data400::in::civil::ca_san_bernardino',
		pRecordSize,
		FALSE
	);

END;
