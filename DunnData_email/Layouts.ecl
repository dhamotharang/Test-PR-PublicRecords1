EXPORT Layouts := MODULE
IMPORT DunnData_email, AID, address, bipv2;

	EXPORT Input := RECORD
		STRING32	DTMATCH;	//Individual unique record match code - Used for all Dunn files
		STRING60	EMAIL;
		STRING50	NAME_FULL;
		STRING50	ADDRESS1;
		STRING50	ADDRESS2;
		STRING20	CITY;
		STRING2		STATE;
		STRING5		ZIP5;
		STRING4		ZIP_ext;
		STRING25	IPADDR;
		STRING25	DATESTAMP;
		STRING100	URL;
		STRING10	LASTDATE; 	//Last known date for activity
		STRING8		EM_SRC_CNT;	//Number of souces for Individual/email address combo
		STRING8		NUM_EMAILS;	//Number of email address sharing this individual postal address
		STRING8		NUM_INDIV;	//Number of individual postal address sharing this email;
	END;
	
	EXPORT Base	:= RECORD
		UNSIGNED6 rcid; //Used for Ingest process
		Input;
		UNSIGNED8	persistent_record_id := 0;	//unique record identifier
		
		//DID fields
		UNSIGNED8 DID;
		UNSIGNED8 DID_Score;

		//Clean name fields
		STRING5		clean_title;
    STRING20	clean_fname;
    STRING20	clean_mname;
    STRING20	clean_lname;
    STRING5		clean_name_suffix;
    STRING3		clean_name_score;
		
		//AID Fields
		AID.Common.xAID	RawAID;
		STRING77	Append_Prep_Address_Situs;
		STRING54	Append_Prep_Address_Last_Situs;
		
		//Clean address fields
		address.Layout_Clean182;
		
		//Instance tracking fields
		STRING8		process_date;
		STRING8		date_first_seen;
		STRING8		date_last_seen;
		STRING8		date_vendor_first_reported;
		STRING8		date_vendor_last_reported;
		STRING		clean_cname;
		BOOLEAN 	current_rec;
		bipv2.IDlayouts.l_xlink_ids;
		END;
END;
	