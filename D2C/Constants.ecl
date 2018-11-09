IMPORT MDR;
EXPORT Constants := MODULE

	
		
	EXPORT CCWRestrictedSources := [
		MDR.sourceTools.src_EMerge_CCW_NY
		];

	
	EXPORT BusinessHeaderRestrictedSources := [
		MDR.sourceTools.src_AK_Fishing_boats,		MDR.sourceTools.src_DEA,									MDR.sourceTools.src_Dunn_Bradstreet,  		 MDR.sourceTools.src_Dunn_Bradstreet_Fein,  
		MDR.sourceTools.src_EBR,  							MDR.sourceTools.src_Experian_FEIN_Rest, 	MDR.sourceTools.src_Experian_FEIN_Unrest,  MDR.sourceTools.src_FL_FBN,  
		MDR.sourceTools.src_IRS_Non_Profit,  		MDR.sourceTools.src_LnPropV2_Fares_Asrs,  MDR.sourceTools.src_LnPropV2_Fares_Deeds,  MDR.sourceTools.src_FL_Veh,
		MDR.sourceTools.src_ID_Veh,         		MDR.sourceTools.src_KY_Veh,               MDR.sourceTools. src_MA_Veh,      				 MDR.sourceTools.src_ME_Veh,                  
		MDR.sourceTools.src_MN_Veh,             MDR.sourceTools.src_MS_Veh,               MDR.sourceTools.src_MT_Veh,                MDR.sourceTools.src_NC_Veh,                   
		MDR.sourceTools.src_ND_Veh,             MDR.sourceTools.src_NE_Veh,               MDR.sourceTools.src_NM_Veh,                MDR.sourceTools.src_NV_Veh,                
		MDR.sourceTools.src_OH_Veh,             MDR.sourceTools.src_TX_Veh,               MDR.sourceTools.src_UT_Veh,                MDR.sourceTools.src_WI_Veh,                  
		MDR.sourceTools.src_WY_Veh, 						MDR.sourceTools.src_AK_Experian_Veh,      MDR.sourceTools.src_AL_Experian_Veh,       MDR.sourceTools.src_AR_Experian_Veh,
		MDR.sourceTools.src_AZ_Experian_Veh,    MDR.sourceTools.src_CO_Experian_Veh,      MDR.sourceTools.src_CT_Experian_Veh,       MDR.sourceTools.src_DC_Experian_Veh,         
		MDR.sourceTools.src_DE_Experian_Veh,    MDR.sourceTools.src_FL_Experian_Veh,      MDR.sourceTools.src_GA_Experian_Veh,       MDR.sourceTools.src_IA_Experian_Veh,          
		MDR.sourceTools.src_ID_Experian_Veh,    MDR.sourceTools.src_IL_Experian_Veh,      MDR.sourceTools.src_KS_Experian_Veh,       MDR.sourceTools.src_KY_Experian_Veh,          
		MDR.sourceTools.src_LA_Experian_Veh,    MDR.sourceTools.src_MA_Experian_Veh,      MDR.sourceTools.src_MD_Experian_Veh,       MDR.sourceTools.src_ME_Experian_Veh,           
		MDR.sourceTools.src_MI_Experian_Veh,    MDR.sourceTools.src_MN_Experian_Veh,      MDR.sourceTools.src_MS_Experian_Veh,       MDR.sourceTools.src_MT_Experian_Veh,          
		MDR.sourceTools.src_NC_Experian_Veh,    MDR.sourceTools.src_ND_Experian_Veh,      MDR.sourceTools.src_NE_Experian_Veh,       MDR.sourceTools.src_NM_Experian_Veh,         
		MDR.sourceTools.src_NV_Experian_Veh,    MDR.sourceTools.src_NY_Experian_Veh,      MDR.sourceTools.src_OH_Experian_Veh,       MDR.sourceTools.src_OK_Experian_Veh,           
		MDR.sourceTools.src_OR_Experian_Veh,    MDR.sourceTools.src_RI_Experian_Veh,      MDR.sourceTools.src_SC_Experian_Veh,       MDR.sourceTools.src_SD_Experian_Veh,           
		MDR.sourceTools.src_TN_Experian_Veh,    MDR.sourceTools.src_TX_Experian_Veh,      MDR.sourceTools.src_UT_Experian_Veh,       MDR.sourceTools.src_VT_Experian_Veh,           
		MDR.sourceTools.src_WA_Experian_Veh,    MDR.sourceTools.src_WI_Experian_Veh,      MDR.sourceTools.src_WY_Experian_Veh,       MDR.sourceTools.src_AK_Watercraft, 
		MDR.sourceTools.src_AL_Watercraft,			MDR.sourceTools.src_AR_Watercraft,				MDR.sourceTools.src_AZ_Watercraft,         MDR.sourceTools.src_CO_Watercraft,        
		MDR.sourceTools.src_CT_Watercraft,      MDR.sourceTools.src_FL_Watercraft,        MDR.sourceTools.src_GA_Watercraft,         MDR.sourceTools.src_IA_Watercraft,             
		MDR.sourceTools.src_IL_Watercraft,      MDR.sourceTools.src_KS_Watercraft,        MDR.sourceTools.src_KY_Watercraft,         MDR.sourceTools.src_MA_Watercraft,             
		MDR.sourceTools.src_MD_Watercraft,      MDR.sourceTools.src_ME_Watercraft,        MDR.sourceTools.src_MI_Watercraft,         MDR.sourceTools.src_MN_Watercraft,             
		MDR.sourceTools.src_MS_Watercraft,      MDR.sourceTools.src_MT_Watercraft,        MDR.sourceTools.src_NC_Watercraft,         MDR.sourceTools.src_ND_Watercraft,            
		MDR.sourceTools.src_NE_Watercraft,      MDR.sourceTools.src_NH_Watercraft,        MDR.sourceTools.src_NM_Watercraft,				 MDR.sourceTools.src_NV_Watercraft,             
		MDR.sourceTools.src_NY_Watercraft,      MDR.sourceTools.src_OH_Watercraft,        MDR.sourceTools.src_SC_Watercraft,         MDR.sourceTools.src_TN_Watercraft,            
		MDR.sourceTools.src_TX_Watercraft,      MDR.sourceTools.src_UT_Watercraft,        MDR.sourceTools.src_VA_Watercraft,         MDR.sourceTools.src_WI_Watercraft,            
		MDR.sourceTools.src_WV_Watercraft,      MDR.sourceTools.src_WY_Watercraft,        MDR.sourceTools.src_WA_Watercraft
	];
	
  EXPORT DOCRestrictedVendors := ['MH'];
 
  EXPORT DOCRestrictedDataTypes := ['5']; // Arrest records go into Offender and Court_offense keys.
 
  EXPORT InfutorRestrictedSources := [MDR.sourceTools.src_InfutorTRK];  
		
	//EXPORT GongRestrictedSources := [];
	EXPORT PhonesPlusRestrictedSources := [MDR.sourceTools.src_InfutorCID, MDR.sourceTools.src_Infutor_Veh];
	//EXPORT WatchdogRestrictedSources := [MDR.sourceTools.src_Infutor_Veh, MDR.sourceTools.src_InfutorNarc];
	//EXPORT WatercraftRestrictedSources := [MDR.sourceTools.src_Infutor_Watercraft];
	//EXPORT VehiclesRestrictedSources := [MDR.sourceTools.src_Infutor_Veh, MDR.sourceTools.src_Infutor_Motorcycle_Veh];
	//EXPORT VehicleV2RestrictedSources := [MDR.sourceTools.src_Infutor_Veh];

   
