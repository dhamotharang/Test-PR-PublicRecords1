Import Data_Services, business_header, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
sbh := PRTE2_Business_Header.Files().Base.Bdid.keybuild;
#ELSE
sbh := business_header.Files().Base.Bdid.keybuild;
#END;


layout_sbh_index := RECORD
	sbh.bdid;
	sbh.city;
	sbh.zip;
	sbh.fein;
	sbh.phone;
	sbh.__filepos;
END;
	
EXPORT Key_Prep_BH_BDID_City_Zip_Fein_Phone := INDEX(
	sbh,
	layout_sbh_index,
	'~thor_data400::key::business_header_bdid.city.zip.fein.phone' + thorlib.wuid());