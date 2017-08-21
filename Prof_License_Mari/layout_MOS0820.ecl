// MOS0820 / Missouri Division of Professional Registration / Multiple Professions //

export layout_MOS0820 := MODULE

export Appraiser := RECORD
	string30   PRC_FIRST_NAME;
	string30   PRC_MIDDLE_NAME;
	string100  PRC_LAST_NAME;
	string10   PRC_SUFFIX;
	string50   BA_ADDRESS1;
	string50   BA_ADDRESS2;
	string30   BA_CITY;
	string2    BA_STATE;	
	string10   BA_ZIP;
	string30   BA_CNTY;
	string30   BA_CNTRY;
	string30   LIC_PROFESSION;
	string30   LIC_NUMBER;
	string30   STATUS;
	string30   EXPIRATION_STATUS;
	string100  PRC_DBA_NAME;
	string30   LIC_ORIG_ISSUE_DATE;
	string30   CLASS_DESC;
	string30   LIC_EXP_DATE;
	string30   CERT_TYPE;
	string30   CERT_LEVEL;
	string100  PRC_ENTITY_NAME;
END;

export RealEstate	:= RECORD
	string30   PRC_FIRST_NAME;
	string30   PRC_MIDDLE_NAME;
	string100  PRC_LAST_NAME;
	string10   PRC_SUFFIX;
	string100  PRC_ENTITY_NAME;
	string50   BA_ADDRESS1;
	string50   BA_ADDRESS2;
	string30   BA_CITY;
	string2    BA_STATE;	
	string10   BA_ZIP;
	string30   BA_CNTY;
	string30   BA_CNTRY;
	string30   LIC_PROFESSION;
	string30   LIC_NUMBER;
	string30   STATUS;
	string30   EXPIRATION_STATUS;
	string100  PRC_DBA_NAME;
	string30   LIC_ORIG_ISSUE_DATE;
	string30   CLASS_DESC;
	string30   LIC_EXP_DATE;
	string30   CERT_TYPE;
	string30   CERT_LEVEL;
	string35	 REL_TYPE;	
	string20   REL_FIRST_NAME;	
	string20   REL_MIDDLE_NAME;
	string35   REL_LAST_NAME;	
  string10   REL_SUFFIX;
  string85   REL_ENTITY_NAME;
  string11   REL_LIC_NUMBER;	
  string35   REL_ADDRESS1;
  string35   REL_ADDRESS2;
  string25   REL_CITY;
  string2	   REL_STATE;
  string9	   REL_ZIP;
END;

END;