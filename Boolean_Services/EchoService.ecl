/*--SOAP--
<message name="EchoService">
</message>
*/
/*--INFO--
This is a test service to facilitate creation of new keys and sub-sequent addition to package file.
*/
IMPORT dx_Oshair;
EXPORT EchoService := MACRO
  OUTPUT(CHOOSEN(dx_OSHAIR.keys_delta_rid.Inspection, 10), NAMED('dx_OSHAIR_Inspection_Delta_RID'));
ENDMACRO;
