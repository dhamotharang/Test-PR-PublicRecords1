EXPORT doxie_MAC_Field_Declare(boolMakeDataset = 'false', IsFCRA = false) := MACRO
  IMPORT doxie, AutoStandardI;

	doxie.MAC_Header_Field_Declare(IsFCRA)
	#uniquename(inputbmod)
	%inputbmod% := AutoStandardI.GlobalModule(isFCRA);
	company_name_val := AutoStandardI.InterfaceTranslator.company_name_val.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.company_name_val.params));
	bdid_val := AutoStandardI.InterfaceTranslator.bdid_val.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.bdid_val.params));
//TODO: only in Business_Header.BH_SearchService
	exact_only := AutoStandardI.InterfaceTranslator.exact_only.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.exact_only.params));
	// bdid_only := AutoStandardI.InterfaceTranslator.bdid_only.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.bdid_only.params));
	// mile_radius := AutoStandardI.InterfaceTranslator.mile_radius.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.mile_radius.params));
	// use_levels_val := AutoStandardI.InterfaceTranslator.use_levels_val.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.use_levels_val.params));
	multibdid := AutoStandardI.InterfaceTranslator.multibdid.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.multibdid.params));
	// use_supergroup := AutoStandardI.InterfaceTranslator.use_supergroup.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.use_supergroup.params));
	// use_supergrouppropertyaddress := AutoStandardI.InterfaceTranslator.use_supergrouppropertyaddress.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.use_supergrouppropertyaddress.params));
//TODO: move to doxie_cbrs.mac_Selection_Declare:
 	use_supergrouppropertyaddress_val := AutoStandardI.InterfaceTranslator.use_supergrouppropertyaddress_val.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.use_supergrouppropertyaddress_val.params));
	bdid_value := AutoStandardI.InterfaceTranslator.bdid_value.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.bdid_value.params));
	company_name_value := AutoStandardI.InterfaceTranslator.company_name_value.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.company_name_value.params));
	// disregard_limits := AutoStandardI.InterfaceTranslator.disregard_limits.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.disregard_limits.params));
//TODO: move to doxie_cbrs.mac_Selection_Declare:
	enforce_limits := AutoStandardI.InterfaceTranslator.enforce_limits.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.enforce_limits.params));
//TODO: move to doxie_cbrs.mac_Selection_Declare:
	max_ceiling := AutoStandardI.InterfaceTranslator.max_ceiling.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.max_ceiling.params));
	supergroup_ds := AutoStandardI.InterfaceTranslator.supergroup_ds.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.supergroup_ds.params));
	bdid_dataset := AutoStandardI.InterfaceTranslator.bdid_dataset.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.bdid_dataset.params));
	mile_radius_value := AutoStandardI.InterfaceTranslator.mile_radius_value.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.mile_radius_value.params));
	bh_zip_value := AutoStandardI.InterfaceTranslator.bh_zip_value.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.bh_zip_value.params));
	// ds_zip0 := AutoStandardI.InterfaceTranslator.ds_zip0.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.ds_zip0.params));
	// ds_zip := AutoStandardI.InterfaceTranslator.ds_zip.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.ds_zip.params));
//TODO: only in Business_Header.BH_ProfileSearchService  
	is_compsearch := AutoStandardI.InterfaceTranslator.is_compsearch.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.is_compsearch.params));
	// isaddrsearch := AutoStandardI.InterfaceTranslator.isaddrsearch.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.isaddrsearch.params));
	// isbareaddr := AutoStandardI.InterfaceTranslator.isbareaddr.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.isbareaddr.params));
//TODO: only in Business_Header.BH_ProfileSearchService  
	is_contsearch := AutoStandardI.InterfaceTranslator.is_contsearch.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.is_contsearch.params));
//TODO: only in Business_Header.BH_ProfileSearchService  
	is_compaddrsearch := AutoStandardI.InterfaceTranslator.is_compaddrsearch.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.is_compaddrsearch.params));
#IF(boolMakeDataset)
	precs := AutoStandardI.InterfaceTranslator.precs.val(project(%inputbmod%,AutoStandardI.InterfaceTranslator.precs.params));
#END

ENDMACRO;