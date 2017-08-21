import roxiekeybuild,seed_files;
EXPORT Proc_FraudPoint_Keys(string filedate) := function
	
	buildkeys(indexdataset,indexsuffix, retval) := macro
		roxiekeybuild.mac_sk_buildprocess_v2_local(index(indexdataset(dataset_name = 'prte'),{dataset_name,hashvalue},
																	{indexdataset},
																	'~thor_data400::key::testseed::qa::'+indexsuffix),'abc','~prte::key::testseed::'+filedate+'::' + indexsuffix,retval);
	endmacro;
	
	buildkeys(Seed_Files.Key_FDAttributes,'fdattributes',a);
	buildkeys(Seed_Files.Key_FraudPoint,'fraudpoint',b);
	
	
	buildkey := parallel(a,b);
	
	return buildkey;


end;