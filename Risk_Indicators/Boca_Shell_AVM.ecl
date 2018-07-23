import _Control, avm_V2, riskwise, ut;
onThor := _Control.Environment.OnThor;

export Boca_Shell_AVM(GROUPED DATASET(layout_bocashell_neutral) ids_wide) := FUNCTION

Layout_AVM := RECORD
	unsigned4 seq;
	unsigned3 historydate;
	Riskwise.Layouts.Layout_AVM;
END;

Layout_AVM_Plus := RECORD
	Layout_Address_Information Address_History_1;
	Layout_Address_Information Address_History_2;
	Layout_AVM AVM;
END;



Layout_AVM_Plus add_AVM(ids_wide le, avm_v2.Key_AVM_Address ri) := transform
	full_history_date := iid_constants.full_history_date(le.historydate);
	AVM_V2.MOD_get_AVM_from_History.MAC_get_AVM(ri, full_history_date, avm_record);	// updated to get full history
	
	SELF.AVM.Input_Address_Information.avm_land_use_code := avm_record.land_use;
	SELF.AVM.Input_Address_Information.avm_recording_date := avm_record.recording_date;
	SELF.AVM.Input_Address_Information.avm_assessed_value_year := avm_record.assessed_value_year;
	SELF.AVM.Input_Address_Information.avm_sales_price := avm_record.sales_price;  
	SELF.AVM.Input_Address_Information.avm_assessed_total_value := avm_record.assessed_total_value;
	SELF.AVM.Input_Address_Information.avm_market_total_value := avm_record.market_total_value;
	SELF.AVM.Input_Address_Information.avm_tax_assessment_valuation := avm_record.tax_assessment_valuation;
	SELF.AVM.Input_Address_Information.avm_price_index_valuation := avm_record.price_index_valuation;
	SELF.AVM.Input_Address_Information.avm_hedonic_valuation := avm_record.hedonic_valuation;
	SELF.AVM.Input_Address_Information.avm_automated_valuation := avm_record.automated_valuation;
	SELF.AVM.Input_Address_Information.avm_confidence_score := avm_record.confidence_score;
	
	// new fields
	SELF.AVM.Input_Address_Information.avm_automated_valuation2 := avm_record.automated_valuation2;
	SELF.AVM.Input_Address_Information.avm_automated_valuation3 := avm_record.automated_valuation3;
	SELF.AVM.Input_Address_Information.avm_automated_valuation4 := avm_record.automated_valuation4;
	SELF.AVM.Input_Address_Information.avm_automated_valuation5 := avm_record.automated_valuation5;
	SELF.AVM.Input_Address_Information.avm_automated_valuation6 := avm_record.automated_valuation6;
	
	SELF.address_history_1 := le.address_verification.address_history_1;
	SELF.address_history_2 := le.address_verification.address_history_2;
	SELF.avm.seq := le.seq;
	self.avm.historydate := le.historydate;
END;
avm1_roxie := join(ids_wide, avm_v2.Key_AVM_Address,  
							left.address_verification.input_address_information.prim_name!='' and left.address_verification.input_address_information.zip5!='' and
							keyed(left.address_verification.input_address_information.prim_name = right.prim_name) and
							keyed(left.address_verification.input_address_information.st = right.st) and
							keyed(left.address_verification.input_address_information.zip5 = right.zip) and
							keyed(left.address_verification.input_address_information.prim_range = right.prim_range) and
							keyed(left.address_verification.input_address_information.sec_range = right.sec_range) and	// NNEQ here?
							left.address_verification.input_address_information.predir=right.predir and 
							left.address_verification.input_address_information.postdir=right.postdir,
						add_AVM(left, right), left outer, 
								atmost(	left.address_verification.input_address_information.prim_name=right.prim_name and
												left.address_verification.input_address_information.st=right.st and
												left.address_verification.input_address_information.zip5=right.zip and 
												left.address_verification.input_address_information.prim_range=right.prim_range and
												left.address_verification.input_address_information.sec_range=right.sec_range, riskwise.max_atmost), keep(100));
