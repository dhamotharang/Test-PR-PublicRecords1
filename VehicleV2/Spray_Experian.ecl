IMPORT STD, VehicleV2;

EXPORT Spray_Experian(
	STRING  pSourceIP,
	STRING  pDirectory,
	STRING  pVersion,
	STRING pfileMask = 'LASP.R010.AIS.M.*.LDDP1150.*',
	UNSIGNED pRecLength = 1151,
	STRING  pGroupName = STD.System.Thorlib.Group(),
	BOOLEAN pOverwrite = TRUE
) :=
FUNCTION

	STRING vProcessDate := (STRING) STD.Date.CurrentDate();

	dRemoteFileList := STD.File.RemoteDirectory(pSourceIP,pDirectory,pfileMask);

	vRawLogicalFileName  := '~thor_data400::in::vehiclev2::experian::raw::' + pVersion + '::@state@';
	vRawSuperFileName    := '~thor_data400::in::vehiclev2::experian::raw';
	vPrepLogicalFileName := '~thor_data400::in::vehiclev2::experian_' + pVersion;
	vPrepSuperFileName   := '~thor_data400::in::vehiclev2::experian';
	vPrepSuperFileDelete := '~thor_data400::in::vehiclev2::experian_delete';
	vPrepSuperFileFather := '~thor_data400::in::vehiclev2::experian_father';
	vPrepSuperFileBldg   := '~thor_data400::in::vehiclev2::experian_building';

	rSprayInfo_layout := RECORD, maxlength(10000)
		STRING   sourceIP;
		STRING   sourceDir;
		STRING   SourceState;
		STRING   FileDate;
		STRING   ProcessDate;
		UNSIGNED RecordLength;
		STRING   GroupName;
		BOOLEAN  Overwrite;
		STRING   RemoteFileName;
		STRING   RawLogicalFileName;
		STRING   RawSuperFileName;
		STRING   PrepLogicalFileName;
		STRING   PrepSuperFileName;
	END;

	rSprayInfo_layout tSprayInfo(dRemoteFileList pInput) := TRANSFORM
		self.SourceIP            := pSourceIP;
		self.SourceDir           := pDirectory + '/' + pInput.name;
		self.SourceState         := STD.Str.SplitWords(pInput.name,'.')[5];
		self.FileDate            := pVersion;
		self.ProcessDate         := vProcessDate;
		self.RecordLength        := pRecLength;
		self.GroupName           := pGroupName;
		self.Overwrite           := pOverwrite;
		self.RemoteFileName      := pInput.name;
		self.RawLogicalFileName  := regexreplace(
			'@state@',
			vRawLogicalFileName,
			self.SourceState
		);
		self.RawSuperFileName    := vRawSuperFileName;
		self.PrepLogicalFileName := vPrepLogicalFileName;
		self.PrepSuperFileName   := vPrepSuperFileName;
	END;

	dRemoteFiles_SprayInfo := PROJECT(dRemoteFileList,tSprayInfo(left));

	sprayFixed(
		STRING   pSrcIP,
		STRING   pSrcDir,
		UNSIGNED pRecLen,
		STRING   pGrpName,
		STRING   pLogicalFileName,
		BOOLEAN  pOverwrite
	) := STD.File.SprayFixed(
		pSrcIP,
		pSrcDir,
		pRecLen,
		pGrpName,
		pLogicalFileName,,,,
		pOverwrite,
		true,
		true
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
	) := IF( STD.File.FindSuperFileSubName(pSuperFileName,pLogicalFileName) != 0,
		SEQUENTIAL(
			STD.File.StartSuperFileTransaction(),
			STD.File.RemoveSuperFile(pSuperFileName,pLogicalFileName),
			STD.File.FinishSuperFileTransaction()
		),
		OUTPUT(pLogicalFileName + ' file does not exist, no action taken')
	);

	sprayFiles := NOTHOR(
		APPLY(
			dRemoteFiles_SprayInfo,
			SEQUENTIAL( 
				IF( pOverwrite = true,
						SEQUENTIAL(
							removeSubFile(RawSuperFileName,RawLogicalFileName),
							removeSubFile(PrepSuperFileName,PrepLogicalFileName)
						)
				),
				sprayFixed(
					SourceIP,
					SourceDir,
					RecordLength,
					GroupName,
					RawLogicalFileName,
					pOverwrite
				),
				addSuperFile(RawSuperFileName,RawLogicalFileName)
			)
		)
	);

	rExperianRaw_layout := RECORD
		VehicleV2.Layout_Experian.Layout_Experian_Raw;
		STRING LogicalFileName {virtual(LogicalFileName)};
	END;
	
	dExperianRaw := DATASET(vRawSuperFileName,rExperianRaw_layout,thor);

	// Create Experian VIN's only file
	removeExpVinCandidates := IF( 
		STD.File.FindSuperFileSubName(
			'~thor_data400::in::vehiclev2::vina_candidates',
			'~thor_data400::in::vehiclev2::experian::vina_candidates'
		) != 0,
		SEQUENTIAL( 
			STD.File.StartSuperFileTransaction(),
			STD.File.RemoveSuperFile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::experian::vina_candidates'),
			STD.File.FinishSuperFileTransaction()
		)
	);

 rVinCandidates_layout := RECORD
		STRING22 VIN;
		STRING1  lf;
	END;

	rVinCandidates_layout tVinCandidates(dExperianRaw pInput) := TRANSFORM
		self.lf := pInput.crlf;
		self    := pInput;
	END;
	
	dExpVinCandidates := PROJECT(dExperianRaw,tVinCandidates(left));
	
	outExpVinCandidates := OUTPUT(dExpVinCandidates,,'~thor_data400::in::vehiclev2::experian::vina_candidates',overwrite,__compressed__);

	addExpVinCandidates := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile('~thor_data400::in::vehiclev2::vina_candidates','~thor_data400::in::vehiclev2::experian::vina_candidates'),
		STD.File.FinishSuperFileTransaction()
	);

	// Add process date and state origin - prep the raw sprayed file and add it to the superfile
	VehicleV2.Layout_Experian.Layout_Experian_Prepped tPrepExperianRaw(dExperianRaw pInput) := TRANSFORM
		string2 vState           := regexfind('[A-Za-z]{2}$',pInput.LogicalFileName,0);
		self.Append_Process_Date := vProcessDate;
		self.Append_State_Origin := stringlib.stringtouppercase(vState);
		self                     := pInput;
	END;
	
	dPrepExperianRaw := PROJECT(dExperianRaw,tPrepExperianRaw(left));

	outExperianPrepped := OUTPUT(dPrepExperianRaw,,vPrepLogicalFileName,overwrite,__compressed__);
	
	addExperianPreppedToSuper := SEQUENTIAL(
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

	addExperianToBldg := IF(
		STD.File.GetSuperFileSubCount(vPrepSuperFileBldg) > 0,
		OUTPUT('Nothing added to Experian Building superfile'),
		STD.File.AddSuperFile(vPrepSuperFileBldg,vPrepLogicalFileName)
	);

	RETURN SEQUENTIAL(
		sprayFiles,
		removeExpVinCandidates,
		outExpVinCandidates,
		addExpVinCandidates,
		outExperianPrepped,
		addExperianPreppedToSuper,
		addExperianToBldg
	);

END;
