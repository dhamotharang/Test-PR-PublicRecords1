import ut, VersionControl, tools;
ut.MAC_SF_BuildProcess(IVerification ,file_iverification.name, iverification_base,3,,true, version);

VersionControl.macBuildNewLogicalKey(Keys_Iverification(version,false).did_phone.New	,BuildDidPhoneKey);
VersionControl.macBuildNewLogicalKey(Keys_Iverification(version,false).phone.New	,BuildPhoneKey);

promote_f := tools.mod_PromoteBuild(version,Keynames_Iverification(version).dAll_filenames,'',false,false);

EXPORT Proc_Build_Iverification := 
										sequential(
										iverification_base,
										BuildDidPhoneKey,
										BuildPhoneKey,
										promote_f.New2Built,
										promote_f.Built2QA);