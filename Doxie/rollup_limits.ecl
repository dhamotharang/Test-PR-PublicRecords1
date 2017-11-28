export rollup_limits :=
MODULE
	export ssns := 15;
	export ssn_hris := 10;
	
	export names := 15;
	
	export addresses := 99;
	export address_hris := 10;
	
	export dlnums := 10;
	export dlnums_lookup_limit := 20;

	export dobs := 15;
	
	export dods := 15;
	
	export phones := 10;
	export phone_hris := 10;
	
	export relatives_names := 10;
	export progressivePhone := 150;
	
	EXPORT SET OF STRING	TNT_CURRENT_SET := ['B', 'V','C'];  
	                              // same as progressive_phone.Constants.TNT_CURRENT_SET

END;