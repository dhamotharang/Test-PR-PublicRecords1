Import Data_Services, doxie,ut,faa;

export key_airmen_rid (boolean isFCRA = false) := function

df := faa.searchFileAirmen;

Layout_rid := record
	unsigned6 airmen_id;
	faa.layout_airmen_Persistent_ID and not source;
 END;

df_prj := project(df, transform(Layout_rid, self := left));

file_prefix := if (IsFCRA, 
										Data_Services.Data_location.Prefix('FAA')+'thor_data400::key::faa::FCRA::airmen_rid_',
                    Data_Services.Data_location.Prefix('FAA')+'thor_Data400::key::faa::airmen_rid_');

return  index(df_prj,{airmen_id,unique_id},{df_prj},
                  file_prefix+ doxie.Version_SuperKey);

end;