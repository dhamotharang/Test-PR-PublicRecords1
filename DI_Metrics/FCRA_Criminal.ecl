//Felony criminal records and Non-Felony Criminal records
//Prod W20200326-093737
// CRIMS is a full replace file, and Dates are not historical. Just going to count records each month. See FCRA_DOCKeys.
// Below code gives record counts, as well as DID count for Offenders and offense count for COurt Offenses.
// Data Types: 1 = DOC, 2 = AOC, 5 = Arrests; Offense Level/Score: F = Felony, I = Infraction, M = Misdemeanor, T = Traffic, U = Unknown

IMPORT _Control, corrections, data_services, Doxie_files, STD, ut;

export FCRA_Criminal(string pHostname, string pTarget, string pContact ='\' \'') := function

filedate := (STRING8)Std.Date.Today();
rpt_yyyymmdd := filedate[1..8];

rs_key_FCRA_CrimOffender := PULL(Doxie_files.key_Offenders(TRUE));
tbl_FCRA_CrimOffender_records := TABLE(rs_key_FCRA_CrimOffender, {datasource, orig_state, record_count := count(group)}, datasource, orig_state, few);
FCRA_CrimOffender_DIDs := DEDUP(sort(distribute(rs_key_FCRA_CrimOffender, hash(sdid)), sdid, local), sdid, all);
FCRA_CrimOffender_DIDs_bySource := DEDUP(sort(distribute(rs_key_FCRA_CrimOffender, hash(sdid)), datasource,orig_state,sdid, local), datasource,orig_state,sdid, all);
tbl_FCRA_CrimOffender_DIDs_bySource := TABLE(FCRA_CrimOffender_DIDs_bySource, {datasource,orig_state, did_count := count(group)}, datasource,orig_state, few);

rs_key_FCRA_CourtOffenses := PULL(doxie_files.Key_Court_Offenses(TRUE));

FCRA_CourtOffenses_offenses := DEDUP(sort(distribute(rs_key_FCRA_CourtOffenses, hash(fcra_offense_key)), fcra_offense_key, local), fcra_offense_key, all,local);
FCRA_CourtOffenses_offenses_bySource := DEDUP(sort(distribute(rs_key_FCRA_CourtOffenses, hash(fcra_offense_key)), data_type,state_origin,offense_score,fcra_offense_key, local), data_type,state_origin,offense_score,fcra_offense_key, all,local);

tbl_FCRA_CourtOffenses_records := TABLE(rs_key_FCRA_CourtOffenses, {data_type,state_origin, record_count := count(group)}, data_type,state_origin, few);
tbl_FCRA_CourtOffenses_offenses_bySource := TABLE(FCRA_CourtOffenses_offenses_bySource, {data_type,state_origin, offense_score, offense_key_count := count(group)}, data_type,state_origin,offense_score, few);

//We will have current inmates at a statewide correctional facility (aka Dept. of Corrections), but we do not have county jail records.
rs_key_FCRA_DOCOffenses := PULL(doxie_files.Key_Offenses(TRUE));

FCRA_DOCOffenses_offenses := DEDUP(sort(distribute(rs_key_FCRA_DOCOffenses, hash(fcra_offense_key)), fcra_offense_key, local), fcra_offense_key, all,local);
FCRA_DOCOffenses_offenses_bySource := DEDUP(sort(distribute(rs_key_FCRA_DOCOffenses, hash(fcra_offense_key)), data_type,orig_state,offense_score,fcra_offense_key, local), data_type,orig_state,offense_score,fcra_offense_key, all,local);

tbl_FCRA_DOCOffenses_records := TABLE(rs_key_FCRA_DOCOffenses, {data_type,orig_state, record_count := count(group)}, data_type,orig_state, few);
tbl_FCRA_DOCOffenses_offenses_bySource := TABLE(FCRA_DOCOffenses_offenses_bySource, {data_type,orig_state, offense_score, offense_key_count := count(group)}, data_type,orig_state,offense_score, few);

//Despray to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_crim_src_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_CrimOffender_records_by_src_'+ filedate +'.csv',
																				 pHostname, 
																				 pTarget + '/tbl_FCRA_CrimOffender_records_by_src_'+ filedate +'.csv'
																				 ,,,,true);

despray_crim_did_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_CrimOffender_DIDs_bySource_'+ filedate +'.csv',
																				 pHostname, 
																				 pTarget + '/tbl_FCRA_CrimOffender_DIDs_bySource_'+ filedate +'.csv'
																				 ,,,,true);

despray_court_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_CourtOffenses_records_'+ filedate +'.csv',
																		       pHostname, 
																			   pTarget + '/tbl_FCRA_CourtOffenses_records_'+ filedate +'.csv'
																			,,,,true);

despray_court_src_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_CourtOffenses_offenses_bySource_'+ filedate +'.csv',
																				pHostname, 
																				pTarget + '/tbl_FCRA_CourtOffenses_offenses_bySource_'+ filedate +'.csv'
																				,,,,true);

despray_doc_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_DOCOffenses_records_'+ filedate +'.csv',
																		pHostname, 
																		pTarget + '/tbl_FCRA_DOCOffenses_records_'+ filedate +'.csv'
																		,,,,true);

despray_doc_src_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_FCRA_DOCOffenses_offenses_bySource_'+ filedate +'.csv',
																				pHostname, 
																				pTarget +'/tbl_FCRA_DOCOffenses_offenses_bySource_'+ filedate +'.csv'
																				,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_FCRA_CrimOffender_records, datasource, orig_state),,'~thor_data400::data_insight::data_metrics::tbl_FCRA_CrimOffender_records_by_src_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(sort(tbl_FCRA_CrimOffender_DIDs_bySource, datasource, orig_state),,'~thor_data400::data_insight::data_metrics::tbl_FCRA_CrimOffender_DIDs_bySource_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(sort(tbl_FCRA_CourtOffenses_records, data_type,state_origin),,'~thor_data400::data_insight::data_metrics::tbl_FCRA_CourtOffenses_records_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(sort(tbl_FCRA_CourtOffenses_offenses_bySource, data_type,state_origin,offense_score),,'~thor_data400::data_insight::data_metrics::tbl_FCRA_CourtOffenses_offenses_bySource_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(sort(tbl_FCRA_DOCOffenses_records, data_type,orig_state),,'~thor_data400::data_insight::data_metrics::tbl_FCRA_DOCOffenses_records_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,output(sort(tbl_FCRA_DOCOffenses_offenses_bySource, data_type,orig_state,offense_score),,'~thor_data400::data_insight::data_metrics::tbl_FCRA_DOCOffenses_offenses_bySource_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')),overwrite)
					,despray_crim_src_tbl
					,despray_crim_did_tbl
					,despray_court_tbl
					,despray_court_src_tbl
					,despray_doc_tbl
					,despray_doc_src_tbl):
					Success(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Criminal Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'FCRA Group: FCRA_Criminal Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
													
return email_alert;

end;