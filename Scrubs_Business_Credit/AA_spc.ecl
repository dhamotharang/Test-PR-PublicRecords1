MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:AA
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


FIELDTYPE:invalid_segment_identifier:ENUM(AA|AA)
FIELDTYPE:invalid_file_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_sbfe_contributor_num:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _):LENGTHS(1..):CUSTOM(scrubs_business_credit.fn_invalid_SBFEContributorNum>0)
FIELDTYPE:invalid_extracted_date:ALLOW(0123456789):LENGTHS(8):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_cycle_end_date:ALLOW(0123456789):LENGTHS(8,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_cycle_number:ALLOW(0123456789)
FIELDTYPE:invalid_cycle_length:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_file_correction_indicator:ENUM(001|002|003|004|)
FIELDTYPE:invalid_overall_file_format_version:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(1..)
FIELDTYPE:invalid_major_aa_segment_version:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_minor_aa_segment_version:ALLOW(0123456789):LENGTHS(1..)



FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0
FIELD:file_sequence_number:LIKE(invalid_file_sequence_number):TYPE(STRING12):0,0
FIELD:sbfe_contributor_number:LIKE(invalid_sbfe_contributor_num):TYPE(STRING30):0,0
FIELD:extracted_date:LIKE(invalid_extracted_date):TYPE(STRING8):0,0
FIELD:cycle_end_date:LIKE(invalid_cycle_end_date):TYPE(STRING8):0,0
FIELD:cycle_number:LIKE(invalid_cycle_number):TYPE(STRING2):0,0
FIELD:cycle_length:LIKE(invalid_cycle_length):TYPE(STRING3):0,0
FIELD:file_correction_indicator:LIKE(invalid_file_correction_indicator):TYPE(STRING3):0,0
FIELD:overall_file_format_version:LIKE(invalid_overall_file_format_version):TYPE(STRING4):0,0
FIELD:major_aa_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_aa_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_ab_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_ab_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_ma_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_ma_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_ad_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_ad_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_pn_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_pn_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_ti_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_ti_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_is_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_is_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_bs_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_bs_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_bi_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_bi_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_cl_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_cl_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_ms_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_ms_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_ah_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_ah_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0
FIELD:major_zz_segment_version:LIKE(invalid_major_aa_segment_version):TYPE(STRING2):0,0
FIELD:minor_zz_segment_version:LIKE(invalid_minor_aa_segment_version):TYPE(STRING2):0,0


//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

