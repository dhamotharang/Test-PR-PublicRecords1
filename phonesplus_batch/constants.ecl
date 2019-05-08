IMPORT Gateway;

	EXPORT constants := MODULE
		EXPORT BOOLEAN ExcludeCurrentGong:= FALSE;
		EXPORT BOOLEAN IncludeTargus:= FALSE;
		EXPORT BOOLEAN IncludeQsent:= FALSE;
		EXPORT BOOLEAN IncludeTargusWireless:= FALSE;
		EXPORT DATASET (Gateway.Layouts.Config) Gateways := DATASET ([], Gateway.Layouts.Config);
	END;