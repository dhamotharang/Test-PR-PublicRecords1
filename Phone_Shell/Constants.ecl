EXPORT Constants := MODULE
	// Phone Restriction Mask - Controls which types of phones can be returned
	EXPORT PRM := ENUM(AllPhones = 0,
										SubjectDIDOnly = 1,
										LastNameAddressOnly = 2,
										SSNOnly = 3,
										AddressOnly = 4,
										FirstDegreeRelativeOnly = 5);
																			
	EXPORT Phone_Subject_Level := ENUM(Subject = 1,
																		 Household = 2,
																		 FirstDegreeRelative = 3,
																		 LeadToSubject = 4);
																			
	EXPORT Default_MaxPhones := 99;
	
	EXPORT maxEQP_Phones := 3;
	
	EXPORT Default_DataPermission := '000000000000000'; // Currently 9 bits - see AutoStandardI.DataPermissionI for bit definitions, by default don't turn any on

	EXPORT default_DataRestriction := '000001000100110000000000'; 

	EXPORT Default_InsuranceVerificationAgeLimit := 730; // In days (2 Years)

	EXPORT Default_SPIIAccessLevel := ''; // Should have 5A or 5B to use TransUnion Gateway
	
	EXPORT HeaderSearchDate := 1826; // 5 Years (Including 1 extra day for leap years) since this is the oldest phone search (EDAHistory)
	
	EXPORT HeaderSixMonthsDate := 183; // 6 Months is used in Phones Plus and EDA Search by Address
	
	//if position 24 is populated then do not run Equifax	
	EXPORT posEquifaxRestriction := 24;
	
	EXPORT Default_PhoneScore := 217;
	
	EXPORT EquiaxDRMCheck(string DataRestrictionMask) := (DataRestrictionMask[posEquifaxRestriction] = '0' or DataRestrictionMask[posEquifaxRestriction] = '');

	EXPORT Src_Equifax := 'EQP';
  
  // List of sources the Phone Shell will allow through and count for PhonesPlus
  // Any source (in src_all in the key) not on this list will be ignored. 
  // Original list pulled from Phonesplus_V2.Translation_Codes.source_bitmap_code
  // but will differ when new sources are added to the key that we aren't ready for 
  // the Phone Shell to use yet. We will add them to this list when we're ready.
  // Since we are using bitmap masking for the actual filtering, this list is more for
  // reference/future use (easier to read than 1/0's) and that's why it's commented out.
