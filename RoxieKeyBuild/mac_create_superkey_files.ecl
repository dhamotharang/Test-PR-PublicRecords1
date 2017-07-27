/*2005-02-07T08:36:07Z (Mark Luber)
all for diffing superkeys
*/
export mac_create_superkey_files(basename,num_gens = '3',diffing = 'false',diffonly = 'false') := macro
	#uniquename(foo)
	string1 %foo% := 'C';

	#if(~diffonly)
		fileservices.createsuperfile(basename + '_FATHER');
		fileservices.createsuperfile(basename + '_BUILT');
		fileservices.createsuperfile(basename + '_QA');
		fileservices.createsuperfile(basename + '_PROD');
	/*
		if(not fileservices.superfileexists(basename + '_FATHER'),fileservices.createsuperfile(basename + '_FATHER'));
		if(not fileservices.superfileexists(basename + '_BUILT'),fileservices.createsuperfile(basename + '_BUILT'));
		if(not fileservices.superfileexists(basename + '_QA'),fileservices.createsuperfile(basename + '_QA'));
		if(not fileservices.superfileexists(basename + '_PROD'),fileservices.createsuperfile(basename + '_PROD'));
	*/
	#end

	#if(diffing)
		fileservices.createsuperfile(basename + '_diff_FATHER');
		fileservices.createsuperfile(basename + '_diff_BUILT');
		fileservices.createsuperfile(basename + '_diff_QA');
		fileservices.createsuperfile(basename + '_diff_PROD');
	#end

	#if(num_gens = 3)
		#if(~diffonly)
			fileservices.createsuperfile(basename + '_GRANDFATHER');
		#end
		#if(diffing)
			fileservices.createsuperfile(basename + '_diff_GRANDFATHER');
		#end
	#end
	
	
endmacro;