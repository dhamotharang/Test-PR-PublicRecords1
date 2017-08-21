import tools;

export mac_CreateXMLStats(

	 pStats
	,pBuildName
	,pBuildSubSet
	,pVersionName
	,pEmailNotifyList
	,rOut
	,pBuildView				      = '\'\''
	,pBuildType				      = '\'\''
	,pShouldExport				  = 'false'
	,pIsTesting				      = 'tools._Constants.IsDataland'
	,pOverwrite				      = 'false'
  ,pomit_output_to_screen = 'false'

) := 
macro
					  
  import strata;					  

  Strata.createXMLStats(pStats,pBuildName,pBuildSubSet,pVersionName,pEmailNotifyList,rOut,pBuildView,pBuildType,pShouldExport,not pIsTesting,pomit_output_to_screen);

endmacro;
