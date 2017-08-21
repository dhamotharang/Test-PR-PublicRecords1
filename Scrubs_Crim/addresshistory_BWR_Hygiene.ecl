//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.addresshistory_BWR_Hygiene - Hygiene & Stats - SALT V3.3.2');
IMPORT Scrubs_Crim,SALT33;
// First create an instantiated hygiene module
  infile := Scrubs_Crim.addresshistory_In_crim;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Crim.addresshistory_Hygiene(ip);
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
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,street,Examples),NAMED('streetByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,unit,Examples),NAMED('unitByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,city,Examples),NAMED('cityByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,orig_state,Examples),NAMED('orig_stateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,orig_zip,Examples),NAMED('orig_zipByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,addresstype,Examples),NAMED('addresstypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourcename,Examples),NAMED('sourcenameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourceid,Examples),NAMED('sourceidByvendor'));
