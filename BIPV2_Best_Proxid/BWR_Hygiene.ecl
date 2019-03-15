//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_Best_Proxid.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Gold');
IMPORT BIPV2_Best_Proxid,SALT30;
// First create an instantiated hygiene module
  infile := BIPV2_Best_Proxid.In_Base;
  h := BIPV2_Best_Proxid.Hygiene(infile);
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
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of Proxid *******
  // Proxid consistency module
  CM := BIPV2_Best_Proxid.Fields.UIDConsistency(BIPV2_Best_Proxid.In_Base);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.Proxid_Unbased,NAMED('UnbasedProxid'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.rcid_TwoParents,NAMED('Twoparentsrcid'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,dt_first_seen,Examples),NAMED('dt_first_seenBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,dt_last_seen,Examples),NAMED('dt_last_seenBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,company_name,Examples),NAMED('company_nameBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,company_fein,Examples),NAMED('company_feinBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,company_phone,Examples),NAMED('company_phoneBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,company_url,Examples),NAMED('company_urlBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,duns_number,Examples),NAMED('duns_numberBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,company_sic_code1,Examples),NAMED('company_sic_code1Bysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,company_naics_code1,Examples),NAMED('company_naics_code1Bysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,prim_range,Examples),NAMED('prim_rangeBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,predir,Examples),NAMED('predirBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,prim_name,Examples),NAMED('prim_nameBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,addr_suffix,Examples),NAMED('addr_suffixBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,postdir,Examples),NAMED('postdirBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,unit_desig,Examples),NAMED('unit_desigBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,sec_range,Examples),NAMED('sec_rangeBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,p_city_name,Examples),NAMED('p_city_nameBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,v_city_name,Examples),NAMED('v_city_nameBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,st,Examples),NAMED('stBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,zip,Examples),NAMED('zipBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,zip4,Examples),NAMED('zip4Bysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,fips_state,Examples),NAMED('fips_stateBysource_for_votes'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_for_votes,fips_county,Examples),NAMED('fips_countyBysource_for_votes'));
