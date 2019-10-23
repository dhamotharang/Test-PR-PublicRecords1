MODULE:Scrubs_VehicleV2
FILENAME:VehicleV2
NAMESCOPE:OH_Direct
SOURCEFIELD:source_code

FIELDTYPE:invalid_only_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -,.)
FIELDTYPE:invalid_weight:ALLOW(0123456789):LENGTHS(6,0)
FIELDTYPE:invalid_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~@&'"`$*-_?):SPACES( <>{}[]^=!+,.;:/#()\|)
FIELDTYPE:invalid_alphanumeric:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( -,.)
FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(8,0)
FIELDTYPE:invalid_year:ALLOW(0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_categorycode:ENUM(BU|PC|NC|NT|MC|TK|HV|TL|MH|FM|RV||MP|UN|CB|TB|):LENGTHS(2,0)
FIELDTYPE:invalid_vin:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_titlenum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_ownercode:ENUM(S|Y|L):LENGTHS(1)
FIELDTYPE:invalid_state:ENUM(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|IA|ID|IH|IL|IN|KS|KY|LA|MA|MD|ME|MI|MN|MO|MS|MT|NC|ND|NE|NJ|NM|NV|NY|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WI|WV|WY|):LENGTHS(2,0)
FIELDTYPE:invalid_zip:ALLOW(0123456789 ):LENGTHS(5,9)
FIELDTYPE:invalid_countycode:ALLOW(0123456789):LENGTHS(2,0)
FIELDTYPE:invalid_vehicletaxcode:ENUM(0|2|D|):LENGTHS(1,0)
FIELDTYPE:invalid_vehiclemake:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )
FIELDTYPE:invalid_source_code:ENUM(DI|):LENGTHS(2,0)
FIELDTYPE:invalid_append_ownernametypeind:ENUM(B|D|I|P|U|):LENGTHS(1,0)
//Fields
FIELD:categorycode:LIKE(invalid_categorycode):TYPE(STRING2):0,0
FIELD:vin:LIKE(invalid_vin):TYPE(STRING20):0,0
FIELD:modelyr:LIKE(invalid_year):TYPE(STRING4):0,0
FIELD:titlenum:LIKE(invalid_titlenum):TYPE(STRING20):0,0
FIELD:ownercode:LIKE(invalid_ownercode):TYPE(STRING1):0,0
FIELD:grossweight:LIKE(invalid_weight):TYPE(STRING6):0,0
FIELD:ownername:LIKE(invalid_alpha):TYPE(STRING35):0,0
FIELD:ownerstreetaddress:LIKE(invalid_alpha):TYPE(STRING30):0,0
FIELD:ownercity:LIKE(invalid_only_alpha):TYPE(STRING15):0,0
FIELD:ownerstate:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:ownerzip:LIKE(invalid_zip):TYPE(STRING9):0,0
FIELD:countynumber:LIKE(invalid_countycode):TYPE(STRING2):0,0
FIELD:vehiclepurchasedt:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:vehicletaxweight:LIKE(invalid_weight):TYPE(STRING6):0,0
FIELD:vehicletaxcode:LIKE(invalid_vehicletaxcode):TYPE(STRING1):0,0
FIELD:vehicleunladdenweight:LIKE(invalid_weight):TYPE(STRING6):0,0
FIELD:additionalownername:LIKE(invalid_alpha):TYPE(STRING35):0,0
FIELD:registrationissuedt:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:vehiclemake:LIKE(invalid_vehiclemake):TYPE(STRING4):0,0
FIELD:vehicletype:LIKE(invalid_alphanumeric):TYPE(STRING2):0,0
FIELD:vehicleexpdt:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:previousplatenum:LIKE(invalid_alphanumeric):TYPE(STRING8):0,0
FIELD:platenum:LIKE(invalid_alphanumeric):TYPE(STRING8):0,0
FIELD:processdate:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:source_code:LIKE(invalid_source_code):TYPE(STRING2):0,0
FIELD:state_origin:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:append_ownernametypeind:LIKE(invalid_append_ownernametypeind):TYPE(STRING1):0,0
FIELD:append_addlownernametypeind:LIKE(invalid_append_ownernametypeind):TYPE(STRING1):0,0
