export mac_create_superKeyFiles_standard(groupname,
                                         basename,
																				 segmentname,
																				 num_gens = '3',
                                         diffing = 'false',
																				 diffonly = 'false'
																				 ) := macro
	import roxiekeybuild;
	
	roxiekeybuild.mac_create_superkeyfiles_standard(groupname,
                                         basename,
																				 segmentname,
																				 num_gens,
                                         diffing,
																				 diffonly);
	
	
endmacro : deprecated('use roxiekeybuild.mac_create_superkeyfiles_standard instead');