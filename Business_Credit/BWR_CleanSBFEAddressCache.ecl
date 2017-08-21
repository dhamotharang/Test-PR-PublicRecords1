//***************************************************************************************
// Use this code to consolidate the SBFE Address Cache into a single logical file
//***************************************************************************************

dSBFEAddressCache				:=	Business_Credit.Files().SBFEAddressCache;
dSBFEAddressCacheClean	:=	DEDUP(SORT(DISTRIBUTE(dSBFEAddressCache,
															HASH(	address_line_1,address_line_2,city,state,zip_code_or_ca_postal_code,postal_code,country_code)),
																		address_line_1,address_line_2,city,state,zip_code_or_ca_postal_code,postal_code,country_code,LOCAL),
																		address_line_1,address_line_2,city,state,zip_code_or_ca_postal_code,postal_code,country_code,LOCAL);

basefilename		:=	Business_Credit.Filenames().AddressCache;
logicalfilename	:=	basefilename+'::'+workunit;

SEQUENTIAL(
	OUTPUT(dSBFEAddressCacheClean,,logicalfilename,OVERWRITE,__compressed__),
	FileServices.StartSuperFileTransaction(),
	FileServices.ClearSuperFile(basefilename),
	FileServices.AddSuperFile(basefilename,logicalfilename),
	FileServices.FinishSuperFileTransaction()
);
