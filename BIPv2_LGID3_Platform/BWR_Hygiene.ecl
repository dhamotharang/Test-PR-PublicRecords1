//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_LGID3_PlatForm.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Gold');
IMPORT BIPV2_LGID3_PlatForm,SALT30;
// First create an instantiated hygiene module
  infile := BIPV2_LGID3_PlatForm.In_LGID3;
  h := BIPV2_LGID3_PlatForm.Hygiene(infile);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.AllOutliers,NAMED('SrcOutliers'),ALL); // One source behaves differently to the others
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_LGID3'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of LGID3 *******
  // LGID3 consistency module
  CM := BIPV2_LGID3_PlatForm.Fields.UIDConsistency(BIPV2_LGID3_PlatForm.In_LGID3);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.LGID3_Unbased,NAMED('UnbasedLGID3'));
//  OUTPUT(CM.seleid_Unbased,NAMED('Unbasedseleid'));
//  OUTPUT(CM.orgid_Unbased,NAMED('Unbasedorgid'));
//  OUTPUT(CM.ultid_Unbased,NAMED('Unbasedultid'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.rcid_TwoParents,NAMED('Twoparentsrcid'));
//  OUTPUT(CM.LGID3_TwoParents,NAMED('TwoparentsLGID3'));
//  OUTPUT(CM.seleid_TwoParents,NAMED('Twoparentsseleid'));
//  OUTPUT(CM.orgid_TwoParents,NAMED('Twoparentsorgid'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,sbfe_id,Examples),NAMED('sbfe_idBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,nodes_below_st,Examples),NAMED('nodes_below_stBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,Lgid3IfHrchy,Examples),NAMED('Lgid3IfHrchyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,OriginalSeleId,Examples),NAMED('OriginalSeleIdBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,OriginalOrgId,Examples),NAMED('OriginalOrgIdBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_name,Examples),NAMED('company_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_number,Examples),NAMED('cnp_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,active_duns_number,Examples),NAMED('active_duns_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,duns_number,Examples),NAMED('duns_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_fein,Examples),NAMED('company_feinBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_inc_state,Examples),NAMED('company_inc_stateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_charter_number,Examples),NAMED('company_charter_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_btype,Examples),NAMED('cnp_btypeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_name_type_derived,Examples),NAMED('company_name_type_derivedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,hist_duns_number,Examples),NAMED('hist_duns_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,active_domestic_corp_key,Examples),NAMED('active_domestic_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,hist_domestic_corp_key,Examples),NAMED('hist_domestic_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,foreign_corp_key,Examples),NAMED('foreign_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,unk_corp_key,Examples),NAMED('unk_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_name,Examples),NAMED('cnp_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_hasNumber,Examples),NAMED('cnp_hasNumberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_lowv,Examples),NAMED('cnp_lowvBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_translated,Examples),NAMED('cnp_translatedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_classid,Examples),NAMED('cnp_classidBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,prim_range,Examples),NAMED('prim_rangeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,prim_name,Examples),NAMED('prim_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,sec_range,Examples),NAMED('sec_rangeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,v_city_name,Examples),NAMED('v_city_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,st,Examples),NAMED('stBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,zip,Examples),NAMED('zipBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,has_lgid,Examples),NAMED('has_lgidBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,is_sele_level,Examples),NAMED('is_sele_levelBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,is_org_level,Examples),NAMED('is_org_levelBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,is_ult_level,Examples),NAMED('is_ult_levelBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,parent_proxid,Examples),NAMED('parent_proxidBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,sele_proxid,Examples),NAMED('sele_proxidBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,org_proxid,Examples),NAMED('org_proxidBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,ultimate_proxid,Examples),NAMED('ultimate_proxidBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,levels_from_top,Examples),NAMED('levels_from_topBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,nodes_total,Examples),NAMED('nodes_totalBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,dt_first_seen,Examples),NAMED('dt_first_seenBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,dt_last_seen,Examples),NAMED('dt_last_seenBysource'));
