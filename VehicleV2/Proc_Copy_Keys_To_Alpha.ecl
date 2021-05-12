IMPORT STD, dops, Orbit3Insurance, ut;

EXPORT Proc_Copy_Keys_To_Alpha(
	STRING  pVersion,
	STRING  pEnv = 'N',
	STRING  pContacts,
	BOOLEAN pTesting = FALSE
) := FUNCTION
	dUserCreds := ut.Credentials().fGetAppUserInfo();	

	vRemoteUrl := 'http://alpha_prod_thor_esp.risk.regn.net:8010/FileSpray';

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

	temp_dataset := PROJECT(roxie_keys_dataset, replaceDate(left));

	copy_files :=APPLY(
		temp_dataset, 
		IF(
			STD.File.FileExists(logicalfiles),
			IF(
				COUNT(
					STD.File.LogicalFileList(
						REGEXREPLACE('~', logicalfiles, ''),
						foreigndali := vRemoteUrl
					)
				) > 0,
				OUTPUT(logicalfiles + ' already exists in ' + vRemoteUrl),
				SEQUENTIAL(
					OUTPUT('Copying ' +logicalfiles+ ' to ' + vRemoteUrl),
					STD.File.RemotePull(
						remoteEspFsURL := vRemoteUrl,
						sourcelogicalname := logicalfiles,
						destinationGroup := 'thor400_112',
						destinationlogicalname := logicalfiles,
						allowoverwrite := TRUE,
						replicate := TRUE,
						username := dUserCreds[1].username,
						userPw := dUserCreds[1].password
					),
					OUTPUT(logicalfiles + ' Was successfully copied to ' + vRemoteUrl)
				)
			),
			OUTPUT(logicalfiles + ' does not exist')
		)
	);

	update_dops_alpha_non_fcra := dops.updateversion(
		'VehicleV2Keys',
		pVersion,
		pContacts,
		l_inenvment := pEnv,
		l_inloc := 'A'
	);

	create_insurance_orbit_build_instance := Orbit3Insurance.Proc_Orbit3I_CreateBuild(
		'Motor Vehicle Registrations',
		pVersion,
		pEnv,
		email_list := STD.Str.FindReplace(pContacts, ',', ';')
	);

	RETURN SEQUENTIAL(
		copy_files,
		IF( 
			NOT pTesting,
			update_dops_alpha_non_fcra
		),
		IF(
			NOT pTesting,
			create_insurance_orbit_build_instance	
		)
	);
END;