avm1_thor := join(
	distribute(ids_wide, hash64(address_verification.input_address_information.prim_name,
															address_verification.input_address_information.st,
															address_verification.input_address_information.zip5,
															address_verification.input_address_information.prim_range)), 
	distribute(pull(avm_v2.Key_AVM_Address), hash64(prim_name, st, zip, prim_range)),  
							left.address_verification.input_address_information.prim_name!='' and left.address_verification.input_address_information.zip5!='' and
							left.address_verification.input_address_information.prim_name = right.prim_name and
							left.address_verification.input_address_information.st = right.st and
							left.address_verification.input_address_information.zip5 = right.zip and
							left.address_verification.input_address_information.prim_range = right.prim_range and
							left.address_verification.input_address_information.sec_range = right.sec_range and	// NNEQ here?
							left.address_verification.input_address_information.predir=right.predir and 
							left.address_verification.input_address_information.postdir=right.postdir,
						add_AVM(left, right), left outer, 
								atmost(riskwise.max_atmost), keep(100), 
				local);

#IF(onThor)
	avm1 := avm1_thor;
#ELSE
	avm1 := ungroup(avm1_roxie); // to get both sides of the branch to have same grouping, remove group here.  grouping the dataset below by avm.seq
#END

// when choosing which AVM to output if the addr returns more than 1 result, 
// always pick the record with the most recent recording date and secondarily the most recent assessed value year
all_avms1 := group(sort(avm1, avm.seq, -AVM.Input_Address_Information.avm_recording_date, -AVM.Input_Address_Information.avm_assessed_value_year), avm.seq);
avms1 := rollup(all_avms1, true, transform(Layout_AVM_Plus, self := left));


Layout_AVM_Plus add_AVM2(Layout_AVM_Plus le, avm_v2.Key_AVM_Address ri) := transform
	full_history_date := iid_constants.full_history_date(le.avm.historydate);
	AVM_V2.MOD_get_AVM_from_History.MAC_get_AVM(ri, full_history_date, avm_record);
	
	SELF.AVM.Address_History_1.avm_land_use_code := avm_record.land_use;
	SELF.AVM.Address_History_1.avm_recording_date := avm_record.recording_date;
	SELF.AVM.Address_History_1.avm_assessed_value_year := avm_record.assessed_value_year;
	SELF.AVM.Address_History_1.avm_sales_price := avm_record.sales_price;  
	SELF.AVM.Address_History_1.avm_assessed_total_value := avm_record.assessed_total_value;
	SELF.AVM.Address_History_1.avm_market_total_value := avm_record.market_total_value;
	SELF.AVM.Address_History_1.avm_tax_assessment_valuation := avm_record.tax_assessment_valuation;
	SELF.AVM.Address_History_1.avm_price_index_valuation := avm_record.price_index_valuation;
	SELF.AVM.Address_History_1.avm_hedonic_valuation := avm_record.hedonic_valuation;
	SELF.AVM.Address_History_1.avm_automated_valuation := avm_record.automated_valuation;
	SELF.AVM.Address_History_1.avm_confidence_score := avm_record.confidence_score;
	
		// new fields
	SELF.AVM.Address_History_1.avm_automated_valuation2 := avm_record.automated_valuation2;
	SELF.AVM.Address_History_1.avm_automated_valuation3 := avm_record.automated_valuation3;
	SELF.AVM.Address_History_1.avm_automated_valuation4 := avm_record.automated_valuation4;
	SELF.AVM.Address_History_1.avm_automated_valuation5 := avm_record.automated_valuation5;
	SELF.AVM.Address_History_1.avm_automated_valuation6 := avm_record.automated_valuation6;
	
	self := le;
