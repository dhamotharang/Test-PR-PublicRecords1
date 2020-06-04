/*--SOAP--
<message name="BestService">
<part name="DOTid" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Best logic as applied to a particular DOTid.*/
EXPORT BestService := MACRO
IMPORT SALT24,BIPV2_DOTID_PLATFORM;
STRING20 DOTidstr := ''  : STORED('DOTid');
SALT24.UIDType uid := (SALT24.UIDType)DOTidstr;
TheData := PROJECT(BIPV2_DOTID_PLATFORM.Keys(BIPV2_DOTID_PLATFORM.In_DOT).InData(DOTid=uid),BIPV2_DOTID_PLATFORM.Layout_DOT);
s := GLOBAL(PROJECT(BIPV2_DOTID_PLATFORM.Keys(TheData).Specificities_Key,BIPV2_DOTID_PLATFORM.Layout_Specificities.R)[1]);
CM := BIPV2_DOTID_PLATFORM.Best(TheData,s,TRUE);
OUTPUT(CM.BestBy_DOTid_np,NAMED('BestBy_DOTid'));
OUTPUT(CM.BestBy_DOTid_child_np,NAMED('BestBy_DOTid_child'));
OUTPUT(CM.BestBy_DOTid_best_np,NAMED('BestBy_DOTid_best'));
OUTPUT(CM.UniqueSingleValue_tab_active_duns_number,NAMED('Tab_UniqueSingleValue_active_duns_number'));
OUTPUT(CM.UniqueSingleValue_method_active_duns_number,NAMED('Method_UniqueSingleValue_active_duns_number'));
OUTPUT(CM.UniqueSingleValue_tab_active_enterprise_number,NAMED('Tab_UniqueSingleValue_active_enterprise_number'));
OUTPUT(CM.UniqueSingleValue_method_active_enterprise_number,NAMED('Method_UniqueSingleValue_active_enterprise_number'));
OUTPUT(CM.UniqueSingleValue_tab_active_domestic_corp_key,NAMED('Tab_UniqueSingleValue_active_domestic_corp_key'));
OUTPUT(CM.UniqueSingleValue_method_active_domestic_corp_key,NAMED('Method_UniqueSingleValue_active_domestic_corp_key'));
ENDMACRO;
