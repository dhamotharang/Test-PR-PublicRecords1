IMPORT SALT311,STD;
IMPORT Scrubs_Diversity_Certification,scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 205;
  EXPORT NumRulesFromFieldType := 205;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 203;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_Layout_Diversity_Certification)
    UNSIGNED1 dartid_Invalid;
    UNSIGNED1 dateadded_Invalid;
    UNSIGNED1 dateupdated_Invalid;
    UNSIGNED1 website_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 profilelastupdated_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 servicearea_Invalid;
    UNSIGNED1 region1_Invalid;
    UNSIGNED1 region2_Invalid;
    UNSIGNED1 region3_Invalid;
    UNSIGNED1 region4_Invalid;
    UNSIGNED1 region5_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 ethnicity_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 address2_Invalid;
    UNSIGNED1 addresscity_Invalid;
    UNSIGNED1 addressstate_Invalid;
    UNSIGNED1 addresszipcode_Invalid;
    UNSIGNED1 addresszip4_Invalid;
    UNSIGNED1 building_Invalid;
    UNSIGNED1 contact_Invalid;
    UNSIGNED1 phone1_Invalid;
    UNSIGNED1 phone2_Invalid;
    UNSIGNED1 phone3_Invalid;
    UNSIGNED1 cell_Invalid;
    UNSIGNED1 fax_Invalid;
    UNSIGNED1 email1_Invalid;
    UNSIGNED1 email2_Invalid;
    UNSIGNED1 email3_Invalid;
    UNSIGNED1 webpage1_Invalid;
    UNSIGNED1 webpage2_Invalid;
    UNSIGNED1 webpage3_Invalid;
    UNSIGNED1 businessname_Invalid;
    UNSIGNED1 dba_Invalid;
    UNSIGNED1 businessid_Invalid;
    UNSIGNED1 businesstype1_Invalid;
    UNSIGNED1 businesslocation1_Invalid;
    UNSIGNED1 businesstype2_Invalid;
    UNSIGNED1 businesslocation2_Invalid;
    UNSIGNED1 businesstype3_Invalid;
    UNSIGNED1 businesslocation3_Invalid;
    UNSIGNED1 businesstype4_Invalid;
    UNSIGNED1 businesslocation4_Invalid;
    UNSIGNED1 businesstype5_Invalid;
    UNSIGNED1 businesslocation5_Invalid;
    UNSIGNED1 industry_Invalid;
    UNSIGNED1 trade_Invalid;
    UNSIGNED1 resourcedescription_Invalid;
    UNSIGNED1 natureofbusiness_Invalid;
    UNSIGNED1 businessstructure_Invalid;
    UNSIGNED1 totalemployees_Invalid;
    UNSIGNED1 avgcontractsize_Invalid;
    UNSIGNED1 firmid_Invalid;
    UNSIGNED1 firmlocationaddress_Invalid;
    UNSIGNED1 firmlocationaddresscity_Invalid;
    UNSIGNED1 firmlocationaddresszip4_Invalid;
    UNSIGNED1 firmlocationaddresszipcode_Invalid;
    UNSIGNED1 firmlocationcounty_Invalid;
    UNSIGNED1 firmlocationstate_Invalid;
    UNSIGNED1 certfed_Invalid;
    UNSIGNED1 certstate_Invalid;
    UNSIGNED1 contractsfederal_Invalid;
    UNSIGNED1 contractsva_Invalid;
    UNSIGNED1 contractscommercial_Invalid;
    UNSIGNED1 contractorgovernmentprime_Invalid;
    UNSIGNED1 contractorgovernmentsub_Invalid;
    UNSIGNED1 contractornongovernment_Invalid;
    UNSIGNED1 registeredgovernmentbus_Invalid;
    UNSIGNED1 registerednongovernmentbus_Invalid;
    UNSIGNED1 clearancelevelpersonnel_Invalid;
    UNSIGNED1 clearancelevelfacility_Invalid;
    UNSIGNED1 certificatedatefrom1_Invalid;
    UNSIGNED1 certificatedateto1_Invalid;
    UNSIGNED1 certificatestatus1_Invalid;
    UNSIGNED1 certificationnumber1_Invalid;
    UNSIGNED1 certificationtype1_Invalid;
    UNSIGNED1 certificatedatefrom2_Invalid;
    UNSIGNED1 certificatedateto2_Invalid;
    UNSIGNED1 certificatestatus2_Invalid;
    UNSIGNED1 certificationnumber2_Invalid;
    UNSIGNED1 certificationtype2_Invalid;
    UNSIGNED1 certificatedatefrom3_Invalid;
    UNSIGNED1 certificatedateto3_Invalid;
    UNSIGNED1 certificatestatus3_Invalid;
    UNSIGNED1 certificationnumber3_Invalid;
    UNSIGNED1 certificationtype3_Invalid;
    UNSIGNED1 certificatedatefrom4_Invalid;
    UNSIGNED1 certificatedateto4_Invalid;
    UNSIGNED1 certificatestatus4_Invalid;
    UNSIGNED1 certificationnumber4_Invalid;
    UNSIGNED1 certificationtype4_Invalid;
    UNSIGNED1 certificatedatefrom5_Invalid;
    UNSIGNED1 certificatedateto5_Invalid;
    UNSIGNED1 certificatestatus5_Invalid;
    UNSIGNED1 certificationnumber5_Invalid;
    UNSIGNED1 certificationtype5_Invalid;
    UNSIGNED1 certificatedatefrom6_Invalid;
    UNSIGNED1 certificatedateto6_Invalid;
    UNSIGNED1 certificatestatus6_Invalid;
    UNSIGNED1 certificationnumber6_Invalid;
    UNSIGNED1 certificationtype6_Invalid;
    UNSIGNED1 starrating_Invalid;
    UNSIGNED1 assets_Invalid;
    UNSIGNED1 biddescription_Invalid;
    UNSIGNED1 competitiveadvantage_Invalid;
    UNSIGNED1 cagecode_Invalid;
    UNSIGNED1 capabilitiesnarrative_Invalid;
    UNSIGNED1 category_Invalid;
    UNSIGNED1 chtrclass_Invalid;
    UNSIGNED1 productdescription1_Invalid;
    UNSIGNED1 productdescription2_Invalid;
    UNSIGNED1 productdescription3_Invalid;
    UNSIGNED1 productdescription4_Invalid;
    UNSIGNED1 productdescription5_Invalid;
    UNSIGNED1 classdescription1_Invalid;
    UNSIGNED1 subclassdescription1_Invalid;
    UNSIGNED1 classdescription2_Invalid;
    UNSIGNED1 subclassdescription2_Invalid;
    UNSIGNED1 classdescription3_Invalid;
    UNSIGNED1 subclassdescription3_Invalid;
    UNSIGNED1 classdescription4_Invalid;
    UNSIGNED1 subclassdescription4_Invalid;
    UNSIGNED1 classdescription5_Invalid;
    UNSIGNED1 subclassdescription5_Invalid;
    UNSIGNED1 classifications_Invalid;
    UNSIGNED1 commodity1_Invalid;
    UNSIGNED1 commodity2_Invalid;
    UNSIGNED1 commodity3_Invalid;
    UNSIGNED1 commodity4_Invalid;
    UNSIGNED1 commodity5_Invalid;
    UNSIGNED1 commodity6_Invalid;
    UNSIGNED1 commodity7_Invalid;
    UNSIGNED1 commodity8_Invalid;
    UNSIGNED1 completedate_Invalid;
    UNSIGNED1 crossreference_Invalid;
    UNSIGNED1 dateestablished_Invalid;
    UNSIGNED1 businessage_Invalid;
    UNSIGNED1 deposits_Invalid;
    UNSIGNED1 dunsnumber_Invalid;
    UNSIGNED1 enttype_Invalid;
    UNSIGNED1 expirationdate_Invalid;
    UNSIGNED1 extendeddate_Invalid;
    UNSIGNED1 issuingauthority_Invalid;
    UNSIGNED1 keywords_Invalid;
    UNSIGNED1 licensenumber_Invalid;
    UNSIGNED1 licensetype_Invalid;
    UNSIGNED1 mincd_Invalid;
    UNSIGNED1 minorityaffiliation_Invalid;
    UNSIGNED1 minorityownershipdate_Invalid;
    UNSIGNED1 siccode1_Invalid;
    UNSIGNED1 siccode2_Invalid;
    UNSIGNED1 siccode3_Invalid;
    UNSIGNED1 siccode4_Invalid;
    UNSIGNED1 siccode5_Invalid;
    UNSIGNED1 siccode6_Invalid;
    UNSIGNED1 siccode7_Invalid;
    UNSIGNED1 siccode8_Invalid;
    UNSIGNED1 naicscode1_Invalid;
    UNSIGNED1 naicscode2_Invalid;
    UNSIGNED1 naicscode3_Invalid;
    UNSIGNED1 naicscode4_Invalid;
    UNSIGNED1 naicscode5_Invalid;
    UNSIGNED1 naicscode6_Invalid;
    UNSIGNED1 naicscode7_Invalid;
    UNSIGNED1 naicscode8_Invalid;
    UNSIGNED1 prequalify_Invalid;
    UNSIGNED1 procurementcategory1_Invalid;
    UNSIGNED1 subprocurementcategory1_Invalid;
    UNSIGNED1 procurementcategory2_Invalid;
    UNSIGNED1 subprocurementcategory2_Invalid;
    UNSIGNED1 procurementcategory3_Invalid;
    UNSIGNED1 subprocurementcategory3_Invalid;
    UNSIGNED1 procurementcategory4_Invalid;
    UNSIGNED1 subprocurementcategory4_Invalid;
    UNSIGNED1 procurementcategory5_Invalid;
    UNSIGNED1 subprocurementcategory5_Invalid;
    UNSIGNED1 renewal_Invalid;
    UNSIGNED1 renewaldate_Invalid;
    UNSIGNED1 unitedcertprogrampartner_Invalid;
    UNSIGNED1 vendorkey_Invalid;
    UNSIGNED1 vendornumber_Invalid;
    UNSIGNED1 workcode1_Invalid;
    UNSIGNED1 workcode2_Invalid;
    UNSIGNED1 workcode3_Invalid;
    UNSIGNED1 workcode4_Invalid;
    UNSIGNED1 workcode5_Invalid;
    UNSIGNED1 workcode6_Invalid;
    UNSIGNED1 workcode7_Invalid;
    UNSIGNED1 workcode8_Invalid;
    UNSIGNED1 exporter_Invalid;
    UNSIGNED1 exportbusinessactivities_Invalid;
    UNSIGNED1 exportto_Invalid;
    UNSIGNED1 exportbusinessrelationships_Invalid;
    UNSIGNED1 exportobjectives_Invalid;
    UNSIGNED1 reference1_Invalid;
    UNSIGNED1 reference2_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_Diversity_Certification)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
  END;
  EXPORT Rule_Layout := RECORD(Input_Layout_Diversity_Certification)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dartid:Invalid_No:ALLOW'
          ,'dateadded:Invalid_Date:CUSTOM'
          ,'dateupdated:Invalid_Date:CUSTOM'
          ,'website:Invalid_AlphaNumChar:ALLOW'
          ,'state:Invalid_State:CUSTOM'
          ,'profilelastupdated:Invalid_Date:CUSTOM'
          ,'county:Invalid_AlphaNumChar:ALLOW'
          ,'servicearea:Invalid_Alpha:ALLOW'
          ,'region1:Invalid_AlphaNumChar:ALLOW'
          ,'region2:Invalid_AlphaNumChar:ALLOW'
          ,'region3:Invalid_AlphaNumChar:ALLOW'
          ,'region4:Invalid_AlphaNumChar:ALLOW'
          ,'region5:Invalid_AlphaNumChar:ALLOW'
          ,'fname:Invalid_AlphaChar:ALLOW'
          ,'lname:Invalid_AlphaChar:ALLOW'
          ,'mname:Invalid_AlphaChar:ALLOW'
          ,'suffix:Invalid_Alpha:ALLOW'
          ,'title:Invalid_AlphaChar:ALLOW'
          ,'ethnicity:Invalid_AlphaChar:ALLOW'
          ,'gender:Invalid_Alpha:ALLOW'
          ,'address1:Invalid_AlphaNumChar:ALLOW'
          ,'address2:Invalid_AlphaNum:ALLOW'
          ,'addresscity:Invalid_Alpha:ALLOW'
          ,'addressstate:Invalid_State:CUSTOM'
          ,'addresszipcode:Invalid_Zip:ALLOW','addresszipcode:Invalid_Zip:LENGTHS'
          ,'addresszip4:Invalid_No:ALLOW'
          ,'building:Invalid_Alpha:ALLOW'
          ,'contact:Invalid_Alpha:ALLOW'
          ,'phone1:Invalid_Phone:CUSTOM'
          ,'phone2:Invalid_Phone:CUSTOM'
          ,'phone3:Invalid_Phone:CUSTOM'
          ,'cell:Invalid_Phone:CUSTOM'
          ,'fax:Invalid_Phone:CUSTOM'
          ,'email1:Invalid_AlphaNumChar:ALLOW'
          ,'email2:Invalid_AlphaNumChar:ALLOW'
          ,'email3:Invalid_AlphaNumChar:ALLOW'
          ,'webpage1:Invalid_AlphaNumChar:ALLOW'
          ,'webpage2:Invalid_AlphaNumChar:ALLOW'
          ,'webpage3:Invalid_AlphaNumChar:ALLOW'
          ,'businessname:Invalid_AlphaNumChar:ALLOW'
          ,'dba:Invalid_AlphaNumChar:ALLOW'
          ,'businessid:Invalid_Float:ALLOW'
          ,'businesstype1:Invalid_Alpha:ALLOW'
          ,'businesslocation1:Invalid_Alpha:ALLOW'
          ,'businesstype2:Invalid_Alpha:ALLOW'
          ,'businesslocation2:Invalid_Alpha:ALLOW'
          ,'businesstype3:Invalid_Alpha:ALLOW'
          ,'businesslocation3:Invalid_Alpha:ALLOW'
          ,'businesstype4:Invalid_Alpha:ALLOW'
          ,'businesslocation4:Invalid_Alpha:ALLOW'
          ,'businesstype5:Invalid_Alpha:ALLOW'
          ,'businesslocation5:Invalid_Alpha:ALLOW'
          ,'industry:Invalid_AlphaChar:ALLOW'
          ,'trade:Invalid_Alpha:ALLOW'
          ,'resourcedescription:Invalid_Alpha:ALLOW'
          ,'natureofbusiness:Invalid_AlphaChar:ALLOW'
          ,'businessstructure:Invalid_Alpha:ALLOW'
          ,'totalemployees:Invalid_Alpha:ALLOW'
          ,'avgcontractsize:Invalid_AlphaNum:ALLOW'
          ,'firmid:Invalid_No:ALLOW'
          ,'firmlocationaddress:Invalid_AlphaNumChar:ALLOW'
          ,'firmlocationaddresscity:Invalid_Alpha:ALLOW'
          ,'firmlocationaddresszip4:Invalid_No:ALLOW'
          ,'firmlocationaddresszipcode:Invalid_Zip:ALLOW','firmlocationaddresszipcode:Invalid_Zip:LENGTHS'
          ,'firmlocationcounty:Invalid_Alpha:ALLOW'
          ,'firmlocationstate:Invalid_State:CUSTOM'
          ,'certfed:Invalid_Alpha:ALLOW'
          ,'certstate:Invalid_State:CUSTOM'
          ,'contractsfederal:Invalid_Alpha:ALLOW'
          ,'contractsva:Invalid_Alpha:ALLOW'
          ,'contractscommercial:Invalid_Alpha:ALLOW'
          ,'contractorgovernmentprime:Invalid_Alpha:ALLOW'
          ,'contractorgovernmentsub:Invalid_Alpha:ALLOW'
          ,'contractornongovernment:Invalid_Alpha:ALLOW'
          ,'registeredgovernmentbus:Invalid_Alpha:ALLOW'
          ,'registerednongovernmentbus:Invalid_Alpha:ALLOW'
          ,'clearancelevelpersonnel:Invalid_Alpha:ALLOW'
          ,'clearancelevelfacility:Invalid_Alpha:ALLOW'
          ,'certificatedatefrom1:Invalid_Date:CUSTOM'
          ,'certificatedateto1:Invalid_Future:CUSTOM'
          ,'certificatestatus1:Invalid_Alpha:ALLOW'
          ,'certificationnumber1:Invalid_Float:ALLOW'
          ,'certificationtype1:Invalid_AlphaChar:ALLOW'
          ,'certificatedatefrom2:Invalid_Date:CUSTOM'
          ,'certificatedateto2:Invalid_Future:CUSTOM'
          ,'certificatestatus2:Invalid_Alpha:ALLOW'
          ,'certificationnumber2:Invalid_Float:ALLOW'
          ,'certificationtype2:Invalid_AlphaChar:ALLOW'
          ,'certificatedatefrom3:Invalid_Date:CUSTOM'
          ,'certificatedateto3:Invalid_Future:CUSTOM'
          ,'certificatestatus3:Invalid_Alpha:ALLOW'
          ,'certificationnumber3:Invalid_Float:ALLOW'
          ,'certificationtype3:Invalid_AlphaChar:ALLOW'
          ,'certificatedatefrom4:Invalid_Date:CUSTOM'
          ,'certificatedateto4:Invalid_Future:CUSTOM'
          ,'certificatestatus4:Invalid_Alpha:ALLOW'
          ,'certificationnumber4:Invalid_Float:ALLOW'
          ,'certificationtype4:Invalid_AlphaChar:ALLOW'
          ,'certificatedatefrom5:Invalid_Date:CUSTOM'
          ,'certificatedateto5:Invalid_Future:CUSTOM'
          ,'certificatestatus5:Invalid_Alpha:ALLOW'
          ,'certificationnumber5:Invalid_Float:ALLOW'
          ,'certificationtype5:Invalid_AlphaChar:ALLOW'
          ,'certificatedatefrom6:Invalid_Date:CUSTOM'
          ,'certificatedateto6:Invalid_Future:CUSTOM'
          ,'certificatestatus6:Invalid_Alpha:ALLOW'
          ,'certificationnumber6:Invalid_Float:ALLOW'
          ,'certificationtype6:Invalid_AlphaChar:ALLOW'
          ,'starrating:Invalid_No:ALLOW'
          ,'assets:Invalid_Float:ALLOW'
          ,'biddescription:Invalid_AlphaChar:ALLOW'
          ,'competitiveadvantage:Invalid_Alpha:ALLOW'
          ,'cagecode:Invalid_No:ALLOW'
          ,'capabilitiesnarrative:Invalid_Alpha:ALLOW'
          ,'category:Invalid_Alpha:ALLOW'
          ,'chtrclass:Invalid_Alpha:ALLOW'
          ,'productdescription1:Invalid_Alpha:ALLOW'
          ,'productdescription2:Invalid_Alpha:ALLOW'
          ,'productdescription3:Invalid_Alpha:ALLOW'
          ,'productdescription4:Invalid_Alpha:ALLOW'
          ,'productdescription5:Invalid_Alpha:ALLOW'
          ,'classdescription1:Invalid_Alpha:ALLOW'
          ,'subclassdescription1:Invalid_Alpha:ALLOW'
          ,'classdescription2:Invalid_Alpha:ALLOW'
          ,'subclassdescription2:Invalid_Alpha:ALLOW'
          ,'classdescription3:Invalid_Alpha:ALLOW'
          ,'subclassdescription3:Invalid_Alpha:ALLOW'
          ,'classdescription4:Invalid_Alpha:ALLOW'
          ,'subclassdescription4:Invalid_Alpha:ALLOW'
          ,'classdescription5:Invalid_Alpha:ALLOW'
          ,'subclassdescription5:Invalid_Alpha:ALLOW'
          ,'classifications:Invalid_Alpha:ALLOW'
          ,'commodity1:Invalid_Commodity:CUSTOM'
          ,'commodity2:Invalid_Commodity:CUSTOM'
          ,'commodity3:Invalid_Commodity:CUSTOM'
          ,'commodity4:Invalid_Commodity:CUSTOM'
          ,'commodity5:Invalid_Commodity:CUSTOM'
          ,'commodity6:Invalid_Commodity:CUSTOM'
          ,'commodity7:Invalid_Commodity:CUSTOM'
          ,'commodity8:Invalid_Commodity:CUSTOM'
          ,'completedate:Invalid_Date:CUSTOM'
          ,'crossreference:Invalid_Alpha:ALLOW'
          ,'dateestablished:Invalid_Date:CUSTOM'
          ,'businessage:Invalid_No:ALLOW'
          ,'deposits:Invalid_No:ALLOW'
          ,'dunsnumber:Invalid_No:ALLOW'
          ,'enttype:Invalid_Alpha:ALLOW'
          ,'expirationdate:Invalid_Future:CUSTOM'
          ,'extendeddate:Invalid_Future:CUSTOM'
          ,'issuingauthority:Invalid_AlphaChar:ALLOW'
          ,'keywords:Invalid_Alpha:ALLOW'
          ,'licensenumber:Invalid_AlphaNum:ALLOW'
          ,'licensetype:Invalid_Alpha:ALLOW'
          ,'mincd:Invalid_No:ALLOW'
          ,'minorityaffiliation:Invalid_Alpha:ALLOW'
          ,'minorityownershipdate:Invalid_Date:CUSTOM'
          ,'siccode1:Invalid_Sic:CUSTOM'
          ,'siccode2:Invalid_Sic:CUSTOM'
          ,'siccode3:Invalid_Sic:CUSTOM'
          ,'siccode4:Invalid_Sic:CUSTOM'
          ,'siccode5:Invalid_Sic:CUSTOM'
          ,'siccode6:Invalid_Sic:CUSTOM'
          ,'siccode7:Invalid_Sic:CUSTOM'
          ,'siccode8:Invalid_Sic:CUSTOM'
          ,'naicscode1:Invalid_NAICS:CUSTOM'
          ,'naicscode2:Invalid_NAICS:CUSTOM'
          ,'naicscode3:Invalid_NAICS:CUSTOM'
          ,'naicscode4:Invalid_NAICS:CUSTOM'
          ,'naicscode5:Invalid_NAICS:CUSTOM'
          ,'naicscode6:Invalid_NAICS:CUSTOM'
          ,'naicscode7:Invalid_NAICS:CUSTOM'
          ,'naicscode8:Invalid_NAICS:CUSTOM'
          ,'prequalify:Invalid_Alpha:ALLOW'
          ,'procurementcategory1:Invalid_Alpha:ALLOW'
          ,'subprocurementcategory1:Invalid_Alpha:ALLOW'
          ,'procurementcategory2:Invalid_Alpha:ALLOW'
          ,'subprocurementcategory2:Invalid_Alpha:ALLOW'
          ,'procurementcategory3:Invalid_Alpha:ALLOW'
          ,'subprocurementcategory3:Invalid_Alpha:ALLOW'
          ,'procurementcategory4:Invalid_Alpha:ALLOW'
          ,'subprocurementcategory4:Invalid_Alpha:ALLOW'
          ,'procurementcategory5:Invalid_Alpha:ALLOW'
          ,'subprocurementcategory5:Invalid_Alpha:ALLOW'
          ,'renewal:Invalid_Alpha:ALLOW'
          ,'renewaldate:Invalid_Future:CUSTOM'
          ,'unitedcertprogrampartner:Invalid_Alpha:ALLOW'
          ,'vendorkey:Invalid_No:ALLOW'
          ,'vendornumber:Invalid_No:ALLOW'
          ,'workcode1:Invalid_AlphaNum:ALLOW'
          ,'workcode2:Invalid_AlphaNum:ALLOW'
          ,'workcode3:Invalid_AlphaNum:ALLOW'
          ,'workcode4:Invalid_AlphaNum:ALLOW'
          ,'workcode5:Invalid_AlphaNum:ALLOW'
          ,'workcode6:Invalid_AlphaNum:ALLOW'
          ,'workcode7:Invalid_AlphaNum:ALLOW'
          ,'workcode8:Invalid_AlphaNum:ALLOW'
          ,'exporter:Invalid_Alpha:ALLOW'
          ,'exportbusinessactivities:Invalid_Alpha:ALLOW'
          ,'exportto:Invalid_Alpha:ALLOW'
          ,'exportbusinessrelationships:Invalid_Alpha:ALLOW'
          ,'exportobjectives:Invalid_Alpha:ALLOW'
          ,'reference1:Invalid_AlphaNum:ALLOW'
          ,'reference2:Invalid_AlphaNum:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Input_Fields.InvalidMessage_dartid(1)
          ,Input_Fields.InvalidMessage_dateadded(1)
          ,Input_Fields.InvalidMessage_dateupdated(1)
          ,Input_Fields.InvalidMessage_website(1)
          ,Input_Fields.InvalidMessage_state(1)
          ,Input_Fields.InvalidMessage_profilelastupdated(1)
          ,Input_Fields.InvalidMessage_county(1)
          ,Input_Fields.InvalidMessage_servicearea(1)
          ,Input_Fields.InvalidMessage_region1(1)
          ,Input_Fields.InvalidMessage_region2(1)
          ,Input_Fields.InvalidMessage_region3(1)
          ,Input_Fields.InvalidMessage_region4(1)
          ,Input_Fields.InvalidMessage_region5(1)
          ,Input_Fields.InvalidMessage_fname(1)
          ,Input_Fields.InvalidMessage_lname(1)
          ,Input_Fields.InvalidMessage_mname(1)
          ,Input_Fields.InvalidMessage_suffix(1)
          ,Input_Fields.InvalidMessage_title(1)
          ,Input_Fields.InvalidMessage_ethnicity(1)
          ,Input_Fields.InvalidMessage_gender(1)
          ,Input_Fields.InvalidMessage_address1(1)
          ,Input_Fields.InvalidMessage_address2(1)
          ,Input_Fields.InvalidMessage_addresscity(1)
          ,Input_Fields.InvalidMessage_addressstate(1)
          ,Input_Fields.InvalidMessage_addresszipcode(1),Input_Fields.InvalidMessage_addresszipcode(2)
          ,Input_Fields.InvalidMessage_addresszip4(1)
          ,Input_Fields.InvalidMessage_building(1)
          ,Input_Fields.InvalidMessage_contact(1)
          ,Input_Fields.InvalidMessage_phone1(1)
          ,Input_Fields.InvalidMessage_phone2(1)
          ,Input_Fields.InvalidMessage_phone3(1)
          ,Input_Fields.InvalidMessage_cell(1)
          ,Input_Fields.InvalidMessage_fax(1)
          ,Input_Fields.InvalidMessage_email1(1)
          ,Input_Fields.InvalidMessage_email2(1)
          ,Input_Fields.InvalidMessage_email3(1)
          ,Input_Fields.InvalidMessage_webpage1(1)
          ,Input_Fields.InvalidMessage_webpage2(1)
          ,Input_Fields.InvalidMessage_webpage3(1)
          ,Input_Fields.InvalidMessage_businessname(1)
          ,Input_Fields.InvalidMessage_dba(1)
          ,Input_Fields.InvalidMessage_businessid(1)
          ,Input_Fields.InvalidMessage_businesstype1(1)
          ,Input_Fields.InvalidMessage_businesslocation1(1)
          ,Input_Fields.InvalidMessage_businesstype2(1)
          ,Input_Fields.InvalidMessage_businesslocation2(1)
          ,Input_Fields.InvalidMessage_businesstype3(1)
          ,Input_Fields.InvalidMessage_businesslocation3(1)
          ,Input_Fields.InvalidMessage_businesstype4(1)
          ,Input_Fields.InvalidMessage_businesslocation4(1)
          ,Input_Fields.InvalidMessage_businesstype5(1)
          ,Input_Fields.InvalidMessage_businesslocation5(1)
          ,Input_Fields.InvalidMessage_industry(1)
          ,Input_Fields.InvalidMessage_trade(1)
          ,Input_Fields.InvalidMessage_resourcedescription(1)
          ,Input_Fields.InvalidMessage_natureofbusiness(1)
          ,Input_Fields.InvalidMessage_businessstructure(1)
          ,Input_Fields.InvalidMessage_totalemployees(1)
          ,Input_Fields.InvalidMessage_avgcontractsize(1)
          ,Input_Fields.InvalidMessage_firmid(1)
          ,Input_Fields.InvalidMessage_firmlocationaddress(1)
          ,Input_Fields.InvalidMessage_firmlocationaddresscity(1)
          ,Input_Fields.InvalidMessage_firmlocationaddresszip4(1)
          ,Input_Fields.InvalidMessage_firmlocationaddresszipcode(1),Input_Fields.InvalidMessage_firmlocationaddresszipcode(2)
          ,Input_Fields.InvalidMessage_firmlocationcounty(1)
          ,Input_Fields.InvalidMessage_firmlocationstate(1)
          ,Input_Fields.InvalidMessage_certfed(1)
          ,Input_Fields.InvalidMessage_certstate(1)
          ,Input_Fields.InvalidMessage_contractsfederal(1)
          ,Input_Fields.InvalidMessage_contractsva(1)
          ,Input_Fields.InvalidMessage_contractscommercial(1)
          ,Input_Fields.InvalidMessage_contractorgovernmentprime(1)
          ,Input_Fields.InvalidMessage_contractorgovernmentsub(1)
          ,Input_Fields.InvalidMessage_contractornongovernment(1)
          ,Input_Fields.InvalidMessage_registeredgovernmentbus(1)
          ,Input_Fields.InvalidMessage_registerednongovernmentbus(1)
          ,Input_Fields.InvalidMessage_clearancelevelpersonnel(1)
          ,Input_Fields.InvalidMessage_clearancelevelfacility(1)
          ,Input_Fields.InvalidMessage_certificatedatefrom1(1)
          ,Input_Fields.InvalidMessage_certificatedateto1(1)
          ,Input_Fields.InvalidMessage_certificatestatus1(1)
          ,Input_Fields.InvalidMessage_certificationnumber1(1)
          ,Input_Fields.InvalidMessage_certificationtype1(1)
          ,Input_Fields.InvalidMessage_certificatedatefrom2(1)
          ,Input_Fields.InvalidMessage_certificatedateto2(1)
          ,Input_Fields.InvalidMessage_certificatestatus2(1)
          ,Input_Fields.InvalidMessage_certificationnumber2(1)
          ,Input_Fields.InvalidMessage_certificationtype2(1)
          ,Input_Fields.InvalidMessage_certificatedatefrom3(1)
          ,Input_Fields.InvalidMessage_certificatedateto3(1)
          ,Input_Fields.InvalidMessage_certificatestatus3(1)
          ,Input_Fields.InvalidMessage_certificationnumber3(1)
          ,Input_Fields.InvalidMessage_certificationtype3(1)
          ,Input_Fields.InvalidMessage_certificatedatefrom4(1)
          ,Input_Fields.InvalidMessage_certificatedateto4(1)
          ,Input_Fields.InvalidMessage_certificatestatus4(1)
          ,Input_Fields.InvalidMessage_certificationnumber4(1)
          ,Input_Fields.InvalidMessage_certificationtype4(1)
          ,Input_Fields.InvalidMessage_certificatedatefrom5(1)
          ,Input_Fields.InvalidMessage_certificatedateto5(1)
          ,Input_Fields.InvalidMessage_certificatestatus5(1)
          ,Input_Fields.InvalidMessage_certificationnumber5(1)
          ,Input_Fields.InvalidMessage_certificationtype5(1)
          ,Input_Fields.InvalidMessage_certificatedatefrom6(1)
          ,Input_Fields.InvalidMessage_certificatedateto6(1)
          ,Input_Fields.InvalidMessage_certificatestatus6(1)
          ,Input_Fields.InvalidMessage_certificationnumber6(1)
          ,Input_Fields.InvalidMessage_certificationtype6(1)
          ,Input_Fields.InvalidMessage_starrating(1)
          ,Input_Fields.InvalidMessage_assets(1)
          ,Input_Fields.InvalidMessage_biddescription(1)
          ,Input_Fields.InvalidMessage_competitiveadvantage(1)
          ,Input_Fields.InvalidMessage_cagecode(1)
          ,Input_Fields.InvalidMessage_capabilitiesnarrative(1)
          ,Input_Fields.InvalidMessage_category(1)
          ,Input_Fields.InvalidMessage_chtrclass(1)
          ,Input_Fields.InvalidMessage_productdescription1(1)
          ,Input_Fields.InvalidMessage_productdescription2(1)
          ,Input_Fields.InvalidMessage_productdescription3(1)
          ,Input_Fields.InvalidMessage_productdescription4(1)
          ,Input_Fields.InvalidMessage_productdescription5(1)
          ,Input_Fields.InvalidMessage_classdescription1(1)
          ,Input_Fields.InvalidMessage_subclassdescription1(1)
          ,Input_Fields.InvalidMessage_classdescription2(1)
          ,Input_Fields.InvalidMessage_subclassdescription2(1)
          ,Input_Fields.InvalidMessage_classdescription3(1)
          ,Input_Fields.InvalidMessage_subclassdescription3(1)
          ,Input_Fields.InvalidMessage_classdescription4(1)
          ,Input_Fields.InvalidMessage_subclassdescription4(1)
          ,Input_Fields.InvalidMessage_classdescription5(1)
          ,Input_Fields.InvalidMessage_subclassdescription5(1)
          ,Input_Fields.InvalidMessage_classifications(1)
          ,Input_Fields.InvalidMessage_commodity1(1)
          ,Input_Fields.InvalidMessage_commodity2(1)
          ,Input_Fields.InvalidMessage_commodity3(1)
          ,Input_Fields.InvalidMessage_commodity4(1)
          ,Input_Fields.InvalidMessage_commodity5(1)
          ,Input_Fields.InvalidMessage_commodity6(1)
          ,Input_Fields.InvalidMessage_commodity7(1)
          ,Input_Fields.InvalidMessage_commodity8(1)
          ,Input_Fields.InvalidMessage_completedate(1)
          ,Input_Fields.InvalidMessage_crossreference(1)
          ,Input_Fields.InvalidMessage_dateestablished(1)
          ,Input_Fields.InvalidMessage_businessage(1)
          ,Input_Fields.InvalidMessage_deposits(1)
          ,Input_Fields.InvalidMessage_dunsnumber(1)
          ,Input_Fields.InvalidMessage_enttype(1)
          ,Input_Fields.InvalidMessage_expirationdate(1)
          ,Input_Fields.InvalidMessage_extendeddate(1)
          ,Input_Fields.InvalidMessage_issuingauthority(1)
          ,Input_Fields.InvalidMessage_keywords(1)
          ,Input_Fields.InvalidMessage_licensenumber(1)
          ,Input_Fields.InvalidMessage_licensetype(1)
          ,Input_Fields.InvalidMessage_mincd(1)
          ,Input_Fields.InvalidMessage_minorityaffiliation(1)
          ,Input_Fields.InvalidMessage_minorityownershipdate(1)
          ,Input_Fields.InvalidMessage_siccode1(1)
          ,Input_Fields.InvalidMessage_siccode2(1)
          ,Input_Fields.InvalidMessage_siccode3(1)
          ,Input_Fields.InvalidMessage_siccode4(1)
          ,Input_Fields.InvalidMessage_siccode5(1)
          ,Input_Fields.InvalidMessage_siccode6(1)
          ,Input_Fields.InvalidMessage_siccode7(1)
          ,Input_Fields.InvalidMessage_siccode8(1)
          ,Input_Fields.InvalidMessage_naicscode1(1)
          ,Input_Fields.InvalidMessage_naicscode2(1)
          ,Input_Fields.InvalidMessage_naicscode3(1)
          ,Input_Fields.InvalidMessage_naicscode4(1)
          ,Input_Fields.InvalidMessage_naicscode5(1)
          ,Input_Fields.InvalidMessage_naicscode6(1)
          ,Input_Fields.InvalidMessage_naicscode7(1)
          ,Input_Fields.InvalidMessage_naicscode8(1)
          ,Input_Fields.InvalidMessage_prequalify(1)
          ,Input_Fields.InvalidMessage_procurementcategory1(1)
          ,Input_Fields.InvalidMessage_subprocurementcategory1(1)
          ,Input_Fields.InvalidMessage_procurementcategory2(1)
          ,Input_Fields.InvalidMessage_subprocurementcategory2(1)
          ,Input_Fields.InvalidMessage_procurementcategory3(1)
          ,Input_Fields.InvalidMessage_subprocurementcategory3(1)
          ,Input_Fields.InvalidMessage_procurementcategory4(1)
          ,Input_Fields.InvalidMessage_subprocurementcategory4(1)
          ,Input_Fields.InvalidMessage_procurementcategory5(1)
          ,Input_Fields.InvalidMessage_subprocurementcategory5(1)
          ,Input_Fields.InvalidMessage_renewal(1)
          ,Input_Fields.InvalidMessage_renewaldate(1)
          ,Input_Fields.InvalidMessage_unitedcertprogrampartner(1)
          ,Input_Fields.InvalidMessage_vendorkey(1)
          ,Input_Fields.InvalidMessage_vendornumber(1)
          ,Input_Fields.InvalidMessage_workcode1(1)
          ,Input_Fields.InvalidMessage_workcode2(1)
          ,Input_Fields.InvalidMessage_workcode3(1)
          ,Input_Fields.InvalidMessage_workcode4(1)
          ,Input_Fields.InvalidMessage_workcode5(1)
          ,Input_Fields.InvalidMessage_workcode6(1)
          ,Input_Fields.InvalidMessage_workcode7(1)
          ,Input_Fields.InvalidMessage_workcode8(1)
          ,Input_Fields.InvalidMessage_exporter(1)
          ,Input_Fields.InvalidMessage_exportbusinessactivities(1)
          ,Input_Fields.InvalidMessage_exportto(1)
          ,Input_Fields.InvalidMessage_exportbusinessrelationships(1)
          ,Input_Fields.InvalidMessage_exportobjectives(1)
          ,Input_Fields.InvalidMessage_reference1(1)
          ,Input_Fields.InvalidMessage_reference2(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Input_Layout_Diversity_Certification) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dartid_Invalid := Input_Fields.InValid_dartid((SALT311.StrType)le.dartid);
    SELF.dateadded_Invalid := Input_Fields.InValid_dateadded((SALT311.StrType)le.dateadded);
    SELF.dateupdated_Invalid := Input_Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated);
    SELF.website_Invalid := Input_Fields.InValid_website((SALT311.StrType)le.website);
    SELF.state_Invalid := Input_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.profilelastupdated_Invalid := Input_Fields.InValid_profilelastupdated((SALT311.StrType)le.profilelastupdated);
    SELF.county_Invalid := Input_Fields.InValid_county((SALT311.StrType)le.county);
    SELF.servicearea_Invalid := Input_Fields.InValid_servicearea((SALT311.StrType)le.servicearea);
    SELF.region1_Invalid := Input_Fields.InValid_region1((SALT311.StrType)le.region1);
    SELF.region2_Invalid := Input_Fields.InValid_region2((SALT311.StrType)le.region2);
    SELF.region3_Invalid := Input_Fields.InValid_region3((SALT311.StrType)le.region3);
    SELF.region4_Invalid := Input_Fields.InValid_region4((SALT311.StrType)le.region4);
    SELF.region5_Invalid := Input_Fields.InValid_region5((SALT311.StrType)le.region5);
    SELF.fname_Invalid := Input_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.lname_Invalid := Input_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.mname_Invalid := Input_Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.suffix_Invalid := Input_Fields.InValid_suffix((SALT311.StrType)le.suffix);
    SELF.title_Invalid := Input_Fields.InValid_title((SALT311.StrType)le.title);
    SELF.ethnicity_Invalid := Input_Fields.InValid_ethnicity((SALT311.StrType)le.ethnicity);
    SELF.gender_Invalid := Input_Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.address1_Invalid := Input_Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.address2_Invalid := Input_Fields.InValid_address2((SALT311.StrType)le.address2);
    SELF.addresscity_Invalid := Input_Fields.InValid_addresscity((SALT311.StrType)le.addresscity);
    SELF.addressstate_Invalid := Input_Fields.InValid_addressstate((SALT311.StrType)le.addressstate);
    SELF.addresszipcode_Invalid := Input_Fields.InValid_addresszipcode((SALT311.StrType)le.addresszipcode);
    SELF.addresszip4_Invalid := Input_Fields.InValid_addresszip4((SALT311.StrType)le.addresszip4);
    SELF.building_Invalid := Input_Fields.InValid_building((SALT311.StrType)le.building);
    SELF.contact_Invalid := Input_Fields.InValid_contact((SALT311.StrType)le.contact);
    SELF.phone1_Invalid := Input_Fields.InValid_phone1((SALT311.StrType)le.phone1);
    SELF.phone2_Invalid := Input_Fields.InValid_phone2((SALT311.StrType)le.phone2);
    SELF.phone3_Invalid := Input_Fields.InValid_phone3((SALT311.StrType)le.phone3);
    SELF.cell_Invalid := Input_Fields.InValid_cell((SALT311.StrType)le.cell);
    SELF.fax_Invalid := Input_Fields.InValid_fax((SALT311.StrType)le.fax);
    SELF.email1_Invalid := Input_Fields.InValid_email1((SALT311.StrType)le.email1);
    SELF.email2_Invalid := Input_Fields.InValid_email2((SALT311.StrType)le.email2);
    SELF.email3_Invalid := Input_Fields.InValid_email3((SALT311.StrType)le.email3);
    SELF.webpage1_Invalid := Input_Fields.InValid_webpage1((SALT311.StrType)le.webpage1);
    SELF.webpage2_Invalid := Input_Fields.InValid_webpage2((SALT311.StrType)le.webpage2);
    SELF.webpage3_Invalid := Input_Fields.InValid_webpage3((SALT311.StrType)le.webpage3);
    SELF.businessname_Invalid := Input_Fields.InValid_businessname((SALT311.StrType)le.businessname);
    SELF.dba_Invalid := Input_Fields.InValid_dba((SALT311.StrType)le.dba);
    SELF.businessid_Invalid := Input_Fields.InValid_businessid((SALT311.StrType)le.businessid);
    SELF.businesstype1_Invalid := Input_Fields.InValid_businesstype1((SALT311.StrType)le.businesstype1);
    SELF.businesslocation1_Invalid := Input_Fields.InValid_businesslocation1((SALT311.StrType)le.businesslocation1);
    SELF.businesstype2_Invalid := Input_Fields.InValid_businesstype2((SALT311.StrType)le.businesstype2);
    SELF.businesslocation2_Invalid := Input_Fields.InValid_businesslocation2((SALT311.StrType)le.businesslocation2);
    SELF.businesstype3_Invalid := Input_Fields.InValid_businesstype3((SALT311.StrType)le.businesstype3);
    SELF.businesslocation3_Invalid := Input_Fields.InValid_businesslocation3((SALT311.StrType)le.businesslocation3);
    SELF.businesstype4_Invalid := Input_Fields.InValid_businesstype4((SALT311.StrType)le.businesstype4);
    SELF.businesslocation4_Invalid := Input_Fields.InValid_businesslocation4((SALT311.StrType)le.businesslocation4);
    SELF.businesstype5_Invalid := Input_Fields.InValid_businesstype5((SALT311.StrType)le.businesstype5);
    SELF.businesslocation5_Invalid := Input_Fields.InValid_businesslocation5((SALT311.StrType)le.businesslocation5);
    SELF.industry_Invalid := Input_Fields.InValid_industry((SALT311.StrType)le.industry);
    SELF.trade_Invalid := Input_Fields.InValid_trade((SALT311.StrType)le.trade);
    SELF.resourcedescription_Invalid := Input_Fields.InValid_resourcedescription((SALT311.StrType)le.resourcedescription);
    SELF.natureofbusiness_Invalid := Input_Fields.InValid_natureofbusiness((SALT311.StrType)le.natureofbusiness);
    SELF.businessstructure_Invalid := Input_Fields.InValid_businessstructure((SALT311.StrType)le.businessstructure);
    SELF.totalemployees_Invalid := Input_Fields.InValid_totalemployees((SALT311.StrType)le.totalemployees);
    SELF.avgcontractsize_Invalid := Input_Fields.InValid_avgcontractsize((SALT311.StrType)le.avgcontractsize);
    SELF.firmid_Invalid := Input_Fields.InValid_firmid((SALT311.StrType)le.firmid);
    SELF.firmlocationaddress_Invalid := Input_Fields.InValid_firmlocationaddress((SALT311.StrType)le.firmlocationaddress);
    SELF.firmlocationaddresscity_Invalid := Input_Fields.InValid_firmlocationaddresscity((SALT311.StrType)le.firmlocationaddresscity);
    SELF.firmlocationaddresszip4_Invalid := Input_Fields.InValid_firmlocationaddresszip4((SALT311.StrType)le.firmlocationaddresszip4);
    SELF.firmlocationaddresszipcode_Invalid := Input_Fields.InValid_firmlocationaddresszipcode((SALT311.StrType)le.firmlocationaddresszipcode);
    SELF.firmlocationcounty_Invalid := Input_Fields.InValid_firmlocationcounty((SALT311.StrType)le.firmlocationcounty);
    SELF.firmlocationstate_Invalid := Input_Fields.InValid_firmlocationstate((SALT311.StrType)le.firmlocationstate);
    SELF.certfed_Invalid := Input_Fields.InValid_certfed((SALT311.StrType)le.certfed);
    SELF.certstate_Invalid := Input_Fields.InValid_certstate((SALT311.StrType)le.certstate);
    SELF.contractsfederal_Invalid := Input_Fields.InValid_contractsfederal((SALT311.StrType)le.contractsfederal);
    SELF.contractsva_Invalid := Input_Fields.InValid_contractsva((SALT311.StrType)le.contractsva);
    SELF.contractscommercial_Invalid := Input_Fields.InValid_contractscommercial((SALT311.StrType)le.contractscommercial);
    SELF.contractorgovernmentprime_Invalid := Input_Fields.InValid_contractorgovernmentprime((SALT311.StrType)le.contractorgovernmentprime);
    SELF.contractorgovernmentsub_Invalid := Input_Fields.InValid_contractorgovernmentsub((SALT311.StrType)le.contractorgovernmentsub);
    SELF.contractornongovernment_Invalid := Input_Fields.InValid_contractornongovernment((SALT311.StrType)le.contractornongovernment);
    SELF.registeredgovernmentbus_Invalid := Input_Fields.InValid_registeredgovernmentbus((SALT311.StrType)le.registeredgovernmentbus);
    SELF.registerednongovernmentbus_Invalid := Input_Fields.InValid_registerednongovernmentbus((SALT311.StrType)le.registerednongovernmentbus);
    SELF.clearancelevelpersonnel_Invalid := Input_Fields.InValid_clearancelevelpersonnel((SALT311.StrType)le.clearancelevelpersonnel);
    SELF.clearancelevelfacility_Invalid := Input_Fields.InValid_clearancelevelfacility((SALT311.StrType)le.clearancelevelfacility);
    SELF.certificatedatefrom1_Invalid := Input_Fields.InValid_certificatedatefrom1((SALT311.StrType)le.certificatedatefrom1);
    SELF.certificatedateto1_Invalid := Input_Fields.InValid_certificatedateto1((SALT311.StrType)le.certificatedateto1);
    SELF.certificatestatus1_Invalid := Input_Fields.InValid_certificatestatus1((SALT311.StrType)le.certificatestatus1);
    SELF.certificationnumber1_Invalid := Input_Fields.InValid_certificationnumber1((SALT311.StrType)le.certificationnumber1);
    SELF.certificationtype1_Invalid := Input_Fields.InValid_certificationtype1((SALT311.StrType)le.certificationtype1);
    SELF.certificatedatefrom2_Invalid := Input_Fields.InValid_certificatedatefrom2((SALT311.StrType)le.certificatedatefrom2);
    SELF.certificatedateto2_Invalid := Input_Fields.InValid_certificatedateto2((SALT311.StrType)le.certificatedateto2);
    SELF.certificatestatus2_Invalid := Input_Fields.InValid_certificatestatus2((SALT311.StrType)le.certificatestatus2);
    SELF.certificationnumber2_Invalid := Input_Fields.InValid_certificationnumber2((SALT311.StrType)le.certificationnumber2);
    SELF.certificationtype2_Invalid := Input_Fields.InValid_certificationtype2((SALT311.StrType)le.certificationtype2);
    SELF.certificatedatefrom3_Invalid := Input_Fields.InValid_certificatedatefrom3((SALT311.StrType)le.certificatedatefrom3);
    SELF.certificatedateto3_Invalid := Input_Fields.InValid_certificatedateto3((SALT311.StrType)le.certificatedateto3);
    SELF.certificatestatus3_Invalid := Input_Fields.InValid_certificatestatus3((SALT311.StrType)le.certificatestatus3);
    SELF.certificationnumber3_Invalid := Input_Fields.InValid_certificationnumber3((SALT311.StrType)le.certificationnumber3);
    SELF.certificationtype3_Invalid := Input_Fields.InValid_certificationtype3((SALT311.StrType)le.certificationtype3);
    SELF.certificatedatefrom4_Invalid := Input_Fields.InValid_certificatedatefrom4((SALT311.StrType)le.certificatedatefrom4);
    SELF.certificatedateto4_Invalid := Input_Fields.InValid_certificatedateto4((SALT311.StrType)le.certificatedateto4);
    SELF.certificatestatus4_Invalid := Input_Fields.InValid_certificatestatus4((SALT311.StrType)le.certificatestatus4);
    SELF.certificationnumber4_Invalid := Input_Fields.InValid_certificationnumber4((SALT311.StrType)le.certificationnumber4);
    SELF.certificationtype4_Invalid := Input_Fields.InValid_certificationtype4((SALT311.StrType)le.certificationtype4);
    SELF.certificatedatefrom5_Invalid := Input_Fields.InValid_certificatedatefrom5((SALT311.StrType)le.certificatedatefrom5);
    SELF.certificatedateto5_Invalid := Input_Fields.InValid_certificatedateto5((SALT311.StrType)le.certificatedateto5);
    SELF.certificatestatus5_Invalid := Input_Fields.InValid_certificatestatus5((SALT311.StrType)le.certificatestatus5);
    SELF.certificationnumber5_Invalid := Input_Fields.InValid_certificationnumber5((SALT311.StrType)le.certificationnumber5);
    SELF.certificationtype5_Invalid := Input_Fields.InValid_certificationtype5((SALT311.StrType)le.certificationtype5);
    SELF.certificatedatefrom6_Invalid := Input_Fields.InValid_certificatedatefrom6((SALT311.StrType)le.certificatedatefrom6);
    SELF.certificatedateto6_Invalid := Input_Fields.InValid_certificatedateto6((SALT311.StrType)le.certificatedateto6);
    SELF.certificatestatus6_Invalid := Input_Fields.InValid_certificatestatus6((SALT311.StrType)le.certificatestatus6);
    SELF.certificationnumber6_Invalid := Input_Fields.InValid_certificationnumber6((SALT311.StrType)le.certificationnumber6);
    SELF.certificationtype6_Invalid := Input_Fields.InValid_certificationtype6((SALT311.StrType)le.certificationtype6);
    SELF.starrating_Invalid := Input_Fields.InValid_starrating((SALT311.StrType)le.starrating);
    SELF.assets_Invalid := Input_Fields.InValid_assets((SALT311.StrType)le.assets);
    SELF.biddescription_Invalid := Input_Fields.InValid_biddescription((SALT311.StrType)le.biddescription);
    SELF.competitiveadvantage_Invalid := Input_Fields.InValid_competitiveadvantage((SALT311.StrType)le.competitiveadvantage);
    SELF.cagecode_Invalid := Input_Fields.InValid_cagecode((SALT311.StrType)le.cagecode);
    SELF.capabilitiesnarrative_Invalid := Input_Fields.InValid_capabilitiesnarrative((SALT311.StrType)le.capabilitiesnarrative);
    SELF.category_Invalid := Input_Fields.InValid_category((SALT311.StrType)le.category);
    SELF.chtrclass_Invalid := Input_Fields.InValid_chtrclass((SALT311.StrType)le.chtrclass);
    SELF.productdescription1_Invalid := Input_Fields.InValid_productdescription1((SALT311.StrType)le.productdescription1);
    SELF.productdescription2_Invalid := Input_Fields.InValid_productdescription2((SALT311.StrType)le.productdescription2);
    SELF.productdescription3_Invalid := Input_Fields.InValid_productdescription3((SALT311.StrType)le.productdescription3);
    SELF.productdescription4_Invalid := Input_Fields.InValid_productdescription4((SALT311.StrType)le.productdescription4);
    SELF.productdescription5_Invalid := Input_Fields.InValid_productdescription5((SALT311.StrType)le.productdescription5);
    SELF.classdescription1_Invalid := Input_Fields.InValid_classdescription1((SALT311.StrType)le.classdescription1);
    SELF.subclassdescription1_Invalid := Input_Fields.InValid_subclassdescription1((SALT311.StrType)le.subclassdescription1);
    SELF.classdescription2_Invalid := Input_Fields.InValid_classdescription2((SALT311.StrType)le.classdescription2);
    SELF.subclassdescription2_Invalid := Input_Fields.InValid_subclassdescription2((SALT311.StrType)le.subclassdescription2);
    SELF.classdescription3_Invalid := Input_Fields.InValid_classdescription3((SALT311.StrType)le.classdescription3);
    SELF.subclassdescription3_Invalid := Input_Fields.InValid_subclassdescription3((SALT311.StrType)le.subclassdescription3);
    SELF.classdescription4_Invalid := Input_Fields.InValid_classdescription4((SALT311.StrType)le.classdescription4);
    SELF.subclassdescription4_Invalid := Input_Fields.InValid_subclassdescription4((SALT311.StrType)le.subclassdescription4);
    SELF.classdescription5_Invalid := Input_Fields.InValid_classdescription5((SALT311.StrType)le.classdescription5);
    SELF.subclassdescription5_Invalid := Input_Fields.InValid_subclassdescription5((SALT311.StrType)le.subclassdescription5);
    SELF.classifications_Invalid := Input_Fields.InValid_classifications((SALT311.StrType)le.classifications);
    SELF.commodity1_Invalid := Input_Fields.InValid_commodity1((SALT311.StrType)le.commodity1);
    SELF.commodity2_Invalid := Input_Fields.InValid_commodity2((SALT311.StrType)le.commodity2);
    SELF.commodity3_Invalid := Input_Fields.InValid_commodity3((SALT311.StrType)le.commodity3);
    SELF.commodity4_Invalid := Input_Fields.InValid_commodity4((SALT311.StrType)le.commodity4);
    SELF.commodity5_Invalid := Input_Fields.InValid_commodity5((SALT311.StrType)le.commodity5);
    SELF.commodity6_Invalid := Input_Fields.InValid_commodity6((SALT311.StrType)le.commodity6);
    SELF.commodity7_Invalid := Input_Fields.InValid_commodity7((SALT311.StrType)le.commodity7);
    SELF.commodity8_Invalid := Input_Fields.InValid_commodity8((SALT311.StrType)le.commodity8);
    SELF.completedate_Invalid := Input_Fields.InValid_completedate((SALT311.StrType)le.completedate);
    SELF.crossreference_Invalid := Input_Fields.InValid_crossreference((SALT311.StrType)le.crossreference);
    SELF.dateestablished_Invalid := Input_Fields.InValid_dateestablished((SALT311.StrType)le.dateestablished);
    SELF.businessage_Invalid := Input_Fields.InValid_businessage((SALT311.StrType)le.businessage);
    SELF.deposits_Invalid := Input_Fields.InValid_deposits((SALT311.StrType)le.deposits);
    SELF.dunsnumber_Invalid := Input_Fields.InValid_dunsnumber((SALT311.StrType)le.dunsnumber);
    SELF.enttype_Invalid := Input_Fields.InValid_enttype((SALT311.StrType)le.enttype);
    SELF.expirationdate_Invalid := Input_Fields.InValid_expirationdate((SALT311.StrType)le.expirationdate);
    SELF.extendeddate_Invalid := Input_Fields.InValid_extendeddate((SALT311.StrType)le.extendeddate);
    SELF.issuingauthority_Invalid := Input_Fields.InValid_issuingauthority((SALT311.StrType)le.issuingauthority);
    SELF.keywords_Invalid := Input_Fields.InValid_keywords((SALT311.StrType)le.keywords);
    SELF.licensenumber_Invalid := Input_Fields.InValid_licensenumber((SALT311.StrType)le.licensenumber);
    SELF.licensetype_Invalid := Input_Fields.InValid_licensetype((SALT311.StrType)le.licensetype);
    SELF.mincd_Invalid := Input_Fields.InValid_mincd((SALT311.StrType)le.mincd);
    SELF.minorityaffiliation_Invalid := Input_Fields.InValid_minorityaffiliation((SALT311.StrType)le.minorityaffiliation);
    SELF.minorityownershipdate_Invalid := Input_Fields.InValid_minorityownershipdate((SALT311.StrType)le.minorityownershipdate);
    SELF.siccode1_Invalid := Input_Fields.InValid_siccode1((SALT311.StrType)le.siccode1);
    SELF.siccode2_Invalid := Input_Fields.InValid_siccode2((SALT311.StrType)le.siccode2);
    SELF.siccode3_Invalid := Input_Fields.InValid_siccode3((SALT311.StrType)le.siccode3);
    SELF.siccode4_Invalid := Input_Fields.InValid_siccode4((SALT311.StrType)le.siccode4);
    SELF.siccode5_Invalid := Input_Fields.InValid_siccode5((SALT311.StrType)le.siccode5);
    SELF.siccode6_Invalid := Input_Fields.InValid_siccode6((SALT311.StrType)le.siccode6);
    SELF.siccode7_Invalid := Input_Fields.InValid_siccode7((SALT311.StrType)le.siccode7);
    SELF.siccode8_Invalid := Input_Fields.InValid_siccode8((SALT311.StrType)le.siccode8);
    SELF.naicscode1_Invalid := Input_Fields.InValid_naicscode1((SALT311.StrType)le.naicscode1);
    SELF.naicscode2_Invalid := Input_Fields.InValid_naicscode2((SALT311.StrType)le.naicscode2);
    SELF.naicscode3_Invalid := Input_Fields.InValid_naicscode3((SALT311.StrType)le.naicscode3);
    SELF.naicscode4_Invalid := Input_Fields.InValid_naicscode4((SALT311.StrType)le.naicscode4);
    SELF.naicscode5_Invalid := Input_Fields.InValid_naicscode5((SALT311.StrType)le.naicscode5);
    SELF.naicscode6_Invalid := Input_Fields.InValid_naicscode6((SALT311.StrType)le.naicscode6);
    SELF.naicscode7_Invalid := Input_Fields.InValid_naicscode7((SALT311.StrType)le.naicscode7);
    SELF.naicscode8_Invalid := Input_Fields.InValid_naicscode8((SALT311.StrType)le.naicscode8);
    SELF.prequalify_Invalid := Input_Fields.InValid_prequalify((SALT311.StrType)le.prequalify);
    SELF.procurementcategory1_Invalid := Input_Fields.InValid_procurementcategory1((SALT311.StrType)le.procurementcategory1);
    SELF.subprocurementcategory1_Invalid := Input_Fields.InValid_subprocurementcategory1((SALT311.StrType)le.subprocurementcategory1);
    SELF.procurementcategory2_Invalid := Input_Fields.InValid_procurementcategory2((SALT311.StrType)le.procurementcategory2);
    SELF.subprocurementcategory2_Invalid := Input_Fields.InValid_subprocurementcategory2((SALT311.StrType)le.subprocurementcategory2);
    SELF.procurementcategory3_Invalid := Input_Fields.InValid_procurementcategory3((SALT311.StrType)le.procurementcategory3);
    SELF.subprocurementcategory3_Invalid := Input_Fields.InValid_subprocurementcategory3((SALT311.StrType)le.subprocurementcategory3);
    SELF.procurementcategory4_Invalid := Input_Fields.InValid_procurementcategory4((SALT311.StrType)le.procurementcategory4);
    SELF.subprocurementcategory4_Invalid := Input_Fields.InValid_subprocurementcategory4((SALT311.StrType)le.subprocurementcategory4);
    SELF.procurementcategory5_Invalid := Input_Fields.InValid_procurementcategory5((SALT311.StrType)le.procurementcategory5);
    SELF.subprocurementcategory5_Invalid := Input_Fields.InValid_subprocurementcategory5((SALT311.StrType)le.subprocurementcategory5);
    SELF.renewal_Invalid := Input_Fields.InValid_renewal((SALT311.StrType)le.renewal);
    SELF.renewaldate_Invalid := Input_Fields.InValid_renewaldate((SALT311.StrType)le.renewaldate);
    SELF.unitedcertprogrampartner_Invalid := Input_Fields.InValid_unitedcertprogrampartner((SALT311.StrType)le.unitedcertprogrampartner);
    SELF.vendorkey_Invalid := Input_Fields.InValid_vendorkey((SALT311.StrType)le.vendorkey);
    SELF.vendornumber_Invalid := Input_Fields.InValid_vendornumber((SALT311.StrType)le.vendornumber);
    SELF.workcode1_Invalid := Input_Fields.InValid_workcode1((SALT311.StrType)le.workcode1);
    SELF.workcode2_Invalid := Input_Fields.InValid_workcode2((SALT311.StrType)le.workcode2);
    SELF.workcode3_Invalid := Input_Fields.InValid_workcode3((SALT311.StrType)le.workcode3);
    SELF.workcode4_Invalid := Input_Fields.InValid_workcode4((SALT311.StrType)le.workcode4);
    SELF.workcode5_Invalid := Input_Fields.InValid_workcode5((SALT311.StrType)le.workcode5);
    SELF.workcode6_Invalid := Input_Fields.InValid_workcode6((SALT311.StrType)le.workcode6);
    SELF.workcode7_Invalid := Input_Fields.InValid_workcode7((SALT311.StrType)le.workcode7);
    SELF.workcode8_Invalid := Input_Fields.InValid_workcode8((SALT311.StrType)le.workcode8);
    SELF.exporter_Invalid := Input_Fields.InValid_exporter((SALT311.StrType)le.exporter);
    SELF.exportbusinessactivities_Invalid := Input_Fields.InValid_exportbusinessactivities((SALT311.StrType)le.exportbusinessactivities);
    SELF.exportto_Invalid := Input_Fields.InValid_exportto((SALT311.StrType)le.exportto);
    SELF.exportbusinessrelationships_Invalid := Input_Fields.InValid_exportbusinessrelationships((SALT311.StrType)le.exportbusinessrelationships);
    SELF.exportobjectives_Invalid := Input_Fields.InValid_exportobjectives((SALT311.StrType)le.exportobjectives);
    SELF.reference1_Invalid := Input_Fields.InValid_reference1((SALT311.StrType)le.reference1);
    SELF.reference2_Invalid := Input_Fields.InValid_reference2((SALT311.StrType)le.reference2);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_Diversity_Certification);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dartid_Invalid << 0 ) + ( le.dateadded_Invalid << 1 ) + ( le.dateupdated_Invalid << 2 ) + ( le.website_Invalid << 3 ) + ( le.state_Invalid << 4 ) + ( le.profilelastupdated_Invalid << 5 ) + ( le.county_Invalid << 6 ) + ( le.servicearea_Invalid << 7 ) + ( le.region1_Invalid << 8 ) + ( le.region2_Invalid << 9 ) + ( le.region3_Invalid << 10 ) + ( le.region4_Invalid << 11 ) + ( le.region5_Invalid << 12 ) + ( le.fname_Invalid << 13 ) + ( le.lname_Invalid << 14 ) + ( le.mname_Invalid << 15 ) + ( le.suffix_Invalid << 16 ) + ( le.title_Invalid << 17 ) + ( le.ethnicity_Invalid << 18 ) + ( le.gender_Invalid << 19 ) + ( le.address1_Invalid << 20 ) + ( le.address2_Invalid << 21 ) + ( le.addresscity_Invalid << 22 ) + ( le.addressstate_Invalid << 23 ) + ( le.addresszipcode_Invalid << 24 ) + ( le.addresszip4_Invalid << 26 ) + ( le.building_Invalid << 27 ) + ( le.contact_Invalid << 28 ) + ( le.phone1_Invalid << 29 ) + ( le.phone2_Invalid << 30 ) + ( le.phone3_Invalid << 31 ) + ( le.cell_Invalid << 32 ) + ( le.fax_Invalid << 33 ) + ( le.email1_Invalid << 34 ) + ( le.email2_Invalid << 35 ) + ( le.email3_Invalid << 36 ) + ( le.webpage1_Invalid << 37 ) + ( le.webpage2_Invalid << 38 ) + ( le.webpage3_Invalid << 39 ) + ( le.businessname_Invalid << 40 ) + ( le.dba_Invalid << 41 ) + ( le.businessid_Invalid << 42 ) + ( le.businesstype1_Invalid << 43 ) + ( le.businesslocation1_Invalid << 44 ) + ( le.businesstype2_Invalid << 45 ) + ( le.businesslocation2_Invalid << 46 ) + ( le.businesstype3_Invalid << 47 ) + ( le.businesslocation3_Invalid << 48 ) + ( le.businesstype4_Invalid << 49 ) + ( le.businesslocation4_Invalid << 50 ) + ( le.businesstype5_Invalid << 51 ) + ( le.businesslocation5_Invalid << 52 ) + ( le.industry_Invalid << 53 ) + ( le.trade_Invalid << 54 ) + ( le.resourcedescription_Invalid << 55 ) + ( le.natureofbusiness_Invalid << 56 ) + ( le.businessstructure_Invalid << 57 ) + ( le.totalemployees_Invalid << 58 ) + ( le.avgcontractsize_Invalid << 59 ) + ( le.firmid_Invalid << 60 ) + ( le.firmlocationaddress_Invalid << 61 ) + ( le.firmlocationaddresscity_Invalid << 62 ) + ( le.firmlocationaddresszip4_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.firmlocationaddresszipcode_Invalid << 0 ) + ( le.firmlocationcounty_Invalid << 2 ) + ( le.firmlocationstate_Invalid << 3 ) + ( le.certfed_Invalid << 4 ) + ( le.certstate_Invalid << 5 ) + ( le.contractsfederal_Invalid << 6 ) + ( le.contractsva_Invalid << 7 ) + ( le.contractscommercial_Invalid << 8 ) + ( le.contractorgovernmentprime_Invalid << 9 ) + ( le.contractorgovernmentsub_Invalid << 10 ) + ( le.contractornongovernment_Invalid << 11 ) + ( le.registeredgovernmentbus_Invalid << 12 ) + ( le.registerednongovernmentbus_Invalid << 13 ) + ( le.clearancelevelpersonnel_Invalid << 14 ) + ( le.clearancelevelfacility_Invalid << 15 ) + ( le.certificatedatefrom1_Invalid << 16 ) + ( le.certificatedateto1_Invalid << 17 ) + ( le.certificatestatus1_Invalid << 18 ) + ( le.certificationnumber1_Invalid << 19 ) + ( le.certificationtype1_Invalid << 20 ) + ( le.certificatedatefrom2_Invalid << 21 ) + ( le.certificatedateto2_Invalid << 22 ) + ( le.certificatestatus2_Invalid << 23 ) + ( le.certificationnumber2_Invalid << 24 ) + ( le.certificationtype2_Invalid << 25 ) + ( le.certificatedatefrom3_Invalid << 26 ) + ( le.certificatedateto3_Invalid << 27 ) + ( le.certificatestatus3_Invalid << 28 ) + ( le.certificationnumber3_Invalid << 29 ) + ( le.certificationtype3_Invalid << 30 ) + ( le.certificatedatefrom4_Invalid << 31 ) + ( le.certificatedateto4_Invalid << 32 ) + ( le.certificatestatus4_Invalid << 33 ) + ( le.certificationnumber4_Invalid << 34 ) + ( le.certificationtype4_Invalid << 35 ) + ( le.certificatedatefrom5_Invalid << 36 ) + ( le.certificatedateto5_Invalid << 37 ) + ( le.certificatestatus5_Invalid << 38 ) + ( le.certificationnumber5_Invalid << 39 ) + ( le.certificationtype5_Invalid << 40 ) + ( le.certificatedatefrom6_Invalid << 41 ) + ( le.certificatedateto6_Invalid << 42 ) + ( le.certificatestatus6_Invalid << 43 ) + ( le.certificationnumber6_Invalid << 44 ) + ( le.certificationtype6_Invalid << 45 ) + ( le.starrating_Invalid << 46 ) + ( le.assets_Invalid << 47 ) + ( le.biddescription_Invalid << 48 ) + ( le.competitiveadvantage_Invalid << 49 ) + ( le.cagecode_Invalid << 50 ) + ( le.capabilitiesnarrative_Invalid << 51 ) + ( le.category_Invalid << 52 ) + ( le.chtrclass_Invalid << 53 ) + ( le.productdescription1_Invalid << 54 ) + ( le.productdescription2_Invalid << 55 ) + ( le.productdescription3_Invalid << 56 ) + ( le.productdescription4_Invalid << 57 ) + ( le.productdescription5_Invalid << 58 ) + ( le.classdescription1_Invalid << 59 ) + ( le.subclassdescription1_Invalid << 60 ) + ( le.classdescription2_Invalid << 61 ) + ( le.subclassdescription2_Invalid << 62 ) + ( le.classdescription3_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.subclassdescription3_Invalid << 0 ) + ( le.classdescription4_Invalid << 1 ) + ( le.subclassdescription4_Invalid << 2 ) + ( le.classdescription5_Invalid << 3 ) + ( le.subclassdescription5_Invalid << 4 ) + ( le.classifications_Invalid << 5 ) + ( le.commodity1_Invalid << 6 ) + ( le.commodity2_Invalid << 7 ) + ( le.commodity3_Invalid << 8 ) + ( le.commodity4_Invalid << 9 ) + ( le.commodity5_Invalid << 10 ) + ( le.commodity6_Invalid << 11 ) + ( le.commodity7_Invalid << 12 ) + ( le.commodity8_Invalid << 13 ) + ( le.completedate_Invalid << 14 ) + ( le.crossreference_Invalid << 15 ) + ( le.dateestablished_Invalid << 16 ) + ( le.businessage_Invalid << 17 ) + ( le.deposits_Invalid << 18 ) + ( le.dunsnumber_Invalid << 19 ) + ( le.enttype_Invalid << 20 ) + ( le.expirationdate_Invalid << 21 ) + ( le.extendeddate_Invalid << 22 ) + ( le.issuingauthority_Invalid << 23 ) + ( le.keywords_Invalid << 24 ) + ( le.licensenumber_Invalid << 25 ) + ( le.licensetype_Invalid << 26 ) + ( le.mincd_Invalid << 27 ) + ( le.minorityaffiliation_Invalid << 28 ) + ( le.minorityownershipdate_Invalid << 29 ) + ( le.siccode1_Invalid << 30 ) + ( le.siccode2_Invalid << 31 ) + ( le.siccode3_Invalid << 32 ) + ( le.siccode4_Invalid << 33 ) + ( le.siccode5_Invalid << 34 ) + ( le.siccode6_Invalid << 35 ) + ( le.siccode7_Invalid << 36 ) + ( le.siccode8_Invalid << 37 ) + ( le.naicscode1_Invalid << 38 ) + ( le.naicscode2_Invalid << 39 ) + ( le.naicscode3_Invalid << 40 ) + ( le.naicscode4_Invalid << 41 ) + ( le.naicscode5_Invalid << 42 ) + ( le.naicscode6_Invalid << 43 ) + ( le.naicscode7_Invalid << 44 ) + ( le.naicscode8_Invalid << 45 ) + ( le.prequalify_Invalid << 46 ) + ( le.procurementcategory1_Invalid << 47 ) + ( le.subprocurementcategory1_Invalid << 48 ) + ( le.procurementcategory2_Invalid << 49 ) + ( le.subprocurementcategory2_Invalid << 50 ) + ( le.procurementcategory3_Invalid << 51 ) + ( le.subprocurementcategory3_Invalid << 52 ) + ( le.procurementcategory4_Invalid << 53 ) + ( le.subprocurementcategory4_Invalid << 54 ) + ( le.procurementcategory5_Invalid << 55 ) + ( le.subprocurementcategory5_Invalid << 56 ) + ( le.renewal_Invalid << 57 ) + ( le.renewaldate_Invalid << 58 ) + ( le.unitedcertprogrampartner_Invalid << 59 ) + ( le.vendorkey_Invalid << 60 ) + ( le.vendornumber_Invalid << 61 ) + ( le.workcode1_Invalid << 62 ) + ( le.workcode2_Invalid << 63 );
    SELF.ScrubsBits4 := ( le.workcode3_Invalid << 0 ) + ( le.workcode4_Invalid << 1 ) + ( le.workcode5_Invalid << 2 ) + ( le.workcode6_Invalid << 3 ) + ( le.workcode7_Invalid << 4 ) + ( le.workcode8_Invalid << 5 ) + ( le.exporter_Invalid << 6 ) + ( le.exportbusinessactivities_Invalid << 7 ) + ( le.exportto_Invalid << 8 ) + ( le.exportbusinessrelationships_Invalid << 9 ) + ( le.exportobjectives_Invalid << 10 ) + ( le.reference1_Invalid << 11 ) + ( le.reference2_Invalid << 12 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0 OR (mask&le.ScrubsBits3)>0 OR (mask&le.ScrubsBits4)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND le.ScrubsBits3=0 AND le.ScrubsBits4=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_Layout_Diversity_Certification);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dartid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dateadded_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dateupdated_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.website_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.profilelastupdated_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.servicearea_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.region1_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.region2_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.region3_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.region4_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.region5_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ethnicity_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.address2_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.addresscity_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.addressstate_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.addresszipcode_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.addresszip4_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.building_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.contact_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.phone1_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.phone2_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.phone3_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.cell_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.fax_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.email1_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.email2_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.email3_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.webpage1_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.webpage2_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.webpage3_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.businessname_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.dba_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.businessid_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.businesstype1_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.businesslocation1_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.businesstype2_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.businesslocation2_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.businesstype3_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.businesslocation3_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.businesstype4_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.businesslocation4_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.businesstype5_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.businesslocation5_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.industry_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.trade_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.resourcedescription_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.natureofbusiness_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.businessstructure_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.totalemployees_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.avgcontractsize_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.firmid_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.firmlocationaddress_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.firmlocationaddresscity_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.firmlocationaddresszip4_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.firmlocationaddresszipcode_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.firmlocationcounty_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.firmlocationstate_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.certfed_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.certstate_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.contractsfederal_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.contractsva_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.contractscommercial_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.contractorgovernmentprime_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.contractorgovernmentsub_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.contractornongovernment_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.registeredgovernmentbus_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.registerednongovernmentbus_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.clearancelevelpersonnel_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.clearancelevelfacility_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.certificatedatefrom1_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.certificatedateto1_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.certificatestatus1_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.certificationnumber1_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.certificationtype1_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.certificatedatefrom2_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.certificatedateto2_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.certificatestatus2_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.certificationnumber2_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.certificationtype2_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.certificatedatefrom3_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.certificatedateto3_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.certificatestatus3_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.certificationnumber3_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.certificationtype3_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.certificatedatefrom4_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.certificatedateto4_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.certificatestatus4_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.certificationnumber4_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.certificationtype4_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.certificatedatefrom5_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.certificatedateto5_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.certificatestatus5_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.certificationnumber5_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.certificationtype5_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.certificatedatefrom6_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.certificatedateto6_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.certificatestatus6_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.certificationnumber6_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.certificationtype6_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.starrating_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.assets_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.biddescription_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.competitiveadvantage_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.cagecode_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.capabilitiesnarrative_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.category_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.chtrclass_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.productdescription1_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.productdescription2_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.productdescription3_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.productdescription4_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.productdescription5_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.classdescription1_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.subclassdescription1_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.classdescription2_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.subclassdescription2_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.classdescription3_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.subclassdescription3_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.classdescription4_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.subclassdescription4_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.classdescription5_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.subclassdescription5_Invalid := (le.ScrubsBits3 >> 4) & 1;
    SELF.classifications_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.commodity1_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.commodity2_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.commodity3_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.commodity4_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.commodity5_Invalid := (le.ScrubsBits3 >> 10) & 1;
    SELF.commodity6_Invalid := (le.ScrubsBits3 >> 11) & 1;
    SELF.commodity7_Invalid := (le.ScrubsBits3 >> 12) & 1;
    SELF.commodity8_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.completedate_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.crossreference_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.dateestablished_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.businessage_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.deposits_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.dunsnumber_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.enttype_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.expirationdate_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.extendeddate_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.issuingauthority_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.keywords_Invalid := (le.ScrubsBits3 >> 24) & 1;
    SELF.licensenumber_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.licensetype_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF.mincd_Invalid := (le.ScrubsBits3 >> 27) & 1;
    SELF.minorityaffiliation_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.minorityownershipdate_Invalid := (le.ScrubsBits3 >> 29) & 1;
    SELF.siccode1_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.siccode2_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.siccode3_Invalid := (le.ScrubsBits3 >> 32) & 1;
    SELF.siccode4_Invalid := (le.ScrubsBits3 >> 33) & 1;
    SELF.siccode5_Invalid := (le.ScrubsBits3 >> 34) & 1;
    SELF.siccode6_Invalid := (le.ScrubsBits3 >> 35) & 1;
    SELF.siccode7_Invalid := (le.ScrubsBits3 >> 36) & 1;
    SELF.siccode8_Invalid := (le.ScrubsBits3 >> 37) & 1;
    SELF.naicscode1_Invalid := (le.ScrubsBits3 >> 38) & 1;
    SELF.naicscode2_Invalid := (le.ScrubsBits3 >> 39) & 1;
    SELF.naicscode3_Invalid := (le.ScrubsBits3 >> 40) & 1;
    SELF.naicscode4_Invalid := (le.ScrubsBits3 >> 41) & 1;
    SELF.naicscode5_Invalid := (le.ScrubsBits3 >> 42) & 1;
    SELF.naicscode6_Invalid := (le.ScrubsBits3 >> 43) & 1;
    SELF.naicscode7_Invalid := (le.ScrubsBits3 >> 44) & 1;
    SELF.naicscode8_Invalid := (le.ScrubsBits3 >> 45) & 1;
    SELF.prequalify_Invalid := (le.ScrubsBits3 >> 46) & 1;
    SELF.procurementcategory1_Invalid := (le.ScrubsBits3 >> 47) & 1;
    SELF.subprocurementcategory1_Invalid := (le.ScrubsBits3 >> 48) & 1;
    SELF.procurementcategory2_Invalid := (le.ScrubsBits3 >> 49) & 1;
    SELF.subprocurementcategory2_Invalid := (le.ScrubsBits3 >> 50) & 1;
    SELF.procurementcategory3_Invalid := (le.ScrubsBits3 >> 51) & 1;
    SELF.subprocurementcategory3_Invalid := (le.ScrubsBits3 >> 52) & 1;
    SELF.procurementcategory4_Invalid := (le.ScrubsBits3 >> 53) & 1;
    SELF.subprocurementcategory4_Invalid := (le.ScrubsBits3 >> 54) & 1;
    SELF.procurementcategory5_Invalid := (le.ScrubsBits3 >> 55) & 1;
    SELF.subprocurementcategory5_Invalid := (le.ScrubsBits3 >> 56) & 1;
    SELF.renewal_Invalid := (le.ScrubsBits3 >> 57) & 1;
    SELF.renewaldate_Invalid := (le.ScrubsBits3 >> 58) & 1;
    SELF.unitedcertprogrampartner_Invalid := (le.ScrubsBits3 >> 59) & 1;
    SELF.vendorkey_Invalid := (le.ScrubsBits3 >> 60) & 1;
    SELF.vendornumber_Invalid := (le.ScrubsBits3 >> 61) & 1;
    SELF.workcode1_Invalid := (le.ScrubsBits3 >> 62) & 1;
    SELF.workcode2_Invalid := (le.ScrubsBits3 >> 63) & 1;
    SELF.workcode3_Invalid := (le.ScrubsBits4 >> 0) & 1;
    SELF.workcode4_Invalid := (le.ScrubsBits4 >> 1) & 1;
    SELF.workcode5_Invalid := (le.ScrubsBits4 >> 2) & 1;
    SELF.workcode6_Invalid := (le.ScrubsBits4 >> 3) & 1;
    SELF.workcode7_Invalid := (le.ScrubsBits4 >> 4) & 1;
    SELF.workcode8_Invalid := (le.ScrubsBits4 >> 5) & 1;
    SELF.exporter_Invalid := (le.ScrubsBits4 >> 6) & 1;
    SELF.exportbusinessactivities_Invalid := (le.ScrubsBits4 >> 7) & 1;
    SELF.exportto_Invalid := (le.ScrubsBits4 >> 8) & 1;
    SELF.exportbusinessrelationships_Invalid := (le.ScrubsBits4 >> 9) & 1;
    SELF.exportobjectives_Invalid := (le.ScrubsBits4 >> 10) & 1;
    SELF.reference1_Invalid := (le.ScrubsBits4 >> 11) & 1;
    SELF.reference2_Invalid := (le.ScrubsBits4 >> 12) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dartid_ALLOW_ErrorCount := COUNT(GROUP,h.dartid_Invalid=1);
    dateadded_CUSTOM_ErrorCount := COUNT(GROUP,h.dateadded_Invalid=1);
    dateupdated_CUSTOM_ErrorCount := COUNT(GROUP,h.dateupdated_Invalid=1);
    website_ALLOW_ErrorCount := COUNT(GROUP,h.website_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    profilelastupdated_CUSTOM_ErrorCount := COUNT(GROUP,h.profilelastupdated_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    servicearea_ALLOW_ErrorCount := COUNT(GROUP,h.servicearea_Invalid=1);
    region1_ALLOW_ErrorCount := COUNT(GROUP,h.region1_Invalid=1);
    region2_ALLOW_ErrorCount := COUNT(GROUP,h.region2_Invalid=1);
    region3_ALLOW_ErrorCount := COUNT(GROUP,h.region3_Invalid=1);
    region4_ALLOW_ErrorCount := COUNT(GROUP,h.region4_Invalid=1);
    region5_ALLOW_ErrorCount := COUNT(GROUP,h.region5_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    ethnicity_ALLOW_ErrorCount := COUNT(GROUP,h.ethnicity_Invalid=1);
    gender_ALLOW_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    address1_ALLOW_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    address2_ALLOW_ErrorCount := COUNT(GROUP,h.address2_Invalid=1);
    addresscity_ALLOW_ErrorCount := COUNT(GROUP,h.addresscity_Invalid=1);
    addressstate_CUSTOM_ErrorCount := COUNT(GROUP,h.addressstate_Invalid=1);
    addresszipcode_ALLOW_ErrorCount := COUNT(GROUP,h.addresszipcode_Invalid=1);
    addresszipcode_LENGTHS_ErrorCount := COUNT(GROUP,h.addresszipcode_Invalid=2);
    addresszipcode_Total_ErrorCount := COUNT(GROUP,h.addresszipcode_Invalid>0);
    addresszip4_ALLOW_ErrorCount := COUNT(GROUP,h.addresszip4_Invalid=1);
    building_ALLOW_ErrorCount := COUNT(GROUP,h.building_Invalid=1);
    contact_ALLOW_ErrorCount := COUNT(GROUP,h.contact_Invalid=1);
    phone1_CUSTOM_ErrorCount := COUNT(GROUP,h.phone1_Invalid=1);
    phone2_CUSTOM_ErrorCount := COUNT(GROUP,h.phone2_Invalid=1);
    phone3_CUSTOM_ErrorCount := COUNT(GROUP,h.phone3_Invalid=1);
    cell_CUSTOM_ErrorCount := COUNT(GROUP,h.cell_Invalid=1);
    fax_CUSTOM_ErrorCount := COUNT(GROUP,h.fax_Invalid=1);
    email1_ALLOW_ErrorCount := COUNT(GROUP,h.email1_Invalid=1);
    email2_ALLOW_ErrorCount := COUNT(GROUP,h.email2_Invalid=1);
    email3_ALLOW_ErrorCount := COUNT(GROUP,h.email3_Invalid=1);
    webpage1_ALLOW_ErrorCount := COUNT(GROUP,h.webpage1_Invalid=1);
    webpage2_ALLOW_ErrorCount := COUNT(GROUP,h.webpage2_Invalid=1);
    webpage3_ALLOW_ErrorCount := COUNT(GROUP,h.webpage3_Invalid=1);
    businessname_ALLOW_ErrorCount := COUNT(GROUP,h.businessname_Invalid=1);
    dba_ALLOW_ErrorCount := COUNT(GROUP,h.dba_Invalid=1);
    businessid_ALLOW_ErrorCount := COUNT(GROUP,h.businessid_Invalid=1);
    businesstype1_ALLOW_ErrorCount := COUNT(GROUP,h.businesstype1_Invalid=1);
    businesslocation1_ALLOW_ErrorCount := COUNT(GROUP,h.businesslocation1_Invalid=1);
    businesstype2_ALLOW_ErrorCount := COUNT(GROUP,h.businesstype2_Invalid=1);
    businesslocation2_ALLOW_ErrorCount := COUNT(GROUP,h.businesslocation2_Invalid=1);
    businesstype3_ALLOW_ErrorCount := COUNT(GROUP,h.businesstype3_Invalid=1);
    businesslocation3_ALLOW_ErrorCount := COUNT(GROUP,h.businesslocation3_Invalid=1);
    businesstype4_ALLOW_ErrorCount := COUNT(GROUP,h.businesstype4_Invalid=1);
    businesslocation4_ALLOW_ErrorCount := COUNT(GROUP,h.businesslocation4_Invalid=1);
    businesstype5_ALLOW_ErrorCount := COUNT(GROUP,h.businesstype5_Invalid=1);
    businesslocation5_ALLOW_ErrorCount := COUNT(GROUP,h.businesslocation5_Invalid=1);
    industry_ALLOW_ErrorCount := COUNT(GROUP,h.industry_Invalid=1);
    trade_ALLOW_ErrorCount := COUNT(GROUP,h.trade_Invalid=1);
    resourcedescription_ALLOW_ErrorCount := COUNT(GROUP,h.resourcedescription_Invalid=1);
    natureofbusiness_ALLOW_ErrorCount := COUNT(GROUP,h.natureofbusiness_Invalid=1);
    businessstructure_ALLOW_ErrorCount := COUNT(GROUP,h.businessstructure_Invalid=1);
    totalemployees_ALLOW_ErrorCount := COUNT(GROUP,h.totalemployees_Invalid=1);
    avgcontractsize_ALLOW_ErrorCount := COUNT(GROUP,h.avgcontractsize_Invalid=1);
    firmid_ALLOW_ErrorCount := COUNT(GROUP,h.firmid_Invalid=1);
    firmlocationaddress_ALLOW_ErrorCount := COUNT(GROUP,h.firmlocationaddress_Invalid=1);
    firmlocationaddresscity_ALLOW_ErrorCount := COUNT(GROUP,h.firmlocationaddresscity_Invalid=1);
    firmlocationaddresszip4_ALLOW_ErrorCount := COUNT(GROUP,h.firmlocationaddresszip4_Invalid=1);
    firmlocationaddresszipcode_ALLOW_ErrorCount := COUNT(GROUP,h.firmlocationaddresszipcode_Invalid=1);
    firmlocationaddresszipcode_LENGTHS_ErrorCount := COUNT(GROUP,h.firmlocationaddresszipcode_Invalid=2);
    firmlocationaddresszipcode_Total_ErrorCount := COUNT(GROUP,h.firmlocationaddresszipcode_Invalid>0);
    firmlocationcounty_ALLOW_ErrorCount := COUNT(GROUP,h.firmlocationcounty_Invalid=1);
    firmlocationstate_CUSTOM_ErrorCount := COUNT(GROUP,h.firmlocationstate_Invalid=1);
    certfed_ALLOW_ErrorCount := COUNT(GROUP,h.certfed_Invalid=1);
    certstate_CUSTOM_ErrorCount := COUNT(GROUP,h.certstate_Invalid=1);
    contractsfederal_ALLOW_ErrorCount := COUNT(GROUP,h.contractsfederal_Invalid=1);
    contractsva_ALLOW_ErrorCount := COUNT(GROUP,h.contractsva_Invalid=1);
    contractscommercial_ALLOW_ErrorCount := COUNT(GROUP,h.contractscommercial_Invalid=1);
    contractorgovernmentprime_ALLOW_ErrorCount := COUNT(GROUP,h.contractorgovernmentprime_Invalid=1);
    contractorgovernmentsub_ALLOW_ErrorCount := COUNT(GROUP,h.contractorgovernmentsub_Invalid=1);
    contractornongovernment_ALLOW_ErrorCount := COUNT(GROUP,h.contractornongovernment_Invalid=1);
    registeredgovernmentbus_ALLOW_ErrorCount := COUNT(GROUP,h.registeredgovernmentbus_Invalid=1);
    registerednongovernmentbus_ALLOW_ErrorCount := COUNT(GROUP,h.registerednongovernmentbus_Invalid=1);
    clearancelevelpersonnel_ALLOW_ErrorCount := COUNT(GROUP,h.clearancelevelpersonnel_Invalid=1);
    clearancelevelfacility_ALLOW_ErrorCount := COUNT(GROUP,h.clearancelevelfacility_Invalid=1);
    certificatedatefrom1_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedatefrom1_Invalid=1);
    certificatedateto1_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedateto1_Invalid=1);
    certificatestatus1_ALLOW_ErrorCount := COUNT(GROUP,h.certificatestatus1_Invalid=1);
    certificationnumber1_ALLOW_ErrorCount := COUNT(GROUP,h.certificationnumber1_Invalid=1);
    certificationtype1_ALLOW_ErrorCount := COUNT(GROUP,h.certificationtype1_Invalid=1);
    certificatedatefrom2_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedatefrom2_Invalid=1);
    certificatedateto2_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedateto2_Invalid=1);
    certificatestatus2_ALLOW_ErrorCount := COUNT(GROUP,h.certificatestatus2_Invalid=1);
    certificationnumber2_ALLOW_ErrorCount := COUNT(GROUP,h.certificationnumber2_Invalid=1);
    certificationtype2_ALLOW_ErrorCount := COUNT(GROUP,h.certificationtype2_Invalid=1);
    certificatedatefrom3_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedatefrom3_Invalid=1);
    certificatedateto3_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedateto3_Invalid=1);
    certificatestatus3_ALLOW_ErrorCount := COUNT(GROUP,h.certificatestatus3_Invalid=1);
    certificationnumber3_ALLOW_ErrorCount := COUNT(GROUP,h.certificationnumber3_Invalid=1);
    certificationtype3_ALLOW_ErrorCount := COUNT(GROUP,h.certificationtype3_Invalid=1);
    certificatedatefrom4_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedatefrom4_Invalid=1);
    certificatedateto4_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedateto4_Invalid=1);
    certificatestatus4_ALLOW_ErrorCount := COUNT(GROUP,h.certificatestatus4_Invalid=1);
    certificationnumber4_ALLOW_ErrorCount := COUNT(GROUP,h.certificationnumber4_Invalid=1);
    certificationtype4_ALLOW_ErrorCount := COUNT(GROUP,h.certificationtype4_Invalid=1);
    certificatedatefrom5_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedatefrom5_Invalid=1);
    certificatedateto5_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedateto5_Invalid=1);
    certificatestatus5_ALLOW_ErrorCount := COUNT(GROUP,h.certificatestatus5_Invalid=1);
    certificationnumber5_ALLOW_ErrorCount := COUNT(GROUP,h.certificationnumber5_Invalid=1);
    certificationtype5_ALLOW_ErrorCount := COUNT(GROUP,h.certificationtype5_Invalid=1);
    certificatedatefrom6_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedatefrom6_Invalid=1);
    certificatedateto6_CUSTOM_ErrorCount := COUNT(GROUP,h.certificatedateto6_Invalid=1);
    certificatestatus6_ALLOW_ErrorCount := COUNT(GROUP,h.certificatestatus6_Invalid=1);
    certificationnumber6_ALLOW_ErrorCount := COUNT(GROUP,h.certificationnumber6_Invalid=1);
    certificationtype6_ALLOW_ErrorCount := COUNT(GROUP,h.certificationtype6_Invalid=1);
    starrating_ALLOW_ErrorCount := COUNT(GROUP,h.starrating_Invalid=1);
    assets_ALLOW_ErrorCount := COUNT(GROUP,h.assets_Invalid=1);
    biddescription_ALLOW_ErrorCount := COUNT(GROUP,h.biddescription_Invalid=1);
    competitiveadvantage_ALLOW_ErrorCount := COUNT(GROUP,h.competitiveadvantage_Invalid=1);
    cagecode_ALLOW_ErrorCount := COUNT(GROUP,h.cagecode_Invalid=1);
    capabilitiesnarrative_ALLOW_ErrorCount := COUNT(GROUP,h.capabilitiesnarrative_Invalid=1);
    category_ALLOW_ErrorCount := COUNT(GROUP,h.category_Invalid=1);
    chtrclass_ALLOW_ErrorCount := COUNT(GROUP,h.chtrclass_Invalid=1);
    productdescription1_ALLOW_ErrorCount := COUNT(GROUP,h.productdescription1_Invalid=1);
    productdescription2_ALLOW_ErrorCount := COUNT(GROUP,h.productdescription2_Invalid=1);
    productdescription3_ALLOW_ErrorCount := COUNT(GROUP,h.productdescription3_Invalid=1);
    productdescription4_ALLOW_ErrorCount := COUNT(GROUP,h.productdescription4_Invalid=1);
    productdescription5_ALLOW_ErrorCount := COUNT(GROUP,h.productdescription5_Invalid=1);
    classdescription1_ALLOW_ErrorCount := COUNT(GROUP,h.classdescription1_Invalid=1);
    subclassdescription1_ALLOW_ErrorCount := COUNT(GROUP,h.subclassdescription1_Invalid=1);
    classdescription2_ALLOW_ErrorCount := COUNT(GROUP,h.classdescription2_Invalid=1);
    subclassdescription2_ALLOW_ErrorCount := COUNT(GROUP,h.subclassdescription2_Invalid=1);
    classdescription3_ALLOW_ErrorCount := COUNT(GROUP,h.classdescription3_Invalid=1);
    subclassdescription3_ALLOW_ErrorCount := COUNT(GROUP,h.subclassdescription3_Invalid=1);
    classdescription4_ALLOW_ErrorCount := COUNT(GROUP,h.classdescription4_Invalid=1);
    subclassdescription4_ALLOW_ErrorCount := COUNT(GROUP,h.subclassdescription4_Invalid=1);
    classdescription5_ALLOW_ErrorCount := COUNT(GROUP,h.classdescription5_Invalid=1);
    subclassdescription5_ALLOW_ErrorCount := COUNT(GROUP,h.subclassdescription5_Invalid=1);
    classifications_ALLOW_ErrorCount := COUNT(GROUP,h.classifications_Invalid=1);
    commodity1_CUSTOM_ErrorCount := COUNT(GROUP,h.commodity1_Invalid=1);
    commodity2_CUSTOM_ErrorCount := COUNT(GROUP,h.commodity2_Invalid=1);
    commodity3_CUSTOM_ErrorCount := COUNT(GROUP,h.commodity3_Invalid=1);
    commodity4_CUSTOM_ErrorCount := COUNT(GROUP,h.commodity4_Invalid=1);
    commodity5_CUSTOM_ErrorCount := COUNT(GROUP,h.commodity5_Invalid=1);
    commodity6_CUSTOM_ErrorCount := COUNT(GROUP,h.commodity6_Invalid=1);
    commodity7_CUSTOM_ErrorCount := COUNT(GROUP,h.commodity7_Invalid=1);
    commodity8_CUSTOM_ErrorCount := COUNT(GROUP,h.commodity8_Invalid=1);
    completedate_CUSTOM_ErrorCount := COUNT(GROUP,h.completedate_Invalid=1);
    crossreference_ALLOW_ErrorCount := COUNT(GROUP,h.crossreference_Invalid=1);
    dateestablished_CUSTOM_ErrorCount := COUNT(GROUP,h.dateestablished_Invalid=1);
    businessage_ALLOW_ErrorCount := COUNT(GROUP,h.businessage_Invalid=1);
    deposits_ALLOW_ErrorCount := COUNT(GROUP,h.deposits_Invalid=1);
    dunsnumber_ALLOW_ErrorCount := COUNT(GROUP,h.dunsnumber_Invalid=1);
    enttype_ALLOW_ErrorCount := COUNT(GROUP,h.enttype_Invalid=1);
    expirationdate_CUSTOM_ErrorCount := COUNT(GROUP,h.expirationdate_Invalid=1);
    extendeddate_CUSTOM_ErrorCount := COUNT(GROUP,h.extendeddate_Invalid=1);
    issuingauthority_ALLOW_ErrorCount := COUNT(GROUP,h.issuingauthority_Invalid=1);
    keywords_ALLOW_ErrorCount := COUNT(GROUP,h.keywords_Invalid=1);
    licensenumber_ALLOW_ErrorCount := COUNT(GROUP,h.licensenumber_Invalid=1);
    licensetype_ALLOW_ErrorCount := COUNT(GROUP,h.licensetype_Invalid=1);
    mincd_ALLOW_ErrorCount := COUNT(GROUP,h.mincd_Invalid=1);
    minorityaffiliation_ALLOW_ErrorCount := COUNT(GROUP,h.minorityaffiliation_Invalid=1);
    minorityownershipdate_CUSTOM_ErrorCount := COUNT(GROUP,h.minorityownershipdate_Invalid=1);
    siccode1_CUSTOM_ErrorCount := COUNT(GROUP,h.siccode1_Invalid=1);
    siccode2_CUSTOM_ErrorCount := COUNT(GROUP,h.siccode2_Invalid=1);
    siccode3_CUSTOM_ErrorCount := COUNT(GROUP,h.siccode3_Invalid=1);
    siccode4_CUSTOM_ErrorCount := COUNT(GROUP,h.siccode4_Invalid=1);
    siccode5_CUSTOM_ErrorCount := COUNT(GROUP,h.siccode5_Invalid=1);
    siccode6_CUSTOM_ErrorCount := COUNT(GROUP,h.siccode6_Invalid=1);
    siccode7_CUSTOM_ErrorCount := COUNT(GROUP,h.siccode7_Invalid=1);
    siccode8_CUSTOM_ErrorCount := COUNT(GROUP,h.siccode8_Invalid=1);
    naicscode1_CUSTOM_ErrorCount := COUNT(GROUP,h.naicscode1_Invalid=1);
    naicscode2_CUSTOM_ErrorCount := COUNT(GROUP,h.naicscode2_Invalid=1);
    naicscode3_CUSTOM_ErrorCount := COUNT(GROUP,h.naicscode3_Invalid=1);
    naicscode4_CUSTOM_ErrorCount := COUNT(GROUP,h.naicscode4_Invalid=1);
    naicscode5_CUSTOM_ErrorCount := COUNT(GROUP,h.naicscode5_Invalid=1);
    naicscode6_CUSTOM_ErrorCount := COUNT(GROUP,h.naicscode6_Invalid=1);
    naicscode7_CUSTOM_ErrorCount := COUNT(GROUP,h.naicscode7_Invalid=1);
    naicscode8_CUSTOM_ErrorCount := COUNT(GROUP,h.naicscode8_Invalid=1);
    prequalify_ALLOW_ErrorCount := COUNT(GROUP,h.prequalify_Invalid=1);
    procurementcategory1_ALLOW_ErrorCount := COUNT(GROUP,h.procurementcategory1_Invalid=1);
    subprocurementcategory1_ALLOW_ErrorCount := COUNT(GROUP,h.subprocurementcategory1_Invalid=1);
    procurementcategory2_ALLOW_ErrorCount := COUNT(GROUP,h.procurementcategory2_Invalid=1);
    subprocurementcategory2_ALLOW_ErrorCount := COUNT(GROUP,h.subprocurementcategory2_Invalid=1);
    procurementcategory3_ALLOW_ErrorCount := COUNT(GROUP,h.procurementcategory3_Invalid=1);
    subprocurementcategory3_ALLOW_ErrorCount := COUNT(GROUP,h.subprocurementcategory3_Invalid=1);
    procurementcategory4_ALLOW_ErrorCount := COUNT(GROUP,h.procurementcategory4_Invalid=1);
    subprocurementcategory4_ALLOW_ErrorCount := COUNT(GROUP,h.subprocurementcategory4_Invalid=1);
    procurementcategory5_ALLOW_ErrorCount := COUNT(GROUP,h.procurementcategory5_Invalid=1);
    subprocurementcategory5_ALLOW_ErrorCount := COUNT(GROUP,h.subprocurementcategory5_Invalid=1);
    renewal_ALLOW_ErrorCount := COUNT(GROUP,h.renewal_Invalid=1);
    renewaldate_CUSTOM_ErrorCount := COUNT(GROUP,h.renewaldate_Invalid=1);
    unitedcertprogrampartner_ALLOW_ErrorCount := COUNT(GROUP,h.unitedcertprogrampartner_Invalid=1);
    vendorkey_ALLOW_ErrorCount := COUNT(GROUP,h.vendorkey_Invalid=1);
    vendornumber_ALLOW_ErrorCount := COUNT(GROUP,h.vendornumber_Invalid=1);
    workcode1_ALLOW_ErrorCount := COUNT(GROUP,h.workcode1_Invalid=1);
    workcode2_ALLOW_ErrorCount := COUNT(GROUP,h.workcode2_Invalid=1);
    workcode3_ALLOW_ErrorCount := COUNT(GROUP,h.workcode3_Invalid=1);
    workcode4_ALLOW_ErrorCount := COUNT(GROUP,h.workcode4_Invalid=1);
    workcode5_ALLOW_ErrorCount := COUNT(GROUP,h.workcode5_Invalid=1);
    workcode6_ALLOW_ErrorCount := COUNT(GROUP,h.workcode6_Invalid=1);
    workcode7_ALLOW_ErrorCount := COUNT(GROUP,h.workcode7_Invalid=1);
    workcode8_ALLOW_ErrorCount := COUNT(GROUP,h.workcode8_Invalid=1);
    exporter_ALLOW_ErrorCount := COUNT(GROUP,h.exporter_Invalid=1);
    exportbusinessactivities_ALLOW_ErrorCount := COUNT(GROUP,h.exportbusinessactivities_Invalid=1);
    exportto_ALLOW_ErrorCount := COUNT(GROUP,h.exportto_Invalid=1);
    exportbusinessrelationships_ALLOW_ErrorCount := COUNT(GROUP,h.exportbusinessrelationships_Invalid=1);
    exportobjectives_ALLOW_ErrorCount := COUNT(GROUP,h.exportobjectives_Invalid=1);
    reference1_ALLOW_ErrorCount := COUNT(GROUP,h.reference1_Invalid=1);
    reference2_ALLOW_ErrorCount := COUNT(GROUP,h.reference2_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dartid_Invalid > 0 OR h.dateadded_Invalid > 0 OR h.dateupdated_Invalid > 0 OR h.website_Invalid > 0 OR h.state_Invalid > 0 OR h.profilelastupdated_Invalid > 0 OR h.county_Invalid > 0 OR h.servicearea_Invalid > 0 OR h.region1_Invalid > 0 OR h.region2_Invalid > 0 OR h.region3_Invalid > 0 OR h.region4_Invalid > 0 OR h.region5_Invalid > 0 OR h.fname_Invalid > 0 OR h.lname_Invalid > 0 OR h.mname_Invalid > 0 OR h.suffix_Invalid > 0 OR h.title_Invalid > 0 OR h.ethnicity_Invalid > 0 OR h.gender_Invalid > 0 OR h.address1_Invalid > 0 OR h.address2_Invalid > 0 OR h.addresscity_Invalid > 0 OR h.addressstate_Invalid > 0 OR h.addresszipcode_Invalid > 0 OR h.addresszip4_Invalid > 0 OR h.building_Invalid > 0 OR h.contact_Invalid > 0 OR h.phone1_Invalid > 0 OR h.phone2_Invalid > 0 OR h.phone3_Invalid > 0 OR h.cell_Invalid > 0 OR h.fax_Invalid > 0 OR h.email1_Invalid > 0 OR h.email2_Invalid > 0 OR h.email3_Invalid > 0 OR h.webpage1_Invalid > 0 OR h.webpage2_Invalid > 0 OR h.webpage3_Invalid > 0 OR h.businessname_Invalid > 0 OR h.dba_Invalid > 0 OR h.businessid_Invalid > 0 OR h.businesstype1_Invalid > 0 OR h.businesslocation1_Invalid > 0 OR h.businesstype2_Invalid > 0 OR h.businesslocation2_Invalid > 0 OR h.businesstype3_Invalid > 0 OR h.businesslocation3_Invalid > 0 OR h.businesstype4_Invalid > 0 OR h.businesslocation4_Invalid > 0 OR h.businesstype5_Invalid > 0 OR h.businesslocation5_Invalid > 0 OR h.industry_Invalid > 0 OR h.trade_Invalid > 0 OR h.resourcedescription_Invalid > 0 OR h.natureofbusiness_Invalid > 0 OR h.businessstructure_Invalid > 0 OR h.totalemployees_Invalid > 0 OR h.avgcontractsize_Invalid > 0 OR h.firmid_Invalid > 0 OR h.firmlocationaddress_Invalid > 0 OR h.firmlocationaddresscity_Invalid > 0 OR h.firmlocationaddresszip4_Invalid > 0 OR h.firmlocationaddresszipcode_Invalid > 0 OR h.firmlocationcounty_Invalid > 0 OR h.firmlocationstate_Invalid > 0 OR h.certfed_Invalid > 0 OR h.certstate_Invalid > 0 OR h.contractsfederal_Invalid > 0 OR h.contractsva_Invalid > 0 OR h.contractscommercial_Invalid > 0 OR h.contractorgovernmentprime_Invalid > 0 OR h.contractorgovernmentsub_Invalid > 0 OR h.contractornongovernment_Invalid > 0 OR h.registeredgovernmentbus_Invalid > 0 OR h.registerednongovernmentbus_Invalid > 0 OR h.clearancelevelpersonnel_Invalid > 0 OR h.clearancelevelfacility_Invalid > 0 OR h.certificatedatefrom1_Invalid > 0 OR h.certificatedateto1_Invalid > 0 OR h.certificatestatus1_Invalid > 0 OR h.certificationnumber1_Invalid > 0 OR h.certificationtype1_Invalid > 0 OR h.certificatedatefrom2_Invalid > 0 OR h.certificatedateto2_Invalid > 0 OR h.certificatestatus2_Invalid > 0 OR h.certificationnumber2_Invalid > 0 OR h.certificationtype2_Invalid > 0 OR h.certificatedatefrom3_Invalid > 0 OR h.certificatedateto3_Invalid > 0 OR h.certificatestatus3_Invalid > 0 OR h.certificationnumber3_Invalid > 0 OR h.certificationtype3_Invalid > 0 OR h.certificatedatefrom4_Invalid > 0 OR h.certificatedateto4_Invalid > 0 OR h.certificatestatus4_Invalid > 0 OR h.certificationnumber4_Invalid > 0 OR h.certificationtype4_Invalid > 0 OR h.certificatedatefrom5_Invalid > 0 OR h.certificatedateto5_Invalid > 0 OR h.certificatestatus5_Invalid > 0 OR h.certificationnumber5_Invalid > 0 OR h.certificationtype5_Invalid > 0 OR h.certificatedatefrom6_Invalid > 0 OR h.certificatedateto6_Invalid > 0 OR h.certificatestatus6_Invalid > 0 OR h.certificationnumber6_Invalid > 0 OR h.certificationtype6_Invalid > 0 OR h.starrating_Invalid > 0 OR h.assets_Invalid > 0 OR h.biddescription_Invalid > 0 OR h.competitiveadvantage_Invalid > 0 OR h.cagecode_Invalid > 0 OR h.capabilitiesnarrative_Invalid > 0 OR h.category_Invalid > 0 OR h.chtrclass_Invalid > 0 OR h.productdescription1_Invalid > 0 OR h.productdescription2_Invalid > 0 OR h.productdescription3_Invalid > 0 OR h.productdescription4_Invalid > 0 OR h.productdescription5_Invalid > 0 OR h.classdescription1_Invalid > 0 OR h.subclassdescription1_Invalid > 0 OR h.classdescription2_Invalid > 0 OR h.subclassdescription2_Invalid > 0 OR h.classdescription3_Invalid > 0 OR h.subclassdescription3_Invalid > 0 OR h.classdescription4_Invalid > 0 OR h.subclassdescription4_Invalid > 0 OR h.classdescription5_Invalid > 0 OR h.subclassdescription5_Invalid > 0 OR h.classifications_Invalid > 0 OR h.commodity1_Invalid > 0 OR h.commodity2_Invalid > 0 OR h.commodity3_Invalid > 0 OR h.commodity4_Invalid > 0 OR h.commodity5_Invalid > 0 OR h.commodity6_Invalid > 0 OR h.commodity7_Invalid > 0 OR h.commodity8_Invalid > 0 OR h.completedate_Invalid > 0 OR h.crossreference_Invalid > 0 OR h.dateestablished_Invalid > 0 OR h.businessage_Invalid > 0 OR h.deposits_Invalid > 0 OR h.dunsnumber_Invalid > 0 OR h.enttype_Invalid > 0 OR h.expirationdate_Invalid > 0 OR h.extendeddate_Invalid > 0 OR h.issuingauthority_Invalid > 0 OR h.keywords_Invalid > 0 OR h.licensenumber_Invalid > 0 OR h.licensetype_Invalid > 0 OR h.mincd_Invalid > 0 OR h.minorityaffiliation_Invalid > 0 OR h.minorityownershipdate_Invalid > 0 OR h.siccode1_Invalid > 0 OR h.siccode2_Invalid > 0 OR h.siccode3_Invalid > 0 OR h.siccode4_Invalid > 0 OR h.siccode5_Invalid > 0 OR h.siccode6_Invalid > 0 OR h.siccode7_Invalid > 0 OR h.siccode8_Invalid > 0 OR h.naicscode1_Invalid > 0 OR h.naicscode2_Invalid > 0 OR h.naicscode3_Invalid > 0 OR h.naicscode4_Invalid > 0 OR h.naicscode5_Invalid > 0 OR h.naicscode6_Invalid > 0 OR h.naicscode7_Invalid > 0 OR h.naicscode8_Invalid > 0 OR h.prequalify_Invalid > 0 OR h.procurementcategory1_Invalid > 0 OR h.subprocurementcategory1_Invalid > 0 OR h.procurementcategory2_Invalid > 0 OR h.subprocurementcategory2_Invalid > 0 OR h.procurementcategory3_Invalid > 0 OR h.subprocurementcategory3_Invalid > 0 OR h.procurementcategory4_Invalid > 0 OR h.subprocurementcategory4_Invalid > 0 OR h.procurementcategory5_Invalid > 0 OR h.subprocurementcategory5_Invalid > 0 OR h.renewal_Invalid > 0 OR h.renewaldate_Invalid > 0 OR h.unitedcertprogrampartner_Invalid > 0 OR h.vendorkey_Invalid > 0 OR h.vendornumber_Invalid > 0 OR h.workcode1_Invalid > 0 OR h.workcode2_Invalid > 0 OR h.workcode3_Invalid > 0 OR h.workcode4_Invalid > 0 OR h.workcode5_Invalid > 0 OR h.workcode6_Invalid > 0 OR h.workcode7_Invalid > 0 OR h.workcode8_Invalid > 0 OR h.exporter_Invalid > 0 OR h.exportbusinessactivities_Invalid > 0 OR h.exportto_Invalid > 0 OR h.exportbusinessrelationships_Invalid > 0 OR h.exportobjectives_Invalid > 0 OR h.reference1_Invalid > 0 OR h.reference2_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateadded_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.profilelastupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.servicearea_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ethnicity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addresszipcode_Total_ErrorCount > 0, 1, 0) + IF(le.addresszip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.building_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cell_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fax_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesslocation1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesslocation2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesslocation3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesslocation4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesslocation5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.industry_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trade_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resourcedescription_ALLOW_ErrorCount > 0, 1, 0) + IF(le.natureofbusiness_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessstructure_ALLOW_ErrorCount > 0, 1, 0) + IF(le.totalemployees_ALLOW_ErrorCount > 0, 1, 0) + IF(le.avgcontractsize_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationaddress_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationaddresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationaddresszip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationaddresszipcode_Total_ErrorCount > 0, 1, 0) + IF(le.firmlocationcounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certfed_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contractsfederal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contractsva_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contractscommercial_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contractorgovernmentprime_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contractorgovernmentsub_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contractornongovernment_ALLOW_ErrorCount > 0, 1, 0) + IF(le.registeredgovernmentbus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.registerednongovernmentbus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clearancelevelpersonnel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clearancelevelfacility_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.starrating_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assets_ALLOW_ErrorCount > 0, 1, 0) + IF(le.biddescription_ALLOW_ErrorCount > 0, 1, 0) + IF(le.competitiveadvantage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cagecode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.capabilitiesnarrative_ALLOW_ErrorCount > 0, 1, 0) + IF(le.category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chtrclass_ALLOW_ErrorCount > 0, 1, 0) + IF(le.productdescription1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.productdescription2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.productdescription3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.productdescription4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.productdescription5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classdescription1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subclassdescription1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classdescription2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subclassdescription2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classdescription3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subclassdescription3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classdescription4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subclassdescription4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classdescription5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subclassdescription5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classifications_ALLOW_ErrorCount > 0, 1, 0) + IF(le.commodity1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.completedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.crossreference_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateestablished_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.businessage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deposits_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dunsnumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.enttype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expirationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.extendeddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.issuingauthority_ALLOW_ErrorCount > 0, 1, 0) + IF(le.keywords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensetype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mincd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.minorityaffiliation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.minorityownershipdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prequalify_ALLOW_ErrorCount > 0, 1, 0) + IF(le.procurementcategory1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subprocurementcategory1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.procurementcategory2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subprocurementcategory2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.procurementcategory3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subprocurementcategory3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.procurementcategory4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subprocurementcategory4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.procurementcategory5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subprocurementcategory5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.renewal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.renewaldate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unitedcertprogrampartner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendorkey_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendornumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.exporter_ALLOW_ErrorCount > 0, 1, 0) + IF(le.exportbusinessactivities_ALLOW_ErrorCount > 0, 1, 0) + IF(le.exportto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.exportbusinessrelationships_ALLOW_ErrorCount > 0, 1, 0) + IF(le.exportobjectives_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reference1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reference2_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateadded_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.profilelastupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.servicearea_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ethnicity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addresszipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addresszipcode_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addresszip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.building_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cell_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fax_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.webpage3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesslocation1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesslocation2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesslocation3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesslocation4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesslocation5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.industry_ALLOW_ErrorCount > 0, 1, 0) + IF(le.trade_ALLOW_ErrorCount > 0, 1, 0) + IF(le.resourcedescription_ALLOW_ErrorCount > 0, 1, 0) + IF(le.natureofbusiness_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessstructure_ALLOW_ErrorCount > 0, 1, 0) + IF(le.totalemployees_ALLOW_ErrorCount > 0, 1, 0) + IF(le.avgcontractsize_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationaddress_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationaddresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationaddresszip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationaddresszipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationaddresszipcode_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.firmlocationcounty_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firmlocationstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certfed_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certstate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contractsfederal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contractsva_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contractscommercial_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contractorgovernmentprime_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contractorgovernmentsub_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contractornongovernment_ALLOW_ErrorCount > 0, 1, 0) + IF(le.registeredgovernmentbus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.registerednongovernmentbus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clearancelevelpersonnel_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clearancelevelfacility_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificatedatefrom6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatedateto6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.certificatestatus6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationnumber6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.certificationtype6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.starrating_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assets_ALLOW_ErrorCount > 0, 1, 0) + IF(le.biddescription_ALLOW_ErrorCount > 0, 1, 0) + IF(le.competitiveadvantage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cagecode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.capabilitiesnarrative_ALLOW_ErrorCount > 0, 1, 0) + IF(le.category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chtrclass_ALLOW_ErrorCount > 0, 1, 0) + IF(le.productdescription1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.productdescription2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.productdescription3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.productdescription4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.productdescription5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classdescription1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subclassdescription1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classdescription2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subclassdescription2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classdescription3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subclassdescription3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classdescription4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subclassdescription4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classdescription5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subclassdescription5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classifications_ALLOW_ErrorCount > 0, 1, 0) + IF(le.commodity1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.commodity8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.completedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.crossreference_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateestablished_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.businessage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.deposits_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dunsnumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.enttype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expirationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.extendeddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.issuingauthority_ALLOW_ErrorCount > 0, 1, 0) + IF(le.keywords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensetype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mincd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.minorityaffiliation_ALLOW_ErrorCount > 0, 1, 0) + IF(le.minorityownershipdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siccode8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.naicscode8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prequalify_ALLOW_ErrorCount > 0, 1, 0) + IF(le.procurementcategory1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subprocurementcategory1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.procurementcategory2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subprocurementcategory2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.procurementcategory3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subprocurementcategory3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.procurementcategory4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subprocurementcategory4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.procurementcategory5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subprocurementcategory5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.renewal_ALLOW_ErrorCount > 0, 1, 0) + IF(le.renewaldate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unitedcertprogrampartner_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendorkey_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendornumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.workcode8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.exporter_ALLOW_ErrorCount > 0, 1, 0) + IF(le.exportbusinessactivities_ALLOW_ErrorCount > 0, 1, 0) + IF(le.exportto_ALLOW_ErrorCount > 0, 1, 0) + IF(le.exportbusinessrelationships_ALLOW_ErrorCount > 0, 1, 0) + IF(le.exportobjectives_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reference1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.reference2_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dartid_Invalid,le.dateadded_Invalid,le.dateupdated_Invalid,le.website_Invalid,le.state_Invalid,le.profilelastupdated_Invalid,le.county_Invalid,le.servicearea_Invalid,le.region1_Invalid,le.region2_Invalid,le.region3_Invalid,le.region4_Invalid,le.region5_Invalid,le.fname_Invalid,le.lname_Invalid,le.mname_Invalid,le.suffix_Invalid,le.title_Invalid,le.ethnicity_Invalid,le.gender_Invalid,le.address1_Invalid,le.address2_Invalid,le.addresscity_Invalid,le.addressstate_Invalid,le.addresszipcode_Invalid,le.addresszip4_Invalid,le.building_Invalid,le.contact_Invalid,le.phone1_Invalid,le.phone2_Invalid,le.phone3_Invalid,le.cell_Invalid,le.fax_Invalid,le.email1_Invalid,le.email2_Invalid,le.email3_Invalid,le.webpage1_Invalid,le.webpage2_Invalid,le.webpage3_Invalid,le.businessname_Invalid,le.dba_Invalid,le.businessid_Invalid,le.businesstype1_Invalid,le.businesslocation1_Invalid,le.businesstype2_Invalid,le.businesslocation2_Invalid,le.businesstype3_Invalid,le.businesslocation3_Invalid,le.businesstype4_Invalid,le.businesslocation4_Invalid,le.businesstype5_Invalid,le.businesslocation5_Invalid,le.industry_Invalid,le.trade_Invalid,le.resourcedescription_Invalid,le.natureofbusiness_Invalid,le.businessstructure_Invalid,le.totalemployees_Invalid,le.avgcontractsize_Invalid,le.firmid_Invalid,le.firmlocationaddress_Invalid,le.firmlocationaddresscity_Invalid,le.firmlocationaddresszip4_Invalid,le.firmlocationaddresszipcode_Invalid,le.firmlocationcounty_Invalid,le.firmlocationstate_Invalid,le.certfed_Invalid,le.certstate_Invalid,le.contractsfederal_Invalid,le.contractsva_Invalid,le.contractscommercial_Invalid,le.contractorgovernmentprime_Invalid,le.contractorgovernmentsub_Invalid,le.contractornongovernment_Invalid,le.registeredgovernmentbus_Invalid,le.registerednongovernmentbus_Invalid,le.clearancelevelpersonnel_Invalid,le.clearancelevelfacility_Invalid,le.certificatedatefrom1_Invalid,le.certificatedateto1_Invalid,le.certificatestatus1_Invalid,le.certificationnumber1_Invalid,le.certificationtype1_Invalid,le.certificatedatefrom2_Invalid,le.certificatedateto2_Invalid,le.certificatestatus2_Invalid,le.certificationnumber2_Invalid,le.certificationtype2_Invalid,le.certificatedatefrom3_Invalid,le.certificatedateto3_Invalid,le.certificatestatus3_Invalid,le.certificationnumber3_Invalid,le.certificationtype3_Invalid,le.certificatedatefrom4_Invalid,le.certificatedateto4_Invalid,le.certificatestatus4_Invalid,le.certificationnumber4_Invalid,le.certificationtype4_Invalid,le.certificatedatefrom5_Invalid,le.certificatedateto5_Invalid,le.certificatestatus5_Invalid,le.certificationnumber5_Invalid,le.certificationtype5_Invalid,le.certificatedatefrom6_Invalid,le.certificatedateto6_Invalid,le.certificatestatus6_Invalid,le.certificationnumber6_Invalid,le.certificationtype6_Invalid,le.starrating_Invalid,le.assets_Invalid,le.biddescription_Invalid,le.competitiveadvantage_Invalid,le.cagecode_Invalid,le.capabilitiesnarrative_Invalid,le.category_Invalid,le.chtrclass_Invalid,le.productdescription1_Invalid,le.productdescription2_Invalid,le.productdescription3_Invalid,le.productdescription4_Invalid,le.productdescription5_Invalid,le.classdescription1_Invalid,le.subclassdescription1_Invalid,le.classdescription2_Invalid,le.subclassdescription2_Invalid,le.classdescription3_Invalid,le.subclassdescription3_Invalid,le.classdescription4_Invalid,le.subclassdescription4_Invalid,le.classdescription5_Invalid,le.subclassdescription5_Invalid,le.classifications_Invalid,le.commodity1_Invalid,le.commodity2_Invalid,le.commodity3_Invalid,le.commodity4_Invalid,le.commodity5_Invalid,le.commodity6_Invalid,le.commodity7_Invalid,le.commodity8_Invalid,le.completedate_Invalid,le.crossreference_Invalid,le.dateestablished_Invalid,le.businessage_Invalid,le.deposits_Invalid,le.dunsnumber_Invalid,le.enttype_Invalid,le.expirationdate_Invalid,le.extendeddate_Invalid,le.issuingauthority_Invalid,le.keywords_Invalid,le.licensenumber_Invalid,le.licensetype_Invalid,le.mincd_Invalid,le.minorityaffiliation_Invalid,le.minorityownershipdate_Invalid,le.siccode1_Invalid,le.siccode2_Invalid,le.siccode3_Invalid,le.siccode4_Invalid,le.siccode5_Invalid,le.siccode6_Invalid,le.siccode7_Invalid,le.siccode8_Invalid,le.naicscode1_Invalid,le.naicscode2_Invalid,le.naicscode3_Invalid,le.naicscode4_Invalid,le.naicscode5_Invalid,le.naicscode6_Invalid,le.naicscode7_Invalid,le.naicscode8_Invalid,le.prequalify_Invalid,le.procurementcategory1_Invalid,le.subprocurementcategory1_Invalid,le.procurementcategory2_Invalid,le.subprocurementcategory2_Invalid,le.procurementcategory3_Invalid,le.subprocurementcategory3_Invalid,le.procurementcategory4_Invalid,le.subprocurementcategory4_Invalid,le.procurementcategory5_Invalid,le.subprocurementcategory5_Invalid,le.renewal_Invalid,le.renewaldate_Invalid,le.unitedcertprogrampartner_Invalid,le.vendorkey_Invalid,le.vendornumber_Invalid,le.workcode1_Invalid,le.workcode2_Invalid,le.workcode3_Invalid,le.workcode4_Invalid,le.workcode5_Invalid,le.workcode6_Invalid,le.workcode7_Invalid,le.workcode8_Invalid,le.exporter_Invalid,le.exportbusinessactivities_Invalid,le.exportto_Invalid,le.exportbusinessrelationships_Invalid,le.exportobjectives_Invalid,le.reference1_Invalid,le.reference2_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_dartid(le.dartid_Invalid),Input_Fields.InvalidMessage_dateadded(le.dateadded_Invalid),Input_Fields.InvalidMessage_dateupdated(le.dateupdated_Invalid),Input_Fields.InvalidMessage_website(le.website_Invalid),Input_Fields.InvalidMessage_state(le.state_Invalid),Input_Fields.InvalidMessage_profilelastupdated(le.profilelastupdated_Invalid),Input_Fields.InvalidMessage_county(le.county_Invalid),Input_Fields.InvalidMessage_servicearea(le.servicearea_Invalid),Input_Fields.InvalidMessage_region1(le.region1_Invalid),Input_Fields.InvalidMessage_region2(le.region2_Invalid),Input_Fields.InvalidMessage_region3(le.region3_Invalid),Input_Fields.InvalidMessage_region4(le.region4_Invalid),Input_Fields.InvalidMessage_region5(le.region5_Invalid),Input_Fields.InvalidMessage_fname(le.fname_Invalid),Input_Fields.InvalidMessage_lname(le.lname_Invalid),Input_Fields.InvalidMessage_mname(le.mname_Invalid),Input_Fields.InvalidMessage_suffix(le.suffix_Invalid),Input_Fields.InvalidMessage_title(le.title_Invalid),Input_Fields.InvalidMessage_ethnicity(le.ethnicity_Invalid),Input_Fields.InvalidMessage_gender(le.gender_Invalid),Input_Fields.InvalidMessage_address1(le.address1_Invalid),Input_Fields.InvalidMessage_address2(le.address2_Invalid),Input_Fields.InvalidMessage_addresscity(le.addresscity_Invalid),Input_Fields.InvalidMessage_addressstate(le.addressstate_Invalid),Input_Fields.InvalidMessage_addresszipcode(le.addresszipcode_Invalid),Input_Fields.InvalidMessage_addresszip4(le.addresszip4_Invalid),Input_Fields.InvalidMessage_building(le.building_Invalid),Input_Fields.InvalidMessage_contact(le.contact_Invalid),Input_Fields.InvalidMessage_phone1(le.phone1_Invalid),Input_Fields.InvalidMessage_phone2(le.phone2_Invalid),Input_Fields.InvalidMessage_phone3(le.phone3_Invalid),Input_Fields.InvalidMessage_cell(le.cell_Invalid),Input_Fields.InvalidMessage_fax(le.fax_Invalid),Input_Fields.InvalidMessage_email1(le.email1_Invalid),Input_Fields.InvalidMessage_email2(le.email2_Invalid),Input_Fields.InvalidMessage_email3(le.email3_Invalid),Input_Fields.InvalidMessage_webpage1(le.webpage1_Invalid),Input_Fields.InvalidMessage_webpage2(le.webpage2_Invalid),Input_Fields.InvalidMessage_webpage3(le.webpage3_Invalid),Input_Fields.InvalidMessage_businessname(le.businessname_Invalid),Input_Fields.InvalidMessage_dba(le.dba_Invalid),Input_Fields.InvalidMessage_businessid(le.businessid_Invalid),Input_Fields.InvalidMessage_businesstype1(le.businesstype1_Invalid),Input_Fields.InvalidMessage_businesslocation1(le.businesslocation1_Invalid),Input_Fields.InvalidMessage_businesstype2(le.businesstype2_Invalid),Input_Fields.InvalidMessage_businesslocation2(le.businesslocation2_Invalid),Input_Fields.InvalidMessage_businesstype3(le.businesstype3_Invalid),Input_Fields.InvalidMessage_businesslocation3(le.businesslocation3_Invalid),Input_Fields.InvalidMessage_businesstype4(le.businesstype4_Invalid),Input_Fields.InvalidMessage_businesslocation4(le.businesslocation4_Invalid),Input_Fields.InvalidMessage_businesstype5(le.businesstype5_Invalid),Input_Fields.InvalidMessage_businesslocation5(le.businesslocation5_Invalid),Input_Fields.InvalidMessage_industry(le.industry_Invalid),Input_Fields.InvalidMessage_trade(le.trade_Invalid),Input_Fields.InvalidMessage_resourcedescription(le.resourcedescription_Invalid),Input_Fields.InvalidMessage_natureofbusiness(le.natureofbusiness_Invalid),Input_Fields.InvalidMessage_businessstructure(le.businessstructure_Invalid),Input_Fields.InvalidMessage_totalemployees(le.totalemployees_Invalid),Input_Fields.InvalidMessage_avgcontractsize(le.avgcontractsize_Invalid),Input_Fields.InvalidMessage_firmid(le.firmid_Invalid),Input_Fields.InvalidMessage_firmlocationaddress(le.firmlocationaddress_Invalid),Input_Fields.InvalidMessage_firmlocationaddresscity(le.firmlocationaddresscity_Invalid),Input_Fields.InvalidMessage_firmlocationaddresszip4(le.firmlocationaddresszip4_Invalid),Input_Fields.InvalidMessage_firmlocationaddresszipcode(le.firmlocationaddresszipcode_Invalid),Input_Fields.InvalidMessage_firmlocationcounty(le.firmlocationcounty_Invalid),Input_Fields.InvalidMessage_firmlocationstate(le.firmlocationstate_Invalid),Input_Fields.InvalidMessage_certfed(le.certfed_Invalid),Input_Fields.InvalidMessage_certstate(le.certstate_Invalid),Input_Fields.InvalidMessage_contractsfederal(le.contractsfederal_Invalid),Input_Fields.InvalidMessage_contractsva(le.contractsva_Invalid),Input_Fields.InvalidMessage_contractscommercial(le.contractscommercial_Invalid),Input_Fields.InvalidMessage_contractorgovernmentprime(le.contractorgovernmentprime_Invalid),Input_Fields.InvalidMessage_contractorgovernmentsub(le.contractorgovernmentsub_Invalid),Input_Fields.InvalidMessage_contractornongovernment(le.contractornongovernment_Invalid),Input_Fields.InvalidMessage_registeredgovernmentbus(le.registeredgovernmentbus_Invalid),Input_Fields.InvalidMessage_registerednongovernmentbus(le.registerednongovernmentbus_Invalid),Input_Fields.InvalidMessage_clearancelevelpersonnel(le.clearancelevelpersonnel_Invalid),Input_Fields.InvalidMessage_clearancelevelfacility(le.clearancelevelfacility_Invalid),Input_Fields.InvalidMessage_certificatedatefrom1(le.certificatedatefrom1_Invalid),Input_Fields.InvalidMessage_certificatedateto1(le.certificatedateto1_Invalid),Input_Fields.InvalidMessage_certificatestatus1(le.certificatestatus1_Invalid),Input_Fields.InvalidMessage_certificationnumber1(le.certificationnumber1_Invalid),Input_Fields.InvalidMessage_certificationtype1(le.certificationtype1_Invalid),Input_Fields.InvalidMessage_certificatedatefrom2(le.certificatedatefrom2_Invalid),Input_Fields.InvalidMessage_certificatedateto2(le.certificatedateto2_Invalid),Input_Fields.InvalidMessage_certificatestatus2(le.certificatestatus2_Invalid),Input_Fields.InvalidMessage_certificationnumber2(le.certificationnumber2_Invalid),Input_Fields.InvalidMessage_certificationtype2(le.certificationtype2_Invalid),Input_Fields.InvalidMessage_certificatedatefrom3(le.certificatedatefrom3_Invalid),Input_Fields.InvalidMessage_certificatedateto3(le.certificatedateto3_Invalid),Input_Fields.InvalidMessage_certificatestatus3(le.certificatestatus3_Invalid),Input_Fields.InvalidMessage_certificationnumber3(le.certificationnumber3_Invalid),Input_Fields.InvalidMessage_certificationtype3(le.certificationtype3_Invalid),Input_Fields.InvalidMessage_certificatedatefrom4(le.certificatedatefrom4_Invalid),Input_Fields.InvalidMessage_certificatedateto4(le.certificatedateto4_Invalid),Input_Fields.InvalidMessage_certificatestatus4(le.certificatestatus4_Invalid),Input_Fields.InvalidMessage_certificationnumber4(le.certificationnumber4_Invalid),Input_Fields.InvalidMessage_certificationtype4(le.certificationtype4_Invalid),Input_Fields.InvalidMessage_certificatedatefrom5(le.certificatedatefrom5_Invalid),Input_Fields.InvalidMessage_certificatedateto5(le.certificatedateto5_Invalid),Input_Fields.InvalidMessage_certificatestatus5(le.certificatestatus5_Invalid),Input_Fields.InvalidMessage_certificationnumber5(le.certificationnumber5_Invalid),Input_Fields.InvalidMessage_certificationtype5(le.certificationtype5_Invalid),Input_Fields.InvalidMessage_certificatedatefrom6(le.certificatedatefrom6_Invalid),Input_Fields.InvalidMessage_certificatedateto6(le.certificatedateto6_Invalid),Input_Fields.InvalidMessage_certificatestatus6(le.certificatestatus6_Invalid),Input_Fields.InvalidMessage_certificationnumber6(le.certificationnumber6_Invalid),Input_Fields.InvalidMessage_certificationtype6(le.certificationtype6_Invalid),Input_Fields.InvalidMessage_starrating(le.starrating_Invalid),Input_Fields.InvalidMessage_assets(le.assets_Invalid),Input_Fields.InvalidMessage_biddescription(le.biddescription_Invalid),Input_Fields.InvalidMessage_competitiveadvantage(le.competitiveadvantage_Invalid),Input_Fields.InvalidMessage_cagecode(le.cagecode_Invalid),Input_Fields.InvalidMessage_capabilitiesnarrative(le.capabilitiesnarrative_Invalid),Input_Fields.InvalidMessage_category(le.category_Invalid),Input_Fields.InvalidMessage_chtrclass(le.chtrclass_Invalid),Input_Fields.InvalidMessage_productdescription1(le.productdescription1_Invalid),Input_Fields.InvalidMessage_productdescription2(le.productdescription2_Invalid),Input_Fields.InvalidMessage_productdescription3(le.productdescription3_Invalid),Input_Fields.InvalidMessage_productdescription4(le.productdescription4_Invalid),Input_Fields.InvalidMessage_productdescription5(le.productdescription5_Invalid),Input_Fields.InvalidMessage_classdescription1(le.classdescription1_Invalid),Input_Fields.InvalidMessage_subclassdescription1(le.subclassdescription1_Invalid),Input_Fields.InvalidMessage_classdescription2(le.classdescription2_Invalid),Input_Fields.InvalidMessage_subclassdescription2(le.subclassdescription2_Invalid),Input_Fields.InvalidMessage_classdescription3(le.classdescription3_Invalid),Input_Fields.InvalidMessage_subclassdescription3(le.subclassdescription3_Invalid),Input_Fields.InvalidMessage_classdescription4(le.classdescription4_Invalid),Input_Fields.InvalidMessage_subclassdescription4(le.subclassdescription4_Invalid),Input_Fields.InvalidMessage_classdescription5(le.classdescription5_Invalid),Input_Fields.InvalidMessage_subclassdescription5(le.subclassdescription5_Invalid),Input_Fields.InvalidMessage_classifications(le.classifications_Invalid),Input_Fields.InvalidMessage_commodity1(le.commodity1_Invalid),Input_Fields.InvalidMessage_commodity2(le.commodity2_Invalid),Input_Fields.InvalidMessage_commodity3(le.commodity3_Invalid),Input_Fields.InvalidMessage_commodity4(le.commodity4_Invalid),Input_Fields.InvalidMessage_commodity5(le.commodity5_Invalid),Input_Fields.InvalidMessage_commodity6(le.commodity6_Invalid),Input_Fields.InvalidMessage_commodity7(le.commodity7_Invalid),Input_Fields.InvalidMessage_commodity8(le.commodity8_Invalid),Input_Fields.InvalidMessage_completedate(le.completedate_Invalid),Input_Fields.InvalidMessage_crossreference(le.crossreference_Invalid),Input_Fields.InvalidMessage_dateestablished(le.dateestablished_Invalid),Input_Fields.InvalidMessage_businessage(le.businessage_Invalid),Input_Fields.InvalidMessage_deposits(le.deposits_Invalid),Input_Fields.InvalidMessage_dunsnumber(le.dunsnumber_Invalid),Input_Fields.InvalidMessage_enttype(le.enttype_Invalid),Input_Fields.InvalidMessage_expirationdate(le.expirationdate_Invalid),Input_Fields.InvalidMessage_extendeddate(le.extendeddate_Invalid),Input_Fields.InvalidMessage_issuingauthority(le.issuingauthority_Invalid),Input_Fields.InvalidMessage_keywords(le.keywords_Invalid),Input_Fields.InvalidMessage_licensenumber(le.licensenumber_Invalid),Input_Fields.InvalidMessage_licensetype(le.licensetype_Invalid),Input_Fields.InvalidMessage_mincd(le.mincd_Invalid),Input_Fields.InvalidMessage_minorityaffiliation(le.minorityaffiliation_Invalid),Input_Fields.InvalidMessage_minorityownershipdate(le.minorityownershipdate_Invalid),Input_Fields.InvalidMessage_siccode1(le.siccode1_Invalid),Input_Fields.InvalidMessage_siccode2(le.siccode2_Invalid),Input_Fields.InvalidMessage_siccode3(le.siccode3_Invalid),Input_Fields.InvalidMessage_siccode4(le.siccode4_Invalid),Input_Fields.InvalidMessage_siccode5(le.siccode5_Invalid),Input_Fields.InvalidMessage_siccode6(le.siccode6_Invalid),Input_Fields.InvalidMessage_siccode7(le.siccode7_Invalid),Input_Fields.InvalidMessage_siccode8(le.siccode8_Invalid),Input_Fields.InvalidMessage_naicscode1(le.naicscode1_Invalid),Input_Fields.InvalidMessage_naicscode2(le.naicscode2_Invalid),Input_Fields.InvalidMessage_naicscode3(le.naicscode3_Invalid),Input_Fields.InvalidMessage_naicscode4(le.naicscode4_Invalid),Input_Fields.InvalidMessage_naicscode5(le.naicscode5_Invalid),Input_Fields.InvalidMessage_naicscode6(le.naicscode6_Invalid),Input_Fields.InvalidMessage_naicscode7(le.naicscode7_Invalid),Input_Fields.InvalidMessage_naicscode8(le.naicscode8_Invalid),Input_Fields.InvalidMessage_prequalify(le.prequalify_Invalid),Input_Fields.InvalidMessage_procurementcategory1(le.procurementcategory1_Invalid),Input_Fields.InvalidMessage_subprocurementcategory1(le.subprocurementcategory1_Invalid),Input_Fields.InvalidMessage_procurementcategory2(le.procurementcategory2_Invalid),Input_Fields.InvalidMessage_subprocurementcategory2(le.subprocurementcategory2_Invalid),Input_Fields.InvalidMessage_procurementcategory3(le.procurementcategory3_Invalid),Input_Fields.InvalidMessage_subprocurementcategory3(le.subprocurementcategory3_Invalid),Input_Fields.InvalidMessage_procurementcategory4(le.procurementcategory4_Invalid),Input_Fields.InvalidMessage_subprocurementcategory4(le.subprocurementcategory4_Invalid),Input_Fields.InvalidMessage_procurementcategory5(le.procurementcategory5_Invalid),Input_Fields.InvalidMessage_subprocurementcategory5(le.subprocurementcategory5_Invalid),Input_Fields.InvalidMessage_renewal(le.renewal_Invalid),Input_Fields.InvalidMessage_renewaldate(le.renewaldate_Invalid),Input_Fields.InvalidMessage_unitedcertprogrampartner(le.unitedcertprogrampartner_Invalid),Input_Fields.InvalidMessage_vendorkey(le.vendorkey_Invalid),Input_Fields.InvalidMessage_vendornumber(le.vendornumber_Invalid),Input_Fields.InvalidMessage_workcode1(le.workcode1_Invalid),Input_Fields.InvalidMessage_workcode2(le.workcode2_Invalid),Input_Fields.InvalidMessage_workcode3(le.workcode3_Invalid),Input_Fields.InvalidMessage_workcode4(le.workcode4_Invalid),Input_Fields.InvalidMessage_workcode5(le.workcode5_Invalid),Input_Fields.InvalidMessage_workcode6(le.workcode6_Invalid),Input_Fields.InvalidMessage_workcode7(le.workcode7_Invalid),Input_Fields.InvalidMessage_workcode8(le.workcode8_Invalid),Input_Fields.InvalidMessage_exporter(le.exporter_Invalid),Input_Fields.InvalidMessage_exportbusinessactivities(le.exportbusinessactivities_Invalid),Input_Fields.InvalidMessage_exportto(le.exportto_Invalid),Input_Fields.InvalidMessage_exportbusinessrelationships(le.exportbusinessrelationships_Invalid),Input_Fields.InvalidMessage_exportobjectives(le.exportobjectives_Invalid),Input_Fields.InvalidMessage_reference1(le.reference1_Invalid),Input_Fields.InvalidMessage_reference2(le.reference2_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dartid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dateadded_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dateupdated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.website_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.profilelastupdated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.servicearea_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.region1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.region2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.region3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.region4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.region5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ethnicity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addresscity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addressstate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addresszipcode_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.addresszip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.building_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cell_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fax_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.email1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.email2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.email3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.webpage1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.webpage2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.webpage3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businessname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dba_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businessid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesstype1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesslocation1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesstype2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesslocation2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesstype3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesslocation3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesstype4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesslocation4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesstype5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesslocation5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.industry_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.trade_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.resourcedescription_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.natureofbusiness_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businessstructure_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.totalemployees_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.avgcontractsize_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.firmid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.firmlocationaddress_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.firmlocationaddresscity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.firmlocationaddresszip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.firmlocationaddresszipcode_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.firmlocationcounty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.firmlocationstate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certfed_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certstate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contractsfederal_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contractsva_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contractscommercial_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contractorgovernmentprime_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contractorgovernmentsub_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contractornongovernment_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.registeredgovernmentbus_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.registerednongovernmentbus_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clearancelevelpersonnel_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clearancelevelfacility_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificatedatefrom1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatedateto1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatestatus1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationnumber1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationtype1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificatedatefrom2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatedateto2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatestatus2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationnumber2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationtype2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificatedatefrom3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatedateto3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatestatus3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationnumber3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationtype3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificatedatefrom4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatedateto4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatestatus4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationnumber4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationtype4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificatedatefrom5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatedateto5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatestatus5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationnumber5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationtype5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificatedatefrom6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatedateto6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.certificatestatus6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationnumber6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.certificationtype6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.starrating_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.assets_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.biddescription_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.competitiveadvantage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cagecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.capabilitiesnarrative_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.category_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.chtrclass_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.productdescription1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.productdescription2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.productdescription3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.productdescription4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.productdescription5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.classdescription1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subclassdescription1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.classdescription2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subclassdescription2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.classdescription3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subclassdescription3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.classdescription4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subclassdescription4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.classdescription5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subclassdescription5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.classifications_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.commodity1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.commodity2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.commodity3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.commodity4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.commodity5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.commodity6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.commodity7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.commodity8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.completedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.crossreference_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dateestablished_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.businessage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.deposits_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dunsnumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.enttype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expirationdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.extendeddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.issuingauthority_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.keywords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.licensenumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.licensetype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mincd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.minorityaffiliation_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.minorityownershipdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.siccode1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.siccode2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.siccode3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.siccode4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.siccode5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.siccode6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.siccode7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.siccode8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naicscode1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naicscode2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naicscode3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naicscode4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naicscode5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naicscode6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naicscode7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.naicscode8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prequalify_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.procurementcategory1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subprocurementcategory1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.procurementcategory2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subprocurementcategory2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.procurementcategory3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subprocurementcategory3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.procurementcategory4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subprocurementcategory4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.procurementcategory5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subprocurementcategory5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.renewal_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.renewaldate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.unitedcertprogrampartner_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendorkey_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendornumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.workcode1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.workcode2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.workcode3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.workcode4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.workcode5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.workcode6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.workcode7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.workcode8_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.exporter_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.exportbusinessactivities_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.exportto_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.exportbusinessrelationships_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.exportobjectives_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reference1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.reference2_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dartid','dateadded','dateupdated','website','state','profilelastupdated','county','servicearea','region1','region2','region3','region4','region5','fname','lname','mname','suffix','title','ethnicity','gender','address1','address2','addresscity','addressstate','addresszipcode','addresszip4','building','contact','phone1','phone2','phone3','cell','fax','email1','email2','email3','webpage1','webpage2','webpage3','businessname','dba','businessid','businesstype1','businesslocation1','businesstype2','businesslocation2','businesstype3','businesslocation3','businesstype4','businesslocation4','businesstype5','businesslocation5','industry','trade','resourcedescription','natureofbusiness','businessstructure','totalemployees','avgcontractsize','firmid','firmlocationaddress','firmlocationaddresscity','firmlocationaddresszip4','firmlocationaddresszipcode','firmlocationcounty','firmlocationstate','certfed','certstate','contractsfederal','contractsva','contractscommercial','contractorgovernmentprime','contractorgovernmentsub','contractornongovernment','registeredgovernmentbus','registerednongovernmentbus','clearancelevelpersonnel','clearancelevelfacility','certificatedatefrom1','certificatedateto1','certificatestatus1','certificationnumber1','certificationtype1','certificatedatefrom2','certificatedateto2','certificatestatus2','certificationnumber2','certificationtype2','certificatedatefrom3','certificatedateto3','certificatestatus3','certificationnumber3','certificationtype3','certificatedatefrom4','certificatedateto4','certificatestatus4','certificationnumber4','certificationtype4','certificatedatefrom5','certificatedateto5','certificatestatus5','certificationnumber5','certificationtype5','certificatedatefrom6','certificatedateto6','certificatestatus6','certificationnumber6','certificationtype6','starrating','assets','biddescription','competitiveadvantage','cagecode','capabilitiesnarrative','category','chtrclass','productdescription1','productdescription2','productdescription3','productdescription4','productdescription5','classdescription1','subclassdescription1','classdescription2','subclassdescription2','classdescription3','subclassdescription3','classdescription4','subclassdescription4','classdescription5','subclassdescription5','classifications','commodity1','commodity2','commodity3','commodity4','commodity5','commodity6','commodity7','commodity8','completedate','crossreference','dateestablished','businessage','deposits','dunsnumber','enttype','expirationdate','extendeddate','issuingauthority','keywords','licensenumber','licensetype','mincd','minorityaffiliation','minorityownershipdate','siccode1','siccode2','siccode3','siccode4','siccode5','siccode6','siccode7','siccode8','naicscode1','naicscode2','naicscode3','naicscode4','naicscode5','naicscode6','naicscode7','naicscode8','prequalify','procurementcategory1','subprocurementcategory1','procurementcategory2','subprocurementcategory2','procurementcategory3','subprocurementcategory3','procurementcategory4','subprocurementcategory4','procurementcategory5','subprocurementcategory5','renewal','renewaldate','unitedcertprogrampartner','vendorkey','vendornumber','workcode1','workcode2','workcode3','workcode4','workcode5','workcode6','workcode7','workcode8','exporter','exportbusinessactivities','exportto','exportbusinessrelationships','exportobjectives','reference1','reference2','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_AlphaNumChar','Invalid_State','Invalid_Date','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_AlphaNum','Invalid_Alpha','Invalid_State','Invalid_Zip','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Phone','Invalid_Phone','Invalid_Phone','Invalid_Phone','Invalid_Phone','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_Float','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaChar','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_No','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_No','Invalid_Zip','Invalid_Alpha','Invalid_State','Invalid_Alpha','Invalid_State','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_Date','Invalid_Future','Invalid_Alpha','Invalid_Float','Invalid_AlphaChar','Invalid_No','Invalid_Float','Invalid_AlphaChar','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Commodity','Invalid_Date','Invalid_Alpha','Invalid_Date','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Future','Invalid_Future','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaNum','Invalid_Alpha','Invalid_No','Invalid_Alpha','Invalid_Date','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_Sic','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_NAICS','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Future','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dartid,(SALT311.StrType)le.dateadded,(SALT311.StrType)le.dateupdated,(SALT311.StrType)le.website,(SALT311.StrType)le.state,(SALT311.StrType)le.profilelastupdated,(SALT311.StrType)le.county,(SALT311.StrType)le.servicearea,(SALT311.StrType)le.region1,(SALT311.StrType)le.region2,(SALT311.StrType)le.region3,(SALT311.StrType)le.region4,(SALT311.StrType)le.region5,(SALT311.StrType)le.fname,(SALT311.StrType)le.lname,(SALT311.StrType)le.mname,(SALT311.StrType)le.suffix,(SALT311.StrType)le.title,(SALT311.StrType)le.ethnicity,(SALT311.StrType)le.gender,(SALT311.StrType)le.address1,(SALT311.StrType)le.address2,(SALT311.StrType)le.addresscity,(SALT311.StrType)le.addressstate,(SALT311.StrType)le.addresszipcode,(SALT311.StrType)le.addresszip4,(SALT311.StrType)le.building,(SALT311.StrType)le.contact,(SALT311.StrType)le.phone1,(SALT311.StrType)le.phone2,(SALT311.StrType)le.phone3,(SALT311.StrType)le.cell,(SALT311.StrType)le.fax,(SALT311.StrType)le.email1,(SALT311.StrType)le.email2,(SALT311.StrType)le.email3,(SALT311.StrType)le.webpage1,(SALT311.StrType)le.webpage2,(SALT311.StrType)le.webpage3,(SALT311.StrType)le.businessname,(SALT311.StrType)le.dba,(SALT311.StrType)le.businessid,(SALT311.StrType)le.businesstype1,(SALT311.StrType)le.businesslocation1,(SALT311.StrType)le.businesstype2,(SALT311.StrType)le.businesslocation2,(SALT311.StrType)le.businesstype3,(SALT311.StrType)le.businesslocation3,(SALT311.StrType)le.businesstype4,(SALT311.StrType)le.businesslocation4,(SALT311.StrType)le.businesstype5,(SALT311.StrType)le.businesslocation5,(SALT311.StrType)le.industry,(SALT311.StrType)le.trade,(SALT311.StrType)le.resourcedescription,(SALT311.StrType)le.natureofbusiness,(SALT311.StrType)le.businessstructure,(SALT311.StrType)le.totalemployees,(SALT311.StrType)le.avgcontractsize,(SALT311.StrType)le.firmid,(SALT311.StrType)le.firmlocationaddress,(SALT311.StrType)le.firmlocationaddresscity,(SALT311.StrType)le.firmlocationaddresszip4,(SALT311.StrType)le.firmlocationaddresszipcode,(SALT311.StrType)le.firmlocationcounty,(SALT311.StrType)le.firmlocationstate,(SALT311.StrType)le.certfed,(SALT311.StrType)le.certstate,(SALT311.StrType)le.contractsfederal,(SALT311.StrType)le.contractsva,(SALT311.StrType)le.contractscommercial,(SALT311.StrType)le.contractorgovernmentprime,(SALT311.StrType)le.contractorgovernmentsub,(SALT311.StrType)le.contractornongovernment,(SALT311.StrType)le.registeredgovernmentbus,(SALT311.StrType)le.registerednongovernmentbus,(SALT311.StrType)le.clearancelevelpersonnel,(SALT311.StrType)le.clearancelevelfacility,(SALT311.StrType)le.certificatedatefrom1,(SALT311.StrType)le.certificatedateto1,(SALT311.StrType)le.certificatestatus1,(SALT311.StrType)le.certificationnumber1,(SALT311.StrType)le.certificationtype1,(SALT311.StrType)le.certificatedatefrom2,(SALT311.StrType)le.certificatedateto2,(SALT311.StrType)le.certificatestatus2,(SALT311.StrType)le.certificationnumber2,(SALT311.StrType)le.certificationtype2,(SALT311.StrType)le.certificatedatefrom3,(SALT311.StrType)le.certificatedateto3,(SALT311.StrType)le.certificatestatus3,(SALT311.StrType)le.certificationnumber3,(SALT311.StrType)le.certificationtype3,(SALT311.StrType)le.certificatedatefrom4,(SALT311.StrType)le.certificatedateto4,(SALT311.StrType)le.certificatestatus4,(SALT311.StrType)le.certificationnumber4,(SALT311.StrType)le.certificationtype4,(SALT311.StrType)le.certificatedatefrom5,(SALT311.StrType)le.certificatedateto5,(SALT311.StrType)le.certificatestatus5,(SALT311.StrType)le.certificationnumber5,(SALT311.StrType)le.certificationtype5,(SALT311.StrType)le.certificatedatefrom6,(SALT311.StrType)le.certificatedateto6,(SALT311.StrType)le.certificatestatus6,(SALT311.StrType)le.certificationnumber6,(SALT311.StrType)le.certificationtype6,(SALT311.StrType)le.starrating,(SALT311.StrType)le.assets,(SALT311.StrType)le.biddescription,(SALT311.StrType)le.competitiveadvantage,(SALT311.StrType)le.cagecode,(SALT311.StrType)le.capabilitiesnarrative,(SALT311.StrType)le.category,(SALT311.StrType)le.chtrclass,(SALT311.StrType)le.productdescription1,(SALT311.StrType)le.productdescription2,(SALT311.StrType)le.productdescription3,(SALT311.StrType)le.productdescription4,(SALT311.StrType)le.productdescription5,(SALT311.StrType)le.classdescription1,(SALT311.StrType)le.subclassdescription1,(SALT311.StrType)le.classdescription2,(SALT311.StrType)le.subclassdescription2,(SALT311.StrType)le.classdescription3,(SALT311.StrType)le.subclassdescription3,(SALT311.StrType)le.classdescription4,(SALT311.StrType)le.subclassdescription4,(SALT311.StrType)le.classdescription5,(SALT311.StrType)le.subclassdescription5,(SALT311.StrType)le.classifications,(SALT311.StrType)le.commodity1,(SALT311.StrType)le.commodity2,(SALT311.StrType)le.commodity3,(SALT311.StrType)le.commodity4,(SALT311.StrType)le.commodity5,(SALT311.StrType)le.commodity6,(SALT311.StrType)le.commodity7,(SALT311.StrType)le.commodity8,(SALT311.StrType)le.completedate,(SALT311.StrType)le.crossreference,(SALT311.StrType)le.dateestablished,(SALT311.StrType)le.businessage,(SALT311.StrType)le.deposits,(SALT311.StrType)le.dunsnumber,(SALT311.StrType)le.enttype,(SALT311.StrType)le.expirationdate,(SALT311.StrType)le.extendeddate,(SALT311.StrType)le.issuingauthority,(SALT311.StrType)le.keywords,(SALT311.StrType)le.licensenumber,(SALT311.StrType)le.licensetype,(SALT311.StrType)le.mincd,(SALT311.StrType)le.minorityaffiliation,(SALT311.StrType)le.minorityownershipdate,(SALT311.StrType)le.siccode1,(SALT311.StrType)le.siccode2,(SALT311.StrType)le.siccode3,(SALT311.StrType)le.siccode4,(SALT311.StrType)le.siccode5,(SALT311.StrType)le.siccode6,(SALT311.StrType)le.siccode7,(SALT311.StrType)le.siccode8,(SALT311.StrType)le.naicscode1,(SALT311.StrType)le.naicscode2,(SALT311.StrType)le.naicscode3,(SALT311.StrType)le.naicscode4,(SALT311.StrType)le.naicscode5,(SALT311.StrType)le.naicscode6,(SALT311.StrType)le.naicscode7,(SALT311.StrType)le.naicscode8,(SALT311.StrType)le.prequalify,(SALT311.StrType)le.procurementcategory1,(SALT311.StrType)le.subprocurementcategory1,(SALT311.StrType)le.procurementcategory2,(SALT311.StrType)le.subprocurementcategory2,(SALT311.StrType)le.procurementcategory3,(SALT311.StrType)le.subprocurementcategory3,(SALT311.StrType)le.procurementcategory4,(SALT311.StrType)le.subprocurementcategory4,(SALT311.StrType)le.procurementcategory5,(SALT311.StrType)le.subprocurementcategory5,(SALT311.StrType)le.renewal,(SALT311.StrType)le.renewaldate,(SALT311.StrType)le.unitedcertprogrampartner,(SALT311.StrType)le.vendorkey,(SALT311.StrType)le.vendornumber,(SALT311.StrType)le.workcode1,(SALT311.StrType)le.workcode2,(SALT311.StrType)le.workcode3,(SALT311.StrType)le.workcode4,(SALT311.StrType)le.workcode5,(SALT311.StrType)le.workcode6,(SALT311.StrType)le.workcode7,(SALT311.StrType)le.workcode8,(SALT311.StrType)le.exporter,(SALT311.StrType)le.exportbusinessactivities,(SALT311.StrType)le.exportto,(SALT311.StrType)le.exportbusinessrelationships,(SALT311.StrType)le.exportobjectives,(SALT311.StrType)le.reference1,(SALT311.StrType)le.reference2,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,203,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_Layout_Diversity_Certification) prevDS = DATASET([], Input_Layout_Diversity_Certification), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dartid_ALLOW_ErrorCount
          ,le.dateadded_CUSTOM_ErrorCount
          ,le.dateupdated_CUSTOM_ErrorCount
          ,le.website_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.profilelastupdated_CUSTOM_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.servicearea_ALLOW_ErrorCount
          ,le.region1_ALLOW_ErrorCount
          ,le.region2_ALLOW_ErrorCount
          ,le.region3_ALLOW_ErrorCount
          ,le.region4_ALLOW_ErrorCount
          ,le.region5_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.ethnicity_ALLOW_ErrorCount
          ,le.gender_ALLOW_ErrorCount
          ,le.address1_ALLOW_ErrorCount
          ,le.address2_ALLOW_ErrorCount
          ,le.addresscity_ALLOW_ErrorCount
          ,le.addressstate_CUSTOM_ErrorCount
          ,le.addresszipcode_ALLOW_ErrorCount,le.addresszipcode_LENGTHS_ErrorCount
          ,le.addresszip4_ALLOW_ErrorCount
          ,le.building_ALLOW_ErrorCount
          ,le.contact_ALLOW_ErrorCount
          ,le.phone1_CUSTOM_ErrorCount
          ,le.phone2_CUSTOM_ErrorCount
          ,le.phone3_CUSTOM_ErrorCount
          ,le.cell_CUSTOM_ErrorCount
          ,le.fax_CUSTOM_ErrorCount
          ,le.email1_ALLOW_ErrorCount
          ,le.email2_ALLOW_ErrorCount
          ,le.email3_ALLOW_ErrorCount
          ,le.webpage1_ALLOW_ErrorCount
          ,le.webpage2_ALLOW_ErrorCount
          ,le.webpage3_ALLOW_ErrorCount
          ,le.businessname_ALLOW_ErrorCount
          ,le.dba_ALLOW_ErrorCount
          ,le.businessid_ALLOW_ErrorCount
          ,le.businesstype1_ALLOW_ErrorCount
          ,le.businesslocation1_ALLOW_ErrorCount
          ,le.businesstype2_ALLOW_ErrorCount
          ,le.businesslocation2_ALLOW_ErrorCount
          ,le.businesstype3_ALLOW_ErrorCount
          ,le.businesslocation3_ALLOW_ErrorCount
          ,le.businesstype4_ALLOW_ErrorCount
          ,le.businesslocation4_ALLOW_ErrorCount
          ,le.businesstype5_ALLOW_ErrorCount
          ,le.businesslocation5_ALLOW_ErrorCount
          ,le.industry_ALLOW_ErrorCount
          ,le.trade_ALLOW_ErrorCount
          ,le.resourcedescription_ALLOW_ErrorCount
          ,le.natureofbusiness_ALLOW_ErrorCount
          ,le.businessstructure_ALLOW_ErrorCount
          ,le.totalemployees_ALLOW_ErrorCount
          ,le.avgcontractsize_ALLOW_ErrorCount
          ,le.firmid_ALLOW_ErrorCount
          ,le.firmlocationaddress_ALLOW_ErrorCount
          ,le.firmlocationaddresscity_ALLOW_ErrorCount
          ,le.firmlocationaddresszip4_ALLOW_ErrorCount
          ,le.firmlocationaddresszipcode_ALLOW_ErrorCount,le.firmlocationaddresszipcode_LENGTHS_ErrorCount
          ,le.firmlocationcounty_ALLOW_ErrorCount
          ,le.firmlocationstate_CUSTOM_ErrorCount
          ,le.certfed_ALLOW_ErrorCount
          ,le.certstate_CUSTOM_ErrorCount
          ,le.contractsfederal_ALLOW_ErrorCount
          ,le.contractsva_ALLOW_ErrorCount
          ,le.contractscommercial_ALLOW_ErrorCount
          ,le.contractorgovernmentprime_ALLOW_ErrorCount
          ,le.contractorgovernmentsub_ALLOW_ErrorCount
          ,le.contractornongovernment_ALLOW_ErrorCount
          ,le.registeredgovernmentbus_ALLOW_ErrorCount
          ,le.registerednongovernmentbus_ALLOW_ErrorCount
          ,le.clearancelevelpersonnel_ALLOW_ErrorCount
          ,le.clearancelevelfacility_ALLOW_ErrorCount
          ,le.certificatedatefrom1_CUSTOM_ErrorCount
          ,le.certificatedateto1_CUSTOM_ErrorCount
          ,le.certificatestatus1_ALLOW_ErrorCount
          ,le.certificationnumber1_ALLOW_ErrorCount
          ,le.certificationtype1_ALLOW_ErrorCount
          ,le.certificatedatefrom2_CUSTOM_ErrorCount
          ,le.certificatedateto2_CUSTOM_ErrorCount
          ,le.certificatestatus2_ALLOW_ErrorCount
          ,le.certificationnumber2_ALLOW_ErrorCount
          ,le.certificationtype2_ALLOW_ErrorCount
          ,le.certificatedatefrom3_CUSTOM_ErrorCount
          ,le.certificatedateto3_CUSTOM_ErrorCount
          ,le.certificatestatus3_ALLOW_ErrorCount
          ,le.certificationnumber3_ALLOW_ErrorCount
          ,le.certificationtype3_ALLOW_ErrorCount
          ,le.certificatedatefrom4_CUSTOM_ErrorCount
          ,le.certificatedateto4_CUSTOM_ErrorCount
          ,le.certificatestatus4_ALLOW_ErrorCount
          ,le.certificationnumber4_ALLOW_ErrorCount
          ,le.certificationtype4_ALLOW_ErrorCount
          ,le.certificatedatefrom5_CUSTOM_ErrorCount
          ,le.certificatedateto5_CUSTOM_ErrorCount
          ,le.certificatestatus5_ALLOW_ErrorCount
          ,le.certificationnumber5_ALLOW_ErrorCount
          ,le.certificationtype5_ALLOW_ErrorCount
          ,le.certificatedatefrom6_CUSTOM_ErrorCount
          ,le.certificatedateto6_CUSTOM_ErrorCount
          ,le.certificatestatus6_ALLOW_ErrorCount
          ,le.certificationnumber6_ALLOW_ErrorCount
          ,le.certificationtype6_ALLOW_ErrorCount
          ,le.starrating_ALLOW_ErrorCount
          ,le.assets_ALLOW_ErrorCount
          ,le.biddescription_ALLOW_ErrorCount
          ,le.competitiveadvantage_ALLOW_ErrorCount
          ,le.cagecode_ALLOW_ErrorCount
          ,le.capabilitiesnarrative_ALLOW_ErrorCount
          ,le.category_ALLOW_ErrorCount
          ,le.chtrclass_ALLOW_ErrorCount
          ,le.productdescription1_ALLOW_ErrorCount
          ,le.productdescription2_ALLOW_ErrorCount
          ,le.productdescription3_ALLOW_ErrorCount
          ,le.productdescription4_ALLOW_ErrorCount
          ,le.productdescription5_ALLOW_ErrorCount
          ,le.classdescription1_ALLOW_ErrorCount
          ,le.subclassdescription1_ALLOW_ErrorCount
          ,le.classdescription2_ALLOW_ErrorCount
          ,le.subclassdescription2_ALLOW_ErrorCount
          ,le.classdescription3_ALLOW_ErrorCount
          ,le.subclassdescription3_ALLOW_ErrorCount
          ,le.classdescription4_ALLOW_ErrorCount
          ,le.subclassdescription4_ALLOW_ErrorCount
          ,le.classdescription5_ALLOW_ErrorCount
          ,le.subclassdescription5_ALLOW_ErrorCount
          ,le.classifications_ALLOW_ErrorCount
          ,le.commodity1_CUSTOM_ErrorCount
          ,le.commodity2_CUSTOM_ErrorCount
          ,le.commodity3_CUSTOM_ErrorCount
          ,le.commodity4_CUSTOM_ErrorCount
          ,le.commodity5_CUSTOM_ErrorCount
          ,le.commodity6_CUSTOM_ErrorCount
          ,le.commodity7_CUSTOM_ErrorCount
          ,le.commodity8_CUSTOM_ErrorCount
          ,le.completedate_CUSTOM_ErrorCount
          ,le.crossreference_ALLOW_ErrorCount
          ,le.dateestablished_CUSTOM_ErrorCount
          ,le.businessage_ALLOW_ErrorCount
          ,le.deposits_ALLOW_ErrorCount
          ,le.dunsnumber_ALLOW_ErrorCount
          ,le.enttype_ALLOW_ErrorCount
          ,le.expirationdate_CUSTOM_ErrorCount
          ,le.extendeddate_CUSTOM_ErrorCount
          ,le.issuingauthority_ALLOW_ErrorCount
          ,le.keywords_ALLOW_ErrorCount
          ,le.licensenumber_ALLOW_ErrorCount
          ,le.licensetype_ALLOW_ErrorCount
          ,le.mincd_ALLOW_ErrorCount
          ,le.minorityaffiliation_ALLOW_ErrorCount
          ,le.minorityownershipdate_CUSTOM_ErrorCount
          ,le.siccode1_CUSTOM_ErrorCount
          ,le.siccode2_CUSTOM_ErrorCount
          ,le.siccode3_CUSTOM_ErrorCount
          ,le.siccode4_CUSTOM_ErrorCount
          ,le.siccode5_CUSTOM_ErrorCount
          ,le.siccode6_CUSTOM_ErrorCount
          ,le.siccode7_CUSTOM_ErrorCount
          ,le.siccode8_CUSTOM_ErrorCount
          ,le.naicscode1_CUSTOM_ErrorCount
          ,le.naicscode2_CUSTOM_ErrorCount
          ,le.naicscode3_CUSTOM_ErrorCount
          ,le.naicscode4_CUSTOM_ErrorCount
          ,le.naicscode5_CUSTOM_ErrorCount
          ,le.naicscode6_CUSTOM_ErrorCount
          ,le.naicscode7_CUSTOM_ErrorCount
          ,le.naicscode8_CUSTOM_ErrorCount
          ,le.prequalify_ALLOW_ErrorCount
          ,le.procurementcategory1_ALLOW_ErrorCount
          ,le.subprocurementcategory1_ALLOW_ErrorCount
          ,le.procurementcategory2_ALLOW_ErrorCount
          ,le.subprocurementcategory2_ALLOW_ErrorCount
          ,le.procurementcategory3_ALLOW_ErrorCount
          ,le.subprocurementcategory3_ALLOW_ErrorCount
          ,le.procurementcategory4_ALLOW_ErrorCount
          ,le.subprocurementcategory4_ALLOW_ErrorCount
          ,le.procurementcategory5_ALLOW_ErrorCount
          ,le.subprocurementcategory5_ALLOW_ErrorCount
          ,le.renewal_ALLOW_ErrorCount
          ,le.renewaldate_CUSTOM_ErrorCount
          ,le.unitedcertprogrampartner_ALLOW_ErrorCount
          ,le.vendorkey_ALLOW_ErrorCount
          ,le.vendornumber_ALLOW_ErrorCount
          ,le.workcode1_ALLOW_ErrorCount
          ,le.workcode2_ALLOW_ErrorCount
          ,le.workcode3_ALLOW_ErrorCount
          ,le.workcode4_ALLOW_ErrorCount
          ,le.workcode5_ALLOW_ErrorCount
          ,le.workcode6_ALLOW_ErrorCount
          ,le.workcode7_ALLOW_ErrorCount
          ,le.workcode8_ALLOW_ErrorCount
          ,le.exporter_ALLOW_ErrorCount
          ,le.exportbusinessactivities_ALLOW_ErrorCount
          ,le.exportto_ALLOW_ErrorCount
          ,le.exportbusinessrelationships_ALLOW_ErrorCount
          ,le.exportobjectives_ALLOW_ErrorCount
          ,le.reference1_ALLOW_ErrorCount
          ,le.reference2_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dartid_ALLOW_ErrorCount
          ,le.dateadded_CUSTOM_ErrorCount
          ,le.dateupdated_CUSTOM_ErrorCount
          ,le.website_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.profilelastupdated_CUSTOM_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.servicearea_ALLOW_ErrorCount
          ,le.region1_ALLOW_ErrorCount
          ,le.region2_ALLOW_ErrorCount
          ,le.region3_ALLOW_ErrorCount
          ,le.region4_ALLOW_ErrorCount
          ,le.region5_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.ethnicity_ALLOW_ErrorCount
          ,le.gender_ALLOW_ErrorCount
          ,le.address1_ALLOW_ErrorCount
          ,le.address2_ALLOW_ErrorCount
          ,le.addresscity_ALLOW_ErrorCount
          ,le.addressstate_CUSTOM_ErrorCount
          ,le.addresszipcode_ALLOW_ErrorCount,le.addresszipcode_LENGTHS_ErrorCount
          ,le.addresszip4_ALLOW_ErrorCount
          ,le.building_ALLOW_ErrorCount
          ,le.contact_ALLOW_ErrorCount
          ,le.phone1_CUSTOM_ErrorCount
          ,le.phone2_CUSTOM_ErrorCount
          ,le.phone3_CUSTOM_ErrorCount
          ,le.cell_CUSTOM_ErrorCount
          ,le.fax_CUSTOM_ErrorCount
          ,le.email1_ALLOW_ErrorCount
          ,le.email2_ALLOW_ErrorCount
          ,le.email3_ALLOW_ErrorCount
          ,le.webpage1_ALLOW_ErrorCount
          ,le.webpage2_ALLOW_ErrorCount
          ,le.webpage3_ALLOW_ErrorCount
          ,le.businessname_ALLOW_ErrorCount
          ,le.dba_ALLOW_ErrorCount
          ,le.businessid_ALLOW_ErrorCount
          ,le.businesstype1_ALLOW_ErrorCount
          ,le.businesslocation1_ALLOW_ErrorCount
          ,le.businesstype2_ALLOW_ErrorCount
          ,le.businesslocation2_ALLOW_ErrorCount
          ,le.businesstype3_ALLOW_ErrorCount
          ,le.businesslocation3_ALLOW_ErrorCount
          ,le.businesstype4_ALLOW_ErrorCount
          ,le.businesslocation4_ALLOW_ErrorCount
          ,le.businesstype5_ALLOW_ErrorCount
          ,le.businesslocation5_ALLOW_ErrorCount
          ,le.industry_ALLOW_ErrorCount
          ,le.trade_ALLOW_ErrorCount
          ,le.resourcedescription_ALLOW_ErrorCount
          ,le.natureofbusiness_ALLOW_ErrorCount
          ,le.businessstructure_ALLOW_ErrorCount
          ,le.totalemployees_ALLOW_ErrorCount
          ,le.avgcontractsize_ALLOW_ErrorCount
          ,le.firmid_ALLOW_ErrorCount
          ,le.firmlocationaddress_ALLOW_ErrorCount
          ,le.firmlocationaddresscity_ALLOW_ErrorCount
          ,le.firmlocationaddresszip4_ALLOW_ErrorCount
          ,le.firmlocationaddresszipcode_ALLOW_ErrorCount,le.firmlocationaddresszipcode_LENGTHS_ErrorCount
          ,le.firmlocationcounty_ALLOW_ErrorCount
          ,le.firmlocationstate_CUSTOM_ErrorCount
          ,le.certfed_ALLOW_ErrorCount
          ,le.certstate_CUSTOM_ErrorCount
          ,le.contractsfederal_ALLOW_ErrorCount
          ,le.contractsva_ALLOW_ErrorCount
          ,le.contractscommercial_ALLOW_ErrorCount
          ,le.contractorgovernmentprime_ALLOW_ErrorCount
          ,le.contractorgovernmentsub_ALLOW_ErrorCount
          ,le.contractornongovernment_ALLOW_ErrorCount
          ,le.registeredgovernmentbus_ALLOW_ErrorCount
          ,le.registerednongovernmentbus_ALLOW_ErrorCount
          ,le.clearancelevelpersonnel_ALLOW_ErrorCount
          ,le.clearancelevelfacility_ALLOW_ErrorCount
          ,le.certificatedatefrom1_CUSTOM_ErrorCount
          ,le.certificatedateto1_CUSTOM_ErrorCount
          ,le.certificatestatus1_ALLOW_ErrorCount
          ,le.certificationnumber1_ALLOW_ErrorCount
          ,le.certificationtype1_ALLOW_ErrorCount
          ,le.certificatedatefrom2_CUSTOM_ErrorCount
          ,le.certificatedateto2_CUSTOM_ErrorCount
          ,le.certificatestatus2_ALLOW_ErrorCount
          ,le.certificationnumber2_ALLOW_ErrorCount
          ,le.certificationtype2_ALLOW_ErrorCount
          ,le.certificatedatefrom3_CUSTOM_ErrorCount
          ,le.certificatedateto3_CUSTOM_ErrorCount
          ,le.certificatestatus3_ALLOW_ErrorCount
          ,le.certificationnumber3_ALLOW_ErrorCount
          ,le.certificationtype3_ALLOW_ErrorCount
          ,le.certificatedatefrom4_CUSTOM_ErrorCount
          ,le.certificatedateto4_CUSTOM_ErrorCount
          ,le.certificatestatus4_ALLOW_ErrorCount
          ,le.certificationnumber4_ALLOW_ErrorCount
          ,le.certificationtype4_ALLOW_ErrorCount
          ,le.certificatedatefrom5_CUSTOM_ErrorCount
          ,le.certificatedateto5_CUSTOM_ErrorCount
          ,le.certificatestatus5_ALLOW_ErrorCount
          ,le.certificationnumber5_ALLOW_ErrorCount
          ,le.certificationtype5_ALLOW_ErrorCount
          ,le.certificatedatefrom6_CUSTOM_ErrorCount
          ,le.certificatedateto6_CUSTOM_ErrorCount
          ,le.certificatestatus6_ALLOW_ErrorCount
          ,le.certificationnumber6_ALLOW_ErrorCount
          ,le.certificationtype6_ALLOW_ErrorCount
          ,le.starrating_ALLOW_ErrorCount
          ,le.assets_ALLOW_ErrorCount
          ,le.biddescription_ALLOW_ErrorCount
          ,le.competitiveadvantage_ALLOW_ErrorCount
          ,le.cagecode_ALLOW_ErrorCount
          ,le.capabilitiesnarrative_ALLOW_ErrorCount
          ,le.category_ALLOW_ErrorCount
          ,le.chtrclass_ALLOW_ErrorCount
          ,le.productdescription1_ALLOW_ErrorCount
          ,le.productdescription2_ALLOW_ErrorCount
          ,le.productdescription3_ALLOW_ErrorCount
          ,le.productdescription4_ALLOW_ErrorCount
          ,le.productdescription5_ALLOW_ErrorCount
          ,le.classdescription1_ALLOW_ErrorCount
          ,le.subclassdescription1_ALLOW_ErrorCount
          ,le.classdescription2_ALLOW_ErrorCount
          ,le.subclassdescription2_ALLOW_ErrorCount
          ,le.classdescription3_ALLOW_ErrorCount
          ,le.subclassdescription3_ALLOW_ErrorCount
          ,le.classdescription4_ALLOW_ErrorCount
          ,le.subclassdescription4_ALLOW_ErrorCount
          ,le.classdescription5_ALLOW_ErrorCount
          ,le.subclassdescription5_ALLOW_ErrorCount
          ,le.classifications_ALLOW_ErrorCount
          ,le.commodity1_CUSTOM_ErrorCount
          ,le.commodity2_CUSTOM_ErrorCount
          ,le.commodity3_CUSTOM_ErrorCount
          ,le.commodity4_CUSTOM_ErrorCount
          ,le.commodity5_CUSTOM_ErrorCount
          ,le.commodity6_CUSTOM_ErrorCount
          ,le.commodity7_CUSTOM_ErrorCount
          ,le.commodity8_CUSTOM_ErrorCount
          ,le.completedate_CUSTOM_ErrorCount
          ,le.crossreference_ALLOW_ErrorCount
          ,le.dateestablished_CUSTOM_ErrorCount
          ,le.businessage_ALLOW_ErrorCount
          ,le.deposits_ALLOW_ErrorCount
          ,le.dunsnumber_ALLOW_ErrorCount
          ,le.enttype_ALLOW_ErrorCount
          ,le.expirationdate_CUSTOM_ErrorCount
          ,le.extendeddate_CUSTOM_ErrorCount
          ,le.issuingauthority_ALLOW_ErrorCount
          ,le.keywords_ALLOW_ErrorCount
          ,le.licensenumber_ALLOW_ErrorCount
          ,le.licensetype_ALLOW_ErrorCount
          ,le.mincd_ALLOW_ErrorCount
          ,le.minorityaffiliation_ALLOW_ErrorCount
          ,le.minorityownershipdate_CUSTOM_ErrorCount
          ,le.siccode1_CUSTOM_ErrorCount
          ,le.siccode2_CUSTOM_ErrorCount
          ,le.siccode3_CUSTOM_ErrorCount
          ,le.siccode4_CUSTOM_ErrorCount
          ,le.siccode5_CUSTOM_ErrorCount
          ,le.siccode6_CUSTOM_ErrorCount
          ,le.siccode7_CUSTOM_ErrorCount
          ,le.siccode8_CUSTOM_ErrorCount
          ,le.naicscode1_CUSTOM_ErrorCount
          ,le.naicscode2_CUSTOM_ErrorCount
          ,le.naicscode3_CUSTOM_ErrorCount
          ,le.naicscode4_CUSTOM_ErrorCount
          ,le.naicscode5_CUSTOM_ErrorCount
          ,le.naicscode6_CUSTOM_ErrorCount
          ,le.naicscode7_CUSTOM_ErrorCount
          ,le.naicscode8_CUSTOM_ErrorCount
          ,le.prequalify_ALLOW_ErrorCount
          ,le.procurementcategory1_ALLOW_ErrorCount
          ,le.subprocurementcategory1_ALLOW_ErrorCount
          ,le.procurementcategory2_ALLOW_ErrorCount
          ,le.subprocurementcategory2_ALLOW_ErrorCount
          ,le.procurementcategory3_ALLOW_ErrorCount
          ,le.subprocurementcategory3_ALLOW_ErrorCount
          ,le.procurementcategory4_ALLOW_ErrorCount
          ,le.subprocurementcategory4_ALLOW_ErrorCount
          ,le.procurementcategory5_ALLOW_ErrorCount
          ,le.subprocurementcategory5_ALLOW_ErrorCount
          ,le.renewal_ALLOW_ErrorCount
          ,le.renewaldate_CUSTOM_ErrorCount
          ,le.unitedcertprogrampartner_ALLOW_ErrorCount
          ,le.vendorkey_ALLOW_ErrorCount
          ,le.vendornumber_ALLOW_ErrorCount
          ,le.workcode1_ALLOW_ErrorCount
          ,le.workcode2_ALLOW_ErrorCount
          ,le.workcode3_ALLOW_ErrorCount
          ,le.workcode4_ALLOW_ErrorCount
          ,le.workcode5_ALLOW_ErrorCount
          ,le.workcode6_ALLOW_ErrorCount
          ,le.workcode7_ALLOW_ErrorCount
          ,le.workcode8_ALLOW_ErrorCount
          ,le.exporter_ALLOW_ErrorCount
          ,le.exportbusinessactivities_ALLOW_ErrorCount
          ,le.exportto_ALLOW_ErrorCount
          ,le.exportbusinessrelationships_ALLOW_ErrorCount
          ,le.exportobjectives_ALLOW_ErrorCount
          ,le.reference1_ALLOW_ErrorCount
          ,le.reference2_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Input_hygiene(PROJECT(h, Input_Layout_Diversity_Certification));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dartid:' + getFieldTypeText(h.dartid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateadded:' + getFieldTypeText(h.dateadded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateupdated:' + getFieldTypeText(h.dateupdated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'website:' + getFieldTypeText(h.website) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'profilelastupdated:' + getFieldTypeText(h.profilelastupdated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'servicearea:' + getFieldTypeText(h.servicearea) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region1:' + getFieldTypeText(h.region1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region2:' + getFieldTypeText(h.region2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region3:' + getFieldTypeText(h.region3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region4:' + getFieldTypeText(h.region4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region5:' + getFieldTypeText(h.region5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ethnicity:' + getFieldTypeText(h.ethnicity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresscity:' + getFieldTypeText(h.addresscity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addressstate:' + getFieldTypeText(h.addressstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresszipcode:' + getFieldTypeText(h.addresszipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresszip4:' + getFieldTypeText(h.addresszip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building:' + getFieldTypeText(h.building) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact:' + getFieldTypeText(h.contact) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone1:' + getFieldTypeText(h.phone1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone2:' + getFieldTypeText(h.phone2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone3:' + getFieldTypeText(h.phone3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cell:' + getFieldTypeText(h.cell) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fax:' + getFieldTypeText(h.fax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email1:' + getFieldTypeText(h.email1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email2:' + getFieldTypeText(h.email2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email3:' + getFieldTypeText(h.email3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'webpage1:' + getFieldTypeText(h.webpage1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'webpage2:' + getFieldTypeText(h.webpage2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'webpage3:' + getFieldTypeText(h.webpage3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessname:' + getFieldTypeText(h.businessname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba:' + getFieldTypeText(h.dba) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessid:' + getFieldTypeText(h.businessid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype1:' + getFieldTypeText(h.businesstype1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesslocation1:' + getFieldTypeText(h.businesslocation1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype2:' + getFieldTypeText(h.businesstype2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesslocation2:' + getFieldTypeText(h.businesslocation2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype3:' + getFieldTypeText(h.businesstype3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesslocation3:' + getFieldTypeText(h.businesslocation3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype4:' + getFieldTypeText(h.businesstype4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesslocation4:' + getFieldTypeText(h.businesslocation4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype5:' + getFieldTypeText(h.businesstype5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesslocation5:' + getFieldTypeText(h.businesslocation5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'industry:' + getFieldTypeText(h.industry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trade:' + getFieldTypeText(h.trade) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'resourcedescription:' + getFieldTypeText(h.resourcedescription) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'natureofbusiness:' + getFieldTypeText(h.natureofbusiness) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessstructure:' + getFieldTypeText(h.businessstructure) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'totalemployees:' + getFieldTypeText(h.totalemployees) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'avgcontractsize:' + getFieldTypeText(h.avgcontractsize) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmid:' + getFieldTypeText(h.firmid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationaddress:' + getFieldTypeText(h.firmlocationaddress) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationaddresscity:' + getFieldTypeText(h.firmlocationaddresscity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationaddresszip4:' + getFieldTypeText(h.firmlocationaddresszip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationaddresszipcode:' + getFieldTypeText(h.firmlocationaddresszipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationcounty:' + getFieldTypeText(h.firmlocationcounty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firmlocationstate:' + getFieldTypeText(h.firmlocationstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certfed:' + getFieldTypeText(h.certfed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certstate:' + getFieldTypeText(h.certstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractsfederal:' + getFieldTypeText(h.contractsfederal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractsva:' + getFieldTypeText(h.contractsva) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractscommercial:' + getFieldTypeText(h.contractscommercial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractorgovernmentprime:' + getFieldTypeText(h.contractorgovernmentprime) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractorgovernmentsub:' + getFieldTypeText(h.contractorgovernmentsub) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contractornongovernment:' + getFieldTypeText(h.contractornongovernment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'registeredgovernmentbus:' + getFieldTypeText(h.registeredgovernmentbus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'registerednongovernmentbus:' + getFieldTypeText(h.registerednongovernmentbus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clearancelevelpersonnel:' + getFieldTypeText(h.clearancelevelpersonnel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clearancelevelfacility:' + getFieldTypeText(h.clearancelevelfacility) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom1:' + getFieldTypeText(h.certificatedatefrom1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto1:' + getFieldTypeText(h.certificatedateto1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus1:' + getFieldTypeText(h.certificatestatus1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber1:' + getFieldTypeText(h.certificationnumber1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype1:' + getFieldTypeText(h.certificationtype1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom2:' + getFieldTypeText(h.certificatedatefrom2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto2:' + getFieldTypeText(h.certificatedateto2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus2:' + getFieldTypeText(h.certificatestatus2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber2:' + getFieldTypeText(h.certificationnumber2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype2:' + getFieldTypeText(h.certificationtype2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom3:' + getFieldTypeText(h.certificatedatefrom3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto3:' + getFieldTypeText(h.certificatedateto3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus3:' + getFieldTypeText(h.certificatestatus3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber3:' + getFieldTypeText(h.certificationnumber3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype3:' + getFieldTypeText(h.certificationtype3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom4:' + getFieldTypeText(h.certificatedatefrom4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto4:' + getFieldTypeText(h.certificatedateto4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus4:' + getFieldTypeText(h.certificatestatus4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber4:' + getFieldTypeText(h.certificationnumber4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype4:' + getFieldTypeText(h.certificationtype4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom5:' + getFieldTypeText(h.certificatedatefrom5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto5:' + getFieldTypeText(h.certificatedateto5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus5:' + getFieldTypeText(h.certificatestatus5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber5:' + getFieldTypeText(h.certificationnumber5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype5:' + getFieldTypeText(h.certificationtype5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedatefrom6:' + getFieldTypeText(h.certificatedatefrom6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatedateto6:' + getFieldTypeText(h.certificatedateto6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificatestatus6:' + getFieldTypeText(h.certificatestatus6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationnumber6:' + getFieldTypeText(h.certificationnumber6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certificationtype6:' + getFieldTypeText(h.certificationtype6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'starrating:' + getFieldTypeText(h.starrating) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assets:' + getFieldTypeText(h.assets) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'biddescription:' + getFieldTypeText(h.biddescription) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'competitiveadvantage:' + getFieldTypeText(h.competitiveadvantage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cagecode:' + getFieldTypeText(h.cagecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'capabilitiesnarrative:' + getFieldTypeText(h.capabilitiesnarrative) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'category:' + getFieldTypeText(h.category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chtrclass:' + getFieldTypeText(h.chtrclass) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'productdescription1:' + getFieldTypeText(h.productdescription1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'productdescription2:' + getFieldTypeText(h.productdescription2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'productdescription3:' + getFieldTypeText(h.productdescription3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'productdescription4:' + getFieldTypeText(h.productdescription4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'productdescription5:' + getFieldTypeText(h.productdescription5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classdescription1:' + getFieldTypeText(h.classdescription1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subclassdescription1:' + getFieldTypeText(h.subclassdescription1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classdescription2:' + getFieldTypeText(h.classdescription2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subclassdescription2:' + getFieldTypeText(h.subclassdescription2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classdescription3:' + getFieldTypeText(h.classdescription3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subclassdescription3:' + getFieldTypeText(h.subclassdescription3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classdescription4:' + getFieldTypeText(h.classdescription4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subclassdescription4:' + getFieldTypeText(h.subclassdescription4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classdescription5:' + getFieldTypeText(h.classdescription5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subclassdescription5:' + getFieldTypeText(h.subclassdescription5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classifications:' + getFieldTypeText(h.classifications) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity1:' + getFieldTypeText(h.commodity1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity2:' + getFieldTypeText(h.commodity2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity3:' + getFieldTypeText(h.commodity3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity4:' + getFieldTypeText(h.commodity4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity5:' + getFieldTypeText(h.commodity5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity6:' + getFieldTypeText(h.commodity6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity7:' + getFieldTypeText(h.commodity7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'commodity8:' + getFieldTypeText(h.commodity8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'completedate:' + getFieldTypeText(h.completedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crossreference:' + getFieldTypeText(h.crossreference) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dateestablished:' + getFieldTypeText(h.dateestablished) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessage:' + getFieldTypeText(h.businessage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deposits:' + getFieldTypeText(h.deposits) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dunsnumber:' + getFieldTypeText(h.dunsnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'enttype:' + getFieldTypeText(h.enttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'expirationdate:' + getFieldTypeText(h.expirationdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'extendeddate:' + getFieldTypeText(h.extendeddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'issuingauthority:' + getFieldTypeText(h.issuingauthority) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'keywords:' + getFieldTypeText(h.keywords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensenumber:' + getFieldTypeText(h.licensenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensetype:' + getFieldTypeText(h.licensetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mincd:' + getFieldTypeText(h.mincd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'minorityaffiliation:' + getFieldTypeText(h.minorityaffiliation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'minorityownershipdate:' + getFieldTypeText(h.minorityownershipdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode1:' + getFieldTypeText(h.siccode1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode2:' + getFieldTypeText(h.siccode2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode3:' + getFieldTypeText(h.siccode3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode4:' + getFieldTypeText(h.siccode4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode5:' + getFieldTypeText(h.siccode5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode6:' + getFieldTypeText(h.siccode6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode7:' + getFieldTypeText(h.siccode7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siccode8:' + getFieldTypeText(h.siccode8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode1:' + getFieldTypeText(h.naicscode1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode2:' + getFieldTypeText(h.naicscode2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode3:' + getFieldTypeText(h.naicscode3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode4:' + getFieldTypeText(h.naicscode4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode5:' + getFieldTypeText(h.naicscode5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode6:' + getFieldTypeText(h.naicscode6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode7:' + getFieldTypeText(h.naicscode7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode8:' + getFieldTypeText(h.naicscode8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prequalify:' + getFieldTypeText(h.prequalify) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'procurementcategory1:' + getFieldTypeText(h.procurementcategory1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subprocurementcategory1:' + getFieldTypeText(h.subprocurementcategory1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'procurementcategory2:' + getFieldTypeText(h.procurementcategory2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subprocurementcategory2:' + getFieldTypeText(h.subprocurementcategory2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'procurementcategory3:' + getFieldTypeText(h.procurementcategory3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subprocurementcategory3:' + getFieldTypeText(h.subprocurementcategory3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'procurementcategory4:' + getFieldTypeText(h.procurementcategory4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subprocurementcategory4:' + getFieldTypeText(h.subprocurementcategory4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'procurementcategory5:' + getFieldTypeText(h.procurementcategory5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subprocurementcategory5:' + getFieldTypeText(h.subprocurementcategory5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'renewal:' + getFieldTypeText(h.renewal) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'renewaldate:' + getFieldTypeText(h.renewaldate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unitedcertprogrampartner:' + getFieldTypeText(h.unitedcertprogrampartner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendorkey:' + getFieldTypeText(h.vendorkey) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendornumber:' + getFieldTypeText(h.vendornumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode1:' + getFieldTypeText(h.workcode1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode2:' + getFieldTypeText(h.workcode2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode3:' + getFieldTypeText(h.workcode3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode4:' + getFieldTypeText(h.workcode4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode5:' + getFieldTypeText(h.workcode5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode6:' + getFieldTypeText(h.workcode6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode7:' + getFieldTypeText(h.workcode7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'workcode8:' + getFieldTypeText(h.workcode8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exporter:' + getFieldTypeText(h.exporter) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exportbusinessactivities:' + getFieldTypeText(h.exportbusinessactivities) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exportto:' + getFieldTypeText(h.exportto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exportbusinessrelationships:' + getFieldTypeText(h.exportbusinessrelationships) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exportobjectives:' + getFieldTypeText(h.exportobjectives) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reference1:' + getFieldTypeText(h.reference1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reference2:' + getFieldTypeText(h.reference2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reference3:' + getFieldTypeText(h.reference3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dartid_cnt
          ,le.populated_dateadded_cnt
          ,le.populated_dateupdated_cnt
          ,le.populated_website_cnt
          ,le.populated_state_cnt
          ,le.populated_profilelastupdated_cnt
          ,le.populated_county_cnt
          ,le.populated_servicearea_cnt
          ,le.populated_region1_cnt
          ,le.populated_region2_cnt
          ,le.populated_region3_cnt
          ,le.populated_region4_cnt
          ,le.populated_region5_cnt
          ,le.populated_fname_cnt
          ,le.populated_lname_cnt
          ,le.populated_mname_cnt
          ,le.populated_suffix_cnt
          ,le.populated_title_cnt
          ,le.populated_ethnicity_cnt
          ,le.populated_gender_cnt
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_addresscity_cnt
          ,le.populated_addressstate_cnt
          ,le.populated_addresszipcode_cnt
          ,le.populated_addresszip4_cnt
          ,le.populated_building_cnt
          ,le.populated_contact_cnt
          ,le.populated_phone1_cnt
          ,le.populated_phone2_cnt
          ,le.populated_phone3_cnt
          ,le.populated_cell_cnt
          ,le.populated_fax_cnt
          ,le.populated_email1_cnt
          ,le.populated_email2_cnt
          ,le.populated_email3_cnt
          ,le.populated_webpage1_cnt
          ,le.populated_webpage2_cnt
          ,le.populated_webpage3_cnt
          ,le.populated_businessname_cnt
          ,le.populated_dba_cnt
          ,le.populated_businessid_cnt
          ,le.populated_businesstype1_cnt
          ,le.populated_businesslocation1_cnt
          ,le.populated_businesstype2_cnt
          ,le.populated_businesslocation2_cnt
          ,le.populated_businesstype3_cnt
          ,le.populated_businesslocation3_cnt
          ,le.populated_businesstype4_cnt
          ,le.populated_businesslocation4_cnt
          ,le.populated_businesstype5_cnt
          ,le.populated_businesslocation5_cnt
          ,le.populated_industry_cnt
          ,le.populated_trade_cnt
          ,le.populated_resourcedescription_cnt
          ,le.populated_natureofbusiness_cnt
          ,le.populated_businessstructure_cnt
          ,le.populated_totalemployees_cnt
          ,le.populated_avgcontractsize_cnt
          ,le.populated_firmid_cnt
          ,le.populated_firmlocationaddress_cnt
          ,le.populated_firmlocationaddresscity_cnt
          ,le.populated_firmlocationaddresszip4_cnt
          ,le.populated_firmlocationaddresszipcode_cnt
          ,le.populated_firmlocationcounty_cnt
          ,le.populated_firmlocationstate_cnt
          ,le.populated_certfed_cnt
          ,le.populated_certstate_cnt
          ,le.populated_contractsfederal_cnt
          ,le.populated_contractsva_cnt
          ,le.populated_contractscommercial_cnt
          ,le.populated_contractorgovernmentprime_cnt
          ,le.populated_contractorgovernmentsub_cnt
          ,le.populated_contractornongovernment_cnt
          ,le.populated_registeredgovernmentbus_cnt
          ,le.populated_registerednongovernmentbus_cnt
          ,le.populated_clearancelevelpersonnel_cnt
          ,le.populated_clearancelevelfacility_cnt
          ,le.populated_certificatedatefrom1_cnt
          ,le.populated_certificatedateto1_cnt
          ,le.populated_certificatestatus1_cnt
          ,le.populated_certificationnumber1_cnt
          ,le.populated_certificationtype1_cnt
          ,le.populated_certificatedatefrom2_cnt
          ,le.populated_certificatedateto2_cnt
          ,le.populated_certificatestatus2_cnt
          ,le.populated_certificationnumber2_cnt
          ,le.populated_certificationtype2_cnt
          ,le.populated_certificatedatefrom3_cnt
          ,le.populated_certificatedateto3_cnt
          ,le.populated_certificatestatus3_cnt
          ,le.populated_certificationnumber3_cnt
          ,le.populated_certificationtype3_cnt
          ,le.populated_certificatedatefrom4_cnt
          ,le.populated_certificatedateto4_cnt
          ,le.populated_certificatestatus4_cnt
          ,le.populated_certificationnumber4_cnt
          ,le.populated_certificationtype4_cnt
          ,le.populated_certificatedatefrom5_cnt
          ,le.populated_certificatedateto5_cnt
          ,le.populated_certificatestatus5_cnt
          ,le.populated_certificationnumber5_cnt
          ,le.populated_certificationtype5_cnt
          ,le.populated_certificatedatefrom6_cnt
          ,le.populated_certificatedateto6_cnt
          ,le.populated_certificatestatus6_cnt
          ,le.populated_certificationnumber6_cnt
          ,le.populated_certificationtype6_cnt
          ,le.populated_starrating_cnt
          ,le.populated_assets_cnt
          ,le.populated_biddescription_cnt
          ,le.populated_competitiveadvantage_cnt
          ,le.populated_cagecode_cnt
          ,le.populated_capabilitiesnarrative_cnt
          ,le.populated_category_cnt
          ,le.populated_chtrclass_cnt
          ,le.populated_productdescription1_cnt
          ,le.populated_productdescription2_cnt
          ,le.populated_productdescription3_cnt
          ,le.populated_productdescription4_cnt
          ,le.populated_productdescription5_cnt
          ,le.populated_classdescription1_cnt
          ,le.populated_subclassdescription1_cnt
          ,le.populated_classdescription2_cnt
          ,le.populated_subclassdescription2_cnt
          ,le.populated_classdescription3_cnt
          ,le.populated_subclassdescription3_cnt
          ,le.populated_classdescription4_cnt
          ,le.populated_subclassdescription4_cnt
          ,le.populated_classdescription5_cnt
          ,le.populated_subclassdescription5_cnt
          ,le.populated_classifications_cnt
          ,le.populated_commodity1_cnt
          ,le.populated_commodity2_cnt
          ,le.populated_commodity3_cnt
          ,le.populated_commodity4_cnt
          ,le.populated_commodity5_cnt
          ,le.populated_commodity6_cnt
          ,le.populated_commodity7_cnt
          ,le.populated_commodity8_cnt
          ,le.populated_completedate_cnt
          ,le.populated_crossreference_cnt
          ,le.populated_dateestablished_cnt
          ,le.populated_businessage_cnt
          ,le.populated_deposits_cnt
          ,le.populated_dunsnumber_cnt
          ,le.populated_enttype_cnt
          ,le.populated_expirationdate_cnt
          ,le.populated_extendeddate_cnt
          ,le.populated_issuingauthority_cnt
          ,le.populated_keywords_cnt
          ,le.populated_licensenumber_cnt
          ,le.populated_licensetype_cnt
          ,le.populated_mincd_cnt
          ,le.populated_minorityaffiliation_cnt
          ,le.populated_minorityownershipdate_cnt
          ,le.populated_siccode1_cnt
          ,le.populated_siccode2_cnt
          ,le.populated_siccode3_cnt
          ,le.populated_siccode4_cnt
          ,le.populated_siccode5_cnt
          ,le.populated_siccode6_cnt
          ,le.populated_siccode7_cnt
          ,le.populated_siccode8_cnt
          ,le.populated_naicscode1_cnt
          ,le.populated_naicscode2_cnt
          ,le.populated_naicscode3_cnt
          ,le.populated_naicscode4_cnt
          ,le.populated_naicscode5_cnt
          ,le.populated_naicscode6_cnt
          ,le.populated_naicscode7_cnt
          ,le.populated_naicscode8_cnt
          ,le.populated_prequalify_cnt
          ,le.populated_procurementcategory1_cnt
          ,le.populated_subprocurementcategory1_cnt
          ,le.populated_procurementcategory2_cnt
          ,le.populated_subprocurementcategory2_cnt
          ,le.populated_procurementcategory3_cnt
          ,le.populated_subprocurementcategory3_cnt
          ,le.populated_procurementcategory4_cnt
          ,le.populated_subprocurementcategory4_cnt
          ,le.populated_procurementcategory5_cnt
          ,le.populated_subprocurementcategory5_cnt
          ,le.populated_renewal_cnt
          ,le.populated_renewaldate_cnt
          ,le.populated_unitedcertprogrampartner_cnt
          ,le.populated_vendorkey_cnt
          ,le.populated_vendornumber_cnt
          ,le.populated_workcode1_cnt
          ,le.populated_workcode2_cnt
          ,le.populated_workcode3_cnt
          ,le.populated_workcode4_cnt
          ,le.populated_workcode5_cnt
          ,le.populated_workcode6_cnt
          ,le.populated_workcode7_cnt
          ,le.populated_workcode8_cnt
          ,le.populated_exporter_cnt
          ,le.populated_exportbusinessactivities_cnt
          ,le.populated_exportto_cnt
          ,le.populated_exportbusinessrelationships_cnt
          ,le.populated_exportobjectives_cnt
          ,le.populated_reference1_cnt
          ,le.populated_reference2_cnt
          ,le.populated_reference3_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dartid_pcnt
          ,le.populated_dateadded_pcnt
          ,le.populated_dateupdated_pcnt
          ,le.populated_website_pcnt
          ,le.populated_state_pcnt
          ,le.populated_profilelastupdated_pcnt
          ,le.populated_county_pcnt
          ,le.populated_servicearea_pcnt
          ,le.populated_region1_pcnt
          ,le.populated_region2_pcnt
          ,le.populated_region3_pcnt
          ,le.populated_region4_pcnt
          ,le.populated_region5_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_title_pcnt
          ,le.populated_ethnicity_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_addresscity_pcnt
          ,le.populated_addressstate_pcnt
          ,le.populated_addresszipcode_pcnt
          ,le.populated_addresszip4_pcnt
          ,le.populated_building_pcnt
          ,le.populated_contact_pcnt
          ,le.populated_phone1_pcnt
          ,le.populated_phone2_pcnt
          ,le.populated_phone3_pcnt
          ,le.populated_cell_pcnt
          ,le.populated_fax_pcnt
          ,le.populated_email1_pcnt
          ,le.populated_email2_pcnt
          ,le.populated_email3_pcnt
          ,le.populated_webpage1_pcnt
          ,le.populated_webpage2_pcnt
          ,le.populated_webpage3_pcnt
          ,le.populated_businessname_pcnt
          ,le.populated_dba_pcnt
          ,le.populated_businessid_pcnt
          ,le.populated_businesstype1_pcnt
          ,le.populated_businesslocation1_pcnt
          ,le.populated_businesstype2_pcnt
          ,le.populated_businesslocation2_pcnt
          ,le.populated_businesstype3_pcnt
          ,le.populated_businesslocation3_pcnt
          ,le.populated_businesstype4_pcnt
          ,le.populated_businesslocation4_pcnt
          ,le.populated_businesstype5_pcnt
          ,le.populated_businesslocation5_pcnt
          ,le.populated_industry_pcnt
          ,le.populated_trade_pcnt
          ,le.populated_resourcedescription_pcnt
          ,le.populated_natureofbusiness_pcnt
          ,le.populated_businessstructure_pcnt
          ,le.populated_totalemployees_pcnt
          ,le.populated_avgcontractsize_pcnt
          ,le.populated_firmid_pcnt
          ,le.populated_firmlocationaddress_pcnt
          ,le.populated_firmlocationaddresscity_pcnt
          ,le.populated_firmlocationaddresszip4_pcnt
          ,le.populated_firmlocationaddresszipcode_pcnt
          ,le.populated_firmlocationcounty_pcnt
          ,le.populated_firmlocationstate_pcnt
          ,le.populated_certfed_pcnt
          ,le.populated_certstate_pcnt
          ,le.populated_contractsfederal_pcnt
          ,le.populated_contractsva_pcnt
          ,le.populated_contractscommercial_pcnt
          ,le.populated_contractorgovernmentprime_pcnt
          ,le.populated_contractorgovernmentsub_pcnt
          ,le.populated_contractornongovernment_pcnt
          ,le.populated_registeredgovernmentbus_pcnt
          ,le.populated_registerednongovernmentbus_pcnt
          ,le.populated_clearancelevelpersonnel_pcnt
          ,le.populated_clearancelevelfacility_pcnt
          ,le.populated_certificatedatefrom1_pcnt
          ,le.populated_certificatedateto1_pcnt
          ,le.populated_certificatestatus1_pcnt
          ,le.populated_certificationnumber1_pcnt
          ,le.populated_certificationtype1_pcnt
          ,le.populated_certificatedatefrom2_pcnt
          ,le.populated_certificatedateto2_pcnt
          ,le.populated_certificatestatus2_pcnt
          ,le.populated_certificationnumber2_pcnt
          ,le.populated_certificationtype2_pcnt
          ,le.populated_certificatedatefrom3_pcnt
          ,le.populated_certificatedateto3_pcnt
          ,le.populated_certificatestatus3_pcnt
          ,le.populated_certificationnumber3_pcnt
          ,le.populated_certificationtype3_pcnt
          ,le.populated_certificatedatefrom4_pcnt
          ,le.populated_certificatedateto4_pcnt
          ,le.populated_certificatestatus4_pcnt
          ,le.populated_certificationnumber4_pcnt
          ,le.populated_certificationtype4_pcnt
          ,le.populated_certificatedatefrom5_pcnt
          ,le.populated_certificatedateto5_pcnt
          ,le.populated_certificatestatus5_pcnt
          ,le.populated_certificationnumber5_pcnt
          ,le.populated_certificationtype5_pcnt
          ,le.populated_certificatedatefrom6_pcnt
          ,le.populated_certificatedateto6_pcnt
          ,le.populated_certificatestatus6_pcnt
          ,le.populated_certificationnumber6_pcnt
          ,le.populated_certificationtype6_pcnt
          ,le.populated_starrating_pcnt
          ,le.populated_assets_pcnt
          ,le.populated_biddescription_pcnt
          ,le.populated_competitiveadvantage_pcnt
          ,le.populated_cagecode_pcnt
          ,le.populated_capabilitiesnarrative_pcnt
          ,le.populated_category_pcnt
          ,le.populated_chtrclass_pcnt
          ,le.populated_productdescription1_pcnt
          ,le.populated_productdescription2_pcnt
          ,le.populated_productdescription3_pcnt
          ,le.populated_productdescription4_pcnt
          ,le.populated_productdescription5_pcnt
          ,le.populated_classdescription1_pcnt
          ,le.populated_subclassdescription1_pcnt
          ,le.populated_classdescription2_pcnt
          ,le.populated_subclassdescription2_pcnt
          ,le.populated_classdescription3_pcnt
          ,le.populated_subclassdescription3_pcnt
          ,le.populated_classdescription4_pcnt
          ,le.populated_subclassdescription4_pcnt
          ,le.populated_classdescription5_pcnt
          ,le.populated_subclassdescription5_pcnt
          ,le.populated_classifications_pcnt
          ,le.populated_commodity1_pcnt
          ,le.populated_commodity2_pcnt
          ,le.populated_commodity3_pcnt
          ,le.populated_commodity4_pcnt
          ,le.populated_commodity5_pcnt
          ,le.populated_commodity6_pcnt
          ,le.populated_commodity7_pcnt
          ,le.populated_commodity8_pcnt
          ,le.populated_completedate_pcnt
          ,le.populated_crossreference_pcnt
          ,le.populated_dateestablished_pcnt
          ,le.populated_businessage_pcnt
          ,le.populated_deposits_pcnt
          ,le.populated_dunsnumber_pcnt
          ,le.populated_enttype_pcnt
          ,le.populated_expirationdate_pcnt
          ,le.populated_extendeddate_pcnt
          ,le.populated_issuingauthority_pcnt
          ,le.populated_keywords_pcnt
          ,le.populated_licensenumber_pcnt
          ,le.populated_licensetype_pcnt
          ,le.populated_mincd_pcnt
          ,le.populated_minorityaffiliation_pcnt
          ,le.populated_minorityownershipdate_pcnt
          ,le.populated_siccode1_pcnt
          ,le.populated_siccode2_pcnt
          ,le.populated_siccode3_pcnt
          ,le.populated_siccode4_pcnt
          ,le.populated_siccode5_pcnt
          ,le.populated_siccode6_pcnt
          ,le.populated_siccode7_pcnt
          ,le.populated_siccode8_pcnt
          ,le.populated_naicscode1_pcnt
          ,le.populated_naicscode2_pcnt
          ,le.populated_naicscode3_pcnt
          ,le.populated_naicscode4_pcnt
          ,le.populated_naicscode5_pcnt
          ,le.populated_naicscode6_pcnt
          ,le.populated_naicscode7_pcnt
          ,le.populated_naicscode8_pcnt
          ,le.populated_prequalify_pcnt
          ,le.populated_procurementcategory1_pcnt
          ,le.populated_subprocurementcategory1_pcnt
          ,le.populated_procurementcategory2_pcnt
          ,le.populated_subprocurementcategory2_pcnt
          ,le.populated_procurementcategory3_pcnt
          ,le.populated_subprocurementcategory3_pcnt
          ,le.populated_procurementcategory4_pcnt
          ,le.populated_subprocurementcategory4_pcnt
          ,le.populated_procurementcategory5_pcnt
          ,le.populated_subprocurementcategory5_pcnt
          ,le.populated_renewal_pcnt
          ,le.populated_renewaldate_pcnt
          ,le.populated_unitedcertprogrampartner_pcnt
          ,le.populated_vendorkey_pcnt
          ,le.populated_vendornumber_pcnt
          ,le.populated_workcode1_pcnt
          ,le.populated_workcode2_pcnt
          ,le.populated_workcode3_pcnt
          ,le.populated_workcode4_pcnt
          ,le.populated_workcode5_pcnt
          ,le.populated_workcode6_pcnt
          ,le.populated_workcode7_pcnt
          ,le.populated_workcode8_pcnt
          ,le.populated_exporter_pcnt
          ,le.populated_exportbusinessactivities_pcnt
          ,le.populated_exportto_pcnt
          ,le.populated_exportbusinessrelationships_pcnt
          ,le.populated_exportobjectives_pcnt
          ,le.populated_reference1_pcnt
          ,le.populated_reference2_pcnt
          ,le.populated_reference3_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,204,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Input_Delta(prevDS, PROJECT(h, Input_Layout_Diversity_Certification));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),204,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_Layout_Diversity_Certification) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Diversity_Certification, Input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
