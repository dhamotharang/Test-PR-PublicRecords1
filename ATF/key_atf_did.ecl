/*2012-11-05T20:25:40Z (Shannon Lucero)

*/
Import Data_Services, doxie,ut,atf;
	export key_atf_did (boolean isFCRA = FALSE) := function

df := ATF.searchFileATF(did != 0);

didout_rmv	:= record
	recordof (ATF_Layout_SearchFile and not [did_out, persistent_record_id, lf]);
end;

df_didout_rmv	:= project(df, transform(didout_rmv, self := left));


		file_prefix := if (IsFCRA,
												Data_Services.Data_location.Prefix('ATF')+'thor_data400::key::atf::firearms::fcra::'+ doxie.Version_SuperKey+'::did',
												Data_Services.Data_location.Prefix('ATF')+'thor_data400::key::atf::firearms::did_'+ doxie.Version_SuperKey);

	return index(df_didout_rmv,{did},{atf_id},file_prefix);
	
end;
