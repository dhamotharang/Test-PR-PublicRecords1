EXPORT Layouts := MODULE
IMPORT RealSource, AID, address, bipv2;

	EXPORT	Raw	:= RECORD
		string  FirstName;
		string  MiddleInit;
		string  LastName;
		string  Suffix;
		string  Address;
		string  City;
		string2 State;
		string	ZipCode; //changed to string vs string5 to catch invalid ziplength
		string  ZipPlus4;
		string10 Phone;
		string8 DOB;
		string  Email;
		string  IPAddr;
		string10  Datestamp;
		string  URL;
	END;

	EXPORT Base	:= RECORD
		unsigned6 rcid;
		Raw;
		unsigned8	persistent_record_id := 0;	//unique record identifier
		
		//DID fields
		unsigned8 DID;
		unsigned8 DID_Score;

		//Clean name fields
		string5		clean_title;
		string20	clean_fname;
		string20	clean_mname;
		string20	clean_lname;
		string5		clean_name_suffix;
		string3		clean_name_score;
		
		//AID Fields
		AID.Common.xAID	RawAID;
		string77	Append_Prep_Address_Situs;
		string54	Append_Prep_Address_Last_Situs;
		
		//Clean address fields
		address.Layout_Clean182;
		
		// Instance tracking fields
		string8		process_date;
		string8		date_first_seen;
		string8		date_last_seen;
		string8		date_vendor_first_reported;
		string8		date_vendor_last_reported;
		string		clean_cname;
		boolean 	current_rec;
	END;
		
		//Not currently utilized but BIP fields will be a future project
	EXPORT Base_w_bip	:= RECORD
		Base;
		bipv2.IDlayouts.l_xlink_ids;
	END;

END;