import corp2_mapping, corp2;

EXPORT Layouts := module

		EXPORT Lay_GovPersons := RECORD 
			string Title									{xpath('Title')};
			string FirstName							{xpath('FirstName')};		
			string MiddleName							{xpath('MiddleName')};	
			string LastName								{xpath('LastName')};	
			string Address								{xpath('Address')};	
			string City										{xpath('City')};	
			string State									{xpath('State')};				
			string Zip										{xpath('Zip')};	
		END;

    // Raw Vendor Input File
		EXPORT CorpsLayoutIN 	:= RECORD 
			string UBI										{xpath('UBI')};
			string BusinessName						{xpath('BusinessName')};          
			string Category								{xpath('Category')}; 
			string StateOfIncorporation		{xpath('StateOfIncorporation')}; 
			string DateOfIncorporation		{xpath('DateOfIncorporation')}; 
			string ExpirationDate					{xpath('ExpirationDate')}; 
			string Duration               {xpath('Duration')};
			string DissolutionDate				{xpath('DissolutionDate')}; 
			string Active									{xpath('Active')}; 
			string Type										{xpath('Type')}; 
			string RegisteredAgentName		{xpath('RegisteredAgentName')}; 
			string RegisteredAgentAddress	{xpath('RegisteredAgentAddress')}; 
			string RegisteredAgentCity		{xpath('RegisteredAgentCity')}; 
			string RegisteredAgentState		{xpath('RegisteredAgentState')}; 
			string RegisteredAgentZip			{xpath('RegisteredAgentZip')}; 
			string AlternateAddress				{xpath('AlternateAddress')}; 
			string AlternateCity					{xpath('AlternateCity')}; 
			string AlternateState					{xpath('AlternateState')}; 
			string AlternateZip						{xpath('AlternateZip')}; 
			dataset (Lay_GovPersons) GoverningPersons {xpath('GoverningPersons/GoverningPerson')};
		END;


    // Base File Layout
		EXPORT CorpsLayoutBASE := RECORD
		  string1		action_flag;
		  unsigned4	dt_first_received;
		  unsigned4	dt_last_received;		
		  CorpsLayoutIN;
	  END;
	  		 
	    
		//---------------------------------
		// TEMPORARY LAYOUTS
		//---------------------------------
   
	 // CorpsIn Normalized on Both RA Addresses
	 EXPORT normCorpLayout := record
	   CorpsLayoutIN;
		 string  NormAddr;
		 string  NormCity;
		 string  NormState;
		 string  NormZip;
		 string  NormCd;
		 string  NormDesc;
	END;	 
	
	 // GoverningPerson child dataset layout having a linking-id in each record 
	 EXPORT ContactChildRec := record 
		string UBI_id; 
		string BusinessName;
		Lay_GovPersons;
	END;
	
END;			
