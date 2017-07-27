Import ut,property,header;

#workunit ('name', 'LT Run');
// Change following:
//
// Change the cut off date in property.Lending_Tree_Deeds
// Change the input file name in Lending_Tree.File_LT_Input
// Change the output file name for DFU


h := dataset('~thor_data400::base::header',header.Layout_Header,flat);


MyFields := record	
    string9  ssn;
	string20 fname;
	string20 mname;
	string20 lname;
    string5  name_suffix;
    string10 prim_range;
    string28 prim_name;
    string4  suffix;
    string5  zip;
end;

MyFields slim_hdr_tr(h lef) := transform
	self := lef;
end;

slim_hdr := project(h,slim_hdr_tr(left));
dist_file := DISTRIBUTE(slim_hdr(ssn<>''), hash(ssn));
dist_input := distribute(Lending_Tree.File_LT_Input, hash(ssn));

after_hdr_match := record
	Lending_Tree.Layout_LT_Input;
	string20 hdr_fname;
	string20 hdr_mname;
	string20 hdr_lname;
    string5  hdr_name_suffix;
	string10 hdr_prim_range;
    string28 hdr_prim_name;
    string4  hdr_suffix;
    string5  hdr_zip;	
end;

after_hdr_match join_to_header(dist_file hdr, dist_input lt) := transform
	self.hdr_fname := hdr.fname;
	self.hdr_mname := hdr.mname;
	self.hdr_lname := hdr.lname;
	self.hdr_name_suffix := hdr.name_Suffix;
	self.hdr_prim_range := hdr.prim_range;
	self.hdr_prim_name := hdr.prim_name;
	self.hdr_suffix := hdr.suffix;
	self.hdr_zip := hdr.zip;
	self := lt;
end;

joined_file := join(dist_file, dist_input,
					left.ssn = right.ssn, 
					join_to_header(left,right), RIGHT OUTER, local);

d1 := distribute(property.Lending_Tree_Deeds, hash(prop_zip, prop_prim_name, prop_prim_range, prop_suffix));
h1 := distribute(joined_file(hdr_zip<>'' or hdr_prim_name <>''), hash(hdr_zip, hdr_prim_name, hdr_prim_range, hdr_suffix));


after_deed_join := record
   joined_file;
   string30 	owner_buyer_last_name;
   string10 	owner_house_number;
   string2 	owner_street_direction;
   string30 	owner_street_name;
   string5 	owner_mode;
   string40 	owner_city;
   string2 	owner_state;
   string9 	owner_zip_code;
   string10 	prop_house_number;
   string30 	prop_street_name;
   string5 	prop_mode;
   string2 	prop_direction;
   string40 	prop_city;
   string2 	prop_state;
   string9 	prop_property_address_zip_code_;
   string11 	mortgage_amount;
   string8 	sale_date_yyyymmdd;
   string8 	recording_date_yyyymmdd;
   string12 	book_page_6x6;
   string30 	lender_last_name;
   string60 	lender_address;
   string1 	sale_code;
   string3 	sales_transaction_code;
   string8 	mortgage_date;
   string5 	mortgage_loan_type_code;
   string6 	mortgage_deed_type;
   string5 	nd_mortgage_loan_type_code;
   string6 	nd_deed_type;
   string1 	seller_carry_back;
   string1 	private_party_lender;
   string1 	construction_loan;
   string1 	resale_new_construction_m_resale_n_;
   string1 	inter_family;
   string1 	cash_mortgage_purchase_q_cash_r_mor;
   string1 	foreclosure;
   string1 	refi_flag;
   string1 	equity_flag;
end;

	

after_deed_join j_stuff (d1 l, h1 r) := TRANSFORM
    self.nd_mortgage_loan_type_code := l.second_mortgage_loan_type_code;
    self.nd_deed_type := l.second_deed_type;
    self := l;
	self := r;
end;


j1 := join(d1, h1, left.prop_zip = right.hdr_zip AND left.prop_prim_name = right.hdr_prim_name AND
				   left.prop_prim_range = right.hdr_prim_range AND left.prop_suffix = right.hdr_suffix
				 ,j_stuff(left,right), local);


Layout_LT_scored := record
	j1;
    integer1 score1;
end;

Layout_LT_scored add_scores (j1 l) := TRANSFORM
    self.score1 := 100 - ut.CompanySimilar100(l.lender_last_name, l.lender_name);
	self := l;
end;

LT_Out := PROJECT(j1(prop_house_number<>'' and 
					 prop_street_name <>'' and 
				     lender_last_name<>'' and 
					 trim(stringlib.StringToUpperCase(lname)) = trim(stringlib.StringToUpperCase(owner_buyer_last_name)) and 
					 (integer)mortgage_date > 0), add_scores(left));

output(LT_Out);
output(LT_Out,,'OUT::LT_OUT_20050822',overwrite)