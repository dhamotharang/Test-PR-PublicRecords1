/*
One time BWR to update Incident file field is_Delete to 0 for blank records.
*/
IMPORT Data_Services, FLAccidents_Ecrash, STD;
EXPORT Update_Incident_is_delete_to_0_from_blank() := FUNCTION
 
 Layout_Incident := FLAccidents_Ecrash.Layout_Infiles.incident_new;
 ds_incident := FLAccidents_Ecrash.Infiles.incident;
 
 Layout_Incident UpdateisDelete(ds_incident L) := TRANSFORM
  SELF.is_Delete := IF(TRIM(L.is_Delete, LEFT, RIGHT) = '', '0', L.is_Delete);
  SELF := L;
 END;
 upd_isDelete := PROJECT(ds_incident, UpdateisDelete(LEFT));
 
 ds_Incident_Upd_Out := OUTPUT(upd_isDelete ,, Files.Incident_Raw_LF('update_isdelete'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
		
 New_Incident_Raw := SEQUENTIAL(
                                ds_Incident_Upd_Out,
												        STD.File.StartSuperFileTransaction(),
												        STD.File.ClearSuperFile(Files.Incident_Raw_SF, FALSE),
												        STD.File.AddSuperFile(Files.Incident_Raw_SF, 
																                      Files.Incident_Raw_LF('update_isdelete')),
												        STD.File.FinishSuperFileTransaction()
												       );
 RETURN New_Incident_Raw;
END;

