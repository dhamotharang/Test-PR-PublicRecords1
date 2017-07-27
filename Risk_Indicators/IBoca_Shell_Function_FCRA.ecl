import Gateway;
export IBoca_Shell_Function_FCRA(
	DATASET (risk_indicators.Layout_input) pre_iid,
	DATASET (Gateway.Layouts.Config) gateways,
	BS_LIBIN args
	) := INTERFACE
		export GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) results;

END;