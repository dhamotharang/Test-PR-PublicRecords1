export Layout_PCNSR_Out := RECORD
STRING20		acctno;
STRING138		filler1 := '';
STRING1			addrChar_in;//Input Address Characteristics
STRING1			phoneStatus;//Status of return phone
STRING10		phone;					//Output Phone Number
STRING3			altAreaCode;				//Alternate Area Code
STRING8			altAreaCodeDate;		//Date New Area Code Must Be Used
STRING2			iCode;							//Internal Code
STRING24		filler2 := '';
STRING1			statusNameAddress;	//Status of return Name and Address
STRING1			addrChar_out;				//Output Address Characteristics
STRING15		fname;					//Output First Name
STRING15		mname;					//Output Middle Name
STRING20		lname;					//Output Last Name
STRING4			suffix;					//Output Name Suffix
STRING50		strAddr;				//Street Address
STRING60		address1;				//Address Line 1
STRING30		address2;				//Address Line 2
STRING10		pobox;							//PO Box Number
STRING10		prim_range;			//Street Number
STRING4			predir;					//Street Pre-directional
STRING30		prim_name;			//Street Name
STRING10		addr_suffix;		//Street Suffix
STRING4			postdir;				//Street Post-Directional
STRING10		unit_desig;			//Unit Type
STRING8			sec_range;			//Unit ID
STRING30		city;						//Output City Name
STRING2			state;					//Output State
STRING9			zip;						//Output Zip + 4
STRING10		infousa_id := '';
STRING9			ssn := '';
STRING10		latitude;				//Output Latitude
STRING11		longitude;			//Output Longitude
STRING50		address_type;		//Output Address Type
STRING3			area_code;			//Output Area Code
STRING7			phone7;					//Output Phone w/o Area Code
STRING6			matchCode;					//Match Code
STRING1			priority;						//Priority
STRING8			addr_crt_dt;				//Address Creation date
STRING8			addr_upt_dt;				//Address Update Date
STRING128		filler3 := '';				
STRING1			coaFlag;						//COA Flag	
STRING1			ownType;						//Owner Type
STRING1			incomeCode;					//Income Code
STRING1			lengthOfRes;				//Length Of residence
STRING1			resType;						//Residence Type
STRING10		spouseName;					//Name of Spouse
STRING8			rptDate;						//Report Date
END;