IMPORT STD, Address;
//This file is copied from Spray_Experian. It reads the input directory and sprays all files in the directory to the target
//location. The input files are with txt extention and delimited by tab.
EXPORT Spray_Infutor_Vin(
	STRING pSourceIP,
	STRING pDirectory,
	STRING pVersion,
	STRING pfileMask = 'NARV3_*.txt',
	STRING pDelimiter = '\\t',
	UNSIGNED pMaxRecordSize =  8192,
	STRING pGroupName = STD.System.Thorlib.Group(),
	BOOLEAN pOverwrite = TRUE
) := FUNCTION

	STRING vProcessDate := (STRING) STD.Date.CurrentDate();

	dRemoteFileList := STD.File.RemoteDirectory(pSourceIP,pDirectory,pfileMask);

	vRawLogicalFileName := '~thor_data400::in::vehiclev2::inf_nondppa::vin_raw::' + pVersion + '::@state@';
	vRawSuperFileName := '~thor_data400::in::vehiclev2::inf_nondppa::vin_raw';
	vPrepLogicalFileName := '~thor_data400::in::vehiclev2::inf_nondppa::vin_' + pVersion;
	vPrepSuperFileName := '~thor_data400::in::vehiclev2::inf_nondppa::vin';
	vPrepSuperFileDelete := '~thor_data400::in::vehiclev2::inf_nondppa::vin_delete';
	vPrepSuperFileFather := '~thor_data400::in::vehiclev2::inf_nondppa::vin_father';
	vPrepSuperFileBldg := '~thor_data400::in::vehiclev2::inf_nondppa::vin_building';

	rSprayInfo_layout :=
	RECORD, maxlength(10000)
		STRING sourceIP;
		STRING sourceDir;
		STRING SourceState;
		STRING FileDate;
		STRING ProcessDate;
		//unsigned RecordLength;
		STRING GroupName;
		BOOLEAN Overwrite;
		STRING RemoteFileName;
		STRING RawLogicalFileName;
		STRING RawSuperFileName;
		STRING PrepLogicalFileName;
		STRING PrepSuperFileName;
	END;

	rSprayInfo_layout tSprayInfo(dRemoteFileList pInput) := TRANSFORM
		SELF.SourceIP  := pSourceIP;
		SELF.SourceDir := pDirectory + '/' + pInput.name;
		SELF.SourceState := REGEXFIND('^NARV3_([A-Z]{2}).txt$', TRIM(pInput.name),1);
		SELF.FileDate := pVersion;
		SELF.ProcessDate := vProcessDate;
		SELF.GroupName := pGroupName;
		SELF.Overwrite := pOverwrite;
		SELF.RemoteFileName := pInput.name;
		SELF.RawLogicalFileName := REGEXREPLACE(
			'@state@',
			vRawLogicalFileName,
			SELF.SourceState
		);
		SELF.RawSuperFileName := vRawSuperFileName;
		SELF.PrepLogicalFileName := vPrepLogicalFileName;
		SELF.PrepSuperFileName := vPrepSuperFileName;
	END;

	dRemoteFiles_SprayInfo := PROJECT(dRemoteFileList,tSprayInfo(left));

	oRemoteFiles_SprayInfo := OUTPUT(dRemoteFiles_SprayInfo);

	sprayVariable(
		STRING  pSrcIP,
		STRING  pSrcDir,
		STRING  pGrpName,
		STRING  pLogicalFileName,
		BOOLEAN pOverwrite
	) := STD.File.SprayDelimited(
		pSrcIP,
		pSrcDir,
		pMaxRecordSize,
		pDelimiter,
		'\r\n',
		'',
		pGrpName,
		pLogicalFileName,,,,
		pOverwrite,
		,
		TRUE
	);

	// Add to superfile
	addSuperFile(
		STRING pSuperFileName,
		STRING pLogicalFileName
	) := SEQUENTIAL( 
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile(pSuperFileName,pLogicalFileName),
		STD.File.FinishSuperFileTransaction()
	);

	// Remove from superfile
	removeSubFile(
		string pSuperFileName,
		string pLogicalFileName
	) := IF(
		STD.File.FindSuperFileSubName(pSuperFileName,pLogicalFileName) != 0,
		SEQUENTIAL(
			STD.File.StartSuperFileTransaction(),
			STD.File.RemoveSuperFile(pSuperFileName,pLogicalFileName),
			STD.File.FinishSuperFileTransaction()
		)
		//OUTPUT(pLogicalFileName + ' file does not exist, no action taken')
	);

	createSuperFiles := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		IF(
			NOT STD.File.SuperFileExists(vRawSuperFileName),
			STD.File.CreateSuperFile(vRawSuperFileName),
			STD.File.ClearSuperFile(vRawSuperFileName)
		),
		IF(
			NOT STD.File.SuperFileExists(vPrepSuperFileName),
			STD.File.CreateSuperFile(vPrepSuperFileName),
			STD.File.ClearSuperFile(vPrepSuperFileName)
		),
		IF(
			NOT STD.File.SuperFileExists(vPrepSuperFileDelete),
			STD.File.CreateSuperFile(vPrepSuperFileDelete)
		),
		IF(
			NOT STD.File.SuperFileExists(vPrepSuperFileFather),
			STD.File.CreateSuperFile(vPrepSuperFileFather)
		),
		IF(
			NOT STD.File.SuperFileExists(vPrepSuperFileBldg),
			STD.File.CreateSuperFile(vPrepSuperFileBldg)
		),
		STD.File.FinishSuperFileTransaction()
	);

	sprayFiles := NOTHOR(
		APPLY(
			dRemoteFiles_SprayInfo,
			SEQUENTIAL(
				IF(
					pOverwrite = TRUE,
					SEQUENTIAL(
						removeSubFile(RawSuperFileName,RawLogicalFileName),
						removeSubFile(PrepSuperFileName,PrepLogicalFileName)
					)
				),
				sprayVariable(
					SourceIP,
					SourceDir,
					GroupName,
					RawLogicalFileName,
					pOverwrite
				),
				addSuperFile(RawSuperFileName,RawLogicalFileName)
			)
		)
	);

	rInfutor_layout := RECORD
		VehicleV2.Layout_Infutor_VIN.Raw_Main;
		STRING LogicalFileName {VIRTUAL(LogicalFileName)};
	END;

	dInfutorRaw := DATASET(
		vRawSuperFileName,
		rInfutor_layout,
		CSV(
			SEPARATOR('\t'),
			heading(0),
			quote('"'),
			TERMINATOR(['\r\n','\n\r'])
		)
	);

	odInfutorRaw := OUTPUT(CHOOSEN(dInfutorRaw, 100));

	// Create Infutor_VIN VIN's only file
	removeInfutorVinCandidates := IF(
		STD.File.FindSuperFileSubName('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_vin::vina_candidates') != 0,
		SEQUENTIAL(
			STD.File.StartSuperFileTransaction(),
			STD.File.RemoveSuperFile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_vin::vina_candidates'),
			STD.File.FinishSuperFileTransaction()
		)
	);

	rVinCandidates_layout := RECORD
		STRING22 VIN;
		STRING1 lf;
	END;

	rVinCandidates_layout tVinCandidates(dInfutorRaw pInput) := TRANSFORM
		SELF.vin := pInput.internal1;
		SELF.lf  := pInput.crlf;
	END;

	dInfutorVinCandidates := PROJECT(dInfutorRaw,tVinCandidates(left));

	outInfutorVinCandidates := OUTPUT(dInfutorVinCandidates,,'~thor_data400::in::vehiclev2::inf_nondppa_vin::vina_candidates',overwrite,__compressed__);

	addInfutorVinCandidates := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_vin::vina_candidates'),
		STD.File.FinishSuperFileTransaction()
	);

	// Add process date and state origin - prep the raw sprayed file and add it to the superfile
	VehicleV2.Layout_Infutor_VIN.Prepped tPrepInfutorRaw(dInfutorRaw pInput) := TRANSFORM
		STRING2 vState := REGEXFIND('[A-Za-z]{2}$',pInput.LogicalFileName,0);
		SELF := pInput;
		SELF.ProcessDate := vProcessDate;
		SELF.source_code := '1V'; //source code for INFUTOR VIN, defined in MDR.sourceTools
		//state_origin should be the state code of the state the vehicle is registered at. However it is not available in Infutor
		//data, and we do need this field for iteration key and other. Instead we use the state code of owner's address.
		SELF.state_origin := stringlib.stringtouppercase(vState);
		SELF := pInput;
		SELF := [];
	END;

	dPrepInfutorRaw := PROJECT(dInfutorRaw,tPrepInfutorRaw(left));

	// Append name type indicators depending on the names
	Address.Mac_Is_Business_Parsed(
		dPrepInfutorRaw,
		dInfutorOwner1NameInd,
		fname,
		mi,
		lname,
		suffix,
		,
		Append_OwnerNameTypeInd
	);

	removeInfutorPrepped := IF(
		STD.File.FindSuperFileSubName(vPrepSuperFileBldg,vPrepLogicalFileName)	!=	0,
		SEQUENTIAL(	STD.File.StartSuperFileTransaction(),
			STD.File.RemoveSuperFile(vPrepSuperFileBldg,vPrepLogicalFileName),
			STD.File.FinishSuperFileTransaction()
		)
	);

	outInfutorPrepped := OUTPUT(dInfutorOwner1NameInd,,vPrepLogicalFileName,overwrite,__compressed__);

	addInfutorPreppedToSuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.ClearSuperFile(vPrepSuperFileDelete),
		STD.File.AddSuperFile(vPrepSuperFileDelete,vPrepSuperFileFather,,true),
		STD.File.ClearSuperFile(vPrepSuperFileFather),
		STD.File.AddSuperFile(vPrepSuperFileFather,vPrepSuperFileName,,true),
		STD.File.ClearSuperFile(vPrepSuperFileName),
		STD.File.AddSuperFile(vPrepSuperFileName,vPrepLogicalFileName),
		STD.File.FinishSuperFileTransaction(),
		STD.File.ClearSuperFile(vPrepSuperFileDelete,true),
		STD.File.ClearSuperFile(vRawSuperFileName,true)
	);

	addInfutorToBldg := IF(
		STD.File.GetSuperFileSubCount(vPrepSuperFileBldg) > 0,
		OUTPUT('Nothing added to Infutor Building superfile'),
		STD.File.AddSuperFile(vPrepSuperFileBldg,vPrepLogicalFileName)
	);

	GoSpray := SEQUENTIAL(
		createSuperFiles,
		IF (
			pVersion <> '' AND
			STD.File.FindSuperFileSubName(vPrepSuperFileName,vPrepLogicalFileName)=0,
			SEQUENTIAL(	
				oRemoteFiles_SprayInfo, 
				sprayFiles,
				odInfutorRaw,
				removeInfutorVinCandidates,
				outInfutorVinCandidates,
				addInfutorVinCandidates,
				removeInfutorPrepped,
				outInfutorPrepped,
				addInfutorPreppedToSuper,
				addInfutorToBldg
			),
			OUTPUT('No New Infutor VIN file available for spray')
		)
	);

	RETURN GoSpray;

END;
