export Layout_in_ProviderAddressTaxID := Module

export raw := record
  string ProviderID; /* Enter your record definition here*/
  string AddressID;
  string TaxID;
  string CompanyCount;
  string TierTypeID;
  string VerificationStatusCode;
  string VerificationDate;
end;


export raw_srctype := 
{
  string  FILETYP;
	string	ProcessDate;

string	ProviderID;
string	AddressID;
string	TaxID;
string	TaxIDCompanyCount;
string	TaxIDTierTypeID;
};

end;
