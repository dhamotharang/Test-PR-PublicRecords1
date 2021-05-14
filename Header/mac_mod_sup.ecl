import header_services;

export mac_mod_sup (head_in, rid_base) := macro
						
rid_base :=  Header.Prep_Build.applyRidRecSup(head_in);						  	
					  
endmacro ;