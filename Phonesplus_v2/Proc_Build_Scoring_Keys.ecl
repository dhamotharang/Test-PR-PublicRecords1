import ut, VersionControl, tools;

export Proc_Build_Scoring_Keys (string pversion):= function
ut.MAC_SF_BuildProcess(Fn_File_Scoring() ,'~thor_data400::base::phonesplusv2_scoring',scoring_base,2,,true, pversion);

VersionControl.macBuildNewLogicalKey(Keys_Scoring(pversion,false).Address.New	,BuildAddressKey);
VersionControl.macBuildNewLogicalKey(Keys_Scoring(pversion,false).Phone.New	,BuildPhoneKey);

promote_f := tools.mod_PromoteBuild(pversion,Keynames_Scoring(pversion).dAll_filenames,'',false,false);

return 							sequential(
										scoring_base,
										BuildAddressKey,
										BuildPhoneKey,
										promote_f.New2Built,
										promote_f.Built2QA);
end;