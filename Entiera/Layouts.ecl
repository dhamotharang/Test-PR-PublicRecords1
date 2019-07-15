import	Address, AID;

export Layouts
 :=
  module

		export 	In_Sprayed
		 :=
			record,maxlength(Constants.InFileCSVMaxLength)
				string		orig_pmghousehold_id;
				string		orig_pmgindividual_id;
				string		orig_first_name;
				string		orig_last_name;
				string		orig_address;
				string		orig_city;
				string		orig_state;
				string		orig_zip;
				string		orig_zip4;
				string		orig_email;
				string		orig_ip;
				string		orig_login_date;
				string		orig_site;
				string		orig_source;
				string		orig_e360_id;
				string		orig_teramedia_id;
			end
		 ;

		export	In_Prepped
		 :=
			record,maxlength(Constants.PrepFileCSVMaxLength)
				string8					Append_Process_Date;
				In_Sprayed;
				string100				Append_Prep_Address1;
				string50				Append_Prep_AddressLast;
				AID.Common.xAID	Append_RawAID;
			end
		 ;

		export	Base
		 :=
			record,maxlength(Constants.BaseFileMaxLength)
				string			orig_pmghousehold_id;
				string			orig_pmgindividual_id;
				string			orig_first_name;
				string			orig_last_name;
				string			orig_address;
				string			orig_city;
				string			orig_state;
				string5			orig_zip;
				string4			orig_zip4;
				string			orig_email;
				string			orig_ip;
				string			orig_login_date;
				string8			ln_login_date; //orig_login_date formatted to CCYYMMDD (Bug# 51741)
				string			orig_site;
//				string			orig_source;
				string			orig_e360_id;
				string			orig_teramedia_id;
				string100		Append_Prep_Address1;
				string50		Append_Prep_AddressLast;
				unsigned6		did;
				unsigned8		did_score;
				Address.Layout_Clean_Name		Clean_Name;
				Address.Layout_Clean182			Clean_Address;
				AID.Common.xAID							Append_RawAID;
				string9			best_ssn;
				unsigned4		best_dob;
				string8			process_date;
				string8			date_first_seen;
				string8			date_last_seen;
				string8			date_vendor_first_reported;
				string8			date_vendor_last_reported;
				BOOLEAN 		current_rec;
			end
		 ;

		export	Entiera_Final_Layout	:=	Base;

		export	Base_For_Indexes
		 :=
			record
				Base and not [Append_Prep_Address1, 
											Append_Prep_AddressLast, 
											Append_RawAID, 
											date_first_seen, 
											date_last_seen, 
											date_vendor_first_reported, 
											date_vendor_last_reported,
											ln_login_date
										 ];
			end
		 ;

	end
 ;