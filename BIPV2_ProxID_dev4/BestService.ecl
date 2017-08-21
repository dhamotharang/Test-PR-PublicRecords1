/*--SOAP--
<message name="BestService">
<part name="Proxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Best logic as applied to a particular Proxid.*/
EXPORT BestService := MACRO
IMPORT SALT25,BIPV2_ProxID_dev4;
STRING20 Proxidstr := ''  : STORED('Proxid');
SALT25.UIDType uid := (SALT25.UIDType)Proxidstr;
TheData := PROJECT(BIPV2_ProxID_dev4.Keys(BIPV2_ProxID_dev4.In_DOT_Base).InData(Proxid=uid),BIPV2_ProxID_dev4.Layout_DOT_Base);
s := GLOBAL(PROJECT(BIPV2_ProxID_dev4.Keys(TheData).Specificities_Key,BIPV2_ProxID_dev4.Layout_Specificities.R)[1]);
CM := BIPV2_ProxID_dev4.Best(TheData,s,TRUE);
OUTPUT(CM.BestBy_Proxid_np,NAMED('BestBy_Proxid'));
OUTPUT(CM.BestBy_Proxid_child_np,NAMED('BestBy_Proxid_child'));
OUTPUT(CM.BestBy_Proxid_best_np,NAMED('BestBy_Proxid_best'));
OUTPUT(CM.UniqueSingleValue_tab_active_duns_number,NAMED('Tab_UniqueSingleValue_active_duns_number'));
OUTPUT(CM.UniqueSingleValue_method_active_duns_number,NAMED('Method_UniqueSingleValue_active_duns_number'));
OUTPUT(CM.UniqueSingleValue_tab_active_enterprise_number,NAMED('Tab_UniqueSingleValue_active_enterprise_number'));
OUTPUT(CM.UniqueSingleValue_method_active_enterprise_number,NAMED('Method_UniqueSingleValue_active_enterprise_number'));
OUTPUT(CM.UniqueSingleValue_tab_active_domestic_corp_key,NAMED('Tab_UniqueSingleValue_active_domestic_corp_key'));
OUTPUT(CM.UniqueSingleValue_method_active_domestic_corp_key,NAMED('Method_UniqueSingleValue_active_domestic_corp_key'));
ENDMACRO;
