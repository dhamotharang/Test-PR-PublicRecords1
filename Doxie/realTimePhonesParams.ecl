IMPORT  AutoStandardI, Gateway;

EXPORT realTimePhonesParams := MODULE
	EXPORT searchParams := INTERFACE(Doxie.IDataAccess)
		EXPORT STRING11  SSN := '';
		EXPORT STRING30  LastName := '';
		EXPORT DATASET (Gateway.Layouts.Config) Gateways := DATASET([], Gateway.Layouts.Config);
	END;
END;

