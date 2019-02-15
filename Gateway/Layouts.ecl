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
	
  export DeltabaseSQL := module
		//  Layouts for Deltabase SQL soap calls
		export value_rec := record
			string100 value {xpath('Value')};
		end;
		export input_rec := record
			string Select {xpath('Select')};  // prepared sql statement  - with '?' placeholders for bind variable values
			dataset(value_rec) Parameters {xpath('Parameters/Parameter')}; // to be used to pass bind variables
		end;
  end;

end;
