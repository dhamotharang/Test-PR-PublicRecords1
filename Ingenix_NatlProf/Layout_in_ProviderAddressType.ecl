export Layout_in_ProviderAddressType := Module

export raw := record
  string ProviderID;
  string AddressID;
  string AddressTypeCode;
  string AddressTypeCompanyCount;
  string AddressTypeTierTypeID;
  string VerificationStatusCode;
  string VerificationDate;
end;


export raw_srctype := 
{
  string  FILETYP;
	string	ProcessDate;
	string	ProviderID;
	string	AddressID;
	string	ProviderAddressTypeCode;
	string	AddressTypeCompanyCount;
	string	AddressTypeTierTypeID;
};

end;