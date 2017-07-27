import liensv2;

export Get_Infile_Record_Length(string updatetype) := 
	map(updatetype = 'federal' => sizeof(liensv2.Layout_Liens_NYFDLN),
	    updatetype = 'Okclien' => sizeof(LiensV2.Layout_Liens_Hogan),
		updatetype = 'ServAbs' => sizeof(LiensV2.Layout_Liens_Service_Abstract),
		updatetype = 'BusDtor' => sizeof(LiensV2.Layout_liens_CA_Federal_Business_Debtor),
		updatetype = 'BusSecp' => sizeof(LiensV2.Layout_Liens_CA_Fedral_Business_secured_party),
		updatetype = 'PerDtor' => sizeof(LiensV2.Layout_Liens_CA_Fedral_Person_Debtor),
		updatetype = 'PerSecp' => sizeof(LiensV2.Layout_Liens_CA_Fedral_Person_Secured_party),
		updatetype = 'filings' => sizeof(LiensV2.Layout_Liens_CA_Federal_Filing_Info),
		updatetype = 'chgfilg' => sizeof(LiensV2.Layout_Liens_CA_Fedral_Change_Filing),
		updatetype = 'judgmts' => sizeof(LiensV2.Layout_liens_NYC_Judgments_liens),
		updatetype = 'crdatty' => sizeof(LiensV2.Layout_Liens_Superior_Creditor_Atty_In),
        updatetype = 'credtor' => sizeof(LiensV2.Layout_liens_Superior_Creditor_in),
        updatetype = 'detatty' => sizeof(LiensV2.Layout_Liens_Superior_Debtor_Atty_In),
        updatetype = 'debtorn' => sizeof(LiensV2.Layout_Liens_Superior_Debtor_In),
        updatetype = 'judment' => sizeof(LiensV2.Layout_Liens_Superior_Judgment_In),
        updatetype = 'subjdmt' => sizeof(LiensV2.Layout_Liens_Superior_Sub_Judgment_In),
        updatetype = 'remarks' => sizeof(LiensV2.Layout_Liens_Superior_Remarks_In),	
		 0);
		 
		 
