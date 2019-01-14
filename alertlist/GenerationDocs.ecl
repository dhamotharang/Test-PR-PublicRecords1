Generated by SALT V2.5 Gold
File being processed :-
OPTIONS:-sa
MODULE:alertlist
FILENAME:AlertOutput
//Uncomment up to NINES for internal or external adl 
//IDFIELD:EXISTS:<NameOfIDField>  
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9, 2 = 99 5.718878e+263tc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking
FIELD:id:TYPE(STRING):0,0
FIELD:customer_id:TYPE(STRING):0,0
FIELD:product_id:TYPE(STRING):0,0
FIELD:lid_type:TYPE(STRING):0,0
FIELD:lid:TYPE(UNSIGNED8):0,0
FIELD:cluster_id:TYPE(UNSIGNED8):0,0
FIELD:totalcnt:TYPE(UNSIGNED2):0,0
FIELD:firstdegrees:TYPE(UNSIGNED2):0,0
FIELD:seconddegrees:TYPE(UNSIGNED2):0,0
FIELD:cohesivity:TYPE(REAL4):0,0
FIELD:active_company_count:TYPE(INTEGER8):0,0
FIELD:active_company_0:TYPE(INTEGER8):0,0
FIELD:active_company_1:TYPE(INTEGER8):0,0
FIELD:active_company_2:TYPE(INTEGER8):0,0
FIELD:alert_company_count:TYPE(INTEGER8):0,0
FIELD:alert_company_0:TYPE(INTEGER8):0,0
FIELD:alert_company_1:TYPE(INTEGER8):0,0
FIELD:alert_company_2:TYPE(INTEGER8):0,0
FIELD:active_person_count:TYPE(INTEGER8):0,0
FIELD:active_person_0:TYPE(INTEGER8):0,0
FIELD:active_person_1:TYPE(INTEGER8):0,0
FIELD:active_person_2:TYPE(INTEGER8):0,0
FIELD:alert_person_count:TYPE(INTEGER8):0,0
FIELD:alert_person_0:TYPE(INTEGER8):0,0
FIELD:alert_person_1:TYPE(INTEGER8):0,0
FIELD:alert_person_2:TYPE(INTEGER8):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
Total available specificity:0
Search Threshold set at -4
+++Line:44:Need threshold and blockthreshold to continue
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
