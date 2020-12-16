//Spray Infutor Motorcycle file. Use thor40_241 for dataland cluster
IMPORT STD, Address;

EXPORT Spray_Infutor_Motorcycle(
	STRING pSourceIP, 
	STRING pDirectory,
	STRING pVersion,
	STRING pfileName = 'NARVM*.txt',
	STRING pDelimiter = '\\t',
	UNSIGNED pMaxRecordSize = 8192,
	STRING pGroupName = STD.System.Thorlib.Group(),
	BOOLEAN pOverwrite = TRUE
) := FUNCTION

	// check if file exists in UNIX
	checkFileExists := IF(COUNT(STD.File.RemoteDirectory(pSourceIP,pDirectory,pfileName,false)(size <> 0)) = 1,TRUE,FALSE) : INDEPENDENT;

	vRawLogicalFileName := '~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_raw::' + pVersion;
	vRawSuperFileName := '~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_raw';
	vPrepLogicalFileName := '~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_' + pVersion;
	vPrepSuperFileName := '~thor_data400::in::vehiclev2::inf_nondppa::motorcycle';
	vPrepSuperFileFather := '~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_father';
	vPrepSuperFileBldg := '~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_building';

	//createSuperFiles and remove logical file from superfile if it is an overwrite
	superFilePrePorcessing := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		IF(
			NOT STD.File.SuperFileExists(vRawSuperFileName),
			STD.File.CreateSuperFile(vRawSuperFileName)
		),
		IF(
			NOT STD.File.SuperFileExists(vPrepSuperFileName),
			STD.File.CreateSuperFile(vPrepSuperFileName)
		),
		IF(
			NOT STD.File.SuperFileExists(vPrepSuperFileFather),
			STD.File.CreateSuperFile(vPrepSuperFileFather)
		),
		IF(
			NOT STD.File.SuperFileExists(vPrepSuperFileBldg),
			STD.File.CreateSuperFile(vPrepSuperFileBldg)
		),
		IF(
			pOverwrite AND STD.File.FindSuperFileSubName(vRawSuperFileName,vRawLogicalFileName) > 0,
			STD.File.RemoveSuperFile(vRawSuperFileName,vRawLogicalFileName)
		),
		IF(
			pOverwrite AND STD.File.FindSuperFileSubName(vPrepSuperFileName,vPrepLogicalFileName) > 0,
			STD.File.RemoveSuperFile(vPrepSuperFileName,vPrepLogicalFileName)
		),
		IF(
			pOverwrite AND STD.File.FindSuperFileSubName(vPrepSuperFileBldg,vPrepLogicalFileName) > 0,
			STD.File.RemoveSuperFile(vPrepSuperFileBldg,vPrepLogicalFileName)
		),
		IF(
			pOverwrite AND STD.File.FindSuperFileSubName(vPrepSuperFileFather,vPrepLogicalFileName) > 0,
			STD.File.RemoveSuperFile(vPrepSuperFileFather,vPrepLogicalFileName)
		),
		STD.File.FinishSuperFileTransaction()
	);

	sprayInfutorMotorcycle:= STD.File.SprayDelimited(
		pSourceIP,
		pDirectory + '/' + pfileName,
		pMaxRecordSize,
		pDelimiter,
		'\r\n',
		'',
		pGroupName,
		vRawLogicalFileName,
		,
		,
		,
		pOverwrite,
		,
		TRUE
	);

	addToRawSuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile(vRawSuperFileName,vRawLogicalFileName),
		STD.File.FinishSuperFileTransaction()
	);


	dInfutorRaw := VehicleV2.Files.In.Infutor_Motorcycle.Raw;

	// Create Infutor_VIN VIN's only file
	removeInfutorVinCandidates := IF(
		STD.File.FindSuperFileSubName('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_motorcycle::vina_candidates') != 0,
		SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
			STD.File.RemoveSuperFile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_motorcycle::vina_candidates'),
			STD.File.FinishSuperFileTransaction()
		)
	);

	rVinCandidates_layout := RECORD
		STRING22	VIN;
		STRING1		lf;
	END;

	rVinCandidates_layout tVinCandidates(dInfutorRaw pInput) := TRANSFORM
		SELF.vin := pInput.internal1;
		SELF := [];
	END;

	dInfutorVinCandidates := PROJECT(dInfutorRaw,tVinCandidates(left));

	outInfutorVinCandidates := OUTPUT(dInfutorVinCandidates,,'~thor_data400::in::vehiclev2::inf_nondppa_motorcycle::vina_candidates',overwrite,__compressed__);

	addInfutorVinCandidates := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::inf_nondppa_motorcycle::vina_candidates'),
		STD.File.FinishSuperFileTransaction()
	);

	// Add process date and state origin - prep the raw sprayed file and add it to the superfile
	VehicleV2.Layout_Infutor_Motorcycle.Prepped tPrepInfutorRaw(dInfutorRaw pInput) := TRANSFORM
		SELF.ProcessDate := pVersion;
		SELF.source_code := '2V';     //source code for INFUTOR VIN, defined in MDR.sourceTools
		//state_origin should be the state code of the state the vehicle is registered at.
		//It is not available in Infutor. Instead we use the state code of owner's address.
		SELF.state_origin := stringlib.stringtouppercase(pInput.STATE);
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
		SEQUENTIAL(
			STD.File.StartSuperFileTransaction(),
			STD.File.RemoveSuperFile(vPrepSuperFileBldg,vPrepLogicalFileName),
			STD.File.FinishSuperFileTransaction()
		)
	);

	outInfutorPrepped := OUTPUT(project(dInfutorOwner1NameInd,VehicleV2.Layout_Infutor_Motorcycle.PREPPED),,vPrepLogicalFileName,overwrite,__compressed__);
	
	addInfutorPreppedToSuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.ClearSuperFile(vPrepSuperFileFather,true),
		STD.File.AddSuperFile(vPrepSuperFileFather,vPrepSuperFileName,,true),
		STD.File.ClearSuperFile(vPrepSuperFileName),
		STD.File.AddSuperFile(vPrepSuperFileName,vPrepLogicalFileName),
		STD.File.FinishSuperFileTransaction(),
		STD.File.ClearSuperFile(vRawSuperFileName,true)
	);

	addInfutorToBldg := IF(
		fileservices.getsuperfilesubcount(vPrepSuperFileBldg) > 0,
		OUTPUT('Nothing added to Infutor Building superfile'),
		STD.File.AddSuperFile(vPrepSuperFileBldg,vPrepLogicalFileName)
	);

	SprayFile := IF(
		checkfileexists AND (NOT STD.File.SuperFileExists(vPrepSuperFileName) OR STD.File.FindSuperFileSubName(vPrepSuperFileName,vPrepLogicalFileName)=0),
		SEQUENTIAL(
			superFilePrePorcessing,
			sprayInfutorMotorcycle,
			addToRawSuper,
			removeInfutorVinCandidates,
			outInfutorVinCandidates,
			addInfutorVinCandidates,
			removeInfutorPrepped,
			outInfutorPrepped,
			addInfutorPreppedToSuper,
			addInfutorToBldg
		),
		OUTPUT('No New Infutor Motorcycle file available for spray')
	);

	RETURN SprayFile;

END;
