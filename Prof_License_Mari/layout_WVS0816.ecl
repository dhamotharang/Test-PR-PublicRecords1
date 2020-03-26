// WVS0816 / West Virginia Real Estate Appr Lic & Cert Board / Real Estate Appraisers //
EXPORT layout_WVS0816 := MODULE

	EXPORT LAYOUT_RAW := RECORD
		STRING30	 COUNTY; 				//New 20130415
   	//string2    LIC_STATE;		//Removed 20130415
   	//string10   LAST_UPDT;		//Removed 20130425
   	STRING100  NAME;
   	STRING100  ADDRESS;
   	STRING30   CITY;
   	STRING2    ST;
   	STRING10   ZIP;
   	STRING30   PHONE;
   	STRING30   LIC_TYPE;
   	STRING30   LIC_NO;
	END;

END;
