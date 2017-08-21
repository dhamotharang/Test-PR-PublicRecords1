/*--SOAP--
<message name="BestService">
<part name="LNPID" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Best logic as applied to a particular LNPID.*/
EXPORT BestService := MACRO
  IMPORT SALT30,HealthCareFacilityHeader_Best;
STRING20 LNPIDstr := ''  : STORED('LNPID');
SALT30.UIDType uid := (SALT30.UIDType)LNPIDstr;
TheData := PROJECT(HealthCareFacilityHeader_Best.Keys(HealthCareFacilityHeader_Best.In_HealthFacility).InData(LNPID=uid),HealthCareFacilityHeader_Best.Layout_HealthFacility);
s := GLOBAL(PROJECT(HealthCareFacilityHeader_Best.Keys(TheData).Specificities_Key,HealthCareFacilityHeader_Best.Layout_Specificities.R)[1]);
CM := HealthCareFacilityHeader_Best.Best(TheData,s,TRUE);
OUTPUT(CM.BestBy_LNPID_np,NAMED('BestBy_LNPID'));
OUTPUT(CM.BestBy_LNPID_child_np,NAMED('BestBy_LNPID_child'));
OUTPUT(CM.BestBy_LNPID_best_np,NAMED('BestBy_LNPID_best'));
OUTPUT(CM.BestBy_LNPID__LIC_STATE_np,NAMED('BestBy_LNPID__LIC_STATE'));
OUTPUT(CM.BestBy_LNPID__LIC_STATE_child_np,NAMED('BestBy_LNPID__LIC_STATE_child'));
OUTPUT(CM.BestBy_LNPID__LIC_STATE_best_np,NAMED('BestBy_LNPID__LIC_STATE_best'));
OUTPUT(CM.BestNPI_tab_NPI_NUMBER,NAMED('Tab_BestNPI_NPI_NUMBER'));
OUTPUT(CM.BestNPI_method_NPI_NUMBER,NAMED('Method_BestNPI_NPI_NUMBER'));
OUTPUT(CM.BestDEA_tab_DEA_NUMBER,NAMED('Tab_BestDEA_DEA_NUMBER'));
OUTPUT(CM.BestDEA_method_DEA_NUMBER,NAMED('Method_BestDEA_DEA_NUMBER'));
OUTPUT(CM.BestCLIA_tab_CLIA_NUMBER,NAMED('Tab_BestCLIA_CLIA_NUMBER'));
OUTPUT(CM.BestCLIA_method_CLIA_NUMBER,NAMED('Method_BestCLIA_CLIA_NUMBER'));
OUTPUT(CM.BestMedicare_tab_MEDICARE_FACILITY_NUMBER,NAMED('Tab_BestMedicare_MEDICARE_FACILITY_NUMBER'));
OUTPUT(CM.BestMedicare_method_MEDICARE_FACILITY_NUMBER,NAMED('Method_BestMedicare_MEDICARE_FACILITY_NUMBER'));
OUTPUT(CM.BestMedicaid_tab_MEDICAID_NUMBER,NAMED('Tab_BestMedicaid_MEDICAID_NUMBER'));
OUTPUT(CM.BestMedicaid_method_MEDICAID_NUMBER,NAMED('Method_BestMedicaid_MEDICAID_NUMBER'));
OUTPUT(CM.BestNCPDP_tab_NCPDP_NUMBER,NAMED('Tab_BestNCPDP_NCPDP_NUMBER'));
OUTPUT(CM.BestNCPDP_method_NCPDP_NUMBER,NAMED('Method_BestNCPDP_NCPDP_NUMBER'));
OUTPUT(CM.MostRecent_tab_NPI_NUMBER,NAMED('Tab_MostRecent_NPI_NUMBER'));
OUTPUT(CM.MostRecent_method_NPI_NUMBER,NAMED('Method_MostRecent_NPI_NUMBER'));
OUTPUT(CM.MostRecentLIC_tab_C_LIC_NBR,NAMED('Tab_MostRecentLIC_C_LIC_NBR'));
OUTPUT(CM.MostRecentLIC_method_C_LIC_NBR,NAMED('Method_MostRecentLIC_C_LIC_NBR'));
OUTPUT(CM.BestLICCommenest_tab_C_LIC_NBR,NAMED('Tab_BestLICCommenest_C_LIC_NBR'));
OUTPUT(CM.BestLICCommenest_method_C_LIC_NBR,NAMED('Method_BestLICCommenest_C_LIC_NBR'));
OUTPUT(CM.BestLICLongest_tab_C_LIC_NBR,NAMED('Tab_BestLICLongest_C_LIC_NBR'));
OUTPUT(CM.BestLICLongest_method_C_LIC_NBR,NAMED('Method_BestLICLongest_C_LIC_NBR'));
OUTPUT(CM.MostRecentDEA_tab_DEA_NUMBER,NAMED('Tab_MostRecentDEA_DEA_NUMBER'));
OUTPUT(CM.MostRecentDEA_method_DEA_NUMBER,NAMED('Method_MostRecentDEA_DEA_NUMBER'));
OUTPUT(CM.BestTaxCommonest_tab_TAX_ID,NAMED('Tab_BestTaxCommonest_TAX_ID'));
OUTPUT(CM.BestTaxCommonest_method_TAX_ID,NAMED('Method_BestTaxCommonest_TAX_ID'));
OUTPUT(CM.BestTaxCommonest_tab_FEIN,NAMED('Tab_BestTaxCommonest_FEIN'));
OUTPUT(CM.BestTaxCommonest_method_FEIN,NAMED('Method_BestTaxCommonest_FEIN'));
OUTPUT(CM.MostCommonValue_tab_CLIA_NUMBER,NAMED('Tab_MostCommonValue_CLIA_NUMBER'));
OUTPUT(CM.MostCommonValue_method_CLIA_NUMBER,NAMED('Method_MostCommonValue_CLIA_NUMBER'));
OUTPUT(CM.MostCommonValue_tab_MEDICARE_FACILITY_NUMBER,NAMED('Tab_MostCommonValue_MEDICARE_FACILITY_NUMBER'));
OUTPUT(CM.MostCommonValue_method_MEDICARE_FACILITY_NUMBER,NAMED('Method_MostCommonValue_MEDICARE_FACILITY_NUMBER'));
OUTPUT(CM.MostCommonValue_tab_NCPDP_NUMBER,NAMED('Tab_MostCommonValue_NCPDP_NUMBER'));
OUTPUT(CM.MostCommonValue_method_NCPDP_NUMBER,NAMED('Method_MostCommonValue_NCPDP_NUMBER'));
OUTPUT(CM.MostCommonValue_tab_MEDICAID_NUMBER,NAMED('Tab_MostCommonValue_MEDICAID_NUMBER'));
OUTPUT(CM.MostCommonValue_method_MEDICAID_NUMBER,NAMED('Method_MostCommonValue_MEDICAID_NUMBER'));
OUTPUT(CM.BestTaxID_tab_TAX_ID,NAMED('Tab_BestTaxID_TAX_ID'));
OUTPUT(CM.BestTaxID_method_TAX_ID,NAMED('Method_BestTaxID_TAX_ID'));
OUTPUT(CM.BestTaxID_tab_FEIN,NAMED('Tab_BestTaxID_FEIN'));
OUTPUT(CM.BestTaxID_method_FEIN,NAMED('Method_BestTaxID_FEIN'));
ENDMACRO;
