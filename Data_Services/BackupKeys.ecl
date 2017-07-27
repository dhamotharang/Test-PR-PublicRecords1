/*--SOAP--
<message name="BackupKeys">
</message>
*/

export BackupKeys := macro
///////////////////// ABI ///////////////////////
output(choosen(InfoUSA.Key_ABIUS_Company_BDID,10));
output(choosen(infousa.Key_ABIUS_Company_abi,10));
//////////////////// ACA ////////////////////////
output(choosen(aca.key_aca_addr,10));
//////////////////// AddressHRI ////////////////
output(choosen(risk_indicators.Key_HRI_Address_To_Sic,10));
output(choosen(risk_indicators.Key_HRI_Sic_Zip_To_Address,10));
output(choosen(risk_indicators.key_phone_table,10));
output(choosen(Risk_Indicators.key_phone_table_filtered,10));
output(choosen(Risk_Indicators.Key_HRI_Address_To_Sic_filtered,10));
/////////////////// Areacode //////////////////
output(choosen(risk_indicators.Key_AreaCode_Change,10));
output(choosen(risk_indicators.Key_AreaCode_Change_plus,10));
/////////////////// ATF //////////////////////
output(choosen(doxie_files.key_atf_did,10));
output(choosen(doxie_files.key_atf_lnum,10));
output(choosen(doxie_files.key_atf_trad,10));
output(choosen(doxie_files.key_atf_records,10));
/////////////////// Bankrupt /////////////////
output(choosen(doxie_files.key_bkrupt_did,10));
output(choosen(doxie_files.key_bkrupt_casenum,10));
output(choosen(doxie_files.key_bkrupt_didslim,10));
output(choosen(doxie_files.key_bkrupt_full,10));
output(choosen(bankrupt.key_bankrupt_bdid,10));
output(choosen(Riskwise.key_bkrupt_ssn,10));
output(choosen(Riskwise.key_bkrupt_address,10));
output(choosen(doxie_files.Key_BocaShell_bkrupt,10));
////////////////// BBB ///////////////////////
output(choosen(BBB2.Key_BBB_BDID,10));
output(choosen(BBB2.Key_BBB_Non_Member_BDID,10));
///////////////// BusinessHeader //////////////
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
output(choosen(business_header.key_employment_did,10));
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
//output(choosen(DATASET('~thor_data400::BASE::Business_Header_qa', Business_Header.Layout_Business_Header_Base, THOR),10));
//output(choosen(DATASET('~thor_data400::base::business_contacts_qa',Business_Header.Layout_Business_Contact_Full,thor),10));
f := DATASET('~thor_data400::base::business_contacts_qa',Business_Header.Layout_Business_Contact_Full,thor);
output(FETCH(f, choosen(business_header.key_business_contacts_state_lfname,10), RIGHT.__filepos));
///////////////////// BusinessReg ////////////////////
output(choosen(busreg.key_busreg_company_bdid,10));
//output(choosen(busreg.key_busreg_contact_bdid,10));
///////////////////// CellPhones /////////////////////
output(choosen(AutoKey.Key_Address('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::cellphones_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::cellphones_'),10));
output(choosen(Cellphone.key_cellphones_did,10));
output(choosen(CellPhone.key_cellphones_fdid,10));
//////////////////// CityZip ////////////////////////
output(choosen(RiskWise.Key_CityStZip,10));
/////////////////// Codes ////////////////////////////
output(choosen(codes.Key_Codes_V3,10));
///////////////////// Corp //////////////////////////
output(choosen(corp.key_corp_base_bdid,10));
output(choosen(corp.key_Corp_base_bdid_pl,10));
output(choosen(corp.key_corp_base_corpkey,10));
output(choosen(corp.Key_Corporate_Affiliations_DID,10));
output(choosen(corp.Key_Corporate_Affiliations_Filepos,10));
//////////////////// County /////////////////////////
output(choosen(Census_data.Key_Fips2County,10));
//////////////////// DCA ////////////////////////////
output(choosen(DCA.Key_DCA_BDID,10));
output(choosen(DCA.Key_DCA_Root_Sub,10));
output(choosen(DCA.Key_DCA_Hierarchy_BDID,10));
output(choosen(DCA.Key_DCA_Hierarchy_Root_Sub,10));
//////////////////// DEA ////////////////////////////
output(choosen(doxie_files.key_dea_did,10));
output(choosen(dea.key_dea_bdid,10));
//////////////////// Death_Weekly //////////////////
output(choosen(doxie.Key_Death_Master_Did,10));
output(choosen(Risk_Indicators.key_ssn_table,10));
output(choosen(Risk_Indicators.key_ssn_table_filtered,10));
//////////////////// DL_Weekly /////////////////////
output(choosen(doxie_files.key_dl,10));
output(choosen(doxie_files.key_dl_number,10));
output(choosen(doxie_files.key_dl_indicatives,10));
output(choosen(doxie_files.key_dl_did,10));
output(choosen(doxie_files.Key_BocaShell_DL,10));
///////////////////// DNB //////////////////////////
output(choosen(dnb.Key_DNB_BDID,10));
output(choosen(dnb.key_DNB_DunsNum,10));
///////////////////// DOC //////////////////////////
output(choosen(doxie_files.key_offenders,10));
output(choosen(doxie_files.key_offenders_docnum,10));
output(choosen(doxie_files.key_offenders_OffenderKey,10));
output(choosen(doxie_files.key_offenders_fdid,10));
output(choosen(doxie_files.key_offenses,10));
output(choosen(doxie_files.key_activity,10));
output(choosen(doxie_files.Key_Court_Offenses,10));
output(choosen(doxie_files.key_punishment,10));
output(choosen(doxie_files.Key_BocaShell_Crim,10));
output(choosen(AutoKey.Key_Address('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::corrections_'+doxie_build.buildstate),10));
///////////////////// EASIKeys /////////////////////
output(choosen(EASI.Key_Easi_Census,10));
//////////////////// EBRkeys //////////////////////
output(choosen(EBR.Key_0010_Header_BDID,10));
output(choosen(EBR.Key_0010_Header_FILE_NUMBER,10));
output(choosen(EBR.Key_1000_Executive_Summary_BDID,10));
output(choosen(EBR.Key_1000_Executive_Summary_FILE_NUMBER,10));
//output(choosen(EBR.Key_2000_Trade_BDID,10));
output(choosen(EBR.Key_2000_Trade_FILE_NUMBER,10));
//output(choosen(EBR.Key_2015_Trade_Payment_Totals_BDID,10));
output(choosen(EBR.Key_2015_Trade_Payment_Totals_FILE_NUMBER,10));
//output(choosen(EBR.Key_2020_Trade_Payment_Trends_BDID,10));
output(choosen(EBR.Key_2020_Trade_Payment_Trends_FILE_NUMBER,10));
//output(choosen(EBR.Key_2025_Trade_Quarterly_Averages_BDID,10));
output(choosen(EBR.Key_2025_Trade_Quarterly_Averages_FILE_NUMBER,10));
//output(choosen(EBR.Key_4010_Bankruptcy_BDID,10));
output(choosen(EBR.Key_4010_Bankruptcy_FILE_NUMBER,10));
output(choosen(EBR.Key_4020_Tax_Liens_BDID,10));
output(choosen(EBR.Key_4020_Tax_Liens_FILE_NUMBER,10));
output(choosen(EBR.Key_4030_Judgement_BDID,10));
output(choosen(EBR.Key_4030_Judgement_FILE_NUMBER,10));
//output(choosen(EBR.Key_4035_Attachment_Lien_BDID,10));
//output(choosen(EBR.Key_4035_Attachment_Lien_FILE_NUMBER,10));
//output(choosen(EBR.Key_4040_Bulk_Transfers_BDID,10));
//output(choosen(EBR.Key_4040_Bulk_Transfers_FILE_NUMBER,10));
//output(choosen(EBR.Key_4500_Collateral_Accounts_BDID,10));
output(choosen(EBR.Key_4500_Collateral_Accounts_FILE_NUMBER,10));
output(choosen(EBR.Key_4510_UCC_Filings_BDID,10));
output(choosen(EBR.Key_4510_UCC_Filings_FILE_NUMBER,10));
//output(choosen(EBR.Key_5000_Bank_Details_BDID,10));
output(choosen(EBR.Key_5000_Bank_Details_FILE_NUMBER,10));
output(choosen(EBR.Key_5600_Demographic_Data_BDID,10));
output(choosen(EBR.Key_5600_Demographic_Data_FILE_NUMBER,10));
//output(choosen(EBR.Key_5610_Demographic_Data_BDID,10));
//output(choosen(EBR.Key_5610_Demographic_Data_DID,10));
output(choosen(EBR.Key_5610_Demographic_Data_FILE_NUMBER,10));
//output(choosen(EBR.Key_5610_Demographic_Data_SSN,10));
//output(choosen(EBR.Key_6000_Inquiries_BDID,10));
output(choosen(EBR.Key_6000_Inquiries_FILE_NUMBER,10));
//output(choosen(EBR.Key_6500_Government_Trade_BDID,10));
output(choosen(EBR.Key_6500_Government_Trade_FILE_NUMBER,10));
//output(choosen(EBR.Key_6510_Government_Debarred_Contractor_BDID,10));
output(choosen(EBR.Key_6510_Government_Debarred_Contractor_FILE_NUMBER,10));
//output(choosen(EBR.Key_7000_SNP_Parent_Name_Address_BDID,10));
//output(choosen(EBR.Key_7000_SNP_Parent_Name_Address_FILE_NUMBER,10));
//output(choosen(EBR.Key_7010_SNP_Data_BDID,10));
output(choosen(EBR.Key_7010_SNP_Data_FILE_NUMBER,10));
////////////////////// Emerges ///////////////////////
output(choosen(doxie_files.key_hunters_did,10));
output(choosen(doxie_files.key_ccw_did,10));
output(choosen(doxie_files.key_voters_did,10));
////////////////////// FAA ///////////////////////////
output(choosen(faa.key_aircraft_did,10));
output(choosen(faa.key_aircraft_info,10));
output(choosen(faa.Key_Aircraft_Reg_BDID,10));
output(choosen(faa.Key_Aircraft_Reg_NNum,10));
output(choosen(faa.key_airmen_certs,10));
output(choosen(faa.key_airmen_did,10));
output(choosen(faa.key_engine_info,10));
////////////////////// FloridaCrash /////////////////
output(choosen(doxie.key_flcrash0,10));
output(choosen(doxie.key_flcrash1,10));
output(choosen(doxie.key_flcrash2v,10));
output(choosen(doxie.key_flcrash3v,10));
output(choosen(doxie.key_flcrash4,10));
output(choosen(doxie.key_flcrash5,10));
output(choosen(doxie.key_flcrash6,10));
output(choosen(doxie.key_flcrash7,10));
output(choosen(doxie.key_flcrash_did,10));
////////////////////// Foreclosure /////////////////
output(choosen(property.Key_Foreclosure_DID,10));
output(choosen(property.Key_Foreclosures_FID,10));
////////////////////// Global Watch List ///////////
output(choosen(GlobalWatchLists.Key_GlobalWatchLists_Seq,10));
output(choosen(GlobalWatchLists.Key_GlobalWatchLists_Country,10));
output(choosen(GlobalWatchLists.Key_GlobalWatchLists_Key,10));
////////////////////// Gongdaily ///////////////////
output(choosen(gong.key_did_add,10));
output(choosen(gong.key_hhid_add,10));
output(choosen(gong.key_address_add,10));
output(choosen(gong.key_remove,10));

