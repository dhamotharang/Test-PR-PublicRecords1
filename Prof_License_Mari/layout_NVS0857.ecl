// NVSO857 / Nevada Real Estate Division / Real Estate Appraisers //

EXPORT layout_NVS0857 := RECORD
	string30   SLNUM;
	string30   EXPDT;
	string100  ORG_NAME;
	string100  OFFICENAME;
	string100  ADDRESS1_1;
	string30   CITY_1;
	string2    STATE_1;
	string10   ZIP;
	string30   COUNTY;
END;

/*EXPORT layout_NVS0857 := RECORD    //Use with 20130103 - 20130415
   	string100  ORG_NAME;
   	string30   SLNUM;
   	string100  OFFICENAME;
   	string100  ADDRESS1_1;
   	string30   CITY_1;
   	string2    STATE_1;
   	string10   ZIP;
   	string30   COUNTY;
   	string30   EXPDT;
END;*/