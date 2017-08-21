//Defines full build process
IMPORT _control, versioncontrol,HMS_Medicaid_NE,HMS_Medicaid_Common;

EXPORT Build_Base(string			pversion
									,boolean		pUseProd	= false
									,dataset(HMS_Medicaid_Common.Layouts.Base_NE)pBaseFile	= HMS_Medicaid_NE.Files().Base.qa):= MODULE
   
	SHARED build_base		:= HMS_Medicaid_NE.Update_Base(pversion,pUseProd)._Base;
	VersionControl.macBuildNewLogicalFile(
															HMS_Medicaid_Common.Filenames('NE',pversion,pUseProd).Base.new
															,build_base
															,Build_Base_File,,,true);
															
													
																																
	EXPORT full_build :=
		sequential(
			Build_Base_File
			,HMS_Medicaid_Common.Promote('NE',pversion,pUseProd).buildfiles.New2Built
		);// : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	EXPORT All :=
		if(VersionControl.IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping build',overwrite)
		);

END; // Module
