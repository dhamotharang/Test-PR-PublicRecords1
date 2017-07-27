export mac_create_superfiles_standard(groupname,
                                      basename, 
																			segname,
                                      num_gens = '3'
																			) := macro
	#uniquename(foo)
	string1 %foo% := 'C';
	
  fileservices.createsuperfile(groupname + basename + '::building::' + segname);
	fileservices.createsuperfile(groupname + basename + '::built::' + segname);
	fileservices.createsuperfile(groupname + basename + '::father::' + segname);
	#if (num_gens = 3)
	  fileservices.createsuperfile(groupname + basename + '::grandfather::' + segname);
  #end
	fileservices.createsuperfile(groupname + basename + '::qa::' + segname);
	fileservices.createsuperfile(groupname + basename + '::prod::' + segname);
	fileservices.createsuperfile(groupname + basename + '::delete::' + segname);
		
	
endmacro;