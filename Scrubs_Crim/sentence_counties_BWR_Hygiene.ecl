//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.sentence_counties_BWR_Hygiene - Hygiene & Stats - SALT V3.11.9');
IMPORT Scrubs_Crim,SALT311;
// First create an instantiated hygiene module
  infile := Scrubs_Crim.sentence_counties_In_crim;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Crim.sentence_counties_hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'sentence_counties_Layout_crim'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,recordid,Examples),NAMED('recordidByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,statecode,Examples),NAMED('statecodeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,caseid,Examples),NAMED('caseidByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentencedate,Examples),NAMED('sentencedateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentencebegindate,Examples),NAMED('sentencebegindateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentenceenddate,Examples),NAMED('sentenceenddateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentencetype,Examples),NAMED('sentencetypeByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentencemaxyears,Examples),NAMED('sentencemaxyearsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentencemaxmonths,Examples),NAMED('sentencemaxmonthsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentencemaxdays,Examples),NAMED('sentencemaxdaysByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentenceminyears,Examples),NAMED('sentenceminyearsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentenceminmonths,Examples),NAMED('sentenceminmonthsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentencemindays,Examples),NAMED('sentencemindaysByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,scheduledreleasedate,Examples),NAMED('scheduledreleasedateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,actualreleasedate,Examples),NAMED('actualreleasedateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentencestatus,Examples),NAMED('sentencestatusByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,timeservedyears,Examples),NAMED('timeservedyearsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,timeservedmonths,Examples),NAMED('timeservedmonthsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,timeserveddays,Examples),NAMED('timeserveddaysByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,publicservicehours,Examples),NAMED('publicservicehoursByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sentenceadditionalinfo,Examples),NAMED('sentenceadditionalinfoByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,communitysupervisioncounty,Examples),NAMED('communitysupervisioncountyByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,communitysupervisionyears,Examples),NAMED('communitysupervisionyearsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,communitysupervisionmonths,Examples),NAMED('communitysupervisionmonthsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,communitysupervisiondays,Examples),NAMED('communitysupervisiondaysByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,parolebegindate,Examples),NAMED('parolebegindateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,paroleenddate,Examples),NAMED('paroleenddateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,paroleeligibilitydate,Examples),NAMED('paroleeligibilitydateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,parolehearingdate,Examples),NAMED('parolehearingdateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,parolemaxyears,Examples),NAMED('parolemaxyearsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,parolemaxmonths,Examples),NAMED('parolemaxmonthsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,parolemaxdays,Examples),NAMED('parolemaxdaysByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,paroleminyears,Examples),NAMED('paroleminyearsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,paroleminmonths,Examples),NAMED('paroleminmonthsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,parolemindays,Examples),NAMED('parolemindaysByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,parolestatus,Examples),NAMED('parolestatusByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,paroleofficer,Examples),NAMED('paroleofficerByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,paroleoffcerphone,Examples),NAMED('paroleoffcerphoneByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,probationbegindate,Examples),NAMED('probationbegindateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,probationenddate,Examples),NAMED('probationenddateByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,probationmaxyears,Examples),NAMED('probationmaxyearsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,probationmaxmonths,Examples),NAMED('probationmaxmonthsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,probationmaxdays,Examples),NAMED('probationmaxdaysByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,probationminyears,Examples),NAMED('probationminyearsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,probationminmonths,Examples),NAMED('probationminmonthsByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,probationmindays,Examples),NAMED('probationmindaysByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,probationstatus,Examples),NAMED('probationstatusByvendor'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,vendor,sourcename,Examples),NAMED('sourcenameByvendor'));
