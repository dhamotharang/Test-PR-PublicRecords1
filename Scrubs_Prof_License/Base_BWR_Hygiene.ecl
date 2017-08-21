//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Prof_License.Base_BWR_Hygiene - Hygiene & Stats - SALT V3.7.1');
IMPORT Scrubs_Prof_License,SALT37;
// First create an instantiated hygiene module
  infile := Scrubs_Prof_License.Base_In_Prof_License;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Prof_License.Base_Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT37.MAC_Character_Counts.EclRecord(p,'Layout_Prof_License'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT37.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT37.MAC_CrossTab
