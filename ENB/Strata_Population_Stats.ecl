import strata;
export Strata_Population_Stats(
   string pversion
) :=
module

   export fCompanies(
   
       dataset(layouts.base.Companies) pInput
   
   ) := 
   function

			companies_file := pInput;
			Layout_companies_file_stat :=
			record
				unsigned8 CountGroup                                                                  := count(group);
				companies_file.rawfields.STATE;
				unsigned8 Bdid_CountNonZero                                                           := sum(group, if(companies_file.Bdid                                                         <> 0   ,1,0));
				unsigned8 bdid_score_CountNonZero                                                     := sum(group, if(companies_file.bdid_score                                                   <> 0   ,1,0));
				unsigned8 dt_first_seen_CountNonZero                                                  := sum(group, if(companies_file.dt_first_seen                                                <> 0   ,1,0));
				unsigned8 dt_last_seen_CountNonZero                                                   := sum(group, if(companies_file.dt_last_seen                                                 <> 0   ,1,0));
				unsigned8 dt_vendor_first_reported_CountNonZero                                       := sum(group, if(companies_file.dt_vendor_first_reported                                     <> 0   ,1,0));
				unsigned8 dt_vendor_last_reported_CountNonZero                                        := sum(group, if(companies_file.dt_vendor_last_reported                                      <> 0   ,1,0));
				unsigned8 rawfields_BIN_CountNonBlank                                                 := sum(group, if(companies_file.rawfields.BIN                                                <> ''  ,1,0));
				unsigned8 rawfields_BUSINESS_NAME_CountNonBlank                                       := sum(group, if(companies_file.rawfields.BUSINESS_NAME                                      <> ''  ,1,0));
				unsigned8 rawfields_BUSINESS_ADDRESS_CountNonBlank                                    := sum(group, if(companies_file.rawfields.BUSINESS_ADDRESS                                   <> ''  ,1,0));
				unsigned8 rawfields_CITY_CountNonBlank                                                := sum(group, if(companies_file.rawfields.CITY                                               <> ''  ,1,0));
				unsigned8 rawfields_STATE_CountNonBlank                                               := sum(group, if(companies_file.rawfields.STATE                                              <> ''  ,1,0));
				unsigned8 rawfields_ZIP_CountNonBlank                                                 := sum(group, if(companies_file.rawfields.ZIP                                                <> ''  ,1,0));
				unsigned8 rawfields_PLUS4_ZIP_CountNonBlank                                           := sum(group, if(companies_file.rawfields.PLUS4_ZIP                                          <> ''  ,1,0));
				unsigned8 rawfields_CARRIER_RTE_CountNonBlank                                         := sum(group, if(companies_file.rawfields.CARRIER_RTE                                        <> ''  ,1,0));
				unsigned8 rawfields_COUNTY_CODE_CountNonBlank                                         := sum(group, if(companies_file.rawfields.COUNTY_CODE                                        <> ''  ,1,0));
				unsigned8 rawfields_PHONE_CountNonBlank                                               := sum(group, if(companies_file.rawfields.PHONE                                              <> ''  ,1,0));
				unsigned8 rawfields_MSA_CODE_CountNonBlank                                            := sum(group, if(companies_file.rawfields.MSA_CODE                                           <> ''  ,1,0));
				unsigned8 rawfields_RECENT_UPDT_CD_CountNonBlank                                      := sum(group, if(companies_file.rawfields.RECENT_UPDT_CD                                     <> ''  ,1,0));
				unsigned8 rawfields_YRS_IN_BUS_CD_CountNonBlank                                       := sum(group, if(companies_file.rawfields.YRS_IN_BUS_CD                                      <> ''  ,1,0));
				unsigned8 rawfields_YEAR_STARTED_CountNonBlank                                        := sum(group, if(companies_file.rawfields.YEAR_STARTED                                       <> ''  ,1,0));
				unsigned8 rawfields_HOTLINE_TYPE_CountNonBlank                                        := sum(group, if(companies_file.rawfields.HOTLINE_TYPE                                       <> ''  ,1,0));
				unsigned8 rawfields_HOTLINE_DATE_CCYYMM_CountNonBlank                                 := sum(group, if(companies_file.rawfields.HOTLINE_DATE_CCYYMM                                <> ''  ,1,0));
				unsigned8 rawfields_BUSINESS_TYPE_CountNonBlank                                       := sum(group, if(companies_file.rawfields.BUSINESS_TYPE                                      <> ''  ,1,0));
				unsigned8 rawfields_ADDRESS_TYPE_CountNonBlank                                        := sum(group, if(companies_file.rawfields.ADDRESS_TYPE                                       <> ''  ,1,0));
				unsigned8 rawfields_OXXFORD_LIFE_CYCLE_CountNonBlank                                  := sum(group, if(companies_file.rawfields.OXXFORD_LIFE_CYCLE                                 <> ''  ,1,0));
				unsigned8 rawfields_EMPLOYEE_CODE_CountNonBlank                                       := sum(group, if(companies_file.rawfields.EMPLOYEE_CODE                                      <> ''  ,1,0));
				unsigned8 rawfields_EMPLOYEE_ACTUAL_CountNonBlank                                     := sum(group, if(companies_file.rawfields.EMPLOYEE_ACTUAL                                    <> ''  ,1,0));
				unsigned8 rawfields_ACTUAL_SALES_CountNonBlank                                        := sum(group, if(companies_file.rawfields.ACTUAL_SALES                                       <> ''  ,1,0));
				unsigned8 rawfields_SALES_CODE_CountNonBlank                                          := sum(group, if(companies_file.rawfields.SALES_CODE                                         <> ''  ,1,0));
				unsigned8 rawfields_OWNERSHIP_CODE_CountNonBlank                                      := sum(group, if(companies_file.rawfields.OWNERSHIP_CODE                                     <> ''  ,1,0));
				unsigned8 rawfields_LOCATION_CODE_CountNonBlank                                       := sum(group, if(companies_file.rawfields.LOCATION_CODE                                      <> ''  ,1,0));
				unsigned8 rawfields_SIC_CODE_1_IC_CountNonBlank                                       := sum(group, if(companies_file.rawfields.SIC_CODE_1_IC                                      <> ''  ,1,0));
				unsigned8 rawfields_SIC_CODE_1_CountNonBlank                                          := sum(group, if(companies_file.rawfields.SIC_CODE_1                                         <> ''  ,1,0));
				unsigned8 rawfields_SIC_CODE_2_CountNonBlank                                          := sum(group, if(companies_file.rawfields.SIC_CODE_2                                         <> ''  ,1,0));
				unsigned8 rawfields_SIC_CODE_3_CountNonBlank                                          := sum(group, if(companies_file.rawfields.SIC_CODE_3                                         <> ''  ,1,0));
				unsigned8 rawfields_SIC_CODE_4_CountNonBlank                                          := sum(group, if(companies_file.rawfields.SIC_CODE_4                                         <> ''  ,1,0));
				unsigned8 rawfields_EXEC_COUNT_CountNonBlank                                          := sum(group, if(companies_file.rawfields.EXEC_COUNT                                         <> ''  ,1,0));
				unsigned8 rawfields_DEROG_LGL_IND_CountNonBlank                                       := sum(group, if(companies_file.rawfields.DEROG_LGL_IND                                      <> ''  ,1,0));
				unsigned8 rawfields_LGL_FILED_DATE_CountNonBlank                                      := sum(group, if(companies_file.rawfields.LGL_FILED_DATE                                     <> ''  ,1,0));
				unsigned8 rawfields_LGL_LIABILTY_AMT_CountNonBlank                                    := sum(group, if(companies_file.rawfields.LGL_LIABILTY_AMT                                   <> ''  ,1,0));
				unsigned8 rawfields_UCC_DATA_IND_CountNonBlank                                        := sum(group, if(companies_file.rawfields.UCC_DATA_IND                                       <> ''  ,1,0));
				unsigned8 rawfields_UCC_COUNT_CountNonBlank                                           := sum(group, if(companies_file.rawfields.UCC_COUNT                                          <> ''  ,1,0));
				unsigned8 rawfields_INQUIRY_DATE_CountNonBlank                                        := sum(group, if(companies_file.rawfields.INQUIRY_DATE                                       <> ''  ,1,0));
				unsigned8 rawfields_RECENT_HIGH_CRDT_CountNonBlank                                    := sum(group, if(companies_file.rawfields.RECENT_HIGH_CRDT                                   <> ''  ,1,0));
				unsigned8 rawfields_MEDIAN_CREDIT_CountNonBlank                                       := sum(group, if(companies_file.rawfields.MEDIAN_CREDIT                                      <> ''  ,1,0));
				unsigned8 rawfields_COMB_TRADE_LINES_CountNonBlank                                    := sum(group, if(companies_file.rawfields.COMB_TRADE_LINES                                   <> ''  ,1,0));
				unsigned8 rawfields_COMB_TRADE_DBT_CountNonBlank                                      := sum(group, if(companies_file.rawfields.COMB_TRADE_DBT                                     <> ''  ,1,0));
				unsigned8 rawfields_COMB_TRADE_BAL_CountNonBlank                                      := sum(group, if(companies_file.rawfields.COMB_TRADE_BAL                                     <> ''  ,1,0));
				unsigned8 rawfields_PCT_CURRENT_CountNonBlank                                         := sum(group, if(companies_file.rawfields.PCT_CURRENT                                        <> ''  ,1,0));
				unsigned8 rawfields_PCT_31_60_PD_CountNonBlank                                        := sum(group, if(companies_file.rawfields.PCT_31_60_PD                                       <> ''  ,1,0));
				unsigned8 rawfields_PCT_OVER_60_PD_CountNonBlank                                      := sum(group, if(companies_file.rawfields.PCT_OVER_60_PD                                     <> ''  ,1,0));
				unsigned8 rawfields_AGED_LINES_CountNonBlank                                          := sum(group, if(companies_file.rawfields.AGED_LINES                                         <> ''  ,1,0));
				unsigned8 rawfields_CREDIT_RATING_CountNonBlank                                       := sum(group, if(companies_file.rawfields.CREDIT_RATING                                      <> ''  ,1,0));
				unsigned8 rawfields_BCS_FILE_NUM_CountNonBlank                                        := sum(group, if(companies_file.rawfields.BCS_FILE_NUM                                       <> ''  ,1,0));
				unsigned8 rawfields_INTEL_SCORE_CountNonBlank                                         := sum(group, if(companies_file.rawfields.INTEL_SCORE                                        <> ''  ,1,0));
				unsigned8 rawfields_INTEL_PCT_CountNonBlank                                           := sum(group, if(companies_file.rawfields.INTEL_PCT                                          <> ''  ,1,0));
				unsigned8 rawfields_INTEL_PROB_CountNonBlank                                          := sum(group, if(companies_file.rawfields.INTEL_PROB                                         <> ''  ,1,0));
				unsigned8 rawfields_QTR1_AVG_DBT_CountNonBlank                                        := sum(group, if(companies_file.rawfields.QTR1_AVG_DBT                                       <> ''  ,1,0));
				unsigned8 rawfields_QTR2_AVG_DBT_CountNonBlank                                        := sum(group, if(companies_file.rawfields.QTR2_AVG_DBT                                       <> ''  ,1,0));
				unsigned8 rawfields_QTR3_AVG_DBT_CountNonBlank                                        := sum(group, if(companies_file.rawfields.QTR3_AVG_DBT                                       <> ''  ,1,0));
				unsigned8 rawfields_QTR4_AVG_DBT_CountNonBlank                                        := sum(group, if(companies_file.rawfields.QTR4_AVG_DBT                                       <> ''  ,1,0));
				unsigned8 rawfields_QTR5_AVG_DBT_CountNonBlank                                        := sum(group, if(companies_file.rawfields.QTR5_AVG_DBT                                       <> ''  ,1,0));
				unsigned8 rawfields_MARKET_INTELLISCORE_CountNonBlank                                 := sum(group, if(companies_file.rawfields.MARKET_INTELLISCORE                                <> ''  ,1,0));
				unsigned8 rawfields_SIC_1_DESCRIPTION_CountNonBlank                                   := sum(group, if(companies_file.rawfields.SIC_1_DESCRIPTION                                  <> ''  ,1,0));
				unsigned8 rawfields_SIC_2_DESCRIPTION_CountNonBlank                                   := sum(group, if(companies_file.rawfields.SIC_2_DESCRIPTION                                  <> ''  ,1,0));
				unsigned8 rawfields_SIC_3_DESCRIPTION_CountNonBlank                                   := sum(group, if(companies_file.rawfields.SIC_3_DESCRIPTION                                  <> ''  ,1,0));
				unsigned8 rawfields_SIC_4_DESCRIPTION_CountNonBlank                                   := sum(group, if(companies_file.rawfields.SIC_4_DESCRIPTION                                  <> ''  ,1,0));
				unsigned8 rawfields_PRI_BUS_NAME_CountNonBlank                                        := sum(group, if(companies_file.rawfields.PRI_BUS_NAME                                       <> ''  ,1,0));
				unsigned8 rawfields_PRI_BUS_NAME_TYPE_CountNonBlank                                   := sum(group, if(companies_file.rawfields.PRI_BUS_NAME_TYPE                                  <> ''  ,1,0));
				unsigned8 rawfields_ALT_BUS_NAME_CountNonBlank                                        := sum(group, if(companies_file.rawfields.ALT_BUS_NAME                                       <> ''  ,1,0));
				unsigned8 rawfields_ALT_BUS_NAME_TYPE_CountNonBlank                                   := sum(group, if(companies_file.rawfields.ALT_BUS_NAME_TYPE                                  <> ''  ,1,0));
				unsigned8 rawfields_PRI_BUS_ADDR_LOC_TYPE_CountNonBlank                               := sum(group, if(companies_file.rawfields.PRI_BUS_ADDR_LOC_TYPE                              <> ''  ,1,0));
				unsigned8 rawfields_PRI_BUS_CITY_CountNonBlank                                        := sum(group, if(companies_file.rawfields.PRI_BUS_CITY                                       <> ''  ,1,0));
				unsigned8 rawfields_PRI_BUS_COUNTY_NAME_CountNonBlank                                 := sum(group, if(companies_file.rawfields.PRI_BUS_COUNTY_NAME                                <> ''  ,1,0));
				unsigned8 rawfields_MAIL_BUS_CITY_CountNonBlank                                       := sum(group, if(companies_file.rawfields.MAIL_BUS_CITY                                      <> ''  ,1,0));
				unsigned8 rawfields_MAIL_BUS_STATE_CountNonBlank                                      := sum(group, if(companies_file.rawfields.MAIL_BUS_STATE                                     <> ''  ,1,0));
				unsigned8 rawfields_MAIL_BUS_ZIP_CountNonBlank                                        := sum(group, if(companies_file.rawfields.MAIL_BUS_ZIP                                       <> ''  ,1,0));
				unsigned8 rawfields_MAIL_BUS_ZIP_PLUS4_CountNonBlank                                  := sum(group, if(companies_file.rawfields.MAIL_BUS_ZIP_PLUS4                                 <> ''  ,1,0));
				unsigned8 rawfields_MAIL_BUS_CARRIER_RTE_CountNonBlank                                := sum(group, if(companies_file.rawfields.MAIL_BUS_CARRIER_RTE                               <> ''  ,1,0));
				unsigned8 rawfields_MAIL_BUS_FIPS_COU_CD_CountNonBlank                                := sum(group, if(companies_file.rawfields.MAIL_BUS_FIPS_COU_CD                               <> ''  ,1,0));
				unsigned8 rawfields_MAIL_BUS_COUNTY_NAME_CountNonBlank                                := sum(group, if(companies_file.rawfields.MAIL_BUS_COUNTY_NAME                               <> ''  ,1,0));
				unsigned8 rawfields_PRI_PHONE_TYPE_CountNonBlank                                      := sum(group, if(companies_file.rawfields.PRI_PHONE_TYPE                                     <> ''  ,1,0));
				unsigned8 rawfields_PRI_PHONE_VAL_IND_CountNonBlank                                   := sum(group, if(companies_file.rawfields.PRI_PHONE_VAL_IND                                  <> ''  ,1,0));
				unsigned8 rawfields_ALT_PHONE_TYPE_CountNonBlank                                      := sum(group, if(companies_file.rawfields.ALT_PHONE_TYPE                                     <> ''  ,1,0));
				unsigned8 rawfields_ALT_PHONE_CON_CD_CountNonBlank                                    := sum(group, if(companies_file.rawfields.ALT_PHONE_CON_CD                                   <> ''  ,1,0));
				unsigned8 rawfields_ALT_PHONE_VAL_IND_CountNonBlank                                   := sum(group, if(companies_file.rawfields.ALT_PHONE_VAL_IND                                  <> ''  ,1,0));
				unsigned8 rawfields_ALT_PHONE_NUMBER_CountNonBlank                                    := sum(group, if(companies_file.rawfields.ALT_PHONE_NUMBER                                   <> ''  ,1,0));
				unsigned8 rawfields_TAX_ID2_CountNonBlank                                             := sum(group, if(companies_file.rawfields.TAX_ID2                                            <> ''  ,1,0));
				unsigned8 rawfields_TAX_ID3_CountNonBlank                                             := sum(group, if(companies_file.rawfields.TAX_ID3                                            <> ''  ,1,0));
				unsigned8 rawfields_TAX_ID4_CountNonBlank                                             := sum(group, if(companies_file.rawfields.TAX_ID4                                            <> ''  ,1,0));
				unsigned8 rawfields_URL_CountNonBlank                                                 := sum(group, if(companies_file.rawfields.URL                                                <> ''  ,1,0));
				unsigned8 rawfields_YRS_IN_BUS_DER_CD_CountNonBlank                                   := sum(group, if(companies_file.rawfields.YRS_IN_BUS_DER_CD                                  <> ''  ,1,0));
				unsigned8 rawfields_YR_MO_BUS_STARTED_CountNonBlank                                   := sum(group, if(companies_file.rawfields.YR_MO_BUS_STARTED                                  <> ''  ,1,0));
				unsigned8 rawfields_LOC_EMP_COUNT_CountNonBlank                                       := sum(group, if(companies_file.rawfields.LOC_EMP_COUNT                                      <> ''  ,1,0));
				unsigned8 rawfields_LOC_SALES_AMT_CountNonBlank                                       := sum(group, if(companies_file.rawfields.LOC_SALES_AMT                                      <> ''  ,1,0));
				unsigned8 rawfields_CORP_EMP_COUNT_CountNonBlank                                      := sum(group, if(companies_file.rawfields.CORP_EMP_COUNT                                     <> ''  ,1,0));
				unsigned8 rawfields_CORP_EMP_SIZE_CD_CountNonBlank                                    := sum(group, if(companies_file.rawfields.CORP_EMP_SIZE_CD                                   <> ''  ,1,0));
				unsigned8 rawfields_CORP_SALES_AMT_CountNonBlank                                      := sum(group, if(companies_file.rawfields.CORP_SALES_AMT                                     <> ''  ,1,0));
				unsigned8 rawfields_CORP_SALES_SIZE_CD_CountNonBlank                                  := sum(group, if(companies_file.rawfields.CORP_SALES_SIZE_CD                                 <> ''  ,1,0));
				unsigned8 rawfields_REC_UPD_CD_CountNonBlank                                          := sum(group, if(companies_file.rawfields.REC_UPD_CD                                         <> ''  ,1,0));
				unsigned8 rawfields_LEG_BUS_STR_CountNonBlank                                         := sum(group, if(companies_file.rawfields.LEG_BUS_STR                                        <> ''  ,1,0));
				unsigned8 rawfields_LIM_LIAB_CORP_CD_CountNonBlank                                    := sum(group, if(companies_file.rawfields.LIM_LIAB_CORP_CD                                   <> ''  ,1,0));
				unsigned8 rawfields_LOC_OPE_STR_CountNonBlank                                         := sum(group, if(companies_file.rawfields.LOC_OPE_STR                                        <> ''  ,1,0));
				unsigned8 rawfields_OWNERSHIP_CD_CountNonBlank                                        := sum(group, if(companies_file.rawfields.OWNERSHIP_CD                                       <> ''  ,1,0));
				unsigned8 rawfields_AFFILIATE_IND_CountNonBlank                                       := sum(group, if(companies_file.rawfields.AFFILIATE_IND                                      <> ''  ,1,0));
				unsigned8 rawfields_SUBSIDIARY_IND_CountNonBlank                                      := sum(group, if(companies_file.rawfields.SUBSIDIARY_IND                                     <> ''  ,1,0));
				unsigned8 rawfields_FORTUNE_1000_IND_CountNonBlank                                    := sum(group, if(companies_file.rawfields.FORTUNE_1000_IND                                   <> ''  ,1,0));
				unsigned8 rawfields_FRANCHISE_CD_CountNonBlank                                        := sum(group, if(companies_file.rawfields.FRANCHISE_CD                                       <> ''  ,1,0));
				unsigned8 rawfields_COTTAGE_IND_CountNonBlank                                         := sum(group, if(companies_file.rawfields.COTTAGE_IND                                        <> ''  ,1,0));
				unsigned8 rawfields_PERSONAL_NAME_IND_CountNonBlank                                   := sum(group, if(companies_file.rawfields.PERSONAL_NAME_IND                                  <> ''  ,1,0));
				unsigned8 rawfields_GEO_LATITUDE_CountNonBlank                                        := sum(group, if(companies_file.rawfields.GEO_LATITUDE                                       <> ''  ,1,0));
				unsigned8 rawfields_GEO_LONGITUDE_CountNonBlank                                       := sum(group, if(companies_file.rawfields.GEO_LONGITUDE                                      <> ''  ,1,0));
				unsigned8 rawfields_OUT_OF_BUS_FLAG_CountNonBlank                                     := sum(group, if(companies_file.rawfields.OUT_OF_BUS_FLAG                                    <> ''  ,1,0));
				unsigned8 rawfields_UNDELIVERABLE_FLAG_CountNonBlank                                  := sum(group, if(companies_file.rawfields.UNDELIVERABLE_FLAG                                 <> ''  ,1,0));
				unsigned8 rawfields_PRI_SIC_DER_CD_CountNonBlank                                      := sum(group, if(companies_file.rawfields.PRI_SIC_DER_CD                                     <> ''  ,1,0));
				unsigned8 rawfields_SEC_SIC_DER_CD_CountNonBlank                                      := sum(group, if(companies_file.rawfields.SEC_SIC_DER_CD                                     <> ''  ,1,0));
				unsigned8 rawfields_THI_SIC_DER_CD_CountNonBlank                                      := sum(group, if(companies_file.rawfields.THI_SIC_DER_CD                                     <> ''  ,1,0));
				unsigned8 rawfields_FOU_SIC_DER_CD_CountNonBlank                                      := sum(group, if(companies_file.rawfields.FOU_SIC_DER_CD                                     <> ''  ,1,0));
				unsigned8 rawfields_NAICS1_DER_CD_CountNonBlank                                       := sum(group, if(companies_file.rawfields.NAICS1_DER_CD                                      <> ''  ,1,0));
				unsigned8 rawfields_NAICS2_DER_CD_CountNonBlank                                       := sum(group, if(companies_file.rawfields.NAICS2_DER_CD                                      <> ''  ,1,0));
				unsigned8 rawfields_NAICS3_DER_CD_CountNonBlank                                       := sum(group, if(companies_file.rawfields.NAICS3_DER_CD                                      <> ''  ,1,0));
				unsigned8 rawfields_NAICS4_DER_CD_CountNonBlank                                       := sum(group, if(companies_file.rawfields.NAICS4_DER_CD                                      <> ''  ,1,0));
				unsigned8 rawfields_MSA_FULL_NAME_CountNonBlank                                       := sum(group, if(companies_file.rawfields.MSA_FULL_NAME                                      <> ''  ,1,0));
				unsigned8 rawfields_TAXID_CountNonBlank                                               := sum(group, if(companies_file.rawfields.TAXID                                              <> ''  ,1,0));
				unsigned8 rawfields_NAICS_1_CountNonBlank                                             := sum(group, if(companies_file.rawfields.NAICS_1                                            <> ''  ,1,0));
				unsigned8 rawfields_NAICS_2_CountNonBlank                                             := sum(group, if(companies_file.rawfields.NAICS_2                                            <> ''  ,1,0));
				unsigned8 rawfields_NAICS_3_CountNonBlank                                             := sum(group, if(companies_file.rawfields.NAICS_3                                            <> ''  ,1,0));
				unsigned8 rawfields_NAICS_4_CountNonBlank                                             := sum(group, if(companies_file.rawfields.NAICS_4                                            <> ''  ,1,0));
				unsigned8 rawfields_NAICS_BHDG_1_CountNonBlank                                        := sum(group, if(companies_file.rawfields.NAICS_BHDG_1                                       <> ''  ,1,0));
				unsigned8 rawfields_NAICS_BHDG_2_CountNonBlank                                        := sum(group, if(companies_file.rawfields.NAICS_BHDG_2                                       <> ''  ,1,0));
				unsigned8 rawfields_NAICS_BHDG_3_CountNonBlank                                        := sum(group, if(companies_file.rawfields.NAICS_BHDG_3                                       <> ''  ,1,0));
				unsigned8 rawfields_NAICS_BHDG_4_CountNonBlank                                        := sum(group, if(companies_file.rawfields.NAICS_BHDG_4                                       <> ''  ,1,0));
				unsigned8 Clean_Company_address_prim_range_CountNonBlank                              := sum(group, if(companies_file.Clean_Company_address.prim_range                             <> ''  ,1,0));
				unsigned8 Clean_Company_address_predir_CountNonBlank                                  := sum(group, if(companies_file.Clean_Company_address.predir                                 <> ''  ,1,0));
				unsigned8 Clean_Company_address_prim_name_CountNonBlank                               := sum(group, if(companies_file.Clean_Company_address.prim_name                              <> ''  ,1,0));
				unsigned8 Clean_Company_address_addr_suffix_CountNonBlank                             := sum(group, if(companies_file.Clean_Company_address.addr_suffix                            <> ''  ,1,0));
				unsigned8 Clean_Company_address_postdir_CountNonBlank                                 := sum(group, if(companies_file.Clean_Company_address.postdir                                <> ''  ,1,0));
				unsigned8 Clean_Company_address_unit_desig_CountNonBlank                              := sum(group, if(companies_file.Clean_Company_address.unit_desig                             <> ''  ,1,0));
				unsigned8 Clean_Company_address_sec_range_CountNonBlank                               := sum(group, if(companies_file.Clean_Company_address.sec_range                              <> ''  ,1,0));
				unsigned8 Clean_Company_address_p_city_name_CountNonBlank                             := sum(group, if(companies_file.Clean_Company_address.p_city_name                            <> ''  ,1,0));
				unsigned8 Clean_Company_address_v_city_name_CountNonBlank                             := sum(group, if(companies_file.Clean_Company_address.v_city_name                            <> ''  ,1,0));
				unsigned8 Clean_Company_address_st_CountNonBlank                                      := sum(group, if(companies_file.Clean_Company_address.st                                     <> ''  ,1,0));
				unsigned8 Clean_Company_address_zip_CountNonBlank                                     := sum(group, if(companies_file.Clean_Company_address.zip                                    <> ''  ,1,0));
				unsigned8 Clean_Company_address_zip4_CountNonBlank                                    := sum(group, if(companies_file.Clean_Company_address.zip4                                   <> ''  ,1,0));
				unsigned8 Clean_Company_address_cart_CountNonBlank                                    := sum(group, if(companies_file.Clean_Company_address.cart                                   <> ''  ,1,0));
				unsigned8 Clean_Company_address_cr_sort_sz_CountNonBlank                              := sum(group, if(companies_file.Clean_Company_address.cr_sort_sz                             <> ''  ,1,0));
				unsigned8 Clean_Company_address_lot_CountNonBlank                                     := sum(group, if(companies_file.Clean_Company_address.lot                                    <> ''  ,1,0));
				unsigned8 Clean_Company_address_lot_order_CountNonBlank                               := sum(group, if(companies_file.Clean_Company_address.lot_order                              <> ''  ,1,0));
				unsigned8 Clean_Company_address_dbpc_CountNonBlank                                    := sum(group, if(companies_file.Clean_Company_address.dbpc                                   <> ''  ,1,0));
				unsigned8 Clean_Company_address_chk_digit_CountNonBlank                               := sum(group, if(companies_file.Clean_Company_address.chk_digit                              <> ''  ,1,0));
				unsigned8 Clean_Company_address_rec_type_CountNonBlank                                := sum(group, if(companies_file.Clean_Company_address.rec_type                               <> ''  ,1,0));
				unsigned8 Clean_Company_address_fips_state_CountNonBlank                              := sum(group, if(companies_file.Clean_Company_address.fips_state                             <> ''  ,1,0));
				unsigned8 Clean_Company_address_fips_county_CountNonBlank                             := sum(group, if(companies_file.Clean_Company_address.fips_county                            <> ''  ,1,0));
				unsigned8 Clean_Company_address_geo_lat_CountNonBlank                                 := sum(group, if(companies_file.Clean_Company_address.geo_lat                                <> ''  ,1,0));
				unsigned8 Clean_Company_address_geo_long_CountNonBlank                                := sum(group, if(companies_file.Clean_Company_address.geo_long                               <> ''  ,1,0));
				unsigned8 Clean_Company_address_msa_CountNonBlank                                     := sum(group, if(companies_file.Clean_Company_address.msa                                    <> ''  ,1,0));
				unsigned8 Clean_Company_address_geo_blk_CountNonBlank                                 := sum(group, if(companies_file.Clean_Company_address.geo_blk                                <> ''  ,1,0));
				unsigned8 Clean_Company_address_geo_match_CountNonBlank                               := sum(group, if(companies_file.Clean_Company_address.geo_match                              <> ''  ,1,0));
				unsigned8 Clean_Company_address_err_stat_CountNonBlank                                := sum(group, if(companies_file.Clean_Company_address.err_stat                               <> ''  ,1,0));
			end;                          
			companies_file_stat := table(companies_file, Layout_companies_file_stat, rawfields.STATE  , few);
			strata.createXMLStats(companies_file_stat, 'ENB Companies', 'Companies', pversion, 'lbentley@seisint.com', resultsOut, 'View', 'Population');
      
      return resultsOut;
   end;

   export fContacts(
   
       dataset(layouts.base.Contacts) pInput
   
   ) := 
   function

			contacts_file := pInput;
			Layout_contacts_file_stat :=
			record
				 unsigned8 CountGroup                                                                  := count(group);
				 contacts_file.rawfields.STATE;
				 unsigned8 Did_CountNonZero                                                            := sum(group, if(contacts_file.Did                                                           <> 0   ,1,0));
				 unsigned8 did_score_CountNonZero                                                      := sum(group, if(contacts_file.did_score                                                     <> 0   ,1,0));
				 unsigned8 dt_first_seen_CountNonZero                                                  := sum(group, if(contacts_file.dt_first_seen                                                 <> 0   ,1,0));
				 unsigned8 dt_last_seen_CountNonZero                                                   := sum(group, if(contacts_file.dt_last_seen                                                  <> 0   ,1,0));
				 unsigned8 dt_vendor_first_reported_CountNonZero                                       := sum(group, if(contacts_file.dt_vendor_first_reported                                      <> 0   ,1,0));
				 unsigned8 dt_vendor_last_reported_CountNonZero                                        := sum(group, if(contacts_file.dt_vendor_last_reported                                       <> 0   ,1,0));
				 unsigned8 rawfields_BIN_CountNonBlank                                                 := sum(group, if(contacts_file.rawfields.BIN                                                 <> ''  ,1,0));
				 unsigned8 rawfields_CON_NAME_HONORIFIC_CountNonBlank                                  := sum(group, if(contacts_file.rawfields.CON_NAME_HONORIFIC                                  <> ''  ,1,0));
				 unsigned8 rawfields_CON_NAME_FIRST_NAME_CountNonBlank                                 := sum(group, if(contacts_file.rawfields.CON_NAME_FIRST_NAME                                 <> ''  ,1,0));
				 unsigned8 rawfields_CON_NAME_MID_NAME_CountNonBlank                                   := sum(group, if(contacts_file.rawfields.CON_NAME_MID_NAME                                   <> ''  ,1,0));
				 unsigned8 rawfields_CON_NAME_LAST_NAME_CountNonBlank                                  := sum(group, if(contacts_file.rawfields.CON_NAME_LAST_NAME                                  <> ''  ,1,0));
				 unsigned8 rawfields_CON_NAME_GEN_CD_CountNonBlank                                     := sum(group, if(contacts_file.rawfields.CON_NAME_GEN_CD                                     <> ''  ,1,0));
				 unsigned8 rawfields_CON_NAME_TITLE_CountNonBlank                                      := sum(group, if(contacts_file.rawfields.CON_NAME_TITLE                                      <> ''  ,1,0));
				 unsigned8 rawfields_CON_NAME_TITLE_CD_CountNonBlank                                   := sum(group, if(contacts_file.rawfields.CON_NAME_TITLE_CD                                   <> ''  ,1,0));
				 unsigned8 rawfields_BUSINESS_NAME_CountNonBlank                                       := sum(group, if(contacts_file.rawfields.BUSINESS_NAME                                       <> ''  ,1,0));
				 unsigned8 rawfields_BUSINESS_ADDRESS_CountNonBlank                                    := sum(group, if(contacts_file.rawfields.BUSINESS_ADDRESS                                    <> ''  ,1,0));
				 unsigned8 rawfields_CITY_CountNonBlank                                                := sum(group, if(contacts_file.rawfields.CITY                                                <> ''  ,1,0));
				 unsigned8 rawfields_STATE_CountNonBlank                                               := sum(group, if(contacts_file.rawfields.STATE                                               <> ''  ,1,0));
				 unsigned8 rawfields_ZIP_CountNonBlank                                                 := sum(group, if(contacts_file.rawfields.ZIP                                                 <> ''  ,1,0));
				 unsigned8 rawfields_PLUS4_ZIP_CountNonBlank                                           := sum(group, if(contacts_file.rawfields.PLUS4_ZIP                                           <> ''  ,1,0));
				 unsigned8 rawfields_PHONE_CountNonBlank                                               := sum(group, if(contacts_file.rawfields.PHONE                                               <> ''  ,1,0));
				 unsigned8 clean_contact_name_title_CountNonBlank                                      := sum(group, if(contacts_file.clean_contact_name.title                                      <> ''  ,1,0));
				 unsigned8 clean_contact_name_fname_CountNonBlank                                      := sum(group, if(contacts_file.clean_contact_name.fname                                      <> ''  ,1,0));
				 unsigned8 clean_contact_name_mname_CountNonBlank                                      := sum(group, if(contacts_file.clean_contact_name.mname                                      <> ''  ,1,0));
				 unsigned8 clean_contact_name_lname_CountNonBlank                                      := sum(group, if(contacts_file.clean_contact_name.lname                                      <> ''  ,1,0));
				 unsigned8 clean_contact_name_name_suffix_CountNonBlank                                := sum(group, if(contacts_file.clean_contact_name.name_suffix                                <> ''  ,1,0));
				 unsigned8 clean_contact_name_name_score_CountNonBlank                                 := sum(group, if(contacts_file.clean_contact_name.name_score                                 <> ''  ,1,0));
				 unsigned8 Clean_Company_address_prim_range_CountNonBlank                              := sum(group, if(contacts_file.Clean_Company_address.prim_range                              <> ''  ,1,0));
				 unsigned8 Clean_Company_address_predir_CountNonBlank                                  := sum(group, if(contacts_file.Clean_Company_address.predir                                  <> ''  ,1,0));
				 unsigned8 Clean_Company_address_prim_name_CountNonBlank                               := sum(group, if(contacts_file.Clean_Company_address.prim_name                               <> ''  ,1,0));
				 unsigned8 Clean_Company_address_addr_suffix_CountNonBlank                             := sum(group, if(contacts_file.Clean_Company_address.addr_suffix                             <> ''  ,1,0));
				 unsigned8 Clean_Company_address_postdir_CountNonBlank                                 := sum(group, if(contacts_file.Clean_Company_address.postdir                                 <> ''  ,1,0));
				 unsigned8 Clean_Company_address_unit_desig_CountNonBlank                              := sum(group, if(contacts_file.Clean_Company_address.unit_desig                              <> ''  ,1,0));
				 unsigned8 Clean_Company_address_sec_range_CountNonBlank                               := sum(group, if(contacts_file.Clean_Company_address.sec_range                               <> ''  ,1,0));
				 unsigned8 Clean_Company_address_p_city_name_CountNonBlank                             := sum(group, if(contacts_file.Clean_Company_address.p_city_name                             <> ''  ,1,0));
				 unsigned8 Clean_Company_address_v_city_name_CountNonBlank                             := sum(group, if(contacts_file.Clean_Company_address.v_city_name                             <> ''  ,1,0));
				 unsigned8 Clean_Company_address_st_CountNonBlank                                      := sum(group, if(contacts_file.Clean_Company_address.st                                      <> ''  ,1,0));
				 unsigned8 Clean_Company_address_zip_CountNonBlank                                     := sum(group, if(contacts_file.Clean_Company_address.zip                                     <> ''  ,1,0));
				 unsigned8 Clean_Company_address_zip4_CountNonBlank                                    := sum(group, if(contacts_file.Clean_Company_address.zip4                                    <> ''  ,1,0));
				 unsigned8 Clean_Company_address_cart_CountNonBlank                                    := sum(group, if(contacts_file.Clean_Company_address.cart                                    <> ''  ,1,0));
				 unsigned8 Clean_Company_address_cr_sort_sz_CountNonBlank                              := sum(group, if(contacts_file.Clean_Company_address.cr_sort_sz                              <> ''  ,1,0));
				 unsigned8 Clean_Company_address_lot_CountNonBlank                                     := sum(group, if(contacts_file.Clean_Company_address.lot                                     <> ''  ,1,0));
				 unsigned8 Clean_Company_address_lot_order_CountNonBlank                               := sum(group, if(contacts_file.Clean_Company_address.lot_order                               <> ''  ,1,0));
				 unsigned8 Clean_Company_address_dbpc_CountNonBlank                                    := sum(group, if(contacts_file.Clean_Company_address.dbpc                                    <> ''  ,1,0));
				 unsigned8 Clean_Company_address_chk_digit_CountNonBlank                               := sum(group, if(contacts_file.Clean_Company_address.chk_digit                               <> ''  ,1,0));
				 unsigned8 Clean_Company_address_rec_type_CountNonBlank                                := sum(group, if(contacts_file.Clean_Company_address.rec_type                                <> ''  ,1,0));
				 unsigned8 Clean_Company_address_fips_state_CountNonBlank                              := sum(group, if(contacts_file.Clean_Company_address.fips_state                              <> ''  ,1,0));
				 unsigned8 Clean_Company_address_fips_county_CountNonBlank                             := sum(group, if(contacts_file.Clean_Company_address.fips_county                             <> ''  ,1,0));
				 unsigned8 Clean_Company_address_geo_lat_CountNonBlank                                 := sum(group, if(contacts_file.Clean_Company_address.geo_lat                                 <> ''  ,1,0));
				 unsigned8 Clean_Company_address_geo_long_CountNonBlank                                := sum(group, if(contacts_file.Clean_Company_address.geo_long                                <> ''  ,1,0));
				 unsigned8 Clean_Company_address_msa_CountNonBlank                                     := sum(group, if(contacts_file.Clean_Company_address.msa                                     <> ''  ,1,0));
				 unsigned8 Clean_Company_address_geo_blk_CountNonBlank                                 := sum(group, if(contacts_file.Clean_Company_address.geo_blk                                 <> ''  ,1,0));
				 unsigned8 Clean_Company_address_geo_match_CountNonBlank                               := sum(group, if(contacts_file.Clean_Company_address.geo_match                               <> ''  ,1,0));
				 unsigned8 Clean_Company_address_err_stat_CountNonBlank                                := sum(group, if(contacts_file.Clean_Company_address.err_stat                                <> ''  ,1,0));
			end;                           
			contacts_file_stat := table(contacts_file, Layout_contacts_file_stat, rawfields.STATE  , few);
			strata.createXMLStats(contacts_file_stat, 'ENB Contacts', 'Contacts', pversion, 'lbentley@seisint.com', resultsOut, 'View', 'Population');
      
      return resultsOut;
   end;



	 
   export all :=
   sequential(
       fCompanies	(files().base.companies.qa)
      ,fContacts	(files().base.contacts.qa	)
   
   );
end;