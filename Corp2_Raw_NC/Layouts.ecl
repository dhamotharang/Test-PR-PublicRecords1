EXPORT Layouts := MODULE;
       
	export  NamesLayoutIn:= record
	
		string 	EnameID;
		string 	Name_EntityID;
		string	Ename;
		string  NtypeID;
		string	Prefix;
		string	MiddleName;
		string	LastName;
		string	FirstName;
		string	Suffix;
		string 	Name_lf;
		
	end;
	
	export NamesLayoutBase := record
	
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		NamesLayoutIn;
			
	end;
	
	export  AddressesLayoutIn:= record
	
		string 	AddressID;
		string 	Address_EntityID;
		string	AtypeID;
		string  Addr1;
		string	Addr2;
		string	Addr3;
		string	City;
		string	State;
		string 	Zip;
		string	CountyName;
		string	Country;
		string 	Address_lf;
		
	end;
	
	export AddressesLayoutBase := record
	
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		AddressesLayoutIn;
			
	end;

	export  CorporationsLayoutIn:= record
	
		string 		Corp_PitemID;	
		string		Corp_EntityID;	
		string		OfficeAddrID;
		string		OfficeMailID;  
		string		AgentEntityID;
		string		CorpType;
		string		CorpNum;
		string		Status;
		string		Citzenship;	
		string		DateFormed;	
		string		DissolveDate;
		string		Duration;  
		string		CountyOfInc;
		string		CountryFileNum;
		string		StateOfInc;
		string		CountryOfInc;
		string		Purpose;	
		string		Profession;	
		string		Managed;
		string		Members;  
		string		Directors;
		string		MemberManaged;
		string		FiscalMonth;
		string		AnnualRptDueDate;
		string		OldStatus;	
		string		Corp_lf;
		
	end;
	
	export CorporationsLayoutBase := record
	
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		CorporationsLayoutIn;
			
	end;
	
	export  FilingsLayoutIn:= record
	
		string		EventLogID;	
		string		Filings_PitemID;	
		string		DocumentID;
		string		DocumentType;  
		string		FilingDate;
		string		EffectiveDate;
		string		lf;
		
	end;
	
	export FilingsLayoutBase := record
	
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		FilingsLayoutIn;
			
	end;
	
	export  PendingFilingsLayoutIn:= record
	
		string		EventLogID;	
		string		Filings_PitemID;	
		string		DocumentID;
		string		DocumentType;  
		string		FilingDate;
		string		EffectiveDate;
		string		lf;
		
	end;
	
	export PendingFilingsLayoutBase := record
	
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		PendingFilingsLayoutIn;
			
	end;
	
	export  CorpOfficersLayoutIn:= record
	
		string 	Offi_PitemID;
		string 	Offi_Tittle;
		string	EntityTypeID;
		string  Ename;
		string	Prefix;
		string	FirstName;
		string	MiddleName;
		string	LastName;
		string	Suffix;
		string  Addr1;
		string	Addr2;
		string	Addr3;
		string	City;
		string	State;
		string 	Zip;

	end;

	export CorpOfficersLayoutBase := record
	
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		CorpOfficersLayoutIn;
			
	end;

	export  StockLayoutIn:= record

		string		StockID;
		string		Stock_PitemID;	
		string		Created;	
		string		Class;
		string  	Shares;  
		string		NoParValue;
		string		ParValue;
		string		lf;
		
	end;
	
	export StockLayoutBase := record
	
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		StockLayoutIn;
			
	end;
	
	export  NameReservationsLayoutIn:= record
	
		string		EntityID;
		string		DocmentID;
		string		DocmentType;
		string		FilingDate;	 
		string		ExpirationDate;
		string		NameRes_StateOfInc;
		string		NameRes_CountryOfInc;	 
		string		NameRes_lf;
		
	end;	

	export NameReservationsLayoutBase := record
	
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		NameReservationsLayoutIn;
			
	end;
	
//Temp Layouts for file joins !! Always make sure ,any future vendor layout changes also reflect Temp layouts !
	
	export  Temp_Corp_Officers:= record
	
		CorpOfficersLayoutIn ;
		CorporationsLayoutIn ;
	
	end;
	
	export  Temp_Corp_Officers_Name:= record
		
		Temp_Corp_Officers;
		NamesLayoutIn;
	
	end;
	
	export Temp_Corp_Name:= record
	
		CorporationsLayoutIn;
		NamesLayoutIn;
		
	end;
		
	export Temp_nc_corp_addr:= record

		string 	addressid;
		string 	address_entityid;
		string	atypeid;
		string  o_addr1;
		string	o_addr2;
		string	o_addr3;
		string	o_city;
		string	o_state;
		string 	o_zip;
		string	o_countyname;
		string  b_addr1;
		string	b_addr2;
		string	b_addr3;
		string	b_city;
		string	b_state;
		string 	b_zip;
		string	b_countyname;
		string  m_addr1;
		string	m_addr2;
		string	m_addr3;
		string	m_city;
		string	m_state;
		string 	m_zip;
		string	m_countyname;

	end;
	
	export Temp_nc_ra_addr:= record
	
		string 	address_entityid;
		string	atypeid;
		string  rm_addr1;
		string	rm_addr2;
		string	rm_addr3;
		string	rm_city;
		string	rm_state;
		string 	rm_zip;
		string	rm_countyname;
		string  r_addr1;
		string	r_addr2;
		string	r_addr3;
		string	r_city;
		string	r_state;
		string 	r_zip;
		string	r_countyname;

	end;
	
	export Temp_nc_addr:= record
	
		Temp_nc_corp_addr;
		Temp_nc_ra_addr -address_entityid-atypeid;

	end;
	
	export Temp_nc_full_addr:= record
	
		Temp_Corp_Name;
		Temp_nc_addr;

	end;
	
	export Temp_SlimCorp_addr:= record

		Temp_Corp_Name;
		Temp_nc_corp_addr;

	end;
	
	export Temp_Name_ra:= record
		
		string 	Name_EntityID;		
		string  NtypeID;
		string 	ra_name;

	end;
	
	export Temp_Addr_ra:= record

		string 		Corp_PitemID;
		string		AgentEntityID;
		string		CorpNum;		
		Temp_nc_ra_addr;
		
	end;
	
	export Temp_SlimCorp_ra:= record
	
		Temp_Name_ra;
		Temp_Addr_ra;

  end;
		
	export  Temp_Corp_NameRes:= record
	
		CorporationsLayoutIn;
		NameReservationsLayoutIn;

 end;

	export  Temp_CorpNameRes_Name:= record

	 Temp_Corp_NameRes;
	 NamesLayoutIn;

	end;

	EXPORT Temp_Corp_StockFile := record

		CorporationsLayoutIn;
		StockLayoutIn;

	end; 

	EXPORT Temp_Corp_Filings := record

		CorporationsLayoutIn;
		FilingsLayoutIn;

	end;
	
	EXPORT Temp_Corp_PendingFilings:= record

		CorporationsLayoutIn;
		PendingFilingsLayoutIn;

	end;
	
end;