output(choosen(DayBatchEda.Key_gong_add_phone,10));
output(choosen(DayBatchEda.key_gong_add_batch_czsslf,10));
output(choosen(DayBatchEda.key_gong_add_batch_lczf,10));

output(choosen(EDA_VIA_XML.Key_npa_nxx_line_add,10));
output(choosen(EDA_VIA_XML.Key_st_bizword_city_add,10));
output(choosen(EDA_VIA_XML.Key_st_city_prim_name_prim_range_add,10));
output(choosen(EDA_VIA_XML.Key_st_lname_city_add,10));
output(choosen(EDA_VIA_XML.Key_st_lname_fname_city_add,10));
output(choosen(gong.Key_daily_History_Phone,10));
output(choosen(gong.key_daily_history_address,10));
output(choosen(gong.Key_daily_History_Phone,10));
output(choosen(gong.Key_daily_History_Name,10));
output(choosen(gong.Key_daily_History_Zip_Name,10));
/////////////////////// Gong weekly //////////////////
output(choosen(gong.key_did,10));
output(choosen(gong.key_hhid,10));
output(choosen(gong.key_address,10));
output(choosen(doxie_cbrs.key_phone_gong,10));

output(choosen(DayBatchEda.Key_gong_phone,10));
output(choosen(DayBatchEda.key_gong_batch_czsslf,10));
output(choosen(DayBatchEda.key_gong_batch_lczf,10));

