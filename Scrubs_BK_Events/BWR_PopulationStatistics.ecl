//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BK_Events.BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_BK_Events,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_BK_Events.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dractivitytypecode_field */,/* docketentryid_field */,/* courtid_field */,/* casekey_field */,/* casetype_field */,/* bkcasenumber_field */,/* bkcasenumberurl_field */,/* proceedingscasenumber_field */,/* proceedingscasenumberurl_field */,/* caseid_field */,/* pacercaseid_field */,/* attachmenturl_field */,/* entrynumber_field */,/* entereddate_field */,/* pacer_entereddate_field */,/* fileddate_field */,/* score_field */,/* drcategoryeventid_field */,/* court_code_field */,/* district_field */,/* boca_court_field */,/* catevent_description_field */,/* catevent_category_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
