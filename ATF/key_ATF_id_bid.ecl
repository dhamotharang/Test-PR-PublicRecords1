/*2012-11-05T20:25:40Z (Shannon Lucero)

*/
Import Data_Services, doxie,ut;
export key_ATF_id_bid () := function

df := ATF.searchFileATF_Bid;

	file_prefix := Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::atf::firearms::bid::atfid_' + doxie.Version_SuperKey;

	return index(df,{ATF_id},{df},file_prefix);

end;
