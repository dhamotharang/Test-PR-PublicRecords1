// ********************************************************************************************************************************
// CustomerTest_Common.mac_create_superfiles
// Copy of the original PromoteSupers.mac_create_superfiles - but leaving out the BUILDING and BUILT we don't need for base files.
// ********************************************************************************************************************************

export mac_create_superfiles(basename, num_gens = '3', infiles = 'false', inname = '\'frblfrbl\'') := macro
	#uniquename(foo)
	string1 %foo% := 'C';
	
	#if (infiles and inname != 'frblfrbl')
	  fileservices.createsuperfile(inname + '_FATHER');
	  fileservices.createsuperfile(inname + '_IN');
	#end
	fileservices.createsuperfile(basename);
	fileservices.createsuperfile(basename + '_FATHER');
	#if (num_gens = 3)
		fileservices.createsuperfile(basename + '_GRANDFATHER');
	#end
	// fileservices.createsuperfile(basename + '_BUILDING');
	// fileservices.createsuperfile(basename + '_BUILT');
endmacro;