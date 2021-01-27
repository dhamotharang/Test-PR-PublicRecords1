/*--SOAP--
<message name="EchoService">
</message>
*/
/*--INFO--
This is a test service to facilitate creation of new keys and sub-sequent addition to package file.
*/
IMPORT data_services, dx_banko, dx_fcra_opt_out, Prof_License_Mari, Suppress;
EXPORT EchoService := MACRO
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Search_Delta_Rid(data_services.data_env.iFCRA), 10), named('Prof_License_Mari_Key_Search_Delta_Rid_FCRA'));
  OUTPUT(CHOOSEN(dx_Banko.Key_Banko_Delta_rid(Data_Services.data_env.iFCRA), 10), named('dx_Banko_Key_FCRA_Banko_Delta_rid'));
  OUTPUT(CHOOSEN(dx_fcra_opt_out.key_delta_rid, 10), named('dx_fcra_opt_out_Delta_rid'));
  OUTPUT(CHOOSEN(Suppress.Key_New_Suppression, 10), named('suppress_key_new_suppression'));
  OUTPUT(CHOOSEN(dx_Suppression.Key_Suppression(), 10), named('dx_suppression_key_suppression'));
  OUTPUT(CHOOSEN(dx_InquiryHistory.Key_Group_RID_Encrypted(data_services.data_env.iFCRA), 5), named('dx_inquiryHistory_encrypted_data'));
ENDMACRO;
