//This is the code to execute in a builder window
#workunit('name','BIPV2_Relative.BWR_Hygiene - Hygiene & Stats - SALT V2.5 Gold');
IMPORT BIPV2_Relative,SALT25;
// First create an instantiated hygiene module
  h := BIPV2_Relative.Hygiene(BIPV2_Relative.In_DOT_Base);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(SALT25.MAC_Character_Counts.EclRecord(p,'Layout_DOT_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
