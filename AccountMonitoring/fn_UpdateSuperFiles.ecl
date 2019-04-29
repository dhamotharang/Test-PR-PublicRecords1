/* This function updates all the super files for a particular product*/

import dops, _control, AccountMonitoring, STD, _Control, ut, Data_Services;

EXPORT fn_UpdateSuperFiles(string esp_server = '10.173.104.101' ,  // prod esp
                            string vip_server =  _Control.RoxieEnv.prodvip,
                            string roxieport = '8010',
                            unsigned category_num = 0 // all
                            ) := function

   
 
   roxie_monitor_superfile_layout := RECORD
      STRING250 RoxieSuperFile;
      STRING250 MonitorSuperFile;
      unsigned category_num;
   end;
   
   superfile_logicalfile_flat_layout := RECORD
      STRING250 MonitorSuperFile;
      STRING250 RoxieSuperFile;
      STRING250 LogicalFile;
      BOOLEAN LogicalFileExists;
      BOOLEAN FirstInstance;
   end;
   
   logicalfile_layout := RECORD
      STRING250 LogicalFile;
   end;
   
   superfile_logicalfile_Rollup_layout := RECORD
      STRING250 MonitorSuperFile;
       STRING250 RoxieSuperFile;
      DATASET(LogicalFile_layout) LogicalFiles;
      BOOLEAN AllLogicalFileExists;
   end;
//--------------------------------------------------------------------------------------------------------------------//
/*  Roxie Super key name vs Monitoring Superkey name. Currently 2 categories are available: 
    (1)PersonHeader (2)SBFE. More categories and their superfiles that this function should
     update can be added in this dataset.       
*/
    
     Superfiles := DATASET([
                          {'thor_data400::key::header_qa','monitor::personheader',1},
                          {'thor_data400::key::sbfe::qa::linkids','monitor::sbfe::linkids',2},
                          {'thor_data400::key::sbfe::qa::tradeline','monitor::sbfe::tradeline',2},
                          {'thor_data400::key::sbfescoring::qa::scoringindex','monitor::sbfescoring::scoringindex',2}
                         ],roxie_monitor_superfile_layout);
//--------------------------------------------------------------------------------------------------------------------//
                             
  liveClust := dops.GetRoxieClusterInfo(esp_server).LiveCluster(vip_server); 
  roxiePack := dops.GetRoxiePackage(esp_server,roxieport,liveClust).Keys();                               

   strToday := STD.Date.Today();
  
   newSuperfileLink :=  join(Superfiles,roxiePack,
                               if(category_num = 0,true, left.category_num = category_num) and
                               left.RoxieSuperFile = right.superfile,
                                  transform(superfile_logicalfile_flat_layout,
                                    self.MonitorSuperFile := left.MonitorSuperFile,
                                    self.RoxieSuperFile := left.RoxieSuperFile,
                                    self.LogicalFile := right.subfile,
                                    self.LogicalFileExists := true, // assume all exists for now
                                    self.FirstInstance := false,
                                  ));
     
     
         global_newSuperfileLink   := global(newSuperfileLink,few);
         
         newSuperfileLinkCheckLogical  :=  nothor(PROJECT(global_newSuperfileLink,
                                                   TRANSFORM(superfile_logicalfile_flat_layout,
                                                    SELF.LogicalFileExists := STD.File.FileExists('~' + left.LogicalFile),
                                                    SELF := left)
                                                   ));
                           

  
   CGM_LogicalFiles := newSuperfileLinkCheckLogical;
   
   CGM_LogicalFilesGroup := GROUP(CGM_LogicalFiles,MonitorSuperFile);
   
   superfile_logicalfile_Rollup_layout RollFiles(superfile_logicalfile_flat_layout L, 
                                                 DATASET(superfile_logicalfile_flat_layout) AllRows) := TRANSFORM
   	SELF.MonitorSuperFile := L.MonitorSuperFile;
    SELF.RoxieSuperFile := L.RoxieSuperFile;
   	SELF.LogicalFiles := PROJECT(AllRows,TRANSFORM(LogicalFile_layout,SELF := LEFT));
   SELF.AllLogicalFileExists := min(l.LogicalFileExists,  min( AllRows,AllRows.LogicalFileExists));
   END;
   
   CGM_LogicalFilesFinal2 := GLOBAL(ROLLUP(CGM_LogicalFilesGroup,GROUP,RollFiles(LEFT,ROWS(LEFT))),FEW);
   
   CGM_LogicalFilesSorted := SORT(CGM_LogicalFiles,MonitorSuperFile,RECORD);
   
   superfile_logicalfile_flat_layout UpdateInstance(superfile_logicalfile_flat_layout L, superfile_logicalfile_flat_layout R) := TRANSFORM
      SELF.FirstInstance := L.MonitorSuperFile != R.MonitorSuperFile;
   	 SELF := R;
   END;
   CGM_LogicalFilesFinal := ITERATE(CGM_LogicalFilesSorted,UpdateInstance(LEFT,RIGHT),STABLE);
   							
   updateMonitorFiles(DATASET(superfile_logicalfile_Rollup_layout) inFiles, STRING stem_name = AccountMonitoring.constants.filename_cluster) := FUNCTION
    
          

    
    add_logicals(STRING SuperFileName, DATASET(LogicalFile_layout) LogicalFiles) := FUNCTION
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
   
/*    output(newSuperfileLinkCheckLogical,named('newSuperfileLinkCheckLogical'));
      output(liveClust,named('liveClust'));
      //output(superfile_stem_name,named('superfile_stem_name'));
      output(choosen(roxiePack,4000),named('roxiePack'));
      //output(CGM_KeyLogical,named('CGM_KeyLogical'));
      output(CGM_LogicalFiles,named('CGM_LogicalFiles'));
      // output(sbfeLogicalFilesFinal,named('sbfeLogicalFilesFinal'));
      output(CGM_LogicalFilesFinal2,named('CGM_LogicalFilesFinal2'));
*/
    update_monitor_file :=
      		SEQUENTIAL(updateMonitorFiles(CGM_LogicalFilesFinal2)
      		          );
      update_monitor_file;


return(0);
end;