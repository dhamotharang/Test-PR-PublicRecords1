
export mac_source_declare := MACRO

string14 bdid := if(input[1].idtype = 'BDID' or input[1].idtype = 'bdid', input[1].id, '');
#stored('BDID', bdid);

//Assume one row for now.
sect := input[1].section;

bsect(string sect_name, string sect_in) := stringlib.stringtouppercase(sect_name) = stringlib.stringtouppercase(sect_in);

bsect_val := if (sect = '' OR stringlib.stringtouppercase(sect) = stringlib.stringtouppercase('all_sources'), false, true);
#stored('SelectIndividually', bsect_val);

#stored('IncludeNameVariations', bsect('Name_Variations',sect));
#stored('IncludeAddressVariations', bsect('Address_Variations',sect));	
#stored('IncludeBankruptcies', bsect('Bankruptcies',sect));
#stored('IncludeProperties', bsect('Properties',sect)); 
#stored('IncludeLiensJudgments', bsect('liens_judgements_uccs',sect)); 
#stored('IncludeBusinessRegistrations', bsect('registered_agents',sect)); 
#stored('IncludeAssociatedPeople', bsect('contacts',sect));
#stored('IncludeProfessionalLicenses', bsect('professional_licenses',sect));
#stored('IncludeCompanyIDnumbers', bsect('id_numbers',sect));
#stored('IncludeCompanyProfile', bsect('profiles',sect));
#stored('IncludeInternetDomains', bsect('internet_domains',sect));
#stored('IncludePhoneVariations', bsect('Phone_Variations',sect));
#stored('IncludeDCA', bsect('parent_company',sect));

/*
#stored('MaxBusinessesAtAddress');
#stored('MaxProfessionalLicenses');
#stored('MaxAssociatedBusinesses');
#stored('MaxAssociatedPeople');
#stored('MaxNameVariations');
#stored('MaxCorporationFilings');
#stored('MaxUCCFilings');
#stored('MaxLiens');
#stored('MaxJudgments');
#stored('MaxInternetDomains');
#stored('MaxBankruptcies');
#stored('MaxBusinessRegistrations');
#stored('MaxProperties');
#stored('MaxReverseLookup');
#stored('MaxExecutives');
#stored('MaxDCA');
*/
ENDMACRO;
