Generated by SALT V1.7 Beta 1
File being processed :-
MODULE:Text_FragV1.Property_A
FILENAME:Property_A_Extract
IDFIELD:EXISTS:did
IDFIELD:EXISTS:bdid
DOCFIELD:sid
IDSPACE:le.source
RIDFIELD:rid
FIELD:state_code:1.0
FIELD:county_name:1.0
FIELD:assessee_name:1.0
FIELD:second_assessee_name:1.0
FIELD:contract_owner:1,0
FIELD:assessee_phone_number:1.0		// Phone type
FIELD:mailing_care_of_name:1.0
FIELD:mailing_full_street_address:1.0
FIELD:mailing_unit_number:1.0
FIELD:mailing_city_state_zip:1.0
FIELD:property_full_street_address:1.0
FIELD:property_unit_number:1.0
FIELD:property_city_state_zip:1.0
FIELD:title:1.0
FIELD:fname:1.0
FIELD:mname:1.0
FIELD:lname:1.0
FIELD:name_suffix:1.0
FIELD:cname:1.0
FIELD:nameasis:1.0
FIELD:prim_range:1.0
FIELD:predir:1.0
FIELD:prim_name:1.0
FIELD:suffix:1.0
FIELD:postdir:1.0
FIELD:unit_desig:1.0
FIELD:sec_range:1.0
FIELD:v_city_name:1.0
FIELD:st:1.0
FIELD:zip:1.0
FIELD:zip4:1.0
FIELD:phone_number:1,0		// SegType Phone
CONCEPT:CASS_ADDRESS:prim_range:predir:prim_name:suffix:postdir:unit_desig:sec_range:SEGTYPE(ConcatSeg):1,0
CONCEPT:CASS_CSZ:v_city_name:st:zip:zip4:SEGTYPE(ConcatSeg):1,0
CONCEPT:CLEAN_NAME:title:fname:mname:lname:name_suffix:SEGTYPE(ConcatSeg):1.0
// Standard alias groups
CONCEPT:ADDRESS:prim_range:predir:prim_name:suffix:postdir:unit_desig:sec_range:v_city_name:st:zip:zip4:mailing_full_street_address:mailing_unit_number:mailing_city_state_zip:property_full_street_address:property_unit_number:property_city_state_zip:1,0
CONCEPT:NAME:title:fname:mname:lname:name_suffix:cname:nameasis:assessee_name:second_assessee_name:mailing_care_of_name:contract_owner:cname:1,0
CONCEPT:PHONE:assessee_phone_number:phone_number:1,0
CONCEPT:COMPANY:cname:1,0
Total available specificity:39
Search Threshold set at -4
Need threshold and blockthreshold to continue
Use of PERSISTs in code set at:3
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
