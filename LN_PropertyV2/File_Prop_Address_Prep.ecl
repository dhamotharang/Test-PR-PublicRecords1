import ut, doxie;

export File_Prop_Address_Prep(boolean isFCRA) := function

unsigned2 MAX_EMBEDDED := 100;

layout_name := record
	qstring20	fname;
	qstring20	lname;
end;

layout_fares := RECORD
  string12 ln_fare_id;
END;

myrec := record
	unsigned1	roll_count;
	string1	AD;
	boolean	occupant_owned;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	UNSIGNED4 assessed_amount;
	UNSIGNED1 property_count;
	UNSIGNED1 property_total;
	UNSIGNED5 property_owned_purchase_total;
	UNSIGNED2 property_owned_purchase_count;
	UNSIGNED5 property_owned_assessed_total;
	UNSIGNED2 property_owned_assessed_count;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	string12	ln_fares_id;
	string10 	prim_range ;
	string2  	predir ;
	string28 	prim_name ;
	string4  	suffix ;
	string2  	postdir ;
	string10 	unit_desig ;
	string8  	sec_range ;
	string25 	p_city_name ;
	string2  	st ;
	string5  	zip;
	string4	zip4;
	string3 	county;
	string7 	geo_blk;
	dataset(layout_name) buyers {MAXCOUNT (MAX_EMBEDDED)};
	dataset(layout_name) sellers {MAXCOUNT (MAX_EMBEDDED)};
  DATASET (layout_fares) fares {MAXCOUNT (MAX_EMBEDDED)};
end;

// source_code[2]='P' - property 
// ln_fares_id[1] != 'R' - FCRA compliant data
// Use FCRA boolean to determine if FARES records need to be filtered out
fdf := ln_propertyv2.File_Search_Did (source_code[2] = 'P', prim_name != '', zip != '');
fcra_df := fdf(ln_fares_id[1] != 'R');
df := if(isFCRA, fcra_df, fdf);

df2 := dedup(sort(distribute(df,hash(ln_fares_id)),
				 ln_fares_id, prim_range, prim_name, sec_range, zip, predir, postdir, suffix, lname, fname, local),
			 ln_fares_id, prim_range, prim_name, sec_range, zip, predir, postdir, suffix, lname, fname, local);
		
myrec into_myrec(df L) := transform
	self.buyers := if (L.source_code[1] = 'O', dataset([{L.fname, l.lname}],layout_name));
	self.sellers := if (L.source_code[1] = 'S', dataset([{L.fname, l.lname}],layout_name));
	self := L;
	self.roll_count := 1;
  self.fares := DATASET ([{L.ln_fares_id}], layout_fares);
	self := [];
end;

df3 := project(df2, into_myrec(LEFT));

df3 get_assessors(df3 L, ln_propertyv2.File_Assessment R) := transform
	SELF.occupant_owned 	:= r.ln_fares_id != '' and r.mailing_full_street_address=r.property_full_street_address;
	SELF.purchase_date 		:= (INTEGER)r.sale_date;
	SELF.built_date 		:= (INTEGER)r.year_built;
	SELF.purchase_amount 	:= (INTEGER)r.sales_price;
	SELF.mortgage_amount 	:= (INTEGER)r.mortgage_loan_amount;
	SELF.assessed_amount 	:= (INTEGER)r.market_total_value;
	self.AD 				:= if (R.ln_fares_id != '', 'A', '');
	self := L;
end;

// Use FCRA boolean to determine if FARES records need to be filtered out
assessments := ln_propertyv2.File_Assessment;
fcra_assessments := assessments(ln_fares_id[1] != 'R');
assessment_file :=  if(isFCRA, fcra_assessments, assessments);

with_assess := join(df3, 
		  distribute(assessment_file, hash(ln_Fares_id)),
			left.ln_fares_id = right.ln_fares_id,
		  get_assessors(LEFT,RIGHT), left outer, local);


