/*--SOAP--
<message name="EchoService">
</message>
*/
/*--INFO--
This is a test service to facilitate creation of new keys and sub-sequent addition to package file.
*/
IMPORT Data_Services, dx_Banko, dx_Cortera_Tradeline, Prof_License_Mari;
EXPORT EchoService := MACRO
  OUTPUT(CHOOSEN(dx_Cortera_Tradeline.Key_Delta_Rid, 10), named('cortera_tradeline_delta_rid'));
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Search_Delta_Rid(), 10), named('Prof_License_Mari_Key_Search_Delta_Rid'));
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Regulatory_Actions_Delta_Rid(), 10), named('Prof_License_Mari_Key_Regulatory_Actions_Delta_Rid'));
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Disciplinary_Actions_Delta_Rid(), 10), named('Prof_License_Mari_Key_Disciplinary_Actions_Delta_Rid'));
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Individual_Detail_Delta_Rid(), 10), named('Prof_License_Mari_Key_Individual_Detail_Delta_Rid'));
  OUTPUT(CHOOSEN(dx_Banko.Key_Banko_Delta_rid(Data_Services.data_env.iNonFCRA), 10), named('dx_Banko_Key_Banko_Delta_rid'));
ENDMACRO;
