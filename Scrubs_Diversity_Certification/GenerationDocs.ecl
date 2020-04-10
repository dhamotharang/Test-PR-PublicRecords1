﻿Generated by SALT V3.11.9
Command line options: -MScrubs_Diversity_Certification -eC:\Users\granjo01\AppData\Local\Temp\TFRB503.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Diversity_Certification
FILENAME:Diversity_Certification
 
FIELDTYPE:Invalid_No:ALLOW(0123456789)
FIELDTYPE:Invalid_Float:ALLOW(0123456789 .-/)
FIELDTYPE:Invalid_Alpha:ALLOW(aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ )
FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ )
FIELDTYPE:Invalid_AlphaChar:ALLOW(aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ .'-&)
FIELDTYPE:Invalid_AlphaNumChar:ALLOW(0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ .'-&@)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_Valid_Date > 0)
FIELDTYPE:Invalid_Future:CUSTOM(Scrubs.fn_Valid_Date > 0, 'Future')
FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)
FIELDTYPE:Invalid_Zip:LIKE(Invalid_Float):LENGTHS(0,5,9,10)
FIELDTYPE:Invalid_Phone:LIKE(Invalid_No):LENGTHS(0,9,10)
 
FIELD:dartid:TYPE(STRING):LIKE(Invalid_No):0,0
FIELD:dateadded:TYPE(STRING):LIKE(Invalid_Date):0,0
FIELD:dateupdated:TYPE(STRING):LIKE(Invalid_Date):0,0
FIELD:website:TYPE(STRING):0,0
FIELD:state:TYPE(STRING):LIKE(Invalid_State):0,0
FIELD:profilelastupdated:TYPE(STRING):LIKE(Invalid_Date):0,0
FIELD:county:TYPE(STRING):0,0
FIELD:servicearea:TYPE(STRING):0,0
FIELD:region1:TYPE(STRING):0,0
FIELD:region2:TYPE(STRING):0,0
FIELD:region3:TYPE(STRING):0,0
FIELD:region4:TYPE(STRING):0,0
FIELD:region5:TYPE(STRING):0,0
FIELD:fname:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:lname:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:mname:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:suffix:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:title:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:ethnicity:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:gender:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:address1:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0
FIELD:address2:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0
FIELD:addresscity:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:addressstate:TYPE(STRING):LIKE(Invalid_State):0,0
FIELD:addresszipcode:TYPE(STRING):LIKE(Invalid_Zip):0,0
FIELD:addresszip4:TYPE(STRING):LIKE(Invalid_No):0,0
FIELD:building:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:contact:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:phone1:TYPE(STRING):LIKE(Invalid_Phone):0,0
FIELD:phone2:TYPE(STRING):LIKE(Invalid_Phone):0,0
FIELD:phone3:TYPE(STRING):LIKE(Invalid_Phone):0,0
FIELD:cell:TYPE(STRING):LIKE(Invalid_Phone):0,0
FIELD:fax:TYPE(STRING):LIKE(Invalid_Phone):0,0
FIELD:email1:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0
FIELD:email2:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0
FIELD:email3:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0
FIELD:webpage1:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0
FIELD:webpage2:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0
FIELD:webpage3:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0
FIELD:businessname:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0
FIELD:dba:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0
FIELD:businessid:TYPE(STRING):LIKE(Invalid_No):00,0
FIELD:businesstype1:TYPE(STRING):0,0
FIELD:businesslocation1:TYPE(STRING):0,0
FIELD:businesstype2:TYPE(STRING):0,0
FIELD:businesslocation2:TYPE(STRING):0,0
FIELD:businesstype3:TYPE(STRING):0,0
FIELD:businesslocation3:TYPE(STRING):0,0
FIELD:businesstype4:TYPE(STRING):0,0
FIELD:businesslocation4:TYPE(STRING):0,0
FIELD:businesstype5:TYPE(STRING):0,0
FIELD:businesslocation5:TYPE(STRING):0,0
FIELD:industry:TYPE(STRING):0,0
FIELD:trade:TYPE(STRING):0,0
FIELD:resourcedescription:TYPE(STRING):0,0
FIELD:natureofbusiness:TYPE(STRING):LIKE(Invalid_Alpha):00,0
FIELD:businessdescription:TYPE(STRING):LIKE(Invalid_AlphaChar):00,0
FIELD:businessstructure:TYPE(STRING):0,0
FIELD:totalemployees:TYPE(STRING):0,0
FIELD:avgcontractsize:TYPE(STRING):0,0
FIELD:firmid:TYPE(STRING):0,0
FIELD:firmlocationaddress:TYPE(STRING):0,0
FIELD:firmlocationaddresscity:TYPE(STRING):0,0
FIELD:firmlocationaddresszip4:TYPE(STRING):0,0
FIELD:firmlocationaddresszipcode:TYPE(STRING):0,0
FIELD:firmlocationcounty:TYPE(STRING):0,0
FIELD:firmlocationstate:TYPE(STRING):0,0
FIELD:certfed:TYPE(STRING):0,0
FIELD:certstate:TYPE(STRING):0,0
FIELD:contractsfederal:TYPE(STRING):0,0
FIELD:contractsva:TYPE(STRING):0,0
FIELD:contractscommercial:TYPE(STRING):0,0
FIELD:contractorgovernmentprime:TYPE(STRING):0,0
FIELD:contractorgovernmentsub:TYPE(STRING):0,0
FIELD:contractornongovernment:TYPE(STRING):0,0
FIELD:registeredgovernmentbus:TYPE(STRING):0,0
FIELD:registerednongovernmentbus:TYPE(STRING):0,0
FIELD:clearancelevelpersonnel:TYPE(STRING):0,0
FIELD:clearancelevelfacility:TYPE(STRING):0,0
FIELD:certificatedatefrom1:TYPE(STRING):LIKE(Invalid_Date):00,0
FIELD:certificatedateto1:TYPE(STRING):LIKE(Invalid_Future):0,0
FIELD:certificatestatus1:TYPE(STRING):0,0
FIELD:certificationnumber1:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0
FIELD:certificationtype1:TYPE(STRING):0,0
FIELD:certificatedatefrom2:TYPE(STRING):0,0
FIELD:certificatedateto2:TYPE(STRING):0,0
FIELD:certificatestatus2:TYPE(STRING):0,0
FIELD:certificationnumber2:TYPE(STRING):0,0
FIELD:certificationtype2:TYPE(STRING):0,0
FIELD:certificatedatefrom3:TYPE(STRING):0,0
FIELD:certificatedateto3:TYPE(STRING):0,0
FIELD:certificatestatus3:TYPE(STRING):0,0
FIELD:certificationnumber3:TYPE(STRING):0,0
FIELD:certificationtype3:TYPE(STRING):0,0
FIELD:certificatedatefrom4:TYPE(STRING):0,0
FIELD:certificatedateto4:TYPE(STRING):0,0
FIELD:certificatestatus4:TYPE(STRING):0,0
FIELD:certificationnumber4:TYPE(STRING):0,0
FIELD:certificationtype4:TYPE(STRING):0,0
FIELD:certificatedatefrom5:TYPE(STRING):0,0
FIELD:certificatedateto5:TYPE(STRING):0,0
FIELD:certificatestatus5:TYPE(STRING):0,0
FIELD:certificationnumber5:TYPE(STRING):0,0
FIELD:certificationtype5:TYPE(STRING):0,0
FIELD:certificatedatefrom6:TYPE(STRING):0,0
FIELD:certificatedateto6:TYPE(STRING):0,0
FIELD:certificatestatus6:TYPE(STRING):0,0
FIELD:certificationnumber6:TYPE(STRING):0,0
FIELD:certificationtype6:TYPE(STRING):0,0
FIELD:starrating:TYPE(STRING):0,0
FIELD:assets:TYPE(STRING):0,0
FIELD:biddescription:TYPE(STRING):0,0
FIELD:competitiveadvantage:TYPE(STRING):0,0
FIELD:cagecode:TYPE(STRING):0,0
FIELD:capabilitiesnarrative:TYPE(STRING):0,0
FIELD:category:TYPE(STRING):0,0
FIELD:chtrclass:TYPE(STRING):0,0
FIELD:productdescription1:TYPE(STRING):0,0
FIELD:productdescription2:TYPE(STRING):0,0
FIELD:productdescription3:TYPE(STRING):0,0
FIELD:productdescription4:TYPE(STRING):0,0
FIELD:productdescription5:TYPE(STRING):0,0
FIELD:classdescription1:TYPE(STRING):0,0
FIELD:subclassdescription1:TYPE(STRING):0,0
FIELD:classdescription2:TYPE(STRING):0,0
FIELD:subclassdescription2:TYPE(STRING):0,0
FIELD:classdescription3:TYPE(STRING):0,0
FIELD:subclassdescription3:TYPE(STRING):0,0
FIELD:classdescription4:TYPE(STRING):0,0
FIELD:subclassdescription4:TYPE(STRING):0,0
FIELD:classdescription5:TYPE(STRING):0,0
FIELD:subclassdescription5:TYPE(STRING):0,0
FIELD:classifications:TYPE(STRING):0,0
FIELD:commodity1:TYPE(STRING):0,0
FIELD:commodity2:TYPE(STRING):0,0
FIELD:commodity3:TYPE(STRING):0,0
FIELD:commodity4:TYPE(STRING):0,0
FIELD:commodity5:TYPE(STRING):0,0
FIELD:commodity6:TYPE(STRING):0,0
FIELD:commodity7:TYPE(STRING):0,0
FIELD:commodity8:TYPE(STRING):0,0
FIELD:completedate:TYPE(STRING):0,0
FIELD:crossreference:TYPE(STRING):0,0
FIELD:dateestablished:TYPE(STRING):0,0
FIELD:businessage:TYPE(STRING):0,0
FIELD:deposits:TYPE(STRING):0,0
FIELD:dunsnumber:TYPE(STRING):0,0
FIELD:enttype:TYPE(STRING):0,0
FIELD:expirationdate:TYPE(STRING):0,0
FIELD:extendeddate:TYPE(STRING):0,0
FIELD:issuingauthority:TYPE(STRING):0,0
FIELD:keywords:TYPE(STRING):0,0
FIELD:licensenumber:TYPE(STRING):0,0
FIELD:licensetype:TYPE(STRING):0,0
FIELD:mincd:TYPE(STRING):0,0
FIELD:minorityaffiliation:TYPE(STRING):0,0
FIELD:minorityownershipdate:TYPE(STRING):0,0
FIELD:siccode1:TYPE(STRING):0,0
FIELD:siccode2:TYPE(STRING):0,0
FIELD:siccode3:TYPE(STRING):0,0
FIELD:siccode4:TYPE(STRING):0,0
FIELD:siccode5:TYPE(STRING):0,0
FIELD:siccode6:TYPE(STRING):0,0
FIELD:siccode7:TYPE(STRING):0,0
FIELD:siccode8:TYPE(STRING):0,0
FIELD:naicscode1:TYPE(STRING):0,0
FIELD:naicscode2:TYPE(STRING):0,0
FIELD:naicscode3:TYPE(STRING):0,0
FIELD:naicscode4:TYPE(STRING):0,0
FIELD:naicscode5:TYPE(STRING):0,0
FIELD:naicscode6:TYPE(STRING):0,0
FIELD:naicscode7:TYPE(STRING):0,0
FIELD:naicscode8:TYPE(STRING):0,0
FIELD:prequalify:TYPE(STRING):0,0
FIELD:procurementcategory1:TYPE(STRING):0,0
FIELD:subprocurementcategory1:TYPE(STRING):0,0
FIELD:procurementcategory2:TYPE(STRING):0,0
FIELD:subprocurementcategory2:TYPE(STRING):0,0
FIELD:procurementcategory3:TYPE(STRING):0,0
FIELD:subprocurementcategory3:TYPE(STRING):0,0
FIELD:procurementcategory4:TYPE(STRING):0,0
FIELD:subprocurementcategory4:TYPE(STRING):0,0
FIELD:procurementcategory5:TYPE(STRING):0,0
FIELD:subprocurementcategory5:TYPE(STRING):0,0
FIELD:renewal:TYPE(STRING):0,0
FIELD:renewaldate:TYPE(STRING):0,0
FIELD:unitedcertprogrampartner:TYPE(STRING):0,0
FIELD:vendorkey:TYPE(STRING):0,0
FIELD:vendornumber:TYPE(STRING):0,0
FIELD:workcode1:TYPE(STRING):0,0
FIELD:workcode2:TYPE(STRING):0,0
FIELD:workcode3:TYPE(STRING):0,0
FIELD:workcode4:TYPE(STRING):0,0
FIELD:workcode5:TYPE(STRING):0,0
FIELD:workcode6:TYPE(STRING):0,0
FIELD:workcode7:TYPE(STRING):0,0
FIELD:workcode8:TYPE(STRING):0,0
FIELD:exporter:TYPE(STRING):0,0
FIELD:exportbusinessactivities:TYPE(STRING):0,0
FIELD:exportto:TYPE(STRING):0,0
FIELD:exportbusinessrelationships:TYPE(STRING):0,0
FIELD:exportobjectives:TYPE(STRING):0,0
FIELD:reference1:TYPE(STRING):0,0
FIELD:reference2:TYPE(STRING):0,0
FIELD:reference3:TYPE(STRING):0,0
 
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
 
