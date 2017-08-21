







dist_File_valid_ecl_cade_id_source_uid :=  DISTRIBUTE(MI7.File_valid_ecl_cade_id_source_uid,HASH32(ecl_cade_id));	
dist_MapCourtOffensesToCriminalCharges :=  DISTRIBUTE(MI7.MapCourtOffensesToCriminalCharges,HASH32(ecl_cade_id));																		 

join_get_invalid_crim_charges := join(dist_File_valid_ecl_cade_id_source_uid , dist_MapCourtOffensesToCriminalCharges,
                                                                  left.ecl_cade_id = right.ecl_cade_id, RIGHT ONLY, local);
																																	
																																	
output(join_get_invalid_crim_charges);									
																								
distinct_crim_charges_source_uid_err := 
                             table(DISTRIBUTE(join_get_invalid_crim_charges,HASH32(OLD_RECORD_SUPPLIER_CD)),
                                               {old_record_supplier_cd,
																				         record_supplier_cd_c,
																				         cama_source_uid, 
																				         count2_ := count(group)}, 
																													 old_record_supplier_cd,
																													 record_supplier_cd_c,
																													 cama_source_uid, local);


output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'AKCR'),1000),NAMED('AKCR_err'));              
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'ARCR'),1000),NAMED('ARCR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'AZCR'),1000),NAMED('AZCR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'CTCR'),1000),NAMED('CTCR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'FLCR'),1000),NAMED('FLCR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'GAGB'),1000),NAMED('GAGB_err'));         
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'IAOC'),1000),NAMED('IAOC_err'));           
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'INCR'),1000),NAMED('INCR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'MOCR'),1000),NAMED('MOCR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'NCCR'),1000),NAMED('NCCR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'NDCR'),1000),NAMED('NDCR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'NJCR'),1000),NAMED('NJCR_err'));         
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'OKCR'),1000),NAMED('OKCR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'ORCR'),1000),NAMED('ORCR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'PACR'),1000),NAMED('PACR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'PACP'),1000),NAMED('PACP_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'RICR'),1000),NAMED('RICR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'RITR'),1000),NAMED('RITR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'TNCR'),1000),NAMED('TNCR_err'));         
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'TXDP'),1000),NAMED('TXDP_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'UTCR'),1000),NAMED('UTCR_err'));               
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'VACR'),1000),NAMED('VACR_err'));                       
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'WICR'),1000),NAMED('WICR_err'));    

output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'HICR'),1000),NAMED('HICR_err'));   
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'MDCR'),1000),NAMED('MDCR_err'));   
output(choosen(distinct_crim_charges_source_uid_err(OLD_RECORD_SUPPLIER_CD = 'NMCR'),1000),NAMED('NMCR_err'));   																														
																																																																	
																																	
																													