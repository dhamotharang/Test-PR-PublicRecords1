/*2018-01-04T20:52:06Z (xsheng_prod)
C:\Users\shenxi01\AppData\Roaming\HPCC Systems\eclide\xsheng_prod\New_Dataland\Prof_License_Mari\layout_dcs0860\2018-01-04T20_52_06Z.ecl
*/
Export layout_dcs0860 := Module

Export Raw := Record //20141002 update
  STRING LIC_TYPE_CD; //LICENSE NAME
	 STRING	IL_LIC_NBR; //LICENSE NUMBER
	 STRING FULLNAME; //MEMBER NAME
	 STRING	EMAIL; //INET_ADDR		
	 STRING PHONE;
	 String	STATUS_CODE; //STS_CD
		STRING	ADDR1; //LINE_ONE_ADDR
		STRING	ADDR2; //LINE_TWO_ADDR
		STRING ADDR3;
		STRING	CITY;//CITY_NAME			
		STRING	ZIPCODE;//PSTL_CD		
		STRING STATE;
End;

Export Common := Record
		String	LIC_TYPE_CD;//LIC_TYPE_CD
		String	SHRT_DSCR;//SHRT_DSCR
		String FULLNAME;
		String	IL_LIC_NBR; //IL_LIC_NBR
		String	ORIG_ISS_DTE; //ORIG_ISS_DTE
		String	EXPR_DTE; //EXPR_DTE
		String	ADDR1; //LINE_ONE_ADDR
		String	ADDR2; //LINE_TWO_ADDR
		String ADDR3;
		String	CITY;//CITY_NAME
		String	STATE;//ST_CD
		String	ZIPCODE;//PSTL_CD
		String	EMAIL; //INET_ADDR
		String	STATUS_CODE; //STS_CD
		String PHONE_TYPE; //PH_TYPE_CD
		String PHONE;	//PH_NBR	
		// String	LN_FILEDATE;
	End;

End;	