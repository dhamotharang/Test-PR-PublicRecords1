export Layout_in_ProviderGender := Module

export raw := record
  string ProviderID;
  string Gender;
  string ProviderGenderCompanyCount;
  string ProviderGenderTierTypeID;
  string VerificationStatusCode; /* Enter your record definition here*/
  string VerificationDate;
end;



export raw_srctype :=


{
  string  FILETYP;
	string	ProcessDate;
	string	ProviderID;
	string	Gender;
	string	GenderCompanyCount;
	string	GenderTierTypeID;
};

end;