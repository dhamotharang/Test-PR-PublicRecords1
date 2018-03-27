/* *********************************************************************************************

********************************************************************************************* */

IMPORT PromoteSupers, PRTE2_LNProperty, ln_propertyv2, PRTE2_LNProperty_Ins;

LNProperty_Base_SF_Deed		:= '~prct::BASE::ct::LNPropertyV2_Alpha_deed';
LNProperty_Base_SF_Tax		:= '~prct::BASE::ct::LNPropertyV2_Alpha_tax';
LNProperty_Base_SF_Search	:= '~prct::BASE::ct::LNPropertyV2_Alpha_search';

// TEMP workaround.	
LNProperty_Deed_DS 				:= DATASET([], ln_propertyv2.layout_deed_mortgage_common_model_base);
LNProperty_Tax_DS 				:= DATASET([], ln_propertyv2.layout_deed_mortgage_common_model_base);
LNProperty_Search_DS 			:= DATASET([], ln_propertyv2.layout_property_common_model_base);
// LNProperty_Deed_DS 				:= DATASET([], PRTE2_LNProperty_Ins.Layouts.DeedLayout);
// LNProperty_Tax_DS 				:= DATASET([], PRTE2_LNProperty_Ins.Layouts.TaxLayout);
// LNProperty_Search_DS 			:= DATASET([], PRTE2_LNProperty_Ins.Layouts.SearchLayout);

// these seem to break if you put them into a sequential
PromoteSupers.mac_create_superfiles(LNProperty_Base_SF_Deed);
PromoteSupers.mac_create_superfiles(LNProperty_Base_SF_Tax);
PromoteSupers.mac_create_superfiles(LNProperty_Base_SF_Search);

PromoteSupers.MAC_SF_BuildProcess(LNProperty_Deed_DS,LNProperty_Base_SF_Deed, writefile_deed);
PromoteSupers.MAC_SF_BuildProcess(LNProperty_Tax_DS,LNProperty_Base_SF_Tax, writefile_search);
PromoteSupers.MAC_SF_BuildProcess(LNProperty_Search_DS,LNProperty_Base_SF_Search, writefile_tax);

sequential(writefile_deed, writefile_search, writefile_tax);
