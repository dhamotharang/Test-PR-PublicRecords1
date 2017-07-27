import Gateway;
export IBoca_Shell_Function(
	GROUPED DATASET (risk_indicators.Layout_output) iid,
	DATASET (Gateway.Layouts.Config) gateways,
	BS_LIBIN args
	) := INTERFACE
		export GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) results;

END;