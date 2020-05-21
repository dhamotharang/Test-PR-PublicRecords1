IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Cert_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 166;
  EXPORT NumRulesFromFieldType := 166;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 163;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Cert_Layout_Insurance_Cert)
    UNSIGNED1 dartid_Invalid;
    UNSIGNED1 dateadded_Invalid;
    UNSIGNED1 dateupdated_Invalid;
    UNSIGNED1 website_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 lninscertrecordid_Invalid;
    UNSIGNED1 profilelastupdated_Invalid;
    UNSIGNED1 siid_Invalid;
    UNSIGNED1 sipstatuscode_Invalid;
    UNSIGNED1 wcbempnumber_Invalid;
    UNSIGNED1 ubinumber_Invalid;
    UNSIGNED1 cofanumber_Invalid;
    UNSIGNED1 usdotnumber_Invalid;
    UNSIGNED1 businessname_Invalid;
    UNSIGNED1 dba_Invalid;
    UNSIGNED1 addressline1_Invalid;
    UNSIGNED1 addressline2_Invalid;
    UNSIGNED1 addresscity_Invalid;
    UNSIGNED1 addressstate_Invalid;
    UNSIGNED1 addresszip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 phone1_Invalid;
    UNSIGNED1 phone2_Invalid;
    UNSIGNED1 phone3_Invalid;
    UNSIGNED1 fax1_Invalid;
    UNSIGNED1 fax2_Invalid;
    UNSIGNED1 email1_Invalid;
    UNSIGNED1 email2_Invalid;
    UNSIGNED1 businesstype_Invalid;
    UNSIGNED1 namefirst_Invalid;
    UNSIGNED1 namemiddle_Invalid;
    UNSIGNED1 namelast_Invalid;
    UNSIGNED1 namesuffix_Invalid;
    UNSIGNED1 nametitle_Invalid;
    UNSIGNED1 mailingaddress1_Invalid;
    UNSIGNED1 mailingaddress2_Invalid;
    UNSIGNED1 mailingaddresscity_Invalid;
    UNSIGNED1 mailingaddressstate_Invalid;
    UNSIGNED1 mailingaddresszip_Invalid;
    UNSIGNED1 mailingaddresszip4_Invalid;
    UNSIGNED1 contactnamefirst_Invalid;
    UNSIGNED1 contactnamemiddle_Invalid;
    UNSIGNED1 contactnamelast_Invalid;
    UNSIGNED1 contactnamesuffix_Invalid;
    UNSIGNED1 contactbusinessname_Invalid;
    UNSIGNED1 contactaddressline1_Invalid;
    UNSIGNED1 contactaddressline2_Invalid;
    UNSIGNED1 contactcity_Invalid;
    UNSIGNED1 contactstate_Invalid;
    UNSIGNED1 contactzip_Invalid;
    UNSIGNED1 contactzip4_Invalid;
    UNSIGNED1 contactphone_Invalid;
    UNSIGNED1 contactfax_Invalid;
    UNSIGNED1 contactemail_Invalid;
    UNSIGNED1 policyholdernamefirst_Invalid;
    UNSIGNED1 policyholdernamemiddle_Invalid;
    UNSIGNED1 policyholdernamelast_Invalid;
    UNSIGNED1 policyholdernamesuffix_Invalid;
    UNSIGNED1 statepolicyfilenumber_Invalid;
    UNSIGNED1 coverageinjuryillnessdate_Invalid;
    UNSIGNED1 selfinsurancegroup_Invalid;
    UNSIGNED1 selfinsurancegroupphone_Invalid;
    UNSIGNED1 selfinsurancegroupid_Invalid;
    UNSIGNED1 numberofemployees_Invalid;
    UNSIGNED1 licensedcontractor_Invalid;
    UNSIGNED1 mconame_Invalid;
    UNSIGNED1 mconumber_Invalid;
    UNSIGNED1 mcoaddressline1_Invalid;
    UNSIGNED1 mcoaddressline2_Invalid;
    UNSIGNED1 mcocity_Invalid;
    UNSIGNED1 mcostate_Invalid;
    UNSIGNED1 mcozip_Invalid;
    UNSIGNED1 mcozip4_Invalid;
    UNSIGNED1 mcophone_Invalid;
    UNSIGNED1 governingclasscode_Invalid;
    UNSIGNED1 licensenumber_Invalid;
    UNSIGNED1 class_Invalid;
    UNSIGNED1 classificationdescription_Invalid;
    UNSIGNED1 licensestatus_Invalid;
    UNSIGNED1 licenseadditionalinfo_Invalid;
    UNSIGNED1 licenseissuedate_Invalid;
    UNSIGNED1 licenseexpirationdate_Invalid;
    UNSIGNED1 naicscode_Invalid;
    UNSIGNED1 officerexemptfirstname1_Invalid;
    UNSIGNED1 officerexemptlastname1_Invalid;
    UNSIGNED1 officerexemptmiddlename1_Invalid;
    UNSIGNED1 officerexempttitle1_Invalid;
    UNSIGNED1 officerexempteffectivedate1_Invalid;
    UNSIGNED1 officerexemptterminationdate1_Invalid;
    UNSIGNED1 officerexempttype1_Invalid;
    UNSIGNED1 officerexemptbusinessactivities1_Invalid;
    UNSIGNED1 officerexemptfirstname2_Invalid;
    UNSIGNED1 officerexemptlastname2_Invalid;
    UNSIGNED1 officerexemptmiddlename2_Invalid;
    UNSIGNED1 officerexempttitle2_Invalid;
    UNSIGNED1 officerexempteffectivedate2_Invalid;
    UNSIGNED1 officerexemptterminationdate2_Invalid;
    UNSIGNED1 officerexempttype2_Invalid;
    UNSIGNED1 officerexemptbusinessactivities2_Invalid;
    UNSIGNED1 officerexemptfirstname3_Invalid;
    UNSIGNED1 officerexemptlastname3_Invalid;
    UNSIGNED1 officerexemptmiddlename3_Invalid;
    UNSIGNED1 officerexempttitle3_Invalid;
    UNSIGNED1 officerexempteffectivedate3_Invalid;
    UNSIGNED1 officerexemptterminationdate3_Invalid;
    UNSIGNED1 officerexempttype3_Invalid;
    UNSIGNED1 officerexemptbusinessactivities3_Invalid;
    UNSIGNED1 officerexemptfirstname4_Invalid;
    UNSIGNED1 officerexemptlastname4_Invalid;
    UNSIGNED1 officerexemptmiddlename4_Invalid;
    UNSIGNED1 officerexempttitle4_Invalid;
    UNSIGNED1 officerexempteffectivedate4_Invalid;
    UNSIGNED1 officerexemptterminationdate4_Invalid;
    UNSIGNED1 officerexempttype4_Invalid;
    UNSIGNED1 officerexemptbusinessactivities4_Invalid;
    UNSIGNED1 officerexemptfirstname5_Invalid;
    UNSIGNED1 officerexemptlastname5_Invalid;
    UNSIGNED1 officerexemptmiddlename5_Invalid;
    UNSIGNED1 officerexempttitle5_Invalid;
    UNSIGNED1 officerexempteffectivedate5_Invalid;
    UNSIGNED1 officerexemptterminationdate5_Invalid;
    UNSIGNED1 officerexempttype5_Invalid;
    UNSIGNED1 officerexemptbusinessactivities5_Invalid;
    UNSIGNED1 dba1_Invalid;
    UNSIGNED1 dbadatefrom1_Invalid;
    UNSIGNED1 dbadateto1_Invalid;
    UNSIGNED1 dbatype1_Invalid;
    UNSIGNED1 dba2_Invalid;
    UNSIGNED1 dbadatefrom2_Invalid;
    UNSIGNED1 dbadateto2_Invalid;
    UNSIGNED1 dbatype2_Invalid;
    UNSIGNED1 dba3_Invalid;
    UNSIGNED1 dbadatefrom3_Invalid;
    UNSIGNED1 dbadateto3_Invalid;
    UNSIGNED1 dbatype3_Invalid;
    UNSIGNED1 dba4_Invalid;
    UNSIGNED1 dbadatefrom4_Invalid;
    UNSIGNED1 dbadateto4_Invalid;
    UNSIGNED1 dbatype4_Invalid;
    UNSIGNED1 dba5_Invalid;
    UNSIGNED1 dbadatefrom5_Invalid;
    UNSIGNED1 dbadateto5_Invalid;
    UNSIGNED1 dbatype5_Invalid;
    UNSIGNED1 subsidiaryname1_Invalid;
    UNSIGNED1 subsidiarystartdate1_Invalid;
    UNSIGNED1 subsidiaryname2_Invalid;
    UNSIGNED1 subsidiarystartdate2_Invalid;
    UNSIGNED1 subsidiaryname3_Invalid;
    UNSIGNED1 subsidiarystartdate3_Invalid;
    UNSIGNED1 subsidiaryname4_Invalid;
    UNSIGNED1 subsidiarystartdate4_Invalid;
    UNSIGNED1 subsidiaryname5_Invalid;
    UNSIGNED1 subsidiarystartdate5_Invalid;
    UNSIGNED1 subsidiaryname6_Invalid;
    UNSIGNED1 subsidiarystartdate6_Invalid;
    UNSIGNED1 subsidiaryname7_Invalid;
    UNSIGNED1 subsidiarystartdate7_Invalid;
    UNSIGNED1 subsidiaryname8_Invalid;
    UNSIGNED1 subsidiarystartdate8_Invalid;
    UNSIGNED1 subsidiaryname9_Invalid;
    UNSIGNED1 subsidiarystartdate9_Invalid;
    UNSIGNED1 subsidiaryname10_Invalid;
    UNSIGNED1 subsidiarystartdate10_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Cert_Layout_Insurance_Cert)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
  END;
  EXPORT Rule_Layout := RECORD(Cert_Layout_Insurance_Cert)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dartid:Invalid_No:ALLOW'
          ,'dateadded:Invalid_Date:CUSTOM'
          ,'dateupdated:Invalid_Date:CUSTOM'
          ,'website:Invalid_Alpha:ALLOW'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTHS'
          ,'lninscertrecordid:Invalid_No:ALLOW'
          ,'profilelastupdated:Invalid_Date:CUSTOM'
          ,'siid:Invalid_No:ALLOW'
          ,'sipstatuscode:Test:ALLOW'
          ,'wcbempnumber:Invalid_No:ALLOW'
          ,'ubinumber:Invalid_No:ALLOW'
          ,'cofanumber:Invalid_No:ALLOW'
          ,'usdotnumber:Invalid_No:ALLOW'
          ,'businessname:Invalid_AlphaChar:ALLOW'
          ,'dba:Invalid_AlphaChar:ALLOW'
          ,'addressline1:Invalid_AlphaChar:ALLOW'
          ,'addressline2:Invalid_AlphaNum:ALLOW'
          ,'addresscity:Invalid_AlphaCaps:ALLOW'
          ,'addressstate:Invalid_State:ALLOW','addressstate:Invalid_State:LENGTHS'
          ,'addresszip:Invalid_Zip:ALLOW','addresszip:Invalid_Zip:LENGTHS'
          ,'zip4:Invalid_No:ALLOW'
          ,'phone1:Test:ALLOW'
          ,'phone2:Test:ALLOW'
          ,'phone3:Test:ALLOW'
          ,'fax1:Test:ALLOW'
          ,'fax2:Test:ALLOW'
          ,'email1:Test:ALLOW'
          ,'email2:Test:ALLOW'
          ,'businesstype:Test:ALLOW'
          ,'namefirst:Test:ALLOW'
          ,'namemiddle:Test:ALLOW'
          ,'namelast:Test:ALLOW'
          ,'namesuffix:Test:ALLOW'
          ,'nametitle:Test:ALLOW'
          ,'mailingaddress1:Test:ALLOW'
          ,'mailingaddress2:Test:ALLOW'
          ,'mailingaddresscity:Test:ALLOW'
          ,'mailingaddressstate:Test:ALLOW'
          ,'mailingaddresszip:Test:ALLOW'
          ,'mailingaddresszip4:Test:ALLOW'
          ,'contactnamefirst:Test:ALLOW'
          ,'contactnamemiddle:Test:ALLOW'
          ,'contactnamelast:Test:ALLOW'
          ,'contactnamesuffix:Test:ALLOW'
          ,'contactbusinessname:Test:ALLOW'
          ,'contactaddressline1:Test:ALLOW'
          ,'contactaddressline2:Test:ALLOW'
          ,'contactcity:Test:ALLOW'
          ,'contactstate:Test:ALLOW'
          ,'contactzip:Test:ALLOW'
          ,'contactzip4:Test:ALLOW'
          ,'contactphone:Test:ALLOW'
          ,'contactfax:Test:ALLOW'
          ,'contactemail:Test:ALLOW'
          ,'policyholdernamefirst:Test:ALLOW'
          ,'policyholdernamemiddle:Test:ALLOW'
          ,'policyholdernamelast:Test:ALLOW'
          ,'policyholdernamesuffix:Test:ALLOW'
          ,'statepolicyfilenumber:Test:ALLOW'
          ,'coverageinjuryillnessdate:Test:ALLOW'
          ,'selfinsurancegroup:Invalid_AlphaCaps:ALLOW'
          ,'selfinsurancegroupphone:Test:ALLOW'
          ,'selfinsurancegroupid:Test:ALLOW'
          ,'numberofemployees:Test:ALLOW'
          ,'licensedcontractor:Test:ALLOW'
          ,'mconame:Test:ALLOW'
          ,'mconumber:Test:ALLOW'
          ,'mcoaddressline1:Test:ALLOW'
          ,'mcoaddressline2:Test:ALLOW'
          ,'mcocity:Test:ALLOW'
          ,'mcostate:Test:ALLOW'
          ,'mcozip:Test:ALLOW'
          ,'mcozip4:Test:ALLOW'
          ,'mcophone:Test:ALLOW'
          ,'governingclasscode:Test:ALLOW'
          ,'licensenumber:Test:ALLOW'
          ,'class:Test:ALLOW'
          ,'classificationdescription:Test:ALLOW'
          ,'licensestatus:Test:ALLOW'
          ,'licenseadditionalinfo:Test:ALLOW'
          ,'licenseissuedate:Test:ALLOW'
          ,'licenseexpirationdate:Test:ALLOW'
          ,'naicscode:Test:ALLOW'
          ,'officerexemptfirstname1:Test:ALLOW'
          ,'officerexemptlastname1:Test:ALLOW'
          ,'officerexemptmiddlename1:Test:ALLOW'
          ,'officerexempttitle1:Test:ALLOW'
          ,'officerexempteffectivedate1:Test:ALLOW'
          ,'officerexemptterminationdate1:Test:ALLOW'
          ,'officerexempttype1:Test:ALLOW'
          ,'officerexemptbusinessactivities1:Test:ALLOW'
          ,'officerexemptfirstname2:Test:ALLOW'
          ,'officerexemptlastname2:Test:ALLOW'
          ,'officerexemptmiddlename2:Test:ALLOW'
          ,'officerexempttitle2:Test:ALLOW'
          ,'officerexempteffectivedate2:Test:ALLOW'
          ,'officerexemptterminationdate2:Test:ALLOW'
          ,'officerexempttype2:Test:ALLOW'
          ,'officerexemptbusinessactivities2:Test:ALLOW'
          ,'officerexemptfirstname3:Test:ALLOW'
          ,'officerexemptlastname3:Test:ALLOW'
          ,'officerexemptmiddlename3:Test:ALLOW'
          ,'officerexempttitle3:Test:ALLOW'
          ,'officerexempteffectivedate3:Test:ALLOW'
          ,'officerexemptterminationdate3:Test:ALLOW'
          ,'officerexempttype3:Test:ALLOW'
          ,'officerexemptbusinessactivities3:Test:ALLOW'
          ,'officerexemptfirstname4:Test:ALLOW'
          ,'officerexemptlastname4:Test:ALLOW'
          ,'officerexemptmiddlename4:Test:ALLOW'
          ,'officerexempttitle4:Test:ALLOW'
          ,'officerexempteffectivedate4:Test:ALLOW'
          ,'officerexemptterminationdate4:Test:ALLOW'
          ,'officerexempttype4:Test:ALLOW'
          ,'officerexemptbusinessactivities4:Test:ALLOW'
          ,'officerexemptfirstname5:Test:ALLOW'
          ,'officerexemptlastname5:Test:ALLOW'
          ,'officerexemptmiddlename5:Test:ALLOW'
          ,'officerexempttitle5:Test:ALLOW'
          ,'officerexempteffectivedate5:Test:ALLOW'
          ,'officerexemptterminationdate5:Test:ALLOW'
          ,'officerexempttype5:Test:ALLOW'
          ,'officerexemptbusinessactivities5:Test:ALLOW'
          ,'dba1:Test:ALLOW'
          ,'dbadatefrom1:Test:ALLOW'
          ,'dbadateto1:Test:ALLOW'
          ,'dbatype1:Test:ALLOW'
          ,'dba2:Test:ALLOW'
          ,'dbadatefrom2:Test:ALLOW'
          ,'dbadateto2:Test:ALLOW'
          ,'dbatype2:Test:ALLOW'
          ,'dba3:Test:ALLOW'
          ,'dbadatefrom3:Test:ALLOW'
          ,'dbadateto3:Test:ALLOW'
          ,'dbatype3:Test:ALLOW'
          ,'dba4:Test:ALLOW'
          ,'dbadatefrom4:Test:ALLOW'
          ,'dbadateto4:Test:ALLOW'
          ,'dbatype4:Test:ALLOW'
          ,'dba5:Test:ALLOW'
          ,'dbadatefrom5:Test:ALLOW'
          ,'dbadateto5:Test:ALLOW'
          ,'dbatype5:Test:ALLOW'
          ,'subsidiaryname1:Test:ALLOW'
          ,'subsidiarystartdate1:Test:ALLOW'
          ,'subsidiaryname2:Test:ALLOW'
          ,'subsidiarystartdate2:Test:ALLOW'
          ,'subsidiaryname3:Test:ALLOW'
          ,'subsidiarystartdate3:Test:ALLOW'
          ,'subsidiaryname4:Test:ALLOW'
          ,'subsidiarystartdate4:Test:ALLOW'
          ,'subsidiaryname5:Test:ALLOW'
          ,'subsidiarystartdate5:Test:ALLOW'
          ,'subsidiaryname6:Test:ALLOW'
          ,'subsidiarystartdate6:Test:ALLOW'
          ,'subsidiaryname7:Test:ALLOW'
          ,'subsidiarystartdate7:Test:ALLOW'
          ,'subsidiaryname8:Test:ALLOW'
          ,'subsidiarystartdate8:Test:ALLOW'
          ,'subsidiaryname9:Test:ALLOW'
          ,'subsidiarystartdate9:Test:ALLOW'
          ,'subsidiaryname10:Test:ALLOW'
          ,'subsidiarystartdate10:Test:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Cert_Fields.InvalidMessage_dartid(1)
          ,Cert_Fields.InvalidMessage_dateadded(1)
          ,Cert_Fields.InvalidMessage_dateupdated(1)
          ,Cert_Fields.InvalidMessage_website(1)
          ,Cert_Fields.InvalidMessage_state(1),Cert_Fields.InvalidMessage_state(2)
          ,Cert_Fields.InvalidMessage_lninscertrecordid(1)
          ,Cert_Fields.InvalidMessage_profilelastupdated(1)
          ,Cert_Fields.InvalidMessage_siid(1)
          ,Cert_Fields.InvalidMessage_sipstatuscode(1)
          ,Cert_Fields.InvalidMessage_wcbempnumber(1)
          ,Cert_Fields.InvalidMessage_ubinumber(1)
          ,Cert_Fields.InvalidMessage_cofanumber(1)
          ,Cert_Fields.InvalidMessage_usdotnumber(1)
          ,Cert_Fields.InvalidMessage_businessname(1)
          ,Cert_Fields.InvalidMessage_dba(1)
          ,Cert_Fields.InvalidMessage_addressline1(1)
          ,Cert_Fields.InvalidMessage_addressline2(1)
          ,Cert_Fields.InvalidMessage_addresscity(1)
          ,Cert_Fields.InvalidMessage_addressstate(1),Cert_Fields.InvalidMessage_addressstate(2)
          ,Cert_Fields.InvalidMessage_addresszip(1),Cert_Fields.InvalidMessage_addresszip(2)
          ,Cert_Fields.InvalidMessage_zip4(1)
          ,Cert_Fields.InvalidMessage_phone1(1)
          ,Cert_Fields.InvalidMessage_phone2(1)
          ,Cert_Fields.InvalidMessage_phone3(1)
          ,Cert_Fields.InvalidMessage_fax1(1)
          ,Cert_Fields.InvalidMessage_fax2(1)
          ,Cert_Fields.InvalidMessage_email1(1)
          ,Cert_Fields.InvalidMessage_email2(1)
          ,Cert_Fields.InvalidMessage_businesstype(1)
          ,Cert_Fields.InvalidMessage_namefirst(1)
          ,Cert_Fields.InvalidMessage_namemiddle(1)
          ,Cert_Fields.InvalidMessage_namelast(1)
          ,Cert_Fields.InvalidMessage_namesuffix(1)
          ,Cert_Fields.InvalidMessage_nametitle(1)
          ,Cert_Fields.InvalidMessage_mailingaddress1(1)
          ,Cert_Fields.InvalidMessage_mailingaddress2(1)
          ,Cert_Fields.InvalidMessage_mailingaddresscity(1)
          ,Cert_Fields.InvalidMessage_mailingaddressstate(1)
          ,Cert_Fields.InvalidMessage_mailingaddresszip(1)
          ,Cert_Fields.InvalidMessage_mailingaddresszip4(1)
          ,Cert_Fields.InvalidMessage_contactnamefirst(1)
          ,Cert_Fields.InvalidMessage_contactnamemiddle(1)
          ,Cert_Fields.InvalidMessage_contactnamelast(1)
          ,Cert_Fields.InvalidMessage_contactnamesuffix(1)
          ,Cert_Fields.InvalidMessage_contactbusinessname(1)
          ,Cert_Fields.InvalidMessage_contactaddressline1(1)
          ,Cert_Fields.InvalidMessage_contactaddressline2(1)
          ,Cert_Fields.InvalidMessage_contactcity(1)
          ,Cert_Fields.InvalidMessage_contactstate(1)
          ,Cert_Fields.InvalidMessage_contactzip(1)
          ,Cert_Fields.InvalidMessage_contactzip4(1)
          ,Cert_Fields.InvalidMessage_contactphone(1)
          ,Cert_Fields.InvalidMessage_contactfax(1)
          ,Cert_Fields.InvalidMessage_contactemail(1)
          ,Cert_Fields.InvalidMessage_policyholdernamefirst(1)
          ,Cert_Fields.InvalidMessage_policyholdernamemiddle(1)
          ,Cert_Fields.InvalidMessage_policyholdernamelast(1)
          ,Cert_Fields.InvalidMessage_policyholdernamesuffix(1)
          ,Cert_Fields.InvalidMessage_statepolicyfilenumber(1)
          ,Cert_Fields.InvalidMessage_coverageinjuryillnessdate(1)
          ,Cert_Fields.InvalidMessage_selfinsurancegroup(1)
          ,Cert_Fields.InvalidMessage_selfinsurancegroupphone(1)
          ,Cert_Fields.InvalidMessage_selfinsurancegroupid(1)
          ,Cert_Fields.InvalidMessage_numberofemployees(1)
          ,Cert_Fields.InvalidMessage_licensedcontractor(1)
          ,Cert_Fields.InvalidMessage_mconame(1)
          ,Cert_Fields.InvalidMessage_mconumber(1)
          ,Cert_Fields.InvalidMessage_mcoaddressline1(1)
          ,Cert_Fields.InvalidMessage_mcoaddressline2(1)
          ,Cert_Fields.InvalidMessage_mcocity(1)
          ,Cert_Fields.InvalidMessage_mcostate(1)
          ,Cert_Fields.InvalidMessage_mcozip(1)
          ,Cert_Fields.InvalidMessage_mcozip4(1)
          ,Cert_Fields.InvalidMessage_mcophone(1)
          ,Cert_Fields.InvalidMessage_governingclasscode(1)
          ,Cert_Fields.InvalidMessage_licensenumber(1)
          ,Cert_Fields.InvalidMessage_class(1)
          ,Cert_Fields.InvalidMessage_classificationdescription(1)
          ,Cert_Fields.InvalidMessage_licensestatus(1)
          ,Cert_Fields.InvalidMessage_licenseadditionalinfo(1)
          ,Cert_Fields.InvalidMessage_licenseissuedate(1)
          ,Cert_Fields.InvalidMessage_licenseexpirationdate(1)
          ,Cert_Fields.InvalidMessage_naicscode(1)
          ,Cert_Fields.InvalidMessage_officerexemptfirstname1(1)
          ,Cert_Fields.InvalidMessage_officerexemptlastname1(1)
          ,Cert_Fields.InvalidMessage_officerexemptmiddlename1(1)
          ,Cert_Fields.InvalidMessage_officerexempttitle1(1)
          ,Cert_Fields.InvalidMessage_officerexempteffectivedate1(1)
          ,Cert_Fields.InvalidMessage_officerexemptterminationdate1(1)
          ,Cert_Fields.InvalidMessage_officerexempttype1(1)
          ,Cert_Fields.InvalidMessage_officerexemptbusinessactivities1(1)
          ,Cert_Fields.InvalidMessage_officerexemptfirstname2(1)
          ,Cert_Fields.InvalidMessage_officerexemptlastname2(1)
          ,Cert_Fields.InvalidMessage_officerexemptmiddlename2(1)
          ,Cert_Fields.InvalidMessage_officerexempttitle2(1)
          ,Cert_Fields.InvalidMessage_officerexempteffectivedate2(1)
          ,Cert_Fields.InvalidMessage_officerexemptterminationdate2(1)
          ,Cert_Fields.InvalidMessage_officerexempttype2(1)
          ,Cert_Fields.InvalidMessage_officerexemptbusinessactivities2(1)
          ,Cert_Fields.InvalidMessage_officerexemptfirstname3(1)
          ,Cert_Fields.InvalidMessage_officerexemptlastname3(1)
          ,Cert_Fields.InvalidMessage_officerexemptmiddlename3(1)
          ,Cert_Fields.InvalidMessage_officerexempttitle3(1)
          ,Cert_Fields.InvalidMessage_officerexempteffectivedate3(1)
          ,Cert_Fields.InvalidMessage_officerexemptterminationdate3(1)
          ,Cert_Fields.InvalidMessage_officerexempttype3(1)
          ,Cert_Fields.InvalidMessage_officerexemptbusinessactivities3(1)
          ,Cert_Fields.InvalidMessage_officerexemptfirstname4(1)
          ,Cert_Fields.InvalidMessage_officerexemptlastname4(1)
          ,Cert_Fields.InvalidMessage_officerexemptmiddlename4(1)
          ,Cert_Fields.InvalidMessage_officerexempttitle4(1)
          ,Cert_Fields.InvalidMessage_officerexempteffectivedate4(1)
          ,Cert_Fields.InvalidMessage_officerexemptterminationdate4(1)
          ,Cert_Fields.InvalidMessage_officerexempttype4(1)
          ,Cert_Fields.InvalidMessage_officerexemptbusinessactivities4(1)
          ,Cert_Fields.InvalidMessage_officerexemptfirstname5(1)
          ,Cert_Fields.InvalidMessage_officerexemptlastname5(1)
          ,Cert_Fields.InvalidMessage_officerexemptmiddlename5(1)
          ,Cert_Fields.InvalidMessage_officerexempttitle5(1)
          ,Cert_Fields.InvalidMessage_officerexempteffectivedate5(1)
          ,Cert_Fields.InvalidMessage_officerexemptterminationdate5(1)
          ,Cert_Fields.InvalidMessage_officerexempttype5(1)
          ,Cert_Fields.InvalidMessage_officerexemptbusinessactivities5(1)
          ,Cert_Fields.InvalidMessage_dba1(1)
          ,Cert_Fields.InvalidMessage_dbadatefrom1(1)
          ,Cert_Fields.InvalidMessage_dbadateto1(1)
          ,Cert_Fields.InvalidMessage_dbatype1(1)
          ,Cert_Fields.InvalidMessage_dba2(1)
          ,Cert_Fields.InvalidMessage_dbadatefrom2(1)
          ,Cert_Fields.InvalidMessage_dbadateto2(1)
          ,Cert_Fields.InvalidMessage_dbatype2(1)
          ,Cert_Fields.InvalidMessage_dba3(1)
          ,Cert_Fields.InvalidMessage_dbadatefrom3(1)
          ,Cert_Fields.InvalidMessage_dbadateto3(1)
          ,Cert_Fields.InvalidMessage_dbatype3(1)
          ,Cert_Fields.InvalidMessage_dba4(1)
          ,Cert_Fields.InvalidMessage_dbadatefrom4(1)
          ,Cert_Fields.InvalidMessage_dbadateto4(1)
          ,Cert_Fields.InvalidMessage_dbatype4(1)
          ,Cert_Fields.InvalidMessage_dba5(1)
          ,Cert_Fields.InvalidMessage_dbadatefrom5(1)
          ,Cert_Fields.InvalidMessage_dbadateto5(1)
          ,Cert_Fields.InvalidMessage_dbatype5(1)
          ,Cert_Fields.InvalidMessage_subsidiaryname1(1)
          ,Cert_Fields.InvalidMessage_subsidiarystartdate1(1)
          ,Cert_Fields.InvalidMessage_subsidiaryname2(1)
          ,Cert_Fields.InvalidMessage_subsidiarystartdate2(1)
          ,Cert_Fields.InvalidMessage_subsidiaryname3(1)
          ,Cert_Fields.InvalidMessage_subsidiarystartdate3(1)
          ,Cert_Fields.InvalidMessage_subsidiaryname4(1)
          ,Cert_Fields.InvalidMessage_subsidiarystartdate4(1)
          ,Cert_Fields.InvalidMessage_subsidiaryname5(1)
          ,Cert_Fields.InvalidMessage_subsidiarystartdate5(1)
          ,Cert_Fields.InvalidMessage_subsidiaryname6(1)
          ,Cert_Fields.InvalidMessage_subsidiarystartdate6(1)
          ,Cert_Fields.InvalidMessage_subsidiaryname7(1)
          ,Cert_Fields.InvalidMessage_subsidiarystartdate7(1)
          ,Cert_Fields.InvalidMessage_subsidiaryname8(1)
          ,Cert_Fields.InvalidMessage_subsidiarystartdate8(1)
          ,Cert_Fields.InvalidMessage_subsidiaryname9(1)
          ,Cert_Fields.InvalidMessage_subsidiarystartdate9(1)
          ,Cert_Fields.InvalidMessage_subsidiaryname10(1)
          ,Cert_Fields.InvalidMessage_subsidiarystartdate10(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Cert_Layout_Insurance_Cert) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dartid_Invalid := Cert_Fields.InValid_dartid((SALT311.StrType)le.dartid);
    SELF.dateadded_Invalid := Cert_Fields.InValid_dateadded((SALT311.StrType)le.dateadded);
    SELF.dateupdated_Invalid := Cert_Fields.InValid_dateupdated((SALT311.StrType)le.dateupdated);
    SELF.website_Invalid := Cert_Fields.InValid_website((SALT311.StrType)le.website);
    SELF.state_Invalid := Cert_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.lninscertrecordid_Invalid := Cert_Fields.InValid_lninscertrecordid((SALT311.StrType)le.lninscertrecordid);
    SELF.profilelastupdated_Invalid := Cert_Fields.InValid_profilelastupdated((SALT311.StrType)le.profilelastupdated);
    SELF.siid_Invalid := Cert_Fields.InValid_siid((SALT311.StrType)le.siid);
    SELF.sipstatuscode_Invalid := Cert_Fields.InValid_sipstatuscode((SALT311.StrType)le.sipstatuscode);
    SELF.wcbempnumber_Invalid := Cert_Fields.InValid_wcbempnumber((SALT311.StrType)le.wcbempnumber);
    SELF.ubinumber_Invalid := Cert_Fields.InValid_ubinumber((SALT311.StrType)le.ubinumber);
    SELF.cofanumber_Invalid := Cert_Fields.InValid_cofanumber((SALT311.StrType)le.cofanumber);
    SELF.usdotnumber_Invalid := Cert_Fields.InValid_usdotnumber((SALT311.StrType)le.usdotnumber);
    SELF.businessname_Invalid := Cert_Fields.InValid_businessname((SALT311.StrType)le.businessname);
    SELF.dba_Invalid := Cert_Fields.InValid_dba((SALT311.StrType)le.dba);
    SELF.addressline1_Invalid := Cert_Fields.InValid_addressline1((SALT311.StrType)le.addressline1);
    SELF.addressline2_Invalid := Cert_Fields.InValid_addressline2((SALT311.StrType)le.addressline2);
    SELF.addresscity_Invalid := Cert_Fields.InValid_addresscity((SALT311.StrType)le.addresscity);
    SELF.addressstate_Invalid := Cert_Fields.InValid_addressstate((SALT311.StrType)le.addressstate);
    SELF.addresszip_Invalid := Cert_Fields.InValid_addresszip((SALT311.StrType)le.addresszip);
    SELF.zip4_Invalid := Cert_Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.phone1_Invalid := Cert_Fields.InValid_phone1((SALT311.StrType)le.phone1);
    SELF.phone2_Invalid := Cert_Fields.InValid_phone2((SALT311.StrType)le.phone2);
    SELF.phone3_Invalid := Cert_Fields.InValid_phone3((SALT311.StrType)le.phone3);
    SELF.fax1_Invalid := Cert_Fields.InValid_fax1((SALT311.StrType)le.fax1);
    SELF.fax2_Invalid := Cert_Fields.InValid_fax2((SALT311.StrType)le.fax2);
    SELF.email1_Invalid := Cert_Fields.InValid_email1((SALT311.StrType)le.email1);
    SELF.email2_Invalid := Cert_Fields.InValid_email2((SALT311.StrType)le.email2);
    SELF.businesstype_Invalid := Cert_Fields.InValid_businesstype((SALT311.StrType)le.businesstype);
    SELF.namefirst_Invalid := Cert_Fields.InValid_namefirst((SALT311.StrType)le.namefirst);
    SELF.namemiddle_Invalid := Cert_Fields.InValid_namemiddle((SALT311.StrType)le.namemiddle);
    SELF.namelast_Invalid := Cert_Fields.InValid_namelast((SALT311.StrType)le.namelast);
    SELF.namesuffix_Invalid := Cert_Fields.InValid_namesuffix((SALT311.StrType)le.namesuffix);
    SELF.nametitle_Invalid := Cert_Fields.InValid_nametitle((SALT311.StrType)le.nametitle);
    SELF.mailingaddress1_Invalid := Cert_Fields.InValid_mailingaddress1((SALT311.StrType)le.mailingaddress1);
    SELF.mailingaddress2_Invalid := Cert_Fields.InValid_mailingaddress2((SALT311.StrType)le.mailingaddress2);
    SELF.mailingaddresscity_Invalid := Cert_Fields.InValid_mailingaddresscity((SALT311.StrType)le.mailingaddresscity);
    SELF.mailingaddressstate_Invalid := Cert_Fields.InValid_mailingaddressstate((SALT311.StrType)le.mailingaddressstate);
    SELF.mailingaddresszip_Invalid := Cert_Fields.InValid_mailingaddresszip((SALT311.StrType)le.mailingaddresszip);
    SELF.mailingaddresszip4_Invalid := Cert_Fields.InValid_mailingaddresszip4((SALT311.StrType)le.mailingaddresszip4);
    SELF.contactnamefirst_Invalid := Cert_Fields.InValid_contactnamefirst((SALT311.StrType)le.contactnamefirst);
    SELF.contactnamemiddle_Invalid := Cert_Fields.InValid_contactnamemiddle((SALT311.StrType)le.contactnamemiddle);
    SELF.contactnamelast_Invalid := Cert_Fields.InValid_contactnamelast((SALT311.StrType)le.contactnamelast);
    SELF.contactnamesuffix_Invalid := Cert_Fields.InValid_contactnamesuffix((SALT311.StrType)le.contactnamesuffix);
    SELF.contactbusinessname_Invalid := Cert_Fields.InValid_contactbusinessname((SALT311.StrType)le.contactbusinessname);
    SELF.contactaddressline1_Invalid := Cert_Fields.InValid_contactaddressline1((SALT311.StrType)le.contactaddressline1);
    SELF.contactaddressline2_Invalid := Cert_Fields.InValid_contactaddressline2((SALT311.StrType)le.contactaddressline2);
    SELF.contactcity_Invalid := Cert_Fields.InValid_contactcity((SALT311.StrType)le.contactcity);
    SELF.contactstate_Invalid := Cert_Fields.InValid_contactstate((SALT311.StrType)le.contactstate);
    SELF.contactzip_Invalid := Cert_Fields.InValid_contactzip((SALT311.StrType)le.contactzip);
    SELF.contactzip4_Invalid := Cert_Fields.InValid_contactzip4((SALT311.StrType)le.contactzip4);
    SELF.contactphone_Invalid := Cert_Fields.InValid_contactphone((SALT311.StrType)le.contactphone);
    SELF.contactfax_Invalid := Cert_Fields.InValid_contactfax((SALT311.StrType)le.contactfax);
    SELF.contactemail_Invalid := Cert_Fields.InValid_contactemail((SALT311.StrType)le.contactemail);
    SELF.policyholdernamefirst_Invalid := Cert_Fields.InValid_policyholdernamefirst((SALT311.StrType)le.policyholdernamefirst);
    SELF.policyholdernamemiddle_Invalid := Cert_Fields.InValid_policyholdernamemiddle((SALT311.StrType)le.policyholdernamemiddle);
    SELF.policyholdernamelast_Invalid := Cert_Fields.InValid_policyholdernamelast((SALT311.StrType)le.policyholdernamelast);
    SELF.policyholdernamesuffix_Invalid := Cert_Fields.InValid_policyholdernamesuffix((SALT311.StrType)le.policyholdernamesuffix);
    SELF.statepolicyfilenumber_Invalid := Cert_Fields.InValid_statepolicyfilenumber((SALT311.StrType)le.statepolicyfilenumber);
    SELF.coverageinjuryillnessdate_Invalid := Cert_Fields.InValid_coverageinjuryillnessdate((SALT311.StrType)le.coverageinjuryillnessdate);
    SELF.selfinsurancegroup_Invalid := Cert_Fields.InValid_selfinsurancegroup((SALT311.StrType)le.selfinsurancegroup);
    SELF.selfinsurancegroupphone_Invalid := Cert_Fields.InValid_selfinsurancegroupphone((SALT311.StrType)le.selfinsurancegroupphone);
    SELF.selfinsurancegroupid_Invalid := Cert_Fields.InValid_selfinsurancegroupid((SALT311.StrType)le.selfinsurancegroupid);
    SELF.numberofemployees_Invalid := Cert_Fields.InValid_numberofemployees((SALT311.StrType)le.numberofemployees);
    SELF.licensedcontractor_Invalid := Cert_Fields.InValid_licensedcontractor((SALT311.StrType)le.licensedcontractor);
    SELF.mconame_Invalid := Cert_Fields.InValid_mconame((SALT311.StrType)le.mconame);
    SELF.mconumber_Invalid := Cert_Fields.InValid_mconumber((SALT311.StrType)le.mconumber);
    SELF.mcoaddressline1_Invalid := Cert_Fields.InValid_mcoaddressline1((SALT311.StrType)le.mcoaddressline1);
    SELF.mcoaddressline2_Invalid := Cert_Fields.InValid_mcoaddressline2((SALT311.StrType)le.mcoaddressline2);
    SELF.mcocity_Invalid := Cert_Fields.InValid_mcocity((SALT311.StrType)le.mcocity);
    SELF.mcostate_Invalid := Cert_Fields.InValid_mcostate((SALT311.StrType)le.mcostate);
    SELF.mcozip_Invalid := Cert_Fields.InValid_mcozip((SALT311.StrType)le.mcozip);
    SELF.mcozip4_Invalid := Cert_Fields.InValid_mcozip4((SALT311.StrType)le.mcozip4);
    SELF.mcophone_Invalid := Cert_Fields.InValid_mcophone((SALT311.StrType)le.mcophone);
    SELF.governingclasscode_Invalid := Cert_Fields.InValid_governingclasscode((SALT311.StrType)le.governingclasscode);
    SELF.licensenumber_Invalid := Cert_Fields.InValid_licensenumber((SALT311.StrType)le.licensenumber);
    SELF.class_Invalid := Cert_Fields.InValid_class((SALT311.StrType)le.class);
    SELF.classificationdescription_Invalid := Cert_Fields.InValid_classificationdescription((SALT311.StrType)le.classificationdescription);
    SELF.licensestatus_Invalid := Cert_Fields.InValid_licensestatus((SALT311.StrType)le.licensestatus);
    SELF.licenseadditionalinfo_Invalid := Cert_Fields.InValid_licenseadditionalinfo((SALT311.StrType)le.licenseadditionalinfo);
    SELF.licenseissuedate_Invalid := Cert_Fields.InValid_licenseissuedate((SALT311.StrType)le.licenseissuedate);
    SELF.licenseexpirationdate_Invalid := Cert_Fields.InValid_licenseexpirationdate((SALT311.StrType)le.licenseexpirationdate);
    SELF.naicscode_Invalid := Cert_Fields.InValid_naicscode((SALT311.StrType)le.naicscode);
    SELF.officerexemptfirstname1_Invalid := Cert_Fields.InValid_officerexemptfirstname1((SALT311.StrType)le.officerexemptfirstname1);
    SELF.officerexemptlastname1_Invalid := Cert_Fields.InValid_officerexemptlastname1((SALT311.StrType)le.officerexemptlastname1);
    SELF.officerexemptmiddlename1_Invalid := Cert_Fields.InValid_officerexemptmiddlename1((SALT311.StrType)le.officerexemptmiddlename1);
    SELF.officerexempttitle1_Invalid := Cert_Fields.InValid_officerexempttitle1((SALT311.StrType)le.officerexempttitle1);
    SELF.officerexempteffectivedate1_Invalid := Cert_Fields.InValid_officerexempteffectivedate1((SALT311.StrType)le.officerexempteffectivedate1);
    SELF.officerexemptterminationdate1_Invalid := Cert_Fields.InValid_officerexemptterminationdate1((SALT311.StrType)le.officerexemptterminationdate1);
    SELF.officerexempttype1_Invalid := Cert_Fields.InValid_officerexempttype1((SALT311.StrType)le.officerexempttype1);
    SELF.officerexemptbusinessactivities1_Invalid := Cert_Fields.InValid_officerexemptbusinessactivities1((SALT311.StrType)le.officerexemptbusinessactivities1);
    SELF.officerexemptfirstname2_Invalid := Cert_Fields.InValid_officerexemptfirstname2((SALT311.StrType)le.officerexemptfirstname2);
    SELF.officerexemptlastname2_Invalid := Cert_Fields.InValid_officerexemptlastname2((SALT311.StrType)le.officerexemptlastname2);
    SELF.officerexemptmiddlename2_Invalid := Cert_Fields.InValid_officerexemptmiddlename2((SALT311.StrType)le.officerexemptmiddlename2);
    SELF.officerexempttitle2_Invalid := Cert_Fields.InValid_officerexempttitle2((SALT311.StrType)le.officerexempttitle2);
    SELF.officerexempteffectivedate2_Invalid := Cert_Fields.InValid_officerexempteffectivedate2((SALT311.StrType)le.officerexempteffectivedate2);
    SELF.officerexemptterminationdate2_Invalid := Cert_Fields.InValid_officerexemptterminationdate2((SALT311.StrType)le.officerexemptterminationdate2);
    SELF.officerexempttype2_Invalid := Cert_Fields.InValid_officerexempttype2((SALT311.StrType)le.officerexempttype2);
    SELF.officerexemptbusinessactivities2_Invalid := Cert_Fields.InValid_officerexemptbusinessactivities2((SALT311.StrType)le.officerexemptbusinessactivities2);
    SELF.officerexemptfirstname3_Invalid := Cert_Fields.InValid_officerexemptfirstname3((SALT311.StrType)le.officerexemptfirstname3);
    SELF.officerexemptlastname3_Invalid := Cert_Fields.InValid_officerexemptlastname3((SALT311.StrType)le.officerexemptlastname3);
    SELF.officerexemptmiddlename3_Invalid := Cert_Fields.InValid_officerexemptmiddlename3((SALT311.StrType)le.officerexemptmiddlename3);
    SELF.officerexempttitle3_Invalid := Cert_Fields.InValid_officerexempttitle3((SALT311.StrType)le.officerexempttitle3);
    SELF.officerexempteffectivedate3_Invalid := Cert_Fields.InValid_officerexempteffectivedate3((SALT311.StrType)le.officerexempteffectivedate3);
    SELF.officerexemptterminationdate3_Invalid := Cert_Fields.InValid_officerexemptterminationdate3((SALT311.StrType)le.officerexemptterminationdate3);
    SELF.officerexempttype3_Invalid := Cert_Fields.InValid_officerexempttype3((SALT311.StrType)le.officerexempttype3);
    SELF.officerexemptbusinessactivities3_Invalid := Cert_Fields.InValid_officerexemptbusinessactivities3((SALT311.StrType)le.officerexemptbusinessactivities3);
    SELF.officerexemptfirstname4_Invalid := Cert_Fields.InValid_officerexemptfirstname4((SALT311.StrType)le.officerexemptfirstname4);
    SELF.officerexemptlastname4_Invalid := Cert_Fields.InValid_officerexemptlastname4((SALT311.StrType)le.officerexemptlastname4);
    SELF.officerexemptmiddlename4_Invalid := Cert_Fields.InValid_officerexemptmiddlename4((SALT311.StrType)le.officerexemptmiddlename4);
    SELF.officerexempttitle4_Invalid := Cert_Fields.InValid_officerexempttitle4((SALT311.StrType)le.officerexempttitle4);
    SELF.officerexempteffectivedate4_Invalid := Cert_Fields.InValid_officerexempteffectivedate4((SALT311.StrType)le.officerexempteffectivedate4);
    SELF.officerexemptterminationdate4_Invalid := Cert_Fields.InValid_officerexemptterminationdate4((SALT311.StrType)le.officerexemptterminationdate4);
    SELF.officerexempttype4_Invalid := Cert_Fields.InValid_officerexempttype4((SALT311.StrType)le.officerexempttype4);
    SELF.officerexemptbusinessactivities4_Invalid := Cert_Fields.InValid_officerexemptbusinessactivities4((SALT311.StrType)le.officerexemptbusinessactivities4);
    SELF.officerexemptfirstname5_Invalid := Cert_Fields.InValid_officerexemptfirstname5((SALT311.StrType)le.officerexemptfirstname5);
    SELF.officerexemptlastname5_Invalid := Cert_Fields.InValid_officerexemptlastname5((SALT311.StrType)le.officerexemptlastname5);
    SELF.officerexemptmiddlename5_Invalid := Cert_Fields.InValid_officerexemptmiddlename5((SALT311.StrType)le.officerexemptmiddlename5);
    SELF.officerexempttitle5_Invalid := Cert_Fields.InValid_officerexempttitle5((SALT311.StrType)le.officerexempttitle5);
    SELF.officerexempteffectivedate5_Invalid := Cert_Fields.InValid_officerexempteffectivedate5((SALT311.StrType)le.officerexempteffectivedate5);
    SELF.officerexemptterminationdate5_Invalid := Cert_Fields.InValid_officerexemptterminationdate5((SALT311.StrType)le.officerexemptterminationdate5);
    SELF.officerexempttype5_Invalid := Cert_Fields.InValid_officerexempttype5((SALT311.StrType)le.officerexempttype5);
    SELF.officerexemptbusinessactivities5_Invalid := Cert_Fields.InValid_officerexemptbusinessactivities5((SALT311.StrType)le.officerexemptbusinessactivities5);
    SELF.dba1_Invalid := Cert_Fields.InValid_dba1((SALT311.StrType)le.dba1);
    SELF.dbadatefrom1_Invalid := Cert_Fields.InValid_dbadatefrom1((SALT311.StrType)le.dbadatefrom1);
    SELF.dbadateto1_Invalid := Cert_Fields.InValid_dbadateto1((SALT311.StrType)le.dbadateto1);
    SELF.dbatype1_Invalid := Cert_Fields.InValid_dbatype1((SALT311.StrType)le.dbatype1);
    SELF.dba2_Invalid := Cert_Fields.InValid_dba2((SALT311.StrType)le.dba2);
    SELF.dbadatefrom2_Invalid := Cert_Fields.InValid_dbadatefrom2((SALT311.StrType)le.dbadatefrom2);
    SELF.dbadateto2_Invalid := Cert_Fields.InValid_dbadateto2((SALT311.StrType)le.dbadateto2);
    SELF.dbatype2_Invalid := Cert_Fields.InValid_dbatype2((SALT311.StrType)le.dbatype2);
    SELF.dba3_Invalid := Cert_Fields.InValid_dba3((SALT311.StrType)le.dba3);
    SELF.dbadatefrom3_Invalid := Cert_Fields.InValid_dbadatefrom3((SALT311.StrType)le.dbadatefrom3);
    SELF.dbadateto3_Invalid := Cert_Fields.InValid_dbadateto3((SALT311.StrType)le.dbadateto3);
    SELF.dbatype3_Invalid := Cert_Fields.InValid_dbatype3((SALT311.StrType)le.dbatype3);
    SELF.dba4_Invalid := Cert_Fields.InValid_dba4((SALT311.StrType)le.dba4);
    SELF.dbadatefrom4_Invalid := Cert_Fields.InValid_dbadatefrom4((SALT311.StrType)le.dbadatefrom4);
    SELF.dbadateto4_Invalid := Cert_Fields.InValid_dbadateto4((SALT311.StrType)le.dbadateto4);
    SELF.dbatype4_Invalid := Cert_Fields.InValid_dbatype4((SALT311.StrType)le.dbatype4);
    SELF.dba5_Invalid := Cert_Fields.InValid_dba5((SALT311.StrType)le.dba5);
    SELF.dbadatefrom5_Invalid := Cert_Fields.InValid_dbadatefrom5((SALT311.StrType)le.dbadatefrom5);
    SELF.dbadateto5_Invalid := Cert_Fields.InValid_dbadateto5((SALT311.StrType)le.dbadateto5);
    SELF.dbatype5_Invalid := Cert_Fields.InValid_dbatype5((SALT311.StrType)le.dbatype5);
    SELF.subsidiaryname1_Invalid := Cert_Fields.InValid_subsidiaryname1((SALT311.StrType)le.subsidiaryname1);
    SELF.subsidiarystartdate1_Invalid := Cert_Fields.InValid_subsidiarystartdate1((SALT311.StrType)le.subsidiarystartdate1);
    SELF.subsidiaryname2_Invalid := Cert_Fields.InValid_subsidiaryname2((SALT311.StrType)le.subsidiaryname2);
    SELF.subsidiarystartdate2_Invalid := Cert_Fields.InValid_subsidiarystartdate2((SALT311.StrType)le.subsidiarystartdate2);
    SELF.subsidiaryname3_Invalid := Cert_Fields.InValid_subsidiaryname3((SALT311.StrType)le.subsidiaryname3);
    SELF.subsidiarystartdate3_Invalid := Cert_Fields.InValid_subsidiarystartdate3((SALT311.StrType)le.subsidiarystartdate3);
    SELF.subsidiaryname4_Invalid := Cert_Fields.InValid_subsidiaryname4((SALT311.StrType)le.subsidiaryname4);
    SELF.subsidiarystartdate4_Invalid := Cert_Fields.InValid_subsidiarystartdate4((SALT311.StrType)le.subsidiarystartdate4);
    SELF.subsidiaryname5_Invalid := Cert_Fields.InValid_subsidiaryname5((SALT311.StrType)le.subsidiaryname5);
    SELF.subsidiarystartdate5_Invalid := Cert_Fields.InValid_subsidiarystartdate5((SALT311.StrType)le.subsidiarystartdate5);
    SELF.subsidiaryname6_Invalid := Cert_Fields.InValid_subsidiaryname6((SALT311.StrType)le.subsidiaryname6);
    SELF.subsidiarystartdate6_Invalid := Cert_Fields.InValid_subsidiarystartdate6((SALT311.StrType)le.subsidiarystartdate6);
    SELF.subsidiaryname7_Invalid := Cert_Fields.InValid_subsidiaryname7((SALT311.StrType)le.subsidiaryname7);
    SELF.subsidiarystartdate7_Invalid := Cert_Fields.InValid_subsidiarystartdate7((SALT311.StrType)le.subsidiarystartdate7);
    SELF.subsidiaryname8_Invalid := Cert_Fields.InValid_subsidiaryname8((SALT311.StrType)le.subsidiaryname8);
    SELF.subsidiarystartdate8_Invalid := Cert_Fields.InValid_subsidiarystartdate8((SALT311.StrType)le.subsidiarystartdate8);
    SELF.subsidiaryname9_Invalid := Cert_Fields.InValid_subsidiaryname9((SALT311.StrType)le.subsidiaryname9);
    SELF.subsidiarystartdate9_Invalid := Cert_Fields.InValid_subsidiarystartdate9((SALT311.StrType)le.subsidiarystartdate9);
    SELF.subsidiaryname10_Invalid := Cert_Fields.InValid_subsidiaryname10((SALT311.StrType)le.subsidiaryname10);
    SELF.subsidiarystartdate10_Invalid := Cert_Fields.InValid_subsidiarystartdate10((SALT311.StrType)le.subsidiarystartdate10);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Cert_Layout_Insurance_Cert);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dartid_Invalid << 0 ) + ( le.dateadded_Invalid << 1 ) + ( le.dateupdated_Invalid << 2 ) + ( le.website_Invalid << 3 ) + ( le.state_Invalid << 4 ) + ( le.lninscertrecordid_Invalid << 6 ) + ( le.profilelastupdated_Invalid << 7 ) + ( le.siid_Invalid << 8 ) + ( le.sipstatuscode_Invalid << 9 ) + ( le.wcbempnumber_Invalid << 10 ) + ( le.ubinumber_Invalid << 11 ) + ( le.cofanumber_Invalid << 12 ) + ( le.usdotnumber_Invalid << 13 ) + ( le.businessname_Invalid << 14 ) + ( le.dba_Invalid << 15 ) + ( le.addressline1_Invalid << 16 ) + ( le.addressline2_Invalid << 17 ) + ( le.addresscity_Invalid << 18 ) + ( le.addressstate_Invalid << 19 ) + ( le.addresszip_Invalid << 21 ) + ( le.zip4_Invalid << 23 ) + ( le.phone1_Invalid << 24 ) + ( le.phone2_Invalid << 25 ) + ( le.phone3_Invalid << 26 ) + ( le.fax1_Invalid << 27 ) + ( le.fax2_Invalid << 28 ) + ( le.email1_Invalid << 29 ) + ( le.email2_Invalid << 30 ) + ( le.businesstype_Invalid << 31 ) + ( le.namefirst_Invalid << 32 ) + ( le.namemiddle_Invalid << 33 ) + ( le.namelast_Invalid << 34 ) + ( le.namesuffix_Invalid << 35 ) + ( le.nametitle_Invalid << 36 ) + ( le.mailingaddress1_Invalid << 37 ) + ( le.mailingaddress2_Invalid << 38 ) + ( le.mailingaddresscity_Invalid << 39 ) + ( le.mailingaddressstate_Invalid << 40 ) + ( le.mailingaddresszip_Invalid << 41 ) + ( le.mailingaddresszip4_Invalid << 42 ) + ( le.contactnamefirst_Invalid << 43 ) + ( le.contactnamemiddle_Invalid << 44 ) + ( le.contactnamelast_Invalid << 45 ) + ( le.contactnamesuffix_Invalid << 46 ) + ( le.contactbusinessname_Invalid << 47 ) + ( le.contactaddressline1_Invalid << 48 ) + ( le.contactaddressline2_Invalid << 49 ) + ( le.contactcity_Invalid << 50 ) + ( le.contactstate_Invalid << 51 ) + ( le.contactzip_Invalid << 52 ) + ( le.contactzip4_Invalid << 53 ) + ( le.contactphone_Invalid << 54 ) + ( le.contactfax_Invalid << 55 ) + ( le.contactemail_Invalid << 56 ) + ( le.policyholdernamefirst_Invalid << 57 ) + ( le.policyholdernamemiddle_Invalid << 58 ) + ( le.policyholdernamelast_Invalid << 59 ) + ( le.policyholdernamesuffix_Invalid << 60 ) + ( le.statepolicyfilenumber_Invalid << 61 ) + ( le.coverageinjuryillnessdate_Invalid << 62 ) + ( le.selfinsurancegroup_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.selfinsurancegroupphone_Invalid << 0 ) + ( le.selfinsurancegroupid_Invalid << 1 ) + ( le.numberofemployees_Invalid << 2 ) + ( le.licensedcontractor_Invalid << 3 ) + ( le.mconame_Invalid << 4 ) + ( le.mconumber_Invalid << 5 ) + ( le.mcoaddressline1_Invalid << 6 ) + ( le.mcoaddressline2_Invalid << 7 ) + ( le.mcocity_Invalid << 8 ) + ( le.mcostate_Invalid << 9 ) + ( le.mcozip_Invalid << 10 ) + ( le.mcozip4_Invalid << 11 ) + ( le.mcophone_Invalid << 12 ) + ( le.governingclasscode_Invalid << 13 ) + ( le.licensenumber_Invalid << 14 ) + ( le.class_Invalid << 15 ) + ( le.classificationdescription_Invalid << 16 ) + ( le.licensestatus_Invalid << 17 ) + ( le.licenseadditionalinfo_Invalid << 18 ) + ( le.licenseissuedate_Invalid << 19 ) + ( le.licenseexpirationdate_Invalid << 20 ) + ( le.naicscode_Invalid << 21 ) + ( le.officerexemptfirstname1_Invalid << 22 ) + ( le.officerexemptlastname1_Invalid << 23 ) + ( le.officerexemptmiddlename1_Invalid << 24 ) + ( le.officerexempttitle1_Invalid << 25 ) + ( le.officerexempteffectivedate1_Invalid << 26 ) + ( le.officerexemptterminationdate1_Invalid << 27 ) + ( le.officerexempttype1_Invalid << 28 ) + ( le.officerexemptbusinessactivities1_Invalid << 29 ) + ( le.officerexemptfirstname2_Invalid << 30 ) + ( le.officerexemptlastname2_Invalid << 31 ) + ( le.officerexemptmiddlename2_Invalid << 32 ) + ( le.officerexempttitle2_Invalid << 33 ) + ( le.officerexempteffectivedate2_Invalid << 34 ) + ( le.officerexemptterminationdate2_Invalid << 35 ) + ( le.officerexempttype2_Invalid << 36 ) + ( le.officerexemptbusinessactivities2_Invalid << 37 ) + ( le.officerexemptfirstname3_Invalid << 38 ) + ( le.officerexemptlastname3_Invalid << 39 ) + ( le.officerexemptmiddlename3_Invalid << 40 ) + ( le.officerexempttitle3_Invalid << 41 ) + ( le.officerexempteffectivedate3_Invalid << 42 ) + ( le.officerexemptterminationdate3_Invalid << 43 ) + ( le.officerexempttype3_Invalid << 44 ) + ( le.officerexemptbusinessactivities3_Invalid << 45 ) + ( le.officerexemptfirstname4_Invalid << 46 ) + ( le.officerexemptlastname4_Invalid << 47 ) + ( le.officerexemptmiddlename4_Invalid << 48 ) + ( le.officerexempttitle4_Invalid << 49 ) + ( le.officerexempteffectivedate4_Invalid << 50 ) + ( le.officerexemptterminationdate4_Invalid << 51 ) + ( le.officerexempttype4_Invalid << 52 ) + ( le.officerexemptbusinessactivities4_Invalid << 53 ) + ( le.officerexemptfirstname5_Invalid << 54 ) + ( le.officerexemptlastname5_Invalid << 55 ) + ( le.officerexemptmiddlename5_Invalid << 56 ) + ( le.officerexempttitle5_Invalid << 57 ) + ( le.officerexempteffectivedate5_Invalid << 58 ) + ( le.officerexemptterminationdate5_Invalid << 59 ) + ( le.officerexempttype5_Invalid << 60 ) + ( le.officerexemptbusinessactivities5_Invalid << 61 ) + ( le.dba1_Invalid << 62 ) + ( le.dbadatefrom1_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.dbadateto1_Invalid << 0 ) + ( le.dbatype1_Invalid << 1 ) + ( le.dba2_Invalid << 2 ) + ( le.dbadatefrom2_Invalid << 3 ) + ( le.dbadateto2_Invalid << 4 ) + ( le.dbatype2_Invalid << 5 ) + ( le.dba3_Invalid << 6 ) + ( le.dbadatefrom3_Invalid << 7 ) + ( le.dbadateto3_Invalid << 8 ) + ( le.dbatype3_Invalid << 9 ) + ( le.dba4_Invalid << 10 ) + ( le.dbadatefrom4_Invalid << 11 ) + ( le.dbadateto4_Invalid << 12 ) + ( le.dbatype4_Invalid << 13 ) + ( le.dba5_Invalid << 14 ) + ( le.dbadatefrom5_Invalid << 15 ) + ( le.dbadateto5_Invalid << 16 ) + ( le.dbatype5_Invalid << 17 ) + ( le.subsidiaryname1_Invalid << 18 ) + ( le.subsidiarystartdate1_Invalid << 19 ) + ( le.subsidiaryname2_Invalid << 20 ) + ( le.subsidiarystartdate2_Invalid << 21 ) + ( le.subsidiaryname3_Invalid << 22 ) + ( le.subsidiarystartdate3_Invalid << 23 ) + ( le.subsidiaryname4_Invalid << 24 ) + ( le.subsidiarystartdate4_Invalid << 25 ) + ( le.subsidiaryname5_Invalid << 26 ) + ( le.subsidiarystartdate5_Invalid << 27 ) + ( le.subsidiaryname6_Invalid << 28 ) + ( le.subsidiarystartdate6_Invalid << 29 ) + ( le.subsidiaryname7_Invalid << 30 ) + ( le.subsidiarystartdate7_Invalid << 31 ) + ( le.subsidiaryname8_Invalid << 32 ) + ( le.subsidiarystartdate8_Invalid << 33 ) + ( le.subsidiaryname9_Invalid << 34 ) + ( le.subsidiarystartdate9_Invalid << 35 ) + ( le.subsidiaryname10_Invalid << 36 ) + ( le.subsidiarystartdate10_Invalid << 37 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0 OR (mask&le.ScrubsBits3)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND le.ScrubsBits3=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,Cert_Layout_Insurance_Cert);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dartid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dateadded_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dateupdated_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.website_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.lninscertrecordid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.profilelastupdated_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.siid_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sipstatuscode_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.wcbempnumber_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.ubinumber_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.cofanumber_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.usdotnumber_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.businessname_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.dba_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.addressline1_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.addressline2_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.addresscity_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.addressstate_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.addresszip_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.phone1_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.phone2_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.phone3_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.fax1_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.fax2_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.email1_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.email2_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.businesstype_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.namefirst_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.namemiddle_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.namelast_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.namesuffix_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.nametitle_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.mailingaddress1_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.mailingaddress2_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.mailingaddresscity_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.mailingaddressstate_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.mailingaddresszip_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.mailingaddresszip4_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.contactnamefirst_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.contactnamemiddle_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.contactnamelast_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.contactnamesuffix_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.contactbusinessname_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.contactaddressline1_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.contactaddressline2_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.contactcity_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.contactstate_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.contactzip_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.contactzip4_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.contactphone_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.contactfax_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.contactemail_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.policyholdernamefirst_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.policyholdernamemiddle_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.policyholdernamelast_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.policyholdernamesuffix_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.statepolicyfilenumber_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.coverageinjuryillnessdate_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.selfinsurancegroup_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.selfinsurancegroupphone_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.selfinsurancegroupid_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.numberofemployees_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.licensedcontractor_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.mconame_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.mconumber_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.mcoaddressline1_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.mcoaddressline2_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.mcocity_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.mcostate_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.mcozip_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.mcozip4_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.mcophone_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.governingclasscode_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.licensenumber_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.class_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.classificationdescription_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.licensestatus_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.licenseadditionalinfo_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.licenseissuedate_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.licenseexpirationdate_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.naicscode_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.officerexemptfirstname1_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.officerexemptlastname1_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.officerexemptmiddlename1_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.officerexempttitle1_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.officerexempteffectivedate1_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.officerexemptterminationdate1_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.officerexempttype1_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.officerexemptbusinessactivities1_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.officerexemptfirstname2_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.officerexemptlastname2_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.officerexemptmiddlename2_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.officerexempttitle2_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.officerexempteffectivedate2_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.officerexemptterminationdate2_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.officerexempttype2_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.officerexemptbusinessactivities2_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.officerexemptfirstname3_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.officerexemptlastname3_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.officerexemptmiddlename3_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.officerexempttitle3_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.officerexempteffectivedate3_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.officerexemptterminationdate3_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.officerexempttype3_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.officerexemptbusinessactivities3_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.officerexemptfirstname4_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.officerexemptlastname4_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.officerexemptmiddlename4_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.officerexempttitle4_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.officerexempteffectivedate4_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.officerexemptterminationdate4_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.officerexempttype4_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.officerexemptbusinessactivities4_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.officerexemptfirstname5_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.officerexemptlastname5_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.officerexemptmiddlename5_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.officerexempttitle5_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.officerexempteffectivedate5_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.officerexemptterminationdate5_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.officerexempttype5_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.officerexemptbusinessactivities5_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.dba1_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.dbadatefrom1_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.dbadateto1_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.dbatype1_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.dba2_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.dbadatefrom2_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.dbadateto2_Invalid := (le.ScrubsBits3 >> 4) & 1;
    SELF.dbatype2_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.dba3_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.dbadatefrom3_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.dbadateto3_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.dbatype3_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.dba4_Invalid := (le.ScrubsBits3 >> 10) & 1;
    SELF.dbadatefrom4_Invalid := (le.ScrubsBits3 >> 11) & 1;
    SELF.dbadateto4_Invalid := (le.ScrubsBits3 >> 12) & 1;
    SELF.dbatype4_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.dba5_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.dbadatefrom5_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.dbadateto5_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.dbatype5_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.subsidiaryname1_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.subsidiarystartdate1_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.subsidiaryname2_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.subsidiarystartdate2_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.subsidiaryname3_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.subsidiarystartdate3_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.subsidiaryname4_Invalid := (le.ScrubsBits3 >> 24) & 1;
    SELF.subsidiarystartdate4_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.subsidiaryname5_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF.subsidiarystartdate5_Invalid := (le.ScrubsBits3 >> 27) & 1;
    SELF.subsidiaryname6_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.subsidiarystartdate6_Invalid := (le.ScrubsBits3 >> 29) & 1;
    SELF.subsidiaryname7_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.subsidiarystartdate7_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.subsidiaryname8_Invalid := (le.ScrubsBits3 >> 32) & 1;
    SELF.subsidiarystartdate8_Invalid := (le.ScrubsBits3 >> 33) & 1;
    SELF.subsidiaryname9_Invalid := (le.ScrubsBits3 >> 34) & 1;
    SELF.subsidiarystartdate9_Invalid := (le.ScrubsBits3 >> 35) & 1;
    SELF.subsidiaryname10_Invalid := (le.ScrubsBits3 >> 36) & 1;
    SELF.subsidiarystartdate10_Invalid := (le.ScrubsBits3 >> 37) & 1;
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
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    lninscertrecordid_ALLOW_ErrorCount := COUNT(GROUP,h.lninscertrecordid_Invalid=1);
    profilelastupdated_CUSTOM_ErrorCount := COUNT(GROUP,h.profilelastupdated_Invalid=1);
    siid_ALLOW_ErrorCount := COUNT(GROUP,h.siid_Invalid=1);
    sipstatuscode_ALLOW_ErrorCount := COUNT(GROUP,h.sipstatuscode_Invalid=1);
    wcbempnumber_ALLOW_ErrorCount := COUNT(GROUP,h.wcbempnumber_Invalid=1);
    ubinumber_ALLOW_ErrorCount := COUNT(GROUP,h.ubinumber_Invalid=1);
    cofanumber_ALLOW_ErrorCount := COUNT(GROUP,h.cofanumber_Invalid=1);
    usdotnumber_ALLOW_ErrorCount := COUNT(GROUP,h.usdotnumber_Invalid=1);
    businessname_ALLOW_ErrorCount := COUNT(GROUP,h.businessname_Invalid=1);
    dba_ALLOW_ErrorCount := COUNT(GROUP,h.dba_Invalid=1);
    addressline1_ALLOW_ErrorCount := COUNT(GROUP,h.addressline1_Invalid=1);
    addressline2_ALLOW_ErrorCount := COUNT(GROUP,h.addressline2_Invalid=1);
    addresscity_ALLOW_ErrorCount := COUNT(GROUP,h.addresscity_Invalid=1);
    addressstate_ALLOW_ErrorCount := COUNT(GROUP,h.addressstate_Invalid=1);
    addressstate_LENGTHS_ErrorCount := COUNT(GROUP,h.addressstate_Invalid=2);
    addressstate_Total_ErrorCount := COUNT(GROUP,h.addressstate_Invalid>0);
    addresszip_ALLOW_ErrorCount := COUNT(GROUP,h.addresszip_Invalid=1);
    addresszip_LENGTHS_ErrorCount := COUNT(GROUP,h.addresszip_Invalid=2);
    addresszip_Total_ErrorCount := COUNT(GROUP,h.addresszip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    phone1_ALLOW_ErrorCount := COUNT(GROUP,h.phone1_Invalid=1);
    phone2_ALLOW_ErrorCount := COUNT(GROUP,h.phone2_Invalid=1);
    phone3_ALLOW_ErrorCount := COUNT(GROUP,h.phone3_Invalid=1);
    fax1_ALLOW_ErrorCount := COUNT(GROUP,h.fax1_Invalid=1);
    fax2_ALLOW_ErrorCount := COUNT(GROUP,h.fax2_Invalid=1);
    email1_ALLOW_ErrorCount := COUNT(GROUP,h.email1_Invalid=1);
    email2_ALLOW_ErrorCount := COUNT(GROUP,h.email2_Invalid=1);
    businesstype_ALLOW_ErrorCount := COUNT(GROUP,h.businesstype_Invalid=1);
    namefirst_ALLOW_ErrorCount := COUNT(GROUP,h.namefirst_Invalid=1);
    namemiddle_ALLOW_ErrorCount := COUNT(GROUP,h.namemiddle_Invalid=1);
    namelast_ALLOW_ErrorCount := COUNT(GROUP,h.namelast_Invalid=1);
    namesuffix_ALLOW_ErrorCount := COUNT(GROUP,h.namesuffix_Invalid=1);
    nametitle_ALLOW_ErrorCount := COUNT(GROUP,h.nametitle_Invalid=1);
    mailingaddress1_ALLOW_ErrorCount := COUNT(GROUP,h.mailingaddress1_Invalid=1);
    mailingaddress2_ALLOW_ErrorCount := COUNT(GROUP,h.mailingaddress2_Invalid=1);
    mailingaddresscity_ALLOW_ErrorCount := COUNT(GROUP,h.mailingaddresscity_Invalid=1);
    mailingaddressstate_ALLOW_ErrorCount := COUNT(GROUP,h.mailingaddressstate_Invalid=1);
    mailingaddresszip_ALLOW_ErrorCount := COUNT(GROUP,h.mailingaddresszip_Invalid=1);
    mailingaddresszip4_ALLOW_ErrorCount := COUNT(GROUP,h.mailingaddresszip4_Invalid=1);
    contactnamefirst_ALLOW_ErrorCount := COUNT(GROUP,h.contactnamefirst_Invalid=1);
    contactnamemiddle_ALLOW_ErrorCount := COUNT(GROUP,h.contactnamemiddle_Invalid=1);
    contactnamelast_ALLOW_ErrorCount := COUNT(GROUP,h.contactnamelast_Invalid=1);
    contactnamesuffix_ALLOW_ErrorCount := COUNT(GROUP,h.contactnamesuffix_Invalid=1);
    contactbusinessname_ALLOW_ErrorCount := COUNT(GROUP,h.contactbusinessname_Invalid=1);
    contactaddressline1_ALLOW_ErrorCount := COUNT(GROUP,h.contactaddressline1_Invalid=1);
    contactaddressline2_ALLOW_ErrorCount := COUNT(GROUP,h.contactaddressline2_Invalid=1);
    contactcity_ALLOW_ErrorCount := COUNT(GROUP,h.contactcity_Invalid=1);
    contactstate_ALLOW_ErrorCount := COUNT(GROUP,h.contactstate_Invalid=1);
    contactzip_ALLOW_ErrorCount := COUNT(GROUP,h.contactzip_Invalid=1);
    contactzip4_ALLOW_ErrorCount := COUNT(GROUP,h.contactzip4_Invalid=1);
    contactphone_ALLOW_ErrorCount := COUNT(GROUP,h.contactphone_Invalid=1);
    contactfax_ALLOW_ErrorCount := COUNT(GROUP,h.contactfax_Invalid=1);
    contactemail_ALLOW_ErrorCount := COUNT(GROUP,h.contactemail_Invalid=1);
    policyholdernamefirst_ALLOW_ErrorCount := COUNT(GROUP,h.policyholdernamefirst_Invalid=1);
    policyholdernamemiddle_ALLOW_ErrorCount := COUNT(GROUP,h.policyholdernamemiddle_Invalid=1);
    policyholdernamelast_ALLOW_ErrorCount := COUNT(GROUP,h.policyholdernamelast_Invalid=1);
    policyholdernamesuffix_ALLOW_ErrorCount := COUNT(GROUP,h.policyholdernamesuffix_Invalid=1);
    statepolicyfilenumber_ALLOW_ErrorCount := COUNT(GROUP,h.statepolicyfilenumber_Invalid=1);
    coverageinjuryillnessdate_ALLOW_ErrorCount := COUNT(GROUP,h.coverageinjuryillnessdate_Invalid=1);
    selfinsurancegroup_ALLOW_ErrorCount := COUNT(GROUP,h.selfinsurancegroup_Invalid=1);
    selfinsurancegroupphone_ALLOW_ErrorCount := COUNT(GROUP,h.selfinsurancegroupphone_Invalid=1);
    selfinsurancegroupid_ALLOW_ErrorCount := COUNT(GROUP,h.selfinsurancegroupid_Invalid=1);
    numberofemployees_ALLOW_ErrorCount := COUNT(GROUP,h.numberofemployees_Invalid=1);
    licensedcontractor_ALLOW_ErrorCount := COUNT(GROUP,h.licensedcontractor_Invalid=1);
    mconame_ALLOW_ErrorCount := COUNT(GROUP,h.mconame_Invalid=1);
    mconumber_ALLOW_ErrorCount := COUNT(GROUP,h.mconumber_Invalid=1);
    mcoaddressline1_ALLOW_ErrorCount := COUNT(GROUP,h.mcoaddressline1_Invalid=1);
    mcoaddressline2_ALLOW_ErrorCount := COUNT(GROUP,h.mcoaddressline2_Invalid=1);
    mcocity_ALLOW_ErrorCount := COUNT(GROUP,h.mcocity_Invalid=1);
    mcostate_ALLOW_ErrorCount := COUNT(GROUP,h.mcostate_Invalid=1);
    mcozip_ALLOW_ErrorCount := COUNT(GROUP,h.mcozip_Invalid=1);
    mcozip4_ALLOW_ErrorCount := COUNT(GROUP,h.mcozip4_Invalid=1);
    mcophone_ALLOW_ErrorCount := COUNT(GROUP,h.mcophone_Invalid=1);
    governingclasscode_ALLOW_ErrorCount := COUNT(GROUP,h.governingclasscode_Invalid=1);
    licensenumber_ALLOW_ErrorCount := COUNT(GROUP,h.licensenumber_Invalid=1);
    class_ALLOW_ErrorCount := COUNT(GROUP,h.class_Invalid=1);
    classificationdescription_ALLOW_ErrorCount := COUNT(GROUP,h.classificationdescription_Invalid=1);
    licensestatus_ALLOW_ErrorCount := COUNT(GROUP,h.licensestatus_Invalid=1);
    licenseadditionalinfo_ALLOW_ErrorCount := COUNT(GROUP,h.licenseadditionalinfo_Invalid=1);
    licenseissuedate_ALLOW_ErrorCount := COUNT(GROUP,h.licenseissuedate_Invalid=1);
    licenseexpirationdate_ALLOW_ErrorCount := COUNT(GROUP,h.licenseexpirationdate_Invalid=1);
    naicscode_ALLOW_ErrorCount := COUNT(GROUP,h.naicscode_Invalid=1);
    officerexemptfirstname1_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptfirstname1_Invalid=1);
    officerexemptlastname1_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptlastname1_Invalid=1);
    officerexemptmiddlename1_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptmiddlename1_Invalid=1);
    officerexempttitle1_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempttitle1_Invalid=1);
    officerexempteffectivedate1_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempteffectivedate1_Invalid=1);
    officerexemptterminationdate1_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptterminationdate1_Invalid=1);
    officerexempttype1_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempttype1_Invalid=1);
    officerexemptbusinessactivities1_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptbusinessactivities1_Invalid=1);
    officerexemptfirstname2_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptfirstname2_Invalid=1);
    officerexemptlastname2_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptlastname2_Invalid=1);
    officerexemptmiddlename2_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptmiddlename2_Invalid=1);
    officerexempttitle2_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempttitle2_Invalid=1);
    officerexempteffectivedate2_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempteffectivedate2_Invalid=1);
    officerexemptterminationdate2_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptterminationdate2_Invalid=1);
    officerexempttype2_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempttype2_Invalid=1);
    officerexemptbusinessactivities2_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptbusinessactivities2_Invalid=1);
    officerexemptfirstname3_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptfirstname3_Invalid=1);
    officerexemptlastname3_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptlastname3_Invalid=1);
    officerexemptmiddlename3_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptmiddlename3_Invalid=1);
    officerexempttitle3_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempttitle3_Invalid=1);
    officerexempteffectivedate3_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempteffectivedate3_Invalid=1);
    officerexemptterminationdate3_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptterminationdate3_Invalid=1);
    officerexempttype3_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempttype3_Invalid=1);
    officerexemptbusinessactivities3_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptbusinessactivities3_Invalid=1);
    officerexemptfirstname4_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptfirstname4_Invalid=1);
    officerexemptlastname4_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptlastname4_Invalid=1);
    officerexemptmiddlename4_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptmiddlename4_Invalid=1);
    officerexempttitle4_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempttitle4_Invalid=1);
    officerexempteffectivedate4_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempteffectivedate4_Invalid=1);
    officerexemptterminationdate4_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptterminationdate4_Invalid=1);
    officerexempttype4_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempttype4_Invalid=1);
    officerexemptbusinessactivities4_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptbusinessactivities4_Invalid=1);
    officerexemptfirstname5_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptfirstname5_Invalid=1);
    officerexemptlastname5_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptlastname5_Invalid=1);
    officerexemptmiddlename5_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptmiddlename5_Invalid=1);
    officerexempttitle5_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempttitle5_Invalid=1);
    officerexempteffectivedate5_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempteffectivedate5_Invalid=1);
    officerexemptterminationdate5_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptterminationdate5_Invalid=1);
    officerexempttype5_ALLOW_ErrorCount := COUNT(GROUP,h.officerexempttype5_Invalid=1);
    officerexemptbusinessactivities5_ALLOW_ErrorCount := COUNT(GROUP,h.officerexemptbusinessactivities5_Invalid=1);
    dba1_ALLOW_ErrorCount := COUNT(GROUP,h.dba1_Invalid=1);
    dbadatefrom1_ALLOW_ErrorCount := COUNT(GROUP,h.dbadatefrom1_Invalid=1);
    dbadateto1_ALLOW_ErrorCount := COUNT(GROUP,h.dbadateto1_Invalid=1);
    dbatype1_ALLOW_ErrorCount := COUNT(GROUP,h.dbatype1_Invalid=1);
    dba2_ALLOW_ErrorCount := COUNT(GROUP,h.dba2_Invalid=1);
    dbadatefrom2_ALLOW_ErrorCount := COUNT(GROUP,h.dbadatefrom2_Invalid=1);
    dbadateto2_ALLOW_ErrorCount := COUNT(GROUP,h.dbadateto2_Invalid=1);
    dbatype2_ALLOW_ErrorCount := COUNT(GROUP,h.dbatype2_Invalid=1);
    dba3_ALLOW_ErrorCount := COUNT(GROUP,h.dba3_Invalid=1);
    dbadatefrom3_ALLOW_ErrorCount := COUNT(GROUP,h.dbadatefrom3_Invalid=1);
    dbadateto3_ALLOW_ErrorCount := COUNT(GROUP,h.dbadateto3_Invalid=1);
    dbatype3_ALLOW_ErrorCount := COUNT(GROUP,h.dbatype3_Invalid=1);
    dba4_ALLOW_ErrorCount := COUNT(GROUP,h.dba4_Invalid=1);
    dbadatefrom4_ALLOW_ErrorCount := COUNT(GROUP,h.dbadatefrom4_Invalid=1);
    dbadateto4_ALLOW_ErrorCount := COUNT(GROUP,h.dbadateto4_Invalid=1);
    dbatype4_ALLOW_ErrorCount := COUNT(GROUP,h.dbatype4_Invalid=1);
    dba5_ALLOW_ErrorCount := COUNT(GROUP,h.dba5_Invalid=1);
    dbadatefrom5_ALLOW_ErrorCount := COUNT(GROUP,h.dbadatefrom5_Invalid=1);
    dbadateto5_ALLOW_ErrorCount := COUNT(GROUP,h.dbadateto5_Invalid=1);
    dbatype5_ALLOW_ErrorCount := COUNT(GROUP,h.dbatype5_Invalid=1);
    subsidiaryname1_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiaryname1_Invalid=1);
    subsidiarystartdate1_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiarystartdate1_Invalid=1);
    subsidiaryname2_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiaryname2_Invalid=1);
    subsidiarystartdate2_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiarystartdate2_Invalid=1);
    subsidiaryname3_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiaryname3_Invalid=1);
    subsidiarystartdate3_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiarystartdate3_Invalid=1);
    subsidiaryname4_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiaryname4_Invalid=1);
    subsidiarystartdate4_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiarystartdate4_Invalid=1);
    subsidiaryname5_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiaryname5_Invalid=1);
    subsidiarystartdate5_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiarystartdate5_Invalid=1);
    subsidiaryname6_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiaryname6_Invalid=1);
    subsidiarystartdate6_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiarystartdate6_Invalid=1);
    subsidiaryname7_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiaryname7_Invalid=1);
    subsidiarystartdate7_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiarystartdate7_Invalid=1);
    subsidiaryname8_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiaryname8_Invalid=1);
    subsidiarystartdate8_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiarystartdate8_Invalid=1);
    subsidiaryname9_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiaryname9_Invalid=1);
    subsidiarystartdate9_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiarystartdate9_Invalid=1);
    subsidiaryname10_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiaryname10_Invalid=1);
    subsidiarystartdate10_ALLOW_ErrorCount := COUNT(GROUP,h.subsidiarystartdate10_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dartid_Invalid > 0 OR h.dateadded_Invalid > 0 OR h.dateupdated_Invalid > 0 OR h.website_Invalid > 0 OR h.state_Invalid > 0 OR h.lninscertrecordid_Invalid > 0 OR h.profilelastupdated_Invalid > 0 OR h.siid_Invalid > 0 OR h.sipstatuscode_Invalid > 0 OR h.wcbempnumber_Invalid > 0 OR h.ubinumber_Invalid > 0 OR h.cofanumber_Invalid > 0 OR h.usdotnumber_Invalid > 0 OR h.businessname_Invalid > 0 OR h.dba_Invalid > 0 OR h.addressline1_Invalid > 0 OR h.addressline2_Invalid > 0 OR h.addresscity_Invalid > 0 OR h.addressstate_Invalid > 0 OR h.addresszip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.phone1_Invalid > 0 OR h.phone2_Invalid > 0 OR h.phone3_Invalid > 0 OR h.fax1_Invalid > 0 OR h.fax2_Invalid > 0 OR h.email1_Invalid > 0 OR h.email2_Invalid > 0 OR h.businesstype_Invalid > 0 OR h.namefirst_Invalid > 0 OR h.namemiddle_Invalid > 0 OR h.namelast_Invalid > 0 OR h.namesuffix_Invalid > 0 OR h.nametitle_Invalid > 0 OR h.mailingaddress1_Invalid > 0 OR h.mailingaddress2_Invalid > 0 OR h.mailingaddresscity_Invalid > 0 OR h.mailingaddressstate_Invalid > 0 OR h.mailingaddresszip_Invalid > 0 OR h.mailingaddresszip4_Invalid > 0 OR h.contactnamefirst_Invalid > 0 OR h.contactnamemiddle_Invalid > 0 OR h.contactnamelast_Invalid > 0 OR h.contactnamesuffix_Invalid > 0 OR h.contactbusinessname_Invalid > 0 OR h.contactaddressline1_Invalid > 0 OR h.contactaddressline2_Invalid > 0 OR h.contactcity_Invalid > 0 OR h.contactstate_Invalid > 0 OR h.contactzip_Invalid > 0 OR h.contactzip4_Invalid > 0 OR h.contactphone_Invalid > 0 OR h.contactfax_Invalid > 0 OR h.contactemail_Invalid > 0 OR h.policyholdernamefirst_Invalid > 0 OR h.policyholdernamemiddle_Invalid > 0 OR h.policyholdernamelast_Invalid > 0 OR h.policyholdernamesuffix_Invalid > 0 OR h.statepolicyfilenumber_Invalid > 0 OR h.coverageinjuryillnessdate_Invalid > 0 OR h.selfinsurancegroup_Invalid > 0 OR h.selfinsurancegroupphone_Invalid > 0 OR h.selfinsurancegroupid_Invalid > 0 OR h.numberofemployees_Invalid > 0 OR h.licensedcontractor_Invalid > 0 OR h.mconame_Invalid > 0 OR h.mconumber_Invalid > 0 OR h.mcoaddressline1_Invalid > 0 OR h.mcoaddressline2_Invalid > 0 OR h.mcocity_Invalid > 0 OR h.mcostate_Invalid > 0 OR h.mcozip_Invalid > 0 OR h.mcozip4_Invalid > 0 OR h.mcophone_Invalid > 0 OR h.governingclasscode_Invalid > 0 OR h.licensenumber_Invalid > 0 OR h.class_Invalid > 0 OR h.classificationdescription_Invalid > 0 OR h.licensestatus_Invalid > 0 OR h.licenseadditionalinfo_Invalid > 0 OR h.licenseissuedate_Invalid > 0 OR h.licenseexpirationdate_Invalid > 0 OR h.naicscode_Invalid > 0 OR h.officerexemptfirstname1_Invalid > 0 OR h.officerexemptlastname1_Invalid > 0 OR h.officerexemptmiddlename1_Invalid > 0 OR h.officerexempttitle1_Invalid > 0 OR h.officerexempteffectivedate1_Invalid > 0 OR h.officerexemptterminationdate1_Invalid > 0 OR h.officerexempttype1_Invalid > 0 OR h.officerexemptbusinessactivities1_Invalid > 0 OR h.officerexemptfirstname2_Invalid > 0 OR h.officerexemptlastname2_Invalid > 0 OR h.officerexemptmiddlename2_Invalid > 0 OR h.officerexempttitle2_Invalid > 0 OR h.officerexempteffectivedate2_Invalid > 0 OR h.officerexemptterminationdate2_Invalid > 0 OR h.officerexempttype2_Invalid > 0 OR h.officerexemptbusinessactivities2_Invalid > 0 OR h.officerexemptfirstname3_Invalid > 0 OR h.officerexemptlastname3_Invalid > 0 OR h.officerexemptmiddlename3_Invalid > 0 OR h.officerexempttitle3_Invalid > 0 OR h.officerexempteffectivedate3_Invalid > 0 OR h.officerexemptterminationdate3_Invalid > 0 OR h.officerexempttype3_Invalid > 0 OR h.officerexemptbusinessactivities3_Invalid > 0 OR h.officerexemptfirstname4_Invalid > 0 OR h.officerexemptlastname4_Invalid > 0 OR h.officerexemptmiddlename4_Invalid > 0 OR h.officerexempttitle4_Invalid > 0 OR h.officerexempteffectivedate4_Invalid > 0 OR h.officerexemptterminationdate4_Invalid > 0 OR h.officerexempttype4_Invalid > 0 OR h.officerexemptbusinessactivities4_Invalid > 0 OR h.officerexemptfirstname5_Invalid > 0 OR h.officerexemptlastname5_Invalid > 0 OR h.officerexemptmiddlename5_Invalid > 0 OR h.officerexempttitle5_Invalid > 0 OR h.officerexempteffectivedate5_Invalid > 0 OR h.officerexemptterminationdate5_Invalid > 0 OR h.officerexempttype5_Invalid > 0 OR h.officerexemptbusinessactivities5_Invalid > 0 OR h.dba1_Invalid > 0 OR h.dbadatefrom1_Invalid > 0 OR h.dbadateto1_Invalid > 0 OR h.dbatype1_Invalid > 0 OR h.dba2_Invalid > 0 OR h.dbadatefrom2_Invalid > 0 OR h.dbadateto2_Invalid > 0 OR h.dbatype2_Invalid > 0 OR h.dba3_Invalid > 0 OR h.dbadatefrom3_Invalid > 0 OR h.dbadateto3_Invalid > 0 OR h.dbatype3_Invalid > 0 OR h.dba4_Invalid > 0 OR h.dbadatefrom4_Invalid > 0 OR h.dbadateto4_Invalid > 0 OR h.dbatype4_Invalid > 0 OR h.dba5_Invalid > 0 OR h.dbadatefrom5_Invalid > 0 OR h.dbadateto5_Invalid > 0 OR h.dbatype5_Invalid > 0 OR h.subsidiaryname1_Invalid > 0 OR h.subsidiarystartdate1_Invalid > 0 OR h.subsidiaryname2_Invalid > 0 OR h.subsidiarystartdate2_Invalid > 0 OR h.subsidiaryname3_Invalid > 0 OR h.subsidiarystartdate3_Invalid > 0 OR h.subsidiaryname4_Invalid > 0 OR h.subsidiarystartdate4_Invalid > 0 OR h.subsidiaryname5_Invalid > 0 OR h.subsidiarystartdate5_Invalid > 0 OR h.subsidiaryname6_Invalid > 0 OR h.subsidiarystartdate6_Invalid > 0 OR h.subsidiaryname7_Invalid > 0 OR h.subsidiarystartdate7_Invalid > 0 OR h.subsidiaryname8_Invalid > 0 OR h.subsidiarystartdate8_Invalid > 0 OR h.subsidiaryname9_Invalid > 0 OR h.subsidiarystartdate9_Invalid > 0 OR h.subsidiaryname10_Invalid > 0 OR h.subsidiarystartdate10_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateadded_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.lninscertrecordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.profilelastupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sipstatuscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.wcbempnumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ubinumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cofanumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.usdotnumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressline1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressline2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressstate_Total_ErrorCount > 0, 1, 0) + IF(le.addresszip_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.namefirst_ALLOW_ErrorCount > 0, 1, 0) + IF(le.namemiddle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.namelast_ALLOW_ErrorCount > 0, 1, 0) + IF(le.namesuffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nametitle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddressstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddresszip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddresszip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactnamefirst_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactnamemiddle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactnamelast_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactnamesuffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactbusinessname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactaddressline1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactaddressline2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactcity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactzip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactzip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactphone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactfax_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactemail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policyholdernamefirst_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policyholdernamemiddle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policyholdernamelast_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policyholdernamesuffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statepolicyfilenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coverageinjuryillnessdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.selfinsurancegroup_ALLOW_ErrorCount > 0, 1, 0) + IF(le.selfinsurancegroupphone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.selfinsurancegroupid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.numberofemployees_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensedcontractor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mconame_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mconumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcoaddressline1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcoaddressline2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcocity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcostate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcozip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcozip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcophone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.governingclasscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classificationdescription_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensestatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licenseadditionalinfo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licenseissuedate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licenseexpirationdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.naicscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptfirstname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptlastname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptmiddlename1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttitle1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempteffectivedate1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptterminationdate1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttype1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptbusinessactivities1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptfirstname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptlastname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptmiddlename2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttitle2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempteffectivedate2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptterminationdate2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttype2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptbusinessactivities2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptfirstname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptlastname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptmiddlename3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttitle3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempteffectivedate3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptterminationdate3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttype3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptbusinessactivities3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptfirstname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptlastname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptmiddlename4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttitle4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempteffectivedate4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptterminationdate4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttype4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptbusinessactivities4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptfirstname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptlastname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptmiddlename5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttitle5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempteffectivedate5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptterminationdate5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttype5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptbusinessactivities5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadatefrom1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadateto1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbatype1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadatefrom2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadateto2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbatype2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadatefrom3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadateto3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbatype3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadatefrom4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadateto4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbatype4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadatefrom5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadateto5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbatype5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname9_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate9_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate10_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dartid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dateadded_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dateupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lninscertrecordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.profilelastupdated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.siid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sipstatuscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.wcbempnumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ubinumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cofanumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.usdotnumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businessname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressline1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressline2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addressstate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addresszip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addresszip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fax2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.businesstype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.namefirst_ALLOW_ErrorCount > 0, 1, 0) + IF(le.namemiddle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.namelast_ALLOW_ErrorCount > 0, 1, 0) + IF(le.namesuffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nametitle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddress1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddress2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddresscity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddressstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddresszip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailingaddresszip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactnamefirst_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactnamemiddle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactnamelast_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactnamesuffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactbusinessname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactaddressline1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactaddressline2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactcity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactzip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactzip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactphone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactfax_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contactemail_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policyholdernamefirst_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policyholdernamemiddle_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policyholdernamelast_ALLOW_ErrorCount > 0, 1, 0) + IF(le.policyholdernamesuffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statepolicyfilenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coverageinjuryillnessdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.selfinsurancegroup_ALLOW_ErrorCount > 0, 1, 0) + IF(le.selfinsurancegroupphone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.selfinsurancegroupid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.numberofemployees_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensedcontractor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mconame_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mconumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcoaddressline1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcoaddressline2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcocity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcostate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcozip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcozip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mcophone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.governingclasscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.classificationdescription_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licensestatus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licenseadditionalinfo_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licenseissuedate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.licenseexpirationdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.naicscode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptfirstname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptlastname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptmiddlename1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttitle1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempteffectivedate1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptterminationdate1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttype1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptbusinessactivities1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptfirstname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptlastname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptmiddlename2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttitle2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempteffectivedate2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptterminationdate2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttype2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptbusinessactivities2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptfirstname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptlastname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptmiddlename3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttitle3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempteffectivedate3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptterminationdate3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttype3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptbusinessactivities3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptfirstname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptlastname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptmiddlename4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttitle4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempteffectivedate4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptterminationdate4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttype4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptbusinessactivities4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptfirstname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptlastname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptmiddlename5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttitle5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempteffectivedate5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptterminationdate5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexempttype5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.officerexemptbusinessactivities5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadatefrom1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadateto1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbatype1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadatefrom2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadateto2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbatype2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadatefrom3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadateto3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbatype3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadatefrom4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadateto4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbatype4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dba5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadatefrom5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbadateto5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbatype5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate6_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate7_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate8_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname9_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate9_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiaryname10_ALLOW_ErrorCount > 0, 1, 0) + IF(le.subsidiarystartdate10_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dartid_Invalid,le.dateadded_Invalid,le.dateupdated_Invalid,le.website_Invalid,le.state_Invalid,le.lninscertrecordid_Invalid,le.profilelastupdated_Invalid,le.siid_Invalid,le.sipstatuscode_Invalid,le.wcbempnumber_Invalid,le.ubinumber_Invalid,le.cofanumber_Invalid,le.usdotnumber_Invalid,le.businessname_Invalid,le.dba_Invalid,le.addressline1_Invalid,le.addressline2_Invalid,le.addresscity_Invalid,le.addressstate_Invalid,le.addresszip_Invalid,le.zip4_Invalid,le.phone1_Invalid,le.phone2_Invalid,le.phone3_Invalid,le.fax1_Invalid,le.fax2_Invalid,le.email1_Invalid,le.email2_Invalid,le.businesstype_Invalid,le.namefirst_Invalid,le.namemiddle_Invalid,le.namelast_Invalid,le.namesuffix_Invalid,le.nametitle_Invalid,le.mailingaddress1_Invalid,le.mailingaddress2_Invalid,le.mailingaddresscity_Invalid,le.mailingaddressstate_Invalid,le.mailingaddresszip_Invalid,le.mailingaddresszip4_Invalid,le.contactnamefirst_Invalid,le.contactnamemiddle_Invalid,le.contactnamelast_Invalid,le.contactnamesuffix_Invalid,le.contactbusinessname_Invalid,le.contactaddressline1_Invalid,le.contactaddressline2_Invalid,le.contactcity_Invalid,le.contactstate_Invalid,le.contactzip_Invalid,le.contactzip4_Invalid,le.contactphone_Invalid,le.contactfax_Invalid,le.contactemail_Invalid,le.policyholdernamefirst_Invalid,le.policyholdernamemiddle_Invalid,le.policyholdernamelast_Invalid,le.policyholdernamesuffix_Invalid,le.statepolicyfilenumber_Invalid,le.coverageinjuryillnessdate_Invalid,le.selfinsurancegroup_Invalid,le.selfinsurancegroupphone_Invalid,le.selfinsurancegroupid_Invalid,le.numberofemployees_Invalid,le.licensedcontractor_Invalid,le.mconame_Invalid,le.mconumber_Invalid,le.mcoaddressline1_Invalid,le.mcoaddressline2_Invalid,le.mcocity_Invalid,le.mcostate_Invalid,le.mcozip_Invalid,le.mcozip4_Invalid,le.mcophone_Invalid,le.governingclasscode_Invalid,le.licensenumber_Invalid,le.class_Invalid,le.classificationdescription_Invalid,le.licensestatus_Invalid,le.licenseadditionalinfo_Invalid,le.licenseissuedate_Invalid,le.licenseexpirationdate_Invalid,le.naicscode_Invalid,le.officerexemptfirstname1_Invalid,le.officerexemptlastname1_Invalid,le.officerexemptmiddlename1_Invalid,le.officerexempttitle1_Invalid,le.officerexempteffectivedate1_Invalid,le.officerexemptterminationdate1_Invalid,le.officerexempttype1_Invalid,le.officerexemptbusinessactivities1_Invalid,le.officerexemptfirstname2_Invalid,le.officerexemptlastname2_Invalid,le.officerexemptmiddlename2_Invalid,le.officerexempttitle2_Invalid,le.officerexempteffectivedate2_Invalid,le.officerexemptterminationdate2_Invalid,le.officerexempttype2_Invalid,le.officerexemptbusinessactivities2_Invalid,le.officerexemptfirstname3_Invalid,le.officerexemptlastname3_Invalid,le.officerexemptmiddlename3_Invalid,le.officerexempttitle3_Invalid,le.officerexempteffectivedate3_Invalid,le.officerexemptterminationdate3_Invalid,le.officerexempttype3_Invalid,le.officerexemptbusinessactivities3_Invalid,le.officerexemptfirstname4_Invalid,le.officerexemptlastname4_Invalid,le.officerexemptmiddlename4_Invalid,le.officerexempttitle4_Invalid,le.officerexempteffectivedate4_Invalid,le.officerexemptterminationdate4_Invalid,le.officerexempttype4_Invalid,le.officerexemptbusinessactivities4_Invalid,le.officerexemptfirstname5_Invalid,le.officerexemptlastname5_Invalid,le.officerexemptmiddlename5_Invalid,le.officerexempttitle5_Invalid,le.officerexempteffectivedate5_Invalid,le.officerexemptterminationdate5_Invalid,le.officerexempttype5_Invalid,le.officerexemptbusinessactivities5_Invalid,le.dba1_Invalid,le.dbadatefrom1_Invalid,le.dbadateto1_Invalid,le.dbatype1_Invalid,le.dba2_Invalid,le.dbadatefrom2_Invalid,le.dbadateto2_Invalid,le.dbatype2_Invalid,le.dba3_Invalid,le.dbadatefrom3_Invalid,le.dbadateto3_Invalid,le.dbatype3_Invalid,le.dba4_Invalid,le.dbadatefrom4_Invalid,le.dbadateto4_Invalid,le.dbatype4_Invalid,le.dba5_Invalid,le.dbadatefrom5_Invalid,le.dbadateto5_Invalid,le.dbatype5_Invalid,le.subsidiaryname1_Invalid,le.subsidiarystartdate1_Invalid,le.subsidiaryname2_Invalid,le.subsidiarystartdate2_Invalid,le.subsidiaryname3_Invalid,le.subsidiarystartdate3_Invalid,le.subsidiaryname4_Invalid,le.subsidiarystartdate4_Invalid,le.subsidiaryname5_Invalid,le.subsidiarystartdate5_Invalid,le.subsidiaryname6_Invalid,le.subsidiarystartdate6_Invalid,le.subsidiaryname7_Invalid,le.subsidiarystartdate7_Invalid,le.subsidiaryname8_Invalid,le.subsidiarystartdate8_Invalid,le.subsidiaryname9_Invalid,le.subsidiarystartdate9_Invalid,le.subsidiaryname10_Invalid,le.subsidiarystartdate10_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Cert_Fields.InvalidMessage_dartid(le.dartid_Invalid),Cert_Fields.InvalidMessage_dateadded(le.dateadded_Invalid),Cert_Fields.InvalidMessage_dateupdated(le.dateupdated_Invalid),Cert_Fields.InvalidMessage_website(le.website_Invalid),Cert_Fields.InvalidMessage_state(le.state_Invalid),Cert_Fields.InvalidMessage_lninscertrecordid(le.lninscertrecordid_Invalid),Cert_Fields.InvalidMessage_profilelastupdated(le.profilelastupdated_Invalid),Cert_Fields.InvalidMessage_siid(le.siid_Invalid),Cert_Fields.InvalidMessage_sipstatuscode(le.sipstatuscode_Invalid),Cert_Fields.InvalidMessage_wcbempnumber(le.wcbempnumber_Invalid),Cert_Fields.InvalidMessage_ubinumber(le.ubinumber_Invalid),Cert_Fields.InvalidMessage_cofanumber(le.cofanumber_Invalid),Cert_Fields.InvalidMessage_usdotnumber(le.usdotnumber_Invalid),Cert_Fields.InvalidMessage_businessname(le.businessname_Invalid),Cert_Fields.InvalidMessage_dba(le.dba_Invalid),Cert_Fields.InvalidMessage_addressline1(le.addressline1_Invalid),Cert_Fields.InvalidMessage_addressline2(le.addressline2_Invalid),Cert_Fields.InvalidMessage_addresscity(le.addresscity_Invalid),Cert_Fields.InvalidMessage_addressstate(le.addressstate_Invalid),Cert_Fields.InvalidMessage_addresszip(le.addresszip_Invalid),Cert_Fields.InvalidMessage_zip4(le.zip4_Invalid),Cert_Fields.InvalidMessage_phone1(le.phone1_Invalid),Cert_Fields.InvalidMessage_phone2(le.phone2_Invalid),Cert_Fields.InvalidMessage_phone3(le.phone3_Invalid),Cert_Fields.InvalidMessage_fax1(le.fax1_Invalid),Cert_Fields.InvalidMessage_fax2(le.fax2_Invalid),Cert_Fields.InvalidMessage_email1(le.email1_Invalid),Cert_Fields.InvalidMessage_email2(le.email2_Invalid),Cert_Fields.InvalidMessage_businesstype(le.businesstype_Invalid),Cert_Fields.InvalidMessage_namefirst(le.namefirst_Invalid),Cert_Fields.InvalidMessage_namemiddle(le.namemiddle_Invalid),Cert_Fields.InvalidMessage_namelast(le.namelast_Invalid),Cert_Fields.InvalidMessage_namesuffix(le.namesuffix_Invalid),Cert_Fields.InvalidMessage_nametitle(le.nametitle_Invalid),Cert_Fields.InvalidMessage_mailingaddress1(le.mailingaddress1_Invalid),Cert_Fields.InvalidMessage_mailingaddress2(le.mailingaddress2_Invalid),Cert_Fields.InvalidMessage_mailingaddresscity(le.mailingaddresscity_Invalid),Cert_Fields.InvalidMessage_mailingaddressstate(le.mailingaddressstate_Invalid),Cert_Fields.InvalidMessage_mailingaddresszip(le.mailingaddresszip_Invalid),Cert_Fields.InvalidMessage_mailingaddresszip4(le.mailingaddresszip4_Invalid),Cert_Fields.InvalidMessage_contactnamefirst(le.contactnamefirst_Invalid),Cert_Fields.InvalidMessage_contactnamemiddle(le.contactnamemiddle_Invalid),Cert_Fields.InvalidMessage_contactnamelast(le.contactnamelast_Invalid),Cert_Fields.InvalidMessage_contactnamesuffix(le.contactnamesuffix_Invalid),Cert_Fields.InvalidMessage_contactbusinessname(le.contactbusinessname_Invalid),Cert_Fields.InvalidMessage_contactaddressline1(le.contactaddressline1_Invalid),Cert_Fields.InvalidMessage_contactaddressline2(le.contactaddressline2_Invalid),Cert_Fields.InvalidMessage_contactcity(le.contactcity_Invalid),Cert_Fields.InvalidMessage_contactstate(le.contactstate_Invalid),Cert_Fields.InvalidMessage_contactzip(le.contactzip_Invalid),Cert_Fields.InvalidMessage_contactzip4(le.contactzip4_Invalid),Cert_Fields.InvalidMessage_contactphone(le.contactphone_Invalid),Cert_Fields.InvalidMessage_contactfax(le.contactfax_Invalid),Cert_Fields.InvalidMessage_contactemail(le.contactemail_Invalid),Cert_Fields.InvalidMessage_policyholdernamefirst(le.policyholdernamefirst_Invalid),Cert_Fields.InvalidMessage_policyholdernamemiddle(le.policyholdernamemiddle_Invalid),Cert_Fields.InvalidMessage_policyholdernamelast(le.policyholdernamelast_Invalid),Cert_Fields.InvalidMessage_policyholdernamesuffix(le.policyholdernamesuffix_Invalid),Cert_Fields.InvalidMessage_statepolicyfilenumber(le.statepolicyfilenumber_Invalid),Cert_Fields.InvalidMessage_coverageinjuryillnessdate(le.coverageinjuryillnessdate_Invalid),Cert_Fields.InvalidMessage_selfinsurancegroup(le.selfinsurancegroup_Invalid),Cert_Fields.InvalidMessage_selfinsurancegroupphone(le.selfinsurancegroupphone_Invalid),Cert_Fields.InvalidMessage_selfinsurancegroupid(le.selfinsurancegroupid_Invalid),Cert_Fields.InvalidMessage_numberofemployees(le.numberofemployees_Invalid),Cert_Fields.InvalidMessage_licensedcontractor(le.licensedcontractor_Invalid),Cert_Fields.InvalidMessage_mconame(le.mconame_Invalid),Cert_Fields.InvalidMessage_mconumber(le.mconumber_Invalid),Cert_Fields.InvalidMessage_mcoaddressline1(le.mcoaddressline1_Invalid),Cert_Fields.InvalidMessage_mcoaddressline2(le.mcoaddressline2_Invalid),Cert_Fields.InvalidMessage_mcocity(le.mcocity_Invalid),Cert_Fields.InvalidMessage_mcostate(le.mcostate_Invalid),Cert_Fields.InvalidMessage_mcozip(le.mcozip_Invalid),Cert_Fields.InvalidMessage_mcozip4(le.mcozip4_Invalid),Cert_Fields.InvalidMessage_mcophone(le.mcophone_Invalid),Cert_Fields.InvalidMessage_governingclasscode(le.governingclasscode_Invalid),Cert_Fields.InvalidMessage_licensenumber(le.licensenumber_Invalid),Cert_Fields.InvalidMessage_class(le.class_Invalid),Cert_Fields.InvalidMessage_classificationdescription(le.classificationdescription_Invalid),Cert_Fields.InvalidMessage_licensestatus(le.licensestatus_Invalid),Cert_Fields.InvalidMessage_licenseadditionalinfo(le.licenseadditionalinfo_Invalid),Cert_Fields.InvalidMessage_licenseissuedate(le.licenseissuedate_Invalid),Cert_Fields.InvalidMessage_licenseexpirationdate(le.licenseexpirationdate_Invalid),Cert_Fields.InvalidMessage_naicscode(le.naicscode_Invalid),Cert_Fields.InvalidMessage_officerexemptfirstname1(le.officerexemptfirstname1_Invalid),Cert_Fields.InvalidMessage_officerexemptlastname1(le.officerexemptlastname1_Invalid),Cert_Fields.InvalidMessage_officerexemptmiddlename1(le.officerexemptmiddlename1_Invalid),Cert_Fields.InvalidMessage_officerexempttitle1(le.officerexempttitle1_Invalid),Cert_Fields.InvalidMessage_officerexempteffectivedate1(le.officerexempteffectivedate1_Invalid),Cert_Fields.InvalidMessage_officerexemptterminationdate1(le.officerexemptterminationdate1_Invalid),Cert_Fields.InvalidMessage_officerexempttype1(le.officerexempttype1_Invalid),Cert_Fields.InvalidMessage_officerexemptbusinessactivities1(le.officerexemptbusinessactivities1_Invalid),Cert_Fields.InvalidMessage_officerexemptfirstname2(le.officerexemptfirstname2_Invalid),Cert_Fields.InvalidMessage_officerexemptlastname2(le.officerexemptlastname2_Invalid),Cert_Fields.InvalidMessage_officerexemptmiddlename2(le.officerexemptmiddlename2_Invalid),Cert_Fields.InvalidMessage_officerexempttitle2(le.officerexempttitle2_Invalid),Cert_Fields.InvalidMessage_officerexempteffectivedate2(le.officerexempteffectivedate2_Invalid),Cert_Fields.InvalidMessage_officerexemptterminationdate2(le.officerexemptterminationdate2_Invalid),Cert_Fields.InvalidMessage_officerexempttype2(le.officerexempttype2_Invalid),Cert_Fields.InvalidMessage_officerexemptbusinessactivities2(le.officerexemptbusinessactivities2_Invalid),Cert_Fields.InvalidMessage_officerexemptfirstname3(le.officerexemptfirstname3_Invalid),Cert_Fields.InvalidMessage_officerexemptlastname3(le.officerexemptlastname3_Invalid),Cert_Fields.InvalidMessage_officerexemptmiddlename3(le.officerexemptmiddlename3_Invalid),Cert_Fields.InvalidMessage_officerexempttitle3(le.officerexempttitle3_Invalid),Cert_Fields.InvalidMessage_officerexempteffectivedate3(le.officerexempteffectivedate3_Invalid),Cert_Fields.InvalidMessage_officerexemptterminationdate3(le.officerexemptterminationdate3_Invalid),Cert_Fields.InvalidMessage_officerexempttype3(le.officerexempttype3_Invalid),Cert_Fields.InvalidMessage_officerexemptbusinessactivities3(le.officerexemptbusinessactivities3_Invalid),Cert_Fields.InvalidMessage_officerexemptfirstname4(le.officerexemptfirstname4_Invalid),Cert_Fields.InvalidMessage_officerexemptlastname4(le.officerexemptlastname4_Invalid),Cert_Fields.InvalidMessage_officerexemptmiddlename4(le.officerexemptmiddlename4_Invalid),Cert_Fields.InvalidMessage_officerexempttitle4(le.officerexempttitle4_Invalid),Cert_Fields.InvalidMessage_officerexempteffectivedate4(le.officerexempteffectivedate4_Invalid),Cert_Fields.InvalidMessage_officerexemptterminationdate4(le.officerexemptterminationdate4_Invalid),Cert_Fields.InvalidMessage_officerexempttype4(le.officerexempttype4_Invalid),Cert_Fields.InvalidMessage_officerexemptbusinessactivities4(le.officerexemptbusinessactivities4_Invalid),Cert_Fields.InvalidMessage_officerexemptfirstname5(le.officerexemptfirstname5_Invalid),Cert_Fields.InvalidMessage_officerexemptlastname5(le.officerexemptlastname5_Invalid),Cert_Fields.InvalidMessage_officerexemptmiddlename5(le.officerexemptmiddlename5_Invalid),Cert_Fields.InvalidMessage_officerexempttitle5(le.officerexempttitle5_Invalid),Cert_Fields.InvalidMessage_officerexempteffectivedate5(le.officerexempteffectivedate5_Invalid),Cert_Fields.InvalidMessage_officerexemptterminationdate5(le.officerexemptterminationdate5_Invalid),Cert_Fields.InvalidMessage_officerexempttype5(le.officerexempttype5_Invalid),Cert_Fields.InvalidMessage_officerexemptbusinessactivities5(le.officerexemptbusinessactivities5_Invalid),Cert_Fields.InvalidMessage_dba1(le.dba1_Invalid),Cert_Fields.InvalidMessage_dbadatefrom1(le.dbadatefrom1_Invalid),Cert_Fields.InvalidMessage_dbadateto1(le.dbadateto1_Invalid),Cert_Fields.InvalidMessage_dbatype1(le.dbatype1_Invalid),Cert_Fields.InvalidMessage_dba2(le.dba2_Invalid),Cert_Fields.InvalidMessage_dbadatefrom2(le.dbadatefrom2_Invalid),Cert_Fields.InvalidMessage_dbadateto2(le.dbadateto2_Invalid),Cert_Fields.InvalidMessage_dbatype2(le.dbatype2_Invalid),Cert_Fields.InvalidMessage_dba3(le.dba3_Invalid),Cert_Fields.InvalidMessage_dbadatefrom3(le.dbadatefrom3_Invalid),Cert_Fields.InvalidMessage_dbadateto3(le.dbadateto3_Invalid),Cert_Fields.InvalidMessage_dbatype3(le.dbatype3_Invalid),Cert_Fields.InvalidMessage_dba4(le.dba4_Invalid),Cert_Fields.InvalidMessage_dbadatefrom4(le.dbadatefrom4_Invalid),Cert_Fields.InvalidMessage_dbadateto4(le.dbadateto4_Invalid),Cert_Fields.InvalidMessage_dbatype4(le.dbatype4_Invalid),Cert_Fields.InvalidMessage_dba5(le.dba5_Invalid),Cert_Fields.InvalidMessage_dbadatefrom5(le.dbadatefrom5_Invalid),Cert_Fields.InvalidMessage_dbadateto5(le.dbadateto5_Invalid),Cert_Fields.InvalidMessage_dbatype5(le.dbatype5_Invalid),Cert_Fields.InvalidMessage_subsidiaryname1(le.subsidiaryname1_Invalid),Cert_Fields.InvalidMessage_subsidiarystartdate1(le.subsidiarystartdate1_Invalid),Cert_Fields.InvalidMessage_subsidiaryname2(le.subsidiaryname2_Invalid),Cert_Fields.InvalidMessage_subsidiarystartdate2(le.subsidiarystartdate2_Invalid),Cert_Fields.InvalidMessage_subsidiaryname3(le.subsidiaryname3_Invalid),Cert_Fields.InvalidMessage_subsidiarystartdate3(le.subsidiarystartdate3_Invalid),Cert_Fields.InvalidMessage_subsidiaryname4(le.subsidiaryname4_Invalid),Cert_Fields.InvalidMessage_subsidiarystartdate4(le.subsidiarystartdate4_Invalid),Cert_Fields.InvalidMessage_subsidiaryname5(le.subsidiaryname5_Invalid),Cert_Fields.InvalidMessage_subsidiarystartdate5(le.subsidiarystartdate5_Invalid),Cert_Fields.InvalidMessage_subsidiaryname6(le.subsidiaryname6_Invalid),Cert_Fields.InvalidMessage_subsidiarystartdate6(le.subsidiarystartdate6_Invalid),Cert_Fields.InvalidMessage_subsidiaryname7(le.subsidiaryname7_Invalid),Cert_Fields.InvalidMessage_subsidiarystartdate7(le.subsidiarystartdate7_Invalid),Cert_Fields.InvalidMessage_subsidiaryname8(le.subsidiaryname8_Invalid),Cert_Fields.InvalidMessage_subsidiarystartdate8(le.subsidiarystartdate8_Invalid),Cert_Fields.InvalidMessage_subsidiaryname9(le.subsidiaryname9_Invalid),Cert_Fields.InvalidMessage_subsidiarystartdate9(le.subsidiarystartdate9_Invalid),Cert_Fields.InvalidMessage_subsidiaryname10(le.subsidiaryname10_Invalid),Cert_Fields.InvalidMessage_subsidiarystartdate10(le.subsidiarystartdate10_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dartid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dateadded_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dateupdated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.website_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.lninscertrecordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.profilelastupdated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.siid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sipstatuscode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.wcbempnumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ubinumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cofanumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.usdotnumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businessname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dba_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addressline1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addressline2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addresscity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addressstate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.addresszip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fax1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fax2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.email1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.email2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.businesstype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.namefirst_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.namemiddle_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.namelast_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.namesuffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nametitle_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailingaddress1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailingaddress2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailingaddresscity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailingaddressstate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailingaddresszip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailingaddresszip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactnamefirst_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactnamemiddle_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactnamelast_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactnamesuffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactbusinessname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactaddressline1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactaddressline2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactcity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactstate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactzip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactzip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactphone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactfax_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contactemail_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.policyholdernamefirst_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.policyholdernamemiddle_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.policyholdernamelast_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.policyholdernamesuffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statepolicyfilenumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.coverageinjuryillnessdate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.selfinsurancegroup_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.selfinsurancegroupphone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.selfinsurancegroupid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.numberofemployees_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.licensedcontractor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mconame_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mconumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mcoaddressline1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mcoaddressline2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mcocity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mcostate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mcozip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mcozip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mcophone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.governingclasscode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.licensenumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.class_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.classificationdescription_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.licensestatus_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.licenseadditionalinfo_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.licenseissuedate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.licenseexpirationdate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.naicscode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptfirstname1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptlastname1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptmiddlename1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempttitle1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempteffectivedate1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptterminationdate1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempttype1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptbusinessactivities1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptfirstname2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptlastname2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptmiddlename2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempttitle2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempteffectivedate2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptterminationdate2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempttype2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptbusinessactivities2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptfirstname3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptlastname3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptmiddlename3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempttitle3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempteffectivedate3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptterminationdate3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempttype3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptbusinessactivities3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptfirstname4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptlastname4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptmiddlename4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempttitle4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempteffectivedate4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptterminationdate4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempttype4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptbusinessactivities4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptfirstname5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptlastname5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptmiddlename5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempttitle5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempteffectivedate5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptterminationdate5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexempttype5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.officerexemptbusinessactivities5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dba1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbadatefrom1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbadateto1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbatype1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dba2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbadatefrom2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbadateto2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbatype2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dba3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbadatefrom3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbadateto3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbatype3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dba4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbadatefrom4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbadateto4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbatype4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dba5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbadatefrom5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbadateto5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbatype5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiaryname1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiarystartdate1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiaryname2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiarystartdate2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiaryname3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiarystartdate3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiaryname4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiarystartdate4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiaryname5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiarystartdate5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiaryname6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiarystartdate6_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiaryname7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiarystartdate7_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiaryname8_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiarystartdate8_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiaryname9_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiarystartdate9_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiaryname10_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.subsidiarystartdate10_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dartid','dateadded','dateupdated','website','state','lninscertrecordid','profilelastupdated','siid','sipstatuscode','wcbempnumber','ubinumber','cofanumber','usdotnumber','businessname','dba','addressline1','addressline2','addresscity','addressstate','addresszip','zip4','phone1','phone2','phone3','fax1','fax2','email1','email2','businesstype','namefirst','namemiddle','namelast','namesuffix','nametitle','mailingaddress1','mailingaddress2','mailingaddresscity','mailingaddressstate','mailingaddresszip','mailingaddresszip4','contactnamefirst','contactnamemiddle','contactnamelast','contactnamesuffix','contactbusinessname','contactaddressline1','contactaddressline2','contactcity','contactstate','contactzip','contactzip4','contactphone','contactfax','contactemail','policyholdernamefirst','policyholdernamemiddle','policyholdernamelast','policyholdernamesuffix','statepolicyfilenumber','coverageinjuryillnessdate','selfinsurancegroup','selfinsurancegroupphone','selfinsurancegroupid','numberofemployees','licensedcontractor','mconame','mconumber','mcoaddressline1','mcoaddressline2','mcocity','mcostate','mcozip','mcozip4','mcophone','governingclasscode','licensenumber','class','classificationdescription','licensestatus','licenseadditionalinfo','licenseissuedate','licenseexpirationdate','naicscode','officerexemptfirstname1','officerexemptlastname1','officerexemptmiddlename1','officerexempttitle1','officerexempteffectivedate1','officerexemptterminationdate1','officerexempttype1','officerexemptbusinessactivities1','officerexemptfirstname2','officerexemptlastname2','officerexemptmiddlename2','officerexempttitle2','officerexempteffectivedate2','officerexemptterminationdate2','officerexempttype2','officerexemptbusinessactivities2','officerexemptfirstname3','officerexemptlastname3','officerexemptmiddlename3','officerexempttitle3','officerexempteffectivedate3','officerexemptterminationdate3','officerexempttype3','officerexemptbusinessactivities3','officerexemptfirstname4','officerexemptlastname4','officerexemptmiddlename4','officerexempttitle4','officerexempteffectivedate4','officerexemptterminationdate4','officerexempttype4','officerexemptbusinessactivities4','officerexemptfirstname5','officerexemptlastname5','officerexemptmiddlename5','officerexempttitle5','officerexempteffectivedate5','officerexemptterminationdate5','officerexempttype5','officerexemptbusinessactivities5','dba1','dbadatefrom1','dbadateto1','dbatype1','dba2','dbadatefrom2','dbadateto2','dbatype2','dba3','dbadatefrom3','dbadateto3','dbatype3','dba4','dbadatefrom4','dbadateto4','dbatype4','dba5','dbadatefrom5','dbadateto5','dbatype5','subsidiaryname1','subsidiarystartdate1','subsidiaryname2','subsidiarystartdate2','subsidiaryname3','subsidiarystartdate3','subsidiaryname4','subsidiarystartdate4','subsidiaryname5','subsidiarystartdate5','subsidiaryname6','subsidiarystartdate6','subsidiaryname7','subsidiarystartdate7','subsidiaryname8','subsidiarystartdate8','subsidiaryname9','subsidiarystartdate9','subsidiaryname10','subsidiarystartdate10','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_State','Invalid_No','Invalid_Date','Invalid_No','Test','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaNum','Invalid_AlphaCaps','Invalid_State','Invalid_Zip','Invalid_No','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Invalid_AlphaCaps','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','Test','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dartid,(SALT311.StrType)le.dateadded,(SALT311.StrType)le.dateupdated,(SALT311.StrType)le.website,(SALT311.StrType)le.state,(SALT311.StrType)le.lninscertrecordid,(SALT311.StrType)le.profilelastupdated,(SALT311.StrType)le.siid,(SALT311.StrType)le.sipstatuscode,(SALT311.StrType)le.wcbempnumber,(SALT311.StrType)le.ubinumber,(SALT311.StrType)le.cofanumber,(SALT311.StrType)le.usdotnumber,(SALT311.StrType)le.businessname,(SALT311.StrType)le.dba,(SALT311.StrType)le.addressline1,(SALT311.StrType)le.addressline2,(SALT311.StrType)le.addresscity,(SALT311.StrType)le.addressstate,(SALT311.StrType)le.addresszip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.phone1,(SALT311.StrType)le.phone2,(SALT311.StrType)le.phone3,(SALT311.StrType)le.fax1,(SALT311.StrType)le.fax2,(SALT311.StrType)le.email1,(SALT311.StrType)le.email2,(SALT311.StrType)le.businesstype,(SALT311.StrType)le.namefirst,(SALT311.StrType)le.namemiddle,(SALT311.StrType)le.namelast,(SALT311.StrType)le.namesuffix,(SALT311.StrType)le.nametitle,(SALT311.StrType)le.mailingaddress1,(SALT311.StrType)le.mailingaddress2,(SALT311.StrType)le.mailingaddresscity,(SALT311.StrType)le.mailingaddressstate,(SALT311.StrType)le.mailingaddresszip,(SALT311.StrType)le.mailingaddresszip4,(SALT311.StrType)le.contactnamefirst,(SALT311.StrType)le.contactnamemiddle,(SALT311.StrType)le.contactnamelast,(SALT311.StrType)le.contactnamesuffix,(SALT311.StrType)le.contactbusinessname,(SALT311.StrType)le.contactaddressline1,(SALT311.StrType)le.contactaddressline2,(SALT311.StrType)le.contactcity,(SALT311.StrType)le.contactstate,(SALT311.StrType)le.contactzip,(SALT311.StrType)le.contactzip4,(SALT311.StrType)le.contactphone,(SALT311.StrType)le.contactfax,(SALT311.StrType)le.contactemail,(SALT311.StrType)le.policyholdernamefirst,(SALT311.StrType)le.policyholdernamemiddle,(SALT311.StrType)le.policyholdernamelast,(SALT311.StrType)le.policyholdernamesuffix,(SALT311.StrType)le.statepolicyfilenumber,(SALT311.StrType)le.coverageinjuryillnessdate,(SALT311.StrType)le.selfinsurancegroup,(SALT311.StrType)le.selfinsurancegroupphone,(SALT311.StrType)le.selfinsurancegroupid,(SALT311.StrType)le.numberofemployees,(SALT311.StrType)le.licensedcontractor,(SALT311.StrType)le.mconame,(SALT311.StrType)le.mconumber,(SALT311.StrType)le.mcoaddressline1,(SALT311.StrType)le.mcoaddressline2,(SALT311.StrType)le.mcocity,(SALT311.StrType)le.mcostate,(SALT311.StrType)le.mcozip,(SALT311.StrType)le.mcozip4,(SALT311.StrType)le.mcophone,(SALT311.StrType)le.governingclasscode,(SALT311.StrType)le.licensenumber,(SALT311.StrType)le.class,(SALT311.StrType)le.classificationdescription,(SALT311.StrType)le.licensestatus,(SALT311.StrType)le.licenseadditionalinfo,(SALT311.StrType)le.licenseissuedate,(SALT311.StrType)le.licenseexpirationdate,(SALT311.StrType)le.naicscode,(SALT311.StrType)le.officerexemptfirstname1,(SALT311.StrType)le.officerexemptlastname1,(SALT311.StrType)le.officerexemptmiddlename1,(SALT311.StrType)le.officerexempttitle1,(SALT311.StrType)le.officerexempteffectivedate1,(SALT311.StrType)le.officerexemptterminationdate1,(SALT311.StrType)le.officerexempttype1,(SALT311.StrType)le.officerexemptbusinessactivities1,(SALT311.StrType)le.officerexemptfirstname2,(SALT311.StrType)le.officerexemptlastname2,(SALT311.StrType)le.officerexemptmiddlename2,(SALT311.StrType)le.officerexempttitle2,(SALT311.StrType)le.officerexempteffectivedate2,(SALT311.StrType)le.officerexemptterminationdate2,(SALT311.StrType)le.officerexempttype2,(SALT311.StrType)le.officerexemptbusinessactivities2,(SALT311.StrType)le.officerexemptfirstname3,(SALT311.StrType)le.officerexemptlastname3,(SALT311.StrType)le.officerexemptmiddlename3,(SALT311.StrType)le.officerexempttitle3,(SALT311.StrType)le.officerexempteffectivedate3,(SALT311.StrType)le.officerexemptterminationdate3,(SALT311.StrType)le.officerexempttype3,(SALT311.StrType)le.officerexemptbusinessactivities3,(SALT311.StrType)le.officerexemptfirstname4,(SALT311.StrType)le.officerexemptlastname4,(SALT311.StrType)le.officerexemptmiddlename4,(SALT311.StrType)le.officerexempttitle4,(SALT311.StrType)le.officerexempteffectivedate4,(SALT311.StrType)le.officerexemptterminationdate4,(SALT311.StrType)le.officerexempttype4,(SALT311.StrType)le.officerexemptbusinessactivities4,(SALT311.StrType)le.officerexemptfirstname5,(SALT311.StrType)le.officerexemptlastname5,(SALT311.StrType)le.officerexemptmiddlename5,(SALT311.StrType)le.officerexempttitle5,(SALT311.StrType)le.officerexempteffectivedate5,(SALT311.StrType)le.officerexemptterminationdate5,(SALT311.StrType)le.officerexempttype5,(SALT311.StrType)le.officerexemptbusinessactivities5,(SALT311.StrType)le.dba1,(SALT311.StrType)le.dbadatefrom1,(SALT311.StrType)le.dbadateto1,(SALT311.StrType)le.dbatype1,(SALT311.StrType)le.dba2,(SALT311.StrType)le.dbadatefrom2,(SALT311.StrType)le.dbadateto2,(SALT311.StrType)le.dbatype2,(SALT311.StrType)le.dba3,(SALT311.StrType)le.dbadatefrom3,(SALT311.StrType)le.dbadateto3,(SALT311.StrType)le.dbatype3,(SALT311.StrType)le.dba4,(SALT311.StrType)le.dbadatefrom4,(SALT311.StrType)le.dbadateto4,(SALT311.StrType)le.dbatype4,(SALT311.StrType)le.dba5,(SALT311.StrType)le.dbadatefrom5,(SALT311.StrType)le.dbadateto5,(SALT311.StrType)le.dbatype5,(SALT311.StrType)le.subsidiaryname1,(SALT311.StrType)le.subsidiarystartdate1,(SALT311.StrType)le.subsidiaryname2,(SALT311.StrType)le.subsidiarystartdate2,(SALT311.StrType)le.subsidiaryname3,(SALT311.StrType)le.subsidiarystartdate3,(SALT311.StrType)le.subsidiaryname4,(SALT311.StrType)le.subsidiarystartdate4,(SALT311.StrType)le.subsidiaryname5,(SALT311.StrType)le.subsidiarystartdate5,(SALT311.StrType)le.subsidiaryname6,(SALT311.StrType)le.subsidiarystartdate6,(SALT311.StrType)le.subsidiaryname7,(SALT311.StrType)le.subsidiarystartdate7,(SALT311.StrType)le.subsidiaryname8,(SALT311.StrType)le.subsidiarystartdate8,(SALT311.StrType)le.subsidiaryname9,(SALT311.StrType)le.subsidiarystartdate9,(SALT311.StrType)le.subsidiaryname10,(SALT311.StrType)le.subsidiarystartdate10,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,163,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Cert_Layout_Insurance_Cert) prevDS = DATASET([], Cert_Layout_Insurance_Cert), STRING10 Src='UNK'):= FUNCTION
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
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.lninscertrecordid_ALLOW_ErrorCount
          ,le.profilelastupdated_CUSTOM_ErrorCount
          ,le.siid_ALLOW_ErrorCount
          ,le.sipstatuscode_ALLOW_ErrorCount
          ,le.wcbempnumber_ALLOW_ErrorCount
          ,le.ubinumber_ALLOW_ErrorCount
          ,le.cofanumber_ALLOW_ErrorCount
          ,le.usdotnumber_ALLOW_ErrorCount
          ,le.businessname_ALLOW_ErrorCount
          ,le.dba_ALLOW_ErrorCount
          ,le.addressline1_ALLOW_ErrorCount
          ,le.addressline2_ALLOW_ErrorCount
          ,le.addresscity_ALLOW_ErrorCount
          ,le.addressstate_ALLOW_ErrorCount,le.addressstate_LENGTHS_ErrorCount
          ,le.addresszip_ALLOW_ErrorCount,le.addresszip_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.phone1_ALLOW_ErrorCount
          ,le.phone2_ALLOW_ErrorCount
          ,le.phone3_ALLOW_ErrorCount
          ,le.fax1_ALLOW_ErrorCount
          ,le.fax2_ALLOW_ErrorCount
          ,le.email1_ALLOW_ErrorCount
          ,le.email2_ALLOW_ErrorCount
          ,le.businesstype_ALLOW_ErrorCount
          ,le.namefirst_ALLOW_ErrorCount
          ,le.namemiddle_ALLOW_ErrorCount
          ,le.namelast_ALLOW_ErrorCount
          ,le.namesuffix_ALLOW_ErrorCount
          ,le.nametitle_ALLOW_ErrorCount
          ,le.mailingaddress1_ALLOW_ErrorCount
          ,le.mailingaddress2_ALLOW_ErrorCount
          ,le.mailingaddresscity_ALLOW_ErrorCount
          ,le.mailingaddressstate_ALLOW_ErrorCount
          ,le.mailingaddresszip_ALLOW_ErrorCount
          ,le.mailingaddresszip4_ALLOW_ErrorCount
          ,le.contactnamefirst_ALLOW_ErrorCount
          ,le.contactnamemiddle_ALLOW_ErrorCount
          ,le.contactnamelast_ALLOW_ErrorCount
          ,le.contactnamesuffix_ALLOW_ErrorCount
          ,le.contactbusinessname_ALLOW_ErrorCount
          ,le.contactaddressline1_ALLOW_ErrorCount
          ,le.contactaddressline2_ALLOW_ErrorCount
          ,le.contactcity_ALLOW_ErrorCount
          ,le.contactstate_ALLOW_ErrorCount
          ,le.contactzip_ALLOW_ErrorCount
          ,le.contactzip4_ALLOW_ErrorCount
          ,le.contactphone_ALLOW_ErrorCount
          ,le.contactfax_ALLOW_ErrorCount
          ,le.contactemail_ALLOW_ErrorCount
          ,le.policyholdernamefirst_ALLOW_ErrorCount
          ,le.policyholdernamemiddle_ALLOW_ErrorCount
          ,le.policyholdernamelast_ALLOW_ErrorCount
          ,le.policyholdernamesuffix_ALLOW_ErrorCount
          ,le.statepolicyfilenumber_ALLOW_ErrorCount
          ,le.coverageinjuryillnessdate_ALLOW_ErrorCount
          ,le.selfinsurancegroup_ALLOW_ErrorCount
          ,le.selfinsurancegroupphone_ALLOW_ErrorCount
          ,le.selfinsurancegroupid_ALLOW_ErrorCount
          ,le.numberofemployees_ALLOW_ErrorCount
          ,le.licensedcontractor_ALLOW_ErrorCount
          ,le.mconame_ALLOW_ErrorCount
          ,le.mconumber_ALLOW_ErrorCount
          ,le.mcoaddressline1_ALLOW_ErrorCount
          ,le.mcoaddressline2_ALLOW_ErrorCount
          ,le.mcocity_ALLOW_ErrorCount
          ,le.mcostate_ALLOW_ErrorCount
          ,le.mcozip_ALLOW_ErrorCount
          ,le.mcozip4_ALLOW_ErrorCount
          ,le.mcophone_ALLOW_ErrorCount
          ,le.governingclasscode_ALLOW_ErrorCount
          ,le.licensenumber_ALLOW_ErrorCount
          ,le.class_ALLOW_ErrorCount
          ,le.classificationdescription_ALLOW_ErrorCount
          ,le.licensestatus_ALLOW_ErrorCount
          ,le.licenseadditionalinfo_ALLOW_ErrorCount
          ,le.licenseissuedate_ALLOW_ErrorCount
          ,le.licenseexpirationdate_ALLOW_ErrorCount
          ,le.naicscode_ALLOW_ErrorCount
          ,le.officerexemptfirstname1_ALLOW_ErrorCount
          ,le.officerexemptlastname1_ALLOW_ErrorCount
          ,le.officerexemptmiddlename1_ALLOW_ErrorCount
          ,le.officerexempttitle1_ALLOW_ErrorCount
          ,le.officerexempteffectivedate1_ALLOW_ErrorCount
          ,le.officerexemptterminationdate1_ALLOW_ErrorCount
          ,le.officerexempttype1_ALLOW_ErrorCount
          ,le.officerexemptbusinessactivities1_ALLOW_ErrorCount
          ,le.officerexemptfirstname2_ALLOW_ErrorCount
          ,le.officerexemptlastname2_ALLOW_ErrorCount
          ,le.officerexemptmiddlename2_ALLOW_ErrorCount
          ,le.officerexempttitle2_ALLOW_ErrorCount
          ,le.officerexempteffectivedate2_ALLOW_ErrorCount
          ,le.officerexemptterminationdate2_ALLOW_ErrorCount
          ,le.officerexempttype2_ALLOW_ErrorCount
          ,le.officerexemptbusinessactivities2_ALLOW_ErrorCount
          ,le.officerexemptfirstname3_ALLOW_ErrorCount
          ,le.officerexemptlastname3_ALLOW_ErrorCount
          ,le.officerexemptmiddlename3_ALLOW_ErrorCount
          ,le.officerexempttitle3_ALLOW_ErrorCount
          ,le.officerexempteffectivedate3_ALLOW_ErrorCount
          ,le.officerexemptterminationdate3_ALLOW_ErrorCount
          ,le.officerexempttype3_ALLOW_ErrorCount
          ,le.officerexemptbusinessactivities3_ALLOW_ErrorCount
          ,le.officerexemptfirstname4_ALLOW_ErrorCount
          ,le.officerexemptlastname4_ALLOW_ErrorCount
          ,le.officerexemptmiddlename4_ALLOW_ErrorCount
          ,le.officerexempttitle4_ALLOW_ErrorCount
          ,le.officerexempteffectivedate4_ALLOW_ErrorCount
          ,le.officerexemptterminationdate4_ALLOW_ErrorCount
          ,le.officerexempttype4_ALLOW_ErrorCount
          ,le.officerexemptbusinessactivities4_ALLOW_ErrorCount
          ,le.officerexemptfirstname5_ALLOW_ErrorCount
          ,le.officerexemptlastname5_ALLOW_ErrorCount
          ,le.officerexemptmiddlename5_ALLOW_ErrorCount
          ,le.officerexempttitle5_ALLOW_ErrorCount
          ,le.officerexempteffectivedate5_ALLOW_ErrorCount
          ,le.officerexemptterminationdate5_ALLOW_ErrorCount
          ,le.officerexempttype5_ALLOW_ErrorCount
          ,le.officerexemptbusinessactivities5_ALLOW_ErrorCount
          ,le.dba1_ALLOW_ErrorCount
          ,le.dbadatefrom1_ALLOW_ErrorCount
          ,le.dbadateto1_ALLOW_ErrorCount
          ,le.dbatype1_ALLOW_ErrorCount
          ,le.dba2_ALLOW_ErrorCount
          ,le.dbadatefrom2_ALLOW_ErrorCount
          ,le.dbadateto2_ALLOW_ErrorCount
          ,le.dbatype2_ALLOW_ErrorCount
          ,le.dba3_ALLOW_ErrorCount
          ,le.dbadatefrom3_ALLOW_ErrorCount
          ,le.dbadateto3_ALLOW_ErrorCount
          ,le.dbatype3_ALLOW_ErrorCount
          ,le.dba4_ALLOW_ErrorCount
          ,le.dbadatefrom4_ALLOW_ErrorCount
          ,le.dbadateto4_ALLOW_ErrorCount
          ,le.dbatype4_ALLOW_ErrorCount
          ,le.dba5_ALLOW_ErrorCount
          ,le.dbadatefrom5_ALLOW_ErrorCount
          ,le.dbadateto5_ALLOW_ErrorCount
          ,le.dbatype5_ALLOW_ErrorCount
          ,le.subsidiaryname1_ALLOW_ErrorCount
          ,le.subsidiarystartdate1_ALLOW_ErrorCount
          ,le.subsidiaryname2_ALLOW_ErrorCount
          ,le.subsidiarystartdate2_ALLOW_ErrorCount
          ,le.subsidiaryname3_ALLOW_ErrorCount
          ,le.subsidiarystartdate3_ALLOW_ErrorCount
          ,le.subsidiaryname4_ALLOW_ErrorCount
          ,le.subsidiarystartdate4_ALLOW_ErrorCount
          ,le.subsidiaryname5_ALLOW_ErrorCount
          ,le.subsidiarystartdate5_ALLOW_ErrorCount
          ,le.subsidiaryname6_ALLOW_ErrorCount
          ,le.subsidiarystartdate6_ALLOW_ErrorCount
          ,le.subsidiaryname7_ALLOW_ErrorCount
          ,le.subsidiarystartdate7_ALLOW_ErrorCount
          ,le.subsidiaryname8_ALLOW_ErrorCount
          ,le.subsidiarystartdate8_ALLOW_ErrorCount
          ,le.subsidiaryname9_ALLOW_ErrorCount
          ,le.subsidiarystartdate9_ALLOW_ErrorCount
          ,le.subsidiaryname10_ALLOW_ErrorCount
          ,le.subsidiarystartdate10_ALLOW_ErrorCount
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
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.lninscertrecordid_ALLOW_ErrorCount
          ,le.profilelastupdated_CUSTOM_ErrorCount
          ,le.siid_ALLOW_ErrorCount
          ,le.sipstatuscode_ALLOW_ErrorCount
          ,le.wcbempnumber_ALLOW_ErrorCount
          ,le.ubinumber_ALLOW_ErrorCount
          ,le.cofanumber_ALLOW_ErrorCount
          ,le.usdotnumber_ALLOW_ErrorCount
          ,le.businessname_ALLOW_ErrorCount
          ,le.dba_ALLOW_ErrorCount
          ,le.addressline1_ALLOW_ErrorCount
          ,le.addressline2_ALLOW_ErrorCount
          ,le.addresscity_ALLOW_ErrorCount
          ,le.addressstate_ALLOW_ErrorCount,le.addressstate_LENGTHS_ErrorCount
          ,le.addresszip_ALLOW_ErrorCount,le.addresszip_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.phone1_ALLOW_ErrorCount
          ,le.phone2_ALLOW_ErrorCount
          ,le.phone3_ALLOW_ErrorCount
          ,le.fax1_ALLOW_ErrorCount
          ,le.fax2_ALLOW_ErrorCount
          ,le.email1_ALLOW_ErrorCount
          ,le.email2_ALLOW_ErrorCount
          ,le.businesstype_ALLOW_ErrorCount
          ,le.namefirst_ALLOW_ErrorCount
          ,le.namemiddle_ALLOW_ErrorCount
          ,le.namelast_ALLOW_ErrorCount
          ,le.namesuffix_ALLOW_ErrorCount
          ,le.nametitle_ALLOW_ErrorCount
          ,le.mailingaddress1_ALLOW_ErrorCount
          ,le.mailingaddress2_ALLOW_ErrorCount
          ,le.mailingaddresscity_ALLOW_ErrorCount
          ,le.mailingaddressstate_ALLOW_ErrorCount
          ,le.mailingaddresszip_ALLOW_ErrorCount
          ,le.mailingaddresszip4_ALLOW_ErrorCount
          ,le.contactnamefirst_ALLOW_ErrorCount
          ,le.contactnamemiddle_ALLOW_ErrorCount
          ,le.contactnamelast_ALLOW_ErrorCount
          ,le.contactnamesuffix_ALLOW_ErrorCount
          ,le.contactbusinessname_ALLOW_ErrorCount
          ,le.contactaddressline1_ALLOW_ErrorCount
          ,le.contactaddressline2_ALLOW_ErrorCount
          ,le.contactcity_ALLOW_ErrorCount
          ,le.contactstate_ALLOW_ErrorCount
          ,le.contactzip_ALLOW_ErrorCount
          ,le.contactzip4_ALLOW_ErrorCount
          ,le.contactphone_ALLOW_ErrorCount
          ,le.contactfax_ALLOW_ErrorCount
          ,le.contactemail_ALLOW_ErrorCount
          ,le.policyholdernamefirst_ALLOW_ErrorCount
          ,le.policyholdernamemiddle_ALLOW_ErrorCount
          ,le.policyholdernamelast_ALLOW_ErrorCount
          ,le.policyholdernamesuffix_ALLOW_ErrorCount
          ,le.statepolicyfilenumber_ALLOW_ErrorCount
          ,le.coverageinjuryillnessdate_ALLOW_ErrorCount
          ,le.selfinsurancegroup_ALLOW_ErrorCount
          ,le.selfinsurancegroupphone_ALLOW_ErrorCount
          ,le.selfinsurancegroupid_ALLOW_ErrorCount
          ,le.numberofemployees_ALLOW_ErrorCount
          ,le.licensedcontractor_ALLOW_ErrorCount
          ,le.mconame_ALLOW_ErrorCount
          ,le.mconumber_ALLOW_ErrorCount
          ,le.mcoaddressline1_ALLOW_ErrorCount
          ,le.mcoaddressline2_ALLOW_ErrorCount
          ,le.mcocity_ALLOW_ErrorCount
          ,le.mcostate_ALLOW_ErrorCount
          ,le.mcozip_ALLOW_ErrorCount
          ,le.mcozip4_ALLOW_ErrorCount
          ,le.mcophone_ALLOW_ErrorCount
          ,le.governingclasscode_ALLOW_ErrorCount
          ,le.licensenumber_ALLOW_ErrorCount
          ,le.class_ALLOW_ErrorCount
          ,le.classificationdescription_ALLOW_ErrorCount
          ,le.licensestatus_ALLOW_ErrorCount
          ,le.licenseadditionalinfo_ALLOW_ErrorCount
          ,le.licenseissuedate_ALLOW_ErrorCount
          ,le.licenseexpirationdate_ALLOW_ErrorCount
          ,le.naicscode_ALLOW_ErrorCount
          ,le.officerexemptfirstname1_ALLOW_ErrorCount
          ,le.officerexemptlastname1_ALLOW_ErrorCount
          ,le.officerexemptmiddlename1_ALLOW_ErrorCount
          ,le.officerexempttitle1_ALLOW_ErrorCount
          ,le.officerexempteffectivedate1_ALLOW_ErrorCount
          ,le.officerexemptterminationdate1_ALLOW_ErrorCount
          ,le.officerexempttype1_ALLOW_ErrorCount
          ,le.officerexemptbusinessactivities1_ALLOW_ErrorCount
          ,le.officerexemptfirstname2_ALLOW_ErrorCount
          ,le.officerexemptlastname2_ALLOW_ErrorCount
          ,le.officerexemptmiddlename2_ALLOW_ErrorCount
          ,le.officerexempttitle2_ALLOW_ErrorCount
          ,le.officerexempteffectivedate2_ALLOW_ErrorCount
          ,le.officerexemptterminationdate2_ALLOW_ErrorCount
          ,le.officerexempttype2_ALLOW_ErrorCount
          ,le.officerexemptbusinessactivities2_ALLOW_ErrorCount
          ,le.officerexemptfirstname3_ALLOW_ErrorCount
          ,le.officerexemptlastname3_ALLOW_ErrorCount
          ,le.officerexemptmiddlename3_ALLOW_ErrorCount
          ,le.officerexempttitle3_ALLOW_ErrorCount
          ,le.officerexempteffectivedate3_ALLOW_ErrorCount
          ,le.officerexemptterminationdate3_ALLOW_ErrorCount
          ,le.officerexempttype3_ALLOW_ErrorCount
          ,le.officerexemptbusinessactivities3_ALLOW_ErrorCount
          ,le.officerexemptfirstname4_ALLOW_ErrorCount
          ,le.officerexemptlastname4_ALLOW_ErrorCount
          ,le.officerexemptmiddlename4_ALLOW_ErrorCount
          ,le.officerexempttitle4_ALLOW_ErrorCount
          ,le.officerexempteffectivedate4_ALLOW_ErrorCount
          ,le.officerexemptterminationdate4_ALLOW_ErrorCount
          ,le.officerexempttype4_ALLOW_ErrorCount
          ,le.officerexemptbusinessactivities4_ALLOW_ErrorCount
          ,le.officerexemptfirstname5_ALLOW_ErrorCount
          ,le.officerexemptlastname5_ALLOW_ErrorCount
          ,le.officerexemptmiddlename5_ALLOW_ErrorCount
          ,le.officerexempttitle5_ALLOW_ErrorCount
          ,le.officerexempteffectivedate5_ALLOW_ErrorCount
          ,le.officerexemptterminationdate5_ALLOW_ErrorCount
          ,le.officerexempttype5_ALLOW_ErrorCount
          ,le.officerexemptbusinessactivities5_ALLOW_ErrorCount
          ,le.dba1_ALLOW_ErrorCount
          ,le.dbadatefrom1_ALLOW_ErrorCount
          ,le.dbadateto1_ALLOW_ErrorCount
          ,le.dbatype1_ALLOW_ErrorCount
          ,le.dba2_ALLOW_ErrorCount
          ,le.dbadatefrom2_ALLOW_ErrorCount
          ,le.dbadateto2_ALLOW_ErrorCount
          ,le.dbatype2_ALLOW_ErrorCount
          ,le.dba3_ALLOW_ErrorCount
          ,le.dbadatefrom3_ALLOW_ErrorCount
          ,le.dbadateto3_ALLOW_ErrorCount
          ,le.dbatype3_ALLOW_ErrorCount
          ,le.dba4_ALLOW_ErrorCount
          ,le.dbadatefrom4_ALLOW_ErrorCount
          ,le.dbadateto4_ALLOW_ErrorCount
          ,le.dbatype4_ALLOW_ErrorCount
          ,le.dba5_ALLOW_ErrorCount
          ,le.dbadatefrom5_ALLOW_ErrorCount
          ,le.dbadateto5_ALLOW_ErrorCount
          ,le.dbatype5_ALLOW_ErrorCount
          ,le.subsidiaryname1_ALLOW_ErrorCount
          ,le.subsidiarystartdate1_ALLOW_ErrorCount
          ,le.subsidiaryname2_ALLOW_ErrorCount
          ,le.subsidiarystartdate2_ALLOW_ErrorCount
          ,le.subsidiaryname3_ALLOW_ErrorCount
          ,le.subsidiarystartdate3_ALLOW_ErrorCount
          ,le.subsidiaryname4_ALLOW_ErrorCount
          ,le.subsidiarystartdate4_ALLOW_ErrorCount
          ,le.subsidiaryname5_ALLOW_ErrorCount
          ,le.subsidiarystartdate5_ALLOW_ErrorCount
          ,le.subsidiaryname6_ALLOW_ErrorCount
          ,le.subsidiarystartdate6_ALLOW_ErrorCount
          ,le.subsidiaryname7_ALLOW_ErrorCount
          ,le.subsidiarystartdate7_ALLOW_ErrorCount
          ,le.subsidiaryname8_ALLOW_ErrorCount
          ,le.subsidiarystartdate8_ALLOW_ErrorCount
          ,le.subsidiaryname9_ALLOW_ErrorCount
          ,le.subsidiarystartdate9_ALLOW_ErrorCount
          ,le.subsidiaryname10_ALLOW_ErrorCount
          ,le.subsidiarystartdate10_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Cert_hygiene(PROJECT(h, Cert_Layout_Insurance_Cert));
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
          ,'lninscertrecordid:' + getFieldTypeText(h.lninscertrecordid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'profilelastupdated:' + getFieldTypeText(h.profilelastupdated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'siid:' + getFieldTypeText(h.siid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sipstatuscode:' + getFieldTypeText(h.sipstatuscode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'wcbempnumber:' + getFieldTypeText(h.wcbempnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ubinumber:' + getFieldTypeText(h.ubinumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cofanumber:' + getFieldTypeText(h.cofanumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'usdotnumber:' + getFieldTypeText(h.usdotnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businessname:' + getFieldTypeText(h.businessname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba:' + getFieldTypeText(h.dba) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addressline1:' + getFieldTypeText(h.addressline1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addressline2:' + getFieldTypeText(h.addressline2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresscity:' + getFieldTypeText(h.addresscity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addressstate:' + getFieldTypeText(h.addressstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresszip:' + getFieldTypeText(h.addresszip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone1:' + getFieldTypeText(h.phone1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone2:' + getFieldTypeText(h.phone2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone3:' + getFieldTypeText(h.phone3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fax1:' + getFieldTypeText(h.fax1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fax2:' + getFieldTypeText(h.fax2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email1:' + getFieldTypeText(h.email1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email2:' + getFieldTypeText(h.email2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'businesstype:' + getFieldTypeText(h.businesstype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'namefirst:' + getFieldTypeText(h.namefirst) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'namemiddle:' + getFieldTypeText(h.namemiddle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'namelast:' + getFieldTypeText(h.namelast) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'namesuffix:' + getFieldTypeText(h.namesuffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nametitle:' + getFieldTypeText(h.nametitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailingaddress1:' + getFieldTypeText(h.mailingaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailingaddress2:' + getFieldTypeText(h.mailingaddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailingaddresscity:' + getFieldTypeText(h.mailingaddresscity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailingaddressstate:' + getFieldTypeText(h.mailingaddressstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailingaddresszip:' + getFieldTypeText(h.mailingaddresszip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailingaddresszip4:' + getFieldTypeText(h.mailingaddresszip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactnamefirst:' + getFieldTypeText(h.contactnamefirst) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactnamemiddle:' + getFieldTypeText(h.contactnamemiddle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactnamelast:' + getFieldTypeText(h.contactnamelast) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactnamesuffix:' + getFieldTypeText(h.contactnamesuffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactbusinessname:' + getFieldTypeText(h.contactbusinessname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactaddressline1:' + getFieldTypeText(h.contactaddressline1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactaddressline2:' + getFieldTypeText(h.contactaddressline2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactcity:' + getFieldTypeText(h.contactcity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactstate:' + getFieldTypeText(h.contactstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactzip:' + getFieldTypeText(h.contactzip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactzip4:' + getFieldTypeText(h.contactzip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactphone:' + getFieldTypeText(h.contactphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactfax:' + getFieldTypeText(h.contactfax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contactemail:' + getFieldTypeText(h.contactemail) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policyholdernamefirst:' + getFieldTypeText(h.policyholdernamefirst) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policyholdernamemiddle:' + getFieldTypeText(h.policyholdernamemiddle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policyholdernamelast:' + getFieldTypeText(h.policyholdernamelast) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'policyholdernamesuffix:' + getFieldTypeText(h.policyholdernamesuffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statepolicyfilenumber:' + getFieldTypeText(h.statepolicyfilenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coverageinjuryillnessdate:' + getFieldTypeText(h.coverageinjuryillnessdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selfinsurancegroup:' + getFieldTypeText(h.selfinsurancegroup) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selfinsurancegroupphone:' + getFieldTypeText(h.selfinsurancegroupphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selfinsurancegroupid:' + getFieldTypeText(h.selfinsurancegroupid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'numberofemployees:' + getFieldTypeText(h.numberofemployees) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensedcontractor:' + getFieldTypeText(h.licensedcontractor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mconame:' + getFieldTypeText(h.mconame) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mconumber:' + getFieldTypeText(h.mconumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mcoaddressline1:' + getFieldTypeText(h.mcoaddressline1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mcoaddressline2:' + getFieldTypeText(h.mcoaddressline2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mcocity:' + getFieldTypeText(h.mcocity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mcostate:' + getFieldTypeText(h.mcostate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mcozip:' + getFieldTypeText(h.mcozip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mcozip4:' + getFieldTypeText(h.mcozip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mcophone:' + getFieldTypeText(h.mcophone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'governingclasscode:' + getFieldTypeText(h.governingclasscode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensenumber:' + getFieldTypeText(h.licensenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'class:' + getFieldTypeText(h.class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classificationdescription:' + getFieldTypeText(h.classificationdescription) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licensestatus:' + getFieldTypeText(h.licensestatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licenseadditionalinfo:' + getFieldTypeText(h.licenseadditionalinfo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licenseissuedate:' + getFieldTypeText(h.licenseissuedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'licenseexpirationdate:' + getFieldTypeText(h.licenseexpirationdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naicscode:' + getFieldTypeText(h.naicscode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptfirstname1:' + getFieldTypeText(h.officerexemptfirstname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptlastname1:' + getFieldTypeText(h.officerexemptlastname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptmiddlename1:' + getFieldTypeText(h.officerexemptmiddlename1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempttitle1:' + getFieldTypeText(h.officerexempttitle1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempteffectivedate1:' + getFieldTypeText(h.officerexempteffectivedate1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptterminationdate1:' + getFieldTypeText(h.officerexemptterminationdate1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempttype1:' + getFieldTypeText(h.officerexempttype1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptbusinessactivities1:' + getFieldTypeText(h.officerexemptbusinessactivities1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptfirstname2:' + getFieldTypeText(h.officerexemptfirstname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptlastname2:' + getFieldTypeText(h.officerexemptlastname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptmiddlename2:' + getFieldTypeText(h.officerexemptmiddlename2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempttitle2:' + getFieldTypeText(h.officerexempttitle2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempteffectivedate2:' + getFieldTypeText(h.officerexempteffectivedate2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptterminationdate2:' + getFieldTypeText(h.officerexemptterminationdate2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempttype2:' + getFieldTypeText(h.officerexempttype2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptbusinessactivities2:' + getFieldTypeText(h.officerexemptbusinessactivities2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptfirstname3:' + getFieldTypeText(h.officerexemptfirstname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptlastname3:' + getFieldTypeText(h.officerexemptlastname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptmiddlename3:' + getFieldTypeText(h.officerexemptmiddlename3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempttitle3:' + getFieldTypeText(h.officerexempttitle3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempteffectivedate3:' + getFieldTypeText(h.officerexempteffectivedate3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptterminationdate3:' + getFieldTypeText(h.officerexemptterminationdate3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempttype3:' + getFieldTypeText(h.officerexempttype3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptbusinessactivities3:' + getFieldTypeText(h.officerexemptbusinessactivities3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptfirstname4:' + getFieldTypeText(h.officerexemptfirstname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptlastname4:' + getFieldTypeText(h.officerexemptlastname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptmiddlename4:' + getFieldTypeText(h.officerexemptmiddlename4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempttitle4:' + getFieldTypeText(h.officerexempttitle4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempteffectivedate4:' + getFieldTypeText(h.officerexempteffectivedate4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptterminationdate4:' + getFieldTypeText(h.officerexemptterminationdate4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempttype4:' + getFieldTypeText(h.officerexempttype4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptbusinessactivities4:' + getFieldTypeText(h.officerexemptbusinessactivities4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptfirstname5:' + getFieldTypeText(h.officerexemptfirstname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptlastname5:' + getFieldTypeText(h.officerexemptlastname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptmiddlename5:' + getFieldTypeText(h.officerexemptmiddlename5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempttitle5:' + getFieldTypeText(h.officerexempttitle5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempteffectivedate5:' + getFieldTypeText(h.officerexempteffectivedate5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptterminationdate5:' + getFieldTypeText(h.officerexemptterminationdate5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexempttype5:' + getFieldTypeText(h.officerexempttype5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'officerexemptbusinessactivities5:' + getFieldTypeText(h.officerexemptbusinessactivities5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba1:' + getFieldTypeText(h.dba1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbadatefrom1:' + getFieldTypeText(h.dbadatefrom1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbadateto1:' + getFieldTypeText(h.dbadateto1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbatype1:' + getFieldTypeText(h.dbatype1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba2:' + getFieldTypeText(h.dba2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbadatefrom2:' + getFieldTypeText(h.dbadatefrom2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbadateto2:' + getFieldTypeText(h.dbadateto2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbatype2:' + getFieldTypeText(h.dbatype2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba3:' + getFieldTypeText(h.dba3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbadatefrom3:' + getFieldTypeText(h.dbadatefrom3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbadateto3:' + getFieldTypeText(h.dbadateto3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbatype3:' + getFieldTypeText(h.dbatype3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba4:' + getFieldTypeText(h.dba4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbadatefrom4:' + getFieldTypeText(h.dbadatefrom4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbadateto4:' + getFieldTypeText(h.dbadateto4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbatype4:' + getFieldTypeText(h.dbatype4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba5:' + getFieldTypeText(h.dba5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbadatefrom5:' + getFieldTypeText(h.dbadatefrom5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbadateto5:' + getFieldTypeText(h.dbadateto5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbatype5:' + getFieldTypeText(h.dbatype5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiaryname1:' + getFieldTypeText(h.subsidiaryname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiarystartdate1:' + getFieldTypeText(h.subsidiarystartdate1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiaryname2:' + getFieldTypeText(h.subsidiaryname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiarystartdate2:' + getFieldTypeText(h.subsidiarystartdate2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiaryname3:' + getFieldTypeText(h.subsidiaryname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiarystartdate3:' + getFieldTypeText(h.subsidiarystartdate3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiaryname4:' + getFieldTypeText(h.subsidiaryname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiarystartdate4:' + getFieldTypeText(h.subsidiarystartdate4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiaryname5:' + getFieldTypeText(h.subsidiaryname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiarystartdate5:' + getFieldTypeText(h.subsidiarystartdate5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiaryname6:' + getFieldTypeText(h.subsidiaryname6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiarystartdate6:' + getFieldTypeText(h.subsidiarystartdate6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiaryname7:' + getFieldTypeText(h.subsidiaryname7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiarystartdate7:' + getFieldTypeText(h.subsidiarystartdate7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiaryname8:' + getFieldTypeText(h.subsidiaryname8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiarystartdate8:' + getFieldTypeText(h.subsidiarystartdate8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiaryname9:' + getFieldTypeText(h.subsidiaryname9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiarystartdate9:' + getFieldTypeText(h.subsidiarystartdate9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiaryname10:' + getFieldTypeText(h.subsidiaryname10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subsidiarystartdate10:' + getFieldTypeText(h.subsidiarystartdate10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dartid_cnt
          ,le.populated_dateadded_cnt
          ,le.populated_dateupdated_cnt
          ,le.populated_website_cnt
          ,le.populated_state_cnt
          ,le.populated_lninscertrecordid_cnt
          ,le.populated_profilelastupdated_cnt
          ,le.populated_siid_cnt
          ,le.populated_sipstatuscode_cnt
          ,le.populated_wcbempnumber_cnt
          ,le.populated_ubinumber_cnt
          ,le.populated_cofanumber_cnt
          ,le.populated_usdotnumber_cnt
          ,le.populated_businessname_cnt
          ,le.populated_dba_cnt
          ,le.populated_addressline1_cnt
          ,le.populated_addressline2_cnt
          ,le.populated_addresscity_cnt
          ,le.populated_addressstate_cnt
          ,le.populated_addresszip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_phone1_cnt
          ,le.populated_phone2_cnt
          ,le.populated_phone3_cnt
          ,le.populated_fax1_cnt
          ,le.populated_fax2_cnt
          ,le.populated_email1_cnt
          ,le.populated_email2_cnt
          ,le.populated_businesstype_cnt
          ,le.populated_namefirst_cnt
          ,le.populated_namemiddle_cnt
          ,le.populated_namelast_cnt
          ,le.populated_namesuffix_cnt
          ,le.populated_nametitle_cnt
          ,le.populated_mailingaddress1_cnt
          ,le.populated_mailingaddress2_cnt
          ,le.populated_mailingaddresscity_cnt
          ,le.populated_mailingaddressstate_cnt
          ,le.populated_mailingaddresszip_cnt
          ,le.populated_mailingaddresszip4_cnt
          ,le.populated_contactnamefirst_cnt
          ,le.populated_contactnamemiddle_cnt
          ,le.populated_contactnamelast_cnt
          ,le.populated_contactnamesuffix_cnt
          ,le.populated_contactbusinessname_cnt
          ,le.populated_contactaddressline1_cnt
          ,le.populated_contactaddressline2_cnt
          ,le.populated_contactcity_cnt
          ,le.populated_contactstate_cnt
          ,le.populated_contactzip_cnt
          ,le.populated_contactzip4_cnt
          ,le.populated_contactphone_cnt
          ,le.populated_contactfax_cnt
          ,le.populated_contactemail_cnt
          ,le.populated_policyholdernamefirst_cnt
          ,le.populated_policyholdernamemiddle_cnt
          ,le.populated_policyholdernamelast_cnt
          ,le.populated_policyholdernamesuffix_cnt
          ,le.populated_statepolicyfilenumber_cnt
          ,le.populated_coverageinjuryillnessdate_cnt
          ,le.populated_selfinsurancegroup_cnt
          ,le.populated_selfinsurancegroupphone_cnt
          ,le.populated_selfinsurancegroupid_cnt
          ,le.populated_numberofemployees_cnt
          ,le.populated_licensedcontractor_cnt
          ,le.populated_mconame_cnt
          ,le.populated_mconumber_cnt
          ,le.populated_mcoaddressline1_cnt
          ,le.populated_mcoaddressline2_cnt
          ,le.populated_mcocity_cnt
          ,le.populated_mcostate_cnt
          ,le.populated_mcozip_cnt
          ,le.populated_mcozip4_cnt
          ,le.populated_mcophone_cnt
          ,le.populated_governingclasscode_cnt
          ,le.populated_licensenumber_cnt
          ,le.populated_class_cnt
          ,le.populated_classificationdescription_cnt
          ,le.populated_licensestatus_cnt
          ,le.populated_licenseadditionalinfo_cnt
          ,le.populated_licenseissuedate_cnt
          ,le.populated_licenseexpirationdate_cnt
          ,le.populated_naicscode_cnt
          ,le.populated_officerexemptfirstname1_cnt
          ,le.populated_officerexemptlastname1_cnt
          ,le.populated_officerexemptmiddlename1_cnt
          ,le.populated_officerexempttitle1_cnt
          ,le.populated_officerexempteffectivedate1_cnt
          ,le.populated_officerexemptterminationdate1_cnt
          ,le.populated_officerexempttype1_cnt
          ,le.populated_officerexemptbusinessactivities1_cnt
          ,le.populated_officerexemptfirstname2_cnt
          ,le.populated_officerexemptlastname2_cnt
          ,le.populated_officerexemptmiddlename2_cnt
          ,le.populated_officerexempttitle2_cnt
          ,le.populated_officerexempteffectivedate2_cnt
          ,le.populated_officerexemptterminationdate2_cnt
          ,le.populated_officerexempttype2_cnt
          ,le.populated_officerexemptbusinessactivities2_cnt
          ,le.populated_officerexemptfirstname3_cnt
          ,le.populated_officerexemptlastname3_cnt
          ,le.populated_officerexemptmiddlename3_cnt
          ,le.populated_officerexempttitle3_cnt
          ,le.populated_officerexempteffectivedate3_cnt
          ,le.populated_officerexemptterminationdate3_cnt
          ,le.populated_officerexempttype3_cnt
          ,le.populated_officerexemptbusinessactivities3_cnt
          ,le.populated_officerexemptfirstname4_cnt
          ,le.populated_officerexemptlastname4_cnt
          ,le.populated_officerexemptmiddlename4_cnt
          ,le.populated_officerexempttitle4_cnt
          ,le.populated_officerexempteffectivedate4_cnt
          ,le.populated_officerexemptterminationdate4_cnt
          ,le.populated_officerexempttype4_cnt
          ,le.populated_officerexemptbusinessactivities4_cnt
          ,le.populated_officerexemptfirstname5_cnt
          ,le.populated_officerexemptlastname5_cnt
          ,le.populated_officerexemptmiddlename5_cnt
          ,le.populated_officerexempttitle5_cnt
          ,le.populated_officerexempteffectivedate5_cnt
          ,le.populated_officerexemptterminationdate5_cnt
          ,le.populated_officerexempttype5_cnt
          ,le.populated_officerexemptbusinessactivities5_cnt
          ,le.populated_dba1_cnt
          ,le.populated_dbadatefrom1_cnt
          ,le.populated_dbadateto1_cnt
          ,le.populated_dbatype1_cnt
          ,le.populated_dba2_cnt
          ,le.populated_dbadatefrom2_cnt
          ,le.populated_dbadateto2_cnt
          ,le.populated_dbatype2_cnt
          ,le.populated_dba3_cnt
          ,le.populated_dbadatefrom3_cnt
          ,le.populated_dbadateto3_cnt
          ,le.populated_dbatype3_cnt
          ,le.populated_dba4_cnt
          ,le.populated_dbadatefrom4_cnt
          ,le.populated_dbadateto4_cnt
          ,le.populated_dbatype4_cnt
          ,le.populated_dba5_cnt
          ,le.populated_dbadatefrom5_cnt
          ,le.populated_dbadateto5_cnt
          ,le.populated_dbatype5_cnt
          ,le.populated_subsidiaryname1_cnt
          ,le.populated_subsidiarystartdate1_cnt
          ,le.populated_subsidiaryname2_cnt
          ,le.populated_subsidiarystartdate2_cnt
          ,le.populated_subsidiaryname3_cnt
          ,le.populated_subsidiarystartdate3_cnt
          ,le.populated_subsidiaryname4_cnt
          ,le.populated_subsidiarystartdate4_cnt
          ,le.populated_subsidiaryname5_cnt
          ,le.populated_subsidiarystartdate5_cnt
          ,le.populated_subsidiaryname6_cnt
          ,le.populated_subsidiarystartdate6_cnt
          ,le.populated_subsidiaryname7_cnt
          ,le.populated_subsidiarystartdate7_cnt
          ,le.populated_subsidiaryname8_cnt
          ,le.populated_subsidiarystartdate8_cnt
          ,le.populated_subsidiaryname9_cnt
          ,le.populated_subsidiarystartdate9_cnt
          ,le.populated_subsidiaryname10_cnt
          ,le.populated_subsidiarystartdate10_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dartid_pcnt
          ,le.populated_dateadded_pcnt
          ,le.populated_dateupdated_pcnt
          ,le.populated_website_pcnt
          ,le.populated_state_pcnt
          ,le.populated_lninscertrecordid_pcnt
          ,le.populated_profilelastupdated_pcnt
          ,le.populated_siid_pcnt
          ,le.populated_sipstatuscode_pcnt
          ,le.populated_wcbempnumber_pcnt
          ,le.populated_ubinumber_pcnt
          ,le.populated_cofanumber_pcnt
          ,le.populated_usdotnumber_pcnt
          ,le.populated_businessname_pcnt
          ,le.populated_dba_pcnt
          ,le.populated_addressline1_pcnt
          ,le.populated_addressline2_pcnt
          ,le.populated_addresscity_pcnt
          ,le.populated_addressstate_pcnt
          ,le.populated_addresszip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_phone1_pcnt
          ,le.populated_phone2_pcnt
          ,le.populated_phone3_pcnt
          ,le.populated_fax1_pcnt
          ,le.populated_fax2_pcnt
          ,le.populated_email1_pcnt
          ,le.populated_email2_pcnt
          ,le.populated_businesstype_pcnt
          ,le.populated_namefirst_pcnt
          ,le.populated_namemiddle_pcnt
          ,le.populated_namelast_pcnt
          ,le.populated_namesuffix_pcnt
          ,le.populated_nametitle_pcnt
          ,le.populated_mailingaddress1_pcnt
          ,le.populated_mailingaddress2_pcnt
          ,le.populated_mailingaddresscity_pcnt
          ,le.populated_mailingaddressstate_pcnt
          ,le.populated_mailingaddresszip_pcnt
          ,le.populated_mailingaddresszip4_pcnt
          ,le.populated_contactnamefirst_pcnt
          ,le.populated_contactnamemiddle_pcnt
          ,le.populated_contactnamelast_pcnt
          ,le.populated_contactnamesuffix_pcnt
          ,le.populated_contactbusinessname_pcnt
          ,le.populated_contactaddressline1_pcnt
          ,le.populated_contactaddressline2_pcnt
          ,le.populated_contactcity_pcnt
          ,le.populated_contactstate_pcnt
          ,le.populated_contactzip_pcnt
          ,le.populated_contactzip4_pcnt
          ,le.populated_contactphone_pcnt
          ,le.populated_contactfax_pcnt
          ,le.populated_contactemail_pcnt
          ,le.populated_policyholdernamefirst_pcnt
          ,le.populated_policyholdernamemiddle_pcnt
          ,le.populated_policyholdernamelast_pcnt
          ,le.populated_policyholdernamesuffix_pcnt
          ,le.populated_statepolicyfilenumber_pcnt
          ,le.populated_coverageinjuryillnessdate_pcnt
          ,le.populated_selfinsurancegroup_pcnt
          ,le.populated_selfinsurancegroupphone_pcnt
          ,le.populated_selfinsurancegroupid_pcnt
          ,le.populated_numberofemployees_pcnt
          ,le.populated_licensedcontractor_pcnt
          ,le.populated_mconame_pcnt
          ,le.populated_mconumber_pcnt
          ,le.populated_mcoaddressline1_pcnt
          ,le.populated_mcoaddressline2_pcnt
          ,le.populated_mcocity_pcnt
          ,le.populated_mcostate_pcnt
          ,le.populated_mcozip_pcnt
          ,le.populated_mcozip4_pcnt
          ,le.populated_mcophone_pcnt
          ,le.populated_governingclasscode_pcnt
          ,le.populated_licensenumber_pcnt
          ,le.populated_class_pcnt
          ,le.populated_classificationdescription_pcnt
          ,le.populated_licensestatus_pcnt
          ,le.populated_licenseadditionalinfo_pcnt
          ,le.populated_licenseissuedate_pcnt
          ,le.populated_licenseexpirationdate_pcnt
          ,le.populated_naicscode_pcnt
          ,le.populated_officerexemptfirstname1_pcnt
          ,le.populated_officerexemptlastname1_pcnt
          ,le.populated_officerexemptmiddlename1_pcnt
          ,le.populated_officerexempttitle1_pcnt
          ,le.populated_officerexempteffectivedate1_pcnt
          ,le.populated_officerexemptterminationdate1_pcnt
          ,le.populated_officerexempttype1_pcnt
          ,le.populated_officerexemptbusinessactivities1_pcnt
          ,le.populated_officerexemptfirstname2_pcnt
          ,le.populated_officerexemptlastname2_pcnt
          ,le.populated_officerexemptmiddlename2_pcnt
          ,le.populated_officerexempttitle2_pcnt
          ,le.populated_officerexempteffectivedate2_pcnt
          ,le.populated_officerexemptterminationdate2_pcnt
          ,le.populated_officerexempttype2_pcnt
          ,le.populated_officerexemptbusinessactivities2_pcnt
          ,le.populated_officerexemptfirstname3_pcnt
          ,le.populated_officerexemptlastname3_pcnt
          ,le.populated_officerexemptmiddlename3_pcnt
          ,le.populated_officerexempttitle3_pcnt
          ,le.populated_officerexempteffectivedate3_pcnt
          ,le.populated_officerexemptterminationdate3_pcnt
          ,le.populated_officerexempttype3_pcnt
          ,le.populated_officerexemptbusinessactivities3_pcnt
          ,le.populated_officerexemptfirstname4_pcnt
          ,le.populated_officerexemptlastname4_pcnt
          ,le.populated_officerexemptmiddlename4_pcnt
          ,le.populated_officerexempttitle4_pcnt
          ,le.populated_officerexempteffectivedate4_pcnt
          ,le.populated_officerexemptterminationdate4_pcnt
          ,le.populated_officerexempttype4_pcnt
          ,le.populated_officerexemptbusinessactivities4_pcnt
          ,le.populated_officerexemptfirstname5_pcnt
          ,le.populated_officerexemptlastname5_pcnt
          ,le.populated_officerexemptmiddlename5_pcnt
          ,le.populated_officerexempttitle5_pcnt
          ,le.populated_officerexempteffectivedate5_pcnt
          ,le.populated_officerexemptterminationdate5_pcnt
          ,le.populated_officerexempttype5_pcnt
          ,le.populated_officerexemptbusinessactivities5_pcnt
          ,le.populated_dba1_pcnt
          ,le.populated_dbadatefrom1_pcnt
          ,le.populated_dbadateto1_pcnt
          ,le.populated_dbatype1_pcnt
          ,le.populated_dba2_pcnt
          ,le.populated_dbadatefrom2_pcnt
          ,le.populated_dbadateto2_pcnt
          ,le.populated_dbatype2_pcnt
          ,le.populated_dba3_pcnt
          ,le.populated_dbadatefrom3_pcnt
          ,le.populated_dbadateto3_pcnt
          ,le.populated_dbatype3_pcnt
          ,le.populated_dba4_pcnt
          ,le.populated_dbadatefrom4_pcnt
          ,le.populated_dbadateto4_pcnt
          ,le.populated_dbatype4_pcnt
          ,le.populated_dba5_pcnt
          ,le.populated_dbadatefrom5_pcnt
          ,le.populated_dbadateto5_pcnt
          ,le.populated_dbatype5_pcnt
          ,le.populated_subsidiaryname1_pcnt
          ,le.populated_subsidiarystartdate1_pcnt
          ,le.populated_subsidiaryname2_pcnt
          ,le.populated_subsidiarystartdate2_pcnt
          ,le.populated_subsidiaryname3_pcnt
          ,le.populated_subsidiarystartdate3_pcnt
          ,le.populated_subsidiaryname4_pcnt
          ,le.populated_subsidiarystartdate4_pcnt
          ,le.populated_subsidiaryname5_pcnt
          ,le.populated_subsidiarystartdate5_pcnt
          ,le.populated_subsidiaryname6_pcnt
          ,le.populated_subsidiarystartdate6_pcnt
          ,le.populated_subsidiaryname7_pcnt
          ,le.populated_subsidiarystartdate7_pcnt
          ,le.populated_subsidiaryname8_pcnt
          ,le.populated_subsidiarystartdate8_pcnt
          ,le.populated_subsidiaryname9_pcnt
          ,le.populated_subsidiarystartdate9_pcnt
          ,le.populated_subsidiaryname10_pcnt
          ,le.populated_subsidiarystartdate10_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,163,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Cert_Delta(prevDS, PROJECT(h, Cert_Layout_Insurance_Cert));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),163,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Cert_Layout_Insurance_Cert) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Insurance_Cert, Cert_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
