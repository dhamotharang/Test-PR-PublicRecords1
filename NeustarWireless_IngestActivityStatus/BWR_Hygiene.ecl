//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','NeustarWireless_IngestActivityStatus.BWR_Hygiene - Hygiene & Stats - SALT V3.11.4');
IMPORT NeustarWireless_IngestActivityStatus,SALT311;
// First create an instantiated hygiene module
  infile := NeustarWireless_IngestActivityStatus.In_NeustarWireless.Files.Base.Activity_Status;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := NeustarWireless_IngestActivityStatus.hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  PARALLEL(OUTPUT(h.AllUnusuallyFrequentOutliers,NAMED('SrcOutliers_UnusuallyFrequent'),ALL),OUTPUT(h.AllUniqueOutliers,NAMED('SrcOutliers_Unique'),ALL),OUTPUT(h.AllUniqueOutlierSources, NAMED('UniqueOutlier_sources')), OUTPUT(h.AllDistinctOutliers,NAMED('SrcOutliers_Distinct'),ALL),OUTPUT(h.AllDistinctOutlierSources, NAMED('DistinctOutlier_sources')), OUTPUT(h.AllTop5Outliers,NAMED('SrcOutliers_Top5'),ALL),OUTPUT(h.AllTop5OutlierSources, NAMED('Top5Outlier_sources'))); // One source behaves differently to the others
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Layout_NeustarWireless.Files.Base.Activity_Status'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,phone,Examples),NAMED('phoneBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,activity_status,Examples),NAMED('activity_statusBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,raw_file_name,Examples),NAMED('raw_file_nameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,rcid,Examples),NAMED('rcidBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,date_first_seen,Examples),NAMED('date_first_seenBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,date_last_seen,Examples),NAMED('date_last_seenBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,date_vendor_first_reported,Examples),NAMED('date_vendor_first_reportedBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,date_vendor_last_reported,Examples),NAMED('date_vendor_last_reportedBysource'));
