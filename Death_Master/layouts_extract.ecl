EXPORT layouts_extract := MODULE

	export layout_compid_extract
		:=
			RECORD
				string9	SSN;
				string8	DOD8;
				string2	ST_COUNTRY_CODE;
				string2	CRLF;
			END;

	export layout_scank_extract
		:=
			RECORD
				string9		SSN;
				string21	LAST_NAME;
				string16	FIRST_NAME;
				string16	MID_NAME;
				string4		SUFFIX;
				string8		DOD;
				string12	CLA_DOD;
				string8		DOB;
				string12	CLA_DOB;
				string2		STATE_CTRY;
				string5		ZIP_LAST_RES;
				string5		ZIP_PAYMENT;
				string6		CERTIF_NUM;
				string20	COUNTY;
				string1		GENDER;
				string1		RACE;
				string14	MARITIAL_STATUS;
				string2		RECORD_SRC;
				string1		VERT_PROOF;
				string5		VOL_NUMB;
				string2		EOR;
			END;

END;