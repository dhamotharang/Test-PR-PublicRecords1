Generated by SALT V3.1.2
File being processed :-
MODULE:Scrubs_HX
OPTIONS:-gh
FILENAME:HX
NAMESCOPE:HX
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
FIELDTYPE:claim_type:SPACES( ):ALLOW(I):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:claim_num:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(15,16):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:attend_prov_id:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(10,0):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:attend_prov_name:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWYZ):LEFTTRIM:WORDS(2,1):ONFAIL(CLEAN) 
FIELDTYPE:billing_addr:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWYZ):ONFAIL(CLEAN) 
FIELDTYPE:billing_city:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWYZ):ONFAIL(CLEAN) 
FIELDTYPE:billing_npi:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,10):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:billing_org_name:SPACES( ):ALLOW( -ABCDEFGHIJKLMNOPQRSTUVWYZ):LEFTTRIM:ONFAIL(CLEAN) 
FIELDTYPE:billing_state:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWYZ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:billing_tax_id:SPACES( ):ALLOW(0135):LEFTTRIM:LENGTHS(10):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:billing_zip:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:inpatient_proc1:SPACES( ):ALLOW(0123456789ACEGJNOQ):LEFTTRIM:LENGTHS(0,4,5):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:inpatient_proc2:SPACES( ):ALLOW(0123456789ACEGJNOQ):LEFTTRIM:LENGTHS(0,4,5):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:inpatient_proc3:SPACES( ):ALLOW(0123456789ACEGJNOQ):LEFTTRIM:LENGTHS(0,4,5):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:operating_prov_id:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,10):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:operating_prov_name:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN) 
FIELDTYPE:other_diag1:SPACES( ):ALLOW(0123456789V):LEFTTRIM:LENGTHS(4,5,0,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_diag2:SPACES( ):ALLOW(0123456789V):LEFTTRIM:LENGTHS(0,5,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_diag3:SPACES( ):ALLOW(0123456789V):LEFTTRIM:LENGTHS(0,5,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_diag4:SPACES( ):ALLOW(0123456789V):LEFTTRIM:LENGTHS(0,5,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_diag5:SPACES( ):ALLOW(0123456789V):LEFTTRIM:LENGTHS(0,5,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_diag6:SPACES( ):ALLOW(0123456789V):LEFTTRIM:LENGTHS(0,5,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_diag7:SPACES( ):ALLOW(0123456789V):LEFTTRIM:LENGTHS(0,5,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_diag8:SPACES( ):ALLOW(0123456789V):LEFTTRIM:LENGTHS(0,5,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_proc1:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_proc2:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_proc3:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_proc4:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_proc5:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_proc_method_code:SPACES( ):ALLOW(09):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_prov_id1:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,10):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:other_prov_name1:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN) 
FIELDTYPE:outpatient_proc1:SPACES( ):ALLOW(0123456789ACEGJNOPQTZ):LEFTTRIM:LENGTHS(5,0,4):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:outpatient_proc2:SPACES( ):ALLOW(0123456789ACEGJNOPQTZ):LEFTTRIM:LENGTHS(5,0,4):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:outpatient_proc3:SPACES( ):ALLOW(0123456789ACEGJNOPQTZ):LEFTTRIM:LENGTHS(5,0,4):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:principle_diag:SPACES( ):ALLOW(0123456789V):LEFTTRIM:LENGTHS(4,5,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:principle_proc:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,4,3):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:service_from:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:service_line:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(3,0):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:service_to:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8):WORDS(1):ONFAIL(CLEAN) 
FIELDTYPE:submitted_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8):WORDS(1):ONFAIL 
FIELD:claim_type:0,0
FIELD:claim_num:0,0
FIELD:attend_prov_id:0,0
FIELD:attend_prov_name:0,0
FIELD:billing_addr:0,0
FIELD:billing_city:0,0
FIELD:billing_npi:0,0
FIELD:billing_org_name:0,0
FIELD:billing_state:0,0
FIELD:billing_tax_id:0,0
FIELD:billing_zip:0,0
FIELD:ext_injury_diag_code:0,0
FIELD:inpatient_proc1:0,0
FIELD:inpatient_proc2:0,0
FIELD:inpatient_proc3:0,0
FIELD:operating_prov_id:0,0
FIELD:operating_prov_name:0,0
FIELD:other_diag1:0,0
FIELD:other_diag2:0,0
FIELD:other_diag3:0,0
FIELD:other_diag4:0,0
FIELD:other_diag5:0,0
FIELD:other_diag6:0,0
FIELD:other_diag7:0,0
FIELD:other_diag8:0,0
FIELD:other_proc1:0,0
FIELD:other_proc2:0,0
FIELD:other_proc3:0,0
FIELD:other_proc4:0,0
FIELD:other_proc5:0,0
FIELD:other_proc_method_code:0,0
FIELD:other_prov_id1:0,0
FIELD:other_prov_id2:0,0
FIELD:other_prov_name1:0,0
FIELD:other_prov_name2:0,0
FIELD:outpatient_proc1:0,0
FIELD:outpatient_proc2:0,0
FIELD:outpatient_proc3:0,0
FIELD:principle_diag:0,0
FIELD:principle_proc:0,0
FIELD:service_from:0,0
FIELD:service_line:0,0
FIELD:service_to:0,0
FIELD:submitted_date:0,0
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
