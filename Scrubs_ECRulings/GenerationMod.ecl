// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_ECRulings';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'ECRulings';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dartid,dateadded,dateupdated,website,state,euid,policyarea,casenumber,memberstate,lastdecisiondate,title,businessname,region,primaryobjective,aidinstrument,casetype,durationdatefrom,durationdateto,notificationregistrationdate,dgresponsible,relatedcasenumber1,relatedcaseinformation1,relatedcasenumber2,relatedcaseinformation2,relatedcasenumber3,relatedcaseinformation3,relatedcasenumber4,relatedcaseinformation4,relatedcasenumber5,relatedcaseinformation5,provisionaldeadlinedate,provisionaldeadlinearticle,provisionaldeadlinestatus,regulation,relatedlink,decpubid,decisiondate,decisionarticle,decisiondetails,pressrelease,pressreleasedate,publicationjournaldate,publicationjournal,publicationjournaledition,publicationjournalyear,publicationpriorjournal,publicationpriorjournaldate,econactid,economicactivity,compeventid,eventdate,eventdoctype,eventdocument,did,bdid,dt_vendor_first_reported,dt_vendor_last_reported,dt_first_seen,dt_last_seen,eu_country_code';
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
    + 'MODULE:Scrubs_ECRulings\n'
    + 'FILENAME:ECRulings\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + '\n'
    + '\n'
    + 'FIELD:dartid:TYPE(STRING):0,0\n'
    + 'FIELD:dateadded:TYPE(STRING):0,0\n'
    + 'FIELD:dateupdated:TYPE(STRING):0,0\n'
    + 'FIELD:website:TYPE(STRING):0,0\n'
    + 'FIELD:state:TYPE(STRING):0,0\n'
    + 'FIELD:euid:TYPE(STRING):0,0\n'
    + 'FIELD:policyarea:TYPE(STRING):0,0\n'
    + 'FIELD:casenumber:TYPE(STRING):0,0\n'
    + 'FIELD:memberstate:TYPE(STRING):0,0\n'
    + 'FIELD:lastdecisiondate:TYPE(STRING):0,0\n'
    + 'FIELD:title:TYPE(STRING):0,0\n'
    + 'FIELD:businessname:TYPE(STRING):0,0\n'
    + 'FIELD:region:TYPE(STRING):0,0\n'
    + 'FIELD:primaryobjective:TYPE(STRING):0,0\n'
    + 'FIELD:aidinstrument:TYPE(STRING):0,0\n'
    + 'FIELD:casetype:TYPE(STRING):0,0\n'
    + 'FIELD:durationdatefrom:TYPE(STRING):0,0\n'
    + 'FIELD:durationdateto:TYPE(STRING):0,0\n'
    + 'FIELD:notificationregistrationdate:TYPE(STRING):0,0\n'
    + 'FIELD:dgresponsible:TYPE(STRING):0,0\n'
    + 'FIELD:relatedcasenumber1:TYPE(STRING):0,0\n'
    + 'FIELD:relatedcaseinformation1:TYPE(STRING):0,0\n'
    + 'FIELD:relatedcasenumber2:TYPE(STRING):0,0\n'
    + 'FIELD:relatedcaseinformation2:TYPE(STRING):0,0\n'
    + 'FIELD:relatedcasenumber3:TYPE(STRING):0,0\n'
    + 'FIELD:relatedcaseinformation3:TYPE(STRING):0,0\n'
    + 'FIELD:relatedcasenumber4:TYPE(STRING):0,0\n'
    + 'FIELD:relatedcaseinformation4:TYPE(STRING):0,0\n'
    + 'FIELD:relatedcasenumber5:TYPE(STRING):0,0\n'
    + 'FIELD:relatedcaseinformation5:TYPE(STRING):0,0\n'
    + 'FIELD:provisionaldeadlinedate:TYPE(STRING):0,0\n'
    + 'FIELD:provisionaldeadlinearticle:TYPE(STRING):0,0\n'
    + 'FIELD:provisionaldeadlinestatus:TYPE(STRING):0,0\n'
    + 'FIELD:regulation:TYPE(STRING):0,0\n'
    + 'FIELD:relatedlink:TYPE(STRING):0,0\n'
    + 'FIELD:decpubid:TYPE(STRING):0,0\n'
    + 'FIELD:decisiondate:TYPE(STRING):0,0\n'
    + 'FIELD:decisionarticle:TYPE(STRING):0,0\n'
    + 'FIELD:decisiondetails:TYPE(STRING):0,0\n'
    + 'FIELD:pressrelease:TYPE(STRING):0,0\n'
    + 'FIELD:pressreleasedate:TYPE(STRING):0,0\n'
    + 'FIELD:publicationjournaldate:TYPE(STRING):0,0\n'
    + 'FIELD:publicationjournal:TYPE(STRING):0,0\n'
    + 'FIELD:publicationjournaledition:TYPE(STRING):0,0\n'
    + 'FIELD:publicationjournalyear:TYPE(STRING):0,0\n'
    + 'FIELD:publicationpriorjournal:TYPE(STRING):0,0\n'
    + 'FIELD:publicationpriorjournaldate:TYPE(STRING):0,0\n'
    + 'FIELD:econactid:TYPE(STRING):0,0\n'
    + 'FIELD:economicactivity:TYPE(STRING):0,0\n'
    + 'FIELD:compeventid:TYPE(STRING):0,0\n'
    + 'FIELD:eventdate:TYPE(STRING):0,0\n'
    + 'FIELD:eventdoctype:TYPE(STRING):0,0\n'
    + 'FIELD:eventdocument:TYPE(STRING):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(STRING):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(STRING):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(STRING):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(STRING):0,0\n'
    + 'FIELD:eu_country_code:TYPE(STRING):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

