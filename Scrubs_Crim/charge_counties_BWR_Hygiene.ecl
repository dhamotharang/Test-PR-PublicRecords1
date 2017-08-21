//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.charge_counties_BWR_Hygiene - Hygiene & Stats - SALT V3.3.2');
IMPORT Scrubs_Crim,SALT33;
// First create an instantiated hygiene module
  infile := Scrubs_Crim.charge_counties_In_crim;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Crim.charge_counties_Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT33.MAC_Character_Counts.EclRecord(p,'Layout_crim'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT33.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT33.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,recordid,Examples),NAMED('recordidByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,statecode,Examples),NAMED('statecodeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,caseid,Examples),NAMED('caseidByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,warrantnumber,Examples),NAMED('warrantnumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,warrantdate,Examples),NAMED('warrantdateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,warrantdesc,Examples),NAMED('warrantdescByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,warrantissuedate,Examples),NAMED('warrantissuedateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,warrantissuingagency,Examples),NAMED('warrantissuingagencyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,warrantstatus,Examples),NAMED('warrantstatusByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,citationnumber,Examples),NAMED('citationnumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,bookingnumber,Examples),NAMED('bookingnumberByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,arrestdate,Examples),NAMED('arrestdateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,arrestingagency,Examples),NAMED('arrestingagencyByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,bookingdate,Examples),NAMED('bookingdateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,custodydate,Examples),NAMED('custodydateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,custodylocation,Examples),NAMED('custodylocationByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,initialcharge,Examples),NAMED('initialchargeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,initialchargedate,Examples),NAMED('initialchargedateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,initialchargecancelleddate,Examples),NAMED('initialchargecancelleddateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,chargedisposed,Examples),NAMED('chargedisposedByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,chargedisposeddate,Examples),NAMED('chargedisposeddateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,chargeseverity,Examples),NAMED('chargeseverityByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,chargedisposition,Examples),NAMED('chargedispositionByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,amendedcharge,Examples),NAMED('amendedchargeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,amendedchargedate,Examples),NAMED('amendedchargedateByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,bondsman,Examples),NAMED('bondsmanByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,bondamount,Examples),NAMED('bondamountByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,bondtype,Examples),NAMED('bondtypeByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourcename,Examples),NAMED('sourcenameByvendor'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,vendor,sourceid,Examples),NAMED('sourceidByvendor'));
