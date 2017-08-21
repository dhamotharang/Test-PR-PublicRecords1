// EXPORT liens_main_spc := 'todo';

MODULE:Scrubs_LiensV2_Main
FILENAME:File_Liens_Main

//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>

SOURCEFIELD:source_file

FIELDTYPE:number:LIKE():ALLOW(0123456789):NOQUOTES("'):
FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'):SPACES( <>{}[]-^=!+&,./#()):LENGTHS(0,1..)
FIELDTYPE:invalid_date:LIKE(NUMBER):LENGTHS(0,4,6,8)
FIELDTYPE:invalid_amount:ALLOW(0123456789):SPACES( <>{}[]-^=!+&,./#())
FIELDTYPE:invalid_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( <>{}[]-^=!+&,./#())
FIELDTYPE:invalid_record_code:ENUM(1|2|3|6|C|E|)
FIELDTYPE:invalid_eviction_ind:ENUM(Y|N|0|1|2|3|4|5|6|7|8|9|)
FIELDTYPE:invalid_filing_type:CUSTOM(Scrubs_LiensV2_CA_Federal_Main.fn_filing_type > 0,'filing_type') 
FIELDTYPE:invalid_filing_desc:CUSTOM(Scrubs_LiensV2_CA_Federal_Main.fn_filing_type > 0,'filing_desc') 
FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -,.()):LENGTHS(0,3..)




FIELD:tmsid:0,0
FIELD:rmsid:0,0
FIELD:orig_rmsid:0,0
FIELD:process_date:LIKE(invalid_date):0,0
FIELD:record_code:LIKE(invalid_record_code):0,0
FIELD:date_vendor_removed:LIKE(invalid_date):0,0
FIELD:filing_jurisdiction:0,0
FIELD:filing_state:0,0
FIELD:orig_filing_number:0,0
FIELD:orig_filing_type:LIKE(invalid_filing_type):0,0
FIELD:orig_filing_date:LIKE(invalid_date):0,0
FIELD:orig_filing_time:LIKE(invalid_number):0,0
FIELD:case_number:0,0
FIELD:filing_number:0,0
FIELD:filing_type_desc:LIKE(invalid_filing_desc):0,0
FIELD:filing_date:LIKE(invalid_date):0,0
FIELD:filing_time:LIKE(invalid_number):0,0
FIELD:vendor_entry_date:LIKE(invalid_date):0,0
FIELD:judge:0,0
FIELD:case_title:0,0
FIELD:filing_book:0,0
FIELD:filing_page:0,0
FIELD:release_date:LIKE(invalid_date):0,0
FIELD:amount:0,0
FIELD:eviction:LIKE(invalid_eviction_ind):0,0
FIELD:satisifaction_type:0,0
FIELD:judg_satisfied_date:LIKE(invalid_date):0,0
FIELD:judg_vacated_date:LIKE(invalid_date):0,0
FIELD:tax_code:0,0
FIELD:irs_serial_number:0,0
FIELD:effective_date:LIKE(invalid_date):0,0
FIELD:lapse_date:LIKE(invalid_date):0,0
FIELD:accident_date:LIKE(invalid_date):0,0
FIELD:sherrif_indc:0,0
FIELD:expiration_date:LIKE(invalid_date):0,0
FIELD:agency:0,0
FIELD:agency_city:LIKE(invalid_alpha):0,0
FIELD:agency_state:LIKE(invalid_alpha):0,0
FIELD:agency_county:0,0
FIELD:legal_lot:0,0
FIELD:legal_block:0,0
FIELD:legal_borough:0,0
FIELD:certificate_number:0,0
FIELD:persistent_record_id:0,0
FIELD:source_file:0,0
//ATTRIBUTEFILE:FILING_STATUS:IDFIELD(tmsid):VALUES(filing_status.filing_status,LIST)

