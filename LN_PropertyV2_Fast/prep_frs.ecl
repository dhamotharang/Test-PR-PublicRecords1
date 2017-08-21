IMPORT Property,LN_PropertyV2;
// Jira DF-11862 - added isfast parameter to name persist file accordingly in order to run continuous delta
EXPORT prep_frs(string pVersionDate,
								dataset(recordof(LN_PropertyV2_Fast.Layout_Raw_Fares.Deed))			  iRfrD,
								dataset(recordof(LN_PropertyV2_Fast.Layout_Raw_Fares.Assessment))	iRfrA, 
								boolean isFast
								) := MODULE
			
			SHARED pFrA		:= LN_PropertyV2_Fast.Prep_Fares_Assessment(pVersionDate,iRfrA,isfast).assessment.dNew;
			SHARED pFrD		:= LN_PropertyV2_Fast.Prep_Fares_Deed(pVersionDate,iRfrD,isfast).deed.dNew;
			SHARED pFrSA 	:= LN_PropertyV2_Fast.Prep_Fares_Assessment(pVersionDate,iRfrA,isfast).search.dNew;
			SHARED pFrSD 	:= LN_PropertyV2_Fast.Prep_Fares_Deed(pVersionDate,iRfrD,isfast).search.dNew;
			
			EXPORT writeUnmatchedFipsFile := parallel(
					LN_PropertyV2_Fast.Prep_Fares_Assessment(pVersionDate,iRfrA,isfast).writeUnmatchedFipsFile,
					LN_PropertyV2_Fast.Prep_Fares_Deed(pVersionDate,iRfrD,isfast).writeUnmatchedFipsFile
			);
			SHARED searchPrpR := pFrSA+pFrSD;
			EXPORT assessment := LN_PropertyV2_Fast.Mapping_Fares_Base(pFrD,pFrA,searchPrpR).AssessorWithC_Layout;
			EXPORT deedMortga	:= LN_PropertyV2_Fast.Mapping_Fares_Base(pFrD,pFrA,searchPrpR).DeedWithC_layout;
			EXPORT addlFLegal	:= project(LN_PropertyV2_Fast.Mapping_Fares_Base(pFrD,pFrA,searchPrpR).Addl_legalWithC_layout,
																		LN_PropertyV2_Fast.Layout_prep_addl_legal);
			EXPORT addlFrsTax	:= LN_PropertyV2_Fast.Mapping_Fares_Base(pFrD,pFrA,searchPrpR).Addl_fares_taxWithC_layout;
			EXPORT addlFrDeed	:= LN_PropertyV2_Fast.Mapping_Fares_Base(pFrD,pFrA,searchPrpR).Addl_fares_deedWithC_layout;
			EXPORT searchProp	:= project(searchPrpR,LN_PropertyV2_Fast.Layout_prep_search_prp);
END;