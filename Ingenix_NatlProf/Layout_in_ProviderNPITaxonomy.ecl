export Layout_in_ProviderNPITaxonomy := Module 

export raw := record
  string ProviderID; /* Enter your record definition here*/
  string NPI;
  string TaxonomyCode;
  string PrimaryIndicator;
end;


export raw_srctype := 

{
  string  FILETYP;
	string	ProcessDate;
	string	ProviderID;
	string	NPI;
	string	TaxonomyCode;
	string	PrimaryIndicator;
};

end;