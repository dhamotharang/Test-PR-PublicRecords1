IMPORT LN_PropertyV2;

EXPORT V_Refresh_LNP_Production_Base_Files := MODULE
		EXPORT Assess := LN_PropertyV2.File_Assessment;
		EXPORT Deed := LN_PropertyV2.File_Deed;
		EXPORT Search_DID := LN_PropertyV2.File_Search_DID(err_stat[1]<>'E');
		EXPORT TaxDeed := LN_PropertyV2.File_TaxDeed;

		EXPORT AddlLegal := LN_PropertyV2.File_addl_legal;
		EXPORT AddlDeedNames := LN_PropertyV2.File_ln_deed_addlnames;
		EXPORT AddlTax := LN_PropertyV2.File_addl_Fares_tax;
		EXPORT AddlDeed := LN_PropertyV2.File_addl_fares_deed;
END;

// I think eventually create a final layout that combines all keys
// addr_search_iFields;
// addr_search_Noni;
// search_fid_iFields;
// search_fid_Noni;
// fcra_assessorKey_iFields;
// fcra_assessorKey_Noni;
// fcra_DeedsKey_iFields;
// fcra_DeedsKey_Noni;
