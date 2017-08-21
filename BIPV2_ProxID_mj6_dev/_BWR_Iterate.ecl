import BIPV2,BIPV2_Build,BIPV2_ProxID_mj6_dev,tools,mdr,BIPV2_Files;
iteration       := '@iteration@'                          ;
pversion        := '@version@'                            ;
pFirstIteration := false                                  ;
pInfile         := BIPV2_ProxID_mj6_dev.In_DOT_Base               ;
pMatchThreshold := 21                                     ;
pDotFilename    := BIPV2_Files.files_dotid.FILE_BASE      ;
#workunit('name',BIPV2_ProxID_mj6_dev._Constants().name + ' ' + pversion + ' iter ' + iteration);
#workunit('priority','high');
#workunit('protect' ,true);
BIPV2_ProxID_mj6_dev._Proc_Iterate(iteration,pversion,pFirstIteration,pInfile,pMatchThreshold,pDotFilename);
