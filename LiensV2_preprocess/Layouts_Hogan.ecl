

EXPORT Layouts_Hogan := MODULE

	EXPORT raw_in	:= RECORD
		string1	ADDDELFLAG;
		string2	ENTITYTYPE; //	Contains INDIVBUSUN	and AKA_YN
		// string1	INDIVBUSUN;
		// string1	AKA_YN;
		string1	ASSOCCODE;
		string7	COURTID;
		string2	FILETYPEID;
		string17	CASENUMBER;
		string6	BOOK;
		string6	PAGE;
		string8	ACTIONDATE;
		string8	ORIGLIEN;
		string9	AMOUNT;
		string9	ASSETS;
		string32	PLAINTIFF;
		string25	ATTORNEY;
		string10	ATTORPHONE;
		string8	S341DATE;
		string3	JUDGE;
		string13	OTHERCASE;
		string9	SSN;
		string32	DEFNAME;
		string1	GENERATION;
		string32	ADDRESS;
		string24	CITY;
		string2	STATE;
		string5	ZIP;
		string8	UPLOADDATE;
		string1	UNLAWDETYN;
		string17	ORIGCASE;
		string6	ORIGBOOK;
		string6	ORIGPAGE;
		string32	ATYADDRESS;
		STRING8	DOB;	//	DF-21430
		STRING8	Collection_Date;	//	DF-21430
		STRING1	Unused;	//	DF-21430
		// string24	ATYCITY;
		string2	ATYSTATE;
		string5	ATYZIP;
		string1	AVAIL;
		string2	ACTIONTYPE;
		string4	S341TIM;
		string5	CTYRESID;
		string2	STL_TYPE;
		string1	VOL_INVOL;
		string10	RMSID;
		string50	EMPLOYER_NAME;
		STRING45	CaseLinkID;	//	DF-21430
	END;
	
	EXPORT filing_type_lkp	:= RECORD
		string2		filetype_cd;
		string		filetype_desc;
	END;

	EXPORT court_lookup	:= RECORD
		string line_data;
	END;
	
	EXPORT court_lkp := RECORD
		string7	court_cd;
		string	court_desc;
	END;
	
	EXPORT generation_lkp := RECORD
		string1	generation_cd;
		string	generation_desc;
	END;

END;