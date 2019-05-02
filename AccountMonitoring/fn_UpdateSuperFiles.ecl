/* This function updates all the super files for a particular product*/

import dops, _control, AccountMonitoring, STD, _Control, ut, Data_Services;

EXPORT fn_UpdateSuperFiles(AccountMonitoring.types.productMask product_mask = 
                            AccountMonitoring.types.productMask.allProducts, // all
                            string roxie_esp_server = '10.173.104.101' ,  // prod
                            string roxie_vip_server =  _Control.RoxieEnv.prodvip,
                            string roxie_port = '8010'
                            
                            ) := function

   
                  
  liveClust := dops.GetRoxieClusterInfo(roxie_esp_server).LiveCluster(roxie_vip_server); 
  roxiePack := dops.GetRoxiePackage(roxie_esp_server,roxie_port,liveClust).Keys();                               

  Superfiles := AccountMonitoring.config_UpdateSuperFiles(product_mask);
  newSuperfileLink :=  join(Superfiles,roxiePack,
                        left.RoxieSuperFile = right.superfile,
                        transform(AccountMonitoring.layouts.UPDATE_SOURCE.superfile_logicalfile_flat_layout,
                          self.MonitorSuperFile := left.MonitorSuperFile,
                          self.RoxieSuperFile := left.RoxieSuperFile,
                          self.LogicalFile := right.subfile,
                          self.LogicalFileExists := true, // assume all exists for now
                          self.FirstInstance := false,
                        ));

   
  global_newSuperfileLink   := global(newSuperfileLink,few);

  newSuperfileLinkCheckLogical  :=  nothor(PROJECT(global_newSuperfileLink,
                                           TRANSFORM(AccountMonitoring.layouts.UPDATE_SOURCE.superfile_logicalfile_flat_layout,
                                            SELF.LogicalFileExists := STD.File.FileExists('~' + left.LogicalFile),
                                            SELF := left)
                                           ));
                         
  CGM_LogicalFiles := newSuperfileLinkCheckLogical;
  CGM_LogicalFilesGroup := GROUP(CGM_LogicalFiles,MonitorSuperFile);

   AccountMonitoring.layouts.UPDATE_SOURCE.superfile_logicalfile_Rollup_layout RollFiles
      (AccountMonitoring.layouts.UPDATE_SOURCE.superfile_logicalfile_flat_layout L, 
      DATASET(AccountMonitoring.layouts.UPDATE_SOURCE.superfile_logicalfile_flat_layout) AllRows) := TRANSFORM
         SELF.MonitorSuperFile := L.MonitorSuperFile;
         SELF.RoxieSuperFile := L.RoxieSuperFile;
         SELF.LogicalFiles := PROJECT(AllRows,TRANSFORM(AccountMonitoring.layouts.UPDATE_SOURCE.LogicalFile_layout,SELF := LEFT));
         SELF.AllLogicalFileExists := min(l.LogicalFileExists,  min( AllRows,AllRows.LogicalFileExists));
     END;
   
  CGM_LogicalFilesFinal := GLOBAL(ROLLUP(CGM_LogicalFilesGroup,GROUP,RollFiles(LEFT,ROWS(LEFT))),FEW);
           
  updateMonitorFiles(DATASET(AccountMonitoring.layouts.UPDATE_SOURCE.superfile_logicalfile_Rollup_layout) inFiles, 
                     STRING stem_name = AccountMonitoring.constants.filename_cluster) := FUNCTION

  add_logicals(STRING SuperFileName, DATASET(AccountMonitoring.layouts.UPDATE_SOURCE.LogicalFile_layout) LogicalFiles) := FUNCTION
            update_action := APPLY(LogicalFiles,
                           
                                SEQUENTIAL(
                                          STD.File.StartSuperFileTransaction()
                                         ,STD.File.AddSuperFile(SuperFileName,'~'+logicalFile)
                                         ,STD.File.FinishSuperFileTransaction()
                                ));
            RETURN update_action;
        END;

    
    update_action := APPLY(inFiles,
                   if(AllLogicalFileExists,
                      SEQUENTIAL(
                             STD.File.StartSuperFileTransaction()
                            ,IF(NOT STD.File.SuperfileExists(TRIM(stem_name+monitorsuperfile)+'_qa'),STD.File.CreateSuperFile(TRIM(stem_name+monitorsuperfile)+'_qa'))
                            ,IF(NOT STD.File.SuperfileExists(TRIM(stem_name+monitorsuperfile)+'_father'),STD.File.CreateSuperFile(TRIM(stem_name+monitorsuperfile)+'_father'))
                            ,STD.File.RemoveOwnedSubFiles(TRIM(stem_name+monitorsuperfile)+'_father',TRUE/*delete_subfile*/) // Remove and delete any unowned logicals
                            ,STD.File.ClearSuperFile(TRIM(stem_name+monitorsuperfile)+'_father',FALSE/*delete_subfile*/) // Remove all files from super
                            ,STD.File.AddSuperFile(TRIM(stem_name+monitorsuperfile)+'_father',TRIM(stem_name+monitorsuperfile)+'_qa',,TRUE/*copy_file_contents*/)
                            ,STD.File.ClearSuperFile(TRIM(stem_name+monitorsuperfile)+'_qa',FALSE/*delete_subfile*/)
                         ,STD.File.FinishSuperFileTransaction()
                         ,add_logicals(TRIM(stem_name+monitorsuperfile)+'_qa',inFiles.logicalFiles))
                   ,STD.System.Log.addWorkunitWarning(TRIM(stem_name+monitorsuperfile)+
                     ' were not updated as package files(s) were not available on THOR.',1)      
                  ));
    return NOTHOR(update_action);		
  END;

/*        output(liveClust,named('liveClust'));
          output(choosen(roxiePack,4000),named('roxiePack'));
          output(CGM_LogicalFiles,named('CGM_LogicalFiles'));
          output(CGM_LogicalFilesFinal,named('CGM_LogicalFilesFinal'));
*/
  update_monitor_file :=
        SEQUENTIAL(updateMonitorFiles(CGM_LogicalFilesFinal)
                  );
    update_monitor_file;


  return(0);
  end;