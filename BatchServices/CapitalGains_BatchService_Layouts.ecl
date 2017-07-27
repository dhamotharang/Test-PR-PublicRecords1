import Autokey_batch;
export CapitalGains_BatchService_Layouts := module
	EXPORT batch_in := RECORD
		Autokey_batch.Layouts.rec_inBatchMaster.seq;
		Autokey_batch.Layouts.rec_inBatchMaster.acctno;
		string100	addr;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_range;
		Autokey_batch.Layouts.rec_inBatchMaster.predir;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_name;
		Autokey_batch.Layouts.rec_inBatchMaster.addr_suffix;
		Autokey_batch.Layouts.rec_inBatchMaster.postdir;
		Autokey_batch.Layouts.rec_inBatchMaster.unit_desig;
		Autokey_batch.Layouts.rec_inBatchMaster.sec_range;
		Autokey_batch.Layouts.rec_inBatchMaster.p_city_name;
		Autokey_batch.Layouts.rec_inBatchMaster.st;
		Autokey_batch.Layouts.rec_inBatchMaster.z5;
		Autokey_batch.Layouts.rec_inBatchMaster.zip4;
		Autokey_batch.Layouts.rec_inBatchMaster.name_first;
		Autokey_batch.Layouts.rec_inBatchMaster.name_middle;
		Autokey_batch.Layouts.rec_inBatchMaster.name_last;
		Autokey_batch.Layouts.rec_inBatchMaster.name_suffix;
		Autokey_batch.Layouts.rec_inBatchMaster.ssn;
		Autokey_batch.Layouts.rec_inBatchMaster.dob;
		string20	subject1_first;
		string20	subject1_middle;
		string20	subject1_last;
		string5		subject1_suffix;
		string12	subject1_ssn;
		string8		subject1_dob;
		string20	subject2_first;
		string20	subject2_middle;
		string20	subject2_last;
		string5		subject2_suffix;
		string12	subject2_ssn;
		string8		subject2_dob;
		string4 	year;
		integer 	error_code := 0; // [internal]
		Autokey_batch.Layouts.rec_inBatchMaster.DID; // [internal]
	END;
	
	EXPORT batch_out := Record
		typeof(Autokey_batch.Layouts.rec_inBatchMaster.acctno) acctno;

		BatchServices.layout_Property_Batch_out.property_address1;
		BatchServices.layout_Property_Batch_out.property_address2;
		string25	property_city_name;
		BatchServices.layout_Property_Batch_out.property_st;
		BatchServices.layout_Property_Batch_out.property_zip;
		BatchServices.layout_Property_Batch_out.property_zip4;
		string65	property_owner1_name;
		string65	property_owner2_name;
		string65	property_seller1_name;
		string65	property_seller2_name;
		string8		sale_date;
		string8		prior_sale_date;
		unsigned3	sale_days_diff;
		string15	sale_amnt; 
		string15	prior_sale_amnt;			
		string15	sale_amnt_diff;
		string15	sale_amnt_diff_pct;
		string15	assessment_value;		
				
		unsigned6 subject1_did;	// [internal]
		string70  subject1_best_name;
		string12	subject1_ssn;
		string8		subject1_dob;
		string75  subject1_current_addr;
		string25  subject1_current_city;
		string2   subject1_current_state;
		string10  subject1_current_zip;
		string10	subject1_current_phone;

		string1		subject1_deceased_indicator; // Y - last name and ssn, 1 - name and DOB, 2 - name only, N - no match
		string8		subject1_dod;
		string20	subject1_deceased_first;
		string20	subject1_deceased_last;
		string12 	subject1_deceased_ssn;
		string8		subject1_deceased_dob;
		
		unsigned6 subject2_did;	// [internal]
		string70  subject2_best_name;
		string12	subject2_ssn;
		string8		subject2_dob;		
		string75  subject2_current_addr;
		string25  subject2_current_city;
		string2   subject2_current_state;
		string10  subject2_current_zip;
		string10	subject2_current_phone;
		
		string1		subject2_deceased_indicator; // Y - last name and ssn, 1 - name and DOB, 2 - name only, N - no match
		string8		subject2_dod;
		string20	subject2_deceased_first;
		string20	subject2_deceased_last;
		string12 	subject2_deceased_ssn;
		string8		subject2_deceased_dob;		

		string4		tax_year; // [internal]
		BatchServices.layout_Property_Batch_out.ln_fares_id; // [internal]
		string4   last4APN; // [internal]
		integer 	error_code;
	END;
	
	EXPORT batch_flat_tmp := RECORD		

		Autokey_batch.Layouts.rec_inBatchMaster.acctno;			
		Autokey_batch.Layouts.rec_inBatchMaster.seq;
		string20	orig_acctno;		
		BatchServices.layout_Property_Batch_out.sortby_date;
		
		BatchServices.layout_Property_Batch_out.vendor_source_flag;		
		BatchServices.layout_Property_Batch_out.fid_type;		
		BatchServices.layout_Property_Batch_out.ln_fares_id;		
		unsigned6 owner_1_did;
		BatchServices.layout_Property_Batch_out.owner_1_ssn;
		BatchServices.layout_Property_Batch_out.owner_1_first_name;
		BatchServices.layout_Property_Batch_out.owner_1_middle_name;
		BatchServices.layout_Property_Batch_out.owner_1_last_name;
		BatchServices.layout_Property_Batch_out.owner_1_name_suffix;
		unsigned6 owner_2_did;
		BatchServices.layout_Property_Batch_out.owner_2_ssn;
		BatchServices.layout_Property_Batch_out.owner_2_first_name;
		BatchServices.layout_Property_Batch_out.owner_2_middle_name;
		BatchServices.layout_Property_Batch_out.owner_2_last_name;
		BatchServices.layout_Property_Batch_out.owner_2_name_suffix;
		unsigned6 buyer_1_did;
		BatchServices.layout_Property_Batch_out.buyer_1_ssn;
		BatchServices.layout_Property_Batch_out.buyer_1_first_name;
		BatchServices.layout_Property_Batch_out.buyer_1_middle_name;
		BatchServices.layout_Property_Batch_out.buyer_1_last_name;
		BatchServices.layout_Property_Batch_out.buyer_1_name_suffix;
		unsigned6 buyer_2_did;
		BatchServices.layout_Property_Batch_out.buyer_2_ssn;
		BatchServices.layout_Property_Batch_out.buyer_2_first_name;
		BatchServices.layout_Property_Batch_out.buyer_2_middle_name;
		BatchServices.layout_Property_Batch_out.buyer_2_last_name;
		BatchServices.layout_Property_Batch_out.buyer_2_name_suffix;
		unsigned6 seller_1_did;
		BatchServices.layout_Property_Batch_out.seller_1_ssn;
		BatchServices.layout_Property_Batch_out.seller_1_first_name;
		BatchServices.layout_Property_Batch_out.seller_1_middle_name;
		BatchServices.layout_Property_Batch_out.seller_1_last_name;
		BatchServices.layout_Property_Batch_out.seller_1_name_suffix;
		unsigned6 seller_2_did;
		BatchServices.layout_Property_Batch_out.seller_2_ssn;
		BatchServices.layout_Property_Batch_out.seller_2_first_name;
		BatchServices.layout_Property_Batch_out.seller_2_middle_name;
		BatchServices.layout_Property_Batch_out.seller_2_last_name;
		BatchServices.layout_Property_Batch_out.seller_2_name_suffix;	
		BatchServices.layout_Property_Batch_out.deed_document_type_code;
		BatchServices.layout_Property_Batch_out.deed_contract_date;
		BatchServices.layout_Property_Batch_out.deed_recording_date;	
		string45 apn;
		string4  last4APN;
		string4  year;		
		string4	 tax_year;
				
		// property info
		BatchServices.layout_Property_Batch_out.property_address1;
		BatchServices.layout_Property_Batch_out.property_address2;
		string25 property_city_name;
		BatchServices.layout_Property_Batch_out.property_st;
		BatchServices.layout_Property_Batch_out.property_zip;
		BatchServices.layout_Property_Batch_out.property_zip4;
		string8		sale_date;
		string8		prior_sale_date;
		unsigned3	sale_days_diff;
		string15	sale_amnt;
		string15	prior_sale_amnt;			
		string15	sale_amnt_diff;
		string15	sale_amnt_diff_pct;
		string15	assessment_value;		
		boolean   isSeller;
		boolean   isBuyer;
		boolean   isOwner;
		unsigned1 property_id;
		
		// subject info
		unsigned1 subject_id;
		unsigned6 subject_did;
		string70  subject_best_name;
		string75  subject_current_addr;
		string25  subject_current_city;
		string2   subject_current_state;
		string10  subject_current_zip;
		string10	subject_current_phone;
		string12	subject_ssn;
		string8		subject_dob;
		string1		subject_deceased_indicator; 
		string8		subject_dod;
		string20	subject_deceased_first;
		string20	subject_deceased_last;
		string12 	subject_deceased_ssn;
		string8		subject_deceased_dob;
		
		// input
		Autokey_batch.Layouts.rec_inBatchMaster.did;
		Autokey_batch.Layouts.rec_inBatchMaster.dob;
		Autokey_batch.Layouts.rec_inBatchMaster.ssn;
		Autokey_batch.Layouts.rec_inBatchMaster.name_first;
		Autokey_batch.Layouts.rec_inBatchMaster.name_middle;
		Autokey_batch.Layouts.rec_inBatchMaster.name_last;
		Autokey_batch.Layouts.rec_inBatchMaster.name_suffix;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_range;
		Autokey_batch.Layouts.rec_inBatchMaster.predir;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_name;
		Autokey_batch.Layouts.rec_inBatchMaster.addr_suffix;
		Autokey_batch.Layouts.rec_inBatchMaster.postdir;
		Autokey_batch.Layouts.rec_inBatchMaster.unit_desig;
		Autokey_batch.Layouts.rec_inBatchMaster.sec_range;
		Autokey_batch.Layouts.rec_inBatchMaster.p_city_name;
		Autokey_batch.Layouts.rec_inBatchMaster.st;
		Autokey_batch.Layouts.rec_inBatchMaster.z5;
		Autokey_batch.Layouts.rec_inBatchMaster.zip4;
		integer 	error_code;
	END;
			
		
end;