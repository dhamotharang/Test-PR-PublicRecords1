IMPORT Bair, STD;

EXPORT Backup_Base := MODULE

SHARED FS														:= fileservices;
SHARED SourceIP    									:= Bair._Constant.copyFromIP;
SHARED base_manifest_filename       := '~thor_data400::out::bair::backup::last_base_manifest_inprogress';

EXPORT CopyUpdateBaseDR ()	:= FUNCTION

baseSF := _Constant.baseSF;

manifestList 						:= dataset(base_manifest_filename, _Constant.manifest_layout, thor) : GLOBAL(FEW);
pVersion            		:= manifestList[1].version; 
candidateToCopy 				:= dedup(manifestList, subname, all) : GLOBAL(FEW);
candidateToCopySET      := SET(candidateToCopy,subname);
existingFilesSET    		:= SET(STD.File.LogicalFileList()(name IN candidateToCopySET),name):INDEPENDENT;

filesToCopy				      := candidateToCopy(subname not in existingFilesSET);

baseFilesToCopy         := filesToCopy(STD.STR.Find(buildname,'input_update') >0);
//copyBaseFiles    	 	    := nothor(apply(baseFilesToCopy,FS.Copy('~'+subname,'thor40', '~'+subname,SourceIP,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));
copyBaseFiles    	 	    := nothor(apply(baseFilesToCopy,FS.Copy(sourceIP+subname,'thor40', '~'+subname,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));

packageFilesToCopy      := filesToCopy(buildname = 'package');
//copyPackageFiles       	:= nothor(apply(packageFilesToCopy,FS.Copy('~'+subname,'thor40', '~'+subname,SourceIP,NAMED compress:=FALSE, NAMED allowoverwrite:=TRUE)));
copyPackageFiles       	:= nothor(apply(packageFilesToCopy,FS.Copy(sourceIP+subname,'thor40', '~'+subname,NAMED compress:=FALSE, NAMED allowoverwrite:=TRUE)));

ctrlFilesToCopy         := filesToCopy(buildname='base_control');
//copyCtrlFiles       	 	:= nothor(apply(ctrlFilesToCopy,FS.Copy('~'+subname,'thor40', '~'+subname,SourceIP,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));
copyCtrlFiles       	 	:= nothor(apply(ctrlFilesToCopy,FS.Copy(sourceIP+subname,'thor40', '~'+subname,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));
subnameToCopySET    		:= SET(filesToCopy,subname);

manifest            		:= manifestList(subname IN subnameToCopySET):GLOBAL(FEW);
supernameToCleanSET 		:= SET(manifest,supername);

curSFToClean     				:= TABLE(STD.File.LogicalFileSuperSubList()(supername IN supernameToCleanSET)); 

FinalSfSet							:= SET(curSFToClean,supername);
FinalLgSet							:= SET(curSFToClean,subname);

OrphanSFToClean 				:= TABLE(STD.File.LogicalFileSuperSubList()(subname in FinalLgSet and supername not in FinalSfSet));
OrphanSFSET							:= SET(OrphanSFToClean,subname);

curSFToDelete						:= curSFToClean(subname not in OrphanSFSET);

prepSFSET 							:= SET(Bair._Constant.prepSF,supername);
prepFilesToFlush    		:= nothor(STD.File.LogicalFileSuperSubList()(supername in prepSFSET and STD.STR.find(subname,pVersion)>0));

updateSuperFiles 				:= sequential(   	 copyCtrlFiles,
																					 copyPackageFiles,
																					 copyBasefiles,
																					 FileServices.StartSuperFileTransaction(),
																						nothor(apply(curSFToClean,FileServices.ClearSuperfile('~'+supername))),
																						nothor(apply(curSFToDelete,FileServices.DeleteLogicalFile('~'+subname))),
																						nothor(apply(manifest,FileServices.addsuperfile  ('~'+supername,'~'+subname))),
																						nothor(apply(prepFilesToFlush,FileServices.ClearSuperfile('~'+supername))),
																						//nothor(apply(prepFilesToDelete,FileServices.DeleteLogicalFile('~'+subname))),
																					FileServices.FinishSuperFileTransaction(),
																					STD.File.DeleteLogicalFile(base_manifest_filename)
																		);
RETURN updateSuperFiles;


END;

END;


