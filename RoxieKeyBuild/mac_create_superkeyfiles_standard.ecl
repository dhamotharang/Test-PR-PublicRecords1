export mac_create_superKeyFiles_standard(groupname,
                                         basename,
																				 segmentname,
																				 num_gens = '3',
                                         diffing = 'false',
																				 diffonly = 'false'
																				 ) := macro
	#uniquename(foo)
	string1 %foo% := 'C';

	#if(~diffonly)
		fileservices.createsuperfile(groupname + basename + '::built::' + segmentname);
		fileservices.createsuperfile(groupname + basename + '::qa::' + segmentname);	
		fileservices.createsuperfile(groupname + basename + '::prod::' + segmentname);
		fileservices.createsuperfile(groupname + basename + '::father::' + segmentname);
		#if(num_gens = 3)
		  fileservices.createsuperfile(groupname + basename + '::grandfather::' + segmentname);		
		#end
	#end

	#if(diffing)
		fileservices.createsuperfile(groupname + basename + '::built::' + segmentname);
		fileservices.createsuperfile(groupname + basename + '::qa::' + segmentname);	
		fileservices.createsuperfile(groupname + basename + '::prod::' + segmentname);
		fileservices.createsuperfile(groupname + basename + '::father::' + segmentname);
		#if(num_gens = 3)
		  fileservices.createsuperfile(groupname + basename + '::grandfather::' + segmentname);		
		#end
	#end

	
	
endmacro;