EXPORT User_Settings_Module := MODULE

//********FCRA PRODUCTS*****************

EXPORT RV_Attributes_V5_BATCH_Prescreen_Capone_settings :=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=1;
			 // EXPORT INTEGER DL:=1;
			 EXPORT STRING DRM :='000000000001010000000000000000'; 	
			 EXPORT STRING DPM :='000000000100000000000000000000' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 EXPORT BOOLEAN IsPreScreen:=true;
			 Export String AttributesVersion := 'riskviewattrv5';
END;

EXPORT RV_Attributes_V5_BATCH_Generic_settings :=MODULE
       // EXPORT INTEGER DPPA:=0;
		   EXPORT INTEGER GLB:=1;
			 EXPORT INTEGER DL:=1;
			 EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
END;

EXPORT RV_Attributes_V5_XML_Generic_settings :=MODULE
       // EXPORT INTEGER DPPA:=0;
		   EXPORT INTEGER GLB:=1;
			 EXPORT INTEGER DL:=1;
			 EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
END;

EXPORT RV_Scores_XML_Tmobile_rvt1212_1_settings :=MODULE
       EXPORT INTEGER DPPA:=0;
		   EXPORT INTEGER GLB:=0;
			 // EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 // EXPORT BOOLEAN IncludeVersion4 :=true;
END;

EXPORT RV_Scores_XML_Tmobile_rvt1210_1_settings :=MODULE
       EXPORT INTEGER DPPA:=0;
		   EXPORT INTEGER GLB:=0;
			 EXPORT STRING DRM :='00000000000101'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 // EXPORT BOOLEAN IncludeVersion4 :=true;
END;

EXPORT RV_Scores_XML_Santander_1304_2_settings :=MODULE
       EXPORT INTEGER DPPA:=0;
		   EXPORT INTEGER GLB:=0;
			 // EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 // EXPORT BOOLEAN IncludeVersion4 :=true;
END;

EXPORT RV_Scores_XML_Santander_1304_1_settings :=MODULE
       EXPORT INTEGER DPPA:=0;
		   EXPORT INTEGER GLB:=0;
			 // EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 // EXPORT BOOLEAN IncludeVersion4 :=true;
END;

EXPORT RV_Scores_V4_XML_Generic_settings :=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=0;
			 EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 // EXPORT BOOLEAN IncludeVersion4 :=true;
END;

EXPORT RV_Scores_V4_BATCH_Generic_settings :=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=0;
			 EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=false;
			 EXPORT BOOLEAN IncludeVersion4 :=true;
END;

EXPORT RV_Attributes_V4_XML_Generic_settings :=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='100001000100'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 // EXPORT BOOLEAN IncludeVersion4 :=true;
END;

EXPORT RV_Attributes_V4_BATCH_Generic_settings :=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='100001000100'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 EXPORT BOOLEAN IncludeVersion4 :=true;
END;

EXPORT RV_Scores_V4_XML_ENOVA_settings :=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=5;
			 // EXPORT STRING DRM :='10000001010000'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 // EXPORT BOOLEAN IncludeVersion3 :=true;
END;

EXPORT RV_Attributes_V3_XML_Experian_settings :=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='10000001010000'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 // EXPORT BOOLEAN IncludeVersion3 :=true;
END;

EXPORT RV_Attributes_V3_BATCH_Experian_settings :=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='10000001010000'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 EXPORT BOOLEAN IncludeVersion3 :=true;
END;

EXPORT RV_Attributes_V2_BATCH_CreditAcceptance_settings :=MODULE
       EXPORT INTEGER DPPA:=0;
		   EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='00000000000101'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 EXPORT BOOLEAN IsPreScreen:=true;
			 EXPORT BOOLEAN IncludeVersion2 :=true;
END;

EXPORT RV_Attributes_V3_BATCH_CapOne_settings :=MODULE
       // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 EXPORT BOOLEAN IsPreScreen:=true;
			 EXPORT BOOLEAN IncludeVersion3 :=true;

END;

EXPORT RV_Attributes_V2_BATCH_CapOne_settings :=MODULE
       // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 EXPORT BOOLEAN IsPreScreen:=true;
			 EXPORT BOOLEAN IncludeVersion2 :=true;

END;

EXPORT RV_Attributes_V3_BATCH_Generic_settings:=MODULE
       // EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 EXPORT BOOLEAN IncludeVersion3 :=true;
END;

