IMPORT Std, _Control, Data_Services, FLAccidents_Ecrash;

EXPORT Update_Person_ReportInjuryStatus() := FUNCTION

Location := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', '~', Data_Services.foreign_prod);

Layout_RptInjuryStatusExtract := RECORD
  STRING Incident_ID;
  STRING Person_ID;
  STRING Report_Injury_Status; //enumeration_value
END;

//Below is the extract from eCrash team with Report InjuryStatus fixed values(ECH-48677)
ds_RptInjuryStatusExtract := DATASET(Data_Services.foreign_prod + 'thor::spray::ecrash::fix_report_injury_status_data_20210413',
                                     Layout_RptInjuryStatusExtract,
													           CSV(HEADING(1), TERMINATOR(['\n','\r\n','\n\r']), SEPARATOR(','), QUOTE('"')));
														
FLAccidents_Ecrash.mac_CleanFields(ds_RptInjuryStatusExtract, Clean_ds_RptInjuryStatusExtract);
ds_RptInjuryStatusExtract_Uniq := DEDUP(SORT(DISTRIBUTE(Clean_ds_RptInjuryStatusExtract, HASH32(Incident_ID, Person_ID)),
                                             Incident_ID, Person_ID, LOCAL),
																		    Incident_ID, Person_ID, LOCAL);																		
																	
//Person File													
Layout_Person := FLAccidents_Ecrash.Layout_Infiles.persn_NEW;
ds_person := FLAccidents_Ecrash.Infiles.Persn;                  
ds_person_dist := DISTRIBUTE(ds_person, HASH32(Incident_ID, Person_ID));

Layout_Person tUpdateRptInjStatus(ds_person_dist L, ds_RptInjuryStatusExtract_Uniq R) := TRANSFORM
  IsMatching := TRIM(L.incident_id, LEFT, RIGHT) = TRIM(R.incident_id, LEFT, RIGHT) AND
					      TRIM(L.Person_ID, LEFT, RIGHT) = TRIM(R.Person_ID, LEFT, RIGHT);
	SELF.Report_injury_status := IF(IsMatching, R.Report_injury_status, L.Report_injury_status);
	SELF := L;
END;
Update_Person_RptInjStatus := JOIN(ds_person_dist, ds_RptInjuryStatusExtract_Uniq,
					                      TRIM(LEFT.incident_id, LEFT, RIGHT) = TRIM(RIGHT.incident_id, LEFT, RIGHT) AND
					                      TRIM(LEFT.Person_ID, LEFT, RIGHT) = TRIM(RIGHT.Person_ID, LEFT, RIGHT),													 
					                      tUpdateRptInjStatus(LEFT, RIGHT), LEFT OUTER, LOCAL);
 					
ds_Person_Upd_Out := OUTPUT(Update_Person_RptInjStatus ,, Files.Person_Raw_LF('ReportInjuryStatusUpdate'), OVERWRITE, __COMPRESSED__,
					                    CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));
 
Updated_Person_Raw := SEQUENTIAL(
                                ds_Person_Upd_Out,
												        STD.File.StartSuperFileTransaction(),
												        STD.File.ClearSuperFile(Files.Person_Raw_SF, FALSE),
												        STD.File.AddSuperFile(Files.Person_Raw_SF, 
																                      Files.Person_Raw_LF('ReportInjuryStatusUpdate')),
												        STD.File.FinishSuperFileTransaction()
												       );
 RETURN Updated_Person_Raw;
END;
