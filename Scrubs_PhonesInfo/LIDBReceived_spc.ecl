MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:LIDBReceived

FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \(\)&-.,/-#@')
FIELDTYPE:Invalid_AccOwn:ALLOW(ABHGCDFE0123456789 )
FIELDTYPE:Invalid_RefID:ALLOW(MGP0123456789 )

FIELD:reference_id:LIKE(Invalid_RefID):TYPE(STRING):0,0
FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:reply_code:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:local_routing_number:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:account_owner:LIKE(Invalid_AccOwn):TYPE(STRING4):0,0
FIELD:carrier_name:LIKE(Invalid_Char):TYPE(STRING55):0,0
FIELD:carrier_category:LIKE(Invalid_Char):TYPE(STRING10):0,0
FIELD:local_area_transport_area:TYPE(STRING5):0,0
FIELD:point_code:TYPE(STRING9):0,0
