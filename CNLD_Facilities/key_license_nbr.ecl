IMPORT doxie, CNLD_Facilities;


df := CNLD_Facilities.file_Facilities_AID(st_lic_num != '');
df_dist :=  sort(distribute(df,hash(st_lic_num,st_lic_in,gennum)),st_lic_num,st_lic_in,gennum,local);

df_dedup := DEDUP(df_dist, st_lic_num,st_lic_in,gennum,local);

base_key_name := CNLD_Facilities.thor_cluster + 'key::cnldfacilities::';

EXPORT key_license_nbr := INDEX(df_dedup,
												 {st_lic_num,st_lic_in},
												 {gennum},
												  base_key_name + doxie.Version_SuperKey + '::LICENSE_NBR');