MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:Daily_Raw_Wireline_to_Wireless

FIELDTYPE:Invalid_Phone:ALLOW(0123456789)
FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-:)

FIELD:phone:LIKE(Invalid_Phone):TYPE(STRING10):0,0
FIELD:lf:TYPE(STRING1):0,0
FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0
