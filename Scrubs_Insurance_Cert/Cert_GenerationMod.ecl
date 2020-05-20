// Machine-readable versions of the spec file and subsets thereof
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dartid,dateadded,dateupdated,website,state,lninscertrecordid,profilelastupdated,siid,sipstatuscode,wcbempnumber,ubinumber,cofanumber,usdotnumber,businessname,dba,addressline1,addressline2,addresscity,addressstate,addresszip,zip4,phone1,phone2,phone3,fax1,fax2,email1,email2,businesstype,namefirst,namemiddle,namelast,namesuffix,nametitle,mailingaddress1,mailingaddress2,mailingaddresscity,mailingaddressstate,mailingaddresszip,mailingaddresszip4,contactnamefirst,contactnamemiddle,contactnamelast,contactnamesuffix,contactbusinessname,contactaddressline1,contactaddressline2,contactcity,contactstate,contactzip,contactzip4,contactphone,contactfax,contactemail,policyholdernamefirst,policyholdernamemiddle,policyholdernamelast,policyholdernamesuffix,statepolicyfilenumber,coverageinjuryillnessdate,selfinsurancegroup,selfinsurancegroupphone,selfinsurancegroupid,numberofemployees,licensedcontractor,mconame,mconumber,mcoaddressline1,mcoaddressline2,mcocity,mcostate,mcozip,mcozip4,mcophone,governingclasscode,licensenumber,class,classificationdescription,licensestatus,licenseadditionalinfo,licenseissuedate,licenseexpirationdate,naicscode,officerexemptfirstname1,officerexemptlastname1,officerexemptmiddlename1,officerexempttitle1,officerexempteffectivedate1,officerexemptterminationdate1,officerexempttype1,officerexemptbusinessactivities1,officerexemptfirstname2,officerexemptlastname2,officerexemptmiddlename2,officerexempttitle2,officerexempteffectivedate2,officerexemptterminationdate2,officerexempttype2,officerexemptbusinessactivities2,officerexemptfirstname3,officerexemptlastname3,officerexemptmiddlename3,officerexempttitle3,officerexempteffectivedate3,officerexemptterminationdate3,officerexempttype3,officerexemptbusinessactivities3,officerexemptfirstname4,officerexemptlastname4,officerexemptmiddlename4,officerexempttitle4,officerexempteffectivedate4,officerexemptterminationdate4,officerexempttype4,officerexemptbusinessactivities4,officerexemptfirstname5,officerexemptlastname5,officerexemptmiddlename5,officerexempttitle5,officerexempteffectivedate5,officerexemptterminationdate5,officerexempttype5,officerexemptbusinessactivities5,dba1,dbadatefrom1,dbadateto1,dbatype1,dba2,dbadatefrom2,dbadateto2,dbatype2,dba3,dbadatefrom3,dbadateto3,dbatype3,dba4,dbadatefrom4,dbadateto4,dbatype4,dba5,dbadatefrom5,dbadateto5,dbatype5,subsidiaryname1,subsidiarystartdate1,subsidiaryname2,subsidiarystartdate2,subsidiaryname3,subsidiarystartdate3,subsidiaryname4,subsidiarystartdate4,subsidiaryname5,subsidiarystartdate5,subsidiaryname6,subsidiarystartdate6,subsidiaryname7,subsidiarystartdate7,subsidiaryname8,subsidiarystartdate8,subsidiaryname9,subsidiarystartdate9,subsidiaryname10,subsidiarystartdate10';
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
    + 'FIELDTYPE:Test:ALLOW(x)\n'
    + '\n'
    + 'FIELD:dartid:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dateadded:TYPE(UNSIGNED8):LIKE(Test):0,0\n'
    + 'FIELD:dateupdated:TYPE(UNSIGNED8):LIKE(Test):0,0\n'
    + 'FIELD:website:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:lninscertrecordid:TYPE(UNSIGNED8):LIKE(Test):0,0\n'
    + 'FIELD:profilelastupdated:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:siid:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:sipstatuscode:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:wcbempnumber:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:ubinumber:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:cofanumber:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:usdotnumber:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:businessname:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dba:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:addressline1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:addressline2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:addresscity:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:addressstate:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:addresszip:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:zip4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:phone1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:phone2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:phone3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:fax1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:fax2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:email1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:email2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:businesstype:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:namefirst:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:namemiddle:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:namelast:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:namesuffix:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:nametitle:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mailingaddress1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mailingaddress2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mailingaddresscity:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mailingaddressstate:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mailingaddresszip:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mailingaddresszip4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactnamefirst:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactnamemiddle:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactnamelast:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactnamesuffix:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactbusinessname:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactaddressline1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactaddressline2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactcity:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactstate:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactzip:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactzip4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactphone:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactfax:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:contactemail:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:policyholdernamefirst:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:policyholdernamemiddle:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:policyholdernamelast:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:policyholdernamesuffix:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:statepolicyfilenumber:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:coverageinjuryillnessdate:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:selfinsurancegroup:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:selfinsurancegroupphone:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:selfinsurancegroupid:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:numberofemployees:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:licensedcontractor:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mconame:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mconumber:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mcoaddressline1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mcoaddressline2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mcocity:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mcostate:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mcozip:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mcozip4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:mcophone:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:governingclasscode:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:licensenumber:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:class:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:classificationdescription:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:licensestatus:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:licenseadditionalinfo:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:licenseissuedate:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:licenseexpirationdate:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:naicscode:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptfirstname1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptlastname1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptmiddlename1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempttitle1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempteffectivedate1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptterminationdate1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempttype1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptbusinessactivities1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptfirstname2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptlastname2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptmiddlename2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempttitle2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempteffectivedate2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptterminationdate2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempttype2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptbusinessactivities2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptfirstname3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptlastname3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptmiddlename3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempttitle3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempteffectivedate3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptterminationdate3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempttype3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptbusinessactivities3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptfirstname4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptlastname4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptmiddlename4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempttitle4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempteffectivedate4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptterminationdate4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempttype4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptbusinessactivities4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptfirstname5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptlastname5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptmiddlename5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempttitle5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempteffectivedate5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptterminationdate5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexempttype5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:officerexemptbusinessactivities5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dba1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbadatefrom1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbadateto1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbatype1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dba2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbadatefrom2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbadateto2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbatype2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dba3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbadatefrom3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbadateto3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbatype3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dba4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbadatefrom4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbadateto4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbatype4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dba5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbadatefrom5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbadateto5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:dbatype5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiaryname1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiarystartdate1:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiaryname2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiarystartdate2:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiaryname3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiarystartdate3:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiaryname4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiarystartdate4:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiaryname5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiarystartdate5:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiaryname6:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiarystartdate6:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiaryname7:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiarystartdate7:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiaryname8:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiarystartdate8:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiaryname9:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiarystartdate9:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiaryname10:TYPE(STRING):LIKE(Test):0,0\n'
    + 'FIELD:subsidiarystartdate10:TYPE(STRING):LIKE(Test):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

