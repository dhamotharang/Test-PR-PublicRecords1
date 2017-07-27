IMPORT doxie, CNLD_Facilities;

df := CNLD_Facilities.file_Facilities_AID(BDID != 0);
df_dist :=  sort(distribute(df,hash(bdid,gennum)),bdid,gennum,local);

df_dedup := DEDUP(df_dist, bdid,gennum,local);

base_key_name := CNLD_Facilities.thor_cluster + 'key::cnldfacilities::';

EXPORT key_BDID := INDEX(df_dedup,
												 {bdid},
												 {gennum},
							           base_key_name + doxie.Version_SuperKey + '::BDID');
												
												 
