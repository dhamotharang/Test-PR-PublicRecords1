


distinct_crim_charges_source_uid := 
                             table(DISTRIBUTE(mi7.MapValidCriminalChargesSourceUID,HASH32(OLD_RECORD_SUPPLIER_CD)),
                                               {old_record_supplier_cd,
																				         record_supplier_cd_c,
																				         cama_source_uid, 
																				         count1_ := count(group)}, 
																													 old_record_supplier_cd,
																													 record_supplier_cd_c,
																													 cama_source_uid, local);

output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'AKCR'),1000),NAMED('AKCR'));              
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'ARCR'),1000),NAMED('ARCR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'AZCR'),1000),NAMED('AZCR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'CTCR'),1000),NAMED('CTCR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'FLCR'),1000),NAMED('FLCR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'GAGB'),1000),NAMED('GAGB'));         
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'IAOC'),1000),NAMED('IAOC'));           
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'INCR'),1000),NAMED('INCR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'MOCR'),1000),NAMED('MOCR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'NCCR'),1000),NAMED('NCCR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'NDCR'),1000),NAMED('NDCR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'NJCR'),1000),NAMED('NJCR'));         
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'OKCR'),1000),NAMED('OKCR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'ORCR'),1000),NAMED('ORCR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'PACR'),1000),NAMED('PACR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'PACP'),1000),NAMED('PACP'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'RICR'),1000),NAMED('RICR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'RITR'),1000),NAMED('RITR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'TNCR'),1000),NAMED('TNCR'));         
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'TXDP'),1000),NAMED('TXDP'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'UTCR'),1000),NAMED('UTCR'));               
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'VACR'),1000),NAMED('VACR'));                       
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'WICR'),1000),NAMED('WICR'));    

output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'HICR'),1000),NAMED('HICR'));   
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'MDCR'),1000),NAMED('MDCR'));   
output(choosen(distinct_crim_charges_source_uid(OLD_RECORD_SUPPLIER_CD = 'NMCR'),1000),NAMED('NMCR'));   																														
																																
																														
																																


																																

