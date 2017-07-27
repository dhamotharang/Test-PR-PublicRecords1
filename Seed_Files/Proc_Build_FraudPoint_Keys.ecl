import RoxieKeyBuild;

export Proc_Build_FraudPoint_Keys(string filedate) := function

	roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_FDAttributes,'abc','~thor_data400::key::testseed::'+filedate+'::fdattributes',a);
	
	roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::fdattributes','~thor_data400::key::testseed::'+filedate+'::fdattributes',a1);



	roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::fdattributes','Q',a2);


	retval := sequential(a,a1,a2);

	return retval;
end;

