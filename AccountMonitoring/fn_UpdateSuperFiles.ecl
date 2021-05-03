/* This function updates all the super files for a particular product*/

IMPORT dops, AccountMonitoring, STD, _Control, Data_Services;

  add_logicals(STRING SuperFileName, DATASET(AccountMonitoring.layouts.UPDATE_SOURCE.LogicalFile_layout) LogicalFiles) := FUNCTION
     update_action := APPLY(LogicalFiles,
                                SEQUENTIAL(
                                          STD.File.StartSuperFileTransaction()
                                         ,STD.File.AddSuperFile(SuperFileName,Data_Services.Default_Data_Location + logicalFile)
                                         ,STD.File.FinishSuperFileTransaction()
                                ));
    RETURN update_action;
  END;

  updateMonitorFiles(DATASET(AccountMonitoring.layouts.UPDATE_SOURCE.superfile_logicalfile_Rollup_layout) inFiles, 
                     STRING stem_name = AccountMonitoring.constants.filename_cluster) := FUNCTION

  
    update_action := APPLY(inFiles,
                   IF(AllLogicalFilesExist,
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
    RETURN NOTHOR(update_action);		
  END;


EXPORT fn_UpdateSuperFiles(AccountMonitoring.types.productMask product_mask = 
                            AccountMonitoring.types.productMask.allProducts, // all
                            STRING roxie_esp_server_env = 'prod', // prod, cert 
														STRING roxie_esp_server_cluster = 'nonfcra', // nonfcra, fcra
                            STRING roxie_vip_server =  _Control.RoxieEnv.prodvip,
                            STRING roxie_port = '8010'
                            
                            ) := FUNCTION

	// Determine roxie server from vip to use for package file pull
	roxie_esp_server := dops.GetRoxieClusterInfo().fESPAssociatedToCluster(roxie_esp_server_cluster,roxie_esp_server_env)[1].esp; // return the cluster that is currently live behind VIP  
  liveClust := dops.GetRoxieClusterInfo(roxie_esp_server).LiveCluster(roxie_vip_server);
  roxiePack := dops.GetRoxiePackage(roxie_esp_server,roxie_port,liveClust).Keys();                               

  Superfiles := AccountMonitoring.config_UpdateSuperFiles(product_mask);
  newSuperfileLink :=  JOIN(Superfiles,roxiePack,
                        STD.Str.ToLowerCase(left.RoxieSuperFile) = STD.Str.ToLowerCase(RIGHT.superfile),
                        TRANSFORM(AccountMonitoring.layouts.UPDATE_SOURCE.superfile_logicalfile_flat_layout,
                          SELF.MonitorSuperFile := LEFT.MonitorSuperFile,
                          SELF.RoxieSuperFile := LEFT.RoxieSuperFile,
                          SELF.LogicalFile := RIGHT.subfile,
                          SELF.LogicalFileExists := TRUE, // assume all exists for now
                          SELF.FirstInstance := FALSE,
                        ));

   
  global_newSuperfileLink   := GLOBAL(newSuperfileLink,few);

  newSuperfileLinkCheckLogical  :=  NOTHOR(PROJECT(global_newSuperfileLink,
                                           TRANSFORM(AccountMonitoring.layouts.UPDATE_SOURCE.superfile_logicalfile_flat_layout,
                                            SELF.LogicalFileExists := STD.File.FileExists(Data_Services.Default_Data_Location + left.LogicalFile),
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
         SELF.AllLogicalFilesExist := MIN( AllRows,AllRows.LogicalFileExists);
  END;
   
  CGM_LogicalFilesFinal := GLOBAL(ROLLUP(CGM_LogicalFilesGroup,GROUP,RollFiles(LEFT,ROWS(LEFT))),FEW);
           
	/*				 
        output(roxie_esp_server,named('roxie_esp_server'));
				output(liveClust,named('liveClust'));
        output(choosen(roxiePack,4000),named('roxiePack'));
        output(CGM_LogicalFiles,named('CGM_LogicalFiles'));
        output(CGM_LogicalFilesFinal,named('CGM_LogicalFilesFinal'));
*/
  update_monitor_file :=
        SEQUENTIAL(updateMonitorFiles(CGM_LogicalFilesFinal)
                  );
  update_monitor_file;


  RETURN(0);
END;
