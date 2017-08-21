import SexOffender;

Layout_Mainfile := record
	SexOffender.Layout_Accurint_Mainfile;
	string2 newline := '<cr><lf>';
end;

export File_OKC_Cleaned_Accurint_In := dataset(OKC_Sexual_Offenders.Cluster + 'base::OKC_Sex_Offender_File_Accurint_In',Layout_Mainfile,thor);