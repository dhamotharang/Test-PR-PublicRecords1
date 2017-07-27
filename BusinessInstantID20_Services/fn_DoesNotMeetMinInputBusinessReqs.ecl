IMPORT Business_Risk_BIP;

// The following function returns TRUE if the input data provided on the Business fails
// to meet minimum input requirements.
EXPORT fn_DoesNotMeetMinInputBusinessReqs( Business_Risk_BIP.Layouts.Shell le ) := 
	FUNCTION
		RETURN (le.Input.InputCheckBusName = '0' AND le.Input.InputCheckBusAltName = '0') OR le.Input.InputCheckBusAddr = '0' OR 
		       ((le.Input.InputCheckBusCity = '0' OR le.Input.InputCheckBusState = '0') AND le.Input.InputCheckBusZip = '0');

	END;