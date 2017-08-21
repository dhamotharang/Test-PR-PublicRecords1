

distinct_case_master_source_uid := 
                             table(DISTRIBUTE(mi7.MapValidCaseMasterSourceUID,HASH32(OLD_RECORD_SUPPLIER_CD_C)),
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
																												
																														

output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'AKCR'),1000),NAMED('AKCR'));              
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'ARCR'),1000),NAMED('ARCR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'AZCR'),1000),NAMED('AZCR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'CTCR'),1000),NAMED('CTCR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'FLCR'),1000),NAMED('FLCR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'GAGB'),1000),NAMED('GAGB'));         
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'IAOC'),1000),NAMED('IAOC'));           
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'INCR'),1000),NAMED('INCR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'MOCR'),1000),NAMED('MOCR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'NCCR'),1000),NAMED('NCCR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'NDCR'),1000),NAMED('NDCR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'NJCR'),1000),NAMED('NJCR'));         
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'OKCR'),1000),NAMED('OKCR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'ORCR'),1000),NAMED('ORCR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'PACR'),1000),NAMED('PACR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'PACP'),1000),NAMED('PACP'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'RICR'),1000),NAMED('RICR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'RITR'),1000),NAMED('RITR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'TNCR'),1000),NAMED('TNCR'));         
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'TXDP'),1000),NAMED('TXDP'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'UTCR'),1000),NAMED('UTCR'));               
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'VACR'),1000),NAMED('VACR'));                       
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'WICR'),1000),NAMED('WICR'));      

output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'HICR'),1000),NAMED('HICR'));   
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'MDCR'),1000),NAMED('MDCR'));   
output(choosen(distinct_case_master_source_uid(OLD_RECORD_SUPPLIER_CD_C = 'NMCR'),1000),NAMED('NMCR'));   



																																


