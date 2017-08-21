//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_dev2.BWR_Hygiene - Hygiene & Stats - SALT V2.7 Alpha 5');
IMPORT BIPV2_ProxID_dev2,SALT27;
// First create an instantiated hygiene module
  h := BIPV2_ProxID_dev2.Hygiene(BIPV2_ProxID_dev2.In_DOT_Base);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(SALT27.MAC_Character_Counts.EclRecord(p,'Layout_DOT_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
