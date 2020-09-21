/*--SOAP--
<message name="EchoService">
</message>
*/
/*--INFO--
This is a test service to facilitate creation of new keys and sub-sequent addition to package file.
*/
IMPORT data_services, suppress;
EXPORT EchoService := MACRO
  OUTPUT(CHOOSEN(suppress.Key_OptOutSrc(data_services.data_env.iFCRA), 10), named('optout_recs')); // <-- added as a first example. to be removed once we have a first key to push out.
ENDMACRO;
