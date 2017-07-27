IMPORT doxie, CNLD_Facilities;


df := CNLD_Facilities.file_Facilities_AID(npi != '');
df_dist :=  sort(distribute(df,hash(npi,gennum)),npi,gennum,local);

df_dedup := DEDUP(df_dist, npi,gennum,local);

base_key_name := CNLD_Facilities.thor_cluster + 'key::cnldfacilities::';

EXPORT key_npi := INDEX(df_dedup,
												 {npi},
												 {gennum},
							            base_key_name + doxie.Version_SuperKey + '::NPI');