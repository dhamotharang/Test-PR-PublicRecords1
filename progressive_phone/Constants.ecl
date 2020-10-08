IMPORT MDR;

EXPORT Constants := MODULE;

	EXPORT premium := 'PR';
	EXPORT eda := ['ES', 'SE', 'SX', 'RL', 'AP', 'NE']; //gong
	EXPORT phones_plus := ['PP', 'TH', 'INF'];
	EXPORT phones_feedback := ['PF'];
	EXPORT util := ['UT'];
 EXPORT paw := ['WK'];
	EXPORT close_proximity := ['CL', 'CR', 'SP', 'MD'];
	EXPORT input := ['IN'];  //If 'IN' (INPUT) is the source, the most reliable data for names will be from user-supplied input.
	EXPORT input_found_inFileOne := 'XX'; //used to identify fake metronet hits where we have the phone internally so we don't hit the Metronet GW see 175166 and 177642

	//set used in final transform of progressive phone queries to output 'PR' as phone type instead of their true identities per contractual obligations.
	//used to assign metronet ('MN'), 'fake metronet' ('XX') (see above XX comment) and Equifax ('EQ') types to 'PR' - premium - thus hiding their true identities.
	EXPORT Premium_Source_Set := [MDR.sourceTools.src_Metronet_Gateway, input_found_inFileOne, MDR.sourceTools.src_Equifax];

	EXPORT Relationship := MODULE
		EXPORT Associate := ['ASSOCIATE'];
		EXPORT Associate_Other := ['ASSOCIATE BY ADDRESS', 'ASSOCIATE BY BUSINESS', 'ASSOCIATE BY PROPERTY',
																	'ASSOCIATE BY SHARED ASSOCIATES', 'ASSOCIATE BY SSN', 'ASSOCIATE BY VEHICLE'];
		EXPORT Family_Other := ['BROTHER', 'GRANDCHILD', 'GRANDDAUGHTER', 'GRANDSON', 'SIBLING', 'SISTER'];
		EXPORT Family_Close := ['DAUGHTER', 'RELATIVE', 'SON', 'CHILD'];
		EXPORT Parent := ['FATHER', 'GRANDFATHER', 'GRANDMOTHER', 'GRANDPARENT', 'MOTHER', 'PARENT'];
		EXPORT Spouse := ['HUSBAND', 'SPOUSE', 'WIFE'];
		EXPORT Subject := ['SUBJECT', 'SUBJECT AT HOUSEHOLD'];
		EXPORT Neighbor := ['NEIGHBOR'];
	END;

 // Used in progressive_phone.functions.GetPhonesV3 for the new Meta_ServLine_Type field
 EXPORT ServLine_Types := MODULE
   EXPORT Landline := 'Landline';
   EXPORT Cable    := 'Cable';
   EXPORT Wireless := 'Possible Wireless';
   EXPORT VoIP     := 'Possible VoIP';
   EXPORT Unknown  := 'Other/Unknown';
 END;

 EXPORT Switch_Type := MODULE
   EXPORT Landline := 'P'; // aka POTS
   EXPORT Wireless := 'C';
   EXPORT VoIP     := 'V';
   EXPORT Unknown  := 'U';
 END;

	EXPORT Associate_Cat := 'ASSOCIATE';
	EXPORT Associate_Other_Cat := 'ASSOCIATE_OTHER';
	EXPORT Family_Other_Cat := 'FAMILY_OTHER';
	EXPORT Family_Close_Cat := 'FAMILY_CLOSE';
	EXPORT Parent_Cat := 'PARENT';
	EXPORT Spouse_Cat := 'SPOUSE';
	EXPORT Subject_Cat := 'SUBJECT';
	EXPORT Neighbor_Cat := 'NEIGHBOR';

	EXPORT max_phone_count := 1000;
	EXPORT max_phone_count_per_account := 80;
	EXPORT max_Equifax_Phones := 3;
	EXPORT max_integrator := 35;

	EXPORT WFP_V8_CP_V3_MODEL_NAMES := ['PHONESCORE_V2', 'COLLECTIONSCORE_V3', 'COMMON_SCORE'];

	/*ContactPlusV2 & WaterfallPhonesV7 were replaced with ContactPlusV3 & WaterfallPhonesV8 in 184749
	-The enums below are used in progressive_phone.HelperFunctions.FN_GetVersion to get the correct running phones version to hit the correct scoring model:
  CP_V1  - CONTACT PLUS VERSION 1 - If phone_score_model = '' AND callMetronet (Experian) or UsePremiumSource_A (Equifax) is turned ON, we hit progressive_phone.phones_score_model_v1
	WFP_V6 - WATERFALL PHONES VERSION 6 - If phone_score_model = '' AND both callMetronet (Experian) and UsePremiumSource_A (Equifax) are turned OFF, we hit progressive_phone.phones_score_model_v1
	CP_V3  - CONTACT PLUS VERSION 3 - If phone_score_model =  'PHONESCORE_V2' or 'COLLECTIONSCORE_V3' AND callMetronet (Experian) or UsePremiumSource_A (Equifax) is turned ON, we hit Phone_Shell.PhoneScore_cp3
	WFP_V8 - WATERFALL PHONES VERSION 8 - If phone_score_model =  'PHONESCORE_V2' or 'COLLECTIONSCORE_V3' AND both callMetronet (Experian) and UsePremiumSource_A (Equifax) are turned OFF, we hit Phone_Shell.CollectionsScore_v8

	Thus, we refer to contact plus when external phone sources are called (metronet/experian or Equifax) else its Waterfall Phones.
  */
	EXPORT Running_Version := ENUM(UNSIGNED1,CP_V1=1,CP_V3=2,WFP_V6=3,WFP_V8=4);

END;
