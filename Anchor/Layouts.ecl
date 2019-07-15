EXPORT Layouts := MODULE
IMPORT Anchor, AID, address, bipv2;

	EXPORT Raw	:= RECORD
		string  FirstName;
		string  LastName;
		string  Address_1;
		string  Address_2;
		string  City;
		string  State;
		string  ZipCode;
		string  SourceURL;
		string  IPAddress;
		string  OptInDate;
		string  EmailAddress;
		string  AnchorInternalCode;
		string  AddressType;
		string  DOB;
		string  Latitude;
		string  Longitude;
	END;
	
	EXPORT Base	:= RECORD
	 unsigned6 rcid; //Used for Ingest process
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