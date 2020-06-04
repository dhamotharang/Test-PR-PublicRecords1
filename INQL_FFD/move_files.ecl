IMPORT Inql_ffd;

export MOVE_FILES(boolean isUpdate = true, boolean isFCRA = true, string pVersion = '') := module
	
	shared FS 		:= fileservices;

	export Current_To_In_Building := sequential(
					FS.StartSuperFileTransaction(),
					  nothor(FS.AddSuperFile(filenames(isUpdate, isFCRA, pVersion).InputBuilding,
						                       filenames(isUpdate, isFCRA, pVersion).Input,addcontents := true)),
						nothor(FS.ClearSuperFile(filenames(isUpdate, isFCRA, pVersion).Input, false)),											 
					FS.FinishSuperFileTransaction()
						);
	
	export In_Building_To_Built := sequential(
				FS.StartSuperFileTransaction(),
					nothor(FS.PromoteSuperFileList([filenames(isUpdate, isFCRA, pVersion).InputBuilding, 
																					filenames(isUpdate, isFCRA, pVersion).InputBuilt])),
				FS.FinishSuperFileTransaction()
					);	
	
	shared version_regexp  := '([0-9]{8}[a-z]?)';
  shared LexidFileToRemove    := '~' + if(isUpdate, nothor(fileservices.GetSuperFileSubName(inql_ffd.keynames(true).Lexid.qa, 2)),
																				 nothor(fileservices.GetSuperFileSubName(inql_ffd.keynames(true).Lexid.qa, 1))
															);	
  shared GroupRIDFileToRemove := '~' + if(isUpdate, nothor(fileservices.GetSuperFileSubName(inql_ffd.keynames(true).GroupRID.qa, 2)),
																				 nothor(fileservices.GetSuperFileSubName(inql_ffd.keynames(true).GroupRID.qa, 1))
															);			
	shared filepos              := if(isUpdate,2,1); 	
	
	export Lexid					 := SEQUENTIAL(
													 nothor(fileservices.StartSuperFileTransaction()),
													 nothor(fileservices.RemoveSuperFile(inql_ffd.keynames(true).Lexid.qa,LexidFileToRemove)),
													 nothor(fileservices.RemoveSuperFile(inql_ffd.keynames(true).Lexid.built,LexidFileToRemove)),
													 nothor(fileservices.addsuperfile(inql_ffd.keynames(true).Lexid.qa,inql_ffd.keynames(true,pVersion).Lexid.new,filepos)),
													 nothor(fileservices.addsuperfile(inql_ffd.keynames(true).Lexid.built,inql_ffd.keynames(true,pVersion).Lexid.new,filepos)),
													 nothor(fileservices.FinishSuperFileTransaction())
																			);

	export GroupRID					 := SEQUENTIAL(
													 nothor(fileservices.StartSuperFileTransaction()),
													 nothor(fileservices.RemoveSuperFile(inql_ffd.keynames(true).GroupRID.qa,GroupRIDFileToRemove)),
													 nothor(fileservices.RemoveSuperFile(inql_ffd.keynames(true).GroupRID.built,GroupRIDFileToRemove)),
													 nothor(fileservices.addsuperfile(inql_ffd.keynames(true).GroupRID.qa,inql_ffd.keynames(true,pVersion).GroupRID.new,filepos)),
													 nothor(fileservices.addsuperfile(inql_ffd.keynames(true).GroupRID.built,inql_ffd.keynames(true,pVersion).GroupRID.new,filepos)),
													 nothor(fileservices.FinishSuperFileTransaction())
																			);


// );
	
 						
end;