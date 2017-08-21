EXPORT Layouts := module

	export CorporationsLayoutIn := Record

			String		EntityName;
			String		FileNumber;
			String		EntityType;
			String		RegistrationDate;
			String		EntityStatus;
			String		BusinessAddress;
			String		StateOfFormation;
			String		RegisteredAgent;
			String		CountryofFormation;
			
	End;

	export CorporationsLayoutBase := Record

			string1		action_flag;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
			CorporationsLayoutIn;
			
	End;
	
end;
