﻿Generated by SALT V3.11.6
Command line options: -gn 
File being processed :-
OPTIONS:-gn
MODULE:Cortera_Tradeline
FILENAME:Tradeline_Base
// Uncomment up to NINES for internal or external adl
// IDFIELD:EXISTS:<NameOfIDField>
RIDFIELD:rid:GENERATE
// RECORDS:<NumberOfRecordsInDataFile>
RECORDS:1000000
// POPULATION:<ExpectedNumberOfEntitiesInDataFile>
// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
NINES:3
// Uncomment Process if doing external adl
// PROCESS:<ProcessName>
// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
// FUZZY can be used to create new types of FUZZY linking
// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.
// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running
// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.
FIELDTYPE:numeric:ALLOW(0123456789)
FIELDTYPE:number:ALLOW(0123456789-):LENGTHS(0,1..)
FIELDTYPE:date:ALLOW(0123456789):LENGTHS(0,8)
FIELD:link_id:LIKE(numeric):0,0
FIELD:account_key:TYPE(STRING32):0,0
FIELD:ar_date:TYPE(STRING8):LIKE(date):0,0
FIELD:total_ar:TYPE(STRING20):0,0
FIELD:status:TYPE(STRING1):0,0
FIELD:dt_vendor_first_reported:RECORDDATE(FIRST):0,0
FIELD:dt_vendor_last_reported:RECORDDATE(LAST):0,0
INGESTFILE:tradelines:NAMED(Cortera_Tradeline.Prep_Ingest)

// CONCEPT statements should be used to group together interellated fields; such as address
// RELATIONSHIP is used to find non-obvious relationships between the clusters
// SOURCEFIELD is used if a field of the file denotes a source of the records in that file
// LINKPATH is used to define access paths for external linking


Total available specificity:0
Search Threshold set at 8
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


