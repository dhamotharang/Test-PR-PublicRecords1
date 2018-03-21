IMPORT OKC_Probate,Address;

EXPORT Layout := module

	export raw := record
		string  MasterID;	
		string  DebtorFirstName;	
		string  DebtorLastName;	
		string  DebtorAddress1;	
		string  DebtorAddress2;	
		string  DebtorAddressCity;	
		string  DebtorAddressState;	
		string  DebtorAddressZipCode;
		string  DateOfDeath;	
		string  DateOfBirth;	
		string  IsProbateLocated;	
		string  CaseNumber;	
		string  FilingDate;
		string  LastDateToFileClaim;	
		string  IsSubjectToCreditorsClaim;	
		string  PublicationStartDate;	
		string  IsEstateOpen;	
		string  ExecutorFirstName;	
		string  ExecutorLastName;	
		string  ExecutorAddress1;	
		string  ExecutorAddress2;	
		string  ExecutorAddressCity;	
		string  ExecutorAddressState;	
		string  ExecutorAddressZipCode;	
		string  ExecutorPhone;	
		string  AttorneyFirstName;	
		string  AttorneyLastName;	
		string  Firm;	
		string  AttorneyAddress1;	
		string  AttorneyAddress2;	
		string  AttorneyAddressCity;	
		string  AttorneyAddressState;	
		string  AttorneyAddressZipCode;	
		string  AttorneyPhone;	
		string  AttorneyEmail;	
		string  DocumentTypes;	
		string  Corr_DateOfDeath;
	end;

	export raw_v2 := record
		string filedate;
		string dod;
		string dob;
		raw;
	end;


	export CleanName  := record
		raw_v2;
		STRING20  pdid := '';
		STRING20  pfrd_address_ind:='';
		UNSIGNED8 rawAid := 0;
	 UNSIGNED8 nid := 0;
		STRING25 		cln_title := '';
		STRING30  	cln_fname := '';
		STRING30  	cln_mname := '';
		STRING30  	cln_lname := '';
		STRING5 		 cln_suffix := '';
		STRING25	 	cln_title2 := '';
		STRING30  	cln_fname2 := '';
		STRING30  	cln_mname2 := '';
		STRING30  	cln_lname2 := '';
		STRING5   	cln_suffix2 := '';
	 UNSIGNED8  name_ind := 0;
	 UNSIGNED8  persistent_record_id := 0;
		STRING100   cname := '';
	end;
		

	export CleanAddress := record
		CleanName;
		UNSIGNED8 cleanaid;
		STRING5		addresstype;
		Address.Layout_Clean182_fips;
		UNSIGNED8	rawaidin				:=	0;
	End;


	export Base_raw := record
		string name_score;
	 CleanAddress;
	end;
end;