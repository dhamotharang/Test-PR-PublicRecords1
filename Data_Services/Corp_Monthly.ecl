/*--SOAP--
<message name="CorpMonthly">
</message>
*/

export Corp_Monthly := MACRO

output(choosen(corp.key_corp_base_bdid,10));
output(choosen(corp.key_Corp_base_bdid_pl,10));
/*output(choosen(corp.key_Corp_event_bdid,10));
output(choosen(corp.key_Corp_cont_bdid,10));
output(choosen(corp.key_Corp_supp_bdid,10));*/
output(choosen(corp.key_corp_base_corpkey,10));
/*output(choosen(corp.key_corp_cont_corpkey,10));
output(choosen(corp.key_corp_event_corpkey,10));
output(choosen(corp.key_corp_supp_corpkey,10));
output(choosen(corp.key_corp_base_name_addr,10));
output(choosen(corp.key_corp_cont_name_addr,10));
output(choosen(corp.key_corp_base_st_charter,10));
output(choosen(corp.Key_BH_FEIN,10));*/
//output(choosen(corp.Key_Corporate_Affiliations_BDID,10));
output(choosen(corp.Key_Corporate_Affiliations_DID,10));
output(choosen(corp.Key_Corporate_Affiliations_Filepos,10));
//output(choosen(corp.Key_Corporate_Affiliations_State_LFName,10));

endmacro;