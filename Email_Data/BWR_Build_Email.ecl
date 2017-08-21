import ut, RoxieKeyBuild, PromoteSupers;

#OPTION('multiplePersistInstances',FALSE);

export BWR_Build_Email(version, string emailList='') := function
#workunit('name','Email Data ' + version);

//email_base := Build_base(version).rollup_with_history_misc; --Replaced by SCRUBS process which incorporates the base build + output
email_fcra_base := Build_base(version).rollup_email_orig;

//ut.MAC_SF_BuildProcess(email_base,'~thor_data400::base::email_data' ,build_email_base,2,,true);
PromoteSupers.MAC_SF_BuildProcess(email_fcra_base(email_src not in Email_Data.FCRA_Src_Filter),'~thor_data400::base::email_data_fcra' ,build_email_base_fcra,2,,true);

Build_all_keys := Build_keys(version);
zDoPopulationStats:=Strata_Stat_Email(version,File_Email_Base);
zDoPopulationVendorStats:=Strata_Stat_Vendor(version,File_Email_Base);

non_FCRA_update :=  RoxieKeyBuild.updateversion('EmailDataKeys',(string)version,'randy.reyes@lexisnexis.com',,'N');
FCRA_update :=  RoxieKeyBuild.updateversion('FCRA_EmailDataKeys',(string)version,'randy.reyes@lexisnexis.com',,'F');

SampleRecs := choosen(sort(File_Email_Base,record),1000);
					
built := sequential(
			Email_data.proc_Scrubs_base((string)version,emailList)
			//build_email_base
			,build_email_base_fcra
			,Build_all_keys
			,zDoPopulationStats
			,zDoPopulationVendorStats
			,output(SampleRecs)
			,non_FCRA_update
			,FCRA_update
			)
			: success(Send_Email(Version).Build_Success)
			, failure(Send_Email(Version).Build_Failure)
			;

return built;

end;