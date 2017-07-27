IMPORT doxie, CNLD_Facilities;


df := CNLD_Facilities.file_Facilities_AID(cln_ssn_taxid != '');
df_dist :=  sort(distribute(df,hash(cln_ssn_taxid,gennum)),cln_ssn_taxid,gennum,local);

df_dedup := DEDUP(df_dist, cln_ssn_taxid,gennum,local);

base_key_name := CNLD_Facilities.thor_cluster + 'key::cnldfacilities::';

EXPORT key_FEIN := INDEX(df_dedup,
												 {cln_ssn_taxid},
												 {gennum},
							            base_key_name + doxie.Version_SuperKey + '::FEIN');