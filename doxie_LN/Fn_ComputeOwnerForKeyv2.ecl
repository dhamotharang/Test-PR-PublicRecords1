import LN_Propertyv2, doxie, standard,ut, NID;
//see test code at bottom
export Fn_ComputeOwnerForKeyv2(
	dataset(recordof(LN_PropertyV2.file_search_building)) searchfile,
	dataset(recordof(ln_propertyv2.File_Assessment)) assesfile,
	dataset(recordof(ln_propertyv2.File_Deed)) deedfile0,
	dataset(recordof(ln_propertyv2.file_addl_fares_deed)) addl_fares_deed
) := MODULE

shared layout_check :=
RECORD
	searchfile.ln_fares_id;
	STRING20 fname;
	STRING20 lname;
	STRING5  name_suffix;
	Standard.Addr;
	integer6 date;
END;

deedfile0_dist := distribute(deedfile0,hash(ln_fares_id));
addl_fares_deed_dist := distribute(addl_fares_deed,hash(ln_fares_id));

r1 := record
 deedfile0_dist;
 addl_fares_deed.fares_corporate_indicator;
 addl_fares_deed.fares_transaction_type;
 addl_fares_deed.fares_lender_address;
 addl_fares_deed.fares_mortgage_date;
 addl_fares_deed.fares_mortgage_deed_type;
 addl_fares_deed.fares_mortgage_term_code;
 addl_fares_deed.fares_mortgage_term;
 addl_fares_deed.fares_building_square_feet;
 addl_fares_deed.fares_foreclosure;
 addl_fares_deed.fares_refi_flag;
 addl_fares_deed.fares_equity_flag;
 addl_fares_deed.fares_iris_apn;
end;

r1 t_get_addl_deed(deedfile0 le, addl_fares_deed ri) := transform
 self := le;
 self := ri;
end;

deedfile := join(deedfile0_dist,addl_fares_deed_dist,
                 left.ln_fares_id=right.ln_fares_id,
				 t_get_addl_deed(left,right),
				 left outer,local
				);


// **** Collect clean name from search
layout_check get_search(searchfile le) :=
TRANSFORM
	SELF.fname := NID.PreferredFirstVersionedStr(le.fname, NID.version);
	SELF := le;
	SELF.addr_suffix := le.suffix;
	SELF.zip5 := le.zip;
	SELF := [];
END;
searchfile_dist := DISTRIBUTE(searchfile(source_code[2] = 'P'), HASH(ln_fares_id));
	
p_search := PROJECT(searchfile_dist(source_code[1] IN ['O','B']),get_search(LEFT));


integer6 assessdate(string recdate, string assvalueyear, string taxyear) := 
FUNCTION
	rd := (unsigned)recdate;
	ad := (unsigned)(assvalueyear+'01'+'01');
	td := (unsigned)(taxyear+'01'+'01');
	
	return max(rd, max(ad,td));
END;


// **** Collect date from assessments
assess := dedup(sort(distribute(PROJECT(assesfile, {assesfile.ln_fares_id,
		assesfile.recording_date,
		assesfile.assessed_value_year,
		assesfile.fips_code, assesfile.apna_or_pin_number,
		assesfile.tax_year}), hash(fips_code, apna_or_pin_number)),
	fips_code, apna_or_pin_number, -assessdate(recording_date, assessed_value_year, tax_year), -ln_fares_id, local),
	fips_code, apna_or_pin_number, local);

layout_check get_deed(layout_check le, assess ri) :=
TRANSFORM
	SELF.date := assessdate(ri.recording_date, ri.assessed_value_year, ri.tax_year);//IF(rec_date > tax_date, rec_date, tax_date);
	SELF := le;
END;

j_assess:= JOIN(p_search(ln_fares_id[2]='A'), DISTRIBUTE(assess, HASH(ln_fares_id)), 
									LEFT.ln_fares_id=RIGHT.ln_fares_id, get_deed(LEFT,RIGHT), LOCAL);


