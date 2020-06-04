//This is the code to execute in a builder window
#workunit('name','BIPV2_POWID_DOWN_Platform.BWR_Hygiene - Hygiene & Stats - SALT V2.7 Gold');
IMPORT BIPV2_POWID_DOWN_Platform,SALT27;
// First create an instantiated hygiene module
  h := BIPV2_POWID_DOWN_Platform.Hygiene(BIPV2_POWID_DOWN_Platform.In_POWID_Down);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.AllOutliers,NAMED('SrcOutliers'),ALL); // One source behaves differently to the others
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT27.MAC_Character_Counts.EclRecord(p,'Layout_POWID_Down'),NAMED('OptimizedLayout'));// File layout suggested by data
