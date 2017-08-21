Generated by SALT V3.1.2
File being processed :-
MODULE:Scrubs_HMS_Csr
OPTIONS:-gh
FILENAME:HmsCsr
NAMESCOPE:HmsCsr
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
FIELDTYPE:ln_key:SPACES( ):ALLOW( -._0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:hms_src:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(1..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:key:SPACES( ):ALLOW( -._0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:id:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(1..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:entityid:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwyz):LEFTTRIM:LENGTHS(1..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:license_number:SPACES( ):ALLOW(-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:license_class_type:SPACES( ):ALLOW( (),-&_.'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:license_state:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:status:SPACES( ):ALLOW( :()*-.&_/01234568789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:issue_date:SPACES( ):ALLOW( -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:renewal_date:SPACES( ):ALLOW( -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:expiration_date:SPACES( ):ALLOW( -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:qualifier1:SPACES( ):ALLOW( ()*-._'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:qualifier2:SPACES( ):ALLOW( ()*-._'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:qualifier3:SPACES( ):ALLOW( ()*-._'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:qualifier4:SPACES( ):ALLOW( ()*-._'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:qualifier5:SPACES( ):ALLOW( ()*-._'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:rawclass:SPACES( ):ALLOW( (),-&_.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:rawissue_date:SPACES( ):ALLOW( "-/0123456789:=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:rawexpiration_date:SPACES( ):ALLOW( "-/0123456789:=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:rawstatus:SPACES( ):ALLOW( :()*-.&_/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:raw_number:SPACES( ):ALLOW("-.0123456789=ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:name:SPACES( ):ALLOW( ,-.'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:prefix:SPACES( ):ALLOW( .ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:first:SPACES( ):ALLOW( ,-.'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(1..):ONFAIL(CLEAN)
FIELDTYPE:middle:SPACES( ):ALLOW( ,-.'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(1..):ONFAIL(CLEAN)
FIELDTYPE:last:SPACES( ):ALLOW( ,-.'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(1..):ONFAIL(CLEAN)
FIELDTYPE:suffix:SPACES( ):ALLOW(()./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:cred:SPACES( ):ALLOW( ,-.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:age:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(0,1..3):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:dateofbirth:SPACES( ):ALLOW( -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:email:SPACES( ):ALLOW(*-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,3..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:gender:SPACES( ):ALLOW(FMU):LEFTTRIM:LENGTHS(0,1..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:dateofdeath:SPACES( ):ALLOW( -/0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:firmname:SPACES( ):ALLOW( #'&,-/.():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:street1:SPACES( ):ALLOW( #'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:street2:SPACES( ):ALLOW( #'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:street3:SPACES( ):ALLOW( #'&,-./():@0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:city:SPACES( ):ALLOW( #',-/.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZacdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:address_state:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:orig_zip:SPACES( ):ALLOW( -0123456789):LEFTTRIM:LENGTHS(0,5..10):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:orig_county:SPACES( ):ALLOW( -.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:country:SPACES( ):ALLOW( -.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:address_type:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:phone1:SPACES( ):ALLOW( ()*-0123456789):LEFTTRIM:LENGTHS(0,10..15):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:phone2:SPACES( ):ALLOW( ()*-0123456789):LEFTTRIM:LENGTHS(0,10..15):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:phone3:SPACES( ):ALLOW( ()*-0123456789):LEFTTRIM:LENGTHS(0,10..15):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:fax1:SPACES( ):ALLOW(()*-0123456789):LEFTTRIM:LENGTHS(0,10..15):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:fax2:SPACES( ):ALLOW(()*-0123456789):LEFTTRIM:LENGTHS(0,10..15):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:fax3:SPACES( ):ALLOW(()*-0123456789):LEFTTRIM:LENGTHS(0,10..15):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:other_phone1:SPACES( ):ALLOW( ()*-0123456789):LEFTTRIM:LENGTHS(0,10..15):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:description:SPACES( ):ALLOW( ()-.01345689ACDEFGHILMNOPRSTUVYabcdehilmnoprstuvy):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:specialty_class_type:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:phone_number:SPACES( ):ALLOW(()-0123456789):LEFTTRIM:LENGTHS(0,12):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:phone_type:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:language:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:degree:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:graduated:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:school:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:location:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:fine:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:board:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:offense:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:offense_date:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,4..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:action:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:action_date:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,4..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:action_start:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:action_end:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:npi_number:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:replacement_number:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:enumeration_date:SPACES( ):ALLOW(-/0123456789):LEFTTRIM:LENGTHS(0,4..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:last_update_date:SPACES( ):ALLOW(-/0123456789):LEFTTRIM:LENGTHS(0,4..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:deactivation_date:SPACES( ):ALLOW(-/0123456789):LEFTTRIM:LENGTHS(0,4..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:reactivation_date:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:deactivation_reason:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:csr_number:SPACES( ):ALLOW(-.0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:credential_type:SPACES( ):ALLOW( ()-./0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:csr_status:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:sub_status:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:csr_state:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:csr_issue_date:SPACES( ):ALLOW(-/0123456789):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:effective_date:SPACES( ):ALLOW(-/0123456789):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:csr_expiration_date:SPACES( ):ALLOW(-/0123456789):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:discipline:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:all_schedules:SPACES( ):ALLOW( &(),0123456789:ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:LENGTHS(0,1..):WORDS(0,1..):ONFAIL(CLEAN)
FIELDTYPE:dea_expiration_date:SPACES( ):ALLOW(-/0123456789):LEFTTRIM:LENGTHS(0,4..):WORDS(0,1..):ONFAIL(CLEAN)
FIELD:ln_key:TYPE(STRING100):0,0
FIELD:hms_src:TYPE(STRING25):0,0
FIELD:key:TYPE(STRING100):0,0
FIELD:id:TYPE(STRING25):0,0
FIELD:entityid:TYPE(STRING100):0,0
FIELD:license_number:TYPE(STRING15):0,0
FIELD:license_class_type:TYPE(STRING):0,0
FIELD:license_state:TYPE(STRING2):0,0
FIELD:status:TYPE(STRING):0,0
FIELD:issue_date:TYPE(STRING):0,0
FIELD:renewal_date:TYPE(STRING):0,0
FIELD:expiration_date:TYPE(STRING):0,0
FIELD:qualifier1:TYPE(STRING):0,0
FIELD:qualifier2:TYPE(STRING):0,0
FIELD:qualifier3:TYPE(STRING):0,0
FIELD:qualifier4:TYPE(STRING):0,0
FIELD:qualifier5:TYPE(STRING):0,0
FIELD:rawclass:TYPE(STRING):0,0
FIELD:rawissue_date:TYPE(STRING):0,0
FIELD:rawexpiration_date:TYPE(STRING):0,0
FIELD:rawstatus:TYPE(STRING):0,0
FIELD:raw_number:TYPE(STRING):0,0
FIELD:name:TYPE(STRING100):0,0
FIELD:prefix:TYPE(STRING):0,0
FIELD:first:TYPE(STRING50):0,0
FIELD:middle:TYPE(STRING10):0,0
FIELD:last:TYPE(STRING50):0,0
FIELD:suffix:TYPE(STRING10):0,0
FIELD:cred:TYPE(STRING10):0,0
FIELD:age:TYPE(UNSIGNED3):0,0
FIELD:dateofbirth:TYPE(STRING20):0,0
FIELD:email:TYPE(STRING50):0,0
FIELD:gender:TYPE(STRING1):0,0
FIELD:dateofdeath:TYPE(STRING20):0,0
FIELD:employer_identification_number:TYPE(STRING):0,0
FIELD:raw_full_address:TYPE(STRING):0,0
FIELD:firmname:TYPE(STRING50):0,0
FIELD:street1:TYPE(STRING50):0,0
FIELD:street2:TYPE(STRING25):0,0
FIELD:street3:TYPE(STRING25):0,0
FIELD:city:TYPE(STRING50):0,0
FIELD:address_state:TYPE(STRING2):0,0
FIELD:orig_zip:TYPE(STRING12):0,0
FIELD:orig_county:TYPE(STRING50):0,0
FIELD:country:TYPE(STRING50):0,0
FIELD:address_type:TYPE(STRING25):0,0
FIELD:phone1:TYPE(STRING20):0,0
FIELD:phone2:TYPE(STRING20):0,0
FIELD:phone3:TYPE(STRING20):0,0
FIELD:fax1:TYPE(STRING20):0,0
FIELD:fax2:TYPE(STRING20):0,0
FIELD:fax3:TYPE(STRING20):0,0
FIELD:other_phone1:TYPE(STRING20):0,0
FIELD:description:TYPE(STRING50):0,0
FIELD:specialty_class_type:TYPE(STRING25):0,0
FIELD:phone_number:TYPE(STRING15):0,0
FIELD:phone_type:TYPE(STRING25):0,0
FIELD:language:TYPE(STRING50):0,0
FIELD:degree:TYPE(STRING):0,0
FIELD:graduated:TYPE(STRING50):0,0
FIELD:school:TYPE(STRING50):0,0
FIELD:location:TYPE(STRING50):0,0
FIELD:fine:TYPE(STRING):0,0
FIELD:board:TYPE(STRING50):0,0
FIELD:offense:TYPE(STRING50):0,0
FIELD:offense_date:TYPE(STRING20):0,0
FIELD:action:TYPE(STRING50):0,0
FIELD:action_date:TYPE(STRING20):0,0
FIELD:action_start:TYPE(STRING20):0,0
FIELD:action_end:TYPE(STRING20):0,0
FIELD:npi_number:TYPE(STRING50):0,0
FIELD:replacement_number:TYPE(STRING):0,0
FIELD:enumeration_date:TYPE(STRING):0,0
FIELD:last_update_date:TYPE(STRING):0,0
FIELD:deactivation_date:TYPE(STRING):0,0
FIELD:reactivation_date:TYPE(STRING):0,0
FIELD:deactivation_reason:TYPE(STRING):0,0
FIELD:csr_number:TYPE(STRING50):0,0
FIELD:credential_type:TYPE(STRING):0,0
FIELD:csr_status:TYPE(STRING):0,0
FIELD:sub_status:TYPE(STRING):0,0
FIELD:csr_state:TYPE(STRING):0,0
FIELD:csr_issue_date:TYPE(STRING):0,0
FIELD:effective_date:TYPE(STRING):0,0
FIELD:csr_expiration_date:TYPE(STRING):0,0
FIELD:discipline:TYPE(STRING):0,0
FIELD:all_schedules:TYPE(STRING):0,0
FIELD:schedule_1:TYPE(STRING):0,0
FIELD:schedule_2:TYPE(STRING):0,0
FIELD:schedule_2n:TYPE(STRING):0,0
FIELD:schedule_3:TYPE(STRING):0,0
FIELD:schedule_3n:TYPE(STRING):0,0
FIELD:schedule_4:TYPE(STRING):0,0
FIELD:schedule_5:TYPE(STRING):0,0
FIELD:schedule_6:TYPE(STRING):0,0
FIELD:raw_status:TYPE(STRING):0,0
FIELD:raw_sub_status1:TYPE(STRING):0,0
FIELD:raw_sub_status2:TYPE(STRING):0,0
FIELD:dea_number:TYPE(STRING):0,0
FIELD:schedules:TYPE(STRING):0,0
FIELD:dea_expiration_date:TYPE(STRING):0,0
FIELD:activity:TYPE(STRING):0,0
FIELD:bac:TYPE(STRING):0,0
FIELD:bac_subcode:TYPE(STRING):0,0
FIELD:payment:TYPE(STRING):0,0
FIELD:medicaid_number:TYPE(STRING):0,0
FIELD:medicaid_status:TYPE(STRING):0,0
FIELD:medicaid_state:TYPE(STRING):0,0
FIELD:participation_flag:TYPE(STRING):0,0
FIELD:taxonomy_npi_number:TYPE(STRING):0,0
FIELD:taxonomy_code:TYPE(STRING):0,0
FIELD:taxonomy_order_number:TYPE(STRING):0,0
FIELD:license_number_state_code:TYPE(STRING):0,0
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
