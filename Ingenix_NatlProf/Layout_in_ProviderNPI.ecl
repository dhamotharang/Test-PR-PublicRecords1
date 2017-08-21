export Layout_in_ProviderNPI := Module

export raw := record
  string ProviderID; /* Enter your record definition here*/
  string NPI;
  string EnumerationDate;
  string ProviderNPICompanyCount;
  string ProviderNPITierTypeID;
  string VerificationStatus;
  string VerificationDate;
end;




export raw_srctype :=

{
  string  FILETYP;
	string	ProcessDate;
	string	ProviderID;
	string	NPI;
	string	EnumerationDate;
	string	NPICompanyCount;
	string	NPITierTypeID;
};

end;