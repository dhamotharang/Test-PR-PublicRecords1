export Layout_In_ProviderAddressDEANumber  := Module

export raw := record
string ProviderID;
string AddressID;
string DEANumber;
string ProviderDEACompanyCount;
string ProviderDEATierTypeID;
string VerificationStatusCode;
string VerificationDate;
end;

export raw_srctype := 

{
  string  FILETYP;
	string	ProcessDate;

	string	ProviderID;
	string	AddressID;
	string	DEANumber;
	string	DEANumberCompanyCount;
	string	DEANumberTierTypeID;
};

end;