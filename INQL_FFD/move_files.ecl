IMPORT Inql_ffd;

export MOVE_FILES(boolean isUpdate = true, boolean isFCRA = true, string pVersion = '') := module
	
	shared FS 		:= fileservices;

	export Current_To_In_Building := sequential(
					FS.StartSuperFileTransaction(),
					  nothor(FS.AddSuperFile(filenames(isUpdate, isFCRA, pVersion).InputBuilding,
						                       filenames(isUpdate, isFCRA, pVersion).Input,addcontents := true)),
						nothor(FS.ClearSuperFile(filenames(isUpdate, isFCRA, pVersion).Input, false)),	
						nothor(FS.AddSuperFile(filenames(isUpdate, isFCRA, pVersion,True).InputBuilding,   
						                       filenames(isUpdate, isFCRA, pVersion,True).Input,addcontents := true)),
						nothor(FS.ClearSuperFile(filenames(isUpdate, isFCRA, pVersion,true).Input, false)),	
					FS.FinishSuperFileTransaction()
						);
	
	export In_Building_To_Built := sequential(
				FS.StartSuperFileTransaction(),
					nothor(FS.PromoteSuperFileList([filenames(isUpdate, isFCRA, pVersion).InputBuilding, 
																					filenames(isUpdate, isFCRA, pVersion).InputBuilt])),
					nothor(FS.PromoteSuperFileList([filenames(isUpdate, isFCRA, pVersion,true).InputBuilding, 
																					filenames(isUpdate, isFCRA, pVersion,true).InputBuilt])),
				FS.FinishSuperFileTransaction()
					);	
	
	shared lexid_delta_key:='~'+max(nothor(fileservices.SuperFileContents(inql_ffd.keynames(true).lexid.qa)),name);
 	shared group_rid_delta_key:='~'+max(nothor(fileservices.SuperFileContents(inql_ffd.keynames(true).Group_RID.qa)),name);
	shared group_rid_encrypted_delta_key:='~'+max(nothor(fileservices.SuperFileContents(inql_ffd.keynames(true).group_rid_encrypted.qa)),name);
  shared remove_previous_delta := sequential
										(nothor(fileservices.RemoveSuperFile(inql_ffd.keynames(true).lexid.qa,lexid_delta_key));
										 nothor(fileservices.RemoveSuperFile(inql_ffd.keynames(true).lexid.built,lexid_delta_key));
										 nothor(fileservices.RemoveSuperFile(inql_ffd.keynames(true).group_rid.qa,group_rid_delta_key));	
										 nothor(fileservices.RemoveSuperFile(inql_ffd.keynames(true).group_rid.built,group_rid_delta_key));	
										 nothor(fileservices.RemoveSuperFile(inql_ffd.keynames(true).group_rid_encrypted.qa,group_rid_encrypted_delta_key));	
										 nothor(fileservices.RemoveSuperFile(inql_ffd.keynames(true).group_rid_encrypted.built,group_rid_encrypted_delta_key));	
										 );

	export Lexid			:= SEQUENTIAL(
													 nothor(fileservices.StartSuperFileTransaction()),
													 nothor(fileservices.addsuperfile(inql_ffd.keynames(true).Lexid.qa,inql_ffd.keynames(true,pVersion).Lexid.new)),
													 nothor(fileservices.addsuperfile(inql_ffd.keynames(true).Lexid.built,inql_ffd.keynames(true,pVersion).Lexid.new)),
													 nothor(fileservices.FinishSuperFileTransaction())
																			);

  	export Group_RID 	 := SEQUENTIAL(
													 nothor(fileservices.StartSuperFileTransaction()),
													 nothor(fileservices.addsuperfile(inql_ffd.keynames(true).Group_RID.qa,inql_ffd.keynames(true,pVersion).Group_RID.new)),
													 nothor(fileservices.addsuperfile(inql_ffd.keynames(true).Group_RID.built,inql_ffd.keynames(true,pVersion).Group_RID.new)),
													 nothor(fileservices.FinishSuperFileTransaction())
																			);

  export Group_RID_Encrypted := SEQUENTIAL(
													 nothor(fileservices.StartSuperFileTransaction()),
													 nothor(fileservices.addsuperfile(inql_ffd.keynames(true).Group_RID_Encrypted.qa,inql_ffd.keynames(true,pVersion).Group_RID_Encrypted.new)),
													 nothor(fileservices.addsuperfile(inql_ffd.keynames(true).Group_RID_Encrypted.built,inql_ffd.keynames(true,pVersion).Group_RID_Encrypted.new)),
													 nothor(fileservices.FinishSuperFileTransaction())
																			);
	export Delta_Keys  := sequential(
	                               if(Inql_ffd._Flags().ExistDeltaKey,remove_previous_delta),
	                               lexid,
	                               group_rid,
																 group_rid_encrypted);
 						
end;