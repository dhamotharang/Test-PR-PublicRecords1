import corp2_mapping, corp2;
 
EXPORT Layouts := module

    // Corporations Raw Vendor Input File
		EXPORT CorporationsLayoutIN 	:= RECORD 
			string UBI										{xpath('Ubi')};
			string BusinessName						{xpath('BusinessName')}; 
			string RecordStatus           {xpath('RecordStatus')};  
			string Category								{xpath('Category')}; 
			string StateOfIncorporation		{xpath('StateOfIncorporation')}; 
			string DateOfIncorporation		{xpath('DateOfIncorporation')}; 
			string ExpirationDate					{xpath('ExpirationDate')}; 
			string DissolutionDate				{xpath('DissolutionDate')}; 
			string Duration               {xpath('Duration')};
			string Type										{xpath('Type')}; 
			string TypeDescription        {xpath('TypeDescription')};  
			string RegisteredAgentName		{xpath('RegisteredAgentName')}; 
			string RegisteredAgentAddress	{xpath('RegisteredAgentAddress')}; 
			string RegisteredAgentCity		{xpath('RegisteredAgentCity')}; 
			string RegisteredAgentState		{xpath('RegisteredAgentState')}; 
			string RegisteredAgentZip			{xpath('RegisteredAgentZip')}; 
		END;

    // Governing Persons Raw Vendor Input File
		EXPORT GoverningPersonsLayoutIN 	:= RECORD 
			string UBI				    				{xpath('Ubi')}; 
			string Title									{xpath('Title')}; 
			string FirstName      				{xpath('FirstName')};  
			string MiddleName		 				  {xpath('MiddleName')};
			string LastName								{xpath('LastName')};
			string Address								{xpath('Address')};
			string City										{xpath('City')}; 
 			string State		    				  {xpath('State')}; 
			string Zip           					{xpath('Zip')};
		END;
		
		// Document Types Raw Vendor Input File
		EXPORT DocumentTypesLayoutIN 	:= RECORD 
			string UBI      							{xpath('Ubi')}; 	
			string CompletedDate					{xpath('CompletedDate')}; 
			string Document								{xpath('Document')}; 
		END;
	 	    
	//---------------------------------
	// TEMPORARY LAYOUTS
	//---------------------------------
	 EXPORT TempCorporationsLayout  := RECORD
			CorporationsLayoutIN;
	    DocumentTypesLayoutIN.Document;
			DocumentTypesLayoutIN.CompletedDate;
	 END; 
	 
   EXPORT TempContactsLayout  := RECORD
			GoverningPersonsLayoutIN;
	    CorporationsLayoutIN.BusinessName;
	 END; 
	 
	 EXPORT TempARLayout  := RECORD
			DocumentTypesLayoutIN;
			CorporationsLayoutIN.ExpirationDate;
			CorporationsLayoutIN.BusinessName;
	 END;
	 
	 EXPORT TempEventLayout  := RECORD
			DocumentTypesLayoutIN;
			CorporationsLayoutIN.BusinessName;
	 END;
	 
	 // Leaving this commented out per the CI since we should be receiving alternate addresses soon
	 // CorpsIn Normalized on Both RA Addresses
	 // EXPORT normCorpLayout := record
	   // CorpsLayoutIN;
		 // string  NormAddr;
		 // string  NormCity;
		 // string  NormState;
		 // string  NormZip;
		 // string  NormCd;
		 // string  NormDesc;
	// END;	 
	
END;			
