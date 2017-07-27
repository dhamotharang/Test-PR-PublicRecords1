import ut;
export BWR_Build_Email(version) := function

#workunit('name','Email Data ' + version);

email_base := Build_base(version);

ut.MAC_SF_BuildProcess(email_base,'~thor_data400::base::email_data' ,build_email_base,2,,true);

Build_all_keys := Build_keys(version);
zDoPopulationStats:=Strata_Stat_Email(version,File_Email_Base);

SampleRecs := choosen(sort(File_Email_Base,record),1000);
					
built := sequential(
			build_email_base
			,Build_all_keys
			,zDoPopulationStats
			,output(SampleRecs)
			)
			: success(Send_Email(Version).Build_Success)
			, failure(Send_Email(Version).Build_Failure)
			;

return built;

end;