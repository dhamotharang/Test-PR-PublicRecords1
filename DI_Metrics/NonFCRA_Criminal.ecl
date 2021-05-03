//Felony criminal records and Non-Felony Criminal records
//W20200806-092305 Prod 
//CRIMS is a full replace file, and Dates are not historical. Just going to count records each month.
//Below code gives record counts, as well as DID count for Offenders and offense count for Court Offenses.
//Data Types: 1 = DOC, 2 = AOC, 5 = Arrests
//Offense Level/Score: F = Felony, I = Infraction, M = Misdemeanor, T = Traffic, U = Unknown

IMPORT _Control, corrections, data_services, Doxie_files, hygenics_crim, STD;
EXPORT NonFCRA_Criminal(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//orig_state, county_of_origin, process_date, datasource, source_file, case_type_desc
//rs_key_nonFCRA_CrimOffender := dataset(data_services.foreign_prod+'thor_data400::base::corrections_offenders_public', corrections.layout_offender, flat);
base_nonFCRA_CrimOffender := Hygenics_crim.File_Moxie_Crim_Offender2_Dev;
key_nonFCRA_CrimOffender := base_nonFCRA_CrimOffender; //PULL(Doxie_files.key_Offenders());
tbl_nonFCRA_CrimOffender_records := TABLE(key_nonFCRA_CrimOffender, {datasource, orig_state, record_count := count(group)}, datasource, orig_state, few);
srt_tbl_nonFCRA_CrimOffender_records := sort(tbl_nonFCRA_CrimOffender_records, datasource, orig_state);
NonFCRA_CrimOffender_DIDs := DEDUP(sort(distribute(key_nonFCRA_CrimOffender, hash(did)), did, local), did, local);
NonFCRA_CrimOffender_DIDs_bySource := DEDUP(sort(distribute(key_nonFCRA_CrimOffender, hash(datasource, orig_state, did)), datasource, orig_state, did, local), datasource, orig_state, did, local);
tbl_nonFCRA_CrimOffender_DIDs_bySource := TABLE(NonFCRA_CrimOffender_DIDs_bySource, {datasource, orig_state, did_count := count(group)}, datasource, orig_state, few);

//state_origin, process date, data_type, source_file, fcra_offense_key, offense_persistent_id, court_off_lev,offense_score, offender_key
//base_nonFCRA_CourtOffenses := dataset(data_services.foreign_prod+'thor_data400::base::corrections_court_offenses_public', hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory, flat);	
base_nonFCRA_CourtOffenses := Hygenics_crim.File_Moxie_Court_Offenses_Dev;
key_nonFCRA_CourtOffenses	:= base_nonFCRA_CourtOffenses; //PULL(doxie_files.Key_Court_Offenses());

NonFCRA_CourtOffenses_offenses := DEDUP(sort(distribute(key_nonFCRA_CourtOffenses, hash(fcra_offense_key)), fcra_offense_key, local), fcra_offense_key, local);
NonFCRA_CourtOffenses_offenses_bySource := DEDUP(sort(distribute(key_nonFCRA_CourtOffenses, hash(data_type, state_origin, offense_score, fcra_offense_key)), data_type, state_origin, offense_score, fcra_offense_key, local), data_type, state_origin, offense_score, fcra_offense_key, local);

tbl_nonFCRA_CourtOffenses_records := TABLE(key_nonFCRA_CourtOffenses, {data_type, state_origin, record_count := count(group)}, data_type, state_origin, few);
tbl_nonFCRA_CourtOffenses_offenses_bySource := TABLE(NonFCRA_CourtOffenses_offenses_bySource, {data_type, state_origin, offense_score, offense_key_count := count(group)}, data_type,state_origin,offense_score, few);

//We will have current inmates at a statewide correctional facility (aka Dept. of Corrections), but we do not have county jail records.
//data_type, orig_state, county_of_origin, process date, fcra_offense_key, offense_persistent_id, off_desc_1, offender_key
//base_nonFCRA_DOCOffenses := dataset('~thor_data400::base::corrections_offenses_public', hygenics_crim.Layout_Base_Offenses_with_OffenseCategory, flat); 	//Hygenics_Search.File_Moxie_Offenses_Dev
base_nonFCRA_DOCOffenses := Hygenics_crim.File_Moxie_DOC_Offenses_Dev;
key_nonFCRA_DOCOffenses	:= base_nonFCRA_DOCOffenses; //PULL(doxie_files.Key_Offenses());

NonFCRA_DOCOffenses_offenses := DEDUP(sort(distribute(key_nonFCRA_DOCOffenses, hash(fcra_offense_key)), fcra_offense_key, local), fcra_offense_key,  local);
NonFCRA_DOCOffenses_offenses_bySource := DEDUP(sort(distribute(key_nonFCRA_DOCOffenses, hash(data_type,orig_state,offense_score,fcra_offense_key)), data_type,orig_state,offense_score,fcra_offense_key, local), data_type,orig_state,offense_score,fcra_offense_key, local);

tbl_nonFCRA_DOCOffenses_records := TABLE(key_nonFCRA_DOCOffenses, {data_type,orig_state, record_count := count(group)}, data_type,orig_state, few);
tbl_nonFCRA_DOCOffenses_offenses_bySource := TABLE(NonFCRA_DOCOffenses_offenses_bySource, {data_type,orig_state, offense_score, offense_key_count := count(group)}, data_type,orig_state,offense_score, few);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_crim_src_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_nonfcra_crimoffender_records_'+ filedate +'.csv',
																				 pHostname, 
																				 pTarget + '/tbl_nonfcra_crimoffender_records_by_src_'+ filedate +'.csv'
																				 ,,,,true);

