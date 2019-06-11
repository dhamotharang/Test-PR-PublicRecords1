IMPORT  doxie,mdr,ut;

EXPORT keys := MODULE
 	
//Key_CCW_Did
export Key_CCW_Did(boolean IsFCRA = false) := function
CCW_DID_File := if (IsFCRA,
								 FILES.CCW_SearchFile(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),
								 Files.CCW_SearchFile);
DS_CCW_did:=project(CCW_DID_File,
Transform(Layouts.Layout_CCW_did,
self.did_out6:= (unsigned6)left.did_out;
Self:=Left;
));
return index(DS_ccw_DID, {did_out6},{ds_ccw_did},
if(IsFCRA, 
  constants.KeyName_CCW + 'fcra::' + doxie.Version_SuperKey +'::did',
  constants.KeyName_CCW + doxie.Version_SuperKey + '::did'));
End;

//key_hunting_fishing_did
export key_hunting_fishing_did(boolean IsFCRA = false) := function
Hunters_DID_File := if (IsFCRA,
		    FILES.Hunters_SearchFile(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),
				Files.Hunters_SearchFile);
DS_Hunters_did:=project(Hunters_DID_File,
Transform(Layouts.Layout_Hunters_did,
self.did:= (unsigned6)left.did_out;
Self:=Left;
));
return index(DS_Hunters_DID, {did},{ds_hunters_did},	
if (IsFCRA, 
  Constants.KeyName_Hunting + 'fcra::' + doxie.Version_SuperKey + '::did',
  Constants.KeyName_Hunting + doxie.Version_SuperKey +'::did'));
End;

//Doxie DID
export key_ccw_doxie_did(boolean IsFCRA = false) := function
Doxie_CCW_DID_File := if (IsFCRA,
								 FILES.CCW_SearchFile(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),
								 Files.CCW_SearchFile);
Doxie_DS_CCW_did:=project(Doxie_CCW_DID_File,
Transform(Layouts.layout_ccw_out_doxie,
self.did:= (unsigned8)left.did_out;
Self:=Left;
self := [];
));
return index(Doxie_DS_ccw_DID, {did},{Doxie_ds_ccw_did},	
if (IsFCRA, 
  constants.KeyName_CCW_doxie_did_FCRA + doxie.Version_SuperKey,
  constants.KeyName_Emerges + doxie.Version_SuperKey + '::CCW_doxie_did'));
 End;

//Hunters Doxie DID
export key_hunters_doxie_did(boolean IsFCRA = false) := function

// DF-22634: FCRA Consumer Data Field Depreciation 
ut.MAC_CLEAR_FIELDS(FILES.Hunters_SearchFile, Hunters_SearchFile_cleaned, constants.fields_to_clear_doxie_did );
Doxie_Hunters_DID_File := if (IsFCRA,
															Hunters_SearchFile_cleaned(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),
															Files.Hunters_SearchFile);
															
Doxie_DS_Hunters_did:=project(Doxie_Hunters_DID_File,
Transform(Layouts.layout_hunters_out_doxie,
self.did:= (unsigned8)left.did_out;
Self:=Left;
self := [];
));
return index(Doxie_DS_hunters_DID, {did},{Doxie_ds_hunters_did},
if (IsFCRA, 
  constants.KeyName_Hunting_doxie_did_FCRA + doxie.Version_SuperKey,
  constants.KeyName_Hunting_Doxie_Did + doxie.Version_SuperKey +'::did'));
End;

//Key_CCW_rid 
export Key_CCW_rid(boolean IsFCRA = false) := function
CCW_RID_File := if (IsFCRA,
								 FILES.CCW_SearchFile(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),
								 Files.CCW_SearchFile);
return index(CCW_RID_File, {rid,persistent_record_id},{CCW_RID_File},									 
							if (IsFCRA, 
									constants.KeyName_CCW + 'fcra::' + doxie.Version_SuperKey + '::rid',
									constants.keyName_CCW + doxie.Version_SuperKey +'::rid'));
End;	

//Key_Hunters_rid 
export Key_Hunters_rid(boolean IsFCRA = false) := function

// DF-22634: FCRA Consumer Data Field Depreciation 
ut.MAC_CLEAR_FIELDS(FILES.Hunters_SearchFile, Hunters_SearchFile_cleaned, constants.fields_to_clear_hunter_rid );

Hunters_RID_File := if(IsFCRA,
											Hunters_SearchFile_cleaned(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),
											Files.Hunters_SearchFile);
											
return index(Hunters_RID_File, {rid,persistent_record_id},{Hunters_RID_File},	
						if (IsFCRA, 
								constants.KeyName_Hunting +'fcra::' + doxie.Version_SuperKey +'::rid',
								constants.KeyName_Hunting + doxie.Version_SuperKey +'::rid'));
End;	

END;
