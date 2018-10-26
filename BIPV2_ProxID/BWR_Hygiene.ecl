//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_ProxID.BWR_Hygiene - Hygiene & Stats - SALT V3.11.3');
IMPORT BIPV2_ProxID,SALT311;
// First create an instantiated hygiene module
  infile := BIPV2_ProxID.In_DOT_Base;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := BIPV2_ProxID.hygiene(ip);
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
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Layout_DOT_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of Proxid *******
  // Proxid consistency module
  CM := BIPV2_ProxID.Fields.UIDConsistency(BIPV2_ProxID.In_DOT_Base);
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
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,active_duns_number,Examples),NAMED('active_duns_numberBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,active_enterprise_number,Examples),NAMED('active_enterprise_numberBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,active_domestic_corp_key,Examples),NAMED('active_domestic_corp_keyBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,hist_enterprise_number,Examples),NAMED('hist_enterprise_numberBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,hist_duns_number,Examples),NAMED('hist_duns_numberBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,hist_domestic_corp_key,Examples),NAMED('hist_domestic_corp_keyBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,foreign_corp_key,Examples),NAMED('foreign_corp_keyBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,unk_corp_key,Examples),NAMED('unk_corp_keyBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,ebr_file_number,Examples),NAMED('ebr_file_numberBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,company_fein,Examples),NAMED('company_feinBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,company_name,Examples),NAMED('company_nameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cnp_name,Examples),NAMED('cnp_nameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,company_name_type_raw,Examples),NAMED('company_name_type_rawBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,company_name_type_derived,Examples),NAMED('company_name_type_derivedBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cnp_hasnumber,Examples),NAMED('cnp_hasnumberBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cnp_number,Examples),NAMED('cnp_numberBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cnp_btype,Examples),NAMED('cnp_btypeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cnp_lowv,Examples),NAMED('cnp_lowvBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cnp_translated,Examples),NAMED('cnp_translatedBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cnp_classid,Examples),NAMED('cnp_classidBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,company_foreign_domestic,Examples),NAMED('company_foreign_domesticBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,company_bdid,Examples),NAMED('company_bdidBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,company_phone,Examples),NAMED('company_phoneBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,prim_name,Examples),NAMED('prim_nameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,prim_name_derived,Examples),NAMED('prim_name_derivedBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,sec_range,Examples),NAMED('sec_rangeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,v_city_name,Examples),NAMED('v_city_nameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,st,Examples),NAMED('stBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,zip,Examples),NAMED('zipBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,prim_range,Examples),NAMED('prim_rangeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,prim_range_derived,Examples),NAMED('prim_range_derivedBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,dt_first_seen,Examples),NAMED('dt_first_seenBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,dt_last_seen,Examples),NAMED('dt_last_seenBysource'));
