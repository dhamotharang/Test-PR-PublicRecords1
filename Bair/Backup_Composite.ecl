IMPORT Bair, STD;

EXPORT Backup_Composite := MODULE

SHARED FS														:= fileservices;
SHARED SourceIP    									:= Bair._Constant.copyFromIP;
SHARED Composite_manifest_filename  := '~thor_data400::out::bair::backup::last_Composite_manifest_inprogress';

EXPORT CopyUpdateCompositeDR ()	:= FUNCTION

CompositeSF := _Constant.CompositeSF;

manifestList 						:= dataset(Composite_manifest_filename, _Constant.manifest_layout, thor) : GLOBAL(FEW);
pVersion            		:= manifestList[1].version; 
candidateToCopy 				:= dedup(manifestList, subname, all) : GLOBAL(FEW);
candidateToCopySET      := SET(candidateToCopy,subname);
existingFilesSET    		:= SET(STD.File.LogicalFileList()(name IN candidateToCopySET),name):INDEPENDENT;

filesToCopy				      := candidateToCopy(subname not in existingFilesSET);

CompositeFilesToCopy         := filesToCopy(STD.STR.Find(buildname,'input_update') >0);
//copyCompositeFiles    	 	    := nothor(apply(CompositeFilesToCopy,FS.Copy('~'+subname,'thor40', '~'+subname,SourceIP,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));
copyCompositeFiles    	 	    := nothor(apply(CompositeFilesToCopy,FS.Copy(sourceIP+subname,'thor40', '~'+subname,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));

ctrlFilesToCopy         := filesToCopy(buildname='Composite_control');
//copyCtrlFiles       	 	:= nothor(apply(ctrlFilesToCopy,FS.Copy('~'+subname,'thor40', '~'+subname,SourceIP,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));
copyCtrlFiles       	 	:= nothor(apply(ctrlFilesToCopy,FS.Copy(sourceIP+subname,'thor40', '~'+subname,NAMED compress:=TRUE, NAMED allowoverwrite:=TRUE)));
subnameToCopySET    		:= SET(filesToCopy,subname);

manifest            		:= manifestList(subname IN subnameToCopySET):GLOBAL(FEW);
supernameToCleanSET 		:= SET(manifest,supername);

curSFToClean     				:= TABLE(STD.File.LogicalFileSuperSubList()(supername IN supernameToCleanSET)); 

prepSFSET 							:= SET(Bair._Constant.prepSF,supername);
prepFilesToFlush    		:= nothor(STD.File.LogicalFileSuperSubList()(supername in prepSFSET and STD.STR.find(subname,pVersion)>0));

updateSuperFiles 				:= sequential(   	 copyCtrlFiles,
																					 copyCompositefiles,
																					 FileServices.StartSuperFileTransaction(),
																					  nothor(apply(curSFToClean,FileServices.RemoveOwnedSubFiles('~'+supername,true))),
																						nothor(apply(curSFToClean,FileServices.ClearSuperfile('~'+supername))),
																						nothor(apply(manifest,FileServices.addsuperfile  ('~'+supername,'~'+subname))),
																						nothor(apply(prepFilesToFlush,FileServices.ClearSuperfile('~'+supername))),
																						//nothor(apply(prepFilesToDelete,FileServices.DeleteLogicalFile('~'+subname))),
																					FileServices.FinishSuperFileTransaction(),
																					STD.File.DeleteLogicalFile(Composite_manifest_filename)
																		);
RETURN updateSuperFiles;


END;

END;


