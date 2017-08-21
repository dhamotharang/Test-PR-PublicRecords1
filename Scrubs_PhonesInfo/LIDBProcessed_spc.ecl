MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:LIDBProcessed

FIELDTYPE:Invalid_Num:ALLOW(0123456789 )
FIELDTYPE:Invalid_AccOwn:ALLOW(ABHGCDFE0123456789 )
FIELDTYPE:Invalid_RefID:ALLOW(MGP0123456789 )
FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \(\)&-.,/-#@'!*)
FIELDTYPE:Invalid_Binary:ALLOW(1 )
FIELDTYPE:Invalid_Num_In_Service:ENUM(1A|2A|3A|4A|7A|10A|12A|1I|2I|3I|4I|7I|10I|12I|U| )
FIELDTYPE:Invalid_Line_Serv:ALLOW(0123 )

FIELD:reference_id:LIKE(Invalid_RefID):TYPE(STRING):0,0
FIELD:dt_first_reported:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:dt_last_reported:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:reply_code:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:local_routing_number:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:account_owner:LIKE(Invalid_AccOwn):TYPE(STRING4):0,0
FIELD:carrier_name:LIKE(Invalid_Char):TYPE(STRING55):0,0
FIELD:carrier_category:LIKE(Invalid_Char):TYPE(STRING10):0,0
FIELD:local_area_transport_area:TYPE(STRING5):0,0
FIELD:point_code:TYPE(STRING9):0,0
FIELD:serv:LIKE(Invalid_Line_Serv):TYPE(STRING1):0,0
FIELD:line:LIKE(Invalid_Line_Serv):TYPE(STRING1):0,0
FIELD:spid:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:operator_fullname:LIKE(Invalid_Char):TYPE(STRING):0,0
FIELD:activation_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:number_in_service:LIKE(Invalid_Num_In_Service):TYPE(STRING5):0,0
FIELD:high_risk_indicator:LIKE(Invalid_Binary):TYPE(STRING2):0,0
FIELD:prepaid:LIKE(Invalid_Binary):TYPE(STRING2):0,0
