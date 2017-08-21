MODULE:scrubs_sexoffender_offense
FILENAME:sexoffender_offense
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9, 2 = 99 6.044841e+258tc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking
SOURCEFIELD:orig_state_code
FIELDTYPE:invalid_date:ALLOW(0123456789)
FIELDTYPE:invalid_age:ALLOW(0123456789)
FIELD:orig_state:TYPE(STRING30):0,0
FIELD:orig_state_code:TYPE(STRING2):0,0
FIELD:vendor_code:TYPE(STRING2):0,0
FIELD:source_file:TYPE(STRING20):0,0
FIELD:seisint_primary_key:TYPE(STRING60):0,0
FIELD:conviction_jurisdiction:TYPE(STRING80):0,0
FIELD:conviction_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:court:TYPE(STRING30):0,0
FIELD:court_case_number:TYPE(STRING25):0,0
FIELD:offense_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:offense_code_or_statute:TYPE(STRING20):0,0
FIELD:offense_description:TYPE(STRING320):0,0
FIELD:offense_description_2:TYPE(STRING180):0,0
FIELD:offense_category:TYPE(STRING30):0,0
FIELD:victim_minor:TYPE(STRING1):0,0
FIELD:victim_age:TYPE(STRING3):LIKE(invalid_age):0,0
FIELD:victim_gender:TYPE(STRING10):0,0
FIELD:victim_relationship:TYPE(STRING30):0,0
FIELD:sentence_description:TYPE(STRING180):0,0
FIELD:sentence_description_2:TYPE(STRING180):0,0
FIELD:arrest_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:arrest_warrant:TYPE(STRING250):0,0
FIELD:fcra_conviction_flag:TYPE(STRING1):0,0
FIELD:fcra_traffic_flag:TYPE(STRING1):0,0
FIELD:fcra_date:TYPE(STRING8):0,0
FIELD:fcra_date_type:TYPE(STRING1):0,0
FIELD:conviction_override_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:conviction_override_date_type:TYPE(STRING1):0,0
FIELD:offense_score:TYPE(STRING2):0,0
FIELD:offense_persistent_id:TYPE(UNSIGNED8):0,0
