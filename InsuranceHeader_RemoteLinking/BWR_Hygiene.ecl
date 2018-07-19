//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_RemoteLinking.BWR_Hygiene - Hygiene & Stats - SALT V3.7.2');
IMPORT InsuranceHeader_RemoteLinking,SALT37;
// First create an instantiated hygiene module
  infile := InsuranceHeader_RemoteLinking.File_HEADER;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := InsuranceHeader_RemoteLinking.Hygiene(ip);
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
  OUTPUT(SALT37.MAC_Character_Counts.EclRecord(p,'Layout_HEADER'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT37.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of DID *******
  // DID consistency module
  CM := InsuranceHeader_RemoteLinking.Fields.UIDConsistency(InsuranceHeader_RemoteLinking.File_HEADER);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.DID_Unbased,NAMED('UnbasedDID'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.RID_TwoParents,NAMED('TwoparentsRID'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT37.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,SSN,Examples),NAMED('SSNBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,POLICY_NUMBER,Examples),NAMED('POLICY_NUMBERBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,CLAIM_NUMBER,Examples),NAMED('CLAIM_NUMBERBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,DL_NBR,Examples),NAMED('DL_NBRBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,DOB,Examples),NAMED('DOBBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,ZIP,Examples),NAMED('ZIPBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,PRIM_NAME,Examples),NAMED('PRIM_NAMEBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,LNAME,Examples),NAMED('LNAMEBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,PRIM_RANGE,Examples),NAMED('PRIM_RANGEBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,CITY,Examples),NAMED('CITYBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,FNAME,Examples),NAMED('FNAMEBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,SEC_RANGE,Examples),NAMED('SEC_RANGEBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,MNAME,Examples),NAMED('MNAMEBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,ST,Examples),NAMED('STBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,SNAME,Examples),NAMED('SNAMEBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,GENDER,Examples),NAMED('GENDERBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,DERIVED_GENDER,Examples),NAMED('DERIVED_GENDERBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,VENDOR_ID,Examples),NAMED('VENDOR_IDBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,BOCA_DID,Examples),NAMED('BOCA_DIDBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,DT_FIRST_SEEN,Examples),NAMED('DT_FIRST_SEENBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,DT_LAST_SEEN,Examples),NAMED('DT_LAST_SEENBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,DL_STATE,Examples),NAMED('DL_STATEBySRC'));
  //  OUTPUT(SALT37.MAC_CrossTab(infile,SRC,AMBEST,Examples),NAMED('AMBESTBySRC'));
