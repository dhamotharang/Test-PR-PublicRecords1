export Layout_in_ProviderSpeciality := Module

export raw := record
string ProviderID;
string SpecialityID;
string ProviderSpecialityCompanyCount;
string ProviderSpecialityTierTypeID;
string VerificationStatusCode;
string VerificationDate;
end;


export raw_srctype := 
{
  string  FILETYP;
	string	ProcessDate;

			string	ProviderID;
			string	SpecialityID;
			string	SpecialtyCompanyCount;
			string	SpecialtyTierTypeID;
};

end;