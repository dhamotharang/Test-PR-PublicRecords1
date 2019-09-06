//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_ProxID_mj6_PlatForm.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Beta 2');
IMPORT BIPV2_ProxID_mj6_PlatForm,SALT30;
// First create an instantiated hygiene module
  infile := BIPV2_ProxID_mj6_PlatForm.In_DOT_Base;
  h := BIPV2_ProxID_mj6_PlatForm.Hygiene(infile);
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
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_DOT_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of Proxid *******
  // Proxid consistency module
  CM := BIPV2_ProxID_mj6_PlatForm.Fields.UIDConsistency(BIPV2_ProxID_mj6_PlatForm.In_DOT_Base);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.Proxid_Unbased,NAMED('UnbasedProxid'));
//  OUTPUT(CM.lgid3_Unbased,NAMED('Unbasedlgid3'));
//  OUTPUT(CM.orgid_Unbased,NAMED('Unbasedorgid'));
//  OUTPUT(CM.ultid_Unbased,NAMED('Unbasedultid'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.rcid_TwoParents,NAMED('Twoparentsrcid'));
//  OUTPUT(CM.Proxid_TwoParents,NAMED('TwoparentsProxid'));
//  OUTPUT(CM.lgid3_TwoParents,NAMED('Twoparentslgid3'));
//  OUTPUT(CM.orgid_TwoParents,NAMED('Twoparentsorgid'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_name,Examples),NAMED('cnp_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_number,Examples),NAMED('cnp_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,active_duns_number,Examples),NAMED('active_duns_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,active_enterprise_number,Examples),NAMED('active_enterprise_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,active_domestic_corp_key,Examples),NAMED('active_domestic_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,hist_enterprise_number,Examples),NAMED('hist_enterprise_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,hist_duns_number,Examples),NAMED('hist_duns_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,hist_domestic_corp_key,Examples),NAMED('hist_domestic_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,foreign_corp_key,Examples),NAMED('foreign_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,unk_corp_key,Examples),NAMED('unk_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,ebr_file_number,Examples),NAMED('ebr_file_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_fein,Examples),NAMED('company_feinBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_phone,Examples),NAMED('company_phoneBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,prim_range,Examples),NAMED('prim_rangeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,prim_name_derived,Examples),NAMED('prim_name_derivedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,sec_range,Examples),NAMED('sec_rangeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,v_city_name,Examples),NAMED('v_city_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,st,Examples),NAMED('stBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,zip,Examples),NAMED('zipBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_csz,Examples),NAMED('company_cszBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_addr1,Examples),NAMED('company_addr1Bysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_address,Examples),NAMED('company_addressBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,dt_first_seen,Examples),NAMED('dt_first_seenBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,dt_last_seen,Examples),NAMED('dt_last_seenBysource'));
