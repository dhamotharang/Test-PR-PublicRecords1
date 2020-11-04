OPTIONS:-gh
MODULE:Scrubs_eCrash_MBSAgency
FILENAME:eCrash_MBSAgency

FIELDTYPE:invalid_agency_id:ALLOW(0123456789):LENGTHS(7)
FIELDTYPE:invalid_source_id:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ \N):LENGTHS(0,1,2,3)
FIELDTYPE:invalid_agency_state_abbr:CUSTOM(Scrubs.fn_Valid_StateAbbrev>0)
FIELDTYPE:invalid_agency_ori:ALLOW(0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ \N)
FIELDTYPE:invalid_allow_open_search:ALLOW(01):LENGTHS(1)
FIELDTYPE:invalid_append_overwrite_flag:ENUM(AP|OW):LENGTHS(2)
FIELDTYPE:invalid_drivers_exchange_flag:ALLOW(01):LENGTHS(1)

FIELD:agency_id:LIKE(invalid_agency_id):TYPE(STRING):0,0
FIELD:agency_name:TYPE(STRING):0,0
FIELD:source_id:LIKE(invalid_source_id):TYPE(STRING):0,0
FIELD:agency_state_abbr:LIKE(invalid_agency_state_abbr):TYPE(STRING):0,0
FIELD:agency_ori:LIKE(invalid_agency_ori):TYPE(STRING):0,0
FIELD:allow_open_search:LIKE(invalid_allow_open_search):TYPE(STRING):0,0
FIELD:append_overwrite_flag:LIKE(invalid_append_overwrite_flag):TYPE(STRING):0,0
FIELD:drivers_exchange_flag:LIKE(invalid_drivers_exchange_flag):TYPE(STRING):0,0