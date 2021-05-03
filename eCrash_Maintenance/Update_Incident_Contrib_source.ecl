IMPORT Std, _Control, Data_Services, FLAccidents_Ecrash;

EXPORT Update_Incident_Contrib_source() := FUNCTION

Location := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', '~', Data_Services.foreign_prod);

Layout_Incident_CS := RECORD
  STRING incident_id;
  STRING contrib_source;
  STRING vendor_code;
END;

//Below are the extracts from eCrash team with Contrib Source info available for the blank ContribSource incidents from 2016 till 20201105
// ds_incident_CS :=	DATASET(Location + 'thor::spray::ecrash::incidents::2016_contrib_source_null_hpcc_file', 
ds_incident_CS :=	DATASET(Location + 'thor::spray::ecrash::incidents::2016_contrib_source_null_hpcc_file::delta_20201118', 
                          Layout_Incident_CS,
                          CSV(HEADING(single), TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
FLAccidents_Ecrash.mac_CleanFields(ds_incident_CS, Clean_ds_incident_CS);
ds_incident_CS_Uniq := DEDUP(Clean_ds_incident_CS, incident_id);
													
Layout_Incident := FLAccidents_Ecrash.Layout_Infiles.incident_new;
ds_incident := FLAccidents_Ecrash.Infiles.incident;                  

Layout_Incident tUpdateContribSrc(ds_incident L, ds_incident_CS_Uniq R) := TRANSFORM
	SELF.contrib_source := IF(L.contrib_source = '', R.contrib_source, L.Contrib_source);
	SELF := L;
END;

Update_Incident_CS := JOIN(ds_incident, ds_incident_CS_Uniq,
					                 TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT),
					                 tUpdateContribSrc(LEFT, RIGHT), LEFT OUTER, LOOKUP);
 					
ds_Incident_Upd_Out := OUTPUT(Update_Incident_CS ,, Files.Incident_Raw_LF('PopulateContribSource_delta'), OVERWRITE, __COMPRESSED__,
					                    CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 
Updated_Incident_Raw := SEQUENTIAL(
                                ds_Incident_Upd_Out,
												        STD.File.StartSuperFileTransaction(),
												        STD.File.ClearSuperFile(Files.Incident_Raw_SF, FALSE),
												        STD.File.AddSuperFile(Files.Incident_Raw_SF, 
																                      Files.Incident_Raw_LF('PopulateContribSource_delta')),
												        STD.File.FinishSuperFileTransaction()
												       );
 RETURN Updated_Incident_Raw;
END;