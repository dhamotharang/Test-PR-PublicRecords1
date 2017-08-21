import	Address, AID;

export Layouts_document
 :=
  module
          export 	In_Sprayed
		 :=
		   record
	string8		process_date;
	string2		vendor;
	string2		state_origin;
	string30	county_name;
	string60	official_record_key;
	string2		fips_st;
	string3		fips_county;
	string15	batch_id;
	string3		doc_serial_num;
	string25	doc_instrument_or_clerk_filing_num;
	string1		doc_num_dummy_flag;
	string8		doc_filed_dt;
	string8		doc_record_dt;
	string5		doc_type_cd;
	string60	doc_type_desc;
	string60	doc_other_desc;
	string6		doc_page_count;
	string6		doc_names_count;
	string5		doc_status_cd;
	string30	doc_status_desc;
	string5		doc_amend_cd;
	string30	doc_amend_desc;
	string8		execution_dt;
	string25	consideration_amt;
	string10	assumption_amt;
	string10	certified_mail_fee;
	string10	service_charge;
	string10	trust_amt;
	string10	transfer_;
	string10	mortgage;
	string10	intangible_tax_amt;
	string10	intangible_tax_penalty;
	string10	excise_tax_amt;
	string10	recording_fee;
	string10	documentary_stamps_fee;
	string10	doc_stamps_mtg_fee;
	string10	book_num;
	string10	page_num;
	string5		book_type_cd;
	string60	book_type_desc;
	string25	parcel_or_case_num;
	string25	formatted_parcel_num;
	string60	legal_desc_1;
	string60	legal_desc_2;
	string60	legal_desc_3;
	string60	legal_desc_4;
	string60	legal_desc_5;
	string1		verified_flag;
	string60	address_1;
	string60	address_2;
	string60	address_3;
	string60	address_4;
	string25	prior_doc_file_num;
	string5		prior_doc_type_cd;
	string60	prior_doc_type_desc;
	string10	prior_book_num;
	string10	prior_page_num;
	string5		prior_book_type_cd;
	string60	prior_book_type_desc;
	
  end
 ;
 
 export	In_Prepped
		 :=
			record
				string8					Append_Process_Date;
				In_Sprayed;
				string100				Append_Prep_Address1;
				string50				Append_Prep_AddressLast;
				AID.Common.xAID	Append_RawAID;
				Address.Layout_Clean182			Clean_Address;

			end
		 ;
		 
 export	Base
		 :=
		 record
  In_Sprayed;
  string8 Append_process_date;
string100 Append_prep_Address1;
string50 Append_prep_AddressLast;
Address.Layout_Clean182			Clean_Address;
AID.Common.xAID							Append_RawAID;
       end;
	   
	   end;