IMPORT MDR;
EXPORT Constants :=
MODULE

  // Defaults
  EXPORT Defaults :=
  MODULE
		EXPORT UNSIGNED1 MaxResultsPerAcctno := 1;		               		
	END;
	
	EXPORT Limits := MODULE
		EXPORT UNSIGNED4 JoinLimit := 10000;	
  END;	
																			 
  EXPORT experianRestrictedSources := [MDR.sourceTools.src_EBR,
	                                     MDR.SourceTools.src_Experian_CRDB];																		 
END;