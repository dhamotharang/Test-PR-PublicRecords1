﻿Generated by SALT V3.9.0
Command line options: -MScrubs_Inql_Nfcra_IDM -eC:\Users\kumade01\AppData\Local\Temp\TFRD964.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Inql_Nfcra_IDM
FILENAME:FILE
 
FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("')
FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):
FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,'.):
FIELDTYPE:NUMBER:ALLOW(0123456789):
FIELDTYPE:ALPHANUM:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):
FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$*):SPACES( ):ONFAIL(CLEAN):
 
FIELDTYPE:orig_transaction_id:SPACES( ):LIKE(WORDBAG):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_dateadded:SPACES( ):ALLOW( -.0123456789:):LEFTTRIM:LENGTHS(23,22,21):WORDS(2):ONFAIL(CLEAN)
FIELDTYPE:orig_billingid:SPACES( ):LIKE(ALPHANUM):LEFTTRIM:LENGTHS(7,6,9,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:orig_function_name:SPACES( ):LIKE(ALPHA):LEFTTRIM:LENGTHS(12,14):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_adl:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,10,12,9,11,8):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_fname:SPACES( ):LIKE(NAME):WORDS(1,0,2,3):ONFAIL(CLEAN)
FIELDTYPE:orig_lname:SPACES( ):LIKE(NAME):WORDS(1,0,2,3):ONFAIL(CLEAN)
FIELDTYPE:orig_mname:SPACES( ):LIKE(NAME):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_ssn:SPACES( ):LIKE(NUMBER):LENGTHS(9,0,4,14):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:orig_address:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)
FIELDTYPE:orig_city:SPACES( ):LIKE(ALPHA):WORDS(1,2,0,3):ONFAIL(CLEAN)
FIELDTYPE:orig_state:SPACES( ):LIKE(ALPHA):WORDS(1,0,2):ONFAIL(CLEAN)
FIELDTYPE:orig_zip:SPACES( ):LIKE(NUMBER):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:orig_phone:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,10,5,9,11):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_dob:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:LENGTHS(10,0,14):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:orig_dln:SPACES( ):LIKE(WORDBAG):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_dln_st:SPACES( ):LIKE(WORDBAG):LEFTTRIM:LENGTHS(0,2):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_glb:SPACES( ):ALLOW(13567):LEFTTRIM:LENGTHS(0,1,2):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:orig_dppa:SPACES( ):ALLOW(01356):LEFTTRIM:LENGTHS(1,0,2):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:orig_fcra:SPACES( ):ALLOW(01357):LEFTTRIM:LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)
 
FIELD:orig_transaction_id:LIKE(orig_transaction_id):TYPE(STRING):0,0
FIELD:orig_dateadded:LIKE(orig_dateadded):TYPE(STRING):0,0
FIELD:orig_billingid:LIKE(orig_billingid):TYPE(STRING):0,0
FIELD:orig_function_name:LIKE(orig_function_name):TYPE(STRING):0,0
FIELD:orig_adl:LIKE(orig_adl):TYPE(STRING):0,0
FIELD:orig_fname:LIKE(orig_fname):TYPE(STRING):0,0
FIELD:orig_lname:LIKE(orig_lname):TYPE(STRING):0,0
FIELD:orig_mname:LIKE(orig_mname):TYPE(STRING):0,0
FIELD:orig_ssn:LIKE(orig_ssn):TYPE(STRING):0,0
FIELD:orig_address:LIKE(orig_address):TYPE(STRING):0,0
FIELD:orig_city:LIKE(orig_city):TYPE(STRING):0,0
FIELD:orig_state:LIKE(orig_state):TYPE(STRING):0,0
FIELD:orig_zip:LIKE(orig_zip):TYPE(STRING):0,0
FIELD:orig_phone:LIKE(orig_phone):TYPE(STRING):0,0
FIELD:orig_dob:LIKE(orig_dob):TYPE(STRING):0,0
FIELD:orig_dln:LIKE(orig_dln):TYPE(STRING):0,0
FIELD:orig_dln_st:LIKE(orig_dln_st):TYPE(STRING):0,0
FIELD:orig_glb:LIKE(orig_glb):TYPE(STRING):0,0
FIELD:orig_dppa:LIKE(orig_dppa):TYPE(STRING):0,0
FIELD:orig_fcra:LIKE(orig_fcra):TYPE(STRING):0,0
 
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
 
