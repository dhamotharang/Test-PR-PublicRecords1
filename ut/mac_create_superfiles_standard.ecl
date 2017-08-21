export mac_create_superfiles_standard(groupname,
                                      basename, 
																			segname,
                                      num_gens = '3'
																			) := macro
	import promotesupers;
	
	promotesupers.mac_create_superfiles_standard(groupname,
                                      basename, 
																			segname,
                                      num_gens);
		
	
endmacro : deprecated('use promotesupers.mac_create_superfiles_standard instead');