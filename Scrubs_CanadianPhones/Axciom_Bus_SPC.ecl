MODULE:Scrubs_CanadianPhones
FILENAME:CanadianPhones
NAMESCOPE:Axciom_Bus

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

FIELDTYPE:invalid_record_id:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(10,0)
FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(6,0)
FIELDTYPE:invalid_area_code:ALLOW(0123456789):LENGTHS(3,0)
FIELDTYPE:invalid_phone:ALLOW(0123456789):LENGTHS(7,0)
FIELDTYPE:invalid_numeric:ALLOW(0123456789.-+,)
FIELDTYPE:invalid_alpha:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ‚ÃƒÃÃ…Ã„Ã‘ÃšÃœÃÃÃŽÃ”Ã–Ã“??Ã˜Ã‹ÃˆÃ‰Ã¢Ã£Ã¡Ã¥Ã¤Ã¯Ã¶Ã¸Ã©Ã¼??):SPACES( -'/.):LENGTHS(0..)
FIELDTYPE:invalid_alnum:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -/):LENGTHS(0..)
FIELDTYPE:invalid_address:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ‚ÃƒÃÃ…Ã„Ã‘ÃšÃœÃÃÃŽÃ”Ã–Ã“Ã¸Ã˜Ã‹ÃˆÃ‰Ã¤Ã¯Ã¶Ã©Ã¼?0123456789'@+~$|):SPACES( ()-&/\#.;,\:"=*):LENGTHS(0..)
FIELDTYPE:invalid_city:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-/'().,?&):SPACES( ;\:):LENGTHS(0..)
FIELDTYPE:invalid_name:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©0123456789'"+=@#$%^&+-_\:*!?):SPACES( ,.(){}/\;):LENGTHS(0..)
FIELDTYPE:invalid_canadian_zip:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- ):LENGTHS(0,3..)
FIELDTYPE:invalid_province:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_lat_long_level_applied:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(2,0)
FIELDTYPE:invalid_record_use_indicator:ENUM(B|C|M|T|):LENGTHS(1,0)
FIELDTYPE:invalid_bus_govt_indicator:ENUM(1|5|6|A|B|C|D|E|F|G|H|I|):LENGTHS(1,0)
FIELDTYPE:invalid_email:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@\:.-_):SPACES( ,&!?/;|')
FIELDTYPE:invalid_verification_flag:ENUM(0|1|2|3|):LENGTHS(1,0)

FIELD:record_id:LIKE(invalid_record_id):TYPE(STRING):0,0
FIELD:book_number:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:pub_date:LIKE(invalid_date):TYPE(STRING):0,0
FIELD:business_name:LIKE(invalid_name):TYPE(STRING):0,0
FIELD:street_number:TYPE(STRING):0,0
FIELD:street_name:LIKE(invalid_address):TYPE(STRING):0,0
FIELD:unit_designator:LIKE(invalid_address):TYPE(STRING):0,0
FIELD:unit_number:LIKE(invalid_address):TYPE(STRING):0,0
FIELD:city:LIKE(invalid_city):TYPE(STRING):0,0
FIELD:province:LIKE(invalid_province):TYPE(STRING):0,0
FIELD:postal_code:LIKE(invalid_canadian_zip):TYPE(STRING):0,0
FIELD:area_code:LIKE(invalid_area_code):TYPE(STRING):0,0
FIELD:phone_number:LIKE(invalid_phone):TYPE(STRING):0,0
FIELD:syph_1:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:syph_2:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:syph_3:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:syph_4:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:syph_5:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:syph_6:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:naics_1:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:naics_2:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:naics_3:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:naics_4:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:naics_5:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:naics_6:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:bdc_1:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:bdc_2:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:bdc_3:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:bdc_4:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:bdc_5:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:bdc_6:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:sic_1:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:sic_2:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:sic_3:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:sic_4:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:sic_5:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:sic_6:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:caption_counter:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:caption_1:TYPE(STRING):0,0
FIELD:caption_2:TYPE(STRING):0,0
FIELD:caption_3:TYPE(STRING):0,0
FIELD:caption_4:TYPE(STRING):0,0
FIELD:caption_5:TYPE(STRING):0,0
FIELD:caption_6:TYPE(STRING):0,0
FIELD:vanity_city:LIKE(invalid_city):TYPE(STRING):0,0
FIELD:bus_govt_indicator:LIKE(invalid_bus_govt_indicator):TYPE(STRING):0,0
FIELD:latitude:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:longitude:LIKE(invalid_numeric):TYPE(STRING):0,0
FIELD:lat_long_level_applied:LIKE(invalid_lat_long_level_applied):TYPE(STRING):0,0
FIELD:record_use_indicator:LIKE(invalid_record_use_indicator):TYPE(STRING):0,0
FIELD:email:LIKE(invalid_email):TYPE(STRING):0,0
FIELD:stated_addr:LIKE(invalid_address):TYPE(STRING):0,0
FIELD:stated_city:LIKE(invalid_city):TYPE(STRING):0,0
FIELD:stated_postal_code:LIKE(invalid_canadian_zip):TYPE(STRING):0,0
FIELD:stated_bus_name:LIKE(invalid_name):TYPE(STRING):0,0
FIELD:verification_flag:LIKE(invalid_verification_flag):TYPE(STRING):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking



