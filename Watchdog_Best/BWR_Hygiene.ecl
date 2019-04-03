//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Watchdog_best.BWR_Hygiene - Hygiene & Stats - SALT V3.11.7');
IMPORT Watchdog_best,SALT311;
// First create an instantiated hygiene module
  infile := Watchdog_best.In_Hdr;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Watchdog_best.hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Layout_Hdr'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of did *******
  // did consistency module
  CM := Watchdog_best.Fields.UIDConsistency(Watchdog_best.In_Hdr);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.did_Unbased,NAMED('Unbaseddid'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.rid_TwoParents,NAMED('Twoparentsrid'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,pflag1,Examples),NAMED('pflag1Bysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,pflag2,Examples),NAMED('pflag2Bysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,pflag3,Examples),NAMED('pflag3Bysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dt_first_seen,Examples),NAMED('dt_first_seenBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dt_last_seen,Examples),NAMED('dt_last_seenBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dt_vendor_last_reported,Examples),NAMED('dt_vendor_last_reportedBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dt_vendor_first_reported,Examples),NAMED('dt_vendor_first_reportedBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dt_nonglb_last_seen,Examples),NAMED('dt_nonglb_last_seenBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,rec_type,Examples),NAMED('rec_typeBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,phone,Examples),NAMED('phoneBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,ssn,Examples),NAMED('ssnBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dob,Examples),NAMED('dobBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,title,Examples),NAMED('titleBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,fname,Examples),NAMED('fnameBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,mname,Examples),NAMED('mnameBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,lname,Examples),NAMED('lnameBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,name_suffix,Examples),NAMED('name_suffixBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,prim_range,Examples),NAMED('prim_rangeBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,predir,Examples),NAMED('predirBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,prim_name,Examples),NAMED('prim_nameBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,suffix,Examples),NAMED('suffixBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,postdir,Examples),NAMED('postdirBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,unit_desig,Examples),NAMED('unit_desigBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,sec_range,Examples),NAMED('sec_rangeBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,city_name,Examples),NAMED('city_nameBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,st,Examples),NAMED('stBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,zip,Examples),NAMED('zipBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,zip4,Examples),NAMED('zip4Bysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,tnt,Examples),NAMED('tntBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,valid_ssn,Examples),NAMED('valid_ssnBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,jflag1,Examples),NAMED('jflag1Bysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,jflag2,Examples),NAMED('jflag2Bysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,jflag3,Examples),NAMED('jflag3Bysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,rawaid,Examples),NAMED('rawaidBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,dodgy_tracking,Examples),NAMED('dodgy_trackingBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,address_ind,Examples),NAMED('address_indBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,name_ind,Examples),NAMED('name_indBysrc'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,src,persistent_record_id,Examples),NAMED('persistent_record_idBysrc'));
