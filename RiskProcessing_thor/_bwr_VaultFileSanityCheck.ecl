//  This script can be run on hthor, doesn't need to wait in line on multi node cluster

// sandbox Vault.Vault.MAC_Remove_Vault_Fields -- comment out this filter in the macro so it runs fast on hthor:  (vault_record_status in [4, 5, 6])

// throw an error here if the controls aren't set correctly for running files on vault
#WORKUNIT('name', 'Vault RiskView 5.0 Sanity Check ' + 	
map(
_Control.Environment.OnThor=false => ERROR(1,'Toggle Setting OnThor'), 
_Control.Environment.OnVault=false => ERROR(2,'Toggle Setting OnVault'), 
_Control.LibraryUse.ForceOff_AllLibraries=false => ERROR(3,'Toggle Setting LibraryUse'), 
'' ) // if all is good, nothing left to say and it runs successfully to test the keys
);  
	
#workunit('priority','high');
#option('pickBestEngine', false);   // workaround to see data in the property keys on vault
	
luckynumber := 31;
	
output(choosen(		AID.Files.RawCacheProd	, luckynumber), named('vault_AID_Files_RawCacheProd') );
output(choosen(		AID.Files.StdCacheProd	, luckynumber), named('vault_AID_Files_StdCacheProd') );
output(choosen(		AID.Files.ACECacheProd	, luckynumber), named('vault_AID_Files_ACECacheProd') );
output(choosen(		PersonContext.Keys.KEY_LexID	, luckynumber), named('vault_PersonContext_Keys_KEY_LexID') );
output(choosen(		PersonContext.Keys.KEY_RecID	, luckynumber), named('vault_PersonContext_Keys_KEY_RecID') );
output(choosen(		InsuranceHeader_xLink.Key_InsuranceHeader_ADDRESS().key	, luckynumber), named('vault_InsuranceHeader_xLink_Key_InsuranceHeader_ADDRESS') );
output(choosen(		InsuranceHeader_xLink.Key_InsuranceHeader_DOB().key	, luckynumber), named('vault_InsuranceHeader_xLink_Key_InsuranceHeader_DOB') );
output(choosen(		InsuranceHeader_xLink.Key_InsuranceHeader_DOBF().key	, luckynumber), named('vault_InsuranceHeader_xLink_Key_InsuranceHeader_DOBF') );
output(choosen(		InsuranceHeader_xLink.Key_InsuranceHeader_LFZ().key	, luckynumber), named('vault_InsuranceHeader_xLink_Key_InsuranceHeader_LFZ') );
output(choosen(		InsuranceHeader_xLink.Key_InsuranceHeader_NAME().Key	, luckynumber), named('vault_InsuranceHeader_xLink_Key_InsuranceHeader_NAME') );
output(choosen(		InsuranceHeader_xLink.Key_InsuranceHeader_PH().key	, luckynumber), named('vault_InsuranceHeader_xLink_Key_InsuranceHeader_PH') );
output(choosen(		InsuranceHeader_xLink.Key_InsuranceHeader_SSN().key	, luckynumber), named('vault_InsuranceHeader_xLink_Key_InsuranceHeader_SSN') );
output(choosen(		InsuranceHeader_xLink.Key_InsuranceHeader_SSN4().key	, luckynumber), named('vault_InsuranceHeader_xLink_Key_InsuranceHeader_SSN4') );
output(choosen(		InsuranceHeader_xLink.Key_InsuranceHeader_ZIP_PR().key	, luckynumber), named('vault_InsuranceHeader_xLink_Key_InsuranceHeader_ZIP_PR') );
output(choosen(		InsuranceHeader_PostProcess.segmentation_keys.key_did_ind	, luckynumber), named('vault_InsuranceHeader_PostProcess_segmentation_keys_key_did_ind') );
output(choosen(		Suppress.Key_New_Suppression	, luckynumber), named('vault_Suppress_Key_New_Suppression') );  // roxie uses the version of the key that doesn't have isFCRA parameter
output(choosen(		Watchdog.Key_watchdog_glb	, luckynumber), named('vault_Watchdog_Key_watchdog_glb') );
output(choosen(		Watchdog.Key_Watchdog_GLB_nonExperian	, luckynumber), named('vault_Watchdog_Key_Watchdog_GLB_nonExperian') );
output(choosen(		FCRA.Key_Override_ADVO_ffid	, luckynumber), named('vault_FCRA_Key_Override_ADVO_ffid') );
output(choosen(		FCRA.key_override_faa.aircraft	, luckynumber), named('vault_FCRA_key_override_faa_aircraft') );
output(choosen(		FCRA.Key_Override_Alloy_FFID	, luckynumber), named('vault_FCRA_Key_Override_Alloy_FFID') );
output(choosen(		FCRA.Key_Override_AVM_FFID	, luckynumber), named('vault_FCRA_Key_Override_AVM_FFID') );
output(choosen(		FCRA.key_override_bkv3_main_ffid	, luckynumber), named('vault_FCRA_key_override_bkv3_main_ffid') );
output(choosen(		FCRA.key_override_bkv3_search_ffid	, luckynumber), named('vault_FCRA_key_override_bkv3_search_ffid') );
output(choosen(		fcra.Key_Override_Crim.Offenders	, luckynumber), named('vault_fcra_Key_Override_Crim_Offenders') );
output(choosen(		FCRA.Key_Override_Email_Data_ffid	, luckynumber), named('vault_FCRA_Key_Override_Email_Data_ffid') );
output(choosen(		FCRA.Key_Override_Flag_DID	, luckynumber), named('vault_FCRA_Key_Override_Flag_DID') );
output(choosen(		FCRA.Key_Override_Flag_SSN	, luckynumber), named('vault_FCRA_Key_Override_Flag_SSN') );
output(choosen(		FCRA.Key_Override_Gong_FFID	, luckynumber), named('vault_FCRA_Key_Override_Gong_FFID') );
output(choosen(		FCRA.Key_Override_Header_DID	, luckynumber), named('vault_FCRA_Key_Override_Header_DID') );
output(choosen(		FCRA.Key_Override_Infutor_FFID	, luckynumber), named('vault_FCRA_Key_Override_Infutor_FFID') );
output(choosen(		FCRA.Key_Override_Inquiries_ffid	, luckynumber), named('vault_FCRA_Key_Override_Inquiries_ffid') );
output(choosen(		FCRA.key_Override_liensv2_main_ffid	, luckynumber), named('vault_FCRA_key_Override_liensv2_main_ffid') );
output(choosen(		FCRA.key_Override_liensv2_party_ffid	, luckynumber), named('vault_FCRA_key_Override_liensv2_party_ffid') );
output(choosen(		FCRA.Key_Override_PAW_ffid	, luckynumber), named('vault_FCRA_Key_Override_PAW_ffid') );
output(choosen(		FCRA.Key_Override_PCR_DID	, luckynumber), named('vault_FCRA_Key_Override_PCR_DID') );
output(choosen(		FCRA.Key_Override_PCR_SSN	, luckynumber), named('vault_FCRA_Key_Override_PCR_SSN') );
output(choosen(		FCRA.key_override_proflic_ffid	, luckynumber), named('vault_FCRA_key_override_proflic_ffid') );
output(choosen(		FCRA.Key_Override_Property.assessment	, luckynumber), named('vault_FCRA_Key_Override_Property_assessment') );
output(choosen(		FCRA.Key_Override_Property.deed	, luckynumber), named('vault_FCRA_Key_Override_Property_deed') );
output(choosen(		FCRA.Key_Override_Property.ownership	, luckynumber), named('vault_FCRA_Key_Override_Property_ownership') );
output(choosen(		FCRA.Key_Override_Property.search	, luckynumber), named('vault_FCRA_Key_Override_Property_search') );
output(choosen(		FCRA.Key_Override_SSN_Table_FFID	, luckynumber), named('vault_FCRA_Key_Override_SSN_Table_FFID') );
output(choosen(		FCRA.key_override_sexoffender.so_main	, luckynumber), named('vault_FCRA_key_override_sexoffender_so_main') );
output(choosen(		FCRA.Key_Override_Student_New_FFID	, luckynumber), named('vault_FCRA_Key_Override_Student_New_FFID') );
output(choosen(		FCRA.Key_Override_Watercraft.sid	, luckynumber), named('vault_FCRA_Key_Override_Watercraft_sid') );
output(choosen(		FCRA.Key_FCRA_Override_pii_did	, luckynumber), named('vault_FCRA_Key_FCRA_Override_pii_did') );
output(choosen(		FCRA.Key_FCRA_Override_pii_ssn	, luckynumber), named('vault_FCRA_Key_FCRA_Override_pii_ssn') );
output(choosen(		doxie_files.Key_Offenders(isFCRA := true)	, luckynumber), named('vault_doxie_files_Key_Offenders') );
output(choosen(		doxie_files.Key_Offenses(isFCRA := true)	, luckynumber), named('vault_doxie_files_Key_Offenses') );
output(choosen(		Email_Data.Key_Did_FCRA	, luckynumber), named('vault_Email_Data_Key_Did_FCRA') );
output(choosen(		Advo.Key_Addr1_FCRA	, luckynumber), named('vault_Advo_Key_Addr1_FCRA') );
output(choosen(		Advo.Key_Addr1_FCRA_history	, luckynumber), named('vault_Advo_Key_Addr1_FCRA_history') );
output(choosen(		AID_Build.Key_AID_Base	, luckynumber), named('vault_AID_Build_Key_AID_Base') );
output(choosen(		AVM_V2.Key_AVM_Address_FCRA	, luckynumber), named('vault_AVM_V2_Key_AVM_Address_FCRA') );
output(choosen(		AVM_V2.Key_AVM_Medians_FCRA	, luckynumber), named('vault_AVM_V2_Key_AVM_Medians_FCRA') );
output(choosen(		BankruptcyV3.key_bankruptcyV3_did(isFCRA := true)	, luckynumber), named('vault_BankruptcyV3_key_bankruptcyV3_did') );
output(choosen(		BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(isFCRA := True)	, luckynumber), named('vault_BankruptcyV3_Key_BankruptcyV3_WithdrawnStatus') );
output(choosen(		BankruptcyV3.key_bankruptcyv3_search_full_bip(isFCRA := true)	, luckynumber), named('vault_BankruptcyV3_key_bankruptcyv3_search_full_bip') );
output(choosen(		risk_indicators.key_HRI_Address_To_SIC_filtered_FCRA	, luckynumber), named('vault_risk_indicators_key_HRI_Address_To_SIC_filtered_FCRA') );
output(choosen(		dx_Gong.key_phone_table(data_services.data_env.iFCRA)	, luckynumber), named('vault_Gong_Key_FCRA_Business_Header_Phone_Table_Filtered_V2') );
output(choosen(		RiskWise.Key_CityStZip	, luckynumber), named('vault_RiskWise_Key_CityStZip') );
output(choosen(		Codes.Key_Codes_V3	, luckynumber), named('vault_Codes_Key_Codes_V3') );
output(choosen(		doxie_files.Key_Court_Offenses(isFCRA := true)	, luckynumber), named('vault_doxie_files_Key_Court_Offenses') );
output(choosen(		doxie_files.Key_BocaShell_Crim_FCRA	, luckynumber), named('vault_doxie_files_Key_BocaShell_Crim_FCRA') );
output(choosen(		misc2.key_dateCorrect_hval	, luckynumber), named('vault_misc2_key_dateCorrect_hval') );
output(choosen(		risk_indicators.key_FCRA_ADL_Risk_Table_v4_filtered	, luckynumber), named('vault_Risk_Indicators_key_FCRA_ADL_Risk_Table_v4_filtered') );
output(choosen(		Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA	, luckynumber), named('vault_Risk_Indicators_Key_SSN_Table_v4_filtered_FCRA') );
output(choosen(		faa.key_aircraft_id(isFCRA := true)	, luckynumber), named('vault_faa_key_aircraft_id') );
output(choosen(		faa.key_aircraft_did(isFCRA := true)	, luckynumber), named('vault_faa_key_aircraft_did') );
output(choosen(		AlloyMedia_student_list.Key_DID_FCRA	, luckynumber), named('vault_AlloyMedia_student_list_Key_DID_FCRA') );
output(choosen(		american_student_list.key_DID_FCRA	, luckynumber), named('vault_american_student_list_key_DID_FCRA') );
output(choosen(		risk_indicators.Key_FCRA_AreaCode_Change_plus	, luckynumber), named('vault_risk_indicators_Key_FCRA_AreaCode_Change_plus') );
output(choosen(		Death_Master.key_ssn_ssa(isFCRA := true)	, luckynumber), named('vault_Death_Master_key_ssn_ssa') );
output(choosen(		doxie.key_death_masterV2_ssa_DID_fcra	, luckynumber), named('vault_doxie_key_death_masterV2_ssa_DID_fcra') );
output(choosen(		dx_Header.Key_AptBuildings(data_services.data_env.iFCRA)	, luckynumber), named('vault_dx_header_key_AptBuildings_FCRA') );
output(choosen(		dx_Header.Key_legacy_ssn(data_services.data_env.iFCRA)	, luckynumber), named('vault_dx_header_Key_FCRA_legacy_ssn') );
output(choosen(		dx_header.key_addr_hist(data_services.data_env.iFCRA)	, luckynumber), named('vault_dx_Header_key_addr_hist') );
output(choosen(		dx_Header.Key_Header_Address(data_services.data_env.iFCRA)	, luckynumber), named('vault_dx_header_Key_FCRA_Header_Address') );
output(choosen(		dx_Header.Key_Header(data_services.data_env.iFCRA)	, luckynumber), named('vault_dx_header_Key_FCRA_Header') );
output(choosen(		dx_Header.Key_max_dt_last_seen(data_services.data_env.iFCRA)	, luckynumber), named('vault_dx_header_Key_FCRA_max_dt_last_seen') );
output(choosen(		dx_fcra_opt_out.key_address	, luckynumber), named('vault_dx_fcra_opt_out_key_address') );
output(choosen(		dx_fcra_opt_out.key_did	, luckynumber), named('vault_dx_fcra_opt_out_key_did') );
output(choosen(		dx_fcra_opt_out.key_ssn	, luckynumber), named('vault_dx_fcra_opt_out_key_ssn') );
output(choosen(		Risk_Indicators.Key_FCRA_Telcordia_tpm_Slim	, luckynumber), named('vault_Risk_Indicators_Key_FCRA_Telcordia_tpm_Slim') );
output(choosen(		Census_Data.Key_Fips2County	, luckynumber), named('vault_Census_Data_Key_Fips2County') );
output(choosen(		dx_Gong.Key_History_Address(data_services.data_env.iFCRA)	, luckynumber), named('vault_Gong_Key_FCRA_History_Address') );
output(choosen(		dx_Gong.Key_History_did(data_services.data_env.iFCRA)	, luckynumber), named('vault_Gong_Key_FCRA_History_did') );
output(choosen(		dx_Gong.Key_History_Phone(data_services.data_env.iFCRA)	, luckynumber), named('vault_Gong_Key_FCRA_History_Phone') );
output(choosen(		header_quick.Key_Did_FCRA	, luckynumber), named('vault_header_quick_Key_Did_FCRA') );
output(choosen(		InfutorCID.Key_Infutor_DID_FCRA	, luckynumber), named('vault_InfutorCID_Key_Infutor_DID_FCRA') );
output(choosen(		InfutorCID.Key_Infutor_Phone_FCRA	, luckynumber), named('vault_InfutorCID_Key_Infutor_Phone_FCRA') );
output(choosen(		Inquiry_AccLogs.Key_FCRA_Address	, luckynumber), named('vault_Inquiry_AccLogs_Key_FCRA_Address') );
output(choosen(		Inquiry_AccLogs.Key_FCRA_DID	, luckynumber), named('vault_Inquiry_AccLogs_Key_FCRA_DID') );
output(choosen(		Inquiry_AccLogs.Key_FCRA_Phone	, luckynumber), named('vault_Inquiry_AccLogs_Key_FCRA_Phone') );
output(choosen(		Inquiry_Acclogs.Key_FCRA_Billgroups_DID	, luckynumber), named('vault_Inquiry_Acclogs_Key_FCRA_Billgroups_DID') );
output(choosen(		Inquiry_AccLogs.Key_FCRA_SSN	, luckynumber), named('vault_Inquiry_AccLogs_Key_FCRA_SSN') );
output(choosen(		LiensV2.key_liens_DID_FCRA	, luckynumber), named('vault_LiensV2_key_liens_DID_FCRA') );
output(choosen(		LiensV2.key_liens_main_ID_FCRA	, luckynumber), named('vault_LiensV2_key_liens_main_ID_FCRA') );
output(choosen(		LiensV2.key_liens_party_id_FCRA	, luckynumber), named('vault_LiensV2_key_liens_party_id_FCRA') );
output(choosen(		LN_PropertyV2.Key_Prop_Address_FCRA_V4	, luckynumber), named('vault_LN_PropertyV2_Key_Prop_Address_FCRA_V4') );
output(choosen(		LN_PropertyV2.key_addr_fid(isFCRA := true)	, luckynumber), named('vault_LN_PropertyV2_key_addr_fid') );
output(choosen(		LN_PropertyV2.key_assessor_fid(isFCRA := true)	, luckynumber), named('vault_LN_PropertyV2_key_assessor_fid') );
output(choosen(		LN_PropertyV2.key_deed_fid(isFCRA := true)	, luckynumber), named('vault_LN_PropertyV2_key_deed_fid') );
output(choosen(		LN_PropertyV2.Key_Prop_Ownership_FCRA_V4	, luckynumber), named('vault_LN_PropertyV2_Key_Prop_Ownership_FCRA_V4') );
output(choosen(		LN_PropertyV2.key_Property_did(isFCRA := true)	, luckynumber), named('vault_LN_PropertyV2_key_Property_did') );
output(choosen(		LN_PropertyV2.key_search_fid(isFCRA := true)	, luckynumber), named('vault_LN_PropertyV2_key_search_fid') );
output(choosen(		paw.Key_DID_FCRA	, luckynumber), named('vault_paw_Key_DID_FCRA') );
output(choosen(		Prof_License_Mari.key_did(isFCRA := true)	, luckynumber), named('vault_Prof_License_Mari_key_did') );
output(choosen(		Prof_LicenseV2.Key_LicenseType_lookup(isFCRA := true)	, luckynumber), named('vault_Prof_LicenseV2_Key_LicenseType_lookup') );
output(choosen(		prof_licenseV2.Key_Proflic_Did (isFCRA := true)	, luckynumber), named('vault_prof_licenseV2_Key_Proflic_Did') );
output(choosen(		SexOffender.Key_SexOffender_DID(true)	, luckynumber), named('vault_SexOffender_Key_SexOffender_DID') );
output(choosen(		SexOffender.Key_SexOffender_SPK(true)	, luckynumber), named('vault_SexOffender_Key_SexOffender_SPK') );
output(choosen(		doxie.Key_SSN_FCRA_Map	, luckynumber), named('vault_doxie_Key_SSN_FCRA_Map') );
output(choosen(		Targus.Key_Targus_fcra_address	, luckynumber), named('vault_Targus_Key_Targus_fcra_address') );
output(choosen(		Targus.Key_Targus_fcra_phone	, luckynumber), named('vault_Targus_Key_Targus_fcra_phone') );
output(choosen(		Risk_Indicators.Key_Telcordia_tds	, luckynumber), named('vault_Risk_Indicators_Key_Telcordia_tds') );
output(choosen(		thrive.keys().Did_fcra.qa	, luckynumber), named('vault_thrive_keys_Did_fcra_qa') );
output(choosen(		VotersV2.Key_Voters_States(isFCRA := true)	, luckynumber), named('vault_VotersV2_Key_Voters_States') );
output(choosen(		Watchdog.Key_Watchdog_FCRA_nonEN	, luckynumber), named('vault_Watchdog_Key_Watchdog_FCRA_nonEN') );
output(choosen(		Watchdog.Key_Watchdog_FCRA_nonEQ	, luckynumber), named('vault_Watchdog_Key_Watchdog_FCRA_nonEQ') );
output(choosen(		watercraft.key_watercraft_did(isFCRA := true)	, luckynumber), named('vault_watercraft_key_watercraft_did') );