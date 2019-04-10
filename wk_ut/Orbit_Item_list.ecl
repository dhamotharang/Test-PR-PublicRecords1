import tools,_control;
EXPORT Orbit_Item_list(
   pWuid
  ,pFileRegex       = '\'^(?!.*?(source_ingest::data).*)(?=.*?[[:digit:]]{8}.*).*?(base|biz|out).*$\''                                             // optional regex filter for files
  ,pRegexToken      = '\'^.*?(base|out|temp)::(.*?)(::|_w[[:digit:]]{8}|w[[:digit:]]{8}|_0010_header|_5600_demo|_5610_demo|_nixie|_verified).*$\'' //regex to pull out build token for deduping multiple files per build to just 1.
) :=
functionmacro
  import Workman;

  return Workman.Orbit_Item_list(pWuid  ,pFileRegex ,pRegexToken);
  
endmacro;
