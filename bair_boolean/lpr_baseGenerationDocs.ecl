Generated by SALT V3.0 Gold
File being processed :-
OPTIONS:-bh
MODULE:bair_boolean.lpr_base
FILENAME:lpr_base
RIDFIELD:newrid:GENERATE
DOCFIELD:eid:HASH5
IDNAME:newrid
IDSPACE:MDR.sourceTools.src_Bair_Analytics
FIELD:eid:0,0
FIELD:gh12:0,0
FIELD:etype:0,0
FIELD:eventnumber:0,0
FIELD:plate:0,0
DATEFIELD:clean_capturedatetime:0,0
FIELD:plateimage:0,0
FIELD:overviewimage:0,0
NUMBERFIELD:x_coordinate:0,0
NUMBERFIELD:y_coordinate:0,0
CONCEPT:DATE:clean_capturedatetime:SEGTYPE(GroupSeg):1,0
 
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
 
