import BIPV2_ProxID,BIPV2,tools,BIPV2_Files;
pstartiter   := 400                                        ;
pnumiters    := 1                                         ;
pversion     := '20171031'                           ;
pDOTFile     := 'bipv2.CommonBase.Common_Base(\'' + pversion + '\').logical'                  ;
pcluster     := tools.fun_Groupname('60',false)           ;
pDotFilename := ''         ;
pdoSpecs     := true                                      ;
uniqueout    := 'Proxid';
#workunit('name','BIPV2_ProxID Iteration' + if(pnumiters > 1 ,'s ' + (string)pstartiter + '-' + (string)(pstartiter + pnumiters - 1)  ,' ' + (string)pstartiter));


#OPTION('multiplePersistInstances',FALSE);
// infile    := BIPV2_ProxID.files().base.built;//(st in ['FL','OH','GA','PA'],v_city_name in ['DAYTON','MIAMISBURG','BOCA RATON','ATLANTA','BETHLEHEM']);
infile    := bipv2.CommonBase.ds_base(st in ['FL','OH','GA'],v_city_name in ['DAYTON','MIAMISBURG','BOCA RATON','ATLANTA']);
writeoutfile := tools.macf_writefile(BIPV2.Filenames(pversion).Common_Base.logical,infile,pOverwrite := TRUE);

// (TRIM(v_city_name) in ['NAPERVILLE'] and TRIM(st) in ['IL']
// v_city_name  = 'BETHLEHEM'  and st = 'PA'

sequential(
   // writeoutfile
  // ,BIPV2_ProxID.promote(pversion).new2built
   BIPV2_ProxID._proc_Multiple_Iterations(
     pstartiter
    ,pnumiters 
    ,pversion     
    ,pDOTFile     
    ,pcluster     
    ,pDotFilename 
    ,pdoSpecs
    ,uniqueout
  )
);

/*
BIPV2_ProxID._proc_Multiple_Iterations(
   pstartiter       := 354   
  ,pnumiters        := 1   
  ,pversion         := BIPV2.KeySuffix
  ,pDOTFile         := 'BIPV2_Files.files_dotid().DS_BASE'                 
  ,pcluster         := BIPV2_Build._Constants().Groupname
  ,pDotFilename     := '' //'BIPV2_Files.files_dotid().FILE      
  ,pdoSpecs         := true
  ,pUniqueOut       := 'Proxid'
  ,pMatchThreshold  := BIPV2_ProxID.Config.MatchThreshold  
);
*/