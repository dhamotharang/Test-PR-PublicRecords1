﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_UCCV2.TH_Party_BWR_Hygiene - Hygiene & Stats - SALT V3.8.0');
IMPORT Scrubs_UCCV2,SALT38;
// First create an instantiated hygiene module
  infile := Scrubs_UCCV2.TH_Party_In_UCCV2;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_UCCV2.TH_Party_Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(SALT38.MAC_Character_Counts.EclRecord(p,'TH_Party_Layout_UCCV2'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT38.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT38.MAC_CrossTab
