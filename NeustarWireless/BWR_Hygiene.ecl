//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','NeustarWireless.BWR_Hygiene - Hygiene & Stats - SALT V3.11.4');
IMPORT NeustarWireless,SALT311;
// First create an instantiated hygiene module
  infile := NeustarWireless.In_MAIN;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := NeustarWireless.hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Layout_MAIN'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
