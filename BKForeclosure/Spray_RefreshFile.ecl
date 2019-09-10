IMPORT STD,_control;

EXPORT Spray_refreshFile(
	STRING pVersion,
	STRING pHostname,
	STRING pSource,
	SET OF STRING setRefreshGlobs,
	STRING pGroup,
	INTEGER maxRecordSize
) := MODULE

	#workunit('name','Spray Foreclosure Refresh Files');

	//Sprayed input files
	SHARED dst_nod_orph_raw := '~thor_data400::in::BKForeclosure::refresh_nod_orphan::' +(string)pVersion+ '::raw';
	SHARED dst_nod_ref_raw  := '~thor_data400::in::BKForeclosure::refresh_nod::' +(string)pVersion+ '::raw';
	SHARED dst_reo_orph_raw := '~thor_data400::in::BKForeclosure::refresh_reo_orphan::' +(string)pVersion+ '::raw';
	SHARED dst_reo_ref_raw  := '~thor_data400::in::BKForeclosure::refresh_reo::' +(string)pVersion+ '::raw';

	//Input files with filedate and file_type added
	SHARED dst_nod_orph := '~thor_data400::in::BKForeclosure::refresh_nod_orphan::' +(string)pVersion;
	SHARED dst_nod_ref  := '~thor_data400::in::BKForeclosure::refresh_nod::' +(string)pVersion;
	SHARED dst_reo_orph := '~thor_data400::in::BKForeclosure::refresh_reo_orphan::' +(string)pVersion;
	SHARED dst_reo_ref  := '~thor_data400::in::BKForeclosure::refresh_reo::' +(string)pVersion;

	//Final input superfiles used for build
	SHARED sprf_nod_orph := '~thor_data400::in::BKForeclosure::refresh_nod_orphan';
	SHARED sprf_nod_ref  := '~thor_data400::in::BKForeclosure::refresh_nod';
	SHARED sprf_reo_orph := '~thor_data400::in::BKForeclosure::refresh_reo_orphan';
	SHARED sprf_reo_ref  := '~thor_data400::in::BKForeclosure::refresh_reo';

	SHARED Spray_Nod_Orphan := STD.File.SprayVariable(
		pHostname,
		pSource + '/' + setRefreshGlobs[1],
		maxRecordSize,
		'\t',
		'\n',,
		pGroup,
		dst_nod_Orph_raw,,,,
		TRUE,
		FALSE,
		TRUE,,,,
		7
	);

	SHARED spray_Nod_refresh := STD.File.SprayVariable(
		pHostname,
		pSource + '/' + setRefreshGlobs[2],
		maxRecordSize,
		'\t',
		'\n',,
		pGroup,
		dst_nod_Ref_raw,,,,
		TRUE,
		FALSE,
		TRUE,,,,
		7
	);

	SHARED Spray_REO_Orphan := STD.File.SprayVariable(
		pHostname,
		pSource + '/' + setRefreshGlobs[3],
		maxRecordSize,
		'\t',
		'\n',,
		pGroup,
		dst_reo_Orph_raw,,,,
		TRUE,
		FALSE,
		TRUE,,,,
		7
	);

	SHARED Spray_REO_refresh := STD.File.SprayVariable(
		pHostname,
		pSource + '/' + setRefreshGlobs[4],
		maxRecordSize,
		'\t',
		'\n',,
		pGroup,
		dst_reo_Ref_raw,,,,
		TRUE,
		FALSE,
		TRUE,,,,
		7
	);

	TransformFile_Nod_Orphan := FUNCTION
		dsraw := DATASET(
			dst_nod_Orph_raw,
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
				SELF.bk_infile_type := 'NOD_ORPHAN';
				SELF := LEFT;
				SELF :=[]
			)
		);

		RETURN ds;
	END;
	
	TransformFile_Nod_refresh := FUNCTION
		dsraw := DATASET(
				dst_nod_ref_raw,
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
				SELF.bk_infile_type := 'NOD_REFRESH';
				SELF := LEFT;
				SELF :=[]
			)
		);

		RETURN ds;
	END;
	
	TransformFile_Reo_Orphan := FUNCTION
		dsraw := DATASET(
			dst_reo_orph_raw,
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
				SELF.bk_infile_type := 'REO_ORPHAN';
				SELF.APN := REGEXREPLACE('^([~]+)|([+])',LEFT.APN,'');
				SELF := LEFT;
				SELF :=[]
			)
		);
		RETURN ds;
	END;

	TransformFile_Reo_refresh := FUNCTION
		dsraw := DATASET(
			dst_reo_ref_raw,
			BKForeclosure.Layout_BK.Reo_Raw,
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
				SELF.bk_infile_type := 'REO_REFRESH';
				SELF.APN := REGEXREPLACE('^([~]+)|([+])',LEFT.APN,'');
				SELF := LEFT;
				SELF :=[])
		);

		RETURN ds;
	END;	

	AddToSuperfile_Nod_Orph := FUNCTION
		RETURN STD.File.AddSuperFile(
			sprf_nod_Orph,
			dst_nod_Orph
		);
	END;

	AddToSuperfile_Nod_Ref := FUNCTION
		RETURN STD.File.AddSuperFile(
			sprf_nod_Ref,
			dst_nod_Ref
		);
	END;

	AddToSuperfile_Reo_Orph := FUNCTION
		RETURN STD.File.AddSuperFile(
			sprf_reo_Orph,
			dst_reo_Orph
		);
	END;

	AddToSuperfile_Reo_Ref := FUNCTION
		RETURN STD.File.AddSuperFile(
			sprf_reo_Ref,
			dst_reo_Ref
		);
	END;

	// Spray all refresh files	
	Spray_Refresh_All := SEQUENTIAL(
		Spray_Nod_Orphan,
		Spray_Nod_refresh,
		Spray_REO_Orphan,
		Spray_REO_refresh
	);

	// Transform All Files
	xform_all := PARALLEL(
		OUTPUT(TransformFile_Nod_Orphan,, dst_nod_Orph, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
		OUTPUT(TransformFile_Nod_refresh,, dst_nod_Ref, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
		OUTPUT(TransformFile_Reo_Orphan,, dst_Reo_Orph, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
		OUTPUT(TransformFile_Reo_refresh,, dst_Reo_Ref, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED)
	);

	// Add Files to Superfile
	super_all := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		AddToSuperfile_Nod_Orph,
		AddToSuperfile_Nod_Ref,
		AddToSuperfile_Reo_Orph,
		AddToSuperfile_Reo_Ref,
		STD.File.FinishSuperFileTransaction()
	);

	EXPORT SprayFile := SEQUENTIAL(
		Spray_Refresh_All,
		xform_all,
		super_all
	);
END;
