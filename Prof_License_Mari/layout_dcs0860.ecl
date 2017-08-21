Export layout_dcs0860 := Module

Export Raw := Record //20141002 update
		// String	SHRT_DSCR;//SHRT_DSCR
		// string  MNAME;
		String	LNAME; //FNAME
		String	FNAME;//LNAME		
		String	LIC_TYPE_CD;//LIC_TYPE_CD
		String	IL_LIC_NBR; //IL_LIC_NBR

		String	ORIG_ISS_DTE; //ORIG_ISS_DTE
		String	EXPR_DTE; //EXPR_DTE
		String	EMAIL; //INET_ADDR		
		String	ADDR1; //LINE_ONE_ADDR
		String	ADDR2; //LINE_TWO_ADDR
		String	CITY;//CITY_NAME	
		String	STATE;//ST_CD
		String	ZIPCODE;//PSTL_CD		
		String  PHONE_TYPE;
		String  PHONE;
		// String	STATUS_CODE; //STS_CD
End;

Export Common := Record
		String	LIC_TYPE_CD;//LIC_TYPE_CD
		String	SHRT_DSCR;//SHRT_DSCR
		String	LNAME;//LNAME
		String  MNAME;
		String	FNAME; //FNAME
		String	IL_LIC_NBR; //IL_LIC_NBR
		String	ORIG_ISS_DTE; //ORIG_ISS_DTE
		String	EXPR_DTE; //EXPR_DTE
		String	ADDR1; //LINE_ONE_ADDR
		String	ADDR2; //LINE_TWO_ADDR
		String	CITY;//CITY_NAME
		String	STATE;//ST_CD
		String	ZIPCODE;//PSTL_CD
		String	EMAIL; //INET_ADDR
		String	STATUS_CODE; //STS_CD
		String  PHONE_TYPE; //PH_TYPE_CD
		String  PHONE;	//PH_NBR	
		// String	LN_FILEDATE;
	End;

End;	