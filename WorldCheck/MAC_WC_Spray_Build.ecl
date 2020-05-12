
export MAC_WC_Spray_Build(filename,filedate) := macro
	IMPORT WorldCheck, doxie_build, Roxiekeybuild, Orbit3, Scrubs, Scrubs_WorldCheck;
						 
	#workunit('name','Yogurt:World Check Spray and Build ' + filedate);

	/* Do STRATA stats work */
	WorldCheck.Out_File_Main_Stats_Population(WorldCheck.File_Main
											,filedate
											,strata_output);
										
	dops_update := if(	
						Scrubs.mac_ScrubsFailureTest('Scrubs_WorldCheck',filedate)
						,RoxieKeybuild.updateversion('WorldCheckKeys',filedate,'randy.reyes@lexisnexis.com; manuel.tarectecan@lexisnexis.com; Abednego.Escobal@lexisnexis.com',,'N|B')
						,OUTPUT('Dops update failed due to Scrubs Reject warning(s)',NAMED('Scrubs_Statis'))
					);

	orbit_update := Orbit3.proc_Orbit3_CreateBuild ('WorldCheck',filedate,'N|B');

	run_scrubs := Scrubs_WorldCheck.Fn_RunScrubs(filedate);
											
	sequential(
				WorldCheck.proc_WorldCheck_Spray(filename ,filedate)
				,run_scrubs
				,WorldCheck.Proc_build_WC(filedate)
				,WorldCheck.UID_Samples
				,strata_output
				,dops_update
				,orbit_update
			);

ENDMACRO;