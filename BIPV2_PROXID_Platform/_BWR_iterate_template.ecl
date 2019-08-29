﻿import BIPV2,BIPV2_Build,BIPV2_ProxID_Platform,tools,mdr,BIPV2_Files;
iteration       := '@iteration@'                          ;
pversion        := '@version@'                            ;
pFirstIteration := false                                  ;
pInfile         := BIPV2_ProxID_Platform.In_DOT_Base               ;
pMatchThreshold := @matchthreshold@                       ;
pDotFilename    := ''                                     ;/*done by BIPV2_ProxID_Platform._proc_Multiple_Iterations.  default is BIPV2_Files.files_dotid.FILE_BASE*/
#workunit('name',BIPV2_ProxID_Platform._Constants().name + ' ' + pversion + ' iter ' + iteration);
#workunit('priority','high');
#workunit('protect' ,true);
BIPV2_ProxID_Platform._Proc_Iterate(iteration,pversion,pFirstIteration,pInfile,pMatchThreshold,pDotFilename);
