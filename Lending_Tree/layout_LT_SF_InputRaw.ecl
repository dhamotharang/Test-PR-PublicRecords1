/*2015-02-12T00:49:20Z (Uma Pamarthy)
New Layout from Vendor
*/
EXPORT layout_LT_SF_InputRaw := record
 // New layout from 20141218 update
 		String	BillingID;
		String	LenderName;
		String	LenderID;
		String	AccountManager;
		String	QFormName;
		String	QFormID;
		String	QFormUID;
		String	BorrowerID;
		String	BorrowerSSN;
		String	BorrowerFirstName;
		String	BorrowerLastName;
		String	BorrowerMiddleName;
		String	CoBorrowerSSN;
		String	CoBorrowerFirstName;
		String	CoBorrowerLastName;
		String	CoBorrowerMiddleName;
		String	CompleteDate;
		String	TransmitDate;
		String	RequestedProduct;
		String	RequestedSubProduct;
		String	FoundAHome;
		String	CreditScore;
		String	StatedCreditHistory;
		String	AmountRequested;
		String	FilterClassLookup;
		String	FixedFilterDescription;
		//String	FilterClassLookupID;  - not in Sept 2015 data
		String	PropertyUse;
		String	AddressLine1;
		String	City;
		String	State;
		String	PostalCode;
		String	UnformattedBorrowerSSN;
End;
 
 
 
 
 
 
 
 /*
 string12	process_id;
   string8 	billing_id;
   string10 lender_id;
   string80 lender_name;
	 string25 accountmanager;
	 string5  name_prefix;
//   string5  title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 	name_suffix;
   string3 	name_score;
   string8 	qform_name;
   string8 	qform_id;
   string36 qform_uid;
	 string10 borrower_id;
   string11 ssnf;
   string20 orig_fname;
   string20 orig_lname;
   string20 orig_mname;
   string23 qfcompleted_date;
   string23 transmit_date;
   string23 requested_product;
   string18 requested_sub_product;
   string1 	found_home;
   string3 	credit_score;
	 string9    stated_credit_history;
   string11 amount_requested;
   string39	filter_class_lookup;
   string86	fixed_filter_desc;
   string2   filter_class_lookup_id;
	 string9   ssn;
	 string1   lf;
	end;
*/