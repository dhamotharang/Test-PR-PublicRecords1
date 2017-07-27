import WorldCheck, doxie_build;

export MAC_WC_Spray_Build(filename
						 ,filedate) := macro
						 
#workunit('name','World Check Spray and Build ' + filedate);

/* Do STRATA stats work */
WorldCheck.Out_File_Main_Stats_Population(WorldCheck.File_Main
                                         ,filedate
										 ,strata_output)

sequential(WorldCheck.proc_WorldCheck_Spray(filename
                                            ,filedate)
           ,WorldCheck.Proc_build_WC(filedate)
		   ,strata_output
		   );

ENDMACRO;