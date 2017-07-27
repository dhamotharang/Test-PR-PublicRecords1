import address, address_Attributes, doxie, ut, bankruptcyv2, risk_indicators;

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
																		'~thor_data400::key::'+doxie.Version_SuperKey+'::bankruptcy::address');
