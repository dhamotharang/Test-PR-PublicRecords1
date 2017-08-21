


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
																														
																														

output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'AKCR'),1000),NAMED('AKCR_err'));           
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'ARCR'),1000),NAMED('ARCR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'AZCR'),1000),NAMED('AZCR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'CTCR'),1000),NAMED('CTCR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'FLCR'),1000),NAMED('FLCR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'GAGB'),1000),NAMED('GAGB_err'));      
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'IAOC'),1000),NAMED('IAOC_err'));        
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'INCR'),1000),NAMED('INCR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'MOCR'),1000),NAMED('MOCR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'NCCR'),1000),NAMED('NCCR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'NDCR'),1000),NAMED('NDCR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'NJCR'),1000),NAMED('NJCR_err'));      
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'OKCR'),1000),NAMED('OKCR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'ORCR'),1000),NAMED('ORCR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'PACR'),1000),NAMED('PACR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'PACP'),1000),NAMED('PACP_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'RICR'),1000),NAMED('RICR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'RITR'),1000),NAMED('RITR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'TNCR'),1000),NAMED('TNCR_err'));      
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'TXDP'),1000),NAMED('TXDP_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'UTCR'),1000),NAMED('UTCR_err'));            
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'VACR'),1000),NAMED('VACR_err'));                    
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'WICR'),1000),NAMED('WICR_err')); 	

output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'HICR'),1000),NAMED('HICR'));   
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'MDCR'),1000),NAMED('MDCR'));   
output(choosen(distinct_case_master_source_uid_err(OLD_RECORD_SUPPLIER_CD_C = 'NMCR'),1000),NAMED('NMCR'));   
																													
																																


																																