END;
avm2_roxie := join(avms1, avm_v2.Key_AVM_Address,  
							left.address_history_1.prim_name!='' and left.address_history_1.zip5!='' and
							keyed(left.address_history_1.prim_name = right.prim_name) and
							keyed(left.address_history_1.st = right.st) and
							keyed(left.address_history_1.zip5 = right.zip) and
							keyed(left.address_history_1.prim_range = right.prim_range) and
							keyed(left.address_history_1.sec_range = right.sec_range) and	// NNEQ here?
							left.address_history_1.predir=right.predir and 
							left.address_history_1.postdir=right.postdir,
						add_AVM2(left, right), left outer, 
								atmost(	left.address_history_1.prim_name=right.prim_name and
												left.address_history_1.st=right.st and
												left.address_history_1.zip5=right.zip and 
												left.address_history_1.prim_range=right.prim_range and
												left.address_history_1.sec_range=right.sec_range, riskwise.max_atmost), keep(100));

avm2_thor := join(
distribute(avms1, hash64(address_history_1.prim_name,
													address_history_1.st,
													address_history_1.zip5,
													address_history_1.prim_range)), 
distribute(pull(avm_v2.Key_AVM_Address), hash64(prim_name, st, zip, prim_range)),
							left.address_history_1.prim_name!='' and left.address_history_1.zip5!='' and
							left.address_history_1.prim_name = right.prim_name and
							left.address_history_1.st = right.st and
							left.address_history_1.zip5 = right.zip and
							left.address_history_1.prim_range = right.prim_range and
							left.address_history_1.sec_range = right.sec_range and	// NNEQ here?
							left.address_history_1.predir=right.predir and 
							left.address_history_1.postdir=right.postdir,
						add_AVM2(left, right), left outer, 
								atmost(riskwise.max_atmost), keep(100),
	local);

#IF(onThor)
	avm2 := avm2_thor;
#ELSE
	avm2 := ungroup(avm2_roxie); // to get both sides of the branch to have same grouping, remove group here.  grouping the dataset below by avm.seq
#END
												

// when choosing which AVM to output if the addr returns more than 1 result, 
// always pick the record with the most recent recording date and secondarily the most recent assessed value year
all_avms2 := group(sort(avm2, avm.seq, -AVM.address_history_1.avm_recording_date, -AVM.address_history_1.avm_assessed_value_year), avm.seq);

avms2 := rollup(all_avms2, true, transform(Layout_AVM_Plus, self := left));


Layout_AVM add_AVM3(Layout_AVM_Plus le, avm_v2.Key_AVM_Address ri) := transform
	full_history_date := iid_constants.full_history_date(le.avm.historydate);
	AVM_V2.MOD_get_AVM_from_History.MAC_get_AVM(ri, full_history_date, avm_record);

	SELF.Address_History_2.avm_land_use_code := avm_record.land_use;
	SELF.Address_History_2.avm_recording_date := avm_record.recording_date;
	SELF.Address_History_2.avm_assessed_value_year := avm_record.assessed_value_year;
	SELF.Address_History_2.avm_sales_price := avm_record.sales_price;  
	SELF.Address_History_2.avm_assessed_total_value := avm_record.assessed_total_value;
	SELF.Address_History_2.avm_market_total_value := avm_record.market_total_value;
	SELF.Address_History_2.avm_tax_assessment_valuation := avm_record.tax_assessment_valuation;
	SELF.Address_History_2.avm_price_index_valuation := avm_record.price_index_valuation;
	SELF.Address_History_2.avm_hedonic_valuation := avm_record.hedonic_valuation;
	SELF.Address_History_2.avm_automated_valuation := avm_record.automated_valuation;
	SELF.Address_History_2.avm_confidence_score := avm_record.confidence_score;
	
		// new fields 
	SELF.Address_History_2.avm_automated_valuation2 := avm_record.automated_valuation2;
	SELF.Address_History_2.avm_automated_valuation3 := avm_record.automated_valuation3;
	SELF.Address_History_2.avm_automated_valuation4 := avm_record.automated_valuation4;
	SELF.Address_History_2.avm_automated_valuation5 := avm_record.automated_valuation5;
	SELF.Address_History_2.avm_automated_valuation6 := avm_record.automated_valuation6;
	
	self.input_address_information := le.avm.input_address_information;
	self.address_history_1 := le.avm.address_history_1;
	self.seq := le.avm.seq;
	self.historydate := le.avm.historydate;
