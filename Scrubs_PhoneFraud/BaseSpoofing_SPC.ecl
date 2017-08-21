MODULE:Scrubs_PhoneFraud
FILENAME:PhoneFraud
NAMESCOPE:BaseSpoofing

FIELDTYPE:Invalid_Num:ALLOW(0123456789 )
FIELDTYPE:Invalid_Phone_Origin:ALLOW(DSC):LENGTHS(1):ONFAIL(REJECT)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_Phone:ALLOW(0123456789):LENGTHS(10):ONFAIL(REJECT)
FIELDTYPE:Invalid_ID:ALLOW(0123456789 ):LENGTHS(1..)

FIELD:date_file_loaded:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:phone:LIKE(Invalid_Phone):TYPE(STRING10):0,0
FIELD:phone_origin:LIKE(Invalid_Phone_Origin):TYPE(STRING1):0,0
FIELD:id:LIKE(Invalid_ID):TYPE(INTEGER4):0,0
FIELD:reference_id:TYPE(STRING45):0,0
FIELD:mode_type:TYPE(STRING20):0,0
FIELD:account_name:TYPE(STRING50):0,0
FIELD:event_date:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:event_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:ip_address:TYPE(STRING20):0,0
FIELD:neustar_lower_bound:TYPE(STRING15):0,0
FIELD:neustar_upper_bound:TYPE(STRING15):0,0
FIELD:vendor:TYPE(STRING30):0,0
FIELD:date_added:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:time_added:LIKE(Invalid_Num):TYPE(STRING6):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
