export Layout_in_ProviderBirthDate := Module

export raw := record
  string ProviderID; /* Enter your record definition here*/
  string BirthDate;
  string ProviderDOBCompanyCount;
  string ProviderDOBTierTypeID;
  string VerificationStatusCode;
  string VerificationDate;
end;

export raw_srctype := 
{
  string  FILETYP;
	string	ProcessDate;

string	ProviderID;
string	BirthDate;
string	BirthDateCompanyCount;
string	BirthDateTierTypeID;
};

end;