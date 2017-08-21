MODULE:Scrubs_Watercraft_Coastguard
FILENAME:Watercraft_Coastguard
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

FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'):SPACES( \/-.,):LENGTHS(0..)
FIELDTYPE:invalid_alnum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -#.\/_):LENGTHS(0..)
FIELDTYPE:invalid_numeric:ALLOW(0123456789):SPACES(.):LENGTHS(0..)
FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_hullnum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -#.\/_*?):LENGTHS(0..)
FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(8,6,4,0)
FIELDTYPE:invalid_year:ALLOW(0123456789):LENGTHS(0..)
FIELDTYPE:invalid_source_code:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(2)
FIELDTYPE:invalid_blank:LENGTHS(1..)

FIELD:watercraft_key:TYPE(STRING30):LIKE(invalid_blank):0,0
FIELD:sequence_key:TYPE(STRING30):0,0
FIELD:state_origin:TYPE(STRING2):LIKE(invalid_state):0,0
FIELD:source_code:TYPE(STRING2):LIKE(invalid_source_code):0,0
FIELD:vessel_id:TYPE(STRING10):0,0
FIELD:vessel_database_key:TYPE(STRING10):0,0
FIELD:name_of_vessel:TYPE(STRING50):0,0
FIELD:call_sign:TYPE(STRING8):0,0
FIELD:official_number:TYPE(STRING10):0,0
FIELD:imo_number:TYPE(STRING30):0,0
FIELD:hull_number:TYPE(STRING30):LIKE(invalid_hullnum):0,0
FIELD:hull_identification_number:TYPE(STRING30):LIKE(invalid_hullnum):0,0
FIELD:vessel_service_type:TYPE(STRING30):0,0
FIELD:flag:TYPE(STRING2):0,0
FIELD:self_propelled_indicator:TYPE(STRING1):0,0
FIELD:registered_gross_tons:TYPE(STRING7):LIKE(invalid_numeric):0,0
FIELD:registered_net_tons:TYPE(STRING7):LIKE(invalid_numeric):0,0
FIELD:registered_length:TYPE(STRING7):LIKE(invalid_numeric):0,0
FIELD:registered_breadth:TYPE(STRING6):LIKE(invalid_numeric):0,0
FIELD:registered_depth:TYPE(STRING6):LIKE(invalid_numeric):0,0
FIELD:itc_gross_tons:TYPE(STRING7):LIKE(invalid_numeric):0,0
FIELD:itc_net_tons:TYPE(STRING7):LIKE(invalid_numeric):0,0
FIELD:itc_length:TYPE(STRING7):LIKE(invalid_numeric):0,0
FIELD:itc_breadth:TYPE(STRING6):LIKE(invalid_numeric):0,0
FIELD:itc_depth:TYPE(STRING6):LIKE(invalid_numeric):0,0
FIELD:hailing_port:TYPE(STRING50):0,0
FIELD:hailing_port_state:TYPE(STRING2):0,0
FIELD:hailing_port_province:TYPE(STRING50):0,0
FIELD:home_port_name:TYPE(STRING50):0,0
FIELD:home_port_state:TYPE(STRING2):0,0
FIELD:home_port_province:TYPE(STRING50):0,0
FIELD:trade_ind_coastwise_unrestricted:TYPE(STRING1):0,0
FIELD:trade_ind_limited_coastwise_bowaters_only:TYPE(STRING1):0,0
FIELD:trade_ind_limited_coastwise_restricted:TYPE(STRING1):0,0
FIELD:trade_ind_limited_coastwise_oil_spill_response_only:TYPE(STRING1):0,0
FIELD:trade_ind_limited_coastwise_under_charter_to_citizen:TYPE(STRING1):0,0
FIELD:trade_ind_fishery:TYPE(STRING1):0,0
FIELD:trade_ind_limited_fishery_only:TYPE(STRING1):0,0
FIELD:trade_ind_recreation:TYPE(STRING1):0,0
FIELD:trade_ind_limited_recreation_great_lakes_use_only:TYPE(STRING1):0,0
FIELD:trade_ind_registry:TYPE(STRING1):0,0
FIELD:trade_ind_limited_registry_cross_border_financing:TYPE(STRING1):0,0
FIELD:trade_ind_limited_registry_no_foreign_voyage:TYPE(STRING1):0,0
FIELD:trade_ind_limited_registry_trade_with_canada_only:TYPE(STRING1):0,0
FIELD:trade_ind_great_lakes:TYPE(STRING1):0,0
FIELD:vessel_complete_build_city:TYPE(STRING50):0,0
FIELD:vessel_complete_build_state:TYPE(STRING2):0,0
FIELD:vessel_complete_build_province:TYPE(STRING50):0,0
FIELD:vessel_complete_build_country:TYPE(STRING64):0,0
FIELD:vessel_build_year:TYPE(STRING4):0,0
FIELD:vessel_hull_build_city:TYPE(STRING50):0,0
FIELD:vessel_hull_build_state:TYPE(STRING2):0,0
FIELD:vessel_hull_build_province:TYPE(STRING50):0,0
FIELD:vessel_hull_build_country:TYPE(STRING64):0,0
FIELD:party_identification_number:TYPE(STRING10):0,0
FIELD:main_hp_ahead:TYPE(STRING7):0,0
FIELD:main_hp_astern:TYPE(STRING7):0,0
FIELD:propulsion_type:TYPE(STRING30):0,0
FIELD:hull_material:TYPE(STRING30):0,0
FIELD:ship_yard:TYPE(STRING50):0,0
FIELD:hull_builder_name:TYPE(STRING50):0,0
FIELD:doc_certificate_status:TYPE(STRING11):0,0
FIELD:date_issued:TYPE(STRING10):LIKE(invalid_date):0,0
FIELD:date_expires:TYPE(STRING10):LIKE(invalid_date):0,0
FIELD:hull_design_type:TYPE(STRING19):0,0
FIELD:sail_ind:TYPE(STRING1):0,0
FIELD:party_database_key:TYPE(STRING10):0,0
FIELD:itc_tons_cod_ind:TYPE(STRING1):0,0
FIELD:persistent_record_id:TYPE(UNSIGNED8):LIKE(invalid_blank):0,0

//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
