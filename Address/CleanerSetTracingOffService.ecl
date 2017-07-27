/*--SOAP--
<message name="CleanerSetTracingOffService">
</message>
*/
/*--INFO-- This service turns off the Address Cleaner Tracing.*/

export CleanerSetTracingOffService() := 
FUNCTION
	return AddrCleanLib.SetTracing(FALSE);
END;