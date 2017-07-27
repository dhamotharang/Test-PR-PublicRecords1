sbh := business_header_ss.File_BH_BDID_City_Plus;

layout_sbh_index := RECORD
	sbh.bdid;
	sbh.city;
	sbh.zip;
	sbh.fein;
	sbh.phone;
	sbh.__filepos;
END;
	
EXPORT Key_BH_BDID_City_Zip_Fein_Phone := INDEX(
	sbh,
	layout_sbh_index,
	'~thor_data400::key::business_header_bdid.city.zip.fein.phone_' + business_header_ss.key_version, OPT);