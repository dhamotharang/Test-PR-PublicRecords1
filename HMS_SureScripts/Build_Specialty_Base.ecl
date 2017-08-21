//Defines full build process
IMPORT _control, versioncontrol,HMS_SureScripts;

EXPORT Build_Specialty_Base(string			pversion
									,boolean		pUseProd	= false
									,dataset(HMS_SureScripts.Layouts.Base_Spec_Codes)pBaseFile	= HMS_SureScripts.Specialty_Files().Base.qa):= MODULE
   
	SHARED Build_Specialty_Base		:= Update_Specialty_Base(pversion,pUseProd)._Base;
	VersionControl.macBuildNewLogicalFile(
															HMS_SureScripts.Filenames_SpecCodes(pversion,pUseProd).Base.new
															,Build_Specialty_Base
															,Build_Specialty_Base_File,,,true);
															
													
																																
	EXPORT full_build :=
		sequential(
			Build_Specialty_Base_File
			,Promote_SpecCodes(pversion,pUseProd).buildfiles.New2Built
		) : success(send_email(pversion).buildsuccess), failure(send_email(pversion).buildfailure);

	EXPORT All :=
		if(VersionControl.IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping build',overwrite)
		);

END; // Module
