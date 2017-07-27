import doxie, business_header,TxBus;

export TxBusSearch(TxbusV2_services.Interfaces.Search_Params in_params) := FUNCTION

	Doxie.MAC_Header_Field_Declare()
	
	IncludeDeepDive := ~NoDeepDive;
			
	ids := 		TXBUSV2_Services.TxbusSearch_Ids(in_params,IncludeDeepDive);
							
	TxBus_r   := TxbusV2_services.Txbus_raw .search_view.
												by_TaxpayerNumber(ids, ssn_mask_value,in_params.is_search);

	rsrt := sort(TxBus_r(penalt <= in_params.pt),if(isDeepDive,1,0), penalt,dt_last_seen,dt_first_seen, record);

	// doxie.MAC_Marshall_Results(rsrt,rmar);	

	// RETURN rmar;
	
	RETURN rsrt;

END;