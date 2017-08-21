export Layout_File_Harris_TX_in       
		:= Record
	   
			string8        process_date;
			string3        JobCode; 
			string7        FileNumber; 
			string8        DateFiled; 
			string27       NameofDebtor; 
			string24       DebtorStreetAddr; 
			string14       DebtorCityZip; 
			string14       DebtorStateZip; 
			string27       NameofMortgagee; 
			string24       MortgageeStrAddr; 
			string14       Mortgageecityzip; 
			string14       Mortgageestatezip; 
			string6        ProcessingFees; 
			string9        MicrofilmNumber; 
			string8        DateInstrFiled; 
			string8        Datewillterminate; 
			string24       Description; 
			string24       Collateral_Filing_Type; 
			string7        UCCNumber; 
			string182      clean_Sec_address;
			string182      clean_Debtor_address;
			string73       Sec_pname;
			string73       Debtor_pname;
		end;