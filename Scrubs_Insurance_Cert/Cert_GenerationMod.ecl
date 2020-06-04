﻿// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Cert_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Insurance_Cert';
  EXPORT spc_NAMESCOPE := 'Cert';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Insurance_Cert';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,date_firstseen,date_lastseen,bdid,did,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,unique_id,norm_type,norm_businessname,norm_firstname,norm_middle,norm_last,norm_suffix,norm_address1,norm_address2,norm_city,norm_state,norm_zip,norm_zip4,norm_phone,dartid,dateadded,dateupdated,website,state,lninscertrecordid,profilelastupdated,siid,sipstatuscode,wcbempnumber,ubinumber,cofanumber,usdotnumber,phone2,phone3,fax1,fax2,email1,email2,businesstype,nametitle,mailingaddress1,mailingaddress2,mailingaddresscity,mailingaddressstate,mailingaddresszip,mailingaddresszip4,contactfax,contactemail,policyholdernamefirst,policyholdernamemiddle,policyholdernamelast,policyholdernamesuffix,statepolicyfilenumber,coverageinjuryillnessdate,selfinsurancegroup,selfinsurancegroupphone,selfinsurancegroupid,numberofemployees,licensedcontractor,mconame,mconumber,mcoaddressline1,mcoaddressline2,mcocity,mcostate,mcozip,mcozip4,mcophone,governingclasscode,licensenumber,class,classificationdescription,licensestatus,licenseadditionalinfo,licenseissuedate,licenseexpirationdate,naicscode,officerexemptfirstname1,officerexemptlastname1,officerexemptmiddlename1,officerexempttitle1,officerexempteffectivedate1,officerexemptterminationdate1,officerexempttype1,officerexemptbusinessactivities1,officerexemptfirstname2,officerexemptlastname2,officerexemptmiddlename2,officerexempttitle2,officerexempteffectivedate2,officerexemptterminationdate2,officerexempttype2,officerexemptbusinessactivities2,officerexemptfirstname3,officerexemptlastname3,officerexemptmiddlename3,officerexempttitle3,officerexempteffectivedate3,officerexemptterminationdate3,officerexempttype3,officerexemptbusinessactivities3,officerexemptfirstname4,officerexemptlastname4,officerexemptmiddlename4,officerexempttitle4,officerexempteffectivedate4,officerexemptterminationdate4,officerexempttype4,officerexemptbusinessactivities4,officerexemptfirstname5,officerexemptlastname5,officerexemptmiddlename5,officerexempttitle5,officerexempteffectivedate5,officerexemptterminationdate5,officerexempttype5,officerexemptbusinessactivities5,dba1,dbadatefrom1,dbadateto1,dbatype1,dba2,dbadatefrom2,dbadateto2,dbatype2,dba3,dbadatefrom3,dbadateto3,dbatype3,dba4,dbadatefrom4,dbadateto4,dbatype4,dba5,dbadatefrom5,dbadateto5,dbatype5,subsidiaryname1,subsidiarystartdate1,subsidiaryname2,subsidiarystartdate2,subsidiaryname3,subsidiarystartdate3,subsidiaryname4,subsidiarystartdate4,subsidiaryname5,subsidiarystartdate5,subsidiaryname6,subsidiarystartdate6,subsidiaryname7,subsidiarystartdate7,subsidiaryname8,subsidiarystartdate8,subsidiaryname9,subsidiarystartdate9,subsidiaryname10,subsidiarystartdate10,append_mailaddress1,append_mailaddresslast,append_mailrawaid,append_mailaceaid';
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
    + 'MODULE:Scrubs_Insurance_Cert\n'
    + 'FILENAME:Insurance_Cert\n'
    + 'NAMESCOPE:Cert\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.Fn_Valid_Date > 0)\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789NA)\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789,.-/NA)\n'
    + 'FIELDTYPE:Invalid_Alpha:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'Alpha\')\n'
    + 'FIELDTYPE:Invalid_AlphaNum:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNum\')\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, \'AlphaNumChar\')\n'
    + 'FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_Float):LENGTHS(0,5,9)\n'
    + 'FIELDTYPE:Invalid_Phone:LIKE(Invalid_No):LENGTHS(0,9,10)\n'
    + 'FIELDTYPE:Invalid_NAICS:CUSTOM(Scrubs.Functions.fn_naics > 0)\n'
    + '\n'
    + '\n'
    + 'FIELD:date_firstseen:TYPE(UNSIGNED8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:date_lastseen:TYPE(UNSIGNED8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dotweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:empscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:powscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:proxscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:selescore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:orgscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:ultscore:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultweight:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:unique_id:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:norm_type:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:norm_businessname:TYPE(STRING205):LIKE(Invalid_AlphaChar):0,0\n'
    + 'FIELD:norm_firstname:TYPE(STRING30):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:norm_middle:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:norm_last:TYPE(STRING30):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:norm_suffix:TYPE(STRING10):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:norm_address1:TYPE(STRING75):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:norm_address2:TYPE(STRING75):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:norm_city:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:norm_state:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:norm_zip:TYPE(STRING5):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:norm_zip4:TYPE(STRING5):LIKE(Invalid_No):0,0\n'
    + 'FIELD:norm_phone:TYPE(STRING15):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:dartid:TYPE(STRING15):LIKE(Invalid_No):0,0\n'
    + 'FIELD:dateadded:TYPE(UNSIGNED8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dateupdated:TYPE(UNSIGNED8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:website:TYPE(STRING80):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:lninscertrecordid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:profilelastupdated:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:siid:TYPE(STRING10):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:sipstatuscode:TYPE(STRING15):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:wcbempnumber:TYPE(STRING15):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:ubinumber:TYPE(STRING15):LIKE(Invalid_No):0,0\n'
    + 'FIELD:cofanumber:TYPE(STRING25):LIKE(Invalid_No):0,0\n'
    + 'FIELD:usdotnumber:TYPE(STRING15):LIKE(Invalid_No):0,0\n'
    + 'FIELD:phone2:TYPE(STRING15):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:phone3:TYPE(STRING15):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:fax1:TYPE(STRING15):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:fax2:TYPE(STRING15):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:email1:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:email2:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:businesstype:TYPE(STRING40):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:nametitle:TYPE(STRING35):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:mailingaddress1:TYPE(STRING75):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:mailingaddress2:TYPE(STRING75):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:mailingaddresscity:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:mailingaddressstate:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:mailingaddresszip:TYPE(STRING5):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:mailingaddresszip4:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:contactfax:TYPE(STRING15):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:contactemail:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:policyholdernamefirst:TYPE(STRING20):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:policyholdernamemiddle:TYPE(STRING1):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:policyholdernamelast:TYPE(STRING30):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:policyholdernamesuffix:TYPE(STRING10):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:statepolicyfilenumber:TYPE(STRING30):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:coverageinjuryillnessdate:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:selfinsurancegroup:TYPE(STRING80):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:selfinsurancegroupphone:TYPE(STRING15):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:selfinsurancegroupid:TYPE(STRING25):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:numberofemployees:TYPE(STRING60):LIKE(Invalid_No):0,0\n'
    + 'FIELD:licensedcontractor:TYPE(STRING10):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:mconame:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:mconumber:TYPE(STRING10):LIKE(Invalid_No):0,0\n'
    + 'FIELD:mcoaddressline1:TYPE(STRING75):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:mcoaddressline2:TYPE(STRING75):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:mcocity:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:mcostate:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:mcozip:TYPE(STRING5):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:mcozip4:TYPE(STRING4):LIKE(Invalid_No):0,0\n'
    + 'FIELD:mcophone:TYPE(STRING15):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:governingclasscode:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:licensenumber:TYPE(STRING8):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:class:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:classificationdescription:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:licensestatus:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:licenseadditionalinfo:TYPE(STRING8):0,0\n'
    + 'FIELD:licenseissuedate:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:licenseexpirationdate:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:naicscode:TYPE(STRING8):LIKE(Invalid_NAICS):0,0\n'
    + 'FIELD:officerexemptfirstname1:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptlastname1:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptmiddlename1:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexempttitle1:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexempteffectivedate1:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:officerexemptterminationdate1:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:officerexempttype1:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptbusinessactivities1:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptfirstname2:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptlastname2:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptmiddlename2:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexempttitle2:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexempteffectivedate2:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:officerexemptterminationdate2:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:officerexempttype2:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptbusinessactivities2:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptfirstname3:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptlastname3:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptmiddlename3:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexempttitle3:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexempteffectivedate3:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:officerexemptterminationdate3:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:officerexempttype3:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptbusinessactivities3:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptfirstname4:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptlastname4:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptmiddlename4:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexempttitle4:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexempteffectivedate4:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:officerexemptterminationdate4:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:officerexempttype4:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptbusinessactivities4:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptfirstname5:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptlastname5:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptmiddlename5:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexempttitle5:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexempteffectivedate5:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:officerexemptterminationdate5:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:officerexempttype5:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:officerexemptbusinessactivities5:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dba1:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dbadatefrom1:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dbadateto1:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dbatype1:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dba2:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dbadatefrom2:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dbadateto2:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dbatype2:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dba3:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dbadatefrom3:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dbadateto3:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dbatype3:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dba4:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dbadatefrom4:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dbadateto4:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dbatype4:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dba5:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:dbadatefrom5:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dbadateto5:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dbatype5:TYPE(STRING8):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiaryname1:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiarystartdate1:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:subsidiaryname2:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiarystartdate2:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:subsidiaryname3:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiarystartdate3:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:subsidiaryname4:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiarystartdate4:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:subsidiaryname5:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiarystartdate5:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:subsidiaryname6:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiarystartdate6:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:subsidiaryname7:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiarystartdate7:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:subsidiaryname8:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiarystartdate8:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:subsidiaryname9:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiarystartdate9:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:subsidiaryname10:TYPE(STRING50):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:subsidiarystartdate10:TYPE(STRING8):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:append_mailaddress1:TYPE(STRING100):LIKE(Invalid_AlphaNum):0,0\n'
    + 'FIELD:append_mailaddresslast:TYPE(STRING50):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:append_mailrawaid:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:append_mailaceaid:TYPE(UNSIGNED8):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

