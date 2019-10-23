//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareNoMatchHeader_Ingest.BWR_Hygiene - Hygiene & Stats - SALT V3.11.7');
IMPORT HealthCareNoMatchHeader_Ingest,SALT311;
// First create an instantiated hygiene module
  infile := HealthCareNoMatchHeader_Ingest.In_Base;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := HealthCareNoMatchHeader_Ingest.hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Layout_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of nomatch_id *******
  // nomatch_id consistency module
  CM := HealthCareNoMatchHeader_Ingest.Fields.UIDConsistency(HealthCareNoMatchHeader_Ingest.In_Base);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.nomatch_id_Unbased,NAMED('Unbasednomatch_id'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.RID_TwoParents,NAMED('TwoparentsRID'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dt_first_seen,Examples),NAMED('dt_first_seenBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dt_last_seen,Examples),NAMED('dt_last_seenBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dt_vendor_first_reported,Examples),NAMED('dt_vendor_first_reportedBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dt_vendor_last_reported,Examples),NAMED('dt_vendor_last_reportedBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,source_rid,Examples),NAMED('source_ridBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,ssn,Examples),NAMED('ssnBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dob,Examples),NAMED('dobBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,title,Examples),NAMED('titleBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,fname,Examples),NAMED('fnameBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,mname,Examples),NAMED('mnameBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,lname,Examples),NAMED('lnameBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,suffix,Examples),NAMED('suffixBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,home_phone,Examples),NAMED('home_phoneBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,gender,Examples),NAMED('genderBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,prim_range,Examples),NAMED('prim_rangeBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,predir,Examples),NAMED('predirBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,prim_name,Examples),NAMED('prim_nameBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,addr_suffix,Examples),NAMED('addr_suffixBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,postdir,Examples),NAMED('postdirBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,unit_desig,Examples),NAMED('unit_desigBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,sec_range,Examples),NAMED('sec_rangeBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,city_name,Examples),NAMED('city_nameBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,st,Examples),NAMED('stBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,zip,Examples),NAMED('zipBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,zip4,Examples),NAMED('zip4Bysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,lexid,Examples),NAMED('lexidBysrc'));
