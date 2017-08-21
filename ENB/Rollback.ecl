import VersionControl;
export Rollback :=
module
   
   export Input := 
   module
      shared dfilenames       := Filenames().Input.dAll_templates;
      shared inputrollbacks := VersionControl.mRollback.InputFiles(dFilenames);
      
      export Sprayed2Root                                         := inputrollbacks.Sprayed2Root                  ;
      export Using2Sprayed                                     := inputrollbacks.Using2Sprayed                 ;
      export Used2Sprayed(boolean pDelete = false) := inputrollbacks.Used2Sprayed   (pDelete)   ;
      export Delete2Used                                          := inputrollbacks.Delete2Used                   ;
                                                                                                
   end;
   export Base := 
   module
      shared dfilenames    := Filenames().base.dAll_filenames;
      shared dTemplates    := versioncontrol.SlimFilenameDs.fOther      (dfilenames ,'T');
      shared baserollback := VersionControl.mRollback.BuildFiles(dTemplates);
      export Father2Prod      (boolean pDelete = false,boolean pCheckVersionIntegrity  = false) := baserollback.Father2Prod      (pDelete,pCheckVersionIntegrity  );
      export Prod2QA          (boolean pDelete = false,boolean pCheckVersionIntegrity  = false) := baserollback.Prod2QA          (pDelete,pCheckVersionIntegrity  );
      export Father2QA        (boolean pDelete = false,boolean pCheckVersionIntegrity  = false) := baserollback.Father2QA        (pDelete,pCheckVersionIntegrity  );
      export QA2Built            (boolean pDelete = false,boolean pCheckVersionIntegrity  = false) := baserollback.QA2Built         (pDelete,pCheckVersionIntegrity  );
      export Built2Building   (boolean pDelete = false,boolean pCheckVersionIntegrity  = false) := baserollback.Built2Building(pDelete,pCheckVersionIntegrity  );
                                                                                                          
   end;
/*
   export RoxieKeys := 
   module
      shared roxierollback := VersionControl.mRollback.BuildFiles(keynames('').dTemplate);
      export Father2Prod      (boolean pDelete = false,boolean pCheckVersionIntegrity  = false):= roxierollback.Father2Prod      (pDelete,pCheckVersionIntegrity  );
      export Prod2QA          (boolean pDelete = false,boolean pCheckVersionIntegrity  = false):= roxierollback.Prod2QA          (pDelete,pCheckVersionIntegrity  );
      export Father2QA        (boolean pDelete = false,boolean pCheckVersionIntegrity  = false):= roxierollback.Father2QA        (pDelete,pCheckVersionIntegrity  );
      export QA2Built            (boolean pDelete = false,boolean pCheckVersionIntegrity  = false):= roxierollback.QA2Built            (pDelete,pCheckVersionIntegrity  );
      export Built2Building   (boolean pDelete = false,boolean pCheckVersionIntegrity  = false):= roxierollback.Built2Building   (pDelete,pCheckVersionIntegrity  );
                                                                                                  
   end;
*/
   export Father2Prod      (boolean pDelete = false,boolean pCheckVersionIntegrity  = false)    := 
   parallel(
       base.Father2Prod       (pDelete,pCheckVersionIntegrity  )
//    ,roxiekeys.Father2Prod(pDelete,pCheckVersionIntegrity )
   );                    
   export Prod2QA          (boolean pDelete = false,boolean pCheckVersionIntegrity  = false)    := 
   parallel(
       base.Prod2QA        (pDelete,pCheckVersionIntegrity  )
//    ,roxiekeys.Prod2QA(pDelete,pCheckVersionIntegrity  )
   );                
   export Father2QA        (boolean pDelete = false,boolean pCheckVersionIntegrity  = false)    := 
   parallel(
       base.Father2QA         (pDelete,pCheckVersionIntegrity  )
//    ,roxiekeys.Father2QA(pDelete,pCheckVersionIntegrity   )
   );                  
   export QA2Built            (boolean pDelete = false,boolean pCheckVersionIntegrity  = false)    := 
   parallel(
       base.QA2Built       (pDelete,pCheckVersionIntegrity  )
//    ,roxiekeys.QA2Built (pDelete,pCheckVersionIntegrity   )
   );                  
   export Built2Building   (boolean pDelete = false,boolean pCheckVersionIntegrity  = false)    := 
   parallel(
       base.Built2Building       (pDelete,pCheckVersionIntegrity  )
//    ,roxiekeys.Built2Building (pDelete,pCheckVersionIntegrity   )
   );                        
end;
