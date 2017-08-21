export Layout_in_ProviderLanguage := Module

export raw := record
string ProviderID;
string Language;
string ProviderLanguageCompanyCount;
string ProviderLanguageTierTypeID;
string VerificationStatusCode;
string VerificationDate;
end;


export raw_srctype := 
{
  string  FILETYP;
	string	ProcessDate;

			string	ProviderID;
			string	Language;
			string	LanguageCompanyCount;
			string	LanguageTierTypeID;
};
end;