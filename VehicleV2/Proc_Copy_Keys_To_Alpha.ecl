IMPORT STD, dops;

EXPORT Proc_Copy_Keys_To_Alpha(
	STRING pVersion,
	STRING envment = 'nonfcra'
) := FUNCTION

	vAlphaDali := 'alpha_prod_thor_dali.risk.regn.net';
	vAlphaEsp := 'alpha_prod_thor_esp.risk.regn.net';
	vDatasetName := 'VehicleV2Keys';
	vDesiredKeysSet := [
		'thor_data400::key::vehiclev2::vin_qa',
		'thor_data400::key::vehiclev2::main_key_qa',
		'thor_data400::key::vehiclev2::party_key_qa'
	];

	roxie_keys_dataset := dops.GetRoxieKeys(vDatasetName,'B','N','N')(
		superkey IN vDesiredKeysSet
	);

	roxie_keys_layout := RECORD, MAXLENGTH(1024)
		STRING superfiles;
		STRING logicalfiles;
	END;

	roxie_keys_layout replaceDate(roxie_keys_dataset l) := TRANSFORM
 		STRING modified_filename := IF(
			envment = 'ct',
			REGEXREPLACE(
				vDatasetName + '_DATE',
				'~'+l.logicalkeys,
				'custtest::'+filedate
			)
			REGEXREPLACE(
				vDatasetName + '_DATE',
				'~'+l.logicalkey,
				pVersion
			);
		 )
		STRING temp_filename := modified_filename[1..LENGTH(modified_filename)-1];
		SELF.superfiles := l.superkey;
		SELF.logicalfiles := IF(
			STD.File.FileExists(temp_filename),
			temp_filename,
			modified_filename
		);
	END;

	temp_dataset := PROJECT(roxie_keys_dataset, replaceDate(left));

	output_dataset := OUTPUT(temp_dataset, NAMED(vDatasetName+'_copyfiles'));

	final_dataset := DATASET(WORKUNIT(vDatasetName+'_copyfiles'), roxie_keys_layout);

	copy_files := NOTHOR(
		APPLY(
			final_dataset,
			IF(
				STD.File.FileExists(logicalfiles),
				IF(
					COUNT(
						STD.File.LogicalFileList(
							REGEXREPLACE('~', logicalfiles, ''),
							foreigndali := vAlphaDali
						)
					) > 0,
					OUTPUT(logicalfiles + ' already exists in ' + vAlphaDali),
					SEQUENTIAL(
						OUTPUT('Copying ' +logicalfiles+ ' to ' + vAlphaEsp),
						STD.File.Copy(
							logicalfiles,
							'thor400_112',
							logicalfiles,
							'uspr-prod-thor-dali.risk.regn.net',
							espServerIPPort := vAlphaEsp + ':8010/FileSpray',
							allowOverwrite := TRUE,
							replicate := TRUE
						),
						OUTPUT(logicalfiles + ' Was successfully copied to ' + vAlphaEsp);
					)
				),
				OUTPUT(logicalfiles + ' does not exist')
			)
		)
	);

	update_dops_alpha_non_fcra := dops.updateversion(
		'VehicleV2Keys',
		pVersion,
		Email_Recipients,,
		'N|B',
		l_inloc := 'A'
	);

	RETURN SEQUENTIAL(
		output_dataset,
		copy_files,
		IF( 
			envment <> 'ct',
			update_dops_alpha_non_fcra
		)
	);

END