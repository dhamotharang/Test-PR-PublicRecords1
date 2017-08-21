import OKC_Sexual_Offenders;

my_so := OKC_Sexual_Offenders.File_OKC_Cleaned_SearchFile(
	Orig_state in ['NC','VA','DC','MD'] or st in ['NC','VA','DC','MD']);

export cville_so_extract :=  my_so : persist('persist::cville_so_extract');

