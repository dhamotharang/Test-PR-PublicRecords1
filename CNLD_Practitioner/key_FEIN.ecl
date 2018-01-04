IMPORT doxie, CNLD_Practitioner, data_services;

KeyBase := dedup(sort(distribute(CNLD_Practitioner.Files().KeyBuild.Built(Tax_ID != ''),hash(tax_id)),tax_id,gennum,local),tax_id,gennum,local);

EXPORT key_FEIN := INDEX(KeyBase,
												{Tax_ID},
												{gennum},
							          data_services.data_location.prefix() + 'thor_data400::key::CNLD_Practitioner::' + doxie.Version_SuperKey + '::TAXID');