/* EXPORT ATFRestrictedSources */
/* EXPORT Corp2RestrictedSources */
/* EXPORT DLV2RestrictedSources */
/* EXPORT EBRRestrictedSources */
/* EXPORT PAWV2RestrictedSources */ 
/* EXPORT UCCV2RestrictedSources */
/* EXPORT VotersV2RestrictedSources */

//------------------------------------------------------------------------------------------------------//
											/* These are the newly verified sources */
//------------------------------------------------------------------------------------------------------//

	EXPORT DeathRestrictedSources := [
		MDR.sourceTools.src_Death_CA, 
		MDR.sourceTools.src_Death_MI, 
		MDR.sourceTools.src_Death_VA, 
		MDR.sourceTools.src_Enclarity,
		MDR.sourceTools.src_Death_Restricted
		];
//------------------------------------------------------------------------------------------------------//
	 EXPORT LiensRestrictedSources(string tmsid) := tmsid[1..2] = 'CA'; // California liens, source code ['LF']

//------------------------------------------------------------------------------------------------------//
/*  CivilCourtKeys :-  
		Key : thor_data400::key::civil_court_party::qa::caseid.  (civil_court.key_caseID)
		Source field : vendor 
*/

	EXPORT CivilCourtRestrictedSources := ['25',	//NY-STATEWIDE-CIV-CRT
																				 '60',	//PA-BUCKS-CIVIL-COURT
																         '90',	//TX-HarrisCntyCivil
																         '30'];//NY-UPSTATE-CIV-COURT

