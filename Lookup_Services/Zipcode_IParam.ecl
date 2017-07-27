export Zipcode_IParam := MODULE
	
	EXPORT searchParams := INTERFACE 
		Export string10 	StreetNumber := '';
		Export string28		StreetName := '';
		Export string28		City := '';
		Export string2		State := '';
		Export string5		Zip := '';
		Export boolean		isAddresses := false;
		Export boolean		isZip5 := false;
		Export boolean		isZip4ByZip5 := false;
		Export boolean		isCityListByZip5 := false;
	END;
	
END;
