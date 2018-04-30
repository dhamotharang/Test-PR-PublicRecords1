/* *********************************************************************************************
PRTE2_LNProperty_Ins.Proc_Copy_to_Trio

NEW EARLY INITIALIZATION - 
This takes the NEW LNProperty base file (new logical names, new SF names, same layout) and transforms and saves 3 files with data
This likely needs some filtering instead of sending a new record for each CSV record to all three files.
********************************************************************************************* */

IMPORT PromoteSupers, PRTE2_LNProperty, ln_propertyv2, PRTE2_LNProperty_Ins;

DataDS 														:= PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS;
LNProperty_Base_SF_Deed_Layout		:= PRTE2_LNProperty_Ins.Files.LNProperty_Base_SF_Deed;
LNProperty_Base_SF_Tax_Layout			:= PRTE2_LNProperty_Ins.Files.LNProperty_Base_SF_Tax;
LNProperty_Base_SF_Search_Layout	:= PRTE2_LNProperty_Ins.Files.LNProperty_Base_SF_Search;

//-----------------------------------------------------------------------------------
ln_propertyv2.layout_deed_mortgage_common_model_base trxDeed(DataDS L) := TRANSFORM
	SELF.fares_unformatted_apn := '';
	SELF.ln_ownership_rights := '';
	SELF.ln_relationship_type := '';
	SELF.ln_buyer_mailing_country_code := '';
	SELF.ln_seller_mailing_country_code := '';
	SELF := L;
END;
ln_propertyv2.layout_deed_mortgage_common_model_base trxTax(DataDS L) := TRANSFORM
	SELF.fares_unformatted_apn := '';
	SELF.ln_ownership_rights := '';
	SELF.ln_relationship_type := '';
	SELF.ln_buyer_mailing_country_code := '';
	SELF.ln_seller_mailing_country_code := '';
	SELF := L;
END;
ln_propertyv2.layout_property_common_model_base trxSearch(DataDS L) := TRANSFORM
	SELF.fares_unformatted_apn := '';
	SELF.ln_ownership_rights := '';
	SELF.ln_relationship_type := '';
	SELF.ln_mailing_country_code := '';
	SELF.ln_property_name := '';
	SELF.ln_property_name_type := '';
	SELF.ln_land_use_category := '';
	SELF.ln_lot := '';
	SELF.ln_block := '';
	SELF.ln_unit := '';
	SELF.ln_subfloor := '';
	SELF.ln_floor_cover := '';
	SELF.ln_mobile_home_indicator := '';
	SELF.ln_condo_indicator := '';
	SELF.ln_property_tax_exemption := '';
	SELF.ln_veteran_status := '';
	SELF.ln_old_apn_indicator := '';
	SELF := L;
END;
//-----------------------------------------------------------------------------------
Deed_DS		:= PROJECT(DataDS,trxDeed(LEFT));
Tax_DS		:= PROJECT(DataDS,trxTax(LEFT));
Search_DS		:= PROJECT(DataDS,trxSearch(LEFT));

	//-------------- These 3 files are the interface to the Boca build system -----------------
//********************************************************************************************* 
PromoteSupers.MAC_SF_BuildProcess(Deed_DS,LNProperty_Base_SF_Deed_Layout, writefile_deed);
PromoteSupers.MAC_SF_BuildProcess(Tax_DS,LNProperty_Base_SF_Tax_Layout, writefile_search);
PromoteSupers.MAC_SF_BuildProcess(Search_DS,LNProperty_Base_SF_Search_Layout, writefile_tax);
sequential(writefile_deed, writefile_search, writefile_tax);
//********************************************************************************************* 

