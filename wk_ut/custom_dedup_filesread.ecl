import Workman;
EXPORT custom_dedup_filesread(

   pFiles
  ,pRegexToken  = '\'^.*?(base|out)::(.*?)(::|_w|_0010_header|_5600_demo|_5610_demo|_nixie|_verified).*$\''
  
) :=
functionmacro
  return Workman.custom_dedup_filesread(pFiles,pRegexToken);
endmacro;