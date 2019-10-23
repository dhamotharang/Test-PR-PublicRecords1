import ut, VersionControl, tools;

EXPORT Proc_Build_Iverification(string pversion) := function

ut.MAC_SF_BuildProcess(IVerification ,file_iverification.name, iverification_base,3,,true, pversion);

VersionControl.macBuildNewLogicalKey(Keys_Iverification(pversion,false).did_phone.New	,BuildDidPhoneKey);
VersionControl.macBuildNewLogicalKey(Keys_Iverification(pversion,false).phone.New	,BuildPhoneKey);

promote_f := tools.mod_PromoteBuild(pversion,Keynames_Iverification(pversion).dAll_filenames,'',false,false);

return
										sequential(
										iverification_base,
										BuildDidPhoneKey,
										BuildPhoneKey,
										promote_f.New2Built,
										promote_f.Built2QA);
end;