export Layout_liens_NYC_Judgments_liens := 
record
string50      RMSID;
string50      TMSID;
string8       process_date;
string2		COUNTY;
string9		KEY_VALUE;
string8		ENTRY_DATE;
string2		BOOK_TYPE;
string4		ENTRY_TIME;
string3		SEQ_NUM;
string8		EFFECTIVE_DATE;
string4		EFFECTIVE_TIME;
string8		EXPIRE_DATE;
string2		DOC_TYPE;
string2		COURT_TYPE;
string10	INDEX_NUMBER;
string8		ACCIDENT_DATE;
string2		D_COUNTY;
string1		DEBTOR_TYPE;
string42	DEBTOR_NAME;
string31      D_ADDR ;
string23      D_CITY	;
string5		D_ZIP5	;
string4		D_ZIP4;
string5		D_BLOCK_NUM;
string5		D_LOT_NUM;
string1		CREDITOR_TYPE;
string42	CREDITOR_NAME;
string6		C_STREET_NUM;
string25      C_STREET_NAME;
string20      C_CITY;
string5		C_ZIP5;
string4		C_ZIP4;
string1		ATTY_TYPE;
string42	ATTY_NAME;
string6		ATTY_STREET_NUM	;
string25    ATTY_STREET_NAME;
string20   ATTY_CITY;
string5		ATTY_ZIP5;
string4		ATTY_ZIP4;
string1		THD_PARTY_TYPE;
string42	THD_NAME;
string6		THD_STREET_NUM;
string25      THD_STREET_NAME	;
string20     THD_CITY;
string5		THD_ZIP5;
string4		THD_ZIP4;
string11	AMOUNT	;
string10	INTERIM_DISPO;
string8		SATIS_DATE;
string1		SATIS_TYPE;
string1		SHERIFF_FLAG;
string182    clean_debtor_addr;
string182    clean_credtor_addr;
string182    clean_atty_addr;
string182    clean_thd_addr;
string73      clean_debtor_pname;
string70      clean_debtor_cname;
string73      clean_credtor_pname;
string70      clean_credtor_cname;
string73      clean_atty_pname;
string70      clean_atty_cname;
string73      clean_thd_pname;
string70      clean_thd_cname;
string40      agency;
string2       FILING_JURISDICTION ;
string20	COURT_TYPE_DESC  ;
string50      DOC_TYPE_DESC  ;
string50      BOOK_TYPE_DESC ;
string50      STATIS_TYPE_DESC ;
string50      INTERIM_DISPO_DESC ;
end;
