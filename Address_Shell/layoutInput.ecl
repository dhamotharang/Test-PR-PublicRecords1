IMPORT iesp, PropertyCharacteristics_Services, PropertyCharacteristics;

SHARED options := RECORD
	STRING20 seq := '';
	STRING2 GLBPurpose := '';
	STRING2 DPPAPurpose := '';
	STRING50 DataRestrictionMask := '';
	STRING20 AccountNumber := '';
END;

SHARED address := RECORD
	iesp.share.t_Address;
	STRING10 GeoLat := '';
	STRING11 GeoLong := '';
	STRING12 GeoLink := '';
	STRING4 Err_Stat := '';
END;

EXPORT layoutInput := RECORD
	options;
	address;
END;