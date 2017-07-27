IMPORT doxie, CNLD_Facilities;


df := CNLD_Facilities.file_Facilities_AID(ncpdpnbr != '');
df_dist :=  sort(distribute(df,hash(ncpdpnbr,gennum)),ncpdpnbr,gennum,local);

df_dedup := DEDUP(df_dist, ncpdpnbr,gennum,local);

base_key_name := CNLD_Facilities.thor_cluster + 'key::cnldfacilities::';

EXPORT key_ncpdp := INDEX(df_dedup,
												 {ncpdpnbr},
												 {gennum},
							            base_key_name + doxie.Version_SuperKey + '::NCPDP');