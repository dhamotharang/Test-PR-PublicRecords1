Import Ln_propertyV2, ut, lib_DataLib, LN_PropertyV2_Fast;

Integer cutoff_date := 20141001;
//Integer cutoff_date := 20140101;
//process originally pulled in clean address from the beforemapping dataset.
//however i see that a lot of records have the clean address empty
//for some reason though our search base file those same ln_fares_id's have the clean address present

fares_search_prop         := Dedup( Sort( Distribute(ln_propertyv2.File_Search_DID(vendor_source_flag in ['F','S'] and source_code[2]='P' and prim_name<>'' and zip<>''), Hash(ln_fares_id)),ln_fares_id, Local),ln_fares_id, Local);
fares_search_mail         := Dedup( Sort( Distribute(ln_propertyv2.File_Search_DID(vendor_source_flag in ['F','S'] and source_code  ='OO' and prim_name<>'' and zip<>''), Hash(ln_fares_id)),ln_fares_id, Local),ln_fares_id, Local);
fares__addl__deed         := Dedup( Sort( Distribute(ln_propertyv2.File_addl_fares_deed, Hash(ln_fares_id)),ln_fares_id, Local),ln_fares_id, Local);

fares_deed 								:= DISTRIBUTE(LN_PropertyV2.File_Deed(vendor_source_flag in ['F','S'] and (integer)recording_date>=cutoff_date) , Hash(ln_fares_id));


// map from fares and owner property
{Lending_Tree.Layout_LT_Deeds, string12 ln_fares_id} map_op(fares_deed le, fares_search_prop ri) := transform

		self.did 							:= (unsigned8) ri.did;
		self.pref_Fname 			:= If(DataLib.PreferredFirstNew(ri.fname, true) <> '', ut.fnTrim2Upper(DataLib.PreferredFirstNew(ri.fname, true)), ''); 
		self.prop_prim_range 	:= ri.prim_range;
		self.prop_prim_name  	:= ri.prim_name;
		self.prop_suffix     	:= ri.suffix;
		self.prop_zip        	:= ri.zip;
		self.lname 						:= ri.lname;
		self.fname 						:= ri.fname;
		self.mname 						:= ri.mname;
		
		self.mortgage_amount 					:= le.first_td_loan_amount;
    self.sale_date_yyyymmdd 			:= le.contract_date;
    self.recording_date_yyyymmdd 	:= le.recording_date;
    self.book_page_6x6 						:= le.recorder_book_number;
		self.sale_code 								:= le.sales_price_code;
		self.mortgage_loan_type_code 	:= le.first_td_loan_type_code;
		self.lender_last_name 				:= le.lender_name;             // this will include the original lender_last_name + lender_first_name

		self.owner_house_number 		:= ri.prim_range;		// original concatenated into mailing_street. This is from clean address
		self.owner_street_direction := ri.postdir;			// original concatenated into mailing_street. This is from clean address
		self.owner_street_name 			:= ri.prim_name;		// original concatenated into mailing_street. This is from clean address
	  self.owner_mode 						:= ri.suffix;				// original concatenated into mailing_street. This is from clean address
    self.owner_city 						:= ri.p_city_name;	// original concatenated into mailing_csz.    This is from clean address
    self.owner_state 						:= le.state;				// original concatenated into mailing_csz.    This is from clean address
    self.owner_zip_code 				:= ri.zip;					// original concatenated into mailing_csz.    This is from clean address
		
		self             						:= le;
		self												:= [];
		
end;
with_op 			 			:= Join(fares_deed,fares_search_prop,Left.ln_fares_id=Right.ln_fares_id,map_op(Left, Right),Left Outer, Local);

// map from owner maling
{Lending_Tree.Layout_LT_Deeds, string12 ln_fares_id} map_oo(with_op le, fares_search_mail ri) := transform

		self.prop_house_number								:= ri.prim_range;	// original concatenated to property_full_street_address. This is from clean address
    self.prop_street_name 								:= ri.prim_name;	// original concatenated to property_full_street_address. This is from clean address
    self.prop_mode 												:= ri.suffix;			// original concatenated to property_full_street_address. This is from clean address
    self.prop_direction 									:= ri.postdir;		// original concatenated to property_full_street_address. This is from clean address
    self.prop_city 												:= ri.p_city_name;// original concatenated to property_address_citystatezip. This is from clean address
    self.prop_state 											:= ri.st;					// original concatenated to property_address_citystatezip. This is from clean address
		self.prop_property_address_zip_code_ 	:= ri.zip;				// original concatenated to property_address_citystatezip. This is fromhe clean address
		self             											:= le;
		self																	:= [];
end;
with_op_and_oo 			:= Join(with_op,fares_search_mail,Left.ln_fares_id=Right.ln_fares_id,map_oo(Left, Right),Left Outer, Local);

// map from additional fares
Lending_Tree.Layout_LT_Deeds map_ad(with_op_and_oo le, fares__addl__deed ri) := transform

		self.lender_address 					 					 	:= ri.fares_lender_address;
    self.sales_transaction_code 		 					:= ri.fares_sales_transaction_code;
    self.mortgage_date 							 					:= ri.fares_mortgage_date;
    self.mortgage_deed_type 				 					:= ri.fares_mortgage_deed_type;
    self.second_mortgage_loan_type_code 			:= ri.fares_second_mortgage_loan_type_code;
    self.second_deed_type 				 						:= ri.fares_second_deed_type;
    self.seller_carry_back 				 					 	:= '';	// DROPPED, BUT SEE SALT STATS FROM FEB/2014: 
																											// <blank> 316M, <?> 156M, <A> 3.3M, <Y> 21K <-- the field does not appear to be densely populated
    self.private_party_lender 			 					:= ri.fares_private_party_lender;
    self.construction_loan 					 					:= ri.fares_construction_loan;
    self.resale_new_construction_m_resale_n_ 	:= ri.fares_resale_new_construction;
    self.inter_family  					 							:= ri.fares_inter_family;
    self.cash_mortgage_purchase_q_cash_r_mor	:= ri.fares_cash_mortgage_purchase;
    self.foreclosure  					 							:= ri.fares_foreclosure;
    self.refi_flag  					 								:= ri.fares_refi_flag;
    self.equity_flag  					 							:= ri.fares_equity_flag;
		self              					 							:= le;
end;

Export File_LT_Deeds := Join(with_op_and_oo,fares__addl__deed,Left.ln_fares_id=Right.ln_fares_id,map_ad(Left, Right),Left Outer, Local);