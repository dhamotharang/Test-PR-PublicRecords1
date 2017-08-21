MODULE:Scrubs_Experian_Phones
FILENAME:Experian_Phones
NAMESCOPE:input

FIELDTYPE:Invalid_Pin:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:Invalid_Num:ALLOW(0123456789 )
FIELDTYPE:Invalid_Type:ENUM(C|N| )
FIELDTYPE:Invalid_Source:ENUM(S|P| )


FIELD:encrypted_experian_pin:LIKE(Invalid_Pin):TYPE(STRING15):0,0
FIELD:phone_1_digits:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:phone_1_type:LIKE(Invalid_Type):TYPE(STRING1):0,0
FIELD:phone_1_source:LIKE(Invalid_Source):TYPE(STRING1):0,0
FIELD:phone_1_last_updt:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:phone_2_digits:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:phone_2_type:LIKE(Invalid_Type):TYPE(STRING1):0,0
FIELD:phone_2_source:LIKE(Invalid_Source):TYPE(STRING1):0,0
FIELD:phone_2_last_updt:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:phone_3_digits:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:phone_3_type:LIKE(Invalid_Type):TYPE(STRING1):0,0
FIELD:phone_3_source:LIKE(Invalid_Source):TYPE(STRING1):0,0
FIELD:phone_3_last_updt:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:filler:TYPE(STRING25):0,0
FIELD:crlf:TYPE(STRING3):0,0