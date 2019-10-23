import tools,_control;
EXPORT Orbit_Item_list(
   pWuid
  ,pFileRegex       = '\'^(?!.*?(source_ingest::data).*)(?=.*?[[:digit:]]{8}.*).*?(base|biz|out).*$\''                                             // optional regex filter for files
  ,pRegexToken      = '\'^.*?(base|out|temp)::(.*?)(::|_w[[:digit:]]{8}|w[[:digit:]]{8}|_0010_header|_5600_demo|_5610_demo|_nixie|_verified).*$\'' //regex to pull out build token for deduping multiple files per build to just 1.
) :=
functionmacro
  import strata,wk_ut;
  
  prep_items         := Workman.get_Slim_FilesRead    (pWuid      ,pFileRegex );  
  dedup_items        := Workman.custom_dedup_filesread(prep_items ,pRegexToken);
  fileitems          := project(dedup_items,transform({string name},self := left));  
  stats := parallel(
     output(prep_items  ,named('prep_items' ))
    ,output(dedup_items ,named('dedup_items'))
    ,output(fileitems   ,named('fileitems'  ))
  );
  return when(fileitems  ,stats);
endmacro;
