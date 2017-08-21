export Layout_in_ProviderGroup := Module

export raw := record
  string ProviderID; /* Enter your record definition here*/
  string AddressID;
  string GroupID;
  string ProviderGroupCompanyCount;
  string ProviderGroupTierTypeID;
  string VerificationStatusCode;
  string VerificationDate;
end;




export raw_srctype := 

{
  string  FILETYP;
	string	ProcessDate;
	string	ProviderID;
	string	AddressID;
	string	GroupPracticeID;
	string	GroupNameCompanyCount;
	string	GroupNameTierTypeID;
	string	GroupName;
};

end;