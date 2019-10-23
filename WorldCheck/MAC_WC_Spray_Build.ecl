import WorldCheck, doxie_build, Roxiekeybuild, Orbit3;

export MAC_WC_Spray_Build(filename
						 ,filedate) := macro
						 
#workunit('name','Yogurt:World Check Spray and Build ' + filedate);

/* Do STRATA stats work */
WorldCheck.Out_File_Main_Stats_Population(WorldCheck.File_Main
                                         ,filedate
										 ,strata_output)
									
dops_update := RoxieKeybuild.updateversion('WorldCheckKeys',filedate,'randy.reyes@lexisnexis.com; manuel.tarectecan@lexisnexis.com; Abednego.Escobal@lexisnexis.com',,'N|B');
orbit_update := Orbit3.proc_Orbit3_CreateBuild ('WorldCheck',filedate,'N|B');
										 
sequential(WorldCheck.proc_WorldCheck_Spray(filename
                                            ,filedate)
           ,WorldCheck.Proc_build_WC(filedate)
		   ,WorldCheck.UID_Samples
		   ,strata_output
		   ,dops_update
			 ,orbit_update
		   );

ENDMACRO;