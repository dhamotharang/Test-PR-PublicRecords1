EXPORT Layout_Best := RECORD
		Spokeo.Layout_Out;
		string70			BestAddressStreet;
		string40			BestAddressCityStateZip;
		string10			BestAddressLatitude;
		string11			BestAddressLongitude;
		string2				BestAddressAddressType;
		integer				best_first_seen;
		integer				best_last_seen;
		unsigned8			BestAddressId;
END;