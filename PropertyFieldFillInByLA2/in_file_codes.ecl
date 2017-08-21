import ut, PropertyFieldFillInByLA2;

EXPORT in_file_codes := dataset('~thor_data400::in::propertyfieldfillinbyla2::localizedavgconversion',PropertyFieldFillInByLA2.layouts.codes, csv(heading(1),separator('\t'),quote('"')));

																									