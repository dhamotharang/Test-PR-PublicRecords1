IMPORT Autokey_batch, DeltabaseGateway, Doxie, BatchServices, BatchShare, iesp, Phones, PhonesInfo;

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
		UNSIGNED1 privateFlag;
		UNSIGNED1 availabilityIndicator;
		STRING error_desc;
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
			string4 	event_type;
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
			
		END;
		
		
		EXPORT Raw := RECORD
			BatchShare.Layouts.ShareAcct;
			recordof(PhonesInfo.Key_Phones.Ported_Metadata);
			BatchOut;
		 Carrier_Reference;//Added for Phone Finder inhousemetadata
		END;

	END;

END;