EXPORT RV_Attributes_V3_XML_Generic_settings:=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='100001000100'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			EXPORT BOOLEAN IncludeVersion3 :=true;
END;

EXPORT RV_Scores_V3_BATCH_Generic_settings:=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=false;
			 EXPORT BOOLEAN IncludeVersion3 :=true;
END;

EXPORT RV_Scores_V3_XML_Generic_settings:=MODULE
       // EXPORT INTEGER DPPA:=0;
		   // EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 // EXPORT INTEGER Version :=3;
END;

EXPORT RV_Scores_XML_RegionalAcceptance_RVA1008_1_settings:=MODULE
       EXPORT INTEGER DPPA:=0;
		   EXPORT INTEGER GLB:=0;
			 EXPORT STRING DRM :='00000000000101'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IncludeVersion4 :=true;
			 // EXPORT BOOLEAN IsPreScreen :=true;
END;

EXPORT RV_Attributes_V2_BATCH_settings :=MODULE
       // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='10000100010001'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen:=true;
			 // EXPORT BOOLEAN IncludeVersion2 :=true;

END;

//********NON FCRA PRODUCTS**************

EXPORT Profile_Booster_Capital_One := MODULE
			 EXPORT STRING DPM :='0000000000'; 
			 EXPORT STRING DRM :='0000000000000'; 
			 EXPORT STRING AttributesVersionRequest	:= 'PBATTRV1';
END;

EXPORT BusinessShell_Attributes_V2_XML_Generic_settings:=MODULE
       EXPORT INTEGER DPPA:=1;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DPM :='000000000001'; 
			 EXPORT STRING DRM :='000000000000000'; 	
			 EXPORT BOOLEAN isFCRA:=false;
			 EXPORT integer Version:=22;
			 // REF: email from Bridgett 12/01/2015 sub: Profiled SBFE attributes for monitoring
END;

EXPORT AddressShell_Attributes_V1_BATCH_Generic_settings:=MODULE
       EXPORT INTEGER DLPurpose:=6;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='00000000000000000000'; 	
			 EXPORT BOOLEAN isFCRA:=false;
			 EXPORT STRING Address_Attributes_Version := 'AddressBasedPRAttrV1';
       EXPORT STRING Property_Info_Attributes_Version := 'PropertyInfoAttrV1';
       EXPORT STRING ERC_Attributes_Version := 'ERCAttrV0';
			 // REF: email from Nathan 10/21/2015 sub: Address Shell Monitoring
			 // <Options> 
      // <RequestedAttributeGroups>
        // <Name>AddressBasedPRAttrV1</Name>
        // <Name>PropertyInfoAttrV1</Name>
        // <Name>ERCAttrV0</Name>
      // </RequestedAttributeGroups>
    // </Options>
    // <User>
      // <GLBPurpose>1</GLBPurpose>
      // <DLPurpose>6</DLPurpose>
      // <DataRestrictionMask>00000000000000000000</DataRestrictionMask>
    // </User>
END;

EXPORT LI_Scores_V4_XML_Generic_msn1106_0_settings:=MODULE
    // EXPORT INTEGER DPPA:=;
		   EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='000000000000';
			 EXPORT STRING Version :='4'; 
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IsPreScreen :=true;
END;

EXPORT LI_Scores_V4_BATCH_Generic_msn1106_0_settings:=MODULE
    EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='000000000000'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 EXPORT BOOLEAN IncludeVersion4 :=true;
			 // EXPORT BOOLEAN IsPreScreen :=true;
END;

EXPORT LI_Attributes_V4_XML_Generic_msn1106_0_settings:=MODULE
       EXPORT INTEGER DPPA:=0;
		   EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='000000000000'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 EXPORT BOOLEAN IncludeVersion4 :=true;
			 // EXPORT BOOLEAN IsPreScreen :=true;
END;

EXPORT LI_Attributes_V4_BATCH_Generic_msn1106_0_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='000000000000'; 	
			 // EXPORT STRING DPM :='' ;
			 EXPORT BOOLEAN isFCRA:=true;
			 EXPORT BOOLEAN IncludeVersion4 :=true;
			 // EXPORT BOOLEAN IsPreScreen :=true;
END;

EXPORT IID_Scores_V0_XML_Generic_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IncludeVersion4 :=true;
			 // EXPORT BOOLEAN IsPreScreen :=true;
END;

EXPORT IID_Scores_V0_BATCH_Generic_settings:=MODULE
       // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=true;
			 // EXPORT BOOLEAN IncludeVersion4 :=true;
			 // EXPORT BOOLEAN IsPreScreen :=true;
