MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:ZZ
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

FIELDTYPE:invalid_segment_identifier:ENUM(ZZ|ZZ)
FIELDTYPE:invalid_zz_file_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_parent_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_total_ab_segments:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_total_segments:ALLOW(0123456789)
FIELDTYPE:invalid_sum_of_balance_amounts:ALLOW(-0123456789):LENGTHS(1..)

FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0
FIELD:file_sequence_number:LIKE(invalid_zz_file_sequence_number):TYPE(STRING12):0,0
FIELD:parent_sequence_number:LIKE(invalid_parent_sequence_number):TYPE(STRING12):0,0
FIELD:total_ab_segments:LIKE(invalid_total_ab_segments):TYPE(STRING9):0,0
FIELD:total_ma_segments:LIKE(invalid_total_segments):TYPE(STRING9):0,0
FIELD:total_ad_segments:LIKE(invalid_total_segments):TYPE(STRING9):0,0
FIELD:total_pn_segments:LIKE(invalid_total_segments):TYPE(STRING9):0,0
FIELD:total_ti_segments:LIKE(invalid_total_segments):TYPE(STRING9):0,0
FIELD:total_is_segments:LIKE(invalid_total_segments):TYPE(STRING9):0,0
FIELD:total_bs_segments:LIKE(invalid_total_segments):TYPE(STRING9):0,0
FIELD:total_bi_segments:LIKE(invalid_total_segments):TYPE(STRING9):0,0
FIELD:total_cl_segments:LIKE(invalid_total_segments):TYPE(STRING9):0,0
FIELD:total_ms_segments:LIKE(invalid_total_segments):TYPE(STRING9):0,0
FIELD:total_ah_segments:LIKE(invalid_total_segments):TYPE(STRING9):0,0
FIELD:sum_of_balance_amounts:LIKE(invalid_sum_of_balance_amounts):TYPE(STRING20):0,0

//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