END;
avm3_roxie := join(avms2, avm_v2.Key_AVM_Address,  
							left.address_history_2.prim_name!='' and left.address_history_2.zip5!='' and
							keyed(left.address_history_2.prim_name = right.prim_name) and
							keyed(left.address_history_2.st = right.st) and
							keyed(left.address_history_2.zip5 = right.zip) and
							keyed(left.address_history_2.prim_range = right.prim_range) and
							keyed(left.address_history_2.sec_range = right.sec_range) and	// NNEQ here?
							left.address_history_2.predir=right.predir and 
							left.address_history_2.postdir=right.postdir,
						add_AVM3(left, right), left outer, 
								atmost(	left.address_history_2.prim_name=right.prim_name and
												left.address_history_2.st=right.st and
												left.address_history_2.zip5=right.zip and 
												left.address_history_2.prim_range=right.prim_range and
												left.address_history_2.sec_range=right.sec_range, riskwise.max_atmost), keep(100));
avm3_thor := join(
distribute(avms2, hash64(address_history_2.prim_name,
													address_history_2.st,
													address_history_2.zip5,
													address_history_2.prim_range)), 
distribute(pull(avm_v2.Key_AVM_Address), hash64(prim_name, st, zip, prim_range)),
							left.address_history_2.prim_name!='' and left.address_history_2.zip5!='' and
							left.address_history_2.prim_name = right.prim_name and
							left.address_history_2.st = right.st and
							left.address_history_2.zip5 = right.zip and
							left.address_history_2.prim_range = right.prim_range and
							left.address_history_2.sec_range = right.sec_range and	// NNEQ here?
							left.address_history_2.predir=right.predir and 
							left.address_history_2.postdir=right.postdir,
						add_AVM3(left, right), left outer, 
								atmost(riskwise.max_atmost), keep(100), 
	local);
												
#IF(onThor)
	avm3 := avm3_thor;
#ELSE
	avm3 := ungroup(avm3_roxie); // to get both sides of the branch to have same grouping, remove group here.  grouping the dataset below by avm.seq
#END

// when choosing which AVM to output if the addr returns more than 1 result, 
// always pick the record with the most recent recording date and secondarily the most recent assessed value year
all_avms3 := group(sort(avm3, seq, -address_history_2.avm_recording_date, -address_history_2.avm_assessed_value_year), seq);

avms3 := rollup(all_avms3, true, transform(Layout_AVM, self := left));
				
	
			
layout_fips := record
  unsigned seq;
	unsigned3 historydate;
	string whichaddr;
	string fips_code;
	string st;
	string county;
	string geo_blk;
end;


