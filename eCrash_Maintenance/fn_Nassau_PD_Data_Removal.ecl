IMPORT Data_Services, STD, FLAccidents_Ecrash;

EXPORT  fn_Nassau_PD_Data_Removal(STRING Pdate = (STRING) STD.Date.CurrentDate(TRUE)) := FUNCTION

  lay_NassauPD_data_removal_stats := RECORD
	  STRING Desc;
	  UNSIGNED8 total_incidents;
	  UNSIGNED8 total_NassauPD_incidents;
	  UNSIGNED8 total_incidents_after_delete;
	  UNSIGNED8 total_NassauPD_incidents_after_delete;
	END;
		
  incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
											,FLAccidents_Ecrash.Layout_Infiles.incident_new
											,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)))(incident_id != 'Incident_ID');
												
	//Distribute DS
	d_incident := DISTRIBUTE(incident, HASH32(incident_id)):INDEPENDENT;

	//NassauPD Incidents									
	NassauPD_incident := d_incident(source_id in ['TF','TM'] and agency_id = '1603437' and sent_to_hpcc_datetime < '2020-01-01'):PERSIST('~THOR::BASE::PERSIST::ECRASH::NPD_DATA_REMOVAL::INCIDENTS', EXPIRE(30), SINGLE);;

  //Incident file deletion
  incident_after_NassauPD_deletion := d_incident(~(source_id in ['TF','TM'] and agency_id = '1603437' and sent_to_hpcc_datetime < '2020-01-01')):INDEPENDENT;

  output_incident := OUTPUT(incident_after_NassauPD_deletion,,'~thor_data400::in::ecrash::NassauPD_data_removal_incident_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                     CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));
	
	incident_out := SEQUENTIAL(
														 output_incident,
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
														 FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::NassauPD_data_removal_incident_'+workunit),
														 FileServices.FinishSuperFileTransaction()
													  );
														
  //Calculating stats
  ds_pre_delete := DATASET([{'PRE_DELETE', COUNT(incident), COUNT(NassauPD_incident), 0, 0}], lay_NassauPD_data_removal_stats);
	ds_post_delete := DATASET([{'POST_DELETE', ds_pre_delete[1].total_incidents, ds_pre_delete[1].total_NassauPD_incidents, COUNT(incident_after_NassauPD_deletion), COUNT(NassauPD_incident)}], lay_NassauPD_data_removal_stats);
  ds_NassauPD_data_removal_incident_removal_stats := ds_pre_delete & ds_post_delete;
	
	delete_NassauPD_data := SEQUENTIAL(
																		 OUTPUT(ds_pre_delete,,NAMED('PRE_DELETE')),
																		 incident_out,
																		 OUTPUT(ds_post_delete,,NAMED('POST_DELETE')),
																		 OUTPUT(ds_NassauPD_data_removal_incident_removal_stats,,NAMED('NassauPD_REMOVAL_STATS'))
																		);
	 
	RETURN delete_NassauPD_data;
END;
