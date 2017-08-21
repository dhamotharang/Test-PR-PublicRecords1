//This is the code to execute in a builder window
#workunit('name','BIPV2_Best_test6.BWR_Hygiene - Hygiene & Stats - SALT V2.7 Beta 1');
IMPORT BIPV2_Best_test6,SALT27;
// First create an instantiated hygiene module
  h := BIPV2_Best_test6.Hygiene(BIPV2_Best_test6.In_Base);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT27.MAC_Character_Counts.EclRecord(p,'Layout_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
