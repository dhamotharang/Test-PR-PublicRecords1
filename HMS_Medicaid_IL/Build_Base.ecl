//Defines full build process
IMPORT _control, versioncontrol,HMS_Medicaid_IL,HMS_Medicaid_Common;

EXPORT Build_Base(string			pversion
									,boolean		pUseProd	= false
									,dataset(HMS_Medicaid_Common.Layouts.Base_IL)pBaseFile	= HMS_Medicaid_IL.Files().Base.qa):= MODULE
   
	SHARED build_base		:= HMS_Medicaid_IL.Update_Base(pversion,pUseProd)._Base;
	VersionControl.macBuildNewLogicalFile(
															HMS_Medicaid_Common.Filenames('IL',pversion,pUseProd).Base.new
															,build_base
															,Build_Base_File,,,true);
															
													
																																
	EXPORT full_build :=
		sequential(
			Build_Base_File
			,HMS_Medicaid_COmmon.Promote('IL',pversion,pUseProd).buildfiles.New2Built
		);// : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	EXPORT All :=
		if(VersionControl.IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping build',overwrite)
		);

END; // Module
