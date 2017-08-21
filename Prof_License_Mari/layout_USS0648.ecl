// USS0648 / National Credit Union Administration / Other Lenders //
export layout_USS0648 := MODULE
	export r_FOICU := RECORD
			string9    CU_NUMBER,
			string17   CYCLE_DATE,
			string11   JOIN_NUMBER,
			string7		 RSSD,							//Research Statistics Supervision Discount. New since 20140205
			string7    CU_TYPE,
			string150  CU_NAME,
			string25   CITY,
			string5    STATE,
			string50	 CHARTER_STATE, 		//New field. It is the full name of the State. 3/20/13
			string10   STATE_CODE,
			string15   ZIP_CODE,
			string11   COUNTY_CODE,
			string9    CONG_DIST,
			string4    SMSA,
			string35   ATTENTION_OF,
			string100  STREET,
			string6    REGION,
			string2    SE,
			string8    DISTRICT,
			string11   YEAR_OPENED,
			string8    TOM_CODE,
			string11   LIMITED_INC,
			string17   ISSUE_DATE,
			string10   PEER_GROUP,
			string12   QUARTER_FL,
	END;

	export r_CRED_UNION := RECORD
			string9    CU_NUMBER,
			string17   CYCLE_DATE,
			string11   JOIN_NUMBER,
			string7    SITE_ID,
			string150  CU_NAME,
			STRING200	 SITE_NAME;							//New 3/20/13
			string		 SITE_TYPE_NAME,
			string		 MAIN_OFFICE,
			string		 BUS_ADDRESS1,
			string		 BUS_ADDRESS2,
			string25   BUS_CITY,
			string5    BUS_STATE,
			// string10   STATE_CODE,
			string15   BUS_ZIP_CODE,
			string     BUS_COUNTY_NAME,
			string		 BUS_COUNTRY,
			string		 MAIL_ADDRESS1,
			string		 MAIL_ADDRESS2,
			string25   MAIL_CITY,
			string2    MAIL_ST_CODE,
			string30   MAIL_STATE_NAME,
			string15   MAIL_ZIP_CODE,
			string		 MAIL_PHONE,
		END;
END;	

