/*2012-11-05T20:25:40Z (Shannon Lucero)

*/
Import Data_Services,doxie,ut,atf;
	export key_ATF_id (boolean isFCRA = FALSE) := function

df := ATF.searchFileATF;

	file_prefix := if (IsFCRA,
											Data_Services.Data_location.Prefix('ATF')+'thor_data400::key::atf::firearms::fcra::'+ doxie.Version_SuperKey+'::atfid',
											Data_Services.Data_location.Prefix('ATF')+'thor_data400::key::atf::firearms::atfid_'+ doxie.Version_SuperKey);

	return index(df,{ATF_id},{df},file_prefix);
	
end;



