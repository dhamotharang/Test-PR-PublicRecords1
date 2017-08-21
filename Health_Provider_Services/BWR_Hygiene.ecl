//This is the code to execute in a builder window
#workunit('name','Health_Provider_Services.BWR_Hygiene - Hygiene & Stats - SALT V2.8 Gold SR1');
IMPORT Health_Provider_Services,SALT28;
// First create an instantiated hygiene module
  h := Health_Provider_Services.Hygiene(Health_Provider_Services.File_HealthProvider);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(SALT28.MAC_Character_Counts.EclRecord(p,'Layout_HealthProvider'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.923460240f your data. Change to 100 to match all your data
  OUTPUT(SALT28.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // LNPID consistency module
  CM := Health_Provider_Services.Fields.UIDConsistency(Health_Provider_Services.In_HealthProvider);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