with_assess get_deeds(with_assess L, ln_propertyv2.File_Deed R) := transform
	SELF.occupant_owned := if (r.ln_fares_id = '', l.occupant_owned, r.mailing_street=r.property_full_street_address or l.occupant_owned);
	SELF.purchase_date := (unsigned)r.contract_date;
	SELF.purchase_amount := (unsigned)r.sales_price;
	SELF.mortgage_amount := (INTEGER)r.first_td_loan_amount;
	SELF.mortgage_date := IF(r.ln_fares_id[2]='M', 
						IF(r.contract_date='', 
							(INTEGER) r.recording_date,
							(INTEGER) r.contract_date)
							,0);
	self.AD	:= if (R.ln_fares_id != '',	if (L.AD = 'A', 'M', 'D'),L.AD);
	self := L;
end;

// Use FCRA boolean to determine if FARES records need to be filtered out
deeds := Ln_propertyv2.file_deed;
fcra_deeds := deeds(ln_fares_id[1] != 'R');
deed_file := if(isFCRA, fcra_deeds, deeds);

with_deeds := join(with_assess, 
		  distribute(deed_file, hash(Ln_fares_id)),
			left.ln_fares_id = right.ln_fares_id,
		  get_deeds(LEFT,RIGHT), left outer, local);

ready_to_roll := group(sort(distribute(with_deeds, hash(prim_range, prim_name, sec_range, zip, suffix)),
						prim_range, prim_name, sec_range, zip, suffix, predir, postdir, ln_fares_id, local),
					prim_range, prim_name, sec_Range, zip, suffix, predir, postdir, local);
			

ready_to_roll pre_proc(ready_to_roll L) := transform
  self.ln_fares_id := L.ln_fares_id;
	SELF.property_count := 1;
	SELF.property_total := 1;
	SELF.property_owned_purchase_total := IF(L.purchase_amount < 1000, 0,
												L.purchase_amount);
	SELF.property_owned_purchase_count := (INTEGER)(l.purchase_amount >= 1000);
	SELF.property_owned_assessed_total := IF(l.assessed_amount < 1000, 0,
												l.assessed_amount);
	SELF.property_owned_assessed_count := (INTEGER)(l.assessed_amount >= 1000);
	self := L;
end;

really_ready_to_roll := project(ready_to_roll, pre_proc(LEFT));

myrec roll_props(really_ready_to_roll L, really_ready_to_roll R) := transform
	self.roll_count := L.roll_count + R.roll_count;
	self.buyers := L.buyers +  R.buyers;
	self.sellers := L.sellers + R.sellers;
	self.AD	:= if (L.AD = '', R.AD,
                 if (R.AD = '', L.AD,	if (L.AD != R.AD, 'M', L.AD)));
	self.occupant_owned := l.occupant_owned or R.occupant_owned;
	self.purchase_date := ut.max2(L.purchase_date, R.purchase_date);
	self.purchase_amount := ut.max2(L.purchase_amount, R.purchase_amount);
	self.mortgage_date := ut.max2(L.mortgage_date, R.mortgage_date);
	self.mortgage_amount := ut.max2(L.mortgage_amount, R.mortgage_amount);
	self.built_date := ut.max2(L.built_date, R.built_date);
	self.assessed_amount := ut.max2(L.assessed_amount, R.assessed_amount);
	SELF.property_count := 1;
	SELF.property_total := 1;
	SELF.property_owned_purchase_total := IF(self.purchase_amount < 1000, 0,
												self.purchase_amount);
	SELF.property_owned_purchase_count := (INTEGER)(self.purchase_amount >= 1000);
	SELF.property_owned_assessed_total := IF(self.assessed_amount < 1000, 0,
												self.assessed_amount);
	SELF.property_owned_assessed_count := (INTEGER)(self.assessed_amount >= 1000);
  
	self.ln_fares_id := R.ln_fares_id;
  self.fares := IF (L.ln_fares_id != R.ln_fares_id, L.fares + R.fares, L.fares);
	self := L;
end;

rolled := rollup(really_ready_to_roll, left.roll_count < MAX_EMBEDDED, roll_props(LEFT,RIGHT));
rolled_props := PROJECT (rolled, transform (myrec, SELF.ln_fares_id := ''; SELF := Left));

return rolled_props;

end;