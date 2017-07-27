/*2012-11-05T20:25:43Z (Shannon Lucero)

*/
Import Data_Services, doxie,ut,atf;
	export key_atf_lnum () := function
	
df := ATF.searchFileATF;

		file_prefix :=	Data_Services.Data_location.Prefix('ATF')+'thor_data400::key::atf::firearms::lnum_'+ doxie.Version_SuperKey;

	return index(df,{license_number},{license_number,atf_id},file_prefix);

end;

