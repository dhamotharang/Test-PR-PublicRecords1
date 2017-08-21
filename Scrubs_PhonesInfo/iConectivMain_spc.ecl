MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:iConectivMain

FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Num_Blank:ALLOW(0123456789 )
FIELDTYPE:Invalid_DCT:ALLOW(ECTBN)
FIELDTYPE:Invalid_TOS:ALLOW(MGOU)
FIELDTYPE:Invalid_Port_Date:ALLOW(0123456789 /:-)
FIELDTYPE:Invalid_ISO2:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:)

FIELD:country_code:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:phone:LIKE(Invalid_Num):TYPE(STRING12):0,0
FIELD:dial_type:LIKE(Invalid_DCT):TYPE(STRING1):0,0
FIELD:spid:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:service_provider:TYPE(STRING):0,0
FIELD:service_type:LIKE(Invalid_TOS):TYPE(STRING1):0,0
FIELD:routing_code:LIKE(Invalid_Num_Blank):TYPE(STRING10):0,0
FIELD:porting_dt:LIKE(Invalid_Port_Date):TYPE(STRING):0,0
FIELD:country_abbr:LIKE(Invalid_ISO2):TYPE(STRING2):0,0
FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0
FIELD:file_dt_time:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:vendor_first_reported_dt:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:vendor_last_reported_dt:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:port_start_dt:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:port_end_dt:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:remove_port_dt:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:is_ported:TYPE(BOOLEAN1):0,0

