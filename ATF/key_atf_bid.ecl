/*2012-11-05T20:25:40Z (Shannon Lucero)

*/
Import Data_Services, doxie,ut,atf;
	export key_atf_bid () := function
	
df := ATF.searchFileATF_Bid(bdid!='');

		file_prefix :=	Data_Services.Data_location.Prefix('ATF')+'thor_data400::key::atf::firearms::bid_'+ doxie.Version_SuperKey;
												
	return index(df,{bdid},{bdid,atf_id},file_prefix);
	
end;
