import address_attributes, doxie, data_services;

//liens file build
liens_and_main_slimmed := Address_Attributes.file_liens;

cleaned := liens_and_main_slimmed(zip !='' and 
																	prim_range !='' and 
																	prim_name !='' and 
																	addr_suffix !='');
								
export key_liens_address := index(cleaned,{
																		zip, 
																		prim_range, 
																		prim_name, 
																		addr_suffix, 
																		predir, 
																		postdir, 
																		sec_range},
																		{cleaned},data_services.data_location.prefix() + 'thor_Data400::key::neighborhood::'+ doxie.Version_SuperKey + '::Liens_Evictions::address');

