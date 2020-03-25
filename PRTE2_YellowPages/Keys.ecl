IMPORT doxie, BIPV2;
EXPORT Keys := module

	EXPORT Key_YellowPages_Bdid := INDEX(Files.File_Keybuild(bdid != 0),{bdid},{Files.File_Keybuild},Constants.Key_Bdid_Name);
	EXPORT Key_YellowPages_Phone := INDEX(Files.File_Keybuild(phone10 != ''),{phone10},{business_name, prim_range, prim_name, sec_range, zip, geo_lat, geo_long},Constants.Key_Phone_Name);	
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.File_Base_v2_Bip, Key_YellowPages_LinkIds_Export, Constants.Key_Linkids_Name)
	EXPORT Key_YellowPages_Linkids := Key_YellowPages_LinkIds_Export;

END;