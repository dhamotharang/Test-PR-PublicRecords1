import BIPV2_ProxID_mj6,BIPV2,tools,BIPV2_Files;
pstartiter         := 162                                  ;
pnumiters          := 1                                    ;
pversion           := bipv2.KeySuffix                         ;
pdoPreprocess      := true                                 ;
pdoSpecs           := true                                 ;
pdoIters           := true                                 ;
pdoPostProcess     := true                                 ;
pcluster           := tools.fun_Groupname('5',false)      ;
pUniqueOut         := 'ProxidMJ6'                          ;
pDOTFile           := BIPV2_ProxID_mj6.In_DOT_Base     ;
pDotFilename       := ''                                   ;

#workunit('name','BIPV2_ProxID_mj6 Iteration' + if(pnumiters > 1 ,'s ' + (string)pstartiter + '-' + (string)(pstartiter + pnumiters - 1)  ,' ' + (string)pstartiter));
/*
Bug: 164068 - Improve Efficiency of BIPV2_Proxid_mj6 iterations
*/
#OPTION('multiplePersistInstances',FALSE);
// infile    := BIPV2_ProxID.files(pversion + '_161',true).base.logical(st in ['FL','OH','GA','PA'],v_city_name in ['DAYTON','MIAMISBURG','BOCA RATON','ATLANTA','BETHLEHEM']);
infile    := bipv2.commonbase.ds_prod(st in ['FL','OH','GA','PA'],v_city_name in ['DAYTON','MIAMISBURG','BOCA RATON','ATLANTA','BETHLEHEM']);
writefile := tools.macf_writefile(BIPV2_ProxID_mj6._filenames(pversion + '_prod').base.logical,infile,pOverwrite := TRUE);

sequential(

 writefile
,BIPV2_ProxID_mj6._promote(pversion + '_prod').new2built
,BIPV2_ProxID_mj6._proc_Multiple_Iterations(
   pstartiter    
  ,pnumiters     
  ,pversion       
  ,pdoPreprocess  
  ,pdoSpecs        
  ,pdoIters       
  ,pdoPostProcess 
  ,pcluster      
  ,pUniqueOut    
  ,pDotFilename  
  // ,pDOTFile      
)
);
/*
pstartiter
pnumiters 
pversion        
pdoPreprocess   
pdoSpecs        
pdoIters        
pdoPostProcess  
pcluster        
pUniqueOut      
pDotFilename    
pMatchThreshold 
*/