﻿Generated by SALT V3.11.4
Command line options: -MScrubs_Inquiry_History -eC:\Users\incafe01\AppData\Local\Temp\TFRE87F.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Inquiry_History
FILENAME:File
 
FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("')
FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):
FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,'.):
FIELDTYPE:NUMBER:ALLOW(0123456789):
FIELDTYPE:ALPHANUM:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):
FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$;):SPACES( ):ONFAIL(CLEAN):
 
FIELDTYPE:lex_id:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(12,10,9,11,8,7):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:product_id:SPACES( ):ALLOW(12):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:inquiry_date:SPACES( ):ALLOW( -0123456789:):LEFTTRIM:LENGTHS(19):WORDS(2):ONFAIL(CLEAN)
FIELDTYPE:transaction_id:SPACES( ):ALLOW(0123456789R):LEFTTRIM:LENGTHS(16,15):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:date_added:SPACES( ):ALLOW( -0123456789:):LEFTTRIM:LENGTHS(19):WORDS(2):ONFAIL(CLEAN)
 
FIELDTYPE:customer_number:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:customer_account:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:ssn:SPACES( ):LEFTTRIM:LENGTHS(9,4,2):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:drivers_license_number:SPACES( ):LEFTTRIM:LENGTHS(2,8,9,13,10,7,12,15,14,11,17,6):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:drivers_license_state:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:name_first:SPACES( ):LEFTTRIM:LENGTHS(6,7,5,4,8,9,3,11,10,2,1,12,13,15,14):WORDS(1,2):ONFAIL(CLEAN)
FIELDTYPE:name_last:SPACES( ):LEFTTRIM:LENGTHS(6,5,7,8,4,9,10,3,11,12,2,13,14,15,16,17,1,18):WORDS(1,2,3):ONFAIL(CLEAN)
FIELDTYPE:name_middle:SPACES( ):LEFTTRIM:LENGTHS(2,1,6,7,5,4,8,9,3):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:name_suffix:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:addr_street:SPACES( ):LEFTTRIM:LENGTHS(0,15,16,17,14,18,13,19,20,12,21,22,23,11,24,25,10,26,27,9,28,8,6,7,4,29,5,30,31,3,32,33,34,35,36,38,37,2,39,1,40,41,43):WORDS(3,4,0,5,1,6,2,7,8):ONFAIL(CLEAN)
FIELDTYPE:addr_city:SPACES( ):LEFTTRIM:LENGTHS(2,7,9,8,6,10,11,12,5,13,14,4,15,16,17,18,3,19):WORDS(1,2,3):ONFAIL(CLEAN)
FIELDTYPE:addr_state:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:addr_zip5:SPACES( ):LEFTTRIM:LENGTHS(5,2,4):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:addr_zip4:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:dob:SPACES( ):LEFTTRIM:LENGTHS(10,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:transaction_location:SPACES( ):LEFTTRIM:LENGTHS(13,8):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:ppc:SPACES( ):LEFTTRIM:LENGTHS(3,1,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:internal_identifier:SPACES( ):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:eu1_customer_number:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:eu1_customer_account:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:eu2_customer_number:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:eu2_customer_account:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:email_addr:SPACES( ):LEFTTRIM:LENGTHS(2,20,19,18):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:ip_address:SPACES( ):LEFTTRIM:LENGTHS(2,13,14,12,39,38):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:state_id_number:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:state_id_state:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:eu_company_name:SPACES( ):LEFTTRIM:LENGTHS(2,13,6,10,27,15,7,3,9,11,19,23,17,26,22,37,24,29,16,8,38,12,5,28,32,21,34,41,30,20,45,40,31,14,36,25,35,18,33):WORDS(1,2,4,3,5,6,8,7):ONFAIL(CLEAN)
FIELDTYPE:eu_addr_street:SPACES( ):LEFTTRIM:LENGTHS(2,20,17,13,19,16,29,22,30,14,21,18,28,24,5,10,15,26,11,23,25,12,0,9,27,36):WORDS(1,4,3,5,6,2,0):ONFAIL(CLEAN)
FIELDTYPE:eu_addr_city:SPACES( ):LEFTTRIM:LENGTHS(2,7,9,10,8,12,6,13,11,15,5,14,4):WORDS(1,2,3):ONFAIL(CLEAN)
FIELDTYPE:eu_addr_state:SPACES( ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:eu_addr_zip5:SPACES( ):LEFTTRIM:LENGTHS(2,5):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:eu_phone_nbr:SPACES( ):LEFTTRIM:LENGTHS(2,10):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:product_code:SPACES( ):LEFTTRIM:LENGTHS(3):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:transaction_type:SPACES( ):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:function_name:SPACES( ):LEFTTRIM:LENGTHS(16,9,11,13):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:customer_id:SPACES( ):LEFTTRIM:LENGTHS(11,12,8,10,9,13,14,16,7,15,18,17):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:company_id:SPACES( ):LEFTTRIM:LENGTHS(6,7):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:global_company_id:SPACES( ):LEFTTRIM:LENGTHS(7,5,8,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:phone_nbr:SPACES( ):LEFTTRIM:LENGTHS(10,2):WORDS(1):ONFAIL(CLEAN)
 
FIELD:lex_id:LIKE(NUMBER):TYPE(STRING30):0,0
FIELD:product_id:TYPE(STRING30):0,0
FIELD:inquiry_date:TYPE(STRING22):0,0
FIELD:transaction_id:TYPE(STRING20):0,0
FIELD:date_added:TYPE(STRING22):0,0
FIELD:customer_number:TYPE(STRING5):0,0
FIELD:customer_account:TYPE(STRING9):0,0
FIELD:ssn:TYPE(STRING9):0,0
FIELD:drivers_license_number:TYPE(STRING25):0,0
FIELD:drivers_license_state:TYPE(STRING2):0,0
FIELD:name_first:TYPE(STRING20):0,0
FIELD:name_last:TYPE(STRING20):0,0
FIELD:name_middle:TYPE(STRING20):0,0
FIELD:name_suffix:TYPE(STRING20):0,0
FIELD:addr_street:TYPE(STRING90):0,0
FIELD:addr_city:TYPE(STRING25):0,0
FIELD:addr_state:TYPE(STRING2):0,0
FIELD:addr_zip5:TYPE(STRING5):0,0
FIELD:addr_zip4:TYPE(STRING4):0,0
FIELD:dob:TYPE(STRING22):0,0
FIELD:transaction_location:TYPE(STRING20):0,0
FIELD:ppc:TYPE(STRING3):0,0
FIELD:internal_identifier:TYPE(STRING1):0,0
FIELD:eu1_customer_number:TYPE(STRING5):0,0
FIELD:eu1_customer_account:TYPE(STRING9):0,0
FIELD:eu2_customer_number:TYPE(STRING5):0,0
FIELD:eu2_customer_account:TYPE(STRING9):0,0
FIELD:email_addr:TYPE(STRING):0,0
FIELD:ip_address:TYPE(STRING):0,0
FIELD:state_id_number:TYPE(STRING):0,0
FIELD:state_id_state:TYPE(STRING):0,0
FIELD:eu_company_name:TYPE(STRING120):0,0
FIELD:eu_addr_street:TYPE(STRING90):0,0 
FIELD:eu_addr_city:TYPE(STRING25):0,0
FIELD:eu_addr_state:TYPE(STRING2):0,0
FIELD:eu_addr_zip5:TYPE(STRING5):0,0
FIELD:eu_phone_nbr:TYPE(STRING10):0,0
FIELD:product_code:TYPE(STRING30):0,0
FIELD:transaction_type:TYPE(STRING1):0,0
FIELD:function_name:TYPE(STRING30):0,0
FIELD:customer_id:TYPE(STRING20):0,0
FIELD:company_id:TYPE(STRING20):0,0
FIELD:global_company_id:TYPE(STRING20):0,0
FIELD:phone_nbr:TYPE(STRING):0,0
// CONCEPT statements should be used to group together interellated fields; such as address
// RELATIONSHIP is used to find non-obvious relationships between the clusters
// SOURCEFIELD is used if a field of the file denotes a source of the records in that file
// LINKPATH is used to define access paths for external linking
 
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
 
