//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','LocationID_Ingest.BWR_Hygiene - Hygiene & Stats - SALT V3.7.0');
IMPORT LocationID_Ingest,SALT37;
// First create an instantiated hygiene module
  infile := LocationID_Ingest.In_BASE;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := LocationID_Ingest.Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT37.MAC_Character_Counts.EclRecord(p,'Layout_BASE'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT37.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of LocId *******
  // LocId consistency module
  CM := LocationID_Ingest.Fields.UIDConsistency(LocationID_Ingest.In_BASE);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.LocId_Unbased,NAMED('UnbasedLocId'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.rid_TwoParents,NAMED('Twoparentsrid'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT37.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,aid,Examples),NAMED('aidBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,dateseenfirst,Examples),NAMED('dateseenfirstBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,dateseenlast,Examples),NAMED('dateseenlastBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,prim_range,Examples),NAMED('prim_rangeBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,predir,Examples),NAMED('predirBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,prim_name,Examples),NAMED('prim_nameBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,addr_suffix,Examples),NAMED('addr_suffixBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,postdir,Examples),NAMED('postdirBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,unit_desig,Examples),NAMED('unit_desigBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,sec_range,Examples),NAMED('sec_rangeBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,v_city_name,Examples),NAMED('v_city_nameBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,st,Examples),NAMED('stBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,zip5,Examples),NAMED('zip5Bysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,rec_type,Examples),NAMED('rec_typeBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,err_stat,Examples),NAMED('err_statBysource'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,source,cntprimname,Examples),NAMED('cntprimnameBysource'));
