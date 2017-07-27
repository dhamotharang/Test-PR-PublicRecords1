import ut, roxiekeybuild;

export Proc_Build_Keys_Linkids(string filedate) := function

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Build all keys + superkey manipulation
//////////////////////////////////////////////////////////////////////////////////////////////
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_0010_Header_linkids.key,													keynames_Linkids(filedate).Versions.k0010_header_Linkids.New,														'',build_0010_Header_linkids_key);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_1000_Executive_Summary_Linkids.key,								keynames_Linkids(filedate).Versions.k1000_executive_summary_Linkids.New,								'',build_1000_Executive_Summary_linkids_key);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_4510_UCC_Filings_Linkids.key,											keynames_Linkids(filedate).Versions.k4510_ucc_filings_Linkids.New,											'',build_4510_UCC_Filings_linkids_key);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_5600_Demographic_Data_Linkids.key,								keynames_Linkids(filedate).Versions.k5600_demographic_data_Linkids.New,									'',build_5600_Demographic_Data_linkids_key);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_5610_Demographic_Data_Linkids.key,								keynames_Linkids(filedate).Versions.k5610_demographic_data_Linkids.New,									'',build_5610_Demographic_Data_linkids_key)

                                                                                 
Build_Keys := parallel(
    build_0010_Header_Linkids_key
   ,build_1000_Executive_Summary_Linkids_key
	 ,build_4510_UCC_Filings_Linkids_key
   ,build_5600_Demographic_Data_Linkids_key
   ,build_5610_Demographic_Data_Linkids_key	
);
/*
Build_Keys2 := parallel(
		build_4510_UCC_Filings_Linkids_key
   ,build_5600_Demographic_Data_Linkids_key
   ,build_5610_Demographic_Data_Linkids_key	 
);
Build_Keys := sequential(
	 Build_Keys1
	,Build_Keys2
);
*/
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames_Linkids(filedate).Versions.k0010_header_Linkids.New,													KeyName_0010_Header_Linkids,														Move_0010_Header_Linkids_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames_Linkids(filedate).Versions.k1000_executive_summary_Linkids.New,								KeyName_1000_Executive_Summary_Linkids,									Move_1000_Executive_Summary_Linkids_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames_Linkids(filedate).Versions.k4510_ucc_filings_Linkids.New,											KeyName_4510_UCC_Filings_Linkids,												Move_4510_UCC_Filings_Linkids_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames_Linkids(filedate).Versions.k5600_demographic_data_Linkids.New,								KeyName_5600_Demographic_Data_Linkids,									Move_5600_Demographic_Data_Linkids_key, 2);
RoxieKeyBuild.Mac_SK_Move_To_Built(keynames_Linkids(filedate).Versions.k5610_demographic_data_Linkids.New,								KeyName_5610_Demographic_Data_Linkids,									Move_5610_Demographic_Data_Linkids_key, 2);



Move_Keys := sequential(
	 Move_0010_Header_Linkids_key
	,Move_1000_Executive_Summary_Linkids_key
	,Move_4510_UCC_Filings_Linkids_key
	,Move_5600_Demographic_Data_Linkids_key
	,Move_5610_Demographic_Data_Linkids_key	
);


//////////////////////////////////////////////////////////////////////////////////////////////
// -- Execute all
//////////////////////////////////////////////////////////////////////////////////////////////
retval := sequential(
	 Build_Keys
	,Move_Keys
);

return retval;

end;
