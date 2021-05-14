IMPORT STD, dops, Orbit3Insurance, ut;

EXPORT Proc_Copy_Keys_To_Alpha(
	STRING  pVersion,
	STRING  pEnv = 'N',
	STRING  pContacts,
	BOOLEAN pTesting = FALSE
) := FUNCTION
	dUserCreds := ut.Credentials().fGetAppUserInfo();
	vDatasetName := 'VehicleV2Keys';
	vDesiredKeysSet := [
		'thor_data400::key::vehiclev2::vin_qa',
		'thor_data400::key::vehiclev2::main_key_qa',
		'thor_data400::key::vehiclev2::party_key_qa'
	];
	vContacts := pContacts + ',' + 'kerry.wood@lexisnexisrisk.com';

	vCommand := 'server=http://alpha_prod_thor_esp.risk.regn.net:8010 ' 
		+ 'overwrite=1 ' 
		+ 'replicate=1 ' 
		+ 'action=copy ' 
		+ 'dstcluster=thor400_112 ' 
		+ 'nosplit=1 '
		+ 'wrap=1 '
		+ 'srcdali=10.173.14.201 '
		+ 'username=' + dUserCreds[1].username + ' password='+ dUserCreds[1].password
		+ ' transferbuffersize=10000000 ';

	roxie_keys_dataset := dops.GetRoxieKeys(vDatasetName,'B','N','N')(
		superkey IN vDesiredKeysSet
	);

	roxie_keys_layout := RECORD, MAXLENGTH(1024)
		STRING superfiles;
		STRING logicalfiles;
	END;

	roxie_keys_layout replaceDate(roxie_keys_dataset l) := TRANSFORM
 		STRING modified_filename := REGEXREPLACE(
			vDatasetName + '_DATE',
			'~'+l.logicalkey,
			pVersion
		);
		STRING temp_filename := modified_filename[1..LENGTH(modified_filename)-1];
		SELF.superfiles := l.superkey;
		SELF.logicalfiles := IF(
			STD.File.FileExists(temp_filename),
			temp_filename,
			modified_filename
		);
	END;

	temp_dataset := NOTHOR(
		PROJECT(
			GLOBAL(roxie_keys_dataset,few),
			replaceDate(left)
		)
	);

	copy_files := NOTHOR(
		APPLY(
			GLOBAL(temp_dataset,few), 
			IF(
				STD.File.FileExists(logicalfiles),
				IF(
					COUNT(
						STD.File.LogicalFileList(
							REGEXREPLACE('~', logicalfiles, ''),
							foreigndali := 'alpha_prod_thor_dali.risk.regn.net'
						)
					) > 0,
					OUTPUT(logicalfiles + ' already exists in alpha_prod_thor_dali.risk.regn.net'),
					SEQUENTIAL(
						OUTPUT('Copying ' +logicalfiles+ ' to alpha_prod_thor_dali.risk.regn.net'),
						STD.File.DfuPlusExec(vCommand + ' dstname=~'+logicalfiles + ' srcname=~'+logicalfiles),
						OUTPUT(logicalfiles + ' Was successfully copied to alpha_prod_thor_dali.risk.regn.net')
					)
				),
				OUTPUT(logicalfiles + ' does not exist')
			)
		)
	);

	RETURN copy_files;
END;
