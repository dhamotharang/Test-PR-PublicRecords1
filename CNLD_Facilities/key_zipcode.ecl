IMPORT doxie, CNLD_Facilities;

df := CNLD_Facilities.file_Facilities_AID(addr_zip != '');
df_dist :=  sort(distribute(df,hash(addr_zip,gennum)),addr_zip,gennum,local);

df_dedup := DEDUP(df_dist, addr_zip,gennum,local);

base_key_name := CNLD_Facilities.thor_cluster + 'key::cnldfacilities::';

EXPORT key_zipcode := INDEX(df_dedup,
												 {addr_zip},
												 {gennum},
							           base_key_name + doxie.Version_SuperKey + '::ZIPCODE');
												