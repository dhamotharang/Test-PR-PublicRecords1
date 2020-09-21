IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_PropertyDamage_RemoveRawDupes() := FUNCTION												
																
  ds_PropertyDamage := FLAccidents_Ecrash.Infiles.Property_damage;
  Layout_PropertyDamage := FLAccidents_Ecrash.Layout_Infiles.Property_damage;
	
 ds_PropertyDamage_Unique := DEDUP(ds_PropertyDamage, ALL);
 					
 ds_PropertyDamage_Upd_Out := OUTPUT(ds_PropertyDamage_Unique ,, Files.PropertyDamage_Raw_LF('RemoveDupes'), OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 ds_PropertyDamage_Cnt := OUTPUT(COUNT(ds_PropertyDamage), NAMED('Count_PropertyDamage'));
 ds_PropertyDamage_Unique_Cnt := OUTPUT(COUNT(ds_PropertyDamage_Unique), NAMED('Count_PropertyDamage_AfterChange'));
 
 New_PropertyDamage_Raw := SEQUENTIAL(ds_PropertyDamage_Cnt,
                                  ds_PropertyDamage_Upd_Out,
												          STD.File.StartSuperFileTransaction(),
												          STD.File.ClearSuperFile(Files.PropertyDamage_Raw_SF, FALSE),
												          STD.File.AddSuperFile(Files.PropertyDamage_Raw_SF, 
																	                      Files.PropertyDamage_Raw_LF('RemoveDupes')),
												          STD.File.FinishSuperFileTransaction(),
																	ds_PropertyDamage_Unique_Cnt
												         );
 RETURN New_PropertyDamage_Raw;
END;