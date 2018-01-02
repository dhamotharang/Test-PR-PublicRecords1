import address, address_Attributes, doxie, data_services;

bankrupt_slim := Address_Attributes.file_bankruptcy;

cleaned := bankrupt_slim(zip !='' and 
												prim_range !='' and 
												prim_name !='' and 
												addr_suffix !='');
								
export key_bankruptcy_address := index(cleaned,{
																		zip, 
																		prim_range, 
																		prim_name, 
																		addr_suffix, 
																		predir, 
																		postdir},
																		{cleaned},
																		data_services.data_location.prefix() + 'thor_data400::key::'+doxie.Version_SuperKey+'::bankruptcy::address');
