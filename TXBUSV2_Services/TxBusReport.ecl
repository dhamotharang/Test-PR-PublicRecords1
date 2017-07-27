export TxBusReport(TxbusV2_services.Interfaces.Search_Params in_params) := FUNCTION
			
	ids := 		TXBUSV2_Services.TxbusSearch_Ids(in_params,FALSE,in_params.is_search);
							
	TxBus_r   := TxbusV2_services.Txbus_raw .Report_view.
									by_TaxpayerNumber(ids,,in_params.is_search);

	RETURN TxBus_r;

END;