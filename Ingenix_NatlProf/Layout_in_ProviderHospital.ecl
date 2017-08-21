export Layout_in_ProviderHospital := Module

export raw := record
  string ProviderID; /* Enter your record definition here*/
  string AddressID;
  string HospitalID;
  string ProviderHospitalCompanyCount;
  string ProviderHospitalTierTypeID;
  string VerificationStatusCode;
  string VerificationDate;
end;

export raw_srctype := 

{ 
	string  FILETYP;
	string	ProcessDate;
	string	ProviderID;
	string	AddressID;
	string	HospitalID;
	string	HospitalNameCompanyCount;
	string	HospitalNameTierTypeID;
	string	HospitalName;
};

end;