//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareFacilityHeader.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Gold');
IMPORT HealthCareFacilityHeader,SALT30;
// First create an instantiated hygiene module
  infile := HealthCareFacilityHeader.In_HealthFacility;
  h := HealthCareFacilityHeader.Hygiene(infile);
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
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_HealthFacility'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of LNPID *******
  // LNPID consistency module
  CM := HealthCareFacilityHeader.Fields.UIDConsistency(HealthCareFacilityHeader.In_HealthFacility);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.LNPID_Unbased,NAMED('UnbasedLNPID'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.RID_TwoParents,NAMED('TwoparentsRID'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,UPIN,Examples),NAMED('UPINBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,NPI_NUMBER,Examples),NAMED('NPI_NUMBERBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,DEA_NUMBER,Examples),NAMED('DEA_NUMBERBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,CLIA_NUMBER,Examples),NAMED('CLIA_NUMBERBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,MEDICARE_FACILITY_NUMBER,Examples),NAMED('MEDICARE_FACILITY_NUMBERBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,NCPDP_NUMBER,Examples),NAMED('NCPDP_NUMBERBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,TAX_ID,Examples),NAMED('TAX_IDBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,FEIN,Examples),NAMED('FEINBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,C_LIC_NBR,Examples),NAMED('C_LIC_NBRBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,CNAME,Examples),NAMED('CNAMEBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,CNP_NAME,Examples),NAMED('CNP_NAMEBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,CNP_NUMBER,Examples),NAMED('CNP_NUMBERBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,CNP_STORE_NUMBER,Examples),NAMED('CNP_STORE_NUMBERBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,CNP_BTYPE,Examples),NAMED('CNP_BTYPEBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,CNP_LOWV,Examples),NAMED('CNP_LOWVBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,CNP_TRANSLATED,Examples),NAMED('CNP_TRANSLATEDBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,CNP_CLASSID,Examples),NAMED('CNP_CLASSIDBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,ADDRESS_ID,Examples),NAMED('ADDRESS_IDBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,ADDRESS_CLASSIFICATION,Examples),NAMED('ADDRESS_CLASSIFICATIONBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,PRIM_RANGE,Examples),NAMED('PRIM_RANGEBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,PRIM_NAME,Examples),NAMED('PRIM_NAMEBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,SEC_RANGE,Examples),NAMED('SEC_RANGEBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,ST,Examples),NAMED('STBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,V_CITY_NAME,Examples),NAMED('V_CITY_NAMEBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,ZIP,Examples),NAMED('ZIPBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,PHONE,Examples),NAMED('PHONEBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,FAX,Examples),NAMED('FAXBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,TAXONOMY,Examples),NAMED('TAXONOMYBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,TAXONOMY_CODE,Examples),NAMED('TAXONOMY_CODEBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,MEDICAID_NUMBER,Examples),NAMED('MEDICAID_NUMBERBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,VENDOR_ID,Examples),NAMED('VENDOR_IDBySRC'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,SRC,LIC_STATE,Examples),NAMED('LIC_STATEBySRC'));
