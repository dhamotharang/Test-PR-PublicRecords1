//This is the code to execute in a builder window
#workunit('name','scrubs_FIDO.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Alpha 5');
IMPORT scrubs_FIDO,SALT30;
// First create an instantiated hygiene module
  infile := scrubs_FIDO.In_FIDO;
  h := scrubs_FIDO.Hygiene(infile);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_FIDO'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
