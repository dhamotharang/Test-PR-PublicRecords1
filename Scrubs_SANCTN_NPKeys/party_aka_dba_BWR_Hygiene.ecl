//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SANCTN_NPKeys.party_aka_dba_BWR_Hygiene - Hygiene & Stats - SALT V3.11.9');
IMPORT Scrubs_SANCTN_NPKeys,SALT311;
// First create an instantiated hygiene module
  infile := Scrubs_SANCTN_NPKeys.party_aka_dba_In_SANCTN_NPKeys;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_SANCTN_NPKeys.party_aka_dba_hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'party_aka_dba_Layout_SANCTN_NPKeys'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,dbcode,batch,Examples),NAMED('batchBydbcode'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,dbcode,incident_num,Examples),NAMED('incident_numBydbcode'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,dbcode,party_num,Examples),NAMED('party_numBydbcode'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,dbcode,name_type,Examples),NAMED('name_typeBydbcode'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,dbcode,first_name,Examples),NAMED('first_nameBydbcode'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,dbcode,middle_name,Examples),NAMED('middle_nameBydbcode'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,dbcode,last_name,Examples),NAMED('last_nameBydbcode'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,dbcode,aka_dba_text,Examples),NAMED('aka_dba_textBydbcode'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,dbcode,party_key,Examples),NAMED('party_keyBydbcode'));
