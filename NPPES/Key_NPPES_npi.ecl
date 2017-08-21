Import Data_Services, doxie;

// base := NPPES.File_NPPES_Base;				   

base := nppes.File_SearchAutoKey((integer)npi >0);

export Key_NPPES_npi := index(base,
							  {npi},
							  {base},
							  Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::NPPES::'+doxie.Version_SuperKey+'::npi');