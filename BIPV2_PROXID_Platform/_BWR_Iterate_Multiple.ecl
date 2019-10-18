import BIPV2_ProxID_Platform,BIPV2,tools,BIPV2_Files;
pstartiter   := 67                                        ;
pnumiters    := 1                                         ;
pversion     := '20140129'                           ;
pDOTFile     := 'BIPV2_ProxID_Platform.In_DOT_Base'                  ;
pdopatch     := false                                      ;
pcluster     := tools.fun_Groupname('11',false)           ;
pDotFilename := ''         ;
pdoSpecs     := true                                      ;
#workunit('name','BIPV2_ProxID_Platform Iteration' + if(pnumiters > 1 ,'s ' + (string)pstartiter + '-' + (string)(pstartiter + pnumiters - 1)  ,' ' + (string)pstartiter));
//#workunit('name','Bug: 122311 - LINKING: ProxID Internal Recall: Company repeating exact same name and address multiple times');
//CHICK-FIL-A, INC 
// 5200 BUFFINGTON RD
// ATLANTA, GA 30349-2945
// LexID(SM): 7842 


#OPTION('multiplePersistInstances',FALSE);
infile       := BIPV2_ProxID_Platform.files('20140129_66',true).base.logical;//(st in ['FL','OH','GA','PA'],v_city_name in ['DAYTON','MIAMISBURG','BOCA RATON','ATLANTA','BETHLEHEM']);
writeoutfile := tools.macf_writefile(BIPV2_ProxID_Platform.filenames(pversion).base.logical,infile,pOverwrite := TRUE);

// (TRIM(v_city_name) in ['NAPERVILLE'] and TRIM(st) in ['IL']
// v_city_name  = 'BETHLEHEM'  and st = 'PA'

sequential(
 writeoutfile
,BIPV2_ProxID_Platform.promote(pversion).new2built
,BIPV2_ProxID_Platform._proc_Multiple_Iterations(
   pstartiter
  ,pnumiters 
  ,pversion     
  ,pDOTFile     
  ,pdopatch      
  ,pcluster     
  ,pDotFilename 
  ,pdoSpecs
));