layout_fips get_fips(ids_wide le, integer c) := TRANSFORM
	self.historydate := le.historydate;
	SELF.whichaddr := (string)c;
	
	state := CHOOSE(c,le.Address_Verification.Input_Address_Information.st,
											le.Address_Verification.Input_Address_Information.st,
											le.Address_Verification.Input_Address_Information.st,
											le.Address_Verification.Address_History_1.st,
											le.Address_Verification.Address_History_1.st,
											le.Address_Verification.Address_History_1.st,
											le.Address_Verification.Address_History_2.st,
											le.Address_Verification.Address_History_2.st,
											le.Address_Verification.Address_History_2.st);
											
	statefips := ut.st2FipsCode(state);
	
	countyfips := CHOOSE(c,le.Address_Verification.Input_Address_Information.county,
													le.Address_Verification.Input_Address_Information.county,
													le.Address_Verification.Input_Address_Information.county,
													le.Address_Verification.Address_History_1.county,
													le.Address_Verification.Address_History_1.county,
													le.Address_Verification.Address_History_1.county,
													le.Address_Verification.Address_History_2.county,
													le.Address_Verification.Address_History_2.county,
													le.Address_Verification.Address_History_2.county);
	geoblk := CHOOSE(c,'',
													 le.Address_Verification.Input_Address_Information.geo_blk[1..6],
													 le.Address_Verification.Input_Address_Information.geo_blk[1..7],
													 '',
													 le.Address_Verification.Address_History_1.geo_blk[1..6],
													 le.Address_Verification.Address_History_1.geo_blk[1..7],
													 '',
													 le.Address_Verification.Address_History_2.geo_blk[1..6],
													 le.Address_Verification.Address_History_2.geo_blk[1..7]);
	
	self.fips_code := trim(statefips) + trim(countyfips) + trim(geoblk);
	SELF.st := state;
	SELF.county := countyfips;
	SELF.geo_blk := geoblk;
	SELF.seq := le.seq;
	SELF := [];
END;
fipsNorm := NORMALIZE(ids_wide,9,get_fips (LEFT,COUNTER));
																													
Layout_AVM getMedians(fipsNorm le, avm_v2.Key_AVM_Medians ri) := transform
	full_history_date := iid_constants.full_history_date(le.historydate);
	AVM_V2.MOD_get_AVM_from_History.MAC_get_Medians(ri, full_history_date, median_record);
	
	self.Input_Address_Information.avm_median_fips_level := if(le.fips_code[1..5]=median_record.fips_geo_12 and le.whichaddr='1', median_record.median_valuation, 0);
	self.Input_Address_Information.avm_median_geo11_level := if(le.fips_code[1..11]=median_record.fips_geo_12 and le.whichaddr='2', median_record.median_valuation, 0);
	self.Input_Address_Information.avm_median_geo12_level := if(le.fips_code[1..12]=median_record.fips_geo_12 and le.whichaddr='3', median_record.median_valuation, 0);
	
	self.Address_History_1.avm_median_fips_level := if(le.fips_code[1..5]=median_record.fips_geo_12 and le.whichaddr='4', median_record.median_valuation, 0);
	self.Address_History_1.avm_median_geo11_level := if(le.fips_code[1..11]=median_record.fips_geo_12 and le.whichaddr='5', median_record.median_valuation, 0);
	self.Address_History_1.avm_median_geo12_level := if(le.fips_code[1..12]=median_record.fips_geo_12 and le.whichaddr='6', median_record.median_valuation, 0);
	
	self.Address_History_2.avm_median_fips_level := if(le.fips_code[1..5]=median_record.fips_geo_12 and le.whichaddr='7', median_record.median_valuation, 0);
	self.Address_History_2.avm_median_geo11_level := if(le.fips_code[1..11]=median_record.fips_geo_12 and le.whichaddr='8', median_record.median_valuation, 0);
	self.Address_History_2.avm_median_geo12_level := if(le.fips_code[1..12]=median_record.fips_geo_12 and le.whichaddr='9', median_record.median_valuation, 0);
	self.seq := le.seq;
	self := []
end;
medians_roxie := join(fipsNorm, avm_v2.Key_AVM_Medians, keyed(left.fips_code=right.fips_geo_12), getMedians(left,right), left outer, atmost(riskwise.max_atmost));
medians_thor := join(
	distribute(fipsNorm, hash64(fips_code)), 
	distribute(pull(avm_v2.Key_AVM_Medians), hash64(fips_geo_12)), 
	left.fips_code=right.fips_geo_12, getMedians(left,right), left outer, atmost(riskwise.max_atmost),
	local);

// adding sort and group here for THOR version prior to rollup
#IF(onThor)
	medians := group(sort(medians_thor, seq), seq);
