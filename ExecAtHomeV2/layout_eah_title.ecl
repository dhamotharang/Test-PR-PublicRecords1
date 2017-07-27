export layout_eah_title := record
	unsigned4 seq;
	string20 acctno;
	string20 customer_id;
	unsigned6 bdid;
	unsigned6 did;
	unsigned6 hhid;
	string35 company_title; 
	string1 confidence_code;
	//string1 decision_maker_flag;
	string1 business_decision_maker_flag;
	string1 business_owner_flag;
end;