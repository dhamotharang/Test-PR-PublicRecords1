IMPORT  doxie,mdr;

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
  constants.KeyName_CCW + 'fcra::' + '@version@::did',
  constants.KeyName_CCW + '@version@::did'));
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
  Constants.KeyName_Hunting + 'fcra::' + '@version@::did',
  Constants.KeyName_Hunting + '@version@::did'));
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
  constants.KeyName_CCW_doxie_did_FCRA + '@version@',
  constants.KeyName_Emerges + '@version@::CCW_doxie_did'));
 End;

//Hunters Doxie DID
export key_hunters_doxie_did(boolean IsFCRA = false) := function
Doxie_Hunters_DID_File := if (IsFCRA,
								 FILES.Hunters_SearchFile(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),
								 Files.Hunters_SearchFile);
Doxie_DS_Hunters_did:=project(Doxie_Hunters_DID_File,
Transform(Layouts.layout_hunters_out_doxie,
self.did:= (unsigned8)left.did_out;
Self:=Left;
self := [];
));
return index(Doxie_DS_hunters_DID, {did},{Doxie_ds_hunters_did},
if (IsFCRA, 
  constants.KeyName_Hunting_doxie_did_FCRA + '@version@',
  constants.KeyName_Hunting_Doxie_Did + '@version@::did'));
End;

//Key_CCW_rid 
export Key_CCW_rid(boolean IsFCRA = false) := function
CCW_RID_File := if (IsFCRA,
								 FILES.CCW_SearchFile(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),
								 Files.CCW_SearchFile);
return index(CCW_RID_File, {rid,persistent_record_id},{CCW_RID_File},									 
if (IsFCRA, 
 constants.KeyName_CCW + 'fcra::' + '@version@::rid',
 constants.keyName_CCW + '@version@::rid'));
End;	

//Key_Hunters_rid 
export Key_Hunters_rid(boolean IsFCRA = false) := function
Hunters_RID_File := if (IsFCRA,
								 FILES.Hunters_SearchFile(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),
								 Files.Hunters_SearchFile);
return index(Hunters_RID_File, {rid,persistent_record_id},{Hunters_RID_File},	
if (IsFCRA, 
  constants.KeyName_Hunting +'fcra::' + '@version@::rid',
  constants.KeyName_Hunting + '@version@::rid'));
End;	

END;
