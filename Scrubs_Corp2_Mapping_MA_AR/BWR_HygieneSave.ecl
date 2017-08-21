//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_MA_AR.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Gold');
IMPORT Scrubs_Corp2_Mapping_MA_AR,SALT30;
// First create an instantiated hygiene module
  h := Scrubs_Corp2_Mapping_MA_AR.Hygiene(Scrubs_Corp2_Mapping_MA_AR.In_MA);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
 //OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  //OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Corp2_Mapping.LayoutsCommon.AR'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
