Generated by SALT V3.0 Gold
File being processed :-
OPTIONS:-bh
MODULE:bair_boolean.persons_base
FILENAME:persons_base
RIDFIELD:newrid:GENERATE
DOCFIELD:eid:HASH5
IDNAME:newrid
IDSPACE:MDR.sourceTools.src_Bair_Analytics
FIELD:eid:0,0
FIELD:gh12:0,0
FIELD:etype:0,0
FIELD:ir_number:0,0
FIELD:name_type:0,0
FIELD:last_name:0,0
FIELD:first_name:0,0
FIELD:middle_name:0,0
FIELD:moniker:0,0
FIELD:persons_address:0,0
DATEFIELD:clean_dob:0,0
FIELD:race:0,0
FIELD:sex:0,0
FIELD:hair:0,0
FIELD:hair_length:0,0
FIELD:eyes:0,0
FIELD:hand_use:0,0
FIELD:speech:0,0
FIELD:teeth:0,0
FIELD:physical_condition:0,0
FIELD:build:0,0
FIELD:complexion:0,0
FIELD:facial_hair:0,0
FIELD:hat:0,0
FIELD:mask:0,0
FIELD:glasses:0,0
FIELD:appearance:0,0
FIELD:shirt:0,0
FIELD:pants:0,0
FIELD:shoes:0,0
FIELD:jacket:0,0
FIELD:soundex:0,0
FIELD:persons_notes:0,0
NUMBERFIELD:weight_1:0,0
NUMBERFIELD:weight_2:0,0
NUMBERFIELD:height_1:0,0
NUMBERFIELD:height_2:0,0
NUMBERFIELD:age_1:0,0
NUMBERFIELD:age_2:0,0
FIELD:persons_sid:0,0
FIELD:picture:0,0
FIELD:facial_recognition:0,0
CONCEPT:NOTES:persons_notes:SEGTYPE(GroupSeg):1,0
 
Total available specificity:1
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
 