despray_crim_did_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_nonFCRA_CrimOffender_DIDs_bySource_'+ filedate +'.csv',
																				 pHostname, 
																				 pTarget + '/tbl_nonFCRA_CrimOffender_DIDs_bySource_'+ filedate +'.csv'
																				 ,,,,true);

despray_court_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_nonFCRA_CourtOffenses_records_'+ filedate +'.csv',
																				pHostname, 
																				pTarget + '/tbl_nonFCRA_CourtOffenses_records_'+ filedate +'.csv'
																				,,,,true);

despray_court_src_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_nonFCRA_CourtOffenses_offenses_bySource_'+ filedate +'.csv',
																				pHostname, 
																				pTarget + '/tbl_nonFCRA_CourtOffenses_offenses_bySource_'+ filedate +'.csv'
																				,,,,true);

despray_doc_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_nonFCRA_DOCOffenses_records_'+ filedate +'.csv',
																				pHostname, 
																				pTarget + '/tbl_nonFCRA_DOCOffenses_records_'+ filedate +'.csv'
																				,,,,true);

despray_doc_src_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_nonFCRA_DOCOffenses_offenses_bySource_'+ filedate +'.csv',
																				pHostname, 
																				pTarget + '/tbl_nonFCRA_DOCOffenses_offenses_bySource_'+ filedate +'.csv'
																				,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(srt_tbl_nonFCRA_CrimOffender_records,,'~thor_data400::data_insight::data_metrics::tbl_nonfcra_crimoffender_records_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(tbl_nonFCRA_CrimOffender_DIDs_bySource, datasource, orig_state),,'~thor_data400::data_insight::data_metrics::tbl_nonFCRA_CrimOffender_DIDs_bySource_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(tbl_nonFCRA_CourtOffenses_records, data_type,state_origin),,'~thor_data400::data_insight::data_metrics::tbl_nonFCRA_CourtOffenses_records_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(tbl_nonFCRA_CourtOffenses_offenses_bySource, data_type,state_origin,offense_score),,'~thor_data400::data_insight::data_metrics::tbl_nonFCRA_CourtOffenses_offenses_bySource_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(tbl_nonFCRA_DOCOffenses_records, data_type,orig_state),,'~thor_data400::data_insight::data_metrics::tbl_nonFCRA_DOCOffenses_records_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,output(sort(tbl_nonFCRA_DOCOffenses_offenses_bySource, data_type,orig_state,offense_score),,'~thor_data400::data_insight::data_metrics::tbl_nonFCRA_DOCOffenses_offenses_bySource_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_crim_src_tbl
					,despray_crim_did_tbl
					,despray_court_tbl
					,despray_court_src_tbl
					,despray_doc_tbl
					,despray_doc_src_tbl):
					Success(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_Criminal Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_Criminal Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
					);											
return email_alert;

end;