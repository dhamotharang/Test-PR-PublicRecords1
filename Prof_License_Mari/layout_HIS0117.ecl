// HIS0117 // Hawaii Department of Commerce and Consumer Affairs / Multiple Professions// 

export layout_HIS0117 :=MODULE

export license	:= RECORD
	string10    BOARD_CODE;
	string100   SORTNAME;
	string10    LIC_TYPE;
	string10    LIC_NUM;
	string10    LIC_OFFICE;
	string10    RECORD_TYPE;
	string10    BOARD_NAME;
	string150   LIC_SORTNAME;
	string20    EFFECTIVE_DATE;
	string20    EXPIRATION_DATE;
	string10    LIC_STATUS;
	string1     ACT_INACT_INDICATOR;
	string3     EMPLOY_POSITION_CODE;
	string5     EMPLOY_STATUS;
	string5     EMPLOY_LIC_TYPE;
	string10    EMPLOY_LIC_NUMR;
	string3     EMPLOY_LIC_OFFICE;
	string100   EMPLOY_FULL_NAME;
	string1     SPECIAL_PRIVILEGE_INDICATOR;
	string1     LICE_RESTRIC_INDICATOR;
	string1     CONDIT_LIC_INDICATOR;
	string50    BUS_ADDRESS1;
	string50    BUS_ADDRESS2;
	string25    BUS_CITY;
	string2     BUS_STATE;
	string5     BUS_ZIPCODE;
	string1     BUS_ADDRESS_RESTRIC_CODE;
	string30    PUB_ADDRESS1;
	string30    PUB_ADDRESS2;
	string25    PUB_CITY;
	string2     PUB_STATE;
	string5     PUB_ZIPCODE;
	string1     CLASS_PREFIX;
END;

export legal_sortname	:= RECORD
	string10    BOARD_CODE;
	string100		DBA;
	string30    LIC_TYPE;
	string30    LIC_NUM;
	string30    LIC_OFFICE;
	string50    RECORD_TYPE;
	string30    BOARD_NAME;
	string100   ORG_NAME;
END;
	        
END;