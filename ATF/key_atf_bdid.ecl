/*2012-11-05T20:25:39Z (Shannon Lucero)

*/
Import Data_Services, doxie,ut,atf;
	export key_atf_bdid () := function
	
df := ATF.searchFileATF(bdid!='');

		file_prefix := 	Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::atf::firearms::bdid_';
												
	return index(df,{bdid},{bdid,atf_id},file_prefix + doxie.Version_SuperKey);
	
end;

