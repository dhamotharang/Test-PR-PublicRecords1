//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.priors_doc_BWR_Hygiene - Hygiene & Stats - SALT V3.3.2');
IMPORT Scrubs_Crim,SALT33;
// First create an instantiated hygiene module
  infile := Scrubs_Crim.priors_doc_In_crim;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Crim.priors_doc_Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT33.MAC_Character_Counts.EclRecord(p,'Layout_crim'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT33.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT33.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,recordid,Examples),NAMED('recordidByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,statecode,Examples),NAMED('statecodeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,caseid,Examples),NAMED('caseidByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,casenumber,Examples),NAMED('casenumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensedesc,Examples),NAMED('offensedescByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensedate,Examples),NAMED('offensedateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensetype,Examples),NAMED('offensetypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offensedegree,Examples),NAMED('offensedegreeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,offenseclass,Examples),NAMED('offenseclassByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,disposition,Examples),NAMED('dispositionByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,dispositiondate,Examples),NAMED('dispositiondateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentencedate,Examples),NAMED('sentencedateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentencebegindate,Examples),NAMED('sentencebegindateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentenceenddate,Examples),NAMED('sentenceenddateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentencetype,Examples),NAMED('sentencetypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentencemaxyears,Examples),NAMED('sentencemaxyearsByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentencemaxmonths,Examples),NAMED('sentencemaxmonthsByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentencemaxdays,Examples),NAMED('sentencemaxdaysByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentenceminyears,Examples),NAMED('sentenceminyearsByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentenceminmonths,Examples),NAMED('sentenceminmonthsByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentencemindays,Examples),NAMED('sentencemindaysByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,scheduledreleasedate,Examples),NAMED('scheduledreleasedateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,actualreleasedate,Examples),NAMED('actualreleasedateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sentencestatus,Examples),NAMED('sentencestatusByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,communitysupervisioncounty,Examples),NAMED('communitysupervisioncountyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,communitysupervisionyears,Examples),NAMED('communitysupervisionyearsByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,communitysupervisionmonths,Examples),NAMED('communitysupervisionmonthsByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,communitysupervisiondays,Examples),NAMED('communitysupervisiondaysByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourcename,Examples),NAMED('sourcenameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourceid,Examples),NAMED('sourceidByvendor'));
