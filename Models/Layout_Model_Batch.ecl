export Layout_Model_Batch := RECORD
	unsigned seq;
	string30	acctno;
	string3 score_0_to_999;
	string3 score_10_to_50;
	string3 score_10_to_90;
	string4	PRI_1;
	string100	PRI_Desc_1;
	string4	PRI_2;
	string100	PRI_Desc_2;
	string4	PRI_3;
	string100	PRI_Desc_3;
	string4	PRI_4;
	string100	PRI_Desc_4;
	string4	PRI_5 := '';
	string100	PRI_Desc_5 := '';
	string4	PRI_6 := '';
	string100	PRI_Desc_6 := '';
END;