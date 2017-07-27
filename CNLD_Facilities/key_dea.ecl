IMPORT doxie, CNLD_Facilities;

df := CNLD_Facilities.file_Facilities_AID(deanbr != '');
df_dist :=  sort(distribute(df,hash(deanbr,gennum)),deanbr,gennum,local);

df_dedup := DEDUP(df_dist, deanbr,gennum,local);

base_key_name := CNLD_Facilities.thor_cluster + 'key::cnldfacilities::';

EXPORT key_dea := INDEX(df_dedup,
												 {deanbr},
												 {gennum},
							           base_key_name + doxie.Version_SuperKey + '::DEA');