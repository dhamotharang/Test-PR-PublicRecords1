IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_PropertyDamage_RemoveRawDupes() := FUNCTION												
																
 ds_PropertyDamage_Unique := FLAccidents_Ecrash.Infiles.Property_damage;
 Layout_PropertyDamage := FLAccidents_Ecrash.Layout_Infiles.Property_damage;
	
 ds_PropertyDamage_Upd_Out := OUTPUT(ds_PropertyDamage_Unique ,, Files.PropertyDamage_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
																 
 New_PropertyDamage_Raw := SEQUENTIAL(
                                      ds_PropertyDamage_Upd_Out,
												              STD.File.StartSuperFileTransaction(),
												              STD.File.ClearSuperFile(Files.PropertyDamage_Raw_SF, FALSE),
												              STD.File.AddSuperFile(Files.PropertyDamage_Raw_SF, 
																	                          Files.PropertyDamage_Raw_LF('RemoveDupes')),
												              STD.File.FinishSuperFileTransaction()
												             );
 RETURN New_PropertyDamage_Raw;
END;