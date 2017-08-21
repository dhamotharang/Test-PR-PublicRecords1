EXPORT Layouts := module

  shared max_size := _Dataset().max_record_size;

	export CorpsEntitiesChildren				:= record, 		maxlength(max_size)
			string AddressType														{xpath('AddressType')};
			string Address1																{xpath('Address1')};
			string Address2																{xpath('Address2')};
			string City																		{xpath('City')};
			string StateorProvince												{xpath('StateorProvince')};
			string ZipCode																{xpath('ZipCode')};
			string Country																{xpath('Country')};
			string Parish																	{xpath('Parish')};
	end;
		 
	export CorpsEntitiesChild						:= record, 		maxlength(max_size)
			string  Addr_EntityID; 
			CorpsEntitiesChildren;		
	end;
		
	export CorpsEntitiesLayoutIn				:= record, 		maxlength(max_size)
			string EntityName															{xpath('EntityName')};
			string EntityID																{xpath('EntityID')};
			string CharterCategory												{xpath('CharterCategory')};
			string EntityStartDate								      	{xpath('EntityStartDate')};
			string EntityStatus														{xpath('EntityStatus')};
			string InactiveReason													{xpath('InactiveReason')};
			string InactiveDate									         	{xpath('InactiveDate')};
			string InactiveActionDate   									{xpath('InactiveActionDate')};
			string InactiveEffectiveDate									{xpath('InactiveEffectiveDate')};
			string GoodStdStatus													{xpath('GoodStandingStatus')};
			dataset(CorpsEntitiesChildren) CorpAddress		{xpath('Addresses')};
	end;
	
	export CorpsEntitiesLayoutBase   		:= record
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			CorpsEntitiesLayoutIn;
	end;	
	
	export AgentsChildren								:= record, 		maxlength(max_size)
			string FirstName															{xpath('FirstName')};
			string LastName    														{xpath('LastName')};
			string Agent_Address1													{xpath('Address1')};
			string Agent_Address2													{xpath('Address2')};
			string Agent_City   													{xpath('City')};
			string Agent_State   													{xpath('State')};
			string PostalCode   													{xpath('PostalCode')};
			string Titles   															{xpath('Titles')};
			string EmailAddress    												{xpath('EmailAddress')};
			string DateAppointed   												{xpath('DateAppointed')};
	end;
	
	export AgentsChild									:= record, 		maxlength(max_size)
			string  Agents_EntityID; 
			AgentsChildren;						
	end;

	export AgentsLayoutIn								:= record, 		maxlength(max_size)
			string Agent_EntityID   											{xpath('EntityID')};
			dataset(AgentsChildren) Agents								{xpath('PartiesofRecord')};	
	end;
	
	export AgentsLayoutBase  				 		:= record
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			AgentsLayoutIn;
	end;

	export FilingsChildren							:= record, 		maxlength(max_size)
			string FilingDate															{xpath('FilingDate')};
			string FilingType															{xpath('FilingType')};
			string FilingID																{xpath('FilingID')};
	end;

	export FilingsChild									:= record, 		maxlength(max_size)
			string  Filing_EntityID; 
			FilingsChildren;						
	end;
		 
	export FilingsLayoutIn							:= record, 		maxlength(max_size)
			string Filing_EntityID												{xpath('EntityID')};
			dataset (FilingsChildren)  Filings 						{xpath('Filings')};
	end;
	
	export FilingsLayoutBase  					:= record
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			FilingsLayoutIn;
	end;

	export MergerParties								:= record, 		maxlength(max_size)
			string EntityID																{xpath('EntityID')};
			string merger_EntityName         							{xpath('EntityName')};  
  end;

	export MergersChildren 							:= record, 		maxlength(max_size)
			string MergerDate															{xpath('MergerDate')};
			string Role																		{xpath('Role')};
			dataset (MergerParties)  		MergParties 			{xpath('PartiesInvolved')};		
  end;

	export MergersChild									:= record, 		maxlength(max_size)				
			string  Merger_EntityID; 
			MergersChildren;						
	end;
	
	export MergersLayoutIn							:= record, 		maxlength(max_size)
			string Merger_EntityID												{xpath('EntityID')};
			dataset (MergersChildren)  	Mergers 					{xpath('Merger')};			
  end;
	
	export MergersLayoutBase  					:= record
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			MergersLayoutIn;
	end;
				 
	export PreviousNameChildren					:= record, 		maxlength(max_size)
			string PreviousEntityName											{xpath('PreviousEntityName')};
			string DateOfChange1   												{xpath('DateOfChange')};
			string AmendmentNumber1   										{xpath('AmendmentNumber')};
	end;		 
		 
	export PreviousNameChild		 				:= record, 		maxlength(max_size)
			string  Prev_Name_EntityID; 
			PreviousNameChildren;						
		end;
	  
	export PreviousNamesLayoutIn			 	:= record, 		maxlength(max_size)
			string pre_entityid   												{xpath('EntityID')};
			string EntityCurrentName   										{xpath('EntityCurrentName')};
			dataset (PreviousNameChildren) 	PreviousNames	{xpath('PreviousEntityNames')};			
	end;
	
	export PreviousNamesLayoutBase  		:= record
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			PreviousNamesLayoutIn;
	end;
	
	export PreviousAppChildren					:= record, 		maxlength(max_size)
			string PreviousApplicantName									{xpath('PreviousApplicantName')};
			string previousApplicantAdd   								{xpath('PreviousApplicantAddress')};
			string DateofChange   										  	{xpath('DateofChange')};
	end;
	
	export PreviousAppChild			 				:= record,	  maxlength(max_size)
      string previousApp_EntityID; 
			PreviousAppChildren;						
  end;
  
	export AmendmentChildren 						:= record, 		maxlength(max_size)
			string DocumentType				  									{xpath('DocumentType')};
			string DateofAmendment   										  {xpath('DateofAmendment')};
			string AmendmentNumber   										  {xpath('AmendmentNumber')};
	end;

	export AmendmentChild			 					:= record, 		maxlength(max_size)
			string  Amend_EntityID; 
			AmendmentChildren;						
	end;

	export RegClassChildren 						:= record, 		maxlength(max_size)
			string Classification         						    {xpath('<>')};     				
	end;

	export RegClassChild				 				:= record, 		maxlength(max_size)
      string RegEntity_EntityID; 
			RegClassChildren;						
	end;

	export TradeServicesLayoutIn 				:= record, 		maxlength(max_size)
			string TradeServiceName			  								{xpath('TradeServiceName')};
			string BusinessDescription   						  		{xpath('BusinessDescription')};
			string ApplicantName  						 			  		{xpath('ApplicantName')};
			string FirstDateUsedinLouisiana   						{xpath('FirstDateUsedinLouisiana')};
			string FirstUsedDate						   			  		{xpath('FirstUsedDate')};
			string RegisteredDate			  									{xpath('RegisteredDate')};
			string DateofExpiration 					  		  		{xpath('DateofExpiration')};
			string Status 								  				  		{xpath('Status')};
			string Substatus      				            		{xpath('Substatus')};
			string trade_EntityID         				    		{xpath('EntityID')};
			string TradeNameType  				            		{xpath('TradeNameType')};
			string TradeMarkType          				    		{xpath('TradeMarkType')};
			string ServiceMarkType   					         		{xpath('ServiceMarkType')};
			string AddressLine1 						  			  		{xpath('AddressLine1')};
			string trade_City   			  									{xpath('City')};
			string State  								 					  		{xpath('State')};
			string PostalCode  				  									{xpath('PostalCode')};
			string trade_Country   									  		{xpath('Country')};
			string CorporateState   		  								{xpath('CorporateState')};
			dataset (PreviousAppChildren) 	PreviousApp		{xpath('PreviousApplicants/PreviousApplicantInformation')};   
      dataset (AmendmentChildren) 		Amendment  		{xpath('EntityFilings/Amendment')};    
      dataset (RegClassChildren) 			RegEntity 		{xpath('RegisteredEntityClasses')};    				
	end;

	export TradeServicesLayoutBase  		:= record
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			TradeServicesLayoutIn;
	end;
	
	export NameReservsLayoutIn 					:= record, 		maxlength(max_size)
			string NameReservationType										{xpath('NameReservationType')};
			string NameReserved														{xpath('NameReserved')};
			string DateReserved														{xpath('DateReserved')};
			string DateExpiration													{xpath('DateExpiration')};
			string FirstExtention												 	{xpath('FirstExtention')};
			string SecondExtention											 	{xpath('SecondExtention')};
			string IsActive													 			{xpath('IsActive')};
			string ContactPerson												 	{xpath('ContactPerson')};
			string ReservationNumber											{xpath('ReservationNumber')};
			string Address1																{xpath('Address1')};
			string Address2																{xpath('Address2')};
			string City																		{xpath('City')};
			string StateorProvince												{xpath('State')};
			string ZipCode																{xpath('ZipCode')};
			string Country																{xpath('CountryCode')};
	end;
	
	export NameReservsLayoutBase  			:= record
			string1			action_flag;
			unsigned4		dt_first_received;
			unsigned4		dt_last_received;		
			NameReservsLayoutIn;
	end;

	export Temp_Agents					 				:= record,		maxlength(max_size)
			string Agent_EntityID   											{xpath('EntityID')};
			AgentsChildren;
	end;
	
	export Temp_Corp			 							:= record, 		maxlength(max_size)
			string EntityID																{xpath('EntityID')};	
			string EntityName															{xpath('EntityName')};
			string CharterCategory												{xpath('CharterCategory')};
			string EntityStartDate								        {xpath('EntityStartDate')};
			string EntityStatus														{xpath('EntityStatus')};
			string InactiveReason													{xpath('InactiveReason')};
			string InactiveDate 								          {xpath('InactiveDate')};
			string InactiveActionDate 							      {xpath('InactiveActionDate')};
			string InactiveEffectiveDate 							    {xpath('InactiveEffectiveDate')};
			string GoodStdStatus													{xpath('GoodStandStatus')};
			CorpsEntitiesChildren;
	end;
	
	export Temp_Filings			 						:= record, 		maxlength(max_size)
			string Filing_EntityID;
			string FilingDate															{xpath('FilingDate')};
			string FilingType															{xpath('FilingType')};
			string FilingID																{xpath('FilingID')};
	end;
	
	export Temp_CorpFilings			 				:= record, 		maxlength(max_size)
			Temp_Corp;
			Temp_Filings;
	end;
	
	export Temp_MergerEntity		 				:= record, 		maxlength(max_size)
	   	string Merger_EntityID;
			string MergerDate;				
   		string Role;	
	end;
	 
	export Temp_Merger									:= record, 		maxlength(max_size)
			Temp_MergerEntity;
			string merger_EntityName           						{xpath('EntityName')}; 
	end;

	export Temp_CorpAgents			 				:= record, 		maxlength(max_size)
			string EntityID;
			string EntityName;
			string CharterCategory;
			string EntityStartDate;
			string EntityStatus;
			string InactiveReason;
			string InactiveDate;
			string InactiveActionDate;
			string InactiveEffectiveDate;
			string GoodStdStatus;	
			string AddressType;
			string Address1;
			string Address2;
			string City;
			string StateorProvince;
			string ZipCode;
			string Country;
			string Parish;
			string FirstName;
			string LastName;
			string Agent_Address1;
			string Agent_Address2;
			string Agent_City;
			string Agent_State;
			string PostalCode;
			string Titles;
			string EmailAddress;
			string DateAppointed;
	end;
	
	export Temp_CorpMergers		 					:= record, 		maxlength(max_size)
			Temp_Corp;
			Temp_Merger;
	end;
	
	export Temp_PreviousName		 				:= record, 		maxlength(max_size)
			string Pre_EntityID;
			string EntityCurrentName;
			PreviousNameChildren;
  end;
	
	export Temp_Trade						 				:= record, 		maxlength(max_size)
			string TradeServiceName			  								{xpath('TradeServiceName')};
			string BusinessDescription   	  							{xpath('BusinessDescription')};
			string ApplicantName   			 									{xpath('ApplicantName')};
			string FirstDateUsedinLouisiana   						{xpath('FirstDateUsedinLouisiana')};
			string FirstUsedDate   			 								  {xpath('FirstUsedDate')};
			string RegisteredDate			  									{xpath('RegisteredDate')};
			string DateofExpiration   		  							{xpath('DateofExpiration')};
			string Status   				  										{xpath('Status')};
			string Substatus                  						{xpath('Substatus')};
			string trade_EntityID             						{xpath('EntityID')};
			string TradeNameType            						  {xpath('TradeNameType')};
			string TradeMarkType            						  {xpath('TradeMarkType')};
			string ServiceMarkType 							          {xpath('ServiceMarkType')};
			string AddressLine1   											  {xpath('AddressLine1')};
			string trade_City										   			  {xpath('City')};
			string State   															  {xpath('State')};
			string PostalCode  													  {xpath('PostalCode')};
			string trade_Country   											  {xpath('Country')};
			string CorporateState  									 		  {xpath('CorporateState')};
			string DocumentType													  {xpath('DocumentType')};
			string DateofAmendment								  		  {xpath('DateofAmendment')};
			string AmendmentNumber 								  		  {xpath('AmendmentNumber')};
	end; 
	
	export Temp_TradePrevApp			 			:= record, 		maxlength(max_size)
			Temp_Trade;
			string PreviousApplicantName	 							  {xpath('PreviousApplicantName')};
   		string PreviousApplicantAdd   	 							{xpath('PreviousApplicantAddress')};
   		string DateofChange   		      							{xpath('DateofChange')};
	end;

	export Temp_TradePrevAppClass			 	:= record, 		maxlength(max_size)
			Temp_TradePrevApp;
			string Classification;
	end;
	
	export Temp_TradePrevAppAddress			:= record	
			Temp_TradePrevAppClass;
			string PrevApp_addr;
			string PrevApp_city;
			string PrevApp_st;
			string PrevApp_zip;
	end;

	export Temp_TradePreviousName			 	:= record, 		maxlength(max_size)
			Temp_PreviousName ;
			Temp_TradePrevAppAddress;
  end;
	
	export Temp_CorpFilingsTrade	 			:= record, 		maxlength(max_size)
			Temp_CorpFilings;
			Temp_TradePrevAppClass;
	end;
	
	export NameReservs_TempLay					:= record, 		maxlength(max_size)
			NameReservsLayoutIn;
			CorpsEntitiesLayoutIn.chartercategory;
			CorpsEntitiesLayoutIn.entitystartdate;
	end;
	
	export PreviousNames_TempLay				:= record, 		maxlength(max_size)
			Temp_PreviousName;
			CorpsEntitiesLayoutIn.chartercategory;
			CorpsEntitiesLayoutIn.entitystartdate;
	end;
	
	export TradePrevAppAddress_TempLay	:= record, 		maxlength(max_size)
		Temp_TradePrevAppAddress;
		CorpsEntitiesLayoutIn.chartercategory;
		CorpsEntitiesLayoutIn.entitystartdate;
	end;
		
end;