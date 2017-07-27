#workunit('name', 'UCC FILINGS STATS ' + ucc.UCC_Build_Date);

UCC_Filings := UCC.File_UCC_Expanded_Filing;

Layout_UCC_Stat := RECORD
UCC_Filings.file_state;
INTEGER4 rec_code_count := SUM(GROUP, IF(UCC_Filings.rec_code<>'',1,0));
INTEGER4 rec_code_blank := SUM(GROUP, IF(UCC_Filings.rec_code='',1,0));

INTEGER4 contrib_num_count := SUM(GROUP, IF(UCC_Filings.contrib_num<>'',1,0));
INTEGER4 contrib_num_blank := SUM(GROUP, IF(UCC_Filings.contrib_num='',1,0));

INTEGER4 value_2900_count := SUM(GROUP, IF(UCC_Filings.value_2900<>'',1,0));
INTEGER4 value_2900_blank := SUM(GROUP, IF(UCC_Filings.value_2900='',1,0));

INTEGER4 orig_filing_num_count := SUM(GROUP, IF(UCC_Filings.orig_filing_num<>'',1,0));
INTEGER4 orig_filing_num_blank := SUM(GROUP, IF(UCC_Filings.orig_filing_num='',1,0));

INTEGER4 experian_rec_type_count := SUM(GROUP, IF(UCC_Filings.experian_rec_type<>'',1,0));
INTEGER4 experian_rec_type_blank := SUM(GROUP, IF(UCC_Filings.experian_rec_type='',1,0));

//Filing type
INTEGER4 filing_type_count := SUM(GROUP, IF(UCC_Filings.filing_type<>'',1,0));
INTEGER4 filing_type_0800 := SUM(GROUP, IF(UCC_Filings.filing_type='0800',1,0));
INTEGER4 filing_type_0801 := SUM(GROUP, IF(UCC_Filings.filing_type='0801',1,0));
INTEGER4 filing_type_0802 := SUM(GROUP, IF(UCC_Filings.filing_type='0802',1,0));
INTEGER4 filing_type_0803 := SUM(GROUP, IF(UCC_Filings.filing_type='0803',1,0));
INTEGER4 filing_type_0804 := SUM(GROUP, IF(UCC_Filings.filing_type='0804',1,0));
INTEGER4 filing_type_0805 := SUM(GROUP, IF(UCC_Filings.filing_type='0805',1,0));
INTEGER4 filing_type_0807 := SUM(GROUP, IF(UCC_Filings.filing_type='0807',1,0));
INTEGER4 filing_type_0808 := SUM(GROUP, IF(UCC_Filings.filing_type='0808',1,0));
INTEGER4 filing_type_0809 := SUM(GROUP, IF(UCC_Filings.filing_type='0809',1,0));
INTEGER4 filing_type_0831 := SUM(GROUP, IF(UCC_Filings.filing_type='0831',1,0));
INTEGER4 filing_type_other := SUM(GROUP, IF(UCC_Filings.filing_type<>'' AND
                                   UCC_Filings.filing_type NOT IN ['0800','0801','0802','0803','0804','0805','0807','0808','0809','0831'],1,0));
INTEGER4 filing_type_blank := SUM(GROUP, IF(UCC_Filings.filing_type='',1,0));

INTEGER4 document_num_count := SUM(GROUP, IF(UCC_Filings.document_num<>'',1,0));
INTEGER4 document_num_blank := SUM(GROUP, IF(UCC_Filings.document_num='',1,0));

INTEGER4 filing_date_count := SUM(GROUP, IF(UCC_Filings.filing_date<>'',1,0));
INTEGER4 filing_date_blank := SUM(GROUP, IF(UCC_Filings.filing_date='',1,0));

INTEGER4 orig_filing_date_count := SUM(GROUP, IF(UCC_Filings.orig_filing_date<>'',1,0));
INTEGER4 orig_filing_date_blank := SUM(GROUP, IF(UCC_Filings.orig_filing_date='',1,0));

INTEGER4 collateral_code_count := SUM(GROUP, IF(UCC_Filings.collateral_code<>'',1,0));
INTEGER4 collateral_code_blank := SUM(GROUP, IF(UCC_Filings.collateral_code='',1,0));

INTEGER4 fk_debtor_orig_st_count := SUM(GROUP, IF(UCC_Filings.fk_debtor_orig_st<>'',1,0));
INTEGER4 fk_debtor_orig_st_blank := SUM(GROUP, IF(UCC_Filings.fk_debtor_orig_st='',1,0));

INTEGER4 fk_filing_seq_num_count := SUM(GROUP, IF(UCC_Filings.fk_filing_seq_num<>'',1,0));
INTEGER4 fk_filing_seq_num_blank := SUM(GROUP, IF(UCC_Filings.fk_filing_seq_num='',1,0));

INTEGER4 Total := COUNT(GROUP);
END;

UCC_Stat := TABLE(UCC_Filings, Layout_UCC_Stat, file_state, FEW);

OUTPUT(UCC_Stat);