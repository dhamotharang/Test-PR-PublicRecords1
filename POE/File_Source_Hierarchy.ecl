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
	
  ds_source_hierarchy := dataset([
		{MDR.sourceTools.src_PSS						,				0},
    {MDR.sourceTools.src_Spoke					,				1},
		{MDR.sourceTools.src_Zoom						,				2},
		//{MDR.sourceTools.src_Jigsaw					,				3},  //*** Removed Jigsaw due to expiration of contract with the vendor -  as per Joe Lezcano
		{MDR.sourceTools.src_Garnishments		,				4},
		{MDR.sourceTools.src_AK_Corporations,				5},
		{MDR.sourceTools.src_AL_Corporations,				5},
		{MDR.sourceTools.src_AR_Corporations,				5},
		{MDR.sourceTools.src_AZ_Corporations,				5},
		{MDR.sourceTools.src_CA_Corporations,				5},
		{MDR.sourceTools.src_CO_Corporations,				5},
		{MDR.sourceTools.src_CT_Corporations,				5},
		{MDR.sourceTools.src_DC_Corporations,				5},
		{MDR.sourceTools.src_FL_Corporations,				5},
		{MDR.sourceTools.src_GA_Corporations,				5},
		{MDR.sourceTools.src_HI_Corporations,				5},
		{MDR.sourceTools.src_IA_Corporations,				5},
		{MDR.sourceTools.src_ID_Corporations,				5},
		{MDR.sourceTools.src_IL_Corporations,				5},
		{MDR.sourceTools.src_IN_Corporations,				5},
		{MDR.sourceTools.src_KS_Corporations,				5},
		{MDR.sourceTools.src_KY_Corporations,				5},
		{MDR.sourceTools.src_LA_Corporations,				5},
		{MDR.sourceTools.src_MA_Corporations,				5},
		{MDR.sourceTools.src_MD_Corporations,				5},
		{MDR.sourceTools.src_ME_Corporations,				5},
		{MDR.sourceTools.src_MI_Corporations,				5},
		{MDR.sourceTools.src_MN_Corporations,				5},
		{MDR.sourceTools.src_MO_Corporations,				5},
		{MDR.sourceTools.src_MS_Corporations,				5},
		{MDR.sourceTools.src_MT_Corporations,				5},
		{MDR.sourceTools.src_NC_Corporations,				5},
		{MDR.sourceTools.src_ND_Corporations,				5},
		{MDR.sourceTools.src_NE_Corporations,				5},
		{MDR.sourceTools.src_NH_Corporations,				5},
		{MDR.sourceTools.src_NJ_Corporations,				5},
		{MDR.sourceTools.src_NM_Corporations,				5},
		{MDR.sourceTools.src_NV_Corporations,				5},
		{MDR.sourceTools.src_NY_Corporations,				5},
		{MDR.sourceTools.src_OH_Corporations,				5},
		{MDR.sourceTools.src_OK_Corporations,				5},
		{MDR.sourceTools.src_OR_Corporations,				5},
		{MDR.sourceTools.src_PA_Corporations,				5},
		{MDR.sourceTools.src_RI_Corporations,				5},
		{MDR.sourceTools.src_SC_Corporations,				5},
		{MDR.sourceTools.src_SD_Corporations,				5},
		{MDR.sourceTools.src_TN_Corporations,				5},
		{MDR.sourceTools.src_TX_Corporations,				5},
		{MDR.sourceTools.src_UT_Corporations,				5},
		{MDR.sourceTools.src_VA_Corporations,				5},
		{MDR.sourceTools.src_VT_Corporations,				5},
		{MDR.sourceTools.src_WA_Corporations,				5},
		{MDR.sourceTools.src_WI_Corporations,				5},
		{MDR.sourceTools.src_WV_Corporations,				5},
		{MDR.sourceTools.src_WV_Hist_Corporations,	5},
		{MDR.sourceTools.src_WY_Corporations,				5},
		{MDR.sourceTools.src_Utilities,							6},
		{MDR.sourceTools.src_Acquiredweb,						7}, // Email
		{MDR.sourceTools.src_Entiera,								7}, // Email
		{MDR.sourceTools.src_Impulse,								7}, // Email
		{MDR.sourceTools.src_Wired_Assets_Email,		7}, // Email
		{MDR.sourceTools.src_MediaOne,							7}, // Email
		{MDR.sourceTools.src_OutwardMedia,					7}, // Email
		{MDR.sourceTools.src_Ibehavior,   					7}, // Email
		{MDR.sourceTools.src_Alloymedia_consumer,	  7}, // Email
		{MDR.sourceTools.src_Thrive_LT_POE_Email,		7}, // Email data derived from Thrive LT data
		{MDR.sourceTools.src_Thrive_PD_POE_Email,		7},	// Email data derived from Thrive PD data
		{MDR.sourceTools.src_InfutorNare, 					7}, // Email
		{MDR.sourceTools.src_SalesChannel,					8},
		{MDR.sourceTools.src_Thrive_LT,	      			9},		
		{MDR.sourceTools.src_Thrive_PD,	      			9},		
		{MDR.sourceTools.src_One_Click_Data,				10},
		{MDR.sourceTools.src_Teletrack,							11}
   ],Layouts.source_hierarchy);

  export File_Source_Hierarchy := ds_source_hierarchy;
