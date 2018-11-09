IMPORT Autokey_batch,DeltabaseGateway,Doxie, BatchServices, BatchShare, iesp, PhonesInfo;

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
	
	EXPORT Deltabase := MODULE	
		// Deltabase Layouts
		EXPORT dValue := RECORD
			STRING100 Value {XPATH('Value')};
		END;
		EXPORT dParameters := RECORD
			DATASET(dValue) Parameter {XPATH('Parameter')}; 
		END;
		EXPORT dInput := RECORD
			STRING Select {XPATH('Select')};
			DATASET(dParameters) Parameters {XPATH('Parameters')};
		END;
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
			DATASET (ATTRecord) Records	 			 {XPATH('Records/Rec'), MAXCOUNT(Phones.Constants.GatewayValues.SQLSelectLimit)};
			STRING  RecsReturned                     {XPATH('RecsReturned'),MAXLENGTH(Phones.Constants.GatewayValues.MaxRecords)};
			STRING  Latency													 {XPATH('Latency')};
			STRING  ExceptionMessage								 {XPATH('Exceptions/Exception/Message')};
		END;	
	END;	
	
	
	
	

	EXPORT gatewayHistory := RECORD
		RECORDOF(DeltabaseGateway.Key_Deltabase_Gateway.Historic_Results);
	END;

	EXPORT ZumigoIdentity := MODULE
		EXPORT subjectName := RECORD
			UNSIGNED6 lexid;
			STRING20 	nameType;
			STRING20 	first_name;
			STRING20 	last_name;		
		END;
		
		business := RECORD
			UNSIGNED6 busult_id;
			UNSIGNED6 busorg_id;
			UNSIGNED6 bussele_id;
			UNSIGNED6 busprox_id;
			UNSIGNED6 buspow_id;
			UNSIGNED6 busemp_id;
			UNSIGNED6 busdot_id;
			STRING120 business_name;
		END;
		
		address := RECORD
			STRING20 	addressType;
			BatchServices.Layouts.layout_batch_common_address;
		END;
		
		EXPORT subjectVerificationRequest := RECORD
			STRING	 	acctno;
			UNSIGNED1 sequence_number;			
			STRING10 	phone;
			subjectName;
			business;
			address;
		END;
	
		EXPORT zIn := RECORD
			STRING acctno;
			UNSIGNED1 sequence_number;
			STRING MobileDeviceNumber;
			iesp.zumigo_identity.t_ZIdNameToVerify Name;
			iesp.zumigo_identity.t_ZIdSubjectAddress Address;
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

	EXPORT PhoneAttributes := MODULE
		EXPORT gatewayQuery:=RECORD
			STRING10 phone;
		END;
		EXPORT BatchIn := RECORD
			BatchShare.Layouts.ShareAcct;
			BatchShare.Layouts.SharePhone;
		END;
		
		EXPORT Raw := RECORD
			BatchShare.Layouts.ShareAcct;
			recordof(PhonesInfo.Key_Phones.Ported_Metadata);
		END;
		
		EXPORT BatchOut := RECORD
			BatchIn;
			boolean 	is_current;
			unsigned8 event_date;
			string4 	event_type;
			unsigned8	disconnect_date;
			unsigned8	ported_date;
			string		carrier_id;
			string60	carrier_name;
			string10	carrier_category;
			string		operator_id;
			string		operator_name;
			unsigned8 line_type_last_seen;
			string		phone_serv_type;
			string		phone_line_type;
			unsigned8	swapped_phone_number_date;
			string10	new_phone_number_from_swap;
			unsigned8	suspended_date;
			unsigned8	reactivated_date;
			string5		source;
		END;

	END;
	
END;