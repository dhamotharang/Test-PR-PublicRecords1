﻿Generated by SALT V3.11.6
Command line options: -MScrubs_Vendor_Src -eC:\Users\petrvl01\AppData\Local\Temp\TFREB7D.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Vendor_Src
FILENAME:Vendor_Src
NAMESCOPE:Orbit
// Uncomment up to NINES for internal or external adl
// IDFIELD:EXISTS:<NameOfIDField>
// RIDFIELD:<NameOfRidField>
// RECORDS:<NumberOfRecordsInDataFile>
// POPULATION:<ExpectedNumberOfEntitiesInDataFile>
// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
// Uncomment Process if doing external adl
// PROCESS:<ProcessName>
// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
FIELDTYPE:item_id:ALLOW( 0123456789)
FIELDTYPE:item_name:ALLOW( ()%@$&*,.-/#'+_0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	)
FIELDTYPE:item_description:ALLOW( ()&',-./+_:$0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	)
FIELDTYPE:status_name:ALLOW( '-ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)
FIELDTYPE:item_source_code:ALLOW( ()!#$%&*+,-./;<>?@[\]^{|}~:_=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)
FIELDTYPE:source_id:ALLOW( 0123456789)
FIELDTYPE:source_name:ALLOW( ()&,-./_'0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	)
FIELDTYPE:source_address1:ALLOW( ()'#&,-./:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	)
FIELDTYPE:source_address2:ALLOW( '#,-._0123456789:0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz	)
FIELDTYPE:source_city:ALLOW( .ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)
FIELDTYPE:source_state:ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)
FIELDTYPE:source_zip:ALLOW( -0123456789ai)
FIELDTYPE:source_phone:ALLOW( ()-./#0123456789?aenotwxpN)
FIELDTYPE:source_website:ALLOW( ~&,-./0123456789:=?@\_ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)
FIELDTYPE:unused_source_sourcecodes:ALLOW()
FIELDTYPE:unused_fcra:ALLOW()
FIELDTYPE:unused_fcra_comments:ALLOW()
FIELDTYPE:market_restrict_flag:ALLOW( NSYeost)
FIELDTYPE:unused_market_comments:ALLOW()
FIELDTYPE:unused_contact_category_name:ALLOW()
FIELDTYPE:unused_contact_name:ALLOW()
FIELDTYPE:unused_contact_phone:ALLOW()
FIELDTYPE:unused_contact_email:ALLOW()
 
// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
// FUZZY can be used to create new types of FUZZY linking
// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.
// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running
// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.
FIELD:item_id:LIKE(item_id):TYPE(STRING):0,0
FIELD:item_name:LIKE(item_name):TYPE(STRING):0,0
FIELD:item_description:LIKE(item_description):TYPE(STRING):0,0
FIELD:status_name:LIKE(status_name):TYPE(STRING):0,0
FIELD:item_source_code:LIKE(item_source_code):TYPE(STRING):0,0
FIELD:source_id:LIKE(source_id):TYPE(STRING):0,0
FIELD:source_name:LIKE(source_name):TYPE(STRING):0,0
FIELD:source_address1:LIKE(source_address1):TYPE(STRING):0,0
FIELD:source_address2:LIKE(source_address2):TYPE(STRING):0,0
FIELD:source_city:LIKE(source_city):TYPE(STRING):0,0
FIELD:source_state:LIKE(source_state):TYPE(STRING):0,0
FIELD:source_zip:LIKE(source_zip):TYPE(STRING):0,0
FIELD:source_phone:LIKE(source_phone):TYPE(STRING):0,0
FIELD:source_website:LIKE(source_website):TYPE(STRING):0,0
FIELD:unused_source_sourcecodes:LIKE(unused_source_sourcecodes):TYPE(STRING):0,0
FIELD:unused_fcra:LIKE(unused_fcra):TYPE(STRING):0,0
FIELD:unused_fcra_comments:LIKE(unused_fcra_comments):TYPE(STRING):0,0
FIELD:market_restrict_flag:LIKE(market_restrict_flag):TYPE(STRING):0,0
FIELD:unused_market_comments:LIKE(unused_market_comments):TYPE(STRING):0,0
FIELD:unused_contact_category_name:LIKE():TYPE(STRING):0,0
FIELD:unused_contact_name:LIKE(unused_contact_category_name):TYPE(STRING):0,0
FIELD:unused_contact_phone:LIKE(unused_contact_phone):TYPE(STRING):0,0
FIELD:unused_contact_email:LIKE(unused_contact_email):TYPE(STRING):0,0
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
 
