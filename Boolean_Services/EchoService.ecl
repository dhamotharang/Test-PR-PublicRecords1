/*--SOAP--
<message name="EchoService">
</message>
*/
/*--INFO--
This is a test service to facilitate creation of new keys and sub-sequent addition to package file.
*/
IMPORT Suppress;
EXPORT EchoService := MACRO
  OUTPUT(CHOOSEN(Suppress.Key_New_Suppression, 10), NAMED('suppress_key_new_suppression'));
ENDMACRO;
