// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.3';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'scrubs_Fed_Bureau_Prisons';
  EXPORT spc_NAMESCOPE := 'raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Fed_Bureau_Prisons';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,recordid,sourcename,sourcetype,statecode,recordtype,recorduploaddate,docnumber,fbinumber,stateidnumber,inmatenumber,aliennumber,orig_ssn,nametype,name,lastname,firstname,middlename,suffix,defendantstatus,defendantadditionalinfo,dob,birthcity,birthplace,age,gender,height,weight,haircolor,eyecolor,race,ethnicity,skincolor,bodymarks,physicalbuild,photoname,dlnumber,dlstate,phone,phonetype,uscitizenflag,addresstype,street,unit,city,orig_state,orig_zip,county,institutionname,institutiondetails,institutionreceiptdate,releasetolocation,releasetodetails,deceasedflag,deceaseddate,healthflag,healthdesc,bloodtype,sexoffenderregistrydate,sexoffenderregexpirationdate,sexoffenderregistrynumber,sourceid,caseid,casenumber,casetitle,casetype,casestatus,casestatusdate,casecomments,fileddate,caseinfo,docketnumber,offensecode,offensedesc,offensedate,offensetype,offensedegree,offenseclass,dispositionstatus,dispositionstatusdate,disposition,dispositiondate,offenselocation,finaloffense,finaloffensedate,offensecount,victimunder18,prioroffenseflag,initialplea,initialpleadate,finalruling,finalrulingdate,appealstatus,appealdate,courtname,fineamount,courtfee,restitution,trialtype,courtdate,classification_code,sub_classification_code,state,zip,sourceid2,sentencedate,sentencebegindate,sentenceenddate,sentencetype,sentencemaxyears,sentencemaxmonths,sentencemaxdays,sentenceminyears,sentenceminmonths,sentencemindays,scheduledreleasedate,actualreleasedate,sentencestatus,timeservedyears,timeservedmonths,timeserveddays,publicservicehours,sentenceadditionalinfo,communitysupervisioncounty,communitysupervisionyears,communitysupervisionmonths,communitysupervisiondays,parolebegindate,paroleenddate,paroleeligibilitydate,parolehearingdate,parolemaxyears,parolemaxmonths,parolemaxdays,paroleminyears,paroleminmonths,parolemindays,parolestatus,paroleofficer,paroleoffcerphone,probationbegindate,probationenddate,probationmaxyears,probationmaxmonths,probationmaxdays,probationminyears,probationminmonths,probationmindays,probationstatus';
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
    '\n'
    + '\n'
    + '\n'
    + 'OPTIONS:-gh\n'
    + 'MODULE:scrubs_Fed_Bureau_Prisons\n'
    + 'FILENAME:Fed_Bureau_Prisons       \n'
    + 'NAMESCOPE:raw\n'
    + '//SOURCEFIELD:source\n'
    + '\n'
    + '//***set FIELDTYPE\n'
    + '\n'
    + 'FIELDTYPE:invalid_orig_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ, -\')  \n'
    + 'FIELDTYPE:invalid_orig_parsed_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -\')  \n'
    + '\n'
    + 'FIELDTYPE:invalid_race:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_number:ALLOW(0123456789) \n'
    + '\n'
    + '\n'
    + '//***set FIELD\n'
    + 'FIELD:recordid:TYPE(STRING40):0,0\n'
    + 'FIELD:sourcename:TYPE(STRING100):0,0\n'
    + 'FIELD:sourcetype:TYPE(STRING20):0,0\n'
    + 'FIELD:statecode:TYPE(STRING2):0,0\n'
    + 'FIELD:recordtype:TYPE(STRING20):0,0\n'
    + 'FIELD:recorduploaddate:TYPE(STRING8):0,0\n'
    + 'FIELD:docnumber:TYPE(STRING20):0,0\n'
    + 'FIELD:fbinumber:TYPE(STRING20):0,0\n'
    + 'FIELD:stateidnumber:TYPE(STRING20):0,0\n'
    + 'FIELD:inmatenumber:TYPE(STRING20):0,0\n'
    + 'FIELD:aliennumber:TYPE(STRING20):0,0\n'
    + 'FIELD:orig_ssn:TYPE(STRING9):0,0\n'
    + 'FIELD:nametype:TYPE(STRING1):0,0\n'
    + 'FIELD:name:LIKE(invalid_orig_name):TYPE(STRING115):0,0            // apply rule    \n'
    + 'FIELD:lastname:LIKE(invalid_orig_parsed_name):TYPE(STRING50):0,0  // apply rule \n'
    + 'FIELD:firstname:LIKE(invalid_orig_parsed_name):TYPE(STRING50):0,0 // apply rule \n'
    + 'FIELD:middlename:LIKE(invalid_orig_parsed_name):TYPE(STRING40):0,0 // apply rule \n'
    + 'FIELD:suffix:LIKE(invalid_orig_parsed_name):TYPE(STRING15):0,0  // apply rule \n'
    + 'FIELD:defendantstatus:TYPE(STRING100):0,0\n'
    + 'FIELD:defendantadditionalinfo:TYPE(STRING200):0,0\n'
    + 'FIELD:dob:LIKE(invalid_number):TYPE(STRING8):0,0  // apply rule \n'
    + 'FIELD:birthcity:TYPE(STRING50):0,0\n'
    + 'FIELD:birthplace:TYPE(STRING100):0,0\n'
    + 'FIELD:age:LIKE(invalid_number):TYPE(STRING3):0,0 // apply rule \n'
    + 'FIELD:gender:TYPE(STRING10):LIKE(invalid_alpha):0,0 // apply rule \n'
    + 'FIELD:height:TYPE(STRING10):0,0\n'
    + 'FIELD:weight:TYPE(STRING10):0,0\n'
    + 'FIELD:haircolor:TYPE(STRING10):0,0\n'
    + 'FIELD:eyecolor:TYPE(STRING10):0,0\n'
    + 'FIELD:race:TYPE(STRING50):LIKE(invalid_race):0,0 // apply rule \n'
    + 'FIELD:ethnicity:TYPE(STRING20):0,0\n'
    + 'FIELD:skincolor:TYPE(STRING10):0,0\n'
    + 'FIELD:bodymarks:TYPE(STRING100):0,0\n'
    + 'FIELD:physicalbuild:TYPE(STRING20):0,0\n'
    + 'FIELD:photoname:TYPE(STRING50):0,0\n'
    + 'FIELD:dlnumber:TYPE(STRING20):0,0\n'
    + 'FIELD:dlstate:TYPE(STRING2):0,0\n'
    + 'FIELD:phone:TYPE(STRING20):0,0\n'
    + 'FIELD:phonetype:TYPE(STRING10):0,0\n'
    + 'FIELD:uscitizenflag:TYPE(STRING1):0,0\n'
    + 'FIELD:addresstype:TYPE(STRING20):0,0\n'
    + 'FIELD:street:TYPE(STRING150):0,0\n'
    + 'FIELD:unit:TYPE(STRING20):0,0\n'
    + 'FIELD:city:TYPE(STRING50):0,0\n'
    + 'FIELD:orig_state:TYPE(STRING2):0,0\n'
    + 'FIELD:orig_zip:TYPE(STRING9):0,0\n'
    + 'FIELD:county:TYPE(STRING50):0,0\n'
    + 'FIELD:institutionname:TYPE(STRING100):0,0\n'
    + 'FIELD:institutiondetails:TYPE(STRING200):0,0\n'
    + 'FIELD:institutionreceiptdate:TYPE(STRING8):0,0\n'
    + 'FIELD:releasetolocation:TYPE(STRING100):0,0\n'
    + 'FIELD:releasetodetails:TYPE(STRING200):0,0\n'
    + 'FIELD:deceasedflag:TYPE(STRING1):0,0\n'
    + 'FIELD:deceaseddate:TYPE(STRING8):0,0\n'
    + 'FIELD:healthflag:TYPE(STRING1):0,0\n'
    + 'FIELD:healthdesc:TYPE(STRING100):0,0\n'
    + 'FIELD:bloodtype:TYPE(STRING10):0,0\n'
    + 'FIELD:sexoffenderregistrydate:TYPE(STRING8):0,0\n'
    + 'FIELD:sexoffenderregexpirationdate:TYPE(STRING8):0,0\n'
    + 'FIELD:sexoffenderregistrynumber:TYPE(STRING100):0,0\n'
    + 'FIELD:sourceid:TYPE(STRING20):0,0\n'
    + 'FIELD:caseid:TYPE(STRING40):0,0\n'
    + 'FIELD:casenumber:TYPE(STRING50):0,0\n'
    + 'FIELD:casetitle:TYPE(STRING100):0,0\n'
    + 'FIELD:casetype:TYPE(STRING20):0,0\n'
    + 'FIELD:casestatus:TYPE(STRING100):0,0\n'
    + 'FIELD:casestatusdate:TYPE(STRING8):0,0\n'
    + 'FIELD:casecomments:TYPE(STRING200):0,0\n'
    + 'FIELD:fileddate:TYPE(STRING8):0,0\n'
    + 'FIELD:caseinfo:TYPE(STRING100):0,0\n'
    + 'FIELD:docketnumber:TYPE(STRING30):0,0\n'
    + 'FIELD:offensecode:TYPE(STRING30):0,0\n'
    + 'FIELD:offensedesc:TYPE(STRING100):0,0\n'
    + 'FIELD:offensedate:TYPE(STRING8):0,0\n'
    + 'FIELD:offensetype:TYPE(STRING100):0,0\n'
    + 'FIELD:offensedegree:TYPE(STRING20):0,0\n'
    + 'FIELD:offenseclass:TYPE(STRING20):0,0\n'
    + 'FIELD:dispositionstatus:TYPE(STRING100):0,0\n'
    + 'FIELD:dispositionstatusdate:TYPE(STRING8):0,0\n'
    + 'FIELD:disposition:TYPE(STRING150):0,0\n'
    + 'FIELD:dispositiondate:TYPE(STRING8):0,0\n'
    + 'FIELD:offenselocation:TYPE(STRING50):0,0\n'
    + 'FIELD:finaloffense:TYPE(STRING100):0,0\n'
    + 'FIELD:finaloffensedate:TYPE(STRING8):0,0\n'
    + 'FIELD:offensecount:TYPE(STRING4):0,0\n'
    + 'FIELD:victimunder18:TYPE(STRING1):0,0\n'
    + 'FIELD:prioroffenseflag:TYPE(STRING1):0,0\n'
    + 'FIELD:initialplea:TYPE(STRING20):0,0\n'
    + 'FIELD:initialpleadate:TYPE(STRING8):0,0\n'
    + 'FIELD:finalruling:TYPE(STRING20):0,0\n'
    + 'FIELD:finalrulingdate:TYPE(STRING8):0,0\n'
    + 'FIELD:appealstatus:TYPE(STRING50):0,0\n'
    + 'FIELD:appealdate:TYPE(STRING8):0,0\n'
    + 'FIELD:courtname:TYPE(STRING50):0,0\n'
    + 'FIELD:fineamount:TYPE(STRING10):0,0\n'
    + 'FIELD:courtfee:TYPE(STRING10):0,0\n'
    + 'FIELD:restitution:TYPE(STRING10):0,0\n'
    + 'FIELD:trialtype:TYPE(STRING20):0,0\n'
    + 'FIELD:courtdate:TYPE(STRING8):0,0\n'
    + 'FIELD:classification_code:TYPE(STRING):0,0\n'
    + 'FIELD:sub_classification_code:TYPE(STRING):0,0\n'
    + 'FIELD:state:TYPE(STRING):0,0\n'
    + 'FIELD:zip:TYPE(STRING):0,0\n'
    + 'FIELD:sourceid2:TYPE(STRING):0,0\n'
    + 'FIELD:sentencedate:TYPE(STRING8):0,0\n'
    + 'FIELD:sentencebegindate:TYPE(STRING8):0,0\n'
    + 'FIELD:sentenceenddate:TYPE(STRING8):0,0\n'
    + 'FIELD:sentencetype:TYPE(STRING20):0,0\n'
    + 'FIELD:sentencemaxyears:TYPE(STRING10):0,0\n'
    + 'FIELD:sentencemaxmonths:TYPE(STRING10):0,0\n'
    + 'FIELD:sentencemaxdays:TYPE(STRING10):0,0\n'
    + 'FIELD:sentenceminyears:TYPE(STRING10):0,0\n'
    + 'FIELD:sentenceminmonths:TYPE(STRING10):0,0\n'
    + 'FIELD:sentencemindays:TYPE(STRING10):0,0\n'
    + 'FIELD:scheduledreleasedate:TYPE(STRING8):0,0\n'
    + 'FIELD:actualreleasedate:TYPE(STRING8):0,0\n'
    + 'FIELD:sentencestatus:TYPE(STRING100):0,0\n'
    + 'FIELD:timeservedyears:TYPE(STRING10):0,0\n'
    + 'FIELD:timeservedmonths:TYPE(STRING10):0,0\n'
    + 'FIELD:timeserveddays:TYPE(STRING10):0,0\n'
    + 'FIELD:publicservicehours:TYPE(STRING10):0,0\n'
    + 'FIELD:sentenceadditionalinfo:TYPE(STRING200):0,0\n'
    + 'FIELD:communitysupervisioncounty:TYPE(STRING50):0,0\n'
    + 'FIELD:communitysupervisionyears:TYPE(STRING10):0,0\n'
    + 'FIELD:communitysupervisionmonths:TYPE(STRING10):0,0\n'
    + 'FIELD:communitysupervisiondays:TYPE(STRING10):0,0\n'
    + 'FIELD:parolebegindate:TYPE(STRING8):0,0\n'
    + 'FIELD:paroleenddate:TYPE(STRING8):0,0\n'
    + 'FIELD:paroleeligibilitydate:TYPE(STRING8):0,0\n'
    + 'FIELD:parolehearingdate:TYPE(STRING8):0,0\n'
    + 'FIELD:parolemaxyears:TYPE(STRING10):0,0\n'
    + 'FIELD:parolemaxmonths:TYPE(STRING10):0,0\n'
    + 'FIELD:parolemaxdays:TYPE(STRING10):0,0\n'
    + 'FIELD:paroleminyears:TYPE(STRING10):0,0\n'
    + 'FIELD:paroleminmonths:TYPE(STRING10):0,0\n'
    + 'FIELD:parolemindays:TYPE(STRING10):0,0\n'
    + 'FIELD:parolestatus:TYPE(STRING100):0,0\n'
    + 'FIELD:paroleofficer:TYPE(STRING50):0,0\n'
    + 'FIELD:paroleoffcerphone:TYPE(STRING20):0,0\n'
    + 'FIELD:probationbegindate:TYPE(STRING8):0,0\n'
    + 'FIELD:probationenddate:TYPE(STRING8):0,0\n'
    + 'FIELD:probationmaxyears:TYPE(STRING10):0,0\n'
    + 'FIELD:probationmaxmonths:TYPE(STRING10):0,0\n'
    + 'FIELD:probationmaxdays:TYPE(STRING10):0,0\n'
    + 'FIELD:probationminyears:TYPE(STRING10):0,0\n'
    + 'FIELD:probationminmonths:TYPE(STRING10):0,0\n'
    + 'FIELD:probationmindays:TYPE(STRING10):0,0\n'
    + 'FIELD:probationstatus:TYPE(STRING100):0,0\n'
    + '\n'
    + '\n'
    + '\n'
    + '\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

