
MODULE:Scrubs_VehicleV2
FILENAME:VehicleV2
NAMESCOPE:Infutor_Motorcycle
SOURCEFIELD:state_origin

FIELDTYPE:invalid_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -)
FIELDTYPE:invalid_number:ALLOW(0123456789)
FIELDTYPE:invalid_alphanumeric:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/):SPACES( -,.)
FIELDTYPE:invalid_vin:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789x-*'):SPACES( -@&)
FIELDTYPE:invalid_make:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ()/&.):SPACES( -)
FIELDTYPE:invalid_model:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()&/':.+*@`):SPACES( -)
FIELDTYPE:invalid_year:ALLOW(0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(8,0)
FIELDTYPE:invalid_name:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'&):SPACES( -.()"):LENGTHS(0..)
FIELDTYPE:invalid_address:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#'/-&):SPACES( .,;:):LENGTHS(0..)
FIELDTYPE:invalid_predir:ALLOW(ESWN):SPACES( .)
FIELDTYPE:invalid_state:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_fuel_type_code:ENUM(B|D|F|G|I|L|N|O|P|Y|):LENGTHS(1,0)
FIELDTYPE:invalid_gender:ENUM(F|M|):LENGTHS(1,0)
FIELDTYPE:invalid_append_ownernametypeind:ENUM(B|D|I|P|U|):LENGTHS(1,0)
//Fields
FIELD:iid:0,0
FIELD:pid:0,0
FIELD:vin:0,0
FIELD:make:LIKE(invalid_make):TYPE(STRING30):0,0
FIELD:model:LIKE(invalid_model):TYPE(STRING30):0,0
FIELD:year:LIKE(invalid_year):TYPE(STRING4):0,0
FIELD:class_code:0,0
FIELD:fuel_type_code:LIKE(invalid_fuel_type_code):TYPE(STRING1):0,0
FIELD:mfg_code:0,0
FIELD:style_code:LIKE(invalid_alphanumeric):TYPE(STRING10):0,0
FIELD:mileagecd:LIKE(invalid_alpha):TYPE(STRING1):0,0
FIELD:nbr_vehicles:LIKE(invalid_number):TYPE(STRING1):0,0
FIELD:idate:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:odate:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:fname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:mi:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:lname:LIKE(invalid_name):TYPE(STRING75):0,0
FIELD:suffix:LIKE(invalid_name):TYPE(STRING10):0,0
FIELD:gender:LIKE(invalid_gender):TYPE(STRING1):0,0
FIELD:house:LIKE(invalid_address):TYPE(STRING10):0,0
FIELD:predir:LIKE(invalid_predir):TYPE(STRING2):0,0
FIELD:street:LIKE(invalid_address):TYPE(STRING28):0,0
FIELD:strtype:LIKE(invalid_address):TYPE(STRING4):0,0
FIELD:postdir:LIKE(invalid_predir):TYPE(STRING2):0,0
FIELD:apttype:LIKE(invalid_address):TYPE(STRING4):0,0
FIELD:aptnbr:LIKE(invalid_address):TYPE(STRING8):0,0
FIELD:city:LIKE(invalid_address):TYPE(STRING28):0,0
FIELD:state:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:zip:LIKE(invalid_number):TYPE(STRING5):0,0
FIELD:z4:LIKE(invalid_number):TYPE(STRING4):0,0
FIELD:dpc:0,0
FIELD:crte:0,0
FIELD:cnty:0,0
FIELD:z4type:0,0
FIELD:dpv:0,0
FIELD:vacant:0,0
FIELD:phone:LIKE(invalid_number):TYPE(STRING4):00,0
FIELD:dnc:0,0
FIELD:internal1:LIKE(invalid_vin):TYPE(STRING16):0,0
FIELD:internal2:0,0
FIELD:internal3:0,0
FIELD:county:LIKE(invalid_address):TYPE(STRING30):0,0
FIELD:msa:0,0
FIELD:cbsa:0,0
FIELD:ehi:0,0
FIELD:child:0,0
FIELD:homeowner:0,0
FIELD:pctw:0,0
FIELD:pctb:0,0
FIELD:pcta:0,0
FIELD:pcth:0,0
FIELD:pctspe:0,0
FIELD:pctsps:0,0
FIELD:pctspa:0,0
FIELD:mhv:0,0
FIELD:mor:0,0
FIELD:pctoccw:0,0
FIELD:pctoccb:0,0
FIELD:pctocco:0,0
FIELD:lor:0,0
FIELD:sfdu:0,0
FIELD:mfdu:0,0
FIELD:processdate:0,0
FIELD:source_code:0,0
FIELD:state_origin:0,0
FIELD:append_ownernametypeind:0,0
FIELD:fullname:0,0
