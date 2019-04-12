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

  import strata,wk_ut;
  
  prep_items         := Workman.get_Slim_FilesRead    (pWuid      ,pFileRegex );  
  dedup_items        := Workman.custom_dedup_filesread(prep_items ,pRegexToken);
  fileitems          := project(dedup_items,transform({string sortfield,string name,unsigned Countgroup := 0,unsigned cnt := 0},self := left));  

  send_to_strata     := Strata.macf_CreateXMLStats (fileitems ,pBuildName,pBuildSubSet  ,pversion	,pEmailNotifyList	,pBuildView ,pBuildType	,pIsTesting,pOverwrite := false);

  stats := parallel(
     output(prep_items  ,named(pBuildName + '_prep_items' ))
    ,output(dedup_items ,named(pBuildName + '_dedup_items'))
    ,output(fileitems   ,named(pBuildName + '_fileitems'  ))
  );

  return when(send_to_strata  ,stats);

endmacro;