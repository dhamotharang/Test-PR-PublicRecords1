import ln_property, ut;

// R = fares data, can't use
// D = Deed record
// P = Property record
search_file := LN_Property.File_Search(ln_fares_id[1]!='R'  and ln_fares_id[2] = 'D' and source_code[2] = 'P' and (integer)zip <> 0);  // search file, deed records
sfd := distribute(search_file, hash(ln_fares_id));
						
layout_clean_deed := record
	string12 ln_fares_id;
	string45  unformatted_apn;
	
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  zip;
	STRING4  zip4;
	STRING10 lat := '';
	STRING11 long := '';
	string7  geo_blk := '';
	
	string5 fips_code;
	string4 land_use_code;
	string11 sales_price;
	string8 recording_date;	
end;

deed_file := ln_property.File_Deed(ln_fares_id[1]!='R' and 
								state in avm.filters.valid_states and 
								avm.filters.valid_date(recording_date) and
								first_td_loan_type_code not in avm.filters.bad_loan_type_codes and
								(integer)sales_price> avm.filters.minimum_sale_price								
								and recording_date <= avm.filters.history_date
								
								);
deed_base := distribute(deed_file, hash(ln_fares_id));


layout_clean_deed clean_deed(deed_base le, sfd rt) := transform
	self.ln_fares_id := le.ln_fares_id;
	self.unformatted_apn := avm.filters.stripformat(le.apnt_or_pin_number);
	self.fips_code := le.fips_code;
	self.land_use_code := le.assessment_match_land_use_code;
	self.sales_price := le.sales_price;
	self.recording_date := le.recording_date;
	self := rt;
end;

// append the clean address and clean the apn to use for linking to assessment records
deed_slim1 := join(deed_base, sfd, left.ln_fares_id=right.ln_fares_id, clean_deed(left,right), left outer, keep(1), local);

// pull out the records with blank address and apns before the distribute and join
deed_blanks := deed_slim1(trim(prim_range)='' and trim(prim_name)='' and trim(sec_range)='' and trim(zip)='' and trim(unformatted_apn)='');
deed_slim1a := deed_slim1(prim_range<>'' or prim_name<>'' or sec_range<>'' or zip<>'' or unformatted_apn<>'');


assessment_slim1 := avm.File_AVM_Assessments;

deed_slim := distribute(deed_slim1a, hash(zip,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,unformatted_apn));
assessment_slim := distribute(assessment_slim1, hash(zip,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,unformatted_apn));

// impute the land_use_codes from the assessment file on any record that's missing the land_use on the deeds file
deed_land_use := join(deed_slim, assessment_slim,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						ut.nneq(left.unit_desig,right.unit_desig) and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
						transform(layout_clean_deed, 
								  self.land_use_code := if(left.land_use_code='', right.land_use_code, left.land_use_code),
								  self := left),
						left outer, keep(1), local) : persist('temp::avm::deeds');  
						

export File_AVM_Deeds := deed_land_use;