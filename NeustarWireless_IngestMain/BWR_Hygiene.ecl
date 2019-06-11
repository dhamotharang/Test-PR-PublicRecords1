//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','NeustarWireless_IngestMain.BWR_Hygiene - Hygiene & Stats - SALT V3.11.4');
IMPORT NeustarWireless_IngestMain,SALT311;
// First create an instantiated hygiene module
  infile := NeustarWireless_IngestMain.In_File_Base;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := NeustarWireless_IngestMain.hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  PARALLEL(OUTPUT(h.AllUnusuallyFrequentOutliers,NAMED('SrcOutliers_UnusuallyFrequent'),ALL),OUTPUT(h.AllUniqueOutliers,NAMED('SrcOutliers_Unique'),ALL),OUTPUT(h.AllUniqueOutlierSources, NAMED('UniqueOutlier_sources')), OUTPUT(h.AllDistinctOutliers,NAMED('SrcOutliers_Distinct'),ALL),OUTPUT(h.AllDistinctOutlierSources, NAMED('DistinctOutlier_sources')), OUTPUT(h.AllTop5Outliers,NAMED('SrcOutliers_Top5'),ALL),OUTPUT(h.AllTop5OutlierSources, NAMED('Top5Outlier_sources'))); // One source behaves differently to the others
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Layout_File_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,phone,Examples),NAMED('phoneBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,fname,Examples),NAMED('fnameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,mname,Examples),NAMED('mnameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,lname,Examples),NAMED('lnameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,salutation,Examples),NAMED('salutationBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,suffix,Examples),NAMED('suffixBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,gender,Examples),NAMED('genderBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,dob,Examples),NAMED('dobBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,house,Examples),NAMED('houseBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,pre_dir,Examples),NAMED('pre_dirBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,street,Examples),NAMED('streetBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,street_type,Examples),NAMED('street_typeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,post_dir,Examples),NAMED('post_dirBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,apt_type,Examples),NAMED('apt_typeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,apt_nbr,Examples),NAMED('apt_nbrBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,zip,Examples),NAMED('zipBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,plus4,Examples),NAMED('plus4Bysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,dpc,Examples),NAMED('dpcBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,z4_type,Examples),NAMED('z4_typeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,crte,Examples),NAMED('crteBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,city,Examples),NAMED('cityBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,state,Examples),NAMED('stateBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,dpvcmra,Examples),NAMED('dpvcmraBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,dpvconf,Examples),NAMED('dpvconfBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,fips_state,Examples),NAMED('fips_stateBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,fips_county,Examples),NAMED('fips_countyBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,census_tract,Examples),NAMED('census_tractBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,census_block_group,Examples),NAMED('census_block_groupBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cbsa,Examples),NAMED('cbsaBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,match_code,Examples),NAMED('match_codeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,latitude,Examples),NAMED('latitudeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,longitude,Examples),NAMED('longitudeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,email,Examples),NAMED('emailBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,verified,Examples),NAMED('verifiedBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,activity_status,Examples),NAMED('activity_statusBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,prepaid,Examples),NAMED('prepaidBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cord_cutter,Examples),NAMED('cord_cutterBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,raw_file_name,Examples),NAMED('raw_file_nameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,date_first_seen,Examples),NAMED('date_first_seenBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,date_last_seen,Examples),NAMED('date_last_seenBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,date_vendor_first_reported,Examples),NAMED('date_vendor_first_reportedBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,date_vendor_last_reported,Examples),NAMED('date_vendor_last_reportedBysource'));