#ELSE
	medians := medians_roxie;
#END

								
Layout_AVM rollMedians(medians le, medians ri) := transform
	self.Input_Address_Information.avm_median_fips_level := MAX(le.Input_Address_Information.avm_median_fips_level, ri.Input_address_information.avm_median_fips_level);
	self.Input_Address_Information.avm_median_geo11_level := MAX(le.Input_Address_Information.avm_median_geo11_level, ri.Input_address_information.avm_median_geo11_level);
	self.Input_Address_Information.avm_median_geo12_level := MAX(le.Input_Address_Information.avm_median_geo12_level, ri.Input_address_information.avm_median_geo12_level);
							
	self.Address_history_1.avm_median_fips_level := MAX(le.Address_history_1.avm_median_fips_level, ri.address_history_1.avm_median_fips_level);	
	self.Address_history_1.avm_median_geo11_level := MAX(le.Address_history_1.avm_median_geo11_level, ri.address_history_1.avm_median_geo11_level);
	self.Address_history_1.avm_median_geo12_level := MAX(le.Address_history_1.avm_median_geo12_level, ri.address_history_1.avm_median_geo12_level);

	self.Address_history_2.avm_median_fips_level := MAX(le.Address_history_2.avm_median_fips_level, ri.address_history_2.avm_median_fips_level);	
	self.Address_history_2.avm_median_geo11_level := MAX(le.Address_history_2.avm_median_geo11_level, ri.address_history_2.avm_median_geo11_level);
	self.Address_history_2.avm_median_geo12_level := MAX(le.Address_history_2.avm_median_geo12_level, ri.address_history_2.avm_median_geo12_level);
								
	self := le;
end;

rolledMedians := rollup(medians, left.seq=right.seq, rollMedians(left,right));


Layout_AVM addMedians(avms3 le, rolledMedians ri) := transform
	self.Input_Address_Information.avm_median_fips_level := MAX(le.input_Address_Information.avm_median_fips_level, ri.Input_address_information.avm_median_fips_level);
	self.Input_Address_Information.avm_median_geo11_level := MAX(le.input_Address_Information.avm_median_geo11_level, ri.Input_address_information.avm_median_geo11_level);
	self.Input_Address_Information.avm_median_geo12_level := MAX(le.input_Address_Information.avm_median_geo12_level, ri.Input_address_information.avm_median_geo12_level);
							
	self.Address_history_1.avm_median_fips_level := MAX(le.Address_history_1.avm_median_fips_level, ri.address_history_1.avm_median_fips_level);	
	self.Address_history_1.avm_median_geo11_level := MAX(le.Address_history_1.avm_median_geo11_level, ri.address_history_1.avm_median_geo11_level);
	self.Address_history_1.avm_median_geo12_level := MAX(le.Address_history_1.avm_median_geo12_level, ri.address_history_1.avm_median_geo12_level);

	self.Address_history_2.avm_median_fips_level := MAX(le.Address_history_2.avm_median_fips_level, ri.address_history_2.avm_median_fips_level);	
	self.Address_history_2.avm_median_geo11_level := MAX(le.Address_history_2.avm_median_geo11_level, ri.address_history_2.avm_median_geo11_level);
	self.Address_history_2.avm_median_geo12_level := MAX(le.Address_history_2.avm_median_geo12_level, ri.address_history_2.avm_median_geo12_level);
	
	self.seq := le.seq;
	self.Input_Address_Information := le.input_address_information;
	self.Address_History_1 := le.address_history_1;
	self.Address_History_2 := le.address_history_2;
	self := le;
end;
// fullavm := join(avms3, rolledMedians, left.seq=right.seq, addMedians(left,right), left outer, lookup);
fullavm := join(avms3, rolledMedians, left.seq=right.seq, addMedians(left,right), left outer);
	
return group(sort(fullavm,seq),seq);

END;