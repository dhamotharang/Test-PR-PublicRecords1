IMPORT Bair, STD;

EXPORT Backup_Prep := MODULE

SHARED FS												:= fileservices;
SHARED SourceIP    							:= Bair._Constant.copyFromIP;
SHARED prep_manifest_filename   := '~thor_data400::out::bair::backup::last_prep_manifest_inprogress';
SHARED period_manifest_fileName	:= '~thor_data400::out::bair::backup::last_byperiod_manifest_inprogress';

EXPORT CopyUpdatePrepDR ()	:= FUNCTION

prepSF := Bair._Constant.prepSF;

manifestListComplete  	:= dataset(prep_manifest_filename, _Constant.manifest_layout, thor) : GLOBAL(FEW);
manifestList				  	:= manifestListComplete(STD.STR.Find(buildName,'prepByPeriod')=0);
pVersion            		:= manifestList[1].version; 
candidateToCopy 				:= dedup(manifestList, subname, all) : GLOBAL(FEW);
candidateToCopySET      := SET(candidateToCopy,subname);
existingFilesSET    		:= SET(STD.File.LogicalFileList()(name IN candidateToCopySET),name):INDEPENDENT;

filesToCopy				      := candidateToCopy(subname not in existingFilesSET);

prepFilesToCopy         := filesToCopy(STD.STR.Find(buildname,'input') >0);
//copyPrepFiles    	 	    := nothor(apply(prepFilesToCopy,FS.Copy('~'+subname,'thor40', '~'+subname,SourceIP,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));
copyPrepFiles    	 	    := nothor(apply(prepFilesToCopy,FS.Copy(SourceIP+subname,'thor40', '~'+subname,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));

ctrlFilesToCopy         := filesToCopy(STD.STR.Find(buildName,'control')>0);
//copyCtrlFiles       	 	:= nothor(apply(ctrlFilesToCopy,FS.Copy('~'+subname,'thor40', '~'+subname,SourceIP,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));
copyCtrlFiles       	 	:= nothor(apply(ctrlFilesToCopy,FS.Copy(SourceIP+subname,'thor40', '~'+subname,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));

subnameToCopySET    		:= SET(filesToCopy,subname);

manifest            		:= manifestList(subname IN subnameToCopySET):GLOBAL(FEW);
supernameToCleanSET 		:= SET(manifest,supername);

curSFToClean     				:= TABLE(STD.File.LogicalFileSuperSubList()(supername IN supernameToCleanSET)); 

deleteCurPrepFile			  := STD.File.DeleteLogicalFile(prep_manifest_fileName); 
deleteCurPerFile 				:= STD.File.DeleteLogicalFile(period_manifest_fileName); 
periodManifestList			:= manifestListComplete(STD.STR.Find(buildName,'prepByPeriod')>0);
createNewPerFile 				:= output(periodManifestList,,period_manifest_fileName,THOR,OVERWRITE);

updateSuperFiles 				:= sequential(   	 copyCtrlFiles,
																					 copyPrepfiles,
																			   FileServices.StartSuperFileTransaction(),
																						nothor(apply(curSFToClean,FileServices.ClearSuperfile('~'+supername))),
																						nothor(apply(curSFToClean,FileServices.DeleteLogicalFile('~'+subname))),
																						nothor(apply(manifest,FileServices.addsuperfile  ('~'+supername,'~'+subname))),
																				 FileServices.FinishSuperFileTransaction(),
																				 deleteCurPerFile,		
																				 createNewPerFile,
																				 deleteCurPrepFile
																	);
RETURN updateSuperFiles;


END;

END;
