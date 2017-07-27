#workunit('name', 'UCC PARTY STATS ' + ucc.UCC_Build_Date);

UCC_Parties := UCC.File_UCC_Expanded_Party;

Layout_UCC_Stat := RECORD
UCC_Parties.file_state;
INTEGER4 rec_code_count := SUM(GROUP, IF(UCC_Parties.rec_code<>'',1,0));
INTEGER4 rec_code_blank := SUM(GROUP, IF(UCC_Parties.rec_code='',1,0));

INTEGER4 contrib_num_count := SUM(GROUP, IF(UCC_Parties.contrib_num<>'',1,0));
INTEGER4 contrib_num_blank := SUM(GROUP, IF(UCC_Parties.contrib_num='',1,0));

INTEGER4 value_2900_count := SUM(GROUP, IF(UCC_Parties.value_2900<>'',1,0));
INTEGER4 value_2900_blank := SUM(GROUP, IF(UCC_Parties.value_2900='',1,0));

INTEGER4 orig_filing_num_count := SUM(GROUP, IF(UCC_Parties.orig_filing_num<>'',1,0));
INTEGER4 orig_filing_num_blank := SUM(GROUP, IF(UCC_Parties.orig_filing_num='',1,0));

INTEGER4 experian_rec_type_count := SUM(GROUP, IF(UCC_Parties.experian_rec_type<>'',1,0));
INTEGER4 experian_rec_type_blank := SUM(GROUP, IF(UCC_Parties.experian_rec_type='',1,0));

// Party type
INTEGER4 party_type_count := SUM(GROUP, IF(UCC_Parties.party_type<>'',1,0));
INTEGER4 party_type_D := SUM(GROUP, IF(UCC_Parties.party_type='D',1,0));
INTEGER4 party_type_S := SUM(GROUP, IF(UCC_Parties.party_type='S',1,0));
INTEGER4 party_type_A := SUM(GROUP, IF(UCC_Parties.party_type='A',1,0));
INTEGER4 party_type_other := SUM(GROUP, IF(UCC_Parties.party_type<>'' AND
                                  UCC_Parties.party_type NOT IN ['D','S','A'],1,0));
INTEGER4 party_type_blank := SUM(GROUP, IF(UCC_Parties.party_type='',1,0));

INTEGER4 orig_name_count := SUM(GROUP, IF(UCC_Parties.orig_name<>'',1,0));
INTEGER4 orig_name_blank := SUM(GROUP, IF(UCC_Parties.orig_name='',1,0));

INTEGER4 street_address_count := SUM(GROUP, IF(UCC_Parties.street_address<>'',1,0));
INTEGER4 street_address_blank := SUM(GROUP, IF(UCC_Parties.street_address='',1,0));

INTEGER4 city_count := SUM(GROUP, IF(UCC_Parties.city<>'',1,0));
INTEGER4 city_blank := SUM(GROUP, IF(UCC_Parties.city='',1,0));

INTEGER4 orig_state_count := SUM(GROUP, IF(UCC_Parties.orig_state<>'',1,0));
INTEGER4 orig_state_blank := SUM(GROUP, IF(UCC_Parties.orig_state='',1,0));

INTEGER4 zip_code_count := SUM(GROUP, IF(UCC_Parties.zip_code<>'',1,0));
INTEGER4 zip_code_blank := SUM(GROUP, IF(UCC_Parties.zip_code='',1,0));

INTEGER4 insert_date_count := SUM(GROUP, IF(UCC_Parties.insert_date<>'',1,0));
INTEGER4 insert_date_blank := SUM(GROUP, IF(UCC_Parties.insert_date='',1,0));

INTEGER4 filed_code_count := SUM(GROUP, IF(UCC_Parties.filed_code<>'',1,0));
INTEGER4 filed_code_blank := SUM(GROUP, IF(UCC_Parties.filed_code='',1,0));

INTEGER4 filed_place_count := SUM(GROUP, IF(UCC_Parties.filed_place<>'',1,0));
INTEGER4 filed_place_blank := SUM(GROUP, IF(UCC_Parties.filed_place='',1,0));

INTEGER4 ssn_count := SUM(GROUP, IF(UCC_Parties.ssn<>'',1,0));
INTEGER4 ssn_blank := SUM(GROUP, IF(UCC_Parties.ssn='',1,0));

INTEGER4 fk_orig_filing_date_count := SUM(GROUP, IF(UCC_Parties.fk_orig_filing_date<>'',1,0));
INTEGER4 fk_orig_filing_date_blank := SUM(GROUP, IF(UCC_Parties.fk_orig_filing_date='',1,0));

INTEGER4 fk_document_num_count := SUM(GROUP, IF(UCC_Parties.fk_document_num<>'',1,0));
INTEGER4 fk_document_num_blank := SUM(GROUP, IF(UCC_Parties.fk_document_num='',1,0));

//Filing type
INTEGER4 fk_filing_type_count := SUM(GROUP, IF(UCC_Parties.fk_filing_type<>'',1,0));
INTEGER4 fk_filing_type_0800 := SUM(GROUP, IF(UCC_Parties.fk_filing_type='0800',1,0));
INTEGER4 fk_filing_type_0801 := SUM(GROUP, IF(UCC_Parties.fk_filing_type='0801',1,0));
INTEGER4 fk_filing_type_0802 := SUM(GROUP, IF(UCC_Parties.fk_filing_type='0802',1,0));
INTEGER4 fk_filing_type_0803 := SUM(GROUP, IF(UCC_Parties.fk_filing_type='0803',1,0));
INTEGER4 fk_filing_type_0804 := SUM(GROUP, IF(UCC_Parties.fk_filing_type='0804',1,0));
INTEGER4 fk_filing_type_0805 := SUM(GROUP, IF(UCC_Parties.fk_filing_type='0805',1,0));
INTEGER4 fk_filing_type_0807 := SUM(GROUP, IF(UCC_Parties.fk_filing_type='0807',1,0));
INTEGER4 fk_filing_type_0808 := SUM(GROUP, IF(UCC_Parties.fk_filing_type='0808',1,0));
INTEGER4 fk_filing_type_0809 := SUM(GROUP, IF(UCC_Parties.fk_filing_type='0809',1,0));
INTEGER4 fk_filing_type_0831 := SUM(GROUP, IF(UCC_Parties.fk_filing_type='0831',1,0));
INTEGER4 fk_filing_type_other := SUM(GROUP, IF(UCC_Parties.fk_filing_type<>'' AND
                                   UCC_Parties.fk_filing_type NOT IN ['0800','0801','0802','0803','0804','0805','0807','0808','0809','0831'],1,0));
INTEGER4 fk_filing_type_blank := SUM(GROUP, IF(UCC_Parties.fk_filing_type='',1,0));

INTEGER4 fk_filing_date_count := SUM(GROUP, IF(UCC_Parties.fk_filing_date<>'',1,0));
INTEGER4 fk_filing_date_blank := SUM(GROUP, IF(UCC_Parties.fk_filing_date='',1,0));

INTEGER4 fk_debtor_orig_st_count := SUM(GROUP, IF(UCC_Parties.fk_debtor_orig_st<>'',1,0));
INTEGER4 fk_debtor_orig_st_blank := SUM(GROUP, IF(UCC_Parties.fk_debtor_orig_st='',1,0));

INTEGER4 Total := COUNT(GROUP);
END;

UCC_Stat := TABLE(UCC_Parties, Layout_UCC_Stat, file_state, FEW);

OUTPUT(UCC_Stat);