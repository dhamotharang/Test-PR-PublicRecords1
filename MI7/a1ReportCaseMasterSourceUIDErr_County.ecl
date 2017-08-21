





ds_invalid_case_master :=  mi7.MapSourceUIDValidation(REGEXFIND('Error',SOURCE_UID_C,NOCASE)=true);																															
														

distinct_case_master_source_uid_err := 
                             table(DISTRIBUTE(ds_invalid_case_master,HASH32(OLD_RECORD_SUPPLIER_CD_C)),
                                               {old_record_supplier_cd_c,
																				         record_supplier_cd_c,
																				         source_uid_c, 
																				         source_state_cd_c,
																				         source_county_cd_c,
																				         source_county_name_c,
																				         district_name_uid,count1_ := count(group)}, 
																													 old_record_supplier_cd_c,
																													 record_supplier_cd_c,
																													 source_uid_c, 
																													 source_state_cd_c,
																													 source_county_cd_c,
																													 source_county_name_c,
																													 district_name_uid ,local);
																													//  : persist ('~thor_data400::persist::out::crim::distinct_case_master_source_uid_err');
																														
		
		
	
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='AZGI'),NAMED('AZGI_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='AZMC'),NAMED('AZMC_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='AZPI'),NAMED('AZPI_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CACO'),NAMED('CACO_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CAFR'),NAMED('CAFR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CALA'),NAMED('CALA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CAMA'),NAMED('CAMA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CAOR'),NAMED('CAOR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CARI'),NAMED('CARI_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CAIN'),NAMED('CAIN_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CABA'),NAMED('CABA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CACL'),NAMED('CACL_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CASC'),NAMED('CASC_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CASB'),NAMED('CASB_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CASD'),NAMED('CASD_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='CAVE'),NAMED('CAVE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLAN'),NAMED('FLAN_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLBA'),NAMED('FLBA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLBR'),NAMED('FLBR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLBO'),NAMED('FLBO_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLCH'),NAMED('FLCH_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLDA'),NAMED('FLDA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLDU'),NAMED('FLDU_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLHE'),NAMED('FLHE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLHI'),NAMED('FLHI_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLHL'),NAMED('FLHL_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLLE'),NAMED('FLLE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLLN'),NAMED('FLLN_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLMR'),NAMED('FLMR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLME'),NAMED('FLME_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLOR'),NAMED('FLOR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLOS'),NAMED('FLOS_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLPB'),NAMED('FLPB_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLPI'),NAMED('FLPI_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='FLSA'),NAMED('FLSA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='GACB'),NAMED('GACB_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='GAGW'),NAMED('GAGW_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='ILCK'),NAMED('ILCK_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='LAST'),NAMED('LAST_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='MIWA'),NAMED('MIWA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='MSHN'),NAMED('MSHN_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHLE'),NAMED('OHLE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHVA'),NAMED('OHVA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHDA'),NAMED('OHDA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHFL'),NAMED('OHFL_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHNE'),NAMED('OHNE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHAX'),NAMED('OHAX_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHAL'),NAMED('OHAL_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHAT'),NAMED('OHAT_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHBR'),NAMED('OHBR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHBU'),NAMED('OHBU_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHCL'),NAMED('OHCL_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHCT'),NAMED('OHCT_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHCM'),NAMED('OHCM_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHBE'),NAMED('OHBE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHEU'),NAMED('OHEU_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHDE'),NAMED('OHDE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHFR'),NAMED('OHFR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHFK'),NAMED('OHFK_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHFU'),NAMED('OHFU_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHGR'),NAMED('OHGR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHXE'),NAMED('OHXE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHLA'),NAMED('OHLA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHLI'),NAMED('OHLI_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHHU'),NAMED('OHHU_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHKE'),NAMED('OHKE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHMO'),NAMED('OHMO_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHPO'),NAMED('OHPO_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHRO'),NAMED('OHRO_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHRC'),NAMED('OHRC_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHSR'),NAMED('OHSR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHST'),NAMED('OHST_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHAK'),NAMED('OHAK_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHSM'),NAMED('OHSM_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHBA'),NAMED('OHBA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHTR'),NAMED('OHTR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHTU'),NAMED('OHTU_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHWA'),NAMED('OHWA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHWR'),NAMED('OHWR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='OHMA'),NAMED('OHMA_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='SCRI'),NAMED('SCRI_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXBE'),NAMED('TXBE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXBR'),NAMED('TXBR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXCL'),NAMED('TXCL_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='STXD'),NAMED('STXD_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXDT'),NAMED('TXDT_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXEP'),NAMED('TXEP_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXFB'),NAMED('TXFB_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXGR'),NAMED('TXGR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXHR'),NAMED('TXHR_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXJE'),NAMED('TXJE_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXJO'),NAMED('TXJO_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXMD'),NAMED('TXMD_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXMG'),NAMED('TXMG_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXPO'),NAMED('TXPO_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='TXVC'),NAMED('TXVC_err'));
output(distinct_case_master_source_uid_err(old_record_supplier_cd_c ='VAFA'),NAMED('VAFA_err'));
    
		


																																


																																