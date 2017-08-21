MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:DeactRaw

FIELDTYPE:Invalid_Action_Code:ENUM(DE|SW|SU|RE)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Num_Blank:ALLOW(0123456789 )
FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:)


FIELD:action_code:LIKE(Invalid_Action_Code):TYPE(STRING2):0,0
FIELD:timestamp:LIKE(Invalid_Num):TYPE(STRING14):0,0
FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:phone_swap:LIKE(Invalid_Num_Blank):TYPE(STRING10):0,0
FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0
