//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_EMPID_Platform.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Gold');
IMPORT BIPV2_EMPID_Platform,SALT30;
// First create an instantiated hygiene module
  infile := BIPV2_EMPID_Platform.In_EmpID;
  h := BIPV2_EMPID_Platform.Hygiene(infile);
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
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_EmpID'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of EmpID *******
  // EmpID consistency module
  CM := BIPV2_EMPID_Platform.Fields.UIDConsistency(BIPV2_EMPID_Platform.In_EmpID);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.EmpID_Unbased,NAMED('UnbasedEmpID'));
//  OUTPUT(CM.SeleID_Unbased,NAMED('UnbasedSeleID'));
//  OUTPUT(CM.OrgID_Unbased,NAMED('UnbasedOrgID'));
//  OUTPUT(CM.UltID_Unbased,NAMED('UnbasedUltID'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.rcid_TwoParents,NAMED('Twoparentsrcid'));
//  OUTPUT(CM.EmpID_TwoParents,NAMED('TwoparentsEmpID'));
//  OUTPUT(CM.SeleID_TwoParents,NAMED('TwoparentsSeleID'));
//  OUTPUT(CM.OrgID_TwoParents,NAMED('TwoparentsOrgID'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,isCorpEnhanced,Examples),NAMED('isCorpEnhancedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,contact_job_title_derived,Examples),NAMED('contact_job_title_derivedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cname_devanitize,Examples),NAMED('cname_devanitizeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,prim_range,Examples),NAMED('prim_rangeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,prim_name,Examples),NAMED('prim_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,zip,Examples),NAMED('zipBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,zip4,Examples),NAMED('zip4Bysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,fname,Examples),NAMED('fnameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,lname,Examples),NAMED('lnameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,contact_phone,Examples),NAMED('contact_phoneBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,contact_did,Examples),NAMED('contact_didBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,contact_ssn,Examples),NAMED('contact_ssnBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_name,Examples),NAMED('company_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,sec_range,Examples),NAMED('sec_rangeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,v_city_name,Examples),NAMED('v_city_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,st,Examples),NAMED('stBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_inc_state,Examples),NAMED('company_inc_stateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_charter_number,Examples),NAMED('company_charter_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,active_duns_number,Examples),NAMED('active_duns_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,hist_duns_number,Examples),NAMED('hist_duns_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,active_domestic_corp_key,Examples),NAMED('active_domestic_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,hist_domestic_corp_key,Examples),NAMED('hist_domestic_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,foreign_corp_key,Examples),NAMED('foreign_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,unk_corp_key,Examples),NAMED('unk_corp_keyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_fein,Examples),NAMED('company_feinBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_btype,Examples),NAMED('cnp_btypeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cnp_name,Examples),NAMED('cnp_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_name_type_derived,Examples),NAMED('company_name_type_derivedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,company_bdid,Examples),NAMED('company_bdidBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,nodes_total,Examples),NAMED('nodes_totalBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,dt_first_seen,Examples),NAMED('dt_first_seenBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,dt_last_seen,Examples),NAMED('dt_last_seenBysource'));
