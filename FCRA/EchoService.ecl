/*--SOAP--
<message name="EchoService">
</message>
*/
/*--INFO--
This is a test service to facilitate creation of new keys and sub-sequent addition to package file.
*/
IMPORT data_services, dx_banko, Prof_License_Mari, Suppress;
EXPORT EchoService := MACRO
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Search_Delta_Rid(data_services.data_env.iFCRA), 10), named('Prof_License_Mari_Key_Search_Delta_Rid_FCRA'));
  OUTPUT(CHOOSEN(dx_Banko.Key_Banko_Delta_rid(Data_Services.data_env.iFCRA), 10), named('dx_Banko_Key_FCRA_Banko_Delta_rid'));
  OUTPUT(CHOOSEN(Suppress.Key_New_Suppression, 10), named('suppress_key_new_suppression'));
ENDMACRO;
