﻿// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Diversity_Certification';
  EXPORT spc_NAMESCOPE := 'Input';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Diversity_Certification';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dartid,dateadded,dateupdated,website,state,profilelastupdated,county,servicearea,region1,region2,region3,region4,region5,fname,lname,mname,suffix,title,ethnicity,gender,address1,address2,addresscity,addressstate,addresszipcode,addresszip4,building,contact,phone1,phone2,phone3,cell,fax,email1,email2,email3,webpage1,webpage2,webpage3,businessname,dba,businessid,businesstype1,businesslocation1,businesstype2,businesslocation2,businesstype3,businesslocation3,businesstype4,businesslocation4,businesstype5,businesslocation5,industry,trade,resourcedescription,natureofbusiness,businessstructure,totalemployees,avgcontractsize,firmid,firmlocationaddress,firmlocationaddresscity,firmlocationaddresszip4,firmlocationaddresszipcode,firmlocationcounty,firmlocationstate,certfed,certstate,contractsfederal,contractsva,contractscommercial,contractorgovernmentprime,contractorgovernmentsub,contractornongovernment,registeredgovernmentbus,registerednongovernmentbus,clearancelevelpersonnel,clearancelevelfacility,certificatedatefrom1,certificatedateto1,certificatestatus1,certificationnumber1,certificationtype1,certificatedatefrom2,certificatedateto2,certificatestatus2,certificationnumber2,certificationtype2,certificatedatefrom3,certificatedateto3,certificatestatus3,certificationnumber3,certificationtype3,certificatedatefrom4,certificatedateto4,certificatestatus4,certificationnumber4,certificationtype4,certificatedatefrom5,certificatedateto5,certificatestatus5,certificationnumber5,certificationtype5,certificatedatefrom6,certificatedateto6,certificatestatus6,certificationnumber6,certificationtype6,starrating,assets,biddescription,competitiveadvantage,cagecode,capabilitiesnarrative,category,chtrclass,productdescription1,productdescription2,productdescription3,productdescription4,productdescription5,classdescription1,subclassdescription1,classdescription2,subclassdescription2,classdescription3,subclassdescription3,classdescription4,subclassdescription4,classdescription5,subclassdescription5,classifications,commodity1,commodity2,commodity3,commodity4,commodity5,commodity6,commodity7,commodity8,completedate,crossreference,dateestablished,businessage,deposits,dunsnumber,enttype,expirationdate,extendeddate,issuingauthority,keywords,licensenumber,licensetype,mincd,minorityaffiliation,minorityownershipdate,siccode1,siccode2,siccode3,siccode4,siccode5,siccode6,siccode7,siccode8,naicscode1,naicscode2,naicscode3,naicscode4,naicscode5,naicscode6,naicscode7,naicscode8,prequalify,procurementcategory1,subprocurementcategory1,procurementcategory2,subprocurementcategory2,procurementcategory3,subprocurementcategory3,procurementcategory4,subprocurementcategory4,procurementcategory5,subprocurementcategory5,renewal,renewaldate,unitedcertprogrampartner,vendorkey,vendornumber,workcode1,workcode2,workcode3,workcode4,workcode5,workcode6,workcode7,workcode8,exporter,exportbusinessactivities,exportto,exportbusinessrelationships,exportobjectives,reference1,reference2,reference3';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Diversity_Certification\n'
    + 'FILENAME:Diversity_Certification\n'
    + 'NAMESCOPE:Input\n'
    + '\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789 .,-/+E$)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ )\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ )\n'
    + 'FIELDTYPE:Invalid_AlphaChar:ALLOW(aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ _,.\'-:;/&#@\\(\\))\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:ALLOW(0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ _,.\'-:;/&#@\\(\\))\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_Diversity_Certification.Functions.fn_valid_Date > 0)\n'
    + 'FIELDTYPE:Invalid_Future:CUSTOM(Scrubs_Diversity_Certification.Functions.fn_valid_Date > 0, \'Future\')\n'
    + 'FIELDTYPE:Invalid_State:CUSTOM(scrubs.functions.fn_Valid_StateAbbrev > 0)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_Float):LENGTHS(0,5,9,10)\n'
    + 'FIELDTYPE:Invalid_Phone:CUSTOM(Scrubs.Functions.fn_verify_optional_phone > 0)\n'
    + 'FIELDTYPE:Invalid_NAICS:CUSTOM(Scrubs_Diversity_Certification.Functions.fn_valid_naics > 0)\n'
    + 'FIELDTYPE:Invalid_Commodity:CUSTOM(Scrubs_Diversity_Certification.Functions.fn_valid_Commodity > 0)\n'
    + 'FIELDTYPE:Invalid_Sic:CUSTOM(Scrubs_Diversity_Certification.Functions.fn_valid_Sic > 0)\n'
    + '\n'
    + 'FIELD:dartid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:dateadded:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dateupdated:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:website:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:profilelastupdated:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:county:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:servicearea:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:region1:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:region2:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:region3:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:region4:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:region5:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:fname:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:lname:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:mname:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:suffix:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:title:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:ethnicity:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:gender:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:address1:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:address2:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:addresscity:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:addressstate:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:addresszipcode:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:addresszip4:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:building:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:contact:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:phone1:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:phone2:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:phone3:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:cell:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:fax:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:email1:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:email2:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:email3:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:webpage1:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:webpage2:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:webpage3:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:businessname:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:dba:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:businessid:TYPE(STRING):LIKE(Invalid_Float):00,0\n'
    + 'FIELD:businesstype1:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:businesslocation1:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:businesstype2:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:businesslocation2:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:businesstype3:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:businesslocation3:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:businesstype4:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:businesslocation4:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:businesstype5:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:businesslocation5:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:industry:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:trade:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:resourcedescription:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:natureofbusiness:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + '\n'
    + 'FIELD:businessstructure:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:totalemployees:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:avgcontractsize:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:firmid:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:firmlocationaddress:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:firmlocationaddresscity:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:firmlocationaddresszip4:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:firmlocationaddresszipcode:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:firmlocationcounty:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:firmlocationstate:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:certfed:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:certstate:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:contractsfederal:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:contractsva:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:contractscommercial:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:contractorgovernmentprime:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:contractorgovernmentsub:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:contractornongovernment:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:registeredgovernmentbus:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:registerednongovernmentbus:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clearancelevelpersonnel:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:clearancelevelfacility:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:certificatedatefrom1:TYPE(STRING):LIKE(Invalid_Date):00,0\n'
    + 'FIELD:certificatedateto1:TYPE(STRING):LIKE(Invalid_Future):0,0\n'
    + 'FIELD:certificatestatus1:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:certificationnumber1:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:certificationtype1:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:certificatedatefrom2:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:certificatedateto2:TYPE(STRING):LIKE(Invalid_Future):0,0\n'
    + 'FIELD:certificatestatus2:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:certificationnumber2:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:certificationtype2:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:certificatedatefrom3:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:certificatedateto3:TYPE(STRING):LIKE(Invalid_Future):0,0\n'
    + 'FIELD:certificatestatus3:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:certificationnumber3:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:certificationtype3:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:certificatedatefrom4:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:certificatedateto4:TYPE(STRING):LIKE(Invalid_Future):0,0\n'
    + 'FIELD:certificatestatus4:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:certificationnumber4:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:certificationtype4:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:certificatedatefrom5:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:certificatedateto5:TYPE(STRING):LIKE(Invalid_Future):0,0\n'
    + 'FIELD:certificatestatus5:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:certificationnumber5:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:certificationtype5:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:certificatedatefrom6:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:certificatedateto6:TYPE(STRING):LIKE(Invalid_Future):0,0\n'
    + 'FIELD:certificatestatus6:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:certificationnumber6:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:certificationtype6:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:starrating:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:assets:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:biddescription:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:competitiveadvantage:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:cagecode:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:capabilitiesnarrative:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:category:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:chtrclass:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:productdescription1:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:productdescription2:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:productdescription3:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:productdescription4:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:productdescription5:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:classdescription1:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subclassdescription1:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:classdescription2:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subclassdescription2:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:classdescription3:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subclassdescription3:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:classdescription4:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subclassdescription4:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:classdescription5:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subclassdescription5:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:classifications:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:commodity1:TYPE(STRING):LIKE(Invalid_Commodity):0,0\n'
    + 'FIELD:commodity2:TYPE(STRING):LIKE(Invalid_Commodity):0,0\n'
    + 'FIELD:commodity3:TYPE(STRING):LIKE(Invalid_Commodity):0,0\n'
    + 'FIELD:commodity4:TYPE(STRING):LIKE(Invalid_Commodity):0,0\n'
    + 'FIELD:commodity5:TYPE(STRING):LIKE(Invalid_Commodity):0,0\n'
    + 'FIELD:commodity6:TYPE(STRING):LIKE(Invalid_Commodity):0,0\n'
    + 'FIELD:commodity7:TYPE(STRING):LIKE(Invalid_Commodity):0,0\n'
    + 'FIELD:commodity8:TYPE(STRING):LIKE(Invalid_Commodity):0,0\n'
    + 'FIELD:completedate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:crossreference:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dateestablished:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:businessage:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:deposits:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:dunsnumber:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:enttype:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:expirationdate:TYPE(STRING):LIKE(Invalid_Future):0,0\n'
    + 'FIELD:extendeddate:TYPE(STRING):LIKE(Invalid_Future):0,0\n'
    + 'FIELD:issuingauthority:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:keywords:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:licensenumber:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:licensetype:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:mincd:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:minorityaffiliation:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:minorityownershipdate:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:siccode1:TYPE(STRING):LIKE(Invalid_Sic):0,0\n'
    + 'FIELD:siccode2:TYPE(STRING):LIKE(Invalid_Sic):0,0\n'
    + 'FIELD:siccode3:TYPE(STRING):LIKE(Invalid_Sic):0,0\n'
    + 'FIELD:siccode4:TYPE(STRING):LIKE(Invalid_Sic):0,0\n'
    + 'FIELD:siccode5:TYPE(STRING):LIKE(Invalid_Sic):0,0\n'
    + 'FIELD:siccode6:TYPE(STRING):LIKE(Invalid_Sic):0,0\n'
    + 'FIELD:siccode7:TYPE(STRING):LIKE(Invalid_Sic):0,0\n'
    + 'FIELD:siccode8:TYPE(STRING):LIKE(Invalid_Sic):0,0\n'
    + 'FIELD:naicscode1:TYPE(STRING):LIKE(Invalid_NAICS):0,0\n'
    + 'FIELD:naicscode2:TYPE(STRING):LIKE(Invalid_NAICS):0,0\n'
    + 'FIELD:naicscode3:TYPE(STRING):LIKE(Invalid_NAICS):0,0\n'
    + 'FIELD:naicscode4:TYPE(STRING):LIKE(Invalid_NAICS):0,0\n'
    + 'FIELD:naicscode5:TYPE(STRING):LIKE(Invalid_NAICS):0,0\n'
    + 'FIELD:naicscode6:TYPE(STRING):LIKE(Invalid_NAICS):0,0\n'
    + 'FIELD:naicscode7:TYPE(STRING):LIKE(Invalid_NAICS):0,0\n'
    + 'FIELD:naicscode8:TYPE(STRING):LIKE(Invalid_NAICS):0,0\n'
    + 'FIELD:prequalify:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:procurementcategory1:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subprocurementcategory1:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:procurementcategory2:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subprocurementcategory2:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:procurementcategory3:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subprocurementcategory3:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:procurementcategory4:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subprocurementcategory4:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:procurementcategory5:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subprocurementcategory5:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:renewal:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:renewaldate:TYPE(STRING):LIKE(Invalid_Future):0,0\n'
    + 'FIELD:unitedcertprogrampartner:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:vendorkey:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:vendornumber:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:workcode1:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:workcode2:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:workcode3:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:workcode4:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:workcode5:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:workcode6:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:workcode7:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:workcode8:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:exporter:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:exportbusinessactivities:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:exportto:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:exportbusinessrelationships:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:exportobjectives:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:reference1:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:reference2:TYPE(STRING):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:reference3:TYPE(STRING):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

