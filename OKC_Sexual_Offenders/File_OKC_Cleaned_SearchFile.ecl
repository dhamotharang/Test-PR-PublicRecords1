import SexOffender;

Layout_Searchfile := record
	SexOffender.Layout_Accurint_SearchFile;
	string2 newline := '<cr><lf>';
end;

export File_OKC_Cleaned_SearchFile := dataset(OKC_Sexual_Offenders.Cluster + 'base::OKC_Sex_Offender_Search_File',Layout_Searchfile,thor);
