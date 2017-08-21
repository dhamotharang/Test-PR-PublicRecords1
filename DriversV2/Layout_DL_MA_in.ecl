export Layout_DL_MA_In := module

	export	Raw	:=	record
		string9   PERS_SURROGATE;  				//	9(9)	001-009
		string1   FILLER1;								//	X(1)	010-010
		string9		LICENSE_LICNO;					//	X(9)	011-019
		string1		FILLER2;								//	X(1)	020-020
		string8		LICENSE_BDATE_YYYYMMDD;	//	9(8)	021-028
		string8		LICENSE_EDATE_YYYYMMDD;	//	9(8)	029-036
		string2		LICENSE_LIC_CLASS;			//	X(2)	037-038
		string3		LICENSE_HEIGHT;					//	9(3)	039-041
		string1		LICENSE_SEX;						//	X(1)	042-042
		string16	LICENSE_LAST_NAME;			//	X(16)	043-058
		string12	LICENSE_FIRST_NAME;			//	X(12)	059-070
		string8		LICENSE_MIDDLE_NAME;		//	X(8)	071-078
		string20	LICMAIL_STREET1;				//	X(20)	079-098
		string20	LICMAIL_STREET2;				//	X(20)	099-118
		string15	LICMAIL_CITY;						//	X(15)	119-133
		string2		LICMAIL_STATE;					//	X(2)	134-135
		string9		LICMAIL_ZIP;						//	9(9)	136-144
		string20	LICRESI_STREET1;				//	X(20)	145-164
		string20	LICRESI_STREET2;				//	X(20)	165-184
		string15	LICRESI_CITY;						//	X(15)	185-199
		string2		LICRESI_STATE;					//	X(2)	200-201
		string9		LICRESI_ZIP;						//	9(9)	202-210
		string8		ISSUE_DATE_YYYYMMDD;    //	9(8)	211-218
		string7		LICENSE_STATUS;					//	X(7)	219-225
		string2		CRLF;										//				226-227
	end;

  export 	Layout_MA_With_Clean := record
			Raw;
			string3		clean_status			:= '';
			string8 	process_date	  	:= '';
  end;
	
end;



