//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_VehicleV2.OH_Direct_BWR_Hygiene - Hygiene & Stats - SALT V3.6.1');
IMPORT Scrubs_VehicleV2,SALT36;
// First create an instantiated hygiene module
  infile := Scrubs_VehicleV2.OH_Direct_In_VehicleV2;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_VehicleV2.OH_Direct_Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT36.MAC_Character_Counts.EclRecord(p,'Layout_VehicleV2'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT36.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT36.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,categorycode,Examples),NAMED('categorycodeBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,vin,Examples),NAMED('vinBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,modelyr,Examples),NAMED('modelyrBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,titlenum,Examples),NAMED('titlenumBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,ownercode,Examples),NAMED('ownercodeBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,grossweight,Examples),NAMED('grossweightBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,ownername,Examples),NAMED('ownernameBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,ownerstreetaddress,Examples),NAMED('ownerstreetaddressBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,ownercity,Examples),NAMED('ownercityBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,ownerstate,Examples),NAMED('ownerstateBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,ownerzip,Examples),NAMED('ownerzipBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,countynumber,Examples),NAMED('countynumberBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,vehiclepurchasedt,Examples),NAMED('vehiclepurchasedtBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,vehicletaxweight,Examples),NAMED('vehicletaxweightBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,vehicletaxcode,Examples),NAMED('vehicletaxcodeBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,vehicleunladdenweight,Examples),NAMED('vehicleunladdenweightBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,additionalownername,Examples),NAMED('additionalownernameBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,registrationissuedt,Examples),NAMED('registrationissuedtBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,vehiclemake,Examples),NAMED('vehiclemakeBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,vehicletype,Examples),NAMED('vehicletypeBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,vehicleexpdt,Examples),NAMED('vehicleexpdtBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,previousplatenum,Examples),NAMED('previousplatenumBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,platenum,Examples),NAMED('platenumBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,processdate,Examples),NAMED('processdateBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,state_origin,Examples),NAMED('state_originBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,append_ownernametypeind,Examples),NAMED('append_ownernametypeindBysource_code'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,source_code,append_addlownernametypeind,Examples),NAMED('append_addlownernametypeindBysource_code'));
