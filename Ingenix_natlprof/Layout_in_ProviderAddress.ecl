export Layout_in_ProviderAddress := Module

 export raw := record
  string ProviderID; /* Enter your record definition here*/
  string AddressID;
  string Address;
  string Address2;
  string City;
  string State;
  string County;
  string ZIP;
  string ExtZip;
  string Latitude;
  string Longitute;
  string GeoReturn;
  string HighRisk;
  string ProviderAddressCompanyCount;
  string ProviderAddressTierTypeID;
  string VerificationStatusCode;
  string VerificationDate;
end;


export raw_srctype := record

string  FILETYP;
string	ProcessDate;
string	ProviderID;
string	AddressID;
string	Address;
string	Address2;
string	City;
string	State;
string	County;
string	ZIP;
string	ExtZip;
string	Latitude;
string	Longitute;
string	GeoReturn;
string	HighRisk;
string	ProviderAddressCompanyCount;
string	ProviderAddressTierTypeID;
string  ProviderAddressVerificationStatusCode;
string  ProviderAddressVerificationDate;
end;

end;