END;

EXPORT FP_V201_American_Express_XML_Generic_FP1109_0_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='000000002000010000000000000000'; 	
			 EXPORT STRING DPM :='110001000100100000000000000000' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 EXPORT string AttributesVersionRequest := 'FRAUDPOINTATTRV201';
END; 


EXPORT FP_V2_XML_Generic_FP1109_0_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 // EXPORT BOOLEAN IncludeVersion2 :=true;
END; 

EXPORT FP_V2_BATCH_Generic_FP1109_0_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 EXPORT BOOLEAN IncludeVersion2 :=true;
END;

EXPORT FP_V3_XML_Generic_FP31505_0_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
			 EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 // EXPORT BOOLEAN IncludeVersion2 :=true;
END; 

EXPORT PRIO_Scores_XML_Chase_PIO2_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='000000000001110000000000000000000000000000'; 	
			 EXPORT STRING DPM :='0000000001000000000' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 // EXPORT INTEGER Version :=3;
END;


EXPORT PRIO_Scores_BATCH_Chase_PIO2_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='000000000001110000000000000000000000000000'; 	
			 EXPORT STRING DPM :='0000000001000000000' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 // EXPORT INTEGER Version :=3;
END;

EXPORT CBBL_Scores_XML_Chase_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000100000000000	'; 	
			 EXPORT STRING DPM :='000000000100' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 // EXPORT INTEGER Version :=3;

END;

EXPORT BC10_Scores_XML_Chase_BNK4_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='000000000001110000000000000000000000000000'; 	
			 EXPORT STRING DPM :='0000000001000000000' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 // EXPORT INTEGER Version :=3;
END;

EXPORT BC10_Scores_BATCH_Chase_BNK4_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='000000000001110000000000000000000000000000'; 	
			 EXPORT STRING DPM :='0000000001000000000' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 // EXPORT INTEGER Version :=3;
END;

EXPORT BIID_BATCH_Chase_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :=''; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 // EXPORT INTEGER Version :=3;
END;

EXPORT BIID_BATCH_Generic_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :=''; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 // EXPORT INTEGER Version :=3;
END;

EXPORT BIID_XML_Generic_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='000000000000010000000000000000'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 // EXPORT INTEGER Version :=3;
END;

EXPORT ChargeBackDefender_BestBuy_settings:=MODULE
       EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='000000000000'; 	
			 // EXPORT STRING DPM :='' ;
			 // EXPORT BOOLEAN isFCRA:=false;
			 EXPORT INTEGER Version :=3;
END;

EXPORT ITA_V3_CapOne_settings:= MODULE
	     EXPORT INTEGER DPPA:=0;
		   EXPORT INTEGER GLB:=5;
			 EXPORT STRING DRM :='000000000000010000000000000000'; 	
			 EXPORT STRING DPM :='110001000100000000000000000000';
			 // EXPORT BOOLEAN isFCRA:=false;
			 EXPORT INTEGER Version :=3;

END;

//********BOCASHELL PRODUCTS**************

EXPORT BocaShell_41_NONFCRA_settings:= MODULE
	     EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     EXPORT BOOLEAN RemoveFares:=false; 
	 	   EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;

EXPORT BocaShell_41_FCRA_settings:= MODULE
	     // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     // EXPORT BOOLEAN RemoveFares:=false; 
	 	   // EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;

EXPORT BocaShell_50_NONFCRA_settings:= MODULE
	     EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     EXPORT BOOLEAN RemoveFares:=false; 
	 	   EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;

EXPORT BocaShell_50_FCRA_settings:= MODULE
	     // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     // EXPORT BOOLEAN RemoveFares:=false; 
	 	   // EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;

//added BocaShell_54 settings
EXPORT BocaShell_54_NONFCRA_settings:= MODULE
	     EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     EXPORT BOOLEAN RemoveFares:=false; 
	 	   EXPORT BOOLEAN LeadIntegrityMode:=false;
// blank line test		 
END;

EXPORT BocaShell_54_FCRA_settings:= MODULE
	     // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     // EXPORT BOOLEAN RemoveFares:=false; 
	 	   // EXPORT BOOLEAN LeadIntegrityMode:=false;
END;


EXPORT Insurview_FCRA_settings:= MODULE
	     // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000010001001100000000000'; 	
			 EXPORT STRING DPM :='0000000000000';
	     // EXPORT BOOLEAN RemoveFares:=false; 
	 	   // EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;

END;