Layout_clean_ContactNames := record

string100 clean_company_name;

string100 clean_address_split;

string73 clean_cleaned_name;

string73 clean_cleaned_name_2;

recordof(Fictitious_Business_Names.File_Out_AllFlat_Rollup);

end;


export File_Clean_ContactNames := dataset('~thor_data400::out::macro_clean_contactnames',Layout_clean_ContactNames,flat);
