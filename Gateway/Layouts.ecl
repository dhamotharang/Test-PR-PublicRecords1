export Layouts := module

	// Additional GW configuration properties to be stored as name value pairs.
	export ConfigProperties := record
		string name;
		string val;
	end;

	// Common layout configuration to be used by ECL services performing gateway calls.
	export Config := record
		string40 	ServiceName;
		string 		Url;
		string50  TransactionId := '';
		dataset(ConfigProperties) properties := dataset([], ConfigProperties);
	end;
	
end;
