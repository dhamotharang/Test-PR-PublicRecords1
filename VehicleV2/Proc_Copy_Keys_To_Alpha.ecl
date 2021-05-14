IMPORT STD, ut, dops, _Control;

EXPORT Proc_Copy_Keys_To_Alpha(
	STRING  pVersion
) := FUNCTION
	dUserCreds := ut.Credentials().fGetAppUserInfo();
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

	temp_dataset := PROJECT(
		roxie_keys_dataset,
		replaceDate(left)
	);

	vTargetCluster := STD.System.Job.Target(); 

	vCluster := MAP(
		REGEXFIND('_eclcc',vTargetCluster) AND _Control.ThisEnvironment.Name = 'Dataland' => 'hthor_dev_eclcc',
		REGEXFIND('_eclcc',vTargetCluster) AND _Control.ThisEnvironment.Name <> 'Dataland' => 'hthor_eclcc',
        REGEXFIND('_eclcc',vTargetCluster) = false AND _Control.ThisEnvironment.Name = 'Dataland' => 'hthor_dev',
		'hthor'
	);

	fECLText( STRING vLogicalfiles ) := FUNCTION 
		vECLText := '#WORKUNIT(\'name\',\'Remote Pull -- ' + vDatasetName + '-- ' + pVersion + '\');\n' 
			+ 'IF(\n'
			+ '\tCOUNT(\n'
			+ '\t\tSTD.File.LogicalFileList(\n'
			+ '\t\t\tREGEXREPLACE(\'~\', \'' + vLogicalfiles + '\', \'\'),\n'
			+ '\t\t\tforeigndali := \'alpha_prod_thor_dali.risk.regn.net\'\n'
			+ '\t\t)'
			+ '\t) > 0,\n'
			+ '\tOUTPUT(\'' + vLogicalfiles + ' already exists in alpha_prod_thor_dali.risk.regn.net\'),\n'
			+ '\tSEQUENTIAL(\n'
			+ '\t\tOUTPUT(\'Copying ' + vLogicalfiles + ' to alpha_prod_thor_dali.risk.regn.net\'),\n'
			+ '\t\tSTD.File.RemotePull(\n'
			+ '\t\t\tremoteEspFsURL := \'http://alpha_prod_thor_dali.risk.regn.net:8010/FileSpray\',\n'
			+ '\t\t\tsourcelogicalname := \'' + vLogicalfiles + '\',\n'
			+ '\t\t\tdestinationGroup := \'thor400_112\',\n'
			+ '\t\t\tdestinationlogicalname := \'' + vLogicalfiles + '\',\n'
			+ '\t\t\tallowoverwrite := TRUE,\n'
			+ '\t\t\treplicate := TRUE,\n'
			+ '\t\t\tusername := \'' + dUserCreds[1].username + '\',\n'
			+ '\t\t\tuserPw := \'' + dUserCreds[1].password + '\'\n'
			+ '\t\t),\n'
			+ '\t\tOUTPUT(\'' + vLogicalfiles + ' Was successfully copied to alpha_prod_thor_dali.risk.regn.net\')\n'
			+ '\t)\n'
			+ ');';
		RETURN vECLText;
	END;

	copy_files := APPLY(
		temp_dataset, 
		IF(
			STD.File.FileExists(logicalfiles),
			SEQUENTIAL(
				OUTPUT('I am in here');
				EVALUATE(
					_Control.fSubmitNewWorkunit(
						fECLText(logicalfiles),
						TRIM(vCluster)	
					)
				)
			),
			OUTPUT(logicalfiles + ' does not exist')
		)
	);

	RETURN copy_files;

END;
