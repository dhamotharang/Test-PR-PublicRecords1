﻿Generated by SALT V3.11.6
Command line options: -M_Scrubs_VendorSrc_CourtLocations -eC:\Users\petrvl01\AppData\Local\Temp\TFRF855.tmp 
File being processed :-
OPTIONS:-gh
MODULE:_Scrubs_VendorSrc_CourtLocations
FILENAME:CourtLocations
// Uncomment up to NINES for internal or external adl
// IDFIELD:EXISTS:<NameOfIDField>
// RIDFIELD:<NameOfRidField>
// RECORDS:<NumberOfRecordsInDataFile>
// POPULATION:<ExpectedNumberOfEntitiesInDataFile>
// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
// Uncomment Process if doing external adl
// PROCESS:<ProcessName>
// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
// FUZZY can be used to create new types of FUZZY linking
// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.
// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running
// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.
FIELD:fipscode:TYPE(STRING5):0,0
FIELD:statefips:TYPE(STRING2):0,0
FIELD:countyfips:TYPE(STRING3):0,0
FIELD:courtid:TYPE(STRING):0,0
FIELD:consolidatedcourtid:TYPE(STRING):0,0
FIELD:masterid:TYPE(STRING):0,0
FIELD:stateofservice:TYPE(STRING):0,0
FIELD:countyofservice:TYPE(STRING):0,0
FIELD:courtname:TYPE(STRING):0,0
FIELD:phone:TYPE(STRING):0,0
FIELD:address1:TYPE(STRING):0,0
FIELD:address2:TYPE(STRING):0,0
FIELD:city:TYPE(STRING):0,0
FIELD:state:TYPE(STRING):0,0
FIELD:zipcode:TYPE(STRING5):0,0
FIELD:zip4:TYPE(STRING4):0,0
FIELD:mailaddress1:TYPE(STRING):0,0
FIELD:mailaddress2:TYPE(STRING):0,0
FIELD:mailcity:TYPE(STRING):0,0
FIELD:mailctate:TYPE(STRING):0,0
FIELD:mailzipcode:TYPE(STRING5):0,0
FIELD:mailzip4:TYPE(STRING4):0,0
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
 
