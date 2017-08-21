import BIPV2_ProxID_mj6_dev,BIPV2,tools,BIPV2_Files;
pstartiter         := 148                                  ;
pnumiters          := 1                                    ;
pversion           := '20140821a'                           ;
pdoPreprocess      := true                                 ;
pdoSpecs           := true                                 ;
pdoIters           := true                                 ;
pdoPostProcess     := true                                 ;
pcluster           := tools.fun_Groupname('20',false)      ;
pUniqueOut         := 'ProxidMJ6'                          ;
pDOTFile           := BIPV2_ProxID_mj6_dev.In_DOT_Base     ;
pDotFilename       := ''                                   ;

#workunit('name','BIPV2_ProxID_mj6_dev Iteration' + if(pnumiters > 1 ,'s ' + (string)pstartiter + '-' + (string)(pstartiter + pnumiters - 1)  ,' ' + (string)pstartiter));
/*
Bug: 164068 - Improve Efficiency of BIPV2_Proxid_mj6 iterations
*/
#OPTION('multiplePersistInstances',FALSE);
infile    := BIPV2_ProxID.files(pversion + '_147').base.logical(st in ['FL','OH','GA','PA'],v_city_name in ['DAYTON','MIAMISBURG','BOCA RATON','ATLANTA','BETHLEHEM']);
writefile := tools.macf_writefile(BIPV2_ProxID_mj6_dev._filenames(pversion + '_147').base.logical,infile,pOverwrite := TRUE);

sequential(

// writefile
// ,BIPV2_ProxID_mj6_dev._promote(pversion + '_147').new2built

BIPV2_ProxID_mj6_dev._proc_Multiple_Iterations(
   pstartiter    
  ,pnumiters     
  ,pversion       
  ,pdoPreprocess  
  ,pdoSpecs        
  ,pdoIters       
  ,pdoPostProcess 
  ,pcluster      
  ,pUniqueOut    
  ,pDOTFile      
  ,pDotFilename  
)
);

