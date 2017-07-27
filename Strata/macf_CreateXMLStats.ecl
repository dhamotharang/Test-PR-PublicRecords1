import tools;
export macf_CreateXMLStats(

	 pStats
	,pBuildName
	,pBuildSubSet
	,pVersionName
	,pEmailNotifyList
	,pBuildView				      = '\'\''
	,pBuildType				      = '\'\''
	,pIsTesting				      = 'tools._Constants.IsDataland'
	,pOverwrite				      = 'false'
  ,pomit_output_to_screen = 'false'

) := 
functionmacro
					  
  import strata;					  

  Strata.createXMLStats(pStats,pBuildName,pBuildSubSet,pVersionName,pEmailNotifyList,returncode,pBuildView,pBuildType,false,not pIsTesting,pomit_output_to_screen);

  return returncode;

endmacro;