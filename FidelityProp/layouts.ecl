import standard;
export layouts := 
MODULE

export from_prop := record
	string parcel__number_1;
  string name__owner__1_1;
  string name__owner__2_1;
	
	//these from result of compute owner function
  string prop__address_1;
  string prop__city_1;
  string prop__state_1;
  string prop__zipcode_1;
	
	
  string total__value_1;
  string sale__date_1;
	string recording__date_1;  
	string sale__price_1;
	string name__seller_1;
	string name__seller_2_1;
  string mortgage__amount_1;
  string assessed__value_1;
  string total__market__value_1;
	string tax_year_1;
	string assessed_value_year_1;
  string legal__description_1;
	string fares_transaction_type_code;
	string fares_transaction_type;
	string first_td_loan_type_code ; 
	string Fidelity_transaction_type; 
	string county_code;
	string county;
end;

export from_prop_fid_old := record
	from_prop;
	string20 ln_fares_id;
	Standard.Addr.prim_range;
	Standard.Addr.prim_name;
	Standard.Addr.predir;
	Standard.Addr.sec_range;
	Standard.Addr.zip5;
	string25 fname;
	string25 mname;
	string25 lname;
	string25 acctno;
	unsigned4 date;
	string20 deed_ln_fares_id;
	string20 assessor_ln_fares_id;
end;

export from_prop_fid := record(from_prop_fid_old)
  unsigned6 owner_1_did;
  unsigned6 owner_2_did;
  unsigned6 seller_1_did;
	unsigned6 seller_2_did;
end;

export from_prop_fid_dob := record(from_prop_fid)
  string8 owner_1_dob_voter;
  string8 owner_1_dob_proflic;
  string8 owner_1_dob_ccw;
  string8 owner_1_dob_hunt;
	string8  owner_1_dob_crim; 
	
  string8 owner_2_dob_voter;
  string8 owner_2_dob_proflic;
  string8 owner_2_dob_ccw;
  string8 owner_2_dob_hunt;
	string8 owner_2_dob_crim;
	
  string8 seller_1_dob_voter;
  string8 seller_1_dob_proflic;
  string8 seller_1_dob_ccw;
  string8 seller_1_dob_hunt;
	string8 seller_1_dob_crim;
	
	string8 seller_2_dob_voter;
  string8 seller_2_dob_proflic;
  string8 seller_2_dob_ccw;
  string8 seller_2_dob_hunt;
	string8 seller_2_dob_crim;
end;

export from_phone := record
	string subj_first_1;
	string subj_middle_1;	
	string subj_last_1;
	string subj_suffix_1;
	string subj_phone10_1;
	string subj_name__dual_1;
	string subj_phone_type_1;
	string subj_date_first_1;
	string subj_date_last_1;
end;

export from_phone_plus := record
	from_phone;
	string25 acctno;
end;

export out := record
	from_prop;
  string parcel__number_2			:='';
  string name__owner__1_2			:='';
  string name__owner__2_2			:='';
  string prop__address_2			:='';
  string prop__city_2			:='';
  string prop__state_2			:='';
  string prop__zipcode_2			:='';
  string total__value_2			:='';
  string sale__date_2			:='';
	string recording__date_2	:='';
  string sale__price_2			:='';
  string name__seller_2			:='';
  string mortgage__amount_2			:='';
  string assessed__value_2			:='';
  string total__market__value_2	:='';
	string tax_year_2						:='';
	string assessed_value_year_2		:='';
  string legal__description_2	:='';
  string parcel__number_3			:='';
  string name__owner__1_3			:='';
  string name__owner__2_3			:='';
  string prop__address_3			:='';
  string prop__city_3			:='';
  string prop__state_3			:='';
	string prop__zipcode_3			:='';
	string total__value_3			:='';
	string sale__date_3			:='';
	string recording__date_3	:='';
	string sale__price_3			:='';
	string name__seller_3			:='';
	string mortgage__amount_3			:='';
	string assessed__value_3			:='';
	string total__market__value_3			:='';
	string tax_year_3						:='';
	string assessed_value_year_3		:='';	
	string legal__description_3			:='';
	string parcel__number_4			:='';
	string name__owner__1_4			:='';
	string name__owner__2_4			:='';
	string prop__address_4			:='';
	string prop__city_4			:='';
	string prop__state_4			:='';
	string prop__zipcode_4			:='';
	string total__value_4			:='';
	string sale__date_4			:='';
	string recording__date_4	:='';
	string sale__price_4			:='';
	string name__seller_4			:='';
	string mortgage__amount_4			:='';
	string assessed__value_4			:='';
	string total__market__value_4	:='';
	string tax_year_4						:='';
	string assessed_value_year_4		:='';	
	string legal__description_4		:='';
	from_phone;
