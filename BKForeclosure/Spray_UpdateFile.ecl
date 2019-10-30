IMPORT STD,_control;

EXPORT Spray_UpdateFile(
	STRING pVersion,
	STRING pHostname,
	STRING pSource,
	SET OF STRING setUpdateGlobs, 
	STRING pGroup,
	INTEGER pMaxRecordSize
) := MODULE

	#WORKUNIT('name','Spray BKForeclosure Update File');

	//Sprayed raw files
	SHARED dst_nod_raw   := '~thor_data400::in::BKForeclosure::Update_Nod::' + (string)pVersion + '::raw';
	SHARED dst_reo_raw   := '~thor_data400::in::BKForeclosure::Update_Reo::' + (string)pVersion + '::raw';

	//Raw files with filedate and file_type added
	SHARED dst_nod       := '~thor_data400::in::BKForeclosure::Update_Nod::' + (string)pVersion;
	SHARED dst_reo       := '~thor_data400::in::BKForeclosure::Update_Reo::' + (string)pVersion;

	//Final input superfiles used for build process
	SHARED sprf_nod      := '~thor_data400::in::BKForeclosure::Update_Nod';
	SHARED sprf_reo      := '~thor_data400::in::BKForeclosure::Update_Reo';

	SHARED Spray_Nod := STD.File.SprayVariable(
		pHostname,
		pSource + '/' + setUpdateGlobs[1],
		pMaxRecordSize,
		'\t',
		'\n',,
		pGroup,
		dst_nod_raw,,,,
		TRUE,
		FALSE,
		TRUE,,,,
		7
	);

	SHARED Spray_REO := STD.File.SprayVariable(
		pHostname,
		pSource + '/' + setUpdateGlobs[2],
		pMaxRecordSize,
		'\t',
		'\n',,
		pGroup,
		dst_reo_raw,,,,
		TRUE,
		FALSE,
		TRUE,,,,
		7
	);

	TransformFile_Nod := FUNCTION
		dsraw := DATASET(
			dst_nod_raw,
			BKForeclosure.Layout_BK.Nod_raw,
			CSV(
				SEPARATOR('\t'),
				QUOTE(''),
				TERMINATOR(['\n','\r','\r\n'])
			)
		);
		ds := PROJECT(
			dsraw,
			TRANSFORM(
				BKForeclosure.Layout_BK.Nod_in,
				SELF.ln_filedate := (string)pVersion;
				SELF.bk_infile_type := 'NOD_UPDATE';
				SELF := LEFT;
				SELF :=[]
			)
		);
		RETURN ds;
	END;

	TransformFile_reo := FUNCTION
		dsraw := DATASET(
			dst_reo_raw,
			BKForeclosure.Layout_BK.REO_Raw,
			CSV(
				SEPARATOR('\t'),
				QUOTE(''),
				TERMINATOR(['\n','\r','\r\n'])
			)
		);
		ds := PROJECT(
			dsraw,
			TRANSFORM(
				BKForeclosure.Layout_BK.REO_in,
				SELF.ln_filedate := (string)pVersion;
				SELF.bk_infile_type := 'REO_UPDATE'; 
				SELF.APN := REGEXREPLACE('^([~]+)|([+])',LEFT.APN,'');
				SELF := LEFT;
				SELF :=[]
			)
		);
		RETURN ds;
	END;

	AddToSuperfile_Nod := FUNCTION
		RETURN STD.File.AddSuperFile(
			sprf_nod,
			dst_nod
		);
	END;

	AddToSuperfile_reo := FUNCTION
		RETURN STD.File.AddSuperFile(
			sprf_reo,
			dst_reo
		);
	END;
	
	// Spray all update files	
	Spray_Update_All := SEQUENTIAL(
		Spray_Nod,
		Spray_reo,
	);

	// Transform All Files
	xform_all := PARALLEL(
		OUTPUT(TransformFile_Nod, , dst_nod,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])),OVERWRITE, COMPRESSED),
		OUTPUT(TransformFile_Reo, , dst_reo,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])),OVERWRITE, COMPRESSED)
	);

	// Add Files to Superfile
	super_all := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		AddToSuperfile_Nod,
		AddToSuperfile_reo,
		STD.File.FinishSuperFileTransaction()
	);

	EXPORT SprayFile := SEQUENTIAL(
		Spray_Update_All,
		xform_all,
		super_all
	);

END;
