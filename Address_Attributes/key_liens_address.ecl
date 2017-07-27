import address, address_attributes, doxie, doxie_files, watchdog, liensv2, ut, risk_indicators;

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
																		{cleaned},'~thor_Data400::key::neighborhood::'+ doxie.Version_SuperKey + '::Liens_Evictions::address');