END;

export out_dob := record(out)
  unsigned6 owner_1_did;
  string8 owner_1_dob_voter;
  string8 owner_1_dob_proflic;
  string8 owner_1_dob_ccw;
  string8 owner_1_dob_hunt;
	string8 owner_1_dob_crim;
	
  unsigned6 owner_2_did;
  string8 owner_2_dob_voter;
  string8 owner_2_dob_proflic;
  string8 owner_2_dob_ccw;
  string8 owner_2_dob_hunt;
	string8 owner_2_dob_crim;

  unsigned6 seller_1_did;
  string8 seller_1_dob_voter;
  string8 seller_1_dob_proflic;
  string8 seller_1_dob_ccw;
  string8 seller_1_dob_hunt;
	string8 seller_1_dob_crim;

  unsigned6 seller_2_did;
  string8 seller_2_dob_voter;
  string8 seller_2_dob_proflic;
  string8 seller_2_dob_ccw;
  string8 seller_2_dob_hunt;
	string8 seller_2_dob_crim;
end;
//only crim dob should be allowed for now...
export out_dob_crim := record //(out) rename fares_transaction_type to transaction type. 
   string parcel__number_1;
   string name__owner__1_1;
   string name__owner__2_1;
   string prop__address_1;
   string prop__city_1;
   string prop__state_1;
   string prop__zipcode_1;
   string total__value_1;
   string sale__date_1;
	 string recording__date_1;
   string sale__price_1;
   string name__seller_1;
   string mortgage__amount_1;
   string assessed__value_1;
   string total__market__value_1;
	 string tax_year_1;
	 string assessed_value_year_1;
   string legal__description_1;
   string transaction_type_code;
   string transaction_type;
  // string first_td_loan_type_code;
  // string fidelity_transaction_type;
   string county_code;
   string county;
   string parcel__number_2;
   string name__owner__1_2;
   string name__owner__2_2;
   string prop__address_2;
   string prop__city_2;
   string prop__state_2;
   string prop__zipcode_2;
   string total__value_2;
   string sale__date_2;
	 string recording__date_2;
   string sale__price_2;
   string name__seller_2;
   string mortgage__amount_2;
   string assessed__value_2;
   string total__market__value_2;
	 string tax_year_2;
	 string assessed_value_year_2;
   string legal__description_2;
   string parcel__number_3;
   string name__owner__1_3;
   string name__owner__2_3;
   string prop__address_3;
   string prop__city_3;
   string prop__state_3;
   string prop__zipcode_3;
   string total__value_3;
   string sale__date_3;
	 string recording__date_3;
   string sale__price_3;
   string name__seller_3;
   string mortgage__amount_3;
   string assessed__value_3;
   string total__market__value_3;
	 string tax_year_3;
	 string assessed_value_year_3; 
   string legal__description_3;
   string parcel__number_4;
   string name__owner__1_4;
   string name__owner__2_4;
   string prop__address_4;
   string prop__city_4;
   string prop__state_4;
   string prop__zipcode_4;
   string total__value_4;
   string sale__date_4;
	 string recording__date_4;
   string sale__price_4;
   string name__seller_4;
   string mortgage__amount_4;
   string assessed__value_4;
   string total__market__value_4;
	 string tax_year_4;
	 string assessed_value_year_4; 
   string legal__description_4;
   string subj_first_1;
   string subj_middle_1;
   string subj_last_1;
   string subj_suffix_1;
   string subj_phone10_1;
   string subj_name__dual_1;
   string subj_phone_type_1;
   string subj_date_first_1;
   string subj_date_last_1;
   string owner_1_dob_crim;
	 string owner_2_dob_crim;
   //added 10/2/2013; include DIDs to output. Per customer, we should not disclose fieldname as LN's LexID	 
   string owner_1_did;
   string owner_2_did;
   string seller_1_did;
	 string seller_1_dob_crim;
	 string name__seller_2_1; 
	 string seller_2_dob_crim;
	 string seller_2_did;
end; 


END;