//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_POWID_Down.BWR_Hygiene - Hygiene & Stats - SALT V3.5.2');
IMPORT BIPV2_POWID_Down,SALT35;
// First create an instantiated hygiene module
  infile := BIPV2_POWID_Down.In_POWID_Down;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := BIPV2_POWID_Down.Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  PARALLEL(OUTPUT(h.AllUnusuallyFrequentOutliers,NAMED('SrcOutliers_UnusuallyFrequent'),ALL),OUTPUT(h.AllUniqueOutliers,NAMED('SrcOutliers_Unique'),ALL),OUTPUT(h.AllUniqueOutlierSources, NAMED('UniqueOutlier_sources')), OUTPUT(h.AllDistinctOutliers,NAMED('SrcOutliers_Distinct'),ALL),OUTPUT(h.AllDistinctOutlierSources, NAMED('DistinctOutlier_sources')), OUTPUT(h.AllTop5Outliers,NAMED('SrcOutliers_Top5'),ALL),OUTPUT(h.AllTop5OutlierSources, NAMED('Top5Outlier_sources'))); // One source behaves differently to the others
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT35.MAC_Character_Counts.EclRecord(p,'Layout_POWID_Down'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT35.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of POWID *******
  // POWID consistency module
  CM := BIPV2_POWID_Down.Fields.UIDConsistency(BIPV2_POWID_Down.In_POWID_Down);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.POWID_Unbased,NAMED('UnbasedPOWID'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.rcid_TwoParents,NAMED('Twoparentsrcid'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT35.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,orgid,Examples),NAMED('orgidBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,prim_range,Examples),NAMED('prim_rangeBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,prim_name,Examples),NAMED('prim_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,st,Examples),NAMED('stBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,zip,Examples),NAMED('zipBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,v_city_name,Examples),NAMED('v_city_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_name,Examples),NAMED('company_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_first_seen,Examples),NAMED('dt_first_seenBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_last_seen,Examples),NAMED('dt_last_seenBysource'));
