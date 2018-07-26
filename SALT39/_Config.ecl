EXPORT _Config := MODULE
	
	// This defines what cluster-specific values are needed by SALT
	EXPORT IConstants := INTERFACE
		EXPORT UNSIGNED JoinLimit := 10000;
		
		EXPORT STRING ESP_IPAddress;
		
		// These can be derived once we know the above, or they can be overridden
		EXPORT STRING wsattributes_port := '8145';
		EXPORT STRING attr_server := ESP_IPAddress + ':' + wsattributes_port;
	END;
	
	// This creates a concrete instance of the interface above
	EXPORT Constants := MODULE(IConstants)
		// NOTE: Most LexisNexis clusters already have a _Control.ThisEnvironment attribute defining
		// various constants including ESP_IPAddress.  If your system doesn't have that, you'll either
		// need to create it or change the ESP_IPAddress definition below.
		IMPORT _Control;
		EXPORT STRING ESP_IPAddress := _Control.ThisEnvironment.ESP_IPAddress;
	END;
	
END;
