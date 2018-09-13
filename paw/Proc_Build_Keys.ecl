import  versioncontrol,DOPSGrowthCheck,dops;

export Proc_Build_Keys(

	string pversion

) :=
function

	shared keyName	:= keynames(pversion);

	VersionControl.macBuildNewLogicalKeyWithName(Key_did								,keyName.Did.New								,Build_Key1);
	VersionControl.macBuildNewLogicalKeyWithName(Key_bdid								,keyName.bdid.New								,Build_Key2);
	VersionControl.macBuildNewLogicalKeyWithName(Key_contactID					,keyName.contactid.New					,Build_Key3);
	VersionControl.macBuildNewLogicalKeyWithName(Key_companyname_domain	,keyName.companyname_domain.New	,Build_Key4);
	VersionControl.macBuildNewLogicalKeyWithName(Key_DID_FCRA						,keyName.fcra.Did_FCRA.New			,Build_Key5);
	VersionControl.macBuildNewLogicalKeyWithName(Key_LinkIDs.key				,keyName.LinkIDs.New						,Build_LinkIDs);
	
	GetDops:=dops.GetDeployedDatasets('P','B','F');
	OnlyPAW:=GetDops(datasetname='FCRA_PAWV2Keys');
	
	father_pversion := OnlyPAW[1].buildversion;
	filename := '~thor_data400::key::paw::'+pversion+'::did_fcra';
	father_filename := '~thor_data400::key::paw::'+father_pversion+'::did_fcra';
	set of string key_PAW_InputSet:=['did','bdid','ssn','company_name','company_prim_range','company_predir','company_prim_name','company_addr_suffix','company_unit_desig','company_sec_range','company_city','company_state','company_zip','company_title','company_phone','company_fein','fname','mname','lname','name_suffix','prim_range','predir','prim_name','addr_suffix','unit_desig','sec_range','city','state','zip','phone','email_address','source','vendor_id'];

	DeltaCommands:=sequential(
	DOPSGrowthCheck.CalculateStats('FCRA_PAWV2Keys','paw.Key_DID_FCRA','key_PAW_fcra',filename,'did','contact_id','','','','',pversion,father_pversion),
	DOPSGrowthCheck.DeltaCommand(filename,father_filename,'FCRA_PAWV2Keys','key_PAW_fcra','paw.Key_DID_FCRA','contact_id',pversion,father_pversion,key_PAW_InputSet),
	DOPSGrowthCheck.ChangesByField(filename,father_filename,'FCRA_PAWV2Keys','key_PAW_fcra','paw.Key_DID_FCRA','contact_id','',pversion,father_pversion),
	DopsGrowthCheck.PersistenceCheck(filename,father_filename,'FCRA_PAWV2Keys','key_PAW_fcra','paw.Key_DID_FCRA','contact_id',key_PAW_InputSet,key_PAW_InputSet,pversion,father_pversion),
	);

	

	keygroupnames := 
				keyName.Did.dAll_filenames                                                                           
			+ keyName.Bdid.dAll_filenames
			+ keyName.contactid.dAll_filenames
			+ keyName.companyname_domain.dAll_filenames
			+ keyName.fcra.Did_FCRA.dAll_filenames
			+ keyName.LinkIDs.dAll_filenames
	 	; 

	build_keys :=
		parallel(
			 Build_Key1
			,Build_Key2
			,Build_Key3
			,Build_Key4
			,Build_Key5
			,Build_LinkIDs
		);

	buildall := 
	sequential(
		if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroupnames)
			,build_keys
		)
		,promote(pversion,'^(?!.*autokey).*$').new2built,
		DeltaCommands
	);
	
	return buildall ;

end;