//------------------------------------------------------------------------------------------------------//
/*  EmailDataKeys :-  
		Key : thor_200::key::email_data::qa::did 
					thor_200::key::email_data::autokey::qa::payload 
					thor_200::key::email_data::qa::email_addresses 
		Source field : email_src
*/	
	EXPORT EmailRestrictedSources := [MDR.sourceTools.src_Entiera,
																		MDR.sourceTools.src_Impulse,
																		MDR.sourceTools.src_Wired_Assets_Email
																		//18259
																		];
 

//------------------------------------------------------------------------------------------------------//
/*	PersonHeaderKeys 
		Keys :  
			thor_data400::key::header::dmv_restricted_qa
			thor_data400::key::header_address_qa
			thor_data400::key::header_nbr_uid_qa
			thor_data400::key::header_qa
		Source field : src
 */

 EXPORT PersonHeaderRestrictedSources := [
			MDR.sourceTools.src_WV_Watercraft,					
			MDR.sourceTools.src_MN_Watercraft, 							
			MDR.sourceTools.src_MS_Watercraft,
   		MDR.sourceTools.src_NV_Watercraft,  				
			MDR.sourceTools.src_Bankruptcy, 						
			MDR.sourceTools.src_US_Coastguard,
   		MDR.sourceTools.src_CO_Watercraft, 					
			MDR.sourceTools.src_Death_Master, 							
			MDR.sourceTools.src_Death_State,
   		MDR.sourceTools.src_EMerge_Hunt, 						
			MDR.sourceTools.src_EMerge_Fish, 						
			MDR.sourceTools.src_EMerge_CCW,
   		MDR.sourceTools.src_EMerge_Boat, 						
			MDR.sourceTools.src_CT_Watercraft, 							
			MDR.sourceTools.src_Gong_Neustar,
   		MDR.sourceTools.src_Gong_History, 					
			MDR.sourceTools.src_GA_Watercraft, 							
			MDR.sourceTools.src_KS_Watercraft,
   		MDR.sourceTools.src_IA_Watercraft, 					
			MDR.sourceTools.src_MA_Watercraft, 							
			MDR.sourceTools.src_LnPropV2_Lexis_Asrs,
   		MDR.sourceTools.src_Liens, 									
			MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs, 	
			MDR.sourceTools.src_AL_Watercraft,
   		MDR.sourceTools.src_NC_Watercraft, 					
			MDR.sourceTools.src_OH_Watercraft, 							
			MDR.sourceTools.src_Professional_License,
   		MDR.sourceTools.src_IL_Watercraft, 					
			MDR.sourceTools.src_ME_Watercraft, 							
			MDR.sourceTools.src_AR_Watercraft,
   		MDR.sourceTools.src_American_Students_List, 
			MDR.sourceTools.src_SC_Watercraft, 							
			MDR.sourceTools.src_TN_Watercraft,
   		MDR.sourceTools.src_Voters_v2, 							
			MDR.sourceTools.src_VA_Watercraft, 							
			MDR.sourceTools.src_Targus_White_pages
];

END;