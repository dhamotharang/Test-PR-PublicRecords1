IMPORT STD,_control;

EXPORT Spray_DeleteFile(
	STRING pVersion,
	STRING pHostname,
	STRING pSource,
	SET OF STRING setDeleteGlobs,
	STRING pGroup,
	INTEGER pMaxRecordSize	
) := MODULE //Use folder date

	#WORKUNIT('name','Spray BKForeclosure Delete File');

	//Sprayed input file
	SHARED dst_Delete_Nod_raw := '~thor_data400::in::BKForeclosure::delete_nod::' +(string)pVersion+ '::raw';
	SHARED dst_Delete_Reo_raw := '~thor_data400::in::BKForeclosure::delete_reo::' +(string)pVersion+ '::raw';

	//Input file with filedate and delete_flag set
	SHARED dst_Delete_Nod := '~thor_data400::in::BKForeclosure::delete_nod::' +(string)pVersion;
	SHARED dst_Delete_Reo := '~thor_data400::in::BKForeclosure::delete_reo::' +(string)pVersion;

	//Delete superfiles used by build process
	SHARED sprf_Delete_Nod := '~thor_data400::in::BKForeclosure::delete_nod';
	SHARED sprf_Delete_Reo := '~thor_data400::in::BKForeclosure::delete_reo';

	SHARED Spray_Delete_Nod := STD.File.SprayVariable(
		pHostname,
		pSource + '/' + setDeleteGlobs[1],
		pMaxRecordSize,
		'\t',
		'\n',,
		pGroup,
		dst_Delete_Nod_raw,,,,
		TRUE,
		FALSE,
		TRUE
	);

	SHARED Spray_Delete_Reo := STD.File.SprayVariable(
		pHostname,
		pSource + '/' + setDeleteGlobs[2],
		pMaxRecordSize,
		'\t',
		'\r\n',,
		pGroup,
		dst_Delete_Reo_raw,,,,
		TRUE,
		FALSE,
		TRUE
	);

	TransformFile_Nod := FUNCTION
		dsraw := DATASET(
			dst_Delete_Nod_raw,
			BKForeclosure.layout_BK.Delete_Nod,
			CSV(
				SEPARATOR('\t'),
				QUOTE(''),
				TERMINATOR('\n')
			)
		);
		ds := PROJECT(
			dsraw,
			TRANSFORM(
				BKForeclosure.layout_BK.Delete_Nod,
				SELF.ln_filedate := (string)pVersion;
				SELF.Delete_Flag := 'DELETE'; 
				SELF := LEFT;
				SELF :=[]
			)
		);
		RETURN ds;
	END;
	
	TransformFile_Reo := FUNCTION
		dsraw := DATASET(
			dst_Delete_Reo_raw,
			BKForeclosure.Layout_BK.Delete_Reo,
			CSV(
				SEPARATOR('\t'),
				QUOTE(''),
				TERMINATOR('\r\n')
			)
		);
		ds := PROJECT(
			dsraw,
			TRANSFORM(
				BKForeclosure.layout_BK.Delete_Reo,
				SELF.ln_filedate := (string)pVersion;
				SELF.Delete_Flag := 'DELETE';
				SELF := LEFT;
				SELF :=[]
			)
		);
		RETURN ds;
	END;

	AddToSuperfile_Nod := FUNCTION
		RETURN STD.File.AddSuperFile(
			sprf_Delete_Nod,
			dst_Delete_Nod
		);
	END;

	AddToSuperfile_Reo := FUNCTION
		RETURN STD.File.AddSuperFile(
			sprf_Delete_Reo,
			dst_Delete_Reo
		);
	END;

	// Spray all delete files
	Spray_delete_all := SEQUENTIAL(
		Spray_Delete_Nod,
		Spray_Delete_Reo
	);

	// Transform All Files
	xform_all := PARALLEL(
		OUTPUT(TransformFile_Nod,, dst_Delete_Nod, OVERWRITE, COMPRESSED),
		OUTPUT(TransformFile_Reo,, dst_Delete_Reo, OVERWRITE, COMPRESSED)
	);

	// Add Files to Superfile
	super_all := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		AddToSuperfile_Nod,
		AddToSuperfile_Reo,
		STD.File.FinishSuperFileTransaction()
	);

	EXPORT SprayFile := SEQUENTIAL(
		Spray_delete_all,
		xform_all,
		super_all
	);

END;