// **** Collect date from deeds
deed := PROJECT(deedfile, {deedfile.ln_fares_id, deedfile.recording_date, deedfile.contract_date, 
						   deedfile.fares_refi_flag, deedfile.fares_transaction_type});

layout_check get_assessment(layout_check le, deed ri) :=
TRANSFORM
	boolean isRefi := ri.fares_refi_flag = 'T' or ri.fares_transaction_type = '2';
	SELF.date := 
		IF(isRefi, -1, //refi record is last resort
			IF((unsigned)ri.contract_date=0,(unsigned)(ri.recording_date),(unsigned)ri.contract_date));
	SELF := le;
END;


j_deeds := JOIN(p_search(ln_fares_id[2]<>'A'), DISTRIBUTE(deed, HASH(ln_fares_id)), 
									LEFT.ln_fares_id=RIGHT.ln_fares_id, get_assessment(LEFT,RIGHT), LOCAL);

all_prop_wseller :=  DISTRIBUTE((j_deeds+j_assess)(prim_name<>'' AND zip5<>''), HASH(prim_name,zip5,prim_range));


// **** Remove Sellers (but do not call them a seller if they are a buyer on the same record)
sellers := join(searchfile_dist(source_code[1] = 'S'),
								searchfile_dist(source_code[1] <> 'S'),
								left.ln_fares_id = right.ln_fares_id and
								 // left.prim_name = right.prim_name and  //these lines are a potential part of the fix for bug 24002
								 // left.zip = right.zip and
								 // left.prim_range = right.prim_range and
								 // left.process_date <= right.process_date and	//seen as owner at same time or later than as seller
								ut.NameMatch(left.fname,'',left.lname,right.fname,'',right.lname) <= 2,
								left only,
								local);

//W20071213-122222 indicates that there are 43M+ SP records where prim_name, zip, and prim_range are all blank
sellers_dist := dedup(	distribute(	sellers(prim_name<>'' or zip<>'' or prim_range<>''),
																		HASH(prim_name,zip,prim_range)
																	),
												prim_name,zip,prim_range,all,local
											);
// output(sellers, named('sellers'));										
export all_prop := join(all_prop_wseller, sellers_dist,
								 left.prim_name = right.prim_name and
								 left.zip5 = right.zip and
								 left.prim_range = right.prim_range and
								 ut.NameMatch(left.fname,'',left.lname,right.fname,'',right.lname) <= 2,
								 transform(layout_check, self := left),
								 left only,
								 local);
								 
// **** Decide who the owner is
each_prop := DEDUP(SORT(all_prop, prim_name, prim_range, zip5, addr_suffix, sec_range, -date, LOCAL),
												prim_name, prim_range, zip5, addr_suffix, sec_range, LOCAL);
												
												
layout_check keepdeeds(layout_check l) := transform
	self := l;
end;



best_fids := join(all_prop, each_prop, 
				  left.prim_name = right.prim_name and 
				  left.prim_range = right.prim_range and
				  left.zip5 = right.zip5 and  
				  left.addr_suffix = right.addr_suffix and
				  left.sec_range = right.sec_range and
				  left.date = right.date, keepdeeds(left), LOCAL);


all_prop_rec := {all_prop.prim_name, all_prop.prim_range, all_prop.zip5, all_prop.predir, all_prop.postdir, all_prop.addr_suffix, all_prop.sec_range, all_prop.lname, all_prop.fname, all_prop.name_suffix};


//*********
//  IMPORTANT - THIS FUNCTION MUST RETURN A DATASET THAT IS DISTRIBUTED BY HASH(prim_name,zip5,prim_range)
//*********

// output(searchfile_dist, named('searchfile_dist'));
// output(assess, named('assess'));
// output(j_assess, named('j_assess'));
// output(deed, named('deed'));
// output(j_deeds, named('j_deeds'));

// output(all_prop, named('all_prop'));
// output(each_prop, named('each_prop'));
// output(best_fids, named('best_fids'));

export records := dedup(sort(project(best_fids, all_prop_rec),record, local),record, local);

END;