IMPORT Business_Header, ut, roxiekeybuild, VersionControl, PRTE2_Business_Header;

// Proc to build BDL2 keys
export Proc_Build_BDL2_Keys(string pversion) :=
module

  shared keyName		:= PRTE2_business_header.keynames	(pversion)			;
	
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_BDL2_BDID								,keyname.BDL2.BDID.New										,Build_BDL2_BDID_Key										);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_BDL2_BDL									,keyname.BDL2.BDL.New											,Build_BDL2_BDL_Key											);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_BDL2_GroupId							,keyname.BDL2.GroupId.New									,Build_BDL2_GroupId_Key									);
	
	shared keygroupnames := 
				keyname.BDL2.BDID.dAll_filenames
			+ keyname.BDL2.BDL.dAll_filenames
			+ keyname.BDL2.GroupId.dAll_filenames
			; 
	
	Build_Keys :=
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroupnames)
		,parallel(
			 Build_BDL2_BDID_Key
			,Build_BDL2_BDL_Key
			,Build_BDL2_GroupId_Key

		)) : success(output('Build PRTE BDL2 Keys Complete'));
	
	export all := sequential(
		 Build_Keys
		,PRTE2_business_header.promote(pversion,'~prte*key::business_header.bdl2').new2built
	);
	
	
end;