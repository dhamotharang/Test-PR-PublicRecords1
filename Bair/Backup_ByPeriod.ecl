IMPORT Bair, STD,ut;

EXPORT Backup_ByPeriod := MODULE

SHARED FS														   := fileservices;
SHARED SourceIP    									   := Bair._Constant.copyFromIP;
SHARED period_manifest_filename        := '~thor_data400::out::bair::backup::last_byperiod_manifest_inprogress';

EXPORT getBackupByPeriodReadyToGo() := FUNCTION

STRING curDate 						:= ut.GetDate:INDEPENDENT;
STRING curTime 						:= ut.GetTime():INDEPENDENT;
STRING wuPrefix         	:='W'+curDate;

wuname 									:= 'Bair Backup ByPeriod -*?';
processList             := nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state = 'completed' and STD.STR.find(wuid,wuPrefix)>0):INDEPENDENT;
processListSorted       := SORT(processList,-wuid);
lastCompletedProcess    := processListSorted[1];
lastCompletedTime       := (INTEGER)STD.STR.SplitWords(lastCompletedProcess.wuid,'-')[2];

byPeriodBackupDS        := Bair._Constant.byPeriodSF_ProcTime_JOIN;

rBackupRun := RECORD
  STRING255  supername;
  INTEGER    period;
	INTEGER    processTime;
	INTEGER    processCount;
END;
rBackupRun tBackupRun(byPeriodBackupDS L) 	:= TRANSFORM
          SELF.processCount   := COUNT(processList((INTEGER)STD.STR.SplitWords(wuid,'-')[2] > L.processTime ));
				  SELF := L;
END;
toBackup			:= PROJECT(byPeriodBackupDS , tBackupRun(LEFT))(processCount = 0 and processTime < (INTEGER)curTime);

return toBackup;

END;

EXPORT CopyUpdateByPeriodDR ()	:= FUNCTION

manifestList    				:= dataset(period_manifest_filename, Bair._Constant.manifest_layout, thor) : GLOBAL(FEW);
pVersion            		:= manifestList[1].version; 
candidateToCopy 				:= dedup(manifestList, subname, all) : GLOBAL(FEW);
candidateToCopySET      := SET(candidateToCopy,subname);
existingFilesSET    		:= SET(STD.File.LogicalFileList()(name IN candidateToCopySET),name):INDEPENDENT;

filesToBackupSET        := SET(getBackupByPeriodReadyToGo(),supername);    

filesToCopy				      := candidateToCopy(subname not in existingFilesSET and supername in filesToBackupSET);

//copyByPeriodFiles    	  := nothor(apply(filesToCopy,FS.Copy('~'+subname,'thor40', '~'+subname,SourceIP,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));
copyByPeriodFiles    	  := nothor(apply(filesToCopy,FS.Copy(SourceIP+subname,'thor40', '~'+subname,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));

subnameToCopySET    		:= SET(filesToCopy,subname);

manifest            		:= manifestList(subname IN subnameToCopySET):GLOBAL(FEW);
supernameToCleanSET 		:= SET(manifest,supername);

curSFToClean     				:= TABLE(STD.File.LogicalFileSuperSubList()(supername IN supernameToCleanSET)); 

updateSuperFiles 				:= sequential(   	 copyByPeriodFiles,
																					 FileServices.StartSuperFileTransaction(),
																						nothor(apply(curSFToClean,FileServices.ClearSuperfile('~'+supername))),
																						nothor(apply(curSFToClean,FileServices.DeleteLogicalFile('~'+subname))),
																						nothor(apply(manifest,FileServices.addsuperfile  ('~'+supername,'~'+subname))),
																					FileServices.FinishSuperFileTransaction(),
																					STD.File.DeleteLogicalFile(period_manifest_filename)
																		);
																		
RETURN updateSuperFiles;

END;

END;


