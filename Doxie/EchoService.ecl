/*--SOAP--
<message name="EchoService">
</message>
*/
/*--INFO--
This is a test service to facilitate creation of new keys and sub-sequent addition to package file.
*/
IMPORT dx_Cortera_Tradeline;
EXPORT EchoService := MACRO
  OUTPUT(CHOOSEN(dx_Cortera_Tradeline.Key_Delta_Rid, 10), named('cortera_tradeline_delta_rid'));
ENDMACRO;
