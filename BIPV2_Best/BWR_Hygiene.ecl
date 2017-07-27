//This is the code to execute in a builder window
#workunit('name','BIPV2_Best.BWR_Hygiene - Hygiene & Stats - SALT V2.4 Gold');
IMPORT BIPV2_Best,SALT24;
// First create an instantiated hygiene module
  h := BIPV2_Best.Hygiene(BIPV2_Best.In_Base);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT24.MAC_Character_Counts.EclRecord(p,'Layout_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
