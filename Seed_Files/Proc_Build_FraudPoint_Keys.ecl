import RoxieKeyBuild;

export Proc_Build_FraudPoint_Keys(string filedate) := function

	roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_FDAttributes,'abc','~thor_data400::key::testseed::'+filedate+'::fdattributes',a);
	roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_FraudPoint,'abc','~thor_data400::key::testseed::'+filedate+'::fraudpoint',b);
	
	roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::fdattributes','~thor_data400::key::testseed::'+filedate+'::fdattributes',a1);
	roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::testseed::@version@::fraudpoint','~thor_data400::key::testseed::'+filedate+'::fraudpoint',b1);



	roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::fdattributes','Q',a2);
	roxiekeybuild.Mac_SK_Move('~thor_data400::key::testseed::@version@::fraudpoint','Q',b2);

	dops_update := Roxiekeybuild.updateversion('FraudpointseedKeys',filedate,'amila.de@lexisnexisrisk.com,matthew.ludewig@lexisnexisrisk.com',,'N');

	retval := sequential(a,a1,a2,b,b1,b2,dops_update);

	return retval;
end;

