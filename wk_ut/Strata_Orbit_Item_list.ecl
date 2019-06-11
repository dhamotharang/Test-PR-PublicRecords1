import tools,_control;

EXPORT Strata_Orbit_Item_list(

   pWuid
  ,pBuildName
	,pBuildSubSet
	,pversion
  ,pFileRegex       = '\'^(?!.*?(source_ingest::data).*)(?=.*?[[:digit:]]{8}.*).*?(base|biz|out).*$\''                                             // optional regex filter for files
  ,pRegexToken      = '\'^.*?(base|out|temp)::(.*?)(::|_w[[:digit:]]{8}|w[[:digit:]]{8}|_0010_header|_5600_demo|_5610_demo|_nixie|_verified).*$\'' //regex to pull out build token for deduping multiple files per build to just 1.
	,pEmailNotifyList = '_control.MyInfo.EmailAddressNotify'
	,pBuildView				= '\'List\''
	,pBuildType				= '\'Orbit_Item\''
	,pIsTesting				= 'tools._Constants.IsDataland'

) :=
functionmacro

 import Workman;
 
 return Workman.Strata_Orbit_Item_list(
   pWuid
  ,pBuildName
  ,pBuildSubSet
  ,pversion
  ,pFileRegex       
  ,pRegexToken      
  ,pEmailNotifyList 
  ,pBuildView				
  ,pBuildType				
  ,pIsTesting				
 );

endmacro;