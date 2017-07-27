/*--SOAP--
<message name="CleanerSetTracingOnService">
</message>
*/
/*--INFO-- This service turns on the Address Cleaner Tracing.*/

export CleanerSetTracingOnService() := 
FUNCTION
	return AddrCleanLib.SetTracing(TRUE);
END;