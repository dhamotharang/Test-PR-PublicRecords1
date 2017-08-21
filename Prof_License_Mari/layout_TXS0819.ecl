// TXS0819 / Texas Real Estate Commission / Real Estate //

export layout_TXS0819 := MODULE
	export raw := RECORD
			string31   INDIV_BUS;				//L,FM fmt(indv) or Business Name
			string3    NAME_SUFFIX;			//ie. JR, III, SR
			string31   CONTACT;					//Name of Sponsor/Designated Officer,Mgr,or Partner
			string30   ADDRESS1;
			string30   ADDRESS2;
			string20   CITY;
			string2    STATE;
			string5    ZIP_CODE;
			string3    COUNTY;
			string6    EXP_DATE;				//fmt MMDDYY
			string6    PRINTED_DATE;		//fmt MMDDYY
			string10   CONT_SLNUM;			//Sponsor/D.O. etc License Number
			string10   LIC_NUMR;
			string2    LIC_TYPE;				
			string6    ISSUE_DATE;			//Original Issue Date, fmt MMDDYY
			string1    SAE_STATUS;			//Saleperson Annual Education <SAE>
			string2    LIC_STATUS;
			string1    MCE_STATUS;			//Manadatory Continiuing Education Status	
			string9		 AGENCY_ID;				//Agency Entity Identifier
		END;

//Record Length 651
export raw_new := RECORD
			string4    LIC_TYPE;
			string10   LIC_NUMR;
			string64   INDIV_BUS;								//L,FM fmt(indv) or Business Name
			string4    NAME_SUFFIX;							//ie. JR, III, SR
			string2    LIC_STATUS;
			string8    ISSUE_DATE;						 // Original Issue Date, fmt: CCYYMMDD
			string8    EXP_DATE;							 // License Expiration Date; fmt: CCYYMMDD
			string1    SAE_STATUS;						 // Saleperson Annual Education <SAE>
			string1    MCE_STATUS;						 // Manadatory Continiuing Education Status
			string1		 Supv_flag;   					 // Desginated Supervisor Flag
			string12	 PHONE_NBR;							 // Phone Number; fmt: 999-999-9999
			string100	 email_addr;             // Email Address
			string54   mail_address1;					 // mailing address info
			string40   mail_address2;
			string40   mail_address3;
			string20   mail_CITY;
			string2    mail_STATE;
			string10   mail_ZIP_CODE;						// fmt: 99999 or 99999-9999
			string3    mail_COUNTY;							// fmt: 999
			string54   bus_address1;						// physical address info
			string40   bus_address2;
			string40   bus_address3;
			string20   bus_CITY;
			string2    bus_STATE;
			string10   bus_ZIP_CODE;						// Physical Address Zip Code; fmt: 99999 or 99999-9999
			string3    bus_COUNTY;							// Physical Address County Code; fmt: 999
			string4    relate_LIC_TYPE;					// Related License Type
			string10   relate_LIC_NUMR;					// Related License Number
			string64   relate_INDIV_BUS;				// Related Full Name; L,FM fmt(indv) or Business Name
			string4    relate_NAME_SUFFIX;			// Related License Suffix; ie. JR, III, SR
			string8		 relate_start_date;				// Relationship Start Date; fmt: CCYYMMDD
			string9		 agency_id;								// Agency Entity Identifier
			string45	 key_name;
		END;

	export Common := RECORD
			raw_new;
			string		 LN_FILEDATE;			//internal
	END;

	export county_name := RECORD
			STRING 	COUNTY_NBR;
			STRING	COUNTY_NAMES;
	END;


END;