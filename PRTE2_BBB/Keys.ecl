import doxie, BIPV2;
export Keys := module

	EXPORT Key_BBB_Member_BDID 		 := INDEX(Files.Key_BBB_BDID,{bdid},					 {Files.Key_BBB_BDID},					 Constants.Key_BBB_Member_BDID_Name);
	EXPORT Key_BBB_Non_Member_BDID := INDEX(Files.Key_BBB_Non_Member_BDID,{bdid},{Files.Key_BBB_Non_Member_BDID},Constants.Key_BBB_Non_Member_BDID_Name);
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Key_BBB_LinkIds, Key_BBB_Member_LinkIds_Export, Constants.Key_BBB_Member_LinkIds_Gen_Name)
	EXPORT Key_BBB_Member_LinkIds := Key_BBB_Member_LinkIds_Export;
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.Key_BBB_Non_Member_LinkIds, Key_BBB_Non_Member_LinkIds_Export, Constants.Key_BBB_Non_Member_LinkIds_Gen_Name)
	EXPORT Key_BBB_Non_Member_LinkIds := Key_BBB_Non_Member_LinkIds_Export;
	
end;