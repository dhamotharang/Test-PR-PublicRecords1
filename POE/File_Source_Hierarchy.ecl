// This attribute is used to create an in-line base file containing POE/WorkPlace Locator
// related source codes and their corresponding hierarchy within the WorkPlace Locator 
// batch & online services results.
//
// A key file will be built from this base file as part of the monthly key build process.
// Then the key file will be accessed by both the: 
//   BatchServices.WorkPlace_BatchService
//   WorkPlace_Services.SearchService
// when determining the source hierarchy for all records for a did. 
import MDR;

  // NOTE1: Source names are self-explanatory except email ones that are noted below.
	// NOTE2: If a new source/source-category is added to the POE main base/key files, 
	//        then the product area will need to provide direction as to what it's hierarchy
	//        position shoudl be and if the other sources change position.
	// NOTE3: Do not change the hierarchy position without direction from the product area.
	
	//*** Jira# CONLOC-217, Modified source hierarchy positions as per the Jira ticket.
	
  ds_source_hierarchy := dataset([
		{MDR.sourceTools.src_PSS,										0},
		{MDR.sourceTools.src_OPM,										1},
		{MDR.sourceTools.src_Netwise,								2},
		{MDR.sourceTools.src_Teletrack,							3},
		{MDR.sourceTools.src_One_Click_Data,				4},
		{MDR.sourceTools.src_Database_USA,					5},
		{MDR.sourceTools.src_Spoke,									6},
		{MDR.sourceTools.src_Databridge,						7},
		{MDR.sourceTools.src_Garnishments,					8},
		{MDR.sourceTools.src_AK_Corporations,				9},
		{MDR.sourceTools.src_AL_Corporations,				9},
		{MDR.sourceTools.src_AR_Corporations,				9},
		{MDR.sourceTools.src_AZ_Corporations,				9},
		{MDR.sourceTools.src_CA_Corporations,				9},
		{MDR.sourceTools.src_CO_Corporations,				9},
		{MDR.sourceTools.src_CT_Corporations,				9},
		{MDR.sourceTools.src_DC_Corporations,				9},
		{MDR.sourceTools.src_FL_Corporations,				9},
		{MDR.sourceTools.src_GA_Corporations,				9},
		{MDR.sourceTools.src_HI_Corporations,				9},
		{MDR.sourceTools.src_IA_Corporations,				9},
		{MDR.sourceTools.src_ID_Corporations,				9},
		{MDR.sourceTools.src_IL_Corporations,				9},
		{MDR.sourceTools.src_IN_Corporations,				9},
		{MDR.sourceTools.src_KS_Corporations,				9},
		{MDR.sourceTools.src_KY_Corporations,				9},
		{MDR.sourceTools.src_LA_Corporations,				9},
		{MDR.sourceTools.src_MA_Corporations,				9},
		{MDR.sourceTools.src_MD_Corporations,				9},
		{MDR.sourceTools.src_ME_Corporations,				9},
		{MDR.sourceTools.src_MI_Corporations,				9},
		{MDR.sourceTools.src_MN_Corporations,				9},
		{MDR.sourceTools.src_MO_Corporations,				9},
		{MDR.sourceTools.src_MS_Corporations,				9},
		{MDR.sourceTools.src_MT_Corporations,				9},
		{MDR.sourceTools.src_NC_Corporations,				9},
		{MDR.sourceTools.src_ND_Corporations,				9},
		{MDR.sourceTools.src_NE_Corporations,				9},
		{MDR.sourceTools.src_NH_Corporations,				9},
		{MDR.sourceTools.src_NJ_Corporations,				9},
		{MDR.sourceTools.src_NM_Corporations,				9},
		{MDR.sourceTools.src_NV_Corporations,				9},
		{MDR.sourceTools.src_NY_Corporations,				9},
		{MDR.sourceTools.src_OH_Corporations,				9},
		{MDR.sourceTools.src_OK_Corporations,				9},
		{MDR.sourceTools.src_OR_Corporations,				9},
		{MDR.sourceTools.src_PA_Corporations,				9},
		{MDR.sourceTools.src_RI_Corporations,				9},
		{MDR.sourceTools.src_SC_Corporations,				9},
		{MDR.sourceTools.src_SD_Corporations,				9},
		{MDR.sourceTools.src_TN_Corporations,				9},
		{MDR.sourceTools.src_TX_Corporations,				9},
		{MDR.sourceTools.src_UT_Corporations,				9},
		{MDR.sourceTools.src_VA_Corporations,				9},
		{MDR.sourceTools.src_VT_Corporations,				9},
		{MDR.sourceTools.src_WA_Corporations,				9},
		{MDR.sourceTools.src_WI_Corporations,				9},
		{MDR.sourceTools.src_WV_Corporations,				9},
		{MDR.sourceTools.src_WV_Hist_Corporations,	9},
		{MDR.sourceTools.src_WY_Corporations,				9},
		{MDR.sourceTools.src_Utilities,							10},
		{MDR.sourceTools.src_InfutorNare, 					11}, // Email
		{MDR.sourceTools.src_Thrive_PD_POE_Email,		11}, // Email data derived from Thrive PD data
		{MDR.sourceTools.src_Alloymedia_consumer,	  11}, // Email
		{MDR.sourceTools.src_Acquiredweb,						11}, // Email
		{MDR.sourceTools.src_Entiera,								11}, // Email
		{MDR.sourceTools.src_Ibehavior,   					11}, // Email
		{MDR.sourceTools.src_Impulse,								11}, // Email
		{MDR.sourceTools.src_MediaOne,							11}, // Email
		{MDR.sourceTools.src_Thrive_LT_POE_Email,		11}, // Email data derived from Thrive LT data
		{MDR.sourceTools.src_OutwardMedia,					11}, // Email
		{MDR.sourceTools.src_Wired_Assets_Email,		11}, // Email		
		{MDR.sourceTools.src_SalesChannel,					12},
		{MDR.sourceTools.src_Thrive_PD,	      			13},
		{MDR.sourceTools.src_Thrive_LT,	      			13},	
		{MDR.sourceTools.src_Zoom,									14}
   ],Layouts.source_hierarchy);

  export File_Source_Hierarchy := ds_source_hierarchy;
