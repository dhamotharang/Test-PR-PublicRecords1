MODULE:Scrubs_Watercraft_Base
FILENAME:Watercraft_Base
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking

SOURCEFIELD:source_code

FIELDTYPE:invalid_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'):SPACES( -.,\/):LENGTHS(0..)
FIELDTYPE:invalid_alnum:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -#.&/_$):LENGTHS(0..)
FIELDTYPE:invalid_numeric:ALLOW(0123456789):SPACES(.):LENGTHS(0..)
FIELDTYPE:invalid_name:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -,&\/.:;_#()*%+!@`):LENGTHS(0..)
FIELDTYPE:invalid_address:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -&/\#().;,:%):LENGTHS(0..)
FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_zip:ALLOW(0123456789X):SPACES( -):LENGTHS(10,9,6,5,0)
FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(8,6,4,0)
FIELDTYPE:invalid_year:ALLOW(0123456789):LENGTHS(0..)
FIELDTYPE:invalid_hull_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( *#.?-/):LENGTHS(0..)
FIELDTYPE:invalid_source_code:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(2)
FIELDTYPE:invalid_history_flag:ENUM(H|E|U| ):LENGTHS(1,0)
FIELDTYPE:invalid_blank:LENGTHS(1..)

FIELD:watercraft_key:TYPE(STRING30):LIKE(invalid_blank):0,0
FIELD:sequence_key:TYPE(STRING30):0,0
FIELD:watercraft_id:TYPE(STRING10):0,0
FIELD:state_origin:TYPE(STRING2):LIKE(invalid_state):0,0
FIELD:source_code:TYPE(STRING2):LIKE(invalid_source_code):0,0
FIELD:st_registration:TYPE(STRING2):LIKE(invalid_state):0,0
FIELD:county_registration:TYPE(STRING15):LIKE(invalid_alnum):0,0
FIELD:registration_number:TYPE(STRING20):LIKE(invalid_alnum):0,0
FIELD:hull_number:TYPE(STRING30):LIKE(invalid_hull_number):0,0
FIELD:propulsion_description:TYPE(STRING20):0,0
FIELD:vehicle_type_code:TYPE(STRING2):0,0
FIELD:vehicle_type_description:TYPE(STRING20):0,0
FIELD:fuel_code:TYPE(STRING1):0,0
FIELD:fuel_description:TYPE(STRING20):0,0
FIELD:hull_type_code:TYPE(STRING5):0,0
FIELD:hull_type_description:TYPE(STRING20):0,0
FIELD:use_code:TYPE(STRING5):0,0
FIELD:use_description:TYPE(STRING20):0,0
FIELD:model_year:TYPE(STRING4):LIKE(invalid_year):0,0
FIELD:watercraft_name:TYPE(STRING40):0,0
FIELD:watercraft_class_code:TYPE(STRING5):0,0
FIELD:watercraft_class_description:TYPE(STRING35):0,0
FIELD:watercraft_make_code:TYPE(STRING5):0,0
FIELD:watercraft_make_description:TYPE(STRING30):0,0
FIELD:watercraft_model_code:TYPE(STRING5):0,0
FIELD:watercraft_model_description:TYPE(STRING30):0,0
FIELD:watercraft_length:TYPE(STRING5):LIKE(invalid_numeric):0,0
FIELD:watercraft_width:TYPE(STRING5):LIKE(invalid_numeric):0,0
FIELD:watercraft_weight:TYPE(STRING10):LIKE(invalid_numeric):0,0
FIELD:watercraft_color_1_code:TYPE(STRING3):0,0
FIELD:watercraft_color_1_description:TYPE(STRING20):0,0
FIELD:watercraft_color_2_code:TYPE(STRING3):0,0
FIELD:watercraft_color_2_description:TYPE(STRING20):0,0
FIELD:watercraft_toilet_code:TYPE(STRING2):0,0
FIELD:watercraft_toilet_description:TYPE(STRING40):0,0
FIELD:watercraft_number_of_engines:TYPE(STRING2):0,0
FIELD:watercraft_hp_1:TYPE(STRING5):0,0
FIELD:watercraft_hp_2:TYPE(STRING5):0,0
FIELD:watercraft_hp_3:TYPE(STRING5):0,0
FIELD:engine_number_1:TYPE(STRING20):0,0
FIELD:engine_number_2:TYPE(STRING20):0,0
FIELD:engine_number_3:TYPE(STRING20):0,0
FIELD:engine_make_1:TYPE(STRING20):0,0
FIELD:engine_make_2:TYPE(STRING20):0,0
FIELD:engine_make_3:TYPE(STRING20):0,0
FIELD:engine_model_1:TYPE(STRING20):0,0
FIELD:engine_model_2:TYPE(STRING20):0,0
FIELD:engine_model_3:TYPE(STRING20):0,0
FIELD:engine_year_1:TYPE(STRING4):0,0
FIELD:engine_year_2:TYPE(STRING4):0,0
FIELD:engine_year_3:TYPE(STRING4):0,0
FIELD:coast_guard_documented_flag:TYPE(STRING1):0,0
FIELD:coast_guard_number:TYPE(STRING30):0,0
FIELD:registration_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:registration_expiration_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:registration_status_code:TYPE(STRING5):0,0
FIELD:registration_status_description:TYPE(STRING40):0,0
FIELD:registration_status_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:registration_renewal_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:decal_number:TYPE(STRING20):LIKE(invalid_alnum):0,0
FIELD:transaction_type_code:TYPE(STRING5):0,0
FIELD:transaction_type_description:TYPE(STRING40):0,0
FIELD:title_state:TYPE(STRING2):LIKE(invalid_state):0,0
FIELD:title_status_code:TYPE(STRING5):0,0
FIELD:title_status_description:TYPE(STRING40):0,0
FIELD:title_number:TYPE(STRING20):0,0
FIELD:title_issue_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:title_type_code:TYPE(STRING5):0,0
FIELD:title_type_description:TYPE(STRING20):0,0
FIELD:additional_owner_count:TYPE(STRING1):0,0
FIELD:lien_1_indicator:TYPE(STRING1):0,0
FIELD:lien_1_name:TYPE(STRING40):LIKE(invalid_name):0,0
FIELD:lien_1_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:lien_1_address_1:TYPE(STRING60):LIKE(invalid_address):0,0
FIELD:lien_1_address_2:TYPE(STRING60):LIKE(invalid_name):0,0
FIELD:lien_1_city:TYPE(STRING25):LIKE(invalid_alpha):0,0
FIELD:lien_1_state:TYPE(STRING2):LIKE(invalid_state):0,0
FIELD:lien_1_zip:TYPE(STRING10):LIKE(invalid_zip):0,0
FIELD:lien_2_indicator:TYPE(STRING1):0,0
FIELD:lien_2_name:TYPE(STRING40):LIKE(invalid_name):0,0
FIELD:lien_2_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:lien_2_address_1:TYPE(STRING60):LIKE(invalid_address):0,0
FIELD:lien_2_address_2:TYPE(STRING60):LIKE(invalid_name):0,0
FIELD:lien_2_city:TYPE(STRING25):LIKE(invalid_alpha):0,0
FIELD:lien_2_state:TYPE(STRING2):LIKE(invalid_state):0,0
FIELD:lien_2_zip:TYPE(STRING10):LIKE(invalid_zip):0,0
FIELD:state_purchased:TYPE(STRING2):LIKE(invalid_state):0,0
FIELD:purchase_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:dealer:TYPE(STRING40):0,0
FIELD:purchase_price:TYPE(STRING10):0,0
FIELD:new_used_flag:TYPE(STRING1):0,0
FIELD:watercraft_status_code:TYPE(STRING5):0,0
FIELD:watercraft_status_description:TYPE(STRING20):0,0
FIELD:history_flag:TYPE(STRING1):LIKE(invalid_history_flag):0,0
FIELD:coastguard_flag:TYPE(STRING1):0,0
FIELD:signatory:TYPE(STRING4):0,0
FIELD:persistent_record_id:TYPE(UNSIGNED8):LIKE(invalid_blank):0,0

//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
