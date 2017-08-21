MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:DeactMain

FIELDTYPE:Invalid_Action_Code:ENUM(DE|SW|SU|RE):Lengths(1..)
FIELDTYPE:Invalid_Deact_Code:ENUM(DE|SU| )
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Num_Blank:ALLOW(0123456789 )
FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:)
FIELDTYPE:Invalid_IS:ALLOW(YNP )


FIELD:vendor_first_reported_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:vendor_last_reported_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:action_code:LIKE(Invalid_Action_Code):TYPE(STRING2):0,0
FIELD:timestamp:LIKE(Invalid_Num):TYPE(STRING14):0,0
FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:phone_swap:LIKE(Invalid_Num_Blank):TYPE(STRING10):0,0
FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0
FIELD:carrier_name:TYPE(STRING60):0,0
FIELD:filedate:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:swap_start_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:swap_end_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:deact_code:LIKE(Invalid_Deact_Code):TYPE(STRING2):0,0
FIELD:deact_start_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:deact_end_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:react_start_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:react_end_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:is_react:LIKE(Invalid_IS):TYPE(STRING2):0,0
FIELD:is_deact:LIKE(Invalid_IS):TYPE(STRING2):0,0
FIELD:porting_dt:LIKE(Invalid_Num_Blank):TYPE(UNSIGNED8):0,0