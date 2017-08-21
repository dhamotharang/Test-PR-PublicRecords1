export Layout_in_ProviderUPIN := Module

export raw := record

string ProviderID;
string UPIN;
string ProviderUPINCompanyCount;
string ProviderUPINTierTypeID;
string VerificationStatusCode;
string VerificationDate;
end;



export raw_srctype := 

{
  string  FILETYP;
	string	ProcessDate;

string	ProviderID;
string	UPIN;
string	UPINCompanyCount;
string	UPINTierTypeID;
};
end;