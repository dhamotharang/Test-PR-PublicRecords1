export Layout_IT1O_model_in := record
	unsigned4 seq := 0;
	string1 addr_type_a := '';
	string1 addr_confidence_a := '';
	string1 phone_type_a := '';
	string1 bansmatchflag := '';
	string2 bansdispcode := '';
     string1 decsflag := '';
     string2 in_drlcstate := '';
     string2 in_debttype := '';
     string8 in_chargeoffdate := '';
     string8 in_opendate := '';
     string8 in_lastpymt := '';
     string6 in_chargeoffamt := '';
     string6 in_balance := '';
end;