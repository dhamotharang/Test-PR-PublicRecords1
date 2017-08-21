Generated by SALT V3.4.3
Command line options: -MScrubs_Corp2_Mapping_NH_Event -eC:\Users\butlersx\AppData\Local\Temp\TFR156B.tmp 
File being processed :-
OPTIONS:-gh 
MODULE:Scrubs_Corp2_Mapping_NH_Event
FILENAME:In_NH
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
 
//FIELDTYPE DEFINITIONS
FIELDTYPE:invalid_corp_key:ALLOW(-0123456789):LENGTHS(4..)
FIELDTYPE:invalid_corp_vendor:ENUM(33)
FIELDTYPE:invalid_state_origin:ENUM(NH)
FIELDTYPE:invalid_mandatory:LENGTHS(1..)
FIELDTYPE:invalid_date:ALLOW(0123456789):CUSTOM(Scrubs.fn_valid_pastDate>0)
FIELDTYPE:invalid_future_date:ALLOW(0123456789):CUSTOM(Scrubs.fn_valid_GeneralDate>0)
FIELDTYPE:invalid_charter_nbr:ALLOW(-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(1..)
FIELDTYPE:invalid_event_filing_reference_nbr:CUSTOM(Scrubs_Corp2_Mapping_NH_Event.Functions.valid_documentid>0)
FIELDTYPE:invalid_event_desc:CUSTOM(Scrubs_Corp2_Mapping_NH_Event.Functions.valid_document_type_desc>0)
FIELDTYPE:invalid_event_date_type_cd:ALLOW(EFIL)
FIELDTYPE:invalid_event_date_type_desc:ALLOW(CEFGILNTV )
 
FIELD:corp_key:TYPE(STRING30):LIKE(invalid_corp_key):0,0
FIELD:corp_supp_key:TYPE(STRING30):0,0
FIELD:corp_vendor:TYPE(STRING2):LIKE(invalid_corp_vendor):0,0
FIELD:corp_vendor_county:TYPE(STRING3):0,0
FIELD:corp_vendor_subcode:TYPE(STRING5):0,0
FIELD:corp_state_origin:TYPE(STRING2):LIKE(invalid_state_origin):0,0
FIELD:corp_process_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:corp_sos_charter_nbr:TYPE(STRING32):LIKE(invalid_charter_nbr):0,0
FIELD:event_filing_reference_nbr:TYPE(STRING30):LIKE(invalid_event_filing_reference_nbr):0,0
FIELD:event_amendment_nbr:TYPE(STRING3):0,0
FIELD:event_filing_date:TYPE(STRING8):LIKE(invalid_future_date):0,0
FIELD:event_date_type_cd:TYPE(STRING3):LIKE(invalid_event_date_type_cd):0,0
FIELD:event_date_type_desc:TYPE(STRING30):LIKE(invalid_event_date_type_desc):0,0
FIELD:event_filing_cd:TYPE(STRING8):0,0
FIELD:event_filing_desc:TYPE(STRING60):0,0
FIELD:event_corp_nbr:TYPE(STRING32):0,0
FIELD:event_corp_nbr_cd:TYPE(STRING1):0,0
FIELD:event_corp_nbr_desc:TYPE(STRING30):0,0
FIELD:event_roll:TYPE(STRING10):0,0
FIELD:event_frame:TYPE(STRING10):0,0
FIELD:event_start:TYPE(STRING8):0,0
FIELD:event_end:TYPE(STRING8):0,0
FIELD:event_microfilm_nbr:TYPE(STRING10):0,0
FIELD:event_desc:TYPE(STRING500):LIKE(invalid_event_desc),0,0
FIELD:event_revocation_comment1:TYPE(STRING250):0,0
FIELD:event_revocation_comment2:TYPE(STRING250):0,0
FIELD:event_book_nbr:TYPE(STRING9):0,0
FIELD:event_page_nbr:TYPE(STRING9):0,0
FIELD:event_certification_nbr:TYPE(STRING9):0,0
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
 
