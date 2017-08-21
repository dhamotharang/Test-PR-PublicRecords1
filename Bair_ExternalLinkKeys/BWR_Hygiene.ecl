//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Bair_ExternalLinkKeys.BWR_Hygiene - Hygiene & Stats - SALT V3.3.0');
IMPORT Bair_ExternalLinkKeys,SALT33;
// First create an instantiated hygiene module
  infile := Bair_ExternalLinkKeys.File_Classify_PS;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Bair_ExternalLinkKeys.Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(SALT33.MAC_Character_Counts.EclRecord(p,'Layout_Classify_PS'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT33.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of EID_HASH *******
  // EID_HASH consistency module
  CM := Bair_ExternalLinkKeys.Fields.UIDConsistency(Bair_ExternalLinkKeys.File_Classify_PS);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT33.MAC_CrossTab
