EXPORT Layouts := module

  export FilingLayoutIn := record
			string   Control_No;
			string   Filing_Type;
			string   Business_Type;
			string   Duration_Type;
			string   Status;
			string   Standing_AR;
			string   Standing_RA;
			string   Standing_Other;
			string   Filing_Name;
			// string   Domestic_YN;  // mapping instructions say this field is present, but input does not have it
			string   Filing_Date;
			string   Delayed_Effective_Date;
			string   Expiration_Date;
			string   Inactive_Date;
			string   Formation_Locale;
			string   Form_Home_Juris_Date;
			string   Common_Shares;
			string   Principle_Addr1;
			string   Principle_Addr2;
			string   Principle_Addr3;
			string   Principle_City;
			string   Principle_State;
			string   Principle_Postal_Code;
			string   Principle_Country;
			string   Mail_Addr1;
			string   Mail_Addr2;
			string   Mail_Addr3;
			string   Mail_City;
			string   Mail_State;
			string   Mail_Postal_Code;
			string   Mail_Country;
			string   AR_Exempt_YN;
			string   Managed_By_Type;
			string   Member_Count;
			string   Public_Benefit_YN;
			// string   Religious_Benefit_YN;  // mapping instructions say this field is present, but input does not have it
			string   AR_Due_Date;
			string   Fiscal_Year_Close_Month;
	end;

	export PartyLayoutIn := record
			string   Control_No;
			string   Party_Id;
			string   Party_Type;
			string   Source_Id;
			string   Source_Type;
			string   Org_Name;
			string   First_Name;
			string   Middle_Name;
			string   Last_Name;
			string   Individiual_Title;
			string   Addr1;
			string   Addr2;
			string   Addr3;
			string   City;
			string   County;
			string   State;
			string   Postal_Code;
			string   Country;
  end;

	export FilingNameLayoutIn := record
			string   Filing_Name_Id;
			string   Control_No;
			string   Name_Type;
			string   Name;
  end;
	
	export Temp_Filing_Party := record
			FilingLayoutIn;
			PartyLayoutIn  - [control_no];
	end;
	
	export Temp_FilingNames	:= record
			FilingNameLayoutIn;
			FilingLayoutIn.Filing_Name;
			FilingLayoutIn.Filing_Type;
			FilingLayoutIn.filing_date;
	end;
	
end;