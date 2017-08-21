//This is the code to execute in a builder window
#workunit('name','BIPV2_WAF.BWR_Hygiene - Hygiene & Stats - SALT V2.9 Beta 3');
IMPORT BIPV2_WAF,SALT29;
// First create an instantiated hygiene module
  h := BIPV2_WAF.Hygiene(BIPV2_WAF.File_BizHead);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT29.MAC_Character_Counts.EclRecord(p,'Layout_BizHead'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT29.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // proxid consistency module
  CM := BIPV2_WAF.Fields.UIDConsistency(BIPV2_WAF.File_BizHead);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.proxid_Unbased,NAMED('Unbasedproxid'));
//  OUTPUT(CM.seleid_Unbased,NAMED('Unbasedseleid'));
//  OUTPUT(CM.orgid_Unbased,NAMED('Unbasedorgid'));
//  OUTPUT(CM.ultid_Unbased,NAMED('Unbasedultid'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.rcid_TwoParents,NAMED('Twoparentsrcid'));
//  OUTPUT(CM.proxid_TwoParents,NAMED('Twoparentsproxid'));
//  OUTPUT(CM.seleid_TwoParents,NAMED('Twoparentsseleid'));
//  OUTPUT(CM.orgid_TwoParents,NAMED('Twoparentsorgid'));
