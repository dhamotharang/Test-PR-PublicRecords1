OPTIONS:-gh
MODULE:Scrubs_Phonesinfo
FILENAME:Phonesinfo
NAMESCOPE:DeactGHMain

FIELDTYPE:Invalid_Num:ALLOW(-0123456789 ) 
FIELDTYPE:Invalid_DeactCode:ENUM(DE|) 
FIELDTYPE:Invalid_YN:ENUM(Y|N|P)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0,'future')


FIELD:groupid:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:vendor_first_reported_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:vendor_last_reported_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:action_code:TYPE(STRING2):0,0
FIELD:timestamp:LIKE(Invalid_Num):TYPE(STRING14):0,0
FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:phone_swap:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:filename:TYPE(STRING255):0,0
FIELD:carrier_name:TYPE(STRING60):0,0
FIELD:filedate:LIKE(Invalid_Date):TYPE(STRING):0,0
FIELD:swap_start_dt:TYPE(UNSIGNED8):0,0
FIELD:swap_end_dt:TYPE(UNSIGNED8):0,0
FIELD:deact_code:LIKE(Invalid_DeactCode):TYPE(STRING2):0,0
FIELD:deact_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:deact_end_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:react_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:react_end_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:is_react:LIKE(Invalid_YN):TYPE(STRING2):0,0
FIELD:is_deact:LIKE(Invalid_YN):TYPE(STRING2):0,0
FIELD:porting_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:pk_carrier_name:TYPE(STRING):0,0
FIELD:days_apart:LIKE(Invalid_Num):TYPE(INTEGER8):0,0
