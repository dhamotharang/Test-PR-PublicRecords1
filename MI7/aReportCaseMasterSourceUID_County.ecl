






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
																												
																														

output(distinct_case_master_source_uid(old_record_supplier_cd_c ='AZGI'),NAMED('AZGI'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='AZMC'),NAMED('AZMC'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='AZPI'),NAMED('AZPI'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CACO'),NAMED('CACO'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CAFR'),NAMED('CAFR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CALA'),NAMED('CALA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CAMA'),NAMED('CAMA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CAOR'),NAMED('CAOR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CARI'),NAMED('CARI'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CAIN'),NAMED('CAIN'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CABA'),NAMED('CABA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CACL'),NAMED('CACL'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CASC'),NAMED('CASC'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CASB'),NAMED('CASB'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CASD'),NAMED('CASD'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='CAVE'),NAMED('CAVE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLAN'),NAMED('FLAN'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLBA'),NAMED('FLBA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLBR'),NAMED('FLBR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLBO'),NAMED('FLBO'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLCH'),NAMED('FLCH'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLDA'),NAMED('FLDA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLDU'),NAMED('FLDU'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLHE'),NAMED('FLHE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLHI'),NAMED('FLHI'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLHL'),NAMED('FLHL'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLLE'),NAMED('FLLE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLLN'),NAMED('FLLN'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLMR'),NAMED('FLMR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLME'),NAMED('FLME'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLOR'),NAMED('FLOR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLOS'),NAMED('FLOS'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLPB'),NAMED('FLPB'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLPI'),NAMED('FLPI'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='FLSA'),NAMED('FLSA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='GACB'),NAMED('GACB'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='GAGW'),NAMED('GAGW'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='ILCK'),NAMED('ILCK'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='LAST'),NAMED('LAST'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='MIWA'),NAMED('MIWA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='MSHN'),NAMED('MSHN'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHLE'),NAMED('OHLE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHVA'),NAMED('OHVA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHDA'),NAMED('OHDA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHFL'),NAMED('OHFL'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHNE'),NAMED('OHNE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHAX'),NAMED('OHAX'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHAL'),NAMED('OHAL'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHAT'),NAMED('OHAT'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHBR'),NAMED('OHBR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHBU'),NAMED('OHBU'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHCL'),NAMED('OHCL'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHCT'),NAMED('OHCT'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHCM'),NAMED('OHCM'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHBE'),NAMED('OHBE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHEU'),NAMED('OHEU'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHDE'),NAMED('OHDE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHFR'),NAMED('OHFR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHFK'),NAMED('OHFK'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHFU'),NAMED('OHFU'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHGR'),NAMED('OHGR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHXE'),NAMED('OHXE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHLA'),NAMED('OHLA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHLI'),NAMED('OHLI'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHHU'),NAMED('OHHU'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHKE'),NAMED('OHKE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHMO'),NAMED('OHMO'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHPO'),NAMED('OHPO'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHRO'),NAMED('OHRO'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHRC'),NAMED('OHRC'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHSR'),NAMED('OHSR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHST'),NAMED('OHST'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHAK'),NAMED('OHAK'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHSM'),NAMED('OHSM'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHBA'),NAMED('OHBA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHTR'),NAMED('OHTR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHTU'),NAMED('OHTU'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHWA'),NAMED('OHWA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHWR'),NAMED('OHWR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='OHMA'),NAMED('OHMA'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='SCRI'),NAMED('SCRI'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXBE'),NAMED('TXBE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXBR'),NAMED('TXBR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXCL'),NAMED('TXCL'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXDL'),NAMED('TXDL'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXDT'),NAMED('TXDT'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXEP'),NAMED('TXEP'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXFB'),NAMED('TXFB'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXGR'),NAMED('TXGR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXHR'),NAMED('TXHR'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXJE'),NAMED('TXJE'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXJO'),NAMED('TXJO'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXMD'),NAMED('TXMD'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXMG'),NAMED('TXMG'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXPO'),NAMED('TXPO'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='TXVC'),NAMED('TXVC'));
output(distinct_case_master_source_uid(old_record_supplier_cd_c ='VAFA'),NAMED('VAFA'));
    


																																


