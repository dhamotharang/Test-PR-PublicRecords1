export Layout_in_ProviderAddressPhone := Module

export raw := record
string ProviderID;
string AddressID;
string PhoneNumber;
string PhoneType;
string ProviderPhoneCompanyCount;
string ProviderPhoneTierTypeID;
string VerificationStatusCode;
string VerificationDate;
end;


export raw_srctype := 

{
  string  FILETYP;
	string	ProcessDate;

		string	ProviderID;
		string	AddressID;
		string	PhoneNumber;
		string	PhoneType;
		string	PhoneNumberCompanyCount;
		string	PhoneNumberTierTypeID;
};

end;