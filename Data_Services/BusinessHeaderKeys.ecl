/*--SOAP--
<message name="BusinessHeader">
</message>
*/

export BusinessHeaderKeys := macro

output(choosen(business_header_ss.key_bh_header_words,10));
output(choosen(business_header_ss.key_bh_bdid_city_zip_fein_phone,10));
output(choosen(business_header.key_bh_best,10));
output(choosen(business_header_ss.key_bh_companyname,10));
output(choosen(business_header_ss.key_bh_companyname_unlimited,10));
output(choosen(business_header_ss.key_bh_addr_pr_pn_sr_st,10));
output(choosen(business_header_ss.key_bh_addr_pr_pn_zip,10));
output(choosen(business_header_ss.key_bh_phone,10));
output(choosen(business_header_ss.key_bh_fein,10));
//output(choosen(business_header_ss.key_bh_source,10));
//output(choosen(business_header_ss.key_bh_bdid,10));
output(choosen(business_header_ss.key_bh_bdid_pl,10));
output(choosen(business_header.key_business_relatives,10));
output(choosen(business_header.key_business_relatives_group,10));
output(choosen(doxie_cbrs.key_addr_bdid,10));
output(choosen(doxie_cbrs.key_bdid_namevariations,10));
output(choosen(business_header.key_bh_supergroup_groupid,10));
output(choosen(business_header.key_bh_supergroup_bdid,10));
output(choosen(business_risk.key_groupid_cnt,10));
output(choosen(business_header.key_sic_code,10));
output(choosen(business_header.key_business_contacts_bdid,10));
output(choosen(business_header.key_company_title,10));
output(choosen(business_header.key_business_contacts_state_lfname,10));
//output(choosen(business_header.key_business_contacts_state_city_name,10));
//output(choosen(business_header.key_business_contacts_fp,10));
output(choosen(business_header.key_business_contacts_did,10));
//output(choosen(business_header.key_business_contacts_stats,10));
output(choosen(business_header.key_business_contacts_ssn,10));
output(choosen(doxie_cbrs.key_bdid_relsbycontact,10));
//output(choosen(business_header.key_business_header_address,10));
//output(choosen(business_header.key_employment_did,10)); -- Added to PAW
output(choosen(business_risk.key_bdid_table,10));
output(choosen(business_risk.key_fein_table,10));
//output(choosen(business_risk.key_groupid_cnt,10));
//output(choosen(business_risk.key_ssn_address,10));
output(choosen(business_risk.key_bh_fein,10));
output(choosen(business_risk.key_bh_bdid_phone,10));
output(choosen(business_risk.key_bus_cont_did_2_bdid,10));
output(choosen(business_header.Key_BH_SuperGroup_BDID,10));
output(choosen(business_header.Key_BH_SuperGroup_GroupID,10));
output(choosen(business_risk.key_BDID_risk_table,10));
output(choosen(EDA_VIA_XML.Key_bizword_frequency,10));
output(choosen(business_header.Key_Business_Contacts_FP,10));
//output(choosen(business_header.Key_Employment_Bdid,10)); -- Added to PAW
// -- address hri
output(choosen(Business_Risk.Key_Business_Header_Address,10));
output(choosen(Business_Header.Key_ZipPRLName,10));
output(choosen(Business_Header_SS.Key_BH_Header_Words_Metaphone,10));
output(choosen(Business_Header.Key_BH_Best_KnowX,10));
output(choosen(Business_Header.Key_BDL2_BDID,10));
output(choosen(Business_Header.Key_BDL2_BDL,10));
output(choosen(Business_Header.Key_Business_Header_RCID,10));
output(choosen(Business_Header_SS.Key_BH_Addr_st,10));
output(choosen(Business_Header_SS.Key_BH_Addr_zip,10));
output(choosen(Business_Header.RoxieKeys().NewFetch.key_address_qa,10));
output(choosen(Business_Header.RoxieKeys().NewFetch.key_fein_qa,10));
output(choosen(Business_Header.RoxieKeys().NewFetch.key_name_qa,10));
output(choosen(Business_Header.RoxieKeys().NewFetch.key_phone_qa,10));
output(choosen(Business_Header.RoxieKeys().NewFetch.key_stcityname_qa,10));
output(choosen(Business_Header.RoxieKeys().NewFetch.key_stname_qa,10));
output(choosen(Business_Header.RoxieKeys().NewFetch.key_street_qa,10));
output(choosen(Business_Header.RoxieKeys().NewFetch.key_zip_qa,10));
output(choosen(Business_Header.key_commercial_SIC_Zip,10));
/*output(choosen(risk_indicators.Key_HRI_Address_To_Sic,10));
output(choosen(risk_indicators.Key_HRI_Sic_Zip_To_Address,10));
output(choosen(Risk_Indicators.Key_HRI_Address_To_Sic_filtered,10));
// -- business best
	output(choosen(marketing_best.Key_Best_MrkTitle_BDID_DID,10));
	output(choosen(marketing_best.Key_Best_MrkTitle_BDID_DID_MrktRes,10));
	
	output(choosen(marketing_best.Key_Marketing_Best_BDID,10));
	output(choosen(marketing_best.Key_Marketing_Best_BDID_MrktRes,10));
	// -- Govdata 
	
output(choosen(govdata.key_ca_sales_tax_bdid,10));
output(choosen(govdata.Key_IA_SalesTax_BDID,10));
output(choosen(govdata.key_fdic_bdid,10));
output(choosen(govdata.Key_FL_FBN_BDID,10));
output(choosen(govdata.key_FL_NonProfit_BDID,10));
output(choosen(govdata.key_gov_phones_bdid,10));
output(choosen(govdata.Key_IRS_NonProfit_BDID,10));
output(choosen(govdata.key_ms_workers_comp_BDID,10));
output(choosen(govdata.key_or_workers_comp_bdid,10));
output(choosen(govdata.key_sec_broker_dealer_BDID,10));
output(choosen(govdata.key_ms_workers_comp_BDID,10));*/
//output(choosen(DATASET('~thor_data400::BASE::Business_Header_qa', Business_Header.Layout_Business_Header_Base, THOR),10));
//output(choosen(DATASET('~thor_data400::base::business_contacts_qa',Business_Header.Layout_Business_Contact_Full,thor),10));
//f := DATASET('~thor_data400::base::business_contacts_qa',Business_Header.Layout_Business_Contact_Full,thor);
//output(FETCH(f, choosen(business_header.key_business_contacts_state_lfname,10), RIGHT.fp));
endmacro;