output(choosen(EDA_VIA_XML.Key_npa_nxx_line,10));
output(choosen(EDA_VIA_XML.Key_st_bizword_city,10));
output(choosen(EDA_VIA_XML.Key_st_city_prim_name_prim_range,10));
output(choosen(EDA_VIA_XML.Key_st_lname_city,10));
output(choosen(EDA_VIA_XML.Key_st_lname_fname_city,10));

output(choosen(gong.Key_History_Address,10));
output(choosen(gong.Key_History_Phone,10));
output(choosen(gong.Key_History_Did,10));
output(choosen(gong.Key_History_Hhid,10));
//output(choosen(gong.Key_History_BDID,10));
output(choosen(gong.Key_History_Name,10));
output(choosen(gong.key_history_zip_name,10));
output(choosen(gong.key_history_npa_nxx_line,10));
//////////////////// Gov Data /////////////////////
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
/////////////////// Ingenix //////////////////////
output(choosen(AutoKey.Key_Address('~thor_data400::key::ingenix_providers_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::ingenix_providers_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::ingenix_providers_'),10));
//output(choosen(AutoKey.Key_Phone('~thor_data400::key::ingenix_providers_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::ingenix_providers_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::ingenix_providers_'),10));
output(choosen(AutoKey.Key_Address('~thor_data400::key::ingenix_sanctions_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::ingenix_sanctions_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::ingenix_sanctions_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::ingenix_sanctions_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::ingenix_sanctions_'),10));
output(choosen(doxie_files.key_provider_did,10));
output(choosen(doxie_files.key_provider_id,10));
output(choosen(doxie_files.key_provider_license,10));
output(choosen(ingenix_natlprof.key_license_providerid,10));
output(choosen(ingenix_natlprof.key_language_providerid,10));
output(choosen(ingenix_natlprof.key_UPIN_providerid,10));
output(choosen(ingenix_natlprof.key_DEA_providerid,10));
output(choosen(ingenix_natlprof.key_degree_providerid,10));
output(choosen(ingenix_natlprof.key_speciality_providerid,10));
output(choosen(ingenix_natlprof.key_group_providerid,10));
output(choosen(ingenix_natlprof.key_hospital_providerid,10));
output(choosen(ingenix_natlprof.key_residency_providerid,10));
output(choosen(ingenix_natlprof.key_medschool_providerid,10));
output(choosen(doxie_files.key_provider_taxid,10));
output(choosen(doxie_files.key_sanctions_did,10));
output(choosen(doxie_files.key_sanctions_sancid,10));
output(choosen(doxie_files.key_sanctions_taxid_name,10));
output(choosen(doxie_files.key_upin_sancid,10));
output(choosen(doxie_files.key_license_sancid,10));
output(choosen(doxie_files.key_providers_fdid,10));
output(choosen(doxie_files.key_sanctions_fdid,10));
output(choosen(doxie_files.key_sanctions_taxid,10));
output(choosen(doxie_files.key_provider_search_id,10));
///////////////////// IRS /////////////////////////
output(choosen(irs5500.key_irs5500_BDID,10));
//////////////////// Liens_Daily /////////////////
output(choosen(doxie.key_liens_did,10));
output(choosen(doxie.key_liens_bdid,10));
output(choosen(doxie.key_liens_rmsid,10));
output(choosen(doxie.key_liens_st_case,10));
output(choosen(bankrupt.key_liens_plaintiffname,10));
output(choosen(doxie.key_liens_bdid_pl,10));
output(choosen(doxie_files.Key_BocaShell_Liens,10));
/////////////////// LiensV2Keys ////////////////////
output(choosen(liensv2.key_liens_main_ID,10));
output(choosen(liensv2.key_liens_party_ID,10));
output(choosen(liensv2.key_liens_case_number,10));
output(choosen(liensv2.key_liens_DID,10));
output(choosen(liensv2.key_liens_BDID,10));
output(choosen(liensv2.key_liens_ssn,10));
output(choosen(liensv2.key_liens_taxID,10));
output(choosen(liensv2.key_liens_orig_filing,10));
output(choosen(liensv2.key_liens_filing,10));
output(choosen(liensv2.key_liens_RMSID,10));
output(choosen(Autokey.Key_Address(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_CityStName(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_Name(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_Phone(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_SSN(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_StName(LiensV2.str_AutokeyName),10));
output(choosen(AutoKey.Key_Zip(LiensV2.str_AutokeyName),10));
output(choosen(AutokeyB.Key_Address(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB.Key_CityStName(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB.Key_FEIN(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB.key_name(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB.Key_NameWords(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB.key_phone(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB.Key_StName(LiensV2.str_AutokeyName),10));
output(choosen(AutoKeyB.Key_Zip(LiensV2.str_AutokeyName),10));
output(choosen(LiensV2.key_liens_AutokeyPayload, 10));
/////////////////// Living Situation ///////////////
output(choosen(doxie_files.key_livsit_pr_pn_zip,10));
////////////////// LNProperty2 ////////////////////
output(choosen(doxie_ln.Key_Addr_Fid,10));
output(choosen(doxie_ln.key_assessor_fid,10));
output(choosen(doxie_ln.Key_Assessors_ParcelNum,10));
output(choosen(doxie_ln.key_deed_fid,10));
output(choosen(doxie_ln.Key_Deeds_ParcelNum,10));
output(choosen(doxie_ln.key_fid_county,10));
output(choosen(doxie_ln.key_fid_search,10));
output(choosen(doxie_ln.Key_FIDAddlNames,10));
output(choosen(doxie_ln.Key_Prop_Address,10));
output(choosen(doxie_ln.Key_Prop_Ownership,10));
output(choosen(doxie_ln.key_property_did,10));
output(choosen(doxie_ln.Key_Search_BDID,10));
////////////////// LSSI daily /////////////////////
output(choosen(doxie.Key_Lssi_Did_Add,10));
output(choosen(doxie.Key_Lssi_Hhid_Add,10));
output(choosen(doxie.Key_Lssi_Remove,10));
////////////////// LSSI Weekly ////////////////////
output(choosen(doxie.Key_Lssi_Did,10));
output(choosen(doxie.Key_Lssi_Hhid,10));
////////////////// Marketing Header //////////////
output(choosen(watchdog.Key_watchdog_marketing,10));
////////////////// Nextones //////////////////////
output(choosen(doxie_files.key_nextones_did,10));
output(choosen(doxie_files.key_nextones_fdid,10));
output(choosen(AutoKey.Key_Address('~thor_data400::key::nextones_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::nextones_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::nextones_'),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::nextones_'),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::nextones_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::nextones_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::nextones_'),10));
////////////////// Patriot_Weekly /////////////////
output(choosen(Patriot.key_baddids,10));
output(choosen(Patriot.key_badnames,10));
output(choosen(Patriot.Key_Baddids_with_name,10));
output(choosen(patriot.key_patriot_file,10));
output(choosen(patriot.key_did_patriot_file,10));
output(choosen(patriot.key_bdid_patriot_file,10));
//output(choosen(patriot.key_patriot_key,10));
output(choosen(patriot.Key_Phonetic_Name,10));
////////////////// Pcnsr ////////////////////////
output(choosen(daybatchpcnsr.key_pcnsr_did,10));
output(choosen(daybatchpcnsr.key_pcnsr_lz3,10));
output(choosen(daybatchpcnsr.key_pcnsr_nbr,10));
output(choosen(daybatchpcnsr.key_pcnsr_phone,10));
output(choosen(daybatchpcnsr.key_pcnsr_surnames,10));
output(choosen(daybatchpcnsr.key_pcnsr_z317lf,10));
//output(choosen(daybatchpcnsr.key_pcnsr_hhid,10));
////////////////// Person Header ////////////////
output(choosen(doxie.Key_Zip_Did,10));
output(choosen(doxie.key_zip_did_full,10));
output(choosen(doxie.key_Header_SSN,10));
output(choosen(doxie.key_Header_rid,10));
output(choosen(doxie.key_header_phone,10));
output(choosen(doxie.key_Header_StFnameLname,10));
output(choosen(doxie.key_Header_StCityLFName,10));
output(choosen(doxie.Key_Header_Name,10));
output(choosen(doxie.Key_Header_Zip,10));
output(choosen(doxie.key_Header_DA,10));
output(choosen(doxie.key_address,10));
output(choosen(doxie.Key_Header_StreetZipName,10));
output(choosen(doxie.key_header,10));
output(choosen(doxie.key_did_lookups,10));
output(choosen(header.Key_Nbr_Address,10));
output(choosen(doxie.Key_Did_Rid,10));
output(choosen(doxie.Key_Did_Rid2,10));
output(choosen(doxie.Key_DID_SSN_Date,10));
output(choosen(doxie.Key_Header_CountyName,10));
output(choosen(Doxie.Key_Header_FnameSmall,10));
output(choosen(header.Key_AptBuildings,10));
output(choosen(business_risk.Key_SSN_Address,10));
output(choosen(doxie.Key_Relatives,10));
output(choosen(doxie.Key_Troy,10)); 
//output(choosen(doxie.Key_Troy_Vehicle,10));
/*output(choosen(header_slimsort.key_probationary_dids,10));
output(choosen(header_slimsort.Key_Household,10));
output(choosen(header_slimsort.Key_Name_Address,10));
output(choosen(header_slimsort.key_name_addr_St,10));
output(choosen(header_slimsort.Key_Name_Address_NN,10));
output(choosen(header_slimsort.Key_Name_Zip,10));
output(choosen(header_slimsort.Key_Name_SSN,10));
output(choosen(header_slimsort.Key_Name_Phone,10));
output(choosen(header_slimsort.Key_Name_DayOB,10));
output(choosen(header_slimsort.Key_Name_Dob,10));
output(choosen(header_slimsort.key_nazs4_age,10));
output(choosen(header_slimsort.key_nazs4_ssn4,10));
output(choosen(header_slimsort.key_nazs4_zip,10));*/
output(choosen(lssi.Key_Determiner,10));
output(choosen(doxie.Key_Did_HDid,10));
output(choosen(doxie.Key_HHID_Did,10));
output(choosen(doxie.key_header_address_research,10));
output(choosen(doxie.key_nbr_headers,10));
output(choosen(doxie.key_nbr_headers_uid,10));
output(choosen(doxie.key_header_wild_ssn,10));
output(choosen(doxie.Key_Header_Wild_StFnameLname,10));
output(choosen(doxie.Key_Header_Wild_StreetZipName,10));
output(choosen(doxie.Key_Header_Wild_Name,10));
output(choosen(doxie.Key_Header_Wild_Phone,10));
output(choosen(doxie.Key_Header_Wild_Address,10));
output(choosen(doxie.Key_Header_Wild_Zip,10));
output(choosen(doxie.Key_Header_Wild_FnameSmall,10));
output(choosen(doxie.Key_Header_Wild_StCityLFName,10));
//output(choosen(Doxie.Key_Did_Lookups_v2,10));
//////////////// Person Header Lookup ///////////////
output(choosen(Doxie.Key_Did_Lookups_v2,10));
//////////////// Person Header Slimsort /////////////
//output(choosen(header_slimsort.key_probationary_dids,10));
output(choosen(header_slimsort.Key_Household,10));
output(choosen(header_slimsort.Key_Name_Address,10));
output(choosen(header_slimsort.key_name_addr_St,10));
output(choosen(header_slimsort.Key_Name_Address_NN,10));
output(choosen(header_slimsort.Key_Name_Zip,10));
output(choosen(header_slimsort.Key_Name_SSN,10));
output(choosen(header_slimsort.Key_Name_Phone,10));
output(choosen(header_slimsort.Key_Name_DayOB,10));
output(choosen(header_slimsort.Key_Name_Dob,10));
output(choosen(header_slimsort.key_nazs4_age,10));
output(choosen(header_slimsort.key_nazs4_ssn4,10));
output(choosen(header_slimsort.key_nazs4_zip,10));
output(choosen(header_slimsort.key_did_ssn,10));
output(choosen(header_slimsort.key_did_ssn_NonGlb,10));
output(choosen(header_slimsort.key_did_ssn_NonUtil,10));
output(choosen(header_slimsort.key_did_ssn_NonGlb_NonUtil,10));
///////////////// Phone Black list ////////////////////
output(choosen(suppress.key_pullPhone,10));
///////////////// Phonesplus //////////////////////////
output(choosen(AutoKey.Key_Address('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::phonesplus_'),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::phonesplus_'),10));
output(choosen(PhonesPlus.Key_phonesplus_did,10));
output(choosen(Phonesplus.key_phonesplus_fdid,10));
///////////////// Proflic ////////////////////////////
output(choosen(doxie_files.key_proflic_did,10));
output(choosen(doxie_files.key_proflic_licensenum,10));
output(choosen(doxie_files.key_proflic_bdid,10));
output(choosen(doxie_cbrs.key_addr_proflic,10));
///////////////// pullssn ////////////////////////////
output(choosen(doxie.Key_PullSSN,10));
///////////////// pullzip ///////////////////////////
output(choosen(doxie.Key_PullZip,10));
///////////////// Quick Header //////////////////////
output(choosen(Autokey.Key_Address(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_CityStName(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_Name(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_Phone(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_SSN(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_StName(header_quick.str_AutokeyName),10));
output(choosen(AutoKey.Key_Zip(header_quick.str_AutokeyName),10));
output(choosen(header_quick.key_DID,10));
output(choosen(header_quick.key_AutokeyPayload,10));
///////////////// SexOffenderImages ////////////////
output(choosen(Images.Key_DID,10));
output(choosen(Images.Key_Images,10));
//output(choosen(Images.File_Images,10));
output(fetch(Images.File_Images,choosen(Images.Key_Images,10),RIGHT.__filepos));
///////////////// SexOffender //////////////////////
output(choosen(AutoKey.Key_Address('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::so_enh'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Address('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_CityStName('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Name('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Phone('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_SSN('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_StName('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(AutoKey.Key_Zip('~thor_data400::key::so_'+doxie_build.buildstate),10));
output(choosen(sexoffender.Key_SexOffender_DID,10));
output(choosen(sexoffender.Key_SexOffender_SPK_Enh,10));
output(choosen(sexoffender.key_sexoffender_offenses,10));
output(choosen(sexoffender.Key_SexOffender_SPK,10));
output(choosen(sexoffender.Key_SexOffender_fdid,10));
/////////////////// Smart Jury /////////////////////
output(choosen(census_data.Key_Smart_Jury,10));
/////////////////// Source Keys ////////////////////
output(choosen(header.Key_Src_Airc,10));
output(choosen(header.Key_Src_Airm,10));
output(choosen(Header.Key_Src_AK,10));
output(choosen(Header.Key_Src_ATF,10));
output(choosen(Header.Key_Src_BK,10));
output(choosen(Header.Key_Src_Boater,10));
output(choosen(Header.Key_Src_DEA,10));
output(choosen(Header.Key_Src_Death,10));
output(choosen(Header.Key_Src_Deed,10));
output(choosen(Header.Key_Src_DL,10));
output(choosen(Header.Key_Src_EM,10));
output(choosen(Header.Key_Src_EQ,10));
output(choosen(Header.Key_Src_For,10));
output(choosen(Header.Key_Src_Lien,10));
output(choosen(Header.Key_Src_LNTU,10));
output(choosen(Header.Key_Src_MS,10));
output(choosen(Header.Key_Src_Prof,10));
output(choosen(Header.Key_Src_PropAssess,10));
output(choosen(Header.Key_Src_Statedeath,10));
output(choosen(Header.Key_Src_Util,10));
output(choosen(Header.Key_Src_Veh,10));
output(choosen(Header.Key_Src_Water,10));
output(choosen(Header.Key_Rid_SrcID,10));
////////////////// State Death ///////////////////
output(choosen(doxie.key_StateDeath_master_did,10));
////////////////// SSNMap ////////////////////////
output(choosen(Doxie.Key_SSN_Map,10));
////////////////// SSNMapLong ///////////////////
output(choosen(Risk_Indicators.Key_SSN_map,10));
////////////////// SSNOverride //////////////////
output(choosen(suppress.key_ssnOver,10));
////////////////// Superior /////////////////////
output(choosen(liens_superior.key_did,10));
output(choosen(liens_superior.key_bdid,10));
////////////////// Targus //////////////////////
output(choosen(targus.Key_Targus_Address,10));
output(choosen(targus.Key_Targus_Phone,10));
////////////////// Teltds //////////////////////
output(choosen(Risk_Indicators.Key_Telcordia_tds,10));
////////////////// Teltpm //////////////////////
output(choosen(Risk_Indicators.Key_tpm_slim,10));
output(choosen(Risk_Indicators.Key_Telcordia_tpm,10));
output(choosen(Risk_Indicators.Key_Telcordia_NPA_St,10));
////////////////// UCC ////////////////////////
output(choosen(uccd.key_did,10));
output(choosen(uccd.key_bdid,10));
output(choosen(uccd.key_ucc,10));
///////////////// Utility /////////////////////
output(choosen(UtilFile.Key_Util_Daily_Address,10));
output(choosen(UtilFile.Key_Util_Daily_CityStName,10));
output(choosen(utilfile.Key_Util_Daily_Did,10));
output(choosen(utilfile.Key_Util_Daily_FDID,10));
//output(choosen(utilfile.Key_Util_Daily_ID,10));
output(choosen(utilfile.Key_Util_Daily_Name,10));
output(choosen(utilfile.Key_Util_Daily_Phone,10));
output(choosen(utilfile.Key_Util_Daily_SSN,10));
output(choosen(utilfile.Key_Util_Daily_StName,10));
output(choosen(utilfile.Key_Util_Daily_Zip,10));
output(choosen(utilfile.Key_Address,10));
///////////////// Vehicle //////////////////////
output(choosen(doxie_files.Key_Vehicles,10));
output(choosen(doxie_files.Key_Vehicle_id,10));
output(choosen(doxie_files.key_vehicle_did,10));
output(choosen(doxie_files.key_vehicle_tag,10));
output(choosen(doxie_files.key_vehicle_vin,10));
output(choosen(doxie_files.key_vehicle_bdid,10));
output(choosen(doxie_files.Key_Vehicle_coName,10));
output(choosen(doxie_files.Key_Vehicle_St_VNum,10));
output(choosen(Vehicle_wildcard.key_NameIndex,10));
output(choosen(Vehicle_wildcard.key_ModelIndex,10));
output(choosen(doxie_files.Key_BocaShell_Vehicles,10));
///////////////// Watchdog /////////////////////
output(choosen(watchdog.Key_Watchdog_GLB,10));
output(choosen(watchdog.Key_Watchdog_nonglb,10));
//output(choosen(watchdog.Key_Watchdog_Delta,10));
output(choosen(watchdog.Key_Best_SSN,10));
output(choosen(Suppress.Key_SSN_Bad,10));
//////////////// Watercraft ///////////////////
output(choosen(doxie.key_watercraft_cid,10));
output(choosen(doxie.key_watercraft_bdid,10));
output(choosen(doxie.key_watercraft_did,10));
output(choosen(doxie.key_watercraft_sid,10));
output(choosen(doxie.key_watercraft_wid,10));
output(choosen(doxie.key_watercraft_hullnum,10));
output(choosen(doxie.key_watercraft_offnum,10));
output(choosen(doxie.key_watercraft_vslnam,10));
//////////////// WhoIs ///////////////////////
output(choosen(domains.Key_Whois_Bdid,10));
output(choosen(domains.Key_Whois_Did,10));
output(choosen(domains.key_whois_domain,10));
//////////////// Yellow Pages ////////////////
output(choosen(yellowpages.key_yellowpages_bdid,10));
//output(choosen(yellowpages.Key_YellowPages_Addr,10));
output(choosen(yellowpages.key_yellowpages_phone,10));
	
endmacro;