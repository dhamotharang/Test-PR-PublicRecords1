//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_MI_Main.BWR_Hygiene - Hygiene & Stats - SALT V3.11.1');
IMPORT Scrubs_Corp2_Mapping_MI_Main,SALT311;
// First create an instantiated hygiene module
  infile := Scrubs_Corp2_Mapping_MI_Main.In_In_MI;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Corp2_Mapping_MI_Main.hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Layout_In_MI'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
