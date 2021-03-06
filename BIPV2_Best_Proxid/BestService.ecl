/*--SOAP--
<message name="BestService">
<part name="Proxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Best logic as applied to a particular Proxid.*/
EXPORT BestService := MACRO
  IMPORT SALT30,BIPV2_Best_Proxid;
STRING20 Proxidstr := ''  : STORED('Proxid');
SALT30.UIDType uid := (SALT30.UIDType)Proxidstr;
TheData := PROJECT(BIPV2_Best_Proxid.Keys(BIPV2_Best_Proxid.In_Base).InData(Proxid=uid),BIPV2_Best_Proxid.Layout_Base);
s := GLOBAL(PROJECT(BIPV2_Best_Proxid.Keys(TheData).Specificities_Key,BIPV2_Best_Proxid.Layout_Specificities.R)[1]);
CM := BIPV2_Best_Proxid.Best(TheData,s,TRUE);
OUTPUT(CM.BestBy_Proxid_np,NAMED('BestBy_Proxid'));
OUTPUT(CM.BestBy_Proxid_child_np,NAMED('BestBy_Proxid_child'));
OUTPUT(CM.BestBy_Proxid_best_np,NAMED('BestBy_Proxid_best'));
OUTPUT(CM.BestCompanyNameLegal_tab_company_name,NAMED('Tab_BestCompanyNameLegal_company_name'));
OUTPUT(CM.BestCompanyNameLegal_method_company_name,NAMED('Method_BestCompanyNameLegal_company_name'));
OUTPUT(CM.BestCompanyNameCommon_tab_company_name,NAMED('Tab_BestCompanyNameCommon_company_name'));
OUTPUT(CM.BestCompanyNameCommon_method_company_name,NAMED('Method_BestCompanyNameCommon_company_name'));
OUTPUT(CM.BestCompanyNameCurrent_tab_company_name,NAMED('Tab_BestCompanyNameCurrent_company_name'));
OUTPUT(CM.BestCompanyNameCurrent_method_company_name,NAMED('Method_BestCompanyNameCurrent_company_name'));
OUTPUT(CM.BestCompanyNameVoted_tab_company_name,NAMED('Tab_BestCompanyNameVoted_company_name'));
OUTPUT(CM.BestCompanyNameVoted_method_company_name,NAMED('Method_BestCompanyNameVoted_company_name'));
OUTPUT(CM.BestCompanyNameLength_tab_company_name,NAMED('Tab_BestCompanyNameLength_company_name'));
OUTPUT(CM.BestCompanyNameLength_method_company_name,NAMED('Method_BestCompanyNameLength_company_name'));
OUTPUT(CM.BestCompanyNameStrong_tab_company_name,NAMED('Tab_BestCompanyNameStrong_company_name'));
OUTPUT(CM.BestCompanyNameStrong_method_company_name,NAMED('Method_BestCompanyNameStrong_company_name'));
OUTPUT(CM.BestCompanyNameCurrent2_tab_company_name,NAMED('Tab_BestCompanyNameCurrent2_company_name'));
OUTPUT(CM.BestCompanyNameCurrent2_method_company_name,NAMED('Method_BestCompanyNameCurrent2_company_name'));
OUTPUT(CM.BestCompanyNameVotedUnrestricted_tab_company_name,NAMED('Tab_BestCompanyNameVotedUnrestricted_company_name'));
OUTPUT(CM.BestCompanyNameVotedUnrestricted_method_company_name,NAMED('Method_BestCompanyNameVotedUnrestricted_company_name'));
OUTPUT(CM.BestCompanyAddressVoted_tab_address,NAMED('Tab_BestCompanyAddressVoted_address'));
OUTPUT(CM.BestCompanyAddressVoted_method_address,NAMED('Method_BestCompanyAddressVoted_address'));
OUTPUT(CM.BestCompanyAddressCurrent_tab_address,NAMED('Tab_BestCompanyAddressCurrent_address'));
OUTPUT(CM.BestCompanyAddressCurrent_method_address,NAMED('Method_BestCompanyAddressCurrent_address'));
OUTPUT(CM.BestCompanyAddressVotedSrc_tab_address,NAMED('Tab_BestCompanyAddressVotedSrc_address'));
OUTPUT(CM.BestCompanyAddressVotedSrc_method_address,NAMED('Method_BestCompanyAddressVotedSrc_address'));
OUTPUT(CM.BestCompanyAddressCommon_tab_address,NAMED('Tab_BestCompanyAddressCommon_address'));
OUTPUT(CM.BestCompanyAddressCommon_method_address,NAMED('Method_BestCompanyAddressCommon_address'));
OUTPUT(CM.BestCompanyAddressStrong_tab_address,NAMED('Tab_BestCompanyAddressStrong_address'));
OUTPUT(CM.BestCompanyAddressStrong_method_address,NAMED('Method_BestCompanyAddressStrong_address'));
OUTPUT(CM.BestCompanyAddressCurrent2_tab_address,NAMED('Tab_BestCompanyAddressCurrent2_address'));
OUTPUT(CM.BestCompanyAddressCurrent2_method_address,NAMED('Method_BestCompanyAddressCurrent2_address'));
OUTPUT(CM.BestCompanyAddressVotedUnrestricted_tab_address,NAMED('Tab_BestCompanyAddressVotedUnrestricted_address'));
OUTPUT(CM.BestCompanyAddressVotedUnrestricted_method_address,NAMED('Method_BestCompanyAddressVotedUnrestricted_address'));
OUTPUT(CM.BestPhoneCurrentWithNpa_tab_company_phone,NAMED('Tab_BestPhoneCurrentWithNpa_company_phone'));
OUTPUT(CM.BestPhoneCurrentWithNpa_method_company_phone,NAMED('Method_BestPhoneCurrentWithNpa_company_phone'));
OUTPUT(CM.BestPhoneCurrent_tab_company_phone,NAMED('Tab_BestPhoneCurrent_company_phone'));
OUTPUT(CM.BestPhoneCurrent_method_company_phone,NAMED('Method_BestPhoneCurrent_company_phone'));
OUTPUT(CM.BestPhoneVoted_tab_company_phone,NAMED('Tab_BestPhoneVoted_company_phone'));
OUTPUT(CM.BestPhoneVoted_method_company_phone,NAMED('Method_BestPhoneVoted_company_phone'));
OUTPUT(CM.BestPhoneLongest_tab_company_phone,NAMED('Tab_BestPhoneLongest_company_phone'));
OUTPUT(CM.BestPhoneLongest_method_company_phone,NAMED('Method_BestPhoneLongest_company_phone'));
OUTPUT(CM.BestPhoneStrong_tab_company_phone,NAMED('Tab_BestPhoneStrong_company_phone'));
OUTPUT(CM.BestPhoneStrong_method_company_phone,NAMED('Method_BestPhoneStrong_company_phone'));
OUTPUT(CM.BestPhoneVotedUnrestricted_tab_company_phone,NAMED('Tab_BestPhoneVotedUnrestricted_company_phone'));
OUTPUT(CM.BestPhoneVotedUnrestricted_method_company_phone,NAMED('Method_BestPhoneVotedUnrestricted_company_phone'));
OUTPUT(CM.BestPhoneCommon_tab_company_phone,NAMED('Tab_BestPhoneCommon_company_phone'));
OUTPUT(CM.BestPhoneCommon_method_company_phone,NAMED('Method_BestPhoneCommon_company_phone'));
OUTPUT(CM.BestFeinStrong_tab_company_fein,NAMED('Tab_BestFeinStrong_company_fein'));
OUTPUT(CM.BestFeinStrong_method_company_fein,NAMED('Method_BestFeinStrong_company_fein'));
OUTPUT(CM.BestFeinCommon_tab_company_fein,NAMED('Tab_BestFeinCommon_company_fein'));
OUTPUT(CM.BestFeinCommon_method_company_fein,NAMED('Method_BestFeinCommon_company_fein'));
OUTPUT(CM.BestFeinCurrent_tab_company_fein,NAMED('Tab_BestFeinCurrent_company_fein'));
OUTPUT(CM.BestFeinCurrent_method_company_fein,NAMED('Method_BestFeinCurrent_company_fein'));
OUTPUT(CM.BestFeinVotedUnrestricted_tab_company_fein,NAMED('Tab_BestFeinVotedUnrestricted_company_fein'));
OUTPUT(CM.BestFeinVotedUnrestricted_method_company_fein,NAMED('Method_BestFeinVotedUnrestricted_company_fein'));
OUTPUT(CM.BestFeinMin_tab_company_fein,NAMED('Tab_BestFeinMin_company_fein'));
OUTPUT(CM.BestFeinMin_method_company_fein,NAMED('Method_BestFeinMin_company_fein'));
OUTPUT(CM.BestFeinMax_tab_company_fein,NAMED('Tab_BestFeinMax_company_fein'));
OUTPUT(CM.BestFeinMax_method_company_fein,NAMED('Method_BestFeinMax_company_fein'));
OUTPUT(CM.BestUrlCommon_tab_company_url,NAMED('Tab_BestUrlCommon_company_url'));
OUTPUT(CM.BestUrlCommon_method_company_url,NAMED('Method_BestUrlCommon_company_url'));
OUTPUT(CM.BestUrlCurrent_tab_company_url,NAMED('Tab_BestUrlCurrent_company_url'));
OUTPUT(CM.BestUrlCurrent_method_company_url,NAMED('Method_BestUrlCurrent_company_url'));
OUTPUT(CM.BestUrlLength_tab_company_url,NAMED('Tab_BestUrlLength_company_url'));
OUTPUT(CM.BestUrlLength_method_company_url,NAMED('Method_BestUrlLength_company_url'));
OUTPUT(CM.BestUrlStrong_tab_company_url,NAMED('Tab_BestUrlStrong_company_url'));
OUTPUT(CM.BestUrlStrong_method_company_url,NAMED('Method_BestUrlStrong_company_url'));
OUTPUT(CM.BestUrlVotedUnrestricted_tab_company_url,NAMED('Tab_BestUrlVotedUnrestricted_company_url'));
OUTPUT(CM.BestUrlVotedUnrestricted_method_company_url,NAMED('Method_BestUrlVotedUnrestricted_company_url'));
OUTPUT(CM.BestDunsCommon_tab_duns_number,NAMED('Tab_BestDunsCommon_duns_number'));
OUTPUT(CM.BestDunsCommon_method_duns_number,NAMED('Method_BestDunsCommon_duns_number'));
OUTPUT(CM.BestDunsCurrent_tab_duns_number,NAMED('Tab_BestDunsCurrent_duns_number'));
OUTPUT(CM.BestDunsCurrent_method_duns_number,NAMED('Method_BestDunsCurrent_duns_number'));
OUTPUT(CM.BestDunsCurrent2_tab_duns_number,NAMED('Tab_BestDunsCurrent2_duns_number'));
OUTPUT(CM.BestDunsCurrent2_method_duns_number,NAMED('Method_BestDunsCurrent2_duns_number'));
OUTPUT(CM.BestDunsVotedUnrestricted_tab_duns_number,NAMED('Tab_BestDunsVotedUnrestricted_duns_number'));
OUTPUT(CM.BestDunsVotedUnrestricted_method_duns_number,NAMED('Method_BestDunsVotedUnrestricted_duns_number'));
OUTPUT(CM.BestSicCommon_tab_company_sic_code1,NAMED('Tab_BestSicCommon_company_sic_code1'));
OUTPUT(CM.BestSicCommon_method_company_sic_code1,NAMED('Method_BestSicCommon_company_sic_code1'));
OUTPUT(CM.BestSicCurrent_tab_company_sic_code1,NAMED('Tab_BestSicCurrent_company_sic_code1'));
OUTPUT(CM.BestSicCurrent_method_company_sic_code1,NAMED('Method_BestSicCurrent_company_sic_code1'));
OUTPUT(CM.BestNaicsCommon_tab_company_naics_code1,NAMED('Tab_BestNaicsCommon_company_naics_code1'));
OUTPUT(CM.BestNaicsCommon_method_company_naics_code1,NAMED('Method_BestNaicsCommon_company_naics_code1'));
OUTPUT(CM.BestNaicsCurrent_tab_company_naics_code1,NAMED('Tab_BestNaicsCurrent_company_naics_code1'));
OUTPUT(CM.BestNaicsCurrent_method_company_naics_code1,NAMED('Method_BestNaicsCurrent_company_naics_code1'));
ENDMACRO;