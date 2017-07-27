import Business_Header, doxie, ut;

ds := Business_Header.File_Business_Header_Base_for_keybuild;

cleaned := ds(zip !=0 and 
							prim_range !='' and 
							prim_name !='');

export key_businesses_addr	:=	index(cleaned, 																														//dataset
																			{zip,prim_range,prim_name,addr_suffix,predir},  										//key fields
																			{cleaned},  																												//layout
																			'~thor_data400::key::neighborhood::'+doxie.Version_SuperKey+'::businesses_addr'); //file
