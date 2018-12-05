import Lib_FileServices, STRATA, ut, Roxiekeybuild, PromoteSupers, Orbit3;
export BWR_Build_GSA(string version) := function
// #workunit('name','GSA Build - ' + version);

mailTarget := 'john.freibaum@lexisnexis.com,deborah.torhanova@lexisnexis.com,Randy.Reyes@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com,Abednego.Escobal@lexisnexisrisk.com';

send_mail (string pSubject, string pBody) := lib_fileservices.FileServices.sendemail(mailTarget, pSubject, pBody);

PromoteSupers.MAC_SF_BuildProcess(GSA.proc_build_base(version),GSA.Cluster + 'base::GSA',GSA_Base,3,false,true);


build_base  := GSA_Base : success(output('Build for base file successful')),
						  failure(output('Build for base file FAILED'));

build_autoKeys  := GSA.proc_Build_AutoKeys(version) : 
							success(output('Autokey build successful')),
							failure(output('Autokey build FAILED'));
							
build_Keys      := GSA.proc_Build_Keys(version) : 
							success(output('Key build successful')),
							failure(output('Key build FAILED'));

build_stats := GSA.out_STRATA_population_stats(version);

dops_update := Roxiekeybuild.updateversion('GSAKeys',version,'Randy.Reyes@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com,Abednego.Escobal@lexisnexisrisk.com,john.freibaum@lexisnexis.com,deborah.torhanova@lexisnexis.com',,'N');

orbit_update := Orbit3.proc_Orbit3_CreateBuild ('GSA',version,'N');

build_all :=
	sequential(build_base,		
			   parallel(build_autoKeys,build_Keys,build_stats),
			   dops_update,
				 orbit_update,
			   send_mail('GSA Build Completed',
						  version + ' GSA build for base file, keys, and stats completed successfully'));
return build_all;
end;