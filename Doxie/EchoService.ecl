/*--SOAP--
<message name="EchoService">
</message>
*/
/*--INFO--
This is a test service to facilitate creation of new keys and sub-sequent addition to package file.
*/
IMPORT suppress;
EXPORT EchoService := MACRO
  OUTPUT(CHOOSEN(suppress.Key_OptOutSrc(), 10), named('optout_recs')); // <-- added as a first example. to be removed once we have a first key to push out.
ENDMACRO;
