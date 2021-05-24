IMPORT Autokey_batch, DeltabaseGateway, Doxie, BatchServices, BatchShare, iesp, Phones;

EXPORT Layouts :=
MODULE
	// Batch input common layout
	EXPORT BatchIn :=
	RECORD(Autokey_batch.Layouts.rec_inBatchMaster)
		UNSIGNED6 orig_did;
	END;

	// Phones common layout
	EXPORT PhonesCommon :=
	RECORD(doxie.layout_pp_raw_common)
		BatchIn batch_in;
    DATASET({STRING3 src}) Phn_src_all;
	END;
	EXPORT PhoneAcctno := RECORD
		STRING20 acctno;
		STRING10 phone;
	END;
	EXPORT PhoneIdentity := RECORD
		UNSIGNED8 seq;
		STRING20 acctno;
		STRING10 phone;
		STRING2 src;
		STRING1	ActiveFlag;
		UNSIGNED6 did;
		UNSIGNED6 ultid;
		UNSIGNED6 orgid;
		UNSIGNED6 seleid;
		UNSIGNED6 proxid;
		UNSIGNED6 powid;
		UNSIGNED6 bdid := 0;
		STRING8 dt_first_seen;
		STRING8 dt_last_seen;
		STRING9 ssn;
		STRING20 fname;
		STRING20 mname;
		STRING20 lname;
		STRING5 name_suffix;
		STRING120 CompanyName;
		STRING10 prim_range;
		STRING2 predir;
		STRING28 prim_name;
		STRING4 suffix;
		STRING2 postdir;
		STRING10 unit_desig;
		STRING8 sec_range;
		STRING120	addr;
		STRING25	city_name;
		STRING2	st;
		STRING5	zip;
		STRING4	zip4;
		STRING30 county;
		STRING120 listed_name;
		STRING1 listing_type_res;
		STRING1 listing_type_bus;
		STRING1 listing_type_gov;
		STRING25 append_phone_type;
	END;

	EXPORT Deltabase := MODULE
		// Deltabase Layouts
		EXPORT ATTRecord := RECORD
			 STRING   transaction_id				{XPATH('transaction_id')};
			 STRING	 	batch_job_id					{XPATH('batch_job_id')};
			 STRING   vendor_transaction_id	{XPATH('vendor_transaction_id')};
			 STRING   date_added				  	{XPATH('date_added')};
			 STRING   source				  			{XPATH('source')};
			 STRING10 submitted_phonenumber	{XPATH('submitted_phonenumber')};
			 STRING   carrier_name				  {XPATH('carrier_name')};
			 STRING   carrier_category			{XPATH('carrier_category')};
			 STRING		carrier_ocn				  	{XPATH('carrier_ocn')};
			 STRING		lata									{XPATH('lata')};
			 STRING 	reply_code						{XPATH('reply_code')};
			 STRING 	point_code				  	{XPATH('point_code')};
		END;

		EXPORT ATTResponse := RECORD
			DATASET (ATTRecord) Records	{XPATH('Records/Rec'), MAXCOUNT(Phones.Constants.GatewayValues.SQLSelectLimit)};
			STRING  RecsReturned {XPATH('RecsReturned'),MAXLENGTH(Phones.Constants.GatewayValues.MaxRecords)};
			STRING  Latency {XPATH('Latency')};
			STRING  ExceptionMessage {XPATH('Exceptions/Exception/Message')};
		END;
	END;

	EXPORT gatewayHistory := RECORD
		RECORDOF(DeltabaseGateway.Key_Deltabase_Gateway.Historic_Results);
	END;

	EXPORT ZumigoIdentity := MODULE
		EXPORT subjectName := RECORD
			UNSIGNED6 lexid;
			STRING40 	nameType;
			STRING20 	first_name;
			STRING20 	middle_name;
			STRING20 	last_name;
		END;

		SHARED business := RECORD
			UNSIGNED6 busult_id;
			UNSIGNED6 busorg_id;
			UNSIGNED6 bussele_id;
			UNSIGNED6 busprox_id;
			UNSIGNED6 buspow_id;
			UNSIGNED6 busemp_id;
			UNSIGNED6 busdot_id;
			STRING120 business_name;
		END;

		SHARED email := RECORD
			STRING40  emailType;
			STRING50 email_address;
		END;

		EXPORT address := RECORD
			STRING40 	addressType;
			BatchServices.Layouts.layout_batch_common_address;
		END;
		EXPORT subjectVerificationRequest := RECORD
			STRING	 	acctno;
			UNSIGNED1 sequence_number;
			STRING10 	phone;
			subjectName;
			business;
			address;
			email;
		END;

		EXPORT zIn := RECORD
			STRING acctno;
			UNSIGNED1 sequence_number;
			STRING MobileDeviceNumber;
			iesp.zumigo_identity.t_ZIdNameToVerify Name;
			iesp.zumigo_identity.t_ZIdSubjectAddress Address;
			iesp.zumigo_identity.t_ZIdEmailToVerify Email;
		END;

		EXPORT zOutEmail := RECORD
			STRING TransactionId;
			UNSIGNED6 lexid;
			STRING FirstName;
			STRING LastName;
			STRING Email;
			UNSIGNED Email_rec_key ;
		END;
		EXPORT zOut := RECORD
			STRING acctno:='';
			UNSIGNED1 sequence_number :=0 ;
			gatewayHistory;
		END;
		// Deltabase format specific to report services only
	 EXPORT zDeltabaseLog := RECORD
	   DATASET(zOut) Records {XPATH('Records/Rec')};
	 END;

	END;

	EXPORT AccuDataCNAM := RECORD
		STRING20 acctno;
		UNSIGNED6 did;
		STRING2 source;
		STRING20 fname;
		STRING20 lname;
		STRING listingName;
		STRING10 phone;
		STRING error_desc;
	END;

	EXPORT rec_phoneLayout := RECORD
	   STRING10 phone;
    END;

	EXPORT portedMetadata_Main := RECORD
		string30 		reference_id;
		string5			source;
		unsigned8 		dt_first_reported;
		unsigned8		dt_last_reported;
		string10 		phone;
		string2			phonetype;
		string3 		reply_code;
		string10 		local_routing_number;
		string6			account_owner;
		string60 		carrier_name;
		string10 		carrier_category;
		string5 		local_area_transport_area;
		string10 		point_code;
		string3			country_code;
		string1			dial_type;
		string10 		routing_code;
		unsigned8		porting_dt;
		string6			porting_time;
		string2			country_abbr;
		unsigned8		vendor_first_reported_dt;
		string6			vendor_first_reported_time;
		unsigned8		vendor_last_reported_dt;
		string6			vendor_last_reported_time;
		unsigned8		port_start_dt;
		string6			port_start_time;
		unsigned8		port_end_dt;
		string6			port_end_time;
		boolean			is_ported;
		string1 		serv;
		string1 		line;
		string10 		spid;
		string60		operator_fullname;
		string5			number_in_service;
		string2			high_risk_indicator;
		string2			prepaid;
		string10 		phone_swap;
		string2			transaction_code;
		unsigned8		swap_start_dt;
		string6			swap_start_time;
		unsigned8		swap_end_dt;
		string6			swap_end_time;
		string2			deact_code;
		unsigned8		deact_start_dt;
		string6			deact_start_time;
		unsigned8		deact_end_dt;
		string6			deact_end_time;
		unsigned8		react_start_dt;
		string6			react_start_time;
		unsigned8		react_end_dt;
		string6			react_end_time;
		string2			is_deact;
		string2			is_react;
		unsigned8		call_forward_dt;
		string15		caller_id;
		unsigned8 	event_date;
		string4 	event_type;
		unsigned8   remove_port_dt;
		unsigned	count_otp_30;	//add more count variables here
		unsigned	count_otp_60;
		unsigned	count_otp_90;
		unsigned	count_otp_180;
		unsigned	count_otp_365;
		unsigned	count_otp_730;
    string10  alt_spid;   // Added 2021-06-02 for the Phone Porting Data for LE project
    string10  lalt_spid;  // Added 2021-06-02 for the Phone Porting Data for LE project
	END;

	EXPORT PhoneAttributes := MODULE
		EXPORT gatewayQuery:=RECORD
			STRING10 phone;
		END;
		EXPORT BatchIn := RECORD
			BatchShare.Layouts.ShareAcct;
			BatchShare.Layouts.SharePhone;
		END;

	 EXPORT Carrier_Reference := RECORD
			STRING25 ocn_abbr_name;
		 STRING4	carrier_route;
		 STRING1	carrier_route_zonecode;
		 STRING2	delivery_point_code;
		 STRING80 affiliated_to;
		 STRING60 contact_name;
		 STRING30 contact_address1;
		 STRING30 contact_address2;
		 STRING30 contact_city;
		 STRING2	contact_state;
		 STRING9	contact_zip;
		 STRING10 contact_phone;
		 STRING10 contact_fax;
		 STRING60 contact_email;
		END;

		EXPORT BatchOut := RECORD
			BatchIn;
			boolean 	is_current;
			unsigned8 	event_date;
			string 	event_type;
			unsigned8	disconnect_date;
			unsigned8	ported_date;
			string		carrier_id;
			string60	carrier_name;
			string10	carrier_category;
			string		operator_id;
			string		operator_name;
			unsigned8 	line_type_last_seen;
			string1		phone_serv_type;
			string1		phone_line_type;
			unsigned8	swapped_phone_number_date;
			string10	new_phone_number_from_swap;
			unsigned8	suspended_date;
			unsigned8	reactivated_date;
			string1		prepaid;
			string5		source;
			string		error_desc;
			boolean 	dialable;
			string1		phone_line_type_desc;
			string1		phone_serv_type_desc;
			string30 	carrier_city;
			string2 	carrier_state;
			string32 	phone_status;
		END;


		EXPORT Raw := RECORD
			BatchShare.Layouts.ShareAcct;
			portedMetadata_Main;
			BatchOut;
		 Carrier_Reference;
		END;

	END;
  
 EXPORT SourceLevelAttributes := MODULE // used for Phones.GetSourceLevelPhonesPlus
 
  EXPORT BatchIn := RECORD
   UNSIGNED8 seq;
			UNSIGNED8 did;
			STRING10  phone;
		END;
    
  EXPORT BatchOut := RECORD
   // identifiers from input   
   BatchIn;
   
   // payload key attributes
   QSTRING100	source_did_scores; // most recent value per source, comma-delimited
   QSTRING150 source_codes; // one entry per source, comma-delimited list
   QSTRING100 source_household_flags; // most recent value per source, comma-delimited list
   QSTRING100 source_glb_dppa_flags; // most recent populated flag per source, comma-delimited list
   QSTRING200 source_dt_nonglb_last_seen; // max value within source, comma-delimited list
   QSTRING200 source_date_first_seen; // min value within source, comma-delimited list
   QSTRING200 source_date_last_seen; // max value within source, comma-delimited list
   QSTRING200 source_date_vendor_first_reported; // min value within source, comma-delimited list
   QSTRING200 source_date_vendor_last_reported; // max value within source, comma-delimited list
   UNSIGNED8  source_bitmap; // src_all to be built from src_bitmap to be added by Dawn. Might not need to pass it back
   UNSIGNED8  source_rules; // rules bitmap will also be added by Dawn, and added here if we need to pass it back
   QSTRING200 source_first_build_date; // min value within source, comma-delimited list
   QSTRING200 source_last_build_date; // max value within source, comma-delimited list
    
   // calculated attributes
   UNSIGNED3 phone_last_seen_date_same_lexid; // last time the phone was seen on this DID, using datelastseen
   UNSIGNED3 phone_last_seen_date_diff_lexid; // last time phone was seen on any DID EXCEPT the input DID, using datelastseen 
   UNSIGNED3 phone_vendor_last_seen_same_lexid; // last time the phone was seen on this DID, using vendorlastreported
   UNSIGNED3 phone_vendor_last_seen_diff_lexid; // last time phone was seen on any DID EXCEPT the input DID, using vendorlastreported
   UNSIGNED3 phone_did_count; // counts all unique non-zero DIDs (including the input DID) for this phone
   // some additional counts and such may be requested by Blake
  END;
    
 END; // End SourceLevelAttributes

END;