IMPORT doxie, BIPV2;
EXPORT Keys := module

	EXPORT Key_Salestax_CA_Bdid_Key := INDEX(Files.Key_Salestax_CA_Bdid,{bdid},{Files.Key_Salestax_CA_Bdid},Constants.Key_Salestax_CA_Bdid_Name);
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Key_Salestax_CA_Linkids, Key_Salestax_CA_Linkids_Export, Constants.Key_Salestax_CA_Linkids_Name)
	EXPORT Key_Salestax_CA_Linkids_Key := Key_Salestax_CA_Linkids_Export;

	EXPORT Key_FDIC_Bdid_Key := INDEX(Files.Key_FDIC_Bdid,{bdid},{Files.Key_FDIC_Bdid},Constants.Key_FDIC_Bdid_Name);
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Key_FDIC_Linkids, Key_FDIC_Linkids_Export, Constants.Key_FDIC_Linkids_Name)
	EXPORT Key_FDIC_Linkids_Key := Key_FDIC_Linkids_Export;
	
	EXPORT Key_Salestax_IA_Bdid_Key := INDEX(Files.Key_Salestax_IA_Bdid,{bdid},{Files.Key_Salestax_IA_Bdid},Constants.Key_Salestax_IA_Bdid_Name);
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Key_Salestax_IA_Linkids, Key_Salestax_IA_Linkids_Export, Constants.Key_Salestax_IA_Linkids_Name)
	EXPORT Key_Salestax_IA_Linkids_Key := Key_Salestax_IA_Linkids_Export;

	EXPORT Key_Irsnonprofit_Bdid_Key := INDEX(Files.Key_Irsnonprofit_Bdid,{bdid},{Files.Key_Irsnonprofit_Bdid},Constants.Key_Irsnonprofit_Bdid_Name);
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Key_Irsnonprofit_Linkids, Key_Irsnonprofit_Linkids_Export, Constants.Key_Irsnonprofit_Linkids_Name)
	EXPORT Key_Irsnonprofit_Linkids_Key := Key_Irsnonprofit_Linkids_Export;
	
	EXPORT Key_ms_workers_comp_Bdid_Key := INDEX(Files.Key_ms_workers_comp_Bdid,{bdid},{Files.Key_ms_workers_comp_Bdid},Constants.Key_ms_workers_comp_Bdid_Name);
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Key_ms_workers_comp_Linkids, Key_ms_workers_comp_Linkids_Export, Constants.Key_ms_workers_comp_Linkids_Name)
	EXPORT Key_ms_workers_comp_Linkids_Key := Key_ms_workers_comp_Linkids_Export;
	
	EXPORT Key_or_workers_comp_Bdid_Key := INDEX(Files.Key_or_workers_comp_Bdid,{bdid},{Files.Key_or_workers_comp_Bdid},Constants.Key_or_workers_comp_Bdid_Name);
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Key_or_workers_comp_Linkids, Key_or_workers_comp_Linkids_Export, Constants.Key_or_workers_comp_Linkids_Name)
	EXPORT Key_or_workers_comp_Linkids_Key := Key_or_workers_comp_Linkids_Export;
  
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Key_sec_broker_dealer_Linkids, Key_sec_broker_dealer_Linkids_Export, Constants.Key_sec_broker_dealer_Linkids_Name)
	EXPORT Key_sec_broker_dealer_Linkids_Key := Key_sec_broker_dealer_Linkids_Export;

END;