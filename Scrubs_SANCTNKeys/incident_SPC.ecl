MODULE:Scrubs_SANCTNKeys
FILENAME:SANCTNKeys
NAMESCOPE:incident

FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_):LENGTHS(1..)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Date:ALLOW(0123456789/)
FIELDTYPE:Invalid_CleanDate:CUSTOM(Scrubs.fn_valid_date>0)

FIELD:batch_number:LIKE(Invalid_Batch):TYPE(STRING8):0,0
FIELD:incident_number:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:party_number:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:record_type:TYPE(STRING1):0,0
FIELD:order_number:LIKE(Invalid_Num):TYPE(STRING4):0,0
FIELD:ag_code:TYPE(STRING8):0,0
FIELD:case_number:TYPE(STRING20):0,0
FIELD:incident_date:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:jurisdiction:TYPE(STRING90):0,0
FIELD:source_document:TYPE(STRING70):0,0
FIELD:additional_info:TYPE(STRING70):0,0
FIELD:agency:TYPE(STRING70):0,0
FIELD:alleged_amount:TYPE(STRING10):0,0
FIELD:estimated_loss:TYPE(STRING10):0,0
FIELD:fcr_date:LIKE(Invalid_Date):TYPE(STRING10):0,0
FIELD:ok_for_fcr:TYPE(STRING1):0,0
FIELD:modified_date:LIKE(Invalid_Date):TYPE(STRING10):0,0
FIELD:load_date:LIKE(Invalid_Date):TYPE(STRING10):0,0
FIELD:incident_text:TYPE(STRING255):0,0
FIELD:incident_date_clean:LIKE(Invalid_CleanDate):TYPE(STRING8):0,0
FIELD:fcr_date_clean:LIKE(Invalid_CleanDate):TYPE(STRING8):0,0
FIELD:cln_modified_date:LIKE(Invalid_CleanDate):TYPE(STRING8):0,0
FIELD:cln_load_date:LIKE(Invalid_CleanDate):TYPE(STRING8):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
