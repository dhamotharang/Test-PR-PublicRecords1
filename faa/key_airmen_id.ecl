Import Data_Services, doxie,ut,faa;

export key_airmen_id (boolean isFCRA = false) := function

df := faa.searchFileAirmen;

Layout_rid := record
	unsigned6 airmen_id;
	faa.layout_airmen_Persistent_ID and not source;
 END;

df_prj := project(df, transform(Layout_rid, self := left));
 
 file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::airmen_id_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_Data400::key::faa::airmen_id_');

return index(df_prj,{unique_id, airmen_id},{df_prj},
                 file_prefix+doxie.Version_SuperKey);


end; 
