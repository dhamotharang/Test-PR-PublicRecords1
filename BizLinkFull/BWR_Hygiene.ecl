//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull.BWR_Hygiene - Hygiene & Stats - SALT V3.7.2');
IMPORT BizLinkFull,SALT37;
// First create an instantiated hygiene module
  infile := BizLinkFull.File_BizHead;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := BizLinkFull.Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(SALT37.MAC_Character_Counts.EclRecord(p,'Layout_BizHead'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT37.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of proxid *******
  // proxid consistency module
  CM := BizLinkFull.Fields.UIDConsistency(BizLinkFull.File_BizHead);
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
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT37.MAC_CrossTab
