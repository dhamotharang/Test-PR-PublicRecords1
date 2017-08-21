// MIS0298 / Michigan Dept of Consumer & Industry Service /	Multiple Professions //

export layout_MIS0298 := MODULE

	export Broker	:= RECORD
		string11   PROFID,
		string15   SLNUM,
		string150  ORG_NAME,
		string3	   ORG_TYPE, 	
		string10   ISSUEDT,		// MM/DD/YYYY
		string5	   ZIP,
		string30   COUNTY,
		string3	   CNTRY_CD,
		string60   ADDRESS1,
		string35   CITY,
		string2    STATE,
		string60   ADDRESS2,
		string60   ADDRESS3,
		string11   LIC_TYPE,
		string15   LICSTAT,
		string10   STAT_DATE,	// MM/DD/YYYY
		string10   EXPDT,			// MM/DD/YYYY
		string15   OFF_SLNUM,
		string60	 OFFICENAME,
		string150	 DBA,
		string40	 PREADDRESS1,
		string40	 PREADDRESS2,
		string40	 PREADDRESS3,
		string35	 PRECITY,
		string2		 PRESTATE,
		string5		 PREZIP,
		string10   PREENTITYID,
		string15	 PREPERSONID,
	END;

	export RealEstate	:= RECORD
		string11   PROFID,
		string15   SLNUM,
		string150  ORG_NAME,
		string150	 DBA_NAME,
		string3    ORG_TYPE,
		string10   ISSUEDT,
		string5    ZIP,
		string30   COUNTY,
		string3    CNTRY_CD,
		string60   ADDRESS1,
		string35   CITY,
		string2    STATE,
		string60   ADDRESS2,
		string60   ADDRESS3,
		string11   LIC_TYPE,
		string15   LICSTAT,
		string10   EXPDT,
		string10   PREENTITYID,
		string15	 PREPERSONID,
	END;

	export MiscLic	:= RECORD
		string11   PROFID,
		string15   SLNUM,
		string150  ORG_NAME,
		string1	   ORG_TYPE,	//N = Person, Y = Organization
		string8	   ISSUEDT,		//YYYYMMDD
		string10   ZIP,
		string30   COUNTY,
		string11   CNTRY_CD,
		string60   ADDRESS1,
		string35   CITY,
		string2    STATE,
		string60   ADDRESS2,
		string60   ADDRESS3,
		string11   LIC_TYPE,
		string11   LICSTAT,
		string8    STAT_DATE,	//YYYYMMDD
		string8    EXPDT,			//YYYYMMDD
		string15   PRESLNUM,
		string11   PRELICTYPE,
	END;
END;