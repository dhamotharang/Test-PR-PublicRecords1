import address;
export layouts := MODULE

	export layout_in := RECORD
		String   fname;
		String   lname;
		String   address;
		String   city;
		String   state;
		String   zip;
		String   phone;
		String   date;
		String   field1;
	END;
	
	export layout_in2 := RECORD
		String25 RecordNum;
		String50 FirstName;
		String50 LastName;
		String50 Address;
		String30 City;
		String2  State;
		String5  Zip;
		String4  Zip4;
		String10 Mobile;
		String100 Email;
		String10 LastTransactionDate;
		String16 IPAddress;
		String100 Source;
		String1  Status;
		string1  extra;
	END;
	
	export Layout_Common := RECORD
		String25 RecordNum;
		String   FirstName;
		String   LastName;
		String   Address;
		String   City;
		String   State;
		String   Zip5;
		String4  Zip4;
		String   Phone;
		String100 EMail;
		String   Date;
		String16 IPAddress;
		String100 Source;
		String1  Status;
		String4  Provider;
	END;	
	
	export Layout_Orig := RECORD
		String25 RecordNum;
		String   Orig_fname;
		String	 Orig_lname;
		unsigned8 rawaidin;
		String	 Orig_address;
		String	 Orig_city;
		String	 Orig_state;
		String   Orig_zip5;
		String   Orig_zip4;
		String   Orig_phone;
		String   Orig_date;
		String100 Email;
		String16 IPAddress;
		String100 Source;
		String1  Status;
		String4  Provider;
		String73 Clean_Name;
	END;

	export Layout_Clean_Name := RECORD
		Unsigned Seq_Rec_Id;
		Layout_Common;
		String73 Clean_Name;
	END;
	
	export Layout_Clean_Cache := RECORD
		String32 Orig_fname;
		String32 Orig_lname;
		String73 Clean_Name;
	END;
	
	export Layout_out := RECORD
		Unsigned Seq_Rec_Id;
		Unsigned6 did :=0;
		Unsigned DID_Score_field :=0;
		Unsigned current_rec_flag :=0;
		Unsigned date_first_seen :=0;
		Unsigned date_last_seen :=0;
		Unsigned date_vendor_first_reported :=0;
		Unsigned date_vendor_last_reported :=0;
		String25 RecordNum;
		String   Orig_fname;
		String	 Orig_lname;
		unsigned8 rawaidin;
		String	 Orig_address;
		String	 Orig_city;
		String	 Orig_state;
		String   Orig_zip5;
		String   Orig_zip4;
		String   Orig_phone;
		String   Orig_date;
		String100 Email;
		String16 IPAddress;
		String100 Source;
		String1  Status;
		String4  Provider;
		address.Layout_Clean_Name;
		Unsigned8 cleanaid;
		String1  addresstype;
				 address.Layout_Clean182;
	END;

END;