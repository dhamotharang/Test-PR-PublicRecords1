IMPORT SALT34;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := FALSE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT34.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
EXPORT MatchThreshold := 25;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT recording_date_Force := 0; 
EXPORT SourceType_Force := 0; 
EXPORT zip_Force := 0; 
EXPORT sales_price_Force := 0; 
EXPORT first_td_loan_amount_Force := 0; 
EXPORT contract_date_Force := 0; 
EXPORT document_number_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT recorder_page_number_Force := 5; 
EXPORT recorder_page_number_OR1_document_number_Force := 0;
EXPORT sec_range_alpha_Force := 0; 
EXPORT name_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT prim_name_num_Force := 0; 
EXPORT prim_name_alpha_Force := 0; 
EXPORT sec_range_num_Force := 0; 
EXPORT lender_name_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT prim_range_num_Force := 0; 
EXPORT city_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT address_Force := 0; 
// Configuration of external files
END;
