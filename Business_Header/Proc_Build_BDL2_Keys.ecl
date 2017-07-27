IMPORT Business_Header, ut, roxiekeybuild, VersionControl;

// Proc to build BDL2 keys
// Note :- This is an independent process only used in case of building the BDL2 keys seperately with
// out the business header build.
export Proc_Build_BDL2_Keys(string pversion) :=
module

  shared keyName		:= business_header.keynames	(pversion)			;
	
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

		)) : success(output('Build BDL2 Keys Complete'));
	
	export all := sequential(
		 Build_Keys
		,business_header.promote(pversion,'key::business_header.bdl2').new2built
		,business_header.promote(pversion,'key::business_header.bdl2').new2qa
	);
	
	
end;