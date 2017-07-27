IMPORT doxie, CNLD_Facilities;

df := CNLD_Facilities.file_Facilities_AID(gennum != '');

df_dist :=  distribute(df,hash(gennum));
df_dedup := DEDUP(SORT(df, gennum,local), RECORD);

base_key_name := CNLD_Facilities.thor_cluster + 'key::cnldfacilities::';

EXPORT key_gennum :=
         INDEX(df_dedup,
					     {gennum},
							 {df},
							 base_key_name + doxie.Version_SuperKey + '::GENNUM');