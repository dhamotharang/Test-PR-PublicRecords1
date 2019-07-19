﻿IMPORT MDR; 

EXPORT Constants := MODULE

  EXPORT NUMBER_OF_INDICATORS := 28;
  
  
  EXPORT FLAGSHIP_MODELS := ['CIT1808_0_0'];

  EXPORT VALID_MODEL_NAMES := [FLAGSHIP_MODELS];
  
  EXPORT RANDOMIZATION_STARTED  := 20110625;      //date ssn randomization started - June 25th, 2011
  EXPORT AGE_CAP                := 110;           //This is the highest value we will allow in this product.
    
 
  EXPORT P_SOURCE  := 'P ';
  EXPORT DL_SOURCE := 'DL';
  
  EXPORT SOURCE_IS_CREDENTIALED := [MDR.SourceTools.src_Airmen, 
                                    MDR.SourceTools.src_Aircrafts, 
                                    MDR.SourceTools.src_Bankruptcy,
                                    MDR.SourceTools.src_US_Coastguard,
                                    MDR.SourceTools.src_DEA,
                                    MDR.SourceTools.src_Dunn_Bradstreet,
                                    DL_SOURCE,
                                    MDR.SourceTools.src_EMerge_Boat,
                                    MDR.SourceTools.src_EMerge_Hunt,
                                    MDR.SourceTools.src_EMerge_Fish,
                                    MDR.SourceTools.src_EMerge_CCW,
                                    MDR.SourceTools.src_Federal_Explosives,
                                    MDR.SourceTools.src_Federal_Firearms,
                                    P_SOURCE,
                                    MDR.SourceTools.src_Professional_License,
                                    MDR.SourceTools.src_American_Students_List,
                                    MDR.SourceTools.src_Vickers,
                                    MDR.SourceTools.src_Voters_v2,
                                    MDR.SourceTools.src_Whois_domains];
 

END;