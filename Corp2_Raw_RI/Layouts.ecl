EXPORT Layouts := module

	export EntitiesIN := record

		string Entity_ID; 
		string EntityName;
		string ElectedName;
		string DateOfOrganization;
		string Chapter;
		string Charter;
		string Status;
		string EffectDate;
		string Purpose;
		string Duration; 
		string StateOfIncorp;
		string CountryOfIncorp;
		string LastAnnualRptYear;
		string BeManagedBy;
		string BusinessAddr1;
		string BusinessAddr2;
		string BusinessCity;
		string BusinessState;
		string BusinessCountry;
		string BusinessZip;
		string MailingAddr1;
		string MailingAddr2;
		string MailingCity;
		string MailingState;
		string MailingCountry;
		string MailingZip;
		string IsAddressedMaintained;
		string IsAgentResigned;
		string AgentName;
		string AgentAddr1;
		string AgentAddr2;
		string AgentCity;
		string AgentState;
		string AgentZip;
		string NaicsCode; //This field has been added to the layout starting from 20181105 vendor data
			
	end;

	export EntitiesBase := record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		EntitiesIn;

	end;

	export InActEntitiesIN := record

		string Entity_ID; 
		string EntityName;
		string ElectedName;
		string DateOfOrganization;
		string Chapter;
		string Charter;
		string Status;
		string EffectDate;
		string Purpose;
		string Duration; 
		string StateOfIncorp;
		//string CountryOfIncorp;   As per CI Inactive layout doesn't have this field 
		string LastAnnualRptYear;
		string BeManagedBy;
		string BusinessAddr1;
		string BusinessAddr2;
		string BusinessCity;
		string BusinessState;
		string BusinessCountry;
		string BusinessZip;
		string MailingAddr1;
		string MailingAddr2;
		string MailingCity;
		string MailingState;
		string MailingCountry;
		string MailingZip;
		string IsAddressedMaintained;
		string IsAgentResigned;
		string AgentName;
		string AgentAddr1;
		string AgentAddr2;
		string AgentCity;
		string AgentState;
		string AgentZip;		
		string NaicsCode; // This field has been added to the layout starting from 20181105 vendor data
			
	end;
	
	export InActEntitiesBase := record
	
		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		InActEntitiesIn;

	end;

	export amendmentsIn := record

		string Entity_ID;
		string EffectiveDate;
		string FilingCode;
		string FilingName;
		string Comments;

	end;

	export amendmentsBase := record

		STRING1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		amendmentsIn;

	end;

	export NamesIn := record

		string Entity_ID;
		string Name;
		string Name_Type;
		string File_Dt;
		string Abandoned_Dt;
		string EntityTypeDescriptor;

	end;

	export NamesBase := record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		NamesIn;

	end;

	export MergersIn := record

		string MergerDate;
		string MergerType;
		string MergedEntityName;
		string MergedEntity_ID;
		string SurvivingEntity_ID;
		
	end;

	export MergersBase := record

		string1		 action_flag;
		UNSIGNED4	 dt_first_received;
		UNSIGNED4	 dt_last_received;			
		MergersIn;

	end;

	export OfficersIn := record

		String   Entity_ID;
		String   IndividualTitle;
		String   FirstName;
		String   LastName;
		String   MiddleName;
		String   Suffix;
		String   BusAddr1;
		String   TermExpiration;
		String   BusCity;
		String   BusState;
		String   BusCountryCode;
		String   BusPostalCode;
		String   ResAddr1;
		String   ResCity;
		String   ResState;
		String   ResCountryCode;
		String   ResPostalCode;
		String   LNameSoundex;
		String   FNameSoundex;
		String   MNameSoundex;
		String   ShareholderName;

	end;

	export OfficersBase := record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received; 
		OfficersIn;

	end;

	export StocksIn := record

		string Entity_ID;
		string StockClass;
		string AuthorizedNumber;
		string ParValuePerShare;
		string RestrictionIndicator;
		string TotalIssuedOutstanding;
		string Series;

	end;

	export StocksBase := record

		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received; 
		StocksIn;

	end;

	export Temp_Officer_Entities := record

		OfficersIN;
		EntitiesIN.EntityName;
		
	end;

	export Temp_Name_Entities := record

		NamesIN;
		EntitiesIN.EntityName;
		
	end;

	export Temp_Entity_Merger:= record

		EntitiesIN;
		MergersIN ;

	end;

	export Temp_InActEntity_Merger:=record 

		Temp_Entity_Merger;
		string ActiveEntity_Name;

	end;
	
	export NamesIn_TempLay := record
		NamesIn;
		EntitiesIn.StateofIncorp;
		EntitiesIn.Charter;
		EntitiesIn.DateofOrganization;
	end;
	
end;