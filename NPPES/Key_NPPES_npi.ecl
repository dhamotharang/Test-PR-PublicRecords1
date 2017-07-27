import doxie;

// base := NPPES.File_NPPES_Base;				   

base := nppes.File_SearchAutoKey;

export Key_NPPES_npi := index(base,
							  {npi},
							  {base},
							  '~thor_data400::key::NPPES::'+doxie.Version_SuperKey+'::npi');