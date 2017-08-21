MODULE:Scrubs_Experian_Phones
FILENAME:Experian_Phones
NAMESCOPE:base

FIELDTYPE:Invalid_Num:ALLOW(0123456789 )
FIELDTYPE:Invalid_Pin:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:Invalid_Type:ENUM(C|N| )
FIELDTYPE:Invalid_Source:ENUM(S|P| )
FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqurstuvwxyz0123456789'- )
FIELDTYPE:Invalid_Date:Custom(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_RecType:ENUM(C1|C2|O1|O2|O3|SP| )

FIELD:score:LIKE(Invalid_Num):TYPE(UNSIGNED2):0,0
FIELD:encrypted_experian_pin:LIKE(Invalid_Pin):TYPE(STRING15):0,0
FIELD:phone_pos:LIKE(Invalid_Num):TYPE(UNSIGNED1):0,0
FIELD:phone_digits:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:phone_type:LIKE(Invalid_Type):TYPE(STRING1):0,0
FIELD:phone_source:LIKE(Invalid_Source):TYPE(STRING1):0,0
FIELD:phone_last_updt:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:did:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:did_score:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:pin_did:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:pin_title:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:pin_fname:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:pin_mname:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:pin_lname:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:pin_name_suffix:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:date_first_seen:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:date_last_seen:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:date_vendor_first_reported:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:date_vendor_last_reported:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:rec_type:LIKE(Invalid_RecType):TYPE(STRING2):0,0
FIELD:is_current:TYPE(BOOLEAN1):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
