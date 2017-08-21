Generated by SALT V3.8.0
Command line options: -MScrubs_Infutor_NARC -eC:\Users\hardygta\AppData\Local\Temp\TFR52CC.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Infutor_NARC
FILENAME:Infutor_NARC
NAMESCOPE:Base
 
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
 
// SOURCEFIELD:src
 
FIELDTYPE:invalid_nums:ALLOW(0123456789):SPACES( )
FIELDTYPE:invalid_total_nbr:ALLOW(0123456789.):SPACES( )
FIELDTYPE:invalid_telephone:ALLOW(0123456789X):SPACES( )
FIELDTYPE:invalid_residence_len:ALLOW(0123456789.):SPACES( )
FIELDTYPE:invalid_gender:ENUM(M|F|)
FIELDTYPE:invalid_gender_code:ENUM(1|2|)
FIELDTYPE:invalid_alpha:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-)
FIELDTYPE:invalid_address:SPACES( ):ALLOW(',.#-&/:;-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_csz:SPACES( ):ALLOW( ,-'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_county_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'-):SPACES( ):WORDS(0,1,2,3,4,5):NOQUOTES(")
FIELDTYPE:invalid_zip:SPACES( ):ALLOW(0123456789):LENGTHS(0,5,9)
FIELDTYPE:invalid_zip4:SPACES( ):ALLOW(0123456789):LENGTHS(0,4)
FIELDTYPE:invalid_date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_suffix:ENUM(SR|JR|I|II|III|IV|V|VI|VII|VIII|IX|X|8TH|)
FIELDTYPE:invalid_indicator:ENUM(Y|N|)
FIELDTYPE:invalid_validation_flag:ENUM(C|N|)
FIELDTYPE:invalid_mhv:ENUM(A|B|C|D|E|F|G|H|I|)
FIELDTYPE:invalid_penetration_percentage_ranges:ENUM(A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|)
FIELDTYPE:invalid_child_num:ENUM(0|1|2|3|4|5|6|7|8|9|)
FIELDTYPE:invalid_dwelling_type:ENUM(A|B|C|D|)
FIELDTYPE:invalid_homeowner:ENUM(Y|)
FIELDTYPE:invalid_time_zone:ENUM(2|3|4|5|6|7|8|)
FIELDTYPE:invalid_assignment_lvl:ENUM(4|R|Z|)
FIELDTYPE:invalid_state_abbr:CUSTOM(Scrubs_Infutor_NARC.fn_valid_state_abbr > 0)
 
FIELD:orig_hhid:TYPE(STRING40):0,0
FIELD:orig_pid:TYPE(STRING20):0,0
FIELD:orig_fname:TYPE(STRING30):LIKE(invalid_alpha):0,0
FIELD:orig_mname:TYPE(STRING1):LIKE(invalid_alpha):0,0
FIELD:orig_lname:TYPE(STRING30):LIKE(invalid_alpha):0,0
FIELD:orig_suffix:TYPE(STRING10):LIKE(invalid_suffix):0,0
FIELD:orig_gender:TYPE(STRING1):LIKE(invalid_gender):0,0
FIELD:orig_age:TYPE(STRING2):LIKE(invalid_total_nbr):0,0
FIELD:orig_dob:TYPE(STRING6):LIKE(invalid_date):0,0
FIELD:orig_hhnbr:TYPE(STRING1):0,0
FIELD:orig_tot_males:TYPE(STRING1):LIKE(invalid_total_nbr):0,0
FIELD:orig_tot_females:TYPE(STRING1):LIKE(invalid_total_nbr):0,0
FIELD:orig_addrid:TYPE(STRING20):0,0
FIELD:orig_address:TYPE(STRING64):LIKE(invalid_address):0,0
FIELD:orig_house:TYPE(STRING10):LIKE(invalid_address):0,0
FIELD:orig_predir:TYPE(STRING2):LIKE(invalid_address):0,0
FIELD:orig_street:TYPE(STRING28):LIKE(invalid_address):0,0
FIELD:orig_strtype:TYPE(STRING4):LIKE(invalid_address):0,0
FIELD:orig_postdir:TYPE(STRING2):LIKE(invalid_address):0,0
FIELD:orig_apttype:TYPE(STRING4):LIKE(invalid_address):0,0
FIELD:orig_aptnbr:TYPE(STRING8):LIKE(invalid_address):0,0
FIELD:orig_city:TYPE(STRING28):LIKE(invalid_county_name):0,0
FIELD:orig_state:TYPE(STRING2):LIKE(invalid_state_abbr):0,0
FIELD:orig_zip:TYPE(STRING5):LIKE(invalid_zip):0,0
FIELD:orig_z4:TYPE(STRING4):LIKE(invalid_zip4):0,0
FIELD:orig_dpc:TYPE(STRING3):0,0
FIELD:orig_z4type:TYPE(STRING1):0,0
FIELD:orig_crte:TYPE(STRING4):0,0
FIELD:orig_dpv:TYPE(STRING1):0,0
FIELD:orig_vacant:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_msa:TYPE(STRING4):0,0
FIELD:orig_cbsa:TYPE(STRING5):0,0
FIELD:orig_county_code:TYPE(STRING3):0,0
FIELD:orig_time_zone:TYPE(STRING1):LIKE(invalid_time_zone):0,0
FIELD:orig_daylight_savings:TYPE(STRING1):0,0
FIELD:orig_lat_long_assignment_level:TYPE(STRING1):LIKE(invalid_assignment_lvl):0,0
FIELD:orig_latitude:TYPE(STRING11):0,0
FIELD:orig_longitude:TYPE(STRING11):0,0
FIELD:orig_telephonenumber_1:TYPE(STRING10):LIKE(invalid_telephone):0,0
FIELD:orig_validationflag_1:TYPE(STRING1):LIKE(invalid_validation_flag):0,0
FIELD:orig_validationdate_1:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:orig_dma_tps_dnc_flag_1:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_telephonenumber_2:TYPE(STRING10):LIKE(invalid_telephone):0,0
FIELD:orig_validation_flag_2:TYPE(STRING1):LIKE(invalid_validation_flag):0,0
FIELD:orig_validation_date_2:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:orig_dma_tps_dnc_flag_2:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_telephonenumber_3:TYPE(STRING10):LIKE(invalid_telephone):0,0
FIELD:orig_validationflag_3:TYPE(STRING1):LIKE(invalid_validation_flag):0,0
FIELD:orig_validationdate_3:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:orig_dma_tps_dnc_flag_3:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_telephonenumber_4:TYPE(STRING10):LIKE(invalid_telephone):0,0
FIELD:orig_validationflag_4:TYPE(STRING1):LIKE(invalid_validation_flag):0,0
FIELD:orig_validationdate_4:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:orig_dma_tps_dnc_flag_4:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_telephonenumber_5:TYPE(STRING10):LIKE(invalid_telephone):0,0
FIELD:orig_validationflag_5:TYPE(STRING1):LIKE(invalid_validation_flag):0,0
FIELD:orig_validationdate_5:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:orig_dma_tps_dnc_flag_5:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_telephonenumber_6:TYPE(STRING10):LIKE(invalid_telephone):0,0
FIELD:orig_validationflag_6:TYPE(STRING1):LIKE(invalid_validation_flag):0,0
FIELD:orig_validationdate_6:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:orig_dma_tps_dnc_flag_6:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_telephonenumber_7:TYPE(STRING10):LIKE(invalid_telephone):0,0
FIELD:orig_validationflag_7:TYPE(STRING1):LIKE(invalid_validation_flag):0,0
FIELD:orig_validationdate_7:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:orig_dma_tps_dnc_flag_7:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_tot_phones:TYPE(STRING1):LIKE(invalid_nums):0,0
FIELD:orig_length_of_residence:TYPE(STRING4):LIKE(invalid_residence_len):0,0
FIELD:orig_homeowner:TYPE(STRING1):LIKE(invalid_homeowner):0,0
FIELD:orig_estimatedincome:TYPE(STRING1):LIKE(invalid_mhv):0,0
FIELD:orig_dwelling_type:TYPE(STRING1):LIKE(invalid_dwelling_type):0,0
FIELD:orig_married:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_child:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_nbrchild:TYPE(STRING1):LIKE(invalid_child_num):0,0
FIELD:orig_teencd:TYPE(STRING1):LIKE(invalid_indicator):0,0
FIELD:orig_percent_range_black:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_percent_range_white:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_percent_range_hispanic:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_percent_range_asian:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_percent_range_english_speaking:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_percnt_range_spanish_speaking:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_percent_range_asian_speaking:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_percent_range_sfdu:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_percent_range_mfdu:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_mhv:TYPE(STRING1):LIKE(invalid_mhv):0,0
FIELD:orig_mor:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_car:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_medschl:TYPE(STRING4):LIKE(invalid_residence_len):0,0
FIELD:orig_penetration_range_whitecollar:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_penetration_range_bluecollar:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_penetration_range_otheroccupation:TYPE(STRING1):LIKE(invalid_penetration_percentage_ranges):0,0
FIELD:orig_demolevel:TYPE(STRING1):0,0
FIELD:orig_recdate:TYPE(STRING6):LIKE(invalid_date):0,0
FIELD:title:TYPE(STRING5):0,0
FIELD:fname:TYPE(STRING20):0,0
FIELD:mname:TYPE(STRING20):0,0
FIELD:lname:TYPE(STRING20):0,0
FIELD:name_suffix:TYPE(STRING5):LIKE(invalid_suffix):0,0
FIELD:prim_range:TYPE(STRING10):LIKE(invalid_address):0,0
FIELD:predir:TYPE(STRING2):LIKE(invalid_address):0,0
FIELD:prim_name:TYPE(STRING28):LIKE(invalid_address):0,0
FIELD:addr_suffix:TYPE(STRING4):LIKE(invalid_address):0,0
FIELD:postdir:TYPE(STRING2):LIKE(invalid_address):0,0
FIELD:unit_desig:TYPE(STRING10):LIKE(invalid_address):0,0
FIELD:sec_range:TYPE(STRING8):LIKE(invalid_address):0,0
FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_csz):0,0
FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_csz):0,0
FIELD:st:TYPE(STRING2):0,0
FIELD:zip:TYPE(STRING5):0,0
FIELD:zip4:TYPE(STRING4):0,0
FIELD:cart:TYPE(STRING4):0,0
FIELD:cr_sort_sz:TYPE(STRING1):0,0
FIELD:lot:TYPE(STRING4):0,0
FIELD:lot_order:TYPE(STRING1):0,0
FIELD:dbpc:TYPE(STRING2):0,0
FIELD:chk_digit:TYPE(STRING1):0,0
FIELD:rec_type:TYPE(STRING2):0,0
FIELD:fips_st:TYPE(STRING2):0,0
FIELD:fips_county:TYPE(STRING3):0,0
FIELD:geo_lat:TYPE(STRING10):0,0
FIELD:geo_long:TYPE(STRING11):0,0
FIELD:msa:TYPE(STRING4):0,0
FIELD:geo_blk:TYPE(STRING7):0,0
FIELD:geo_match:TYPE(STRING1):0,0
FIELD:err_stat:TYPE(STRING4):0,0bye
FIELD:did:TYPE(UNSIGNED6):0,0
FIELD:did_score:TYPE(UNSIGNED1):0,0
FIELD:clean_phone:TYPE(STRING10):LIKE(invalid_nums):0,0
FIELD:clean_dob:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:date_first_seen:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:date_last_seen:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:date_vendor_first_reported:TYPE(UNSIGNED6):LIKE(invalid_date):0,0
FIELD:date_vendor_last_reported:TYPE(UNSIGNED6):LIKE(invalid_date):0,0
FIELD:record_type:TYPE(STRING1):0,0
FIELD:src:TYPE(STRING2):0,0
FIELD:rawaid:TYPE(UNSIGNED8):0,0
FIELD:Lexhhid:TYPE(UNSIGNED6):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
 
 
Total available specificity:0
Search Threshold set at -4
Use of PERSISTs in code set at:3
 
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
 
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
 
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
 
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
 
