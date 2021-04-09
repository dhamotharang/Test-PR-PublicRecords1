/*--SOAP--
<message name="EchoService">
</message>
*/
/*--INFO--
This is a test service to facilitate creation of new keys and sub-sequent addition to package file.
*/
IMPORT Data_Services, dx_Banko, dx_Cortera, dx_Cortera_Tradeline, dx_EBR, dx_Property, Patriot, Prof_License_Mari;
EXPORT EchoService := MACRO
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Search_Delta_Rid(), 10), named('Prof_License_Mari_Key_Search_Delta_Rid'));
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Regulatory_Actions_Delta_Rid(), 10), named('Prof_License_Mari_Key_Regulatory_Actions_Delta_Rid'));
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Disciplinary_Actions_Delta_Rid(), 10), named('Prof_License_Mari_Key_Disciplinary_Actions_Delta_Rid'));
  OUTPUT(CHOOSEN(Prof_License_Mari.Key_Individual_Detail_Delta_Rid(), 10), named('Prof_License_Mari_Key_Individual_Detail_Delta_Rid'));
  OUTPUT(CHOOSEN(dx_Banko.Key_Banko_Delta_rid(Data_Services.data_env.iNonFCRA), 10), named('dx_Banko_Key_Banko_Delta_rid'));
  OUTPUT(CHOOSEN(Patriot.key_patriot_delta_rid(), 10), named('Patriot_Key_patriot_Delta_rid'));
  OUTPUT(CHOOSEN(Patriot.key_baddids_delta_rid(), 10), named('Patriot_Key_baddids_Delta_rid'));
  OUTPUT(CHOOSEN(Patriot.key_badnames_delta_rid(), 10), named('Patriot_Key_badnames_Delta_rid'));
  OUTPUT(CHOOSEN(dx_OSHAIR.keys_delta_rid.Accident, 10), NAMED('dx_OSHAIR_Accident_Delta_RID'));
  OUTPUT(CHOOSEN(dx_OSHAIR.keys_delta_rid.Autokey_Payload, 10), NAMED('dx_OSHAIR_Autokey_Payload_Delta_RID'));
  OUTPUT(CHOOSEN(dx_OSHAIR.keys_delta_rid.Hazardous_Substance, 10), NAMED('dx_OSHAIR_Hazardous_Substance_Delta_RID'));
  OUTPUT(CHOOSEN(dx_OSHAIR.keys_delta_rid.Inspection, 10), NAMED('dx_OSHAIR_Inspection_Delta_RID'));
  OUTPUT(CHOOSEN(dx_OSHAIR.keys_delta_rid.Program, 10), NAMED('dx_OSHAIR_Program_Delta_RID'));
  OUTPUT(CHOOSEN(dx_OSHAIR.keys_delta_rid.Violations, 10), NAMED('dx_OSHAIR_Violations_Delta_RID'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_0010_delta_rid, 10), named('dx_ebr_key_0010_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_1000_delta_rid, 10), named('dx_ebr_key_1000_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_2000_delta_rid, 10), named('dx_ebr_key_2000_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_2015_delta_rid, 10), named('dx_ebr_key_2015_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_2020_delta_rid, 10), named('dx_ebr_key_2020_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_2025_delta_rid, 10), named('dx_ebr_key_2025_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_4010_delta_rid, 10), named('dx_ebr_key_4010_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_4020_delta_rid, 10), named('dx_ebr_key_4020_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_4030_delta_rid, 10), named('dx_ebr_key_4030_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_4500_delta_rid, 10), named('dx_ebr_key_4500_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_4510_delta_rid, 10), named('dx_ebr_key_4510_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_5000_delta_rid, 10), named('dx_ebr_key_5000_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_5600_delta_rid, 10), named('dx_ebr_key_5600_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_5610_delta_rid, 10), named('dx_ebr_key_5610_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_6000_delta_rid, 10), named('dx_ebr_key_6000_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_6500_delta_rid, 10), named('dx_ebr_key_6500_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_6510_delta_rid, 10), named('dx_ebr_key_6510_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_7010_delta_rid, 10), named('dx_ebr_key_7010_delta_rid'));
  OUTPUT(CHOOSEN(dx_ebr.mod_delta_rid.key_autokey_payload_delta_rid, 10), named('dx_ebr_key_autokey_payload_delta_rid'));
  OUTPUT(CHOOSEN(dx_Property.Key_Foreclosure_Delta_Rid, 10), named('dx_Property_Key_Foreclosure_Delta_Rid'));
  OUTPUT(CHOOSEN(dx_Property.Key_Normalized_Delta_Rid, 10), named('dx_Property_Key_Normalized_Delta_Rid'));
  OUTPUT(CHOOSEN(dx_Cortera.Key_Delta_Rid_Attributes, 10), named('dx_Cortera_Key_Delta_Rid_Attributes'));
  OUTPUT(CHOOSEN(dx_Cortera.Key_Delta_Rid_Executive, 10), named('dx_Cortera_Key_Delta_Rid_Executive'));
  OUTPUT(CHOOSEN(dx_Cortera.Key_Delta_Rid_Hdr, 10), named('dx_Cortera_Key_Delta_Rid_Hdr'));
  OUTPUT(CHOOSEN(dx_Cortera.Key_Build_Version, 10), named('dx_Cortera_Key_Build_Version'));
ENDMACRO;
