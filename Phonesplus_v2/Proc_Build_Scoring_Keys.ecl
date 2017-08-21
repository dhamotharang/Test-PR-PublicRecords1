import ut, VersionControl, tools;

ut.MAC_SF_BuildProcess(Fn_File_Scoring() ,'~thor_data400::base::phonesplusv2_scoring',scoring_base,2,,true, Phonesplus_v2.version);

VersionControl.macBuildNewLogicalKey(Keys_Scoring(version,false).Address.New	,BuildAddressKey);
VersionControl.macBuildNewLogicalKey(Keys_Scoring(version,false).Phone.New	,BuildPhoneKey);

promote_f := tools.mod_PromoteBuild(version,Keynames_Scoring(version).dAll_filenames,'',false,false);

EXPORT  Proc_Build_Scoring_Keys := 
										sequential(
										scoring_base,
										BuildAddressKey,
										BuildPhoneKey,
										promote_f.New2Built,
										promote_f.Built2QA);