﻿Generated by SALT V3.11.6
Command line options: -MWhoIs -eC:\Users\shenxi01\AppData\Local\Temp\TFR3DBE.tmp 
File being processed :-
OPTIONS:-gh
MODULE:WhoIs
FILENAME:WhoIs
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
FIELD:rcid:TYPE(UNSIGNED6):0,0
FIELD:domainname:TYPE(STRING):0,0
FIELD:registrarname:TYPE(STRING):0,0
FIELD:contactemail:TYPE(STRING):0,0
FIELD:whoisserver:TYPE(STRING):0,0
FIELD:nameservers:TYPE(STRING):0,0
FIELD:createddate:TYPE(STRING):0,0
FIELD:updateddate:TYPE(STRING):0,0
FIELD:expiresdate:TYPE(STRING):0,0
FIELD:standardregcreateddate:TYPE(STRING):0,0
FIELD:standardregupdateddate:TYPE(STRING):0,0
FIELD:standardregexpiresdate:TYPE(STRING):0,0
FIELD:status:TYPE(STRING):0,0
FIELD:audit_auditupdateddate:TYPE(STRING):0,0
FIELD:registrant_rawtext:TYPE(STRING):0,0
FIELD:registrant_email:TYPE(STRING):0,0
FIELD:registrant_name:TYPE(STRING):0,0
FIELD:registrant_organization:TYPE(STRING):0,0
FIELD:registrant_street1:TYPE(STRING):0,0
FIELD:registrant_street2:TYPE(STRING):0,0
FIELD:registrant_street3:TYPE(STRING):0,0
FIELD:registrant_street4:TYPE(STRING):0,0
FIELD:registrant_city:TYPE(STRING):0,0
FIELD:registrant_state:TYPE(STRING):0,0
FIELD:registrant_postalcode:TYPE(STRING):0,0
FIELD:registrant_country:TYPE(STRING):0,0
FIELD:registrant_fax:TYPE(STRING):0,0
FIELD:registrant_faxext:TYPE(STRING):0,0
FIELD:registrant_phone:TYPE(STRING):0,0
FIELD:registrant_phoneext:TYPE(STRING):0,0
FIELD:administrativecontact_rawtext:TYPE(STRING):0,0
FIELD:administrativecontact_email:TYPE(STRING):0,0
FIELD:administrativecontact_name:TYPE(STRING):0,0
FIELD:administrativecontact_organization:TYPE(STRING):0,0
FIELD:administrativecontact_street1:TYPE(STRING):0,0
FIELD:administrativecontact_street2:TYPE(STRING):0,0
FIELD:administrativecontact_street3:TYPE(STRING):0,0
FIELD:administrativecontact_street4:TYPE(STRING):0,0
FIELD:administrativecontact_city:TYPE(STRING):0,0
FIELD:administrativecontact_state:TYPE(STRING):0,0
FIELD:administrativecontact_postalcode:TYPE(STRING):0,0
FIELD:administrativecontact_country:TYPE(STRING):0,0
FIELD:administrativecontact_fax:TYPE(STRING):0,0
FIELD:administrativecontact_faxext:TYPE(STRING):0,0
FIELD:administrativecontact_phone:TYPE(STRING):0,0
FIELD:administrativecontact_phoneext:TYPE(STRING):0,0
FIELD:billingcontact_rawtext:TYPE(STRING):0,0
FIELD:billingcontact_email:TYPE(STRING):0,0
FIELD:billingcontact_name:TYPE(STRING):0,0
FIELD:billingcontact_organization:TYPE(STRING):0,0
FIELD:billingcontact_street1:TYPE(STRING):0,0
FIELD:billingcontact_street2:TYPE(STRING):0,0
FIELD:billingcontact_street3:TYPE(STRING):0,0
FIELD:billingcontact_street4:TYPE(STRING):0,0
FIELD:billingcontact_city:TYPE(STRING):0,0
FIELD:billingcontact_state:TYPE(STRING):0,0
FIELD:billingcontact_postalcode:TYPE(STRING):0,0
FIELD:billingcontact_country:TYPE(STRING):0,0
FIELD:billingcontact_fax:TYPE(STRING):0,0
FIELD:billingcontact_faxext:TYPE(STRING):0,0
FIELD:billingcontact_phone:TYPE(STRING):0,0
FIELD:billingcontact_phoneext:TYPE(STRING):0,0
FIELD:technicalcontact_rawtext:TYPE(STRING):0,0
FIELD:technicalcontact_email:TYPE(STRING):0,0
FIELD:technicalcontact_name:TYPE(STRING):0,0
FIELD:technicalcontact_organization:TYPE(STRING):0,0
FIELD:technicalcontact_street1:TYPE(STRING):0,0
FIELD:technicalcontact_street2:TYPE(STRING):0,0
FIELD:technicalcontact_street3:TYPE(STRING):0,0
FIELD:technicalcontact_street4:TYPE(STRING):0,0
FIELD:technicalcontact_city:TYPE(STRING):0,0
FIELD:technicalcontact_state:TYPE(STRING):0,0
FIELD:technicalcontact_postalcode:TYPE(STRING):0,0
FIELD:technicalcontact_country:TYPE(STRING):0,0
FIELD:technicalcontact_fax:TYPE(STRING):0,0
FIELD:technicalcontact_faxext:TYPE(STRING):0,0
FIELD:technicalcontact_phone:TYPE(STRING):0,0
FIELD:technicalcontact_phoneext:TYPE(STRING):0,0
FIELD:zonecontact_rawtext:TYPE(STRING):0,0
FIELD:zonecontact_email:TYPE(STRING):0,0
FIELD:zonecontact_name:TYPE(STRING):0,0
FIELD:zonecontact_organization:TYPE(STRING):0,0
FIELD:zonecontact_street1:TYPE(STRING):0,0
FIELD:zonecontact_street2:TYPE(STRING):0,0
FIELD:zonecontact_street3:TYPE(STRING):0,0
FIELD:zonecontact_street4:TYPE(STRING):0,0
FIELD:zonecontact_city:TYPE(STRING):0,0
FIELD:zonecontact_state:TYPE(STRING):0,0
FIELD:zonecontact_postalcode:TYPE(STRING):0,0
FIELD:zonecontact_country:TYPE(STRING):0,0
FIELD:zonecontact_fax:TYPE(STRING):0,0
FIELD:zonecontact_faxext:TYPE(STRING):0,0
FIELD:zonecontact_phone:TYPE(STRING):0,0
FIELD:zonecontact_phoneext:TYPE(STRING):0,0
FIELD:emailtype:TYPE(STRING10):0,0
FIELD:rawtext:TYPE(STRING):0,0
FIELD:email:TYPE(STRING):0,0
FIELD:name:TYPE(STRING):0,0
FIELD:organization:TYPE(STRING):0,0
FIELD:street1:TYPE(STRING):0,0
FIELD:street2:TYPE(STRING):0,0
FIELD:street3:TYPE(STRING):0,0
FIELD:street4:TYPE(STRING):0,0
FIELD:city:TYPE(STRING):0,0
FIELD:state:TYPE(STRING):0,0
FIELD:postalcode:TYPE(STRING):0,0
FIELD:country:TYPE(STRING):0,0
FIELD:fax:TYPE(STRING):0,0
FIELD:faxext:TYPE(STRING):0,0
FIELD:phone:TYPE(STRING):0,0
FIELD:phoneext:TYPE(STRING):0,0
FIELD:uniq_record_id:TYPE(UNSIGNED8):0,0
FIELD:uniq_email_id:TYPE(UNSIGNED8):0,0
FIELD:did:TYPE(UNSIGNED8):0,0
FIELD:did_score:TYPE(UNSIGNED8):0,0
FIELD:clean_title:TYPE(STRING5):0,0
FIELD:clean_fname:TYPE(STRING20):0,0
FIELD:clean_mname:TYPE(STRING20):0,0
FIELD:clean_lname:TYPE(STRING20):0,0
FIELD:clean_name_suffix:TYPE(STRING5):0,0
FIELD:clean_name_score:TYPE(STRING3):0,0
FIELD:rawaid:TYPE(UNSIGNED8):0,0
FIELD:append_prep_address_situs:TYPE(STRING77):0,0
FIELD:append_prep_address_last_situs:TYPE(STRING54):0,0
FIELD:prim_range:TYPE(STRING10):0,0
FIELD:predir:TYPE(STRING2):0,0
FIELD:prim_name:TYPE(STRING28):0,0
FIELD:addr_suffix:TYPE(STRING4):0,0
FIELD:postdir:TYPE(STRING2):0,0
FIELD:unit_desig:TYPE(STRING10):0,0
FIELD:sec_range:TYPE(STRING8):0,0
FIELD:p_city_name:TYPE(STRING25):0,0
FIELD:v_city_name:TYPE(STRING25):0,0
FIELD:st:TYPE(STRING2):0,0
FIELD:zip:TYPE(STRING5):0,0
FIELD:zip4:TYPE(STRING4):0,0
FIELD:cart:TYPE(STRING4):0,0
FIELD:cr_sort_sz:TYPE(STRING1):0,0
FIELD:lot:TYPE(STRING4):0,0
FIELD:lot_order:TYPE(STRING1):0,0
FIELD:dbpc:TYPE(STRING2):0,0
FIELD:chk_digit:TYPE(STRING1):0,0
FIELD:rec_type:TYPE(STRING2):0,0
FIELD:county:TYPE(STRING5):0,0
FIELD:geo_lat:TYPE(STRING10):0,0
FIELD:geo_long:TYPE(STRING11):0,0
FIELD:msa:TYPE(STRING4):0,0
FIELD:geo_blk:TYPE(STRING7):0,0
FIELD:geo_match:TYPE(STRING1):0,0
FIELD:err_stat:TYPE(STRING4):0,0
FIELD:process_date:TYPE(STRING8):0,0
FIELD:date_first_seen:TYPE(STRING8):0,0
FIELD:date_last_seen:TYPE(STRING8):0,0
FIELD:date_vendor_first_reported:TYPE(STRING8):0,0
FIELD:date_vendor_last_reported:TYPE(STRING8):0,0
FIELD:clean_cname:TYPE(STRING):0,0
FIELD:current_rec:TYPE(BOOLEAN):0,0
FIELD:dotid:TYPE(UNSIGNED6):0,0
FIELD:dotscore:TYPE(UNSIGNED2):0,0
FIELD:dotweight:TYPE(UNSIGNED2):0,0
FIELD:empid:TYPE(UNSIGNED6):0,0
FIELD:empscore:TYPE(UNSIGNED2):0,0
FIELD:empweight:TYPE(UNSIGNED2):0,0
FIELD:powid:TYPE(UNSIGNED6):0,0
FIELD:powscore:TYPE(UNSIGNED2):0,0
FIELD:powweight:TYPE(UNSIGNED2):0,0
FIELD:proxid:TYPE(UNSIGNED6):0,0
FIELD:proxscore:TYPE(UNSIGNED2):0,0
FIELD:proxweight:TYPE(UNSIGNED2):0,0
FIELD:seleid:TYPE(UNSIGNED6):0,0
FIELD:selescore:TYPE(UNSIGNED2):0,0
FIELD:seleweight:TYPE(UNSIGNED2):0,0
FIELD:orgid:TYPE(UNSIGNED6):0,0
FIELD:orgscore:TYPE(UNSIGNED2):0,0
FIELD:orgweight:TYPE(UNSIGNED2):0,0
FIELD:ultid:TYPE(UNSIGNED6):0,0
FIELD:ultscore:TYPE(UNSIGNED2):0,0
FIELD:ultweight:TYPE(UNSIGNED2):0,0
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
 
