import risk_indicators;

export Layout_RecoverScore_Batch_Input := record
	risk_indicators.Layout_Batch_In;

	string1	address_type := '';
	string1	address_confidence := '';
	string1	phone_type := '';
	string2	debt_type := '';
	string15	debt_amount := '';
	string8	charge_off_date := '';
	string8	open_date := '';
	string1	deceased := ''; 
	string2	bankruptcy := '';

	string3	custom_input_1 := '';	
	string3	custom_input_2 := '';	
	string3	custom_input_3 := '';	
	string3	custom_input_4 := '';	
	string3	custom_input_5 := '';	
	string3	custom_input_6 := '';	
end;