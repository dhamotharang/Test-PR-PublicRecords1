IMPORT _Control, RoxieKeyBuild, VersionControl, ut;

EXPORT Build_All(STRING	pversion) := MODULE
  EXPORT spray_files := fSpray;

	EXPORT dkeybuild := Update_Base(Files().Input.Using);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).Keybuild.New
																				,dkeybuild
																				,Build_KeyBuild_File);

	dNewBase := PROJECT(Files(pversion).Keybuild.Logical, TRANSFORM(Layouts.Base, SELF := LEFT;));
  VersionControl.macBuildNewLogicalFile(Filenames(pversion).Base.New
																				,dNewBase
																				,Build_Base_File);

	dops_update := RoxieKeyBuild.updateversion('CNLDPracKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N'); 															

	full_build := SEQUENTIAL(
														NOTHOR(APPLY(Filenames().Input.dAll_superfilenames, VersionControl.mUtilities.createsuper(name)))
													 ,NOTHOR(APPLY(Filenames().Base.dAll_filenames, APPLY(dSuperfiles, VersionControl.mUtilities.createsuper(name))))
													 ,spray_files
													 ,Promote().Input.Sprayed2Using
													 ,Build_KeyBuild_File
													 ,Build_Base_File
													 ,FileServices.ClearSuperFile(Filenames(pversion).Keybuild.Built, TRUE)
													 ,FileServices.AddSuperFile(Filenames(pversion).Keybuild.Built, Filenames(pversion).Keybuild.Logical)
													 ,Promote().Input.Using2Used
													 ,Promote(pversion).New2Built
													 ,Promote().Built2QA
													 ,Proc_Build_Autokeys(pversion)
													 ,Proc_Build_RoxieKeys(pversion)
													 // ,out_STRATA_population_stats(pversion)
													 // ,New_records_sample
													 // ,dops_update
													) : SUCCESS(Send_Email(pversion).BuildSuccess), FAILURE(Send_Email(pversion).BuildFailure);

	EXPORT All := IF(VersionControl.IsValidVersion(pversion)
									 ,full_build
									 ,OUTPUT('No Valid version parameter passed, skipping build'));
END;