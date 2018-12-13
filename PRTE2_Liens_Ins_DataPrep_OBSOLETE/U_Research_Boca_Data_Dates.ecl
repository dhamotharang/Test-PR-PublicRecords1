
IMPORT PRTE2_Liens;

// Initial data 
main		:= PRTE2_Liens.files.MainStatus(TMSID <> ''); //Spreadsheet passed blank records
Party 	:= PRTE2_Liens.files.SprayParty(TMSID <> ''); //Spreadsheet passed blank records


// BaseStatus_in 
// process_date;


// BaseMain_IN
OUTPUT(MAX(main,process_date),NAMED('process_date'));
OUTPUT(MAX(main,date_vendor_removed),NAMED('date_vendor_removed'));
OUTPUT(MAX(main,orig_filing_date),NAMED('orig_filing_date'));
OUTPUT(MAX(main,filing_date),NAMED('filing_date'));
OUTPUT(MAX(main,vendor_entry_date),NAMED('vendor_entry_date'));
OUTPUT(MAX(main,release_date),NAMED('release_date'));
OUTPUT(MAX(main,judg_satisfied_date),NAMED('judg_satisfied_date'));
OUTPUT(MAX(main,judg_vacated_date),NAMED('judg_vacated_date'));
OUTPUT(MAX(main,effective_date),NAMED('effective_date'));
OUTPUT(MAX(main,lapse_date),NAMED('lapse_date'));
OUTPUT(MAX(main,accident_date),NAMED('accident_date'));
OUTPUT(MAX(main,expiration_date),NAMED('expiration_date'));

// dataset(layout_filing_status) filing_status;


// BaseParty_IN
OUTPUT(MAX(party,date_first_seen),NAMED('date_first_seen'));
OUTPUT(MAX(party,date_last_seen),NAMED('date_last_seen'));
OUTPUT(MAX(party,date_vendor_first_reported),NAMED('date_vendor_first_reported'));
OUTPUT(MAX(party,date_vendor_last_reported),NAMED('date_vendor_last_reported'));
