MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:LIDBCurrent

FIELDTYPE:Invalid_RefID:ALLOW(MGP0123456789 )
FIELDTYPE:Invalid_Num:ALLOW(0123456789)

FIELD:reference_id:LIKE(Invalid_RefID):TYPE(STRING):0,0
FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0

