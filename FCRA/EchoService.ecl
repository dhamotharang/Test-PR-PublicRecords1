/*--SOAP--
<message name="EchoService">
</message>
*/
/*--INFO--
This is a test service to facilitate creation of new keys and sub-sequent addition to package file.
*/
IMPORT data_services, Prof_License_Mari;
EXPORT EchoService := MACRO
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Search_Delta_Rid(data_services.data_env.iFCRA), 10), named('Prof_License_Mari_Key_Search_Delta_Rid_FCRA'));
ENDMACRO;
