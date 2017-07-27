/*--SOAP--
<message name="BestService">
<part name="Proxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Best logic as applied to a particular Proxid.*/
EXPORT BestService := MACRO
  IMPORT SALT24,BIPV2_Best;
STRING20 Proxidstr := ''  : STORED('Proxid');
SALT24.UIDType uid := (SALT24.UIDType)Proxidstr;
TheData := PROJECT(BIPV2_Best.Keys(BIPV2_Best.In_Base).InData(Proxid=uid),BIPV2_Best.Layout_Base);
s := GLOBAL(PROJECT(BIPV2_Best.Keys(TheData).Specificities_Key,BIPV2_Best.Layout_Specificities.R)[1]);
CM := BIPV2_Best.Best(TheData,s,TRUE);
OUTPUT(CM.BestBy_Proxid_np,NAMED('BestBy_Proxid'));
OUTPUT(CM.BestBy_Proxid_child_np,NAMED('BestBy_Proxid_child'));
OUTPUT(CM.BestBy_Proxid_best_np,NAMED('BestBy_Proxid_best'));
OUTPUT(CM.BestCompanyNameCommon_tab_company_name,NAMED('Tab_BestCompanyNameCommon_company_name'));
OUTPUT(CM.BestCompanyNameCommon_method_company_name,NAMED('Method_BestCompanyNameCommon_company_name'));
OUTPUT(CM.BestCompanyNameCurrent_tab_company_name,NAMED('Tab_BestCompanyNameCurrent_company_name'));
OUTPUT(CM.BestCompanyNameCurrent_method_company_name,NAMED('Method_BestCompanyNameCurrent_company_name'));
OUTPUT(CM.BestCompanyNameLength_tab_company_name,NAMED('Tab_BestCompanyNameLength_company_name'));
OUTPUT(CM.BestCompanyNameLength_method_company_name,NAMED('Method_BestCompanyNameLength_company_name'));
OUTPUT(CM.BestCompanyAddressCurrent_tab_company_address,NAMED('Tab_BestCompanyAddressCurrent_company_address'));
OUTPUT(CM.BestCompanyAddressCurrent_method_company_address,NAMED('Method_BestCompanyAddressCurrent_company_address'));
OUTPUT(CM.BestPhoneCurrent_tab_company_phone,NAMED('Tab_BestPhoneCurrent_company_phone'));
OUTPUT(CM.BestPhoneCurrent_method_company_phone,NAMED('Method_BestPhoneCurrent_company_phone'));
OUTPUT(CM.BestPhoneStrong_tab_company_phone,NAMED('Tab_BestPhoneStrong_company_phone'));
OUTPUT(CM.BestPhoneStrong_method_company_phone,NAMED('Method_BestPhoneStrong_company_phone'));
OUTPUT(CM.BestFeinStrong_tab_company_fein,NAMED('Tab_BestFeinStrong_company_fein'));
OUTPUT(CM.BestFeinStrong_method_company_fein,NAMED('Method_BestFeinStrong_company_fein'));
OUTPUT(CM.BestFeinCommon_tab_company_fein,NAMED('Tab_BestFeinCommon_company_fein'));
OUTPUT(CM.BestFeinCommon_method_company_fein,NAMED('Method_BestFeinCommon_company_fein'));
OUTPUT(CM.BestUrlCommon_tab_company_url,NAMED('Tab_BestUrlCommon_company_url'));
OUTPUT(CM.BestUrlCommon_method_company_url,NAMED('Method_BestUrlCommon_company_url'));
ENDMACRO;