/*
 EXPORT Set_PhonesPlus_AllowedSources := [        MDR.sourceTools.src_InfutorCID									  
    ,MDR.sourceTools.src_Cellphones_Kroll					   ,MDR.sourceTools.src_Cellphones_Traffix				
    ,MDR.sourceTools.src_Cellphones_Nextones     ,MDR.sourceTools.src_Intrado										
    ,MDR.sourceTools.src_Targus_White_pages	     ,MDR.sourceTools.src_Pcnsr											        
    ,MDR.sourceTools.src_Gong_History            ,MDR.sourceTools.src_Equifax
    ,MDR.sourceTools.src_Utilities               ,MDR.sourceTools.src_LnPropV2_Fares_Asrs
    ,MDR.sourceTools.src_Voters_v2               ,MDR.sourceTools.src_Util_Work_Phone
    ,MDR.sourceTools.src_American_Students_List  ,MDR.sourceTools.src_Professional_License
    ,MDR.sourceTools.src_Certegy                 ,MDR.sourceTools.src_EMerge_Hunt
    ,MDR.sourceTools.src_EMerge_Master           ,MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs
    ,MDR.sourceTools.src_LnPropV2_Lexis_Asrs     ,MDR.sourceTools.src_KY_Watercraft
    ,MDR.sourceTools.src_EMerge_Boat             ,MDR.sourceTools.src_VA_Watercraft
    ,MDR.sourceTools.src_NC_Watercraft           ,MDR.sourceTools.src_TUCS_Ptrack
    ,MDR.sourceTools.src_EMerge_Cens             ,MDR.sourceTools.src_Federal_Firearms
    ,MDR.sourceTools.src_EMerge_Fish             ,MDR.sourceTools.src_Federal_Explosives
    ,MDR.sourceTools.src_MD_Watercraft           ,MDR.sourceTools.src_Miscellaneous
    ,MDR.sourceTools.src_MO_Veh                  ,MDR.sourceTools.src_MO_DL
    ,MDR.sourceTools.src_MO_Experian_Veh         ,MDR.sourceTools.src_Experian_Credit_Header
    ,MDR.sourceTools.src_MO_Watercraft           ,MDR.sourceTools.src_Wired_Assets_Royalty
    ,MDR.sourceTools.src_Wired_Assets_Owned 			  ,MDR.sourceTools.src_ZUtil_Work_Phone
    ,MDR.sourceTools.src_ZUtilities              ,MDR.sourceTools.src_InquiryAcclogs
    ,MDR.sourceTools.src_TU_CreditHeader         ,MDR.sourceTools.src_Ibehavior   
	   ,MDR.sourceTools.src_thrive_lt									      ,MDR.sourceTools.src_thrive_pd	 				
    ,MDR.sourceTools.src_AlloyMedia_Consumer    	,MDR.sourceTools.src_Link2tek
   ];
*/
 
 // This is the mask corresponding to the list above and the order of the bits in
 // Phonesplus_V2.Translation_Codes.source_bitmap_code indicating which bits (sources)
 // we are allowing. This is in order to be able to filter out unwanted bits from src_all 
 // in the keys to create an updated src_all for the Phone Shell.
 // When our list of allowed sources changes, this should change as well.
 // Also if for some reason the order of sources in the bits of src_all are changed, this changes too.
 // Currently 47 sources accepted in 48 bits (9th bit empty/not used, going 'backwards')
 // whole string is 64 bits, any bits not listed should be zero automatically, can fill some extras with zeroes as safety net
    EXPORT PhonesPlus_AllowedSourcesMask := '0000000000000000111111111111111111111111111111111111111011111111';
 // EXPORT PhonesPlus_AllowedSourcesMask := '0000000000000000111111111111111111111111111111111111101011111111'; // debug mask pretending UT is not allowed
 // EXPORT PhonesPlus_AllowedSourcesMask := '0000000000000000111111111111111111101111111111111111111011111111'; // debug mask pretending E2 is not allowed
 // EXPORT PhonesPlus_AllowedSourcesMask := '0000000000000000111111111111111111111111111111111011111011111111'; // debug mask pretending SL is not allowed
 // EXPORT PhonesPlus_AllowedSourcesMask := '0000000000000000111111011111111111111111111111111111111011111111'; // debug mask pretending IQ is not allowed
 // EXPORT PhonesPlus_AllowedSourcesMask := '0000000000000000111111111111111111111111111111111110111011111111'; // debug mask pretending VO is not allowed
 
 // This list (obtained from the Data Team's MDR.SourceTools file - it's not in RoxieDev
 // is all the sources that are considered 'header' sources when filling out the Vendor and Src fields
 // in the PhonesPlus key data. Our Allow List logic will need to use this list as well
 // to update Vendor and Src as needed when we remove disallowed sources from src_all
 // The logic:
 // If the first '1' or 'on' bit in src_all (going backwards) is on this list
 // then VENDOR = HD and SRC = the two-letter code for that bit in src_all.
 // If the first '1' or 'on' bit in src_all (going backwards) is NOT on this list
 // then VENDOR = the two-letter code for the bit in src_all and SRC is blank.
 //
 // As above, we are using bitmap masking for the actual filtering, this list is more for
 // reference/future use (easier to read than 1/0's) and that's why it's commented out.
 /*
 export set_Phonesplus_Header := [
		 MDR.sourceTools.src_Equifax										      ,MDR.sourceTools.src_LnPropV2_Fares_Asrs				
  ,MDR.sourceTools.src_Voters_v2							       ,MDR.sourceTools.src_American_Students_List
		,MDR.sourceTools.src_Professional_License			,MDR.sourceTools.src_Certegy										
  ,MDR.sourceTools.src_EMerge_Hunt						     	,MDR.sourceTools.src_EMerge_Master
		,MDR.sourceTools.src_TU_CreditHeader			   		,MDR.sourceTools.src_LnPropV2_Lexis_Asrs				
  ,MDR.sourceTools.src_KY_Watercraft						    ,MDR.sourceTools.src_EMerge_Boat
		,MDR.sourceTools.src_VA_Watercraft						    ,MDR.sourceTools.src_NC_Watercraft							
  ,MDR.sourceTools.src_EMerge_Cens							     ,MDR.sourceTools.src_Federal_Firearms
		,MDR.sourceTools.src_EMerge_Fish							     ,MDR.sourceTools.src_Federal_Explosives					
  ,MDR.sourceTools.src_MD_Watercraft					    	,MDR.sourceTools.src_Miscellaneous
		,MDR.sourceTools.src_MO_Veh								       		,MDR.sourceTools.src_MO_DL											
  ,MDR.sourceTools.src_MO_Experian_Veh					   ,MDR.sourceTools.src_Experian_Credit_Header
		,MDR.sourceTools.src_MO_Watercraft				    		,MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs 
	];
 */
  
 // This is the mask corresponding to the list above
 export PhonesPlus_HeaderSourceMask :=   '0000000000000000000001000001111111111101111111111101101000000000';
END;