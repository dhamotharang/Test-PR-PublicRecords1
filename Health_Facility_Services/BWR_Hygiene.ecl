//This is the code to execute in a builder window
#workunit('name','Health_Facility_Services.BWR_Hygiene - Hygiene & Stats - SALT V2.9 Beta 1');
IMPORT Health_Facility_Services,SALT29;
// First create an instantiated hygiene module
  h := Health_Facility_Services.Hygiene(Health_Facility_Services.File_HealthFacility);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(SALT29.MAC_Character_Counts.EclRecord(p,'Layout_HealthFacility'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT29.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // LNPID consistency module
  CM := Health_Facility_Services.Fields.UIDConsistency(Health_Facility_Services.File_HealthFacility);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
