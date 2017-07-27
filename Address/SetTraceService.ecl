/*--SOAP--
<message name="SetTraceService">
 </message>
*/
export SetTraceService() := macro

output(addrcleanlib.SetTracing(true))

ENDMACRO;