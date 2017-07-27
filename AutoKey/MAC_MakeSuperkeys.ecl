export MAC_MakeSuperkeys (infilename,num_gens = '3',diffing = 'false',diffonly = 'false',
                          create_skip_set='[]') :=
MACRO

#uniquename(x)
%x% := 1;
	ut.mac_create_superkey_files(infilename+'Address',num_gens,diffing,diffonly)
	ut.mac_create_superkey_files(infilename+'CityStName',num_gens,diffing,diffonly)
	ut.mac_create_superkey_files(infilename+'Name',num_gens,diffing,diffonly)

#if('P' not in create_skip_set)
	ut.mac_create_superkey_files(infilename+'Phone',num_gens,diffing,diffonly)
#end

#if('S' not in create_skip_set)	
	ut.mac_create_superkey_files(infilename+'SSN',num_gens,diffing,diffonly)
#end

	ut.mac_create_superkey_files(infilename+'StName',num_gens,diffing,diffonly)
	ut.mac_create_superkey_files(infilename+'Zip',num_gens,diffing,diffonly)
	
ENDMACRO;