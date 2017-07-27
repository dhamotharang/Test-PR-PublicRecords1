IMPORT BankruptcyV2;

EXPORT layout_Trustee_Batch_in  := RECORD
	string30 acctno;	
	bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp.trusteeid;
	unsigned2 hold_days;
END;