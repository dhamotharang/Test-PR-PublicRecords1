import Business_Header;
bh := Business_Header.File_Business_Header;

layout_sbh := RECORD
	bh.bdid;
	bh.city;
	bh.zip;
	bh.fein;
	bh.phone;
	UNSIGNED8 __filepos {virtual(fileposition)};
END;

export File_BH_BDID_City_Plus := DATASET(
	'~thor_data400::BASE::bh_bdid.city.zip.fein.phone_built',
	layout_sbh,
	thor);