import _Control, avm_v2, census_data, FCRA, riskwise, ut, codes;
onThor := _Control.Environment.OnThor;

export Boca_Shell_AVM_FCRA(GROUPED DATASET(layout_bocashell_neutral) ids_wide) := FUNCTION

// full_history_date := risk_indicators.iid_constants.full_history_date(history_date);

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


// check for correction record, if one exists, then don't calculate an avm?
Layout_AVM avm_correct(ids_wide le, FCRA.Key_Override_AVM_FFID ri) := transform
	SELF.seq := le.seq;
	SELF.Input_Address_Information.avm_automated_valuation := ri.automated_valuation;
	SELF := le;
END;
avm_corr_roxie := join(ids_wide, FCRA.Key_Override_AVM_FFID,
									keyed(right.flag_file_id in left.avm_correct_ffid),
									avm_correct(left, right), left outer, atmost(right.flag_file_id in left.avm_correct_ffid, 100), keep(1));

avm_corr_thor := join(ids_wide, pull(FCRA.Key_Override_AVM_FFID),
									(right.flag_file_id in left.avm_correct_ffid),
									avm_correct(left, right), left outer, keep(1), ALL, LOCAL);

#IF(onThor)
	avm_corr := avm_corr_thor;
#ELSE
	avm_corr := avm_corr_roxie;
#END

Layout_AVM_Plus add_AVM(ids_wide le, avm_v2.Key_AVM_Address_FCRA ri) := transform
	full_history_date := iid_constants.full_history_date(le.historydate);

	AVM_V2.MOD_get_AVM_from_History.MAC_get_AVM(ri, full_history_date, avm_record);	// updated version to return full history before history date 
	
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
avm1_roxie := join(ids_wide, avm_v2.Key_AVM_Address_FCRA,  
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

avm1_thor := join(distribute(ids_wide, hash64(address_verification.input_address_information.prim_name,
																							address_verification.input_address_information.zip5,
																							address_verification.input_address_information.prim_range)),
							distribute(pull(avm_v2.Key_AVM_Address_FCRA), hash64(prim_name, zip, prim_range)),  
							left.address_verification.input_address_information.prim_name!='' and left.address_verification.input_address_information.zip5!='' and
							left.address_verification.input_address_information.prim_name = right.prim_name and
							left.address_verification.input_address_information.st = right.st and
							left.address_verification.input_address_information.zip5 = right.zip and
							left.address_verification.input_address_information.prim_range = right.prim_range and
							left.address_verification.input_address_information.sec_range = right.sec_range and	// NNEQ here?
							left.address_verification.input_address_information.predir=right.predir and 
							left.address_verification.input_address_information.postdir=right.postdir,
						add_AVM(left, right), left outer, 
								atmost(	left.address_verification.input_address_information.prim_name=right.prim_name and
												left.address_verification.input_address_information.st=right.st and
												left.address_verification.input_address_information.zip5=right.zip and 
												left.address_verification.input_address_information.prim_range=right.prim_range and
												left.address_verification.input_address_information.sec_range=right.sec_range, riskwise.max_atmost), keep(100), LOCAL);

#IF(onThor)
	avm1 := avm1_thor;
#ELSE
	avm1 := ungroup(avm1_roxie);
#END

// when choosing which AVM to output if the addr returns more than 1 result, 
// always pick the record with the most recent recording date and secondarily the most recent assessed value year
all_avms1 := group(sort(avm1, avm.seq, -AVM.Input_Address_Information.avm_recording_date, -AVM.Input_Address_Information.avm_assessed_value_year), avm.seq);
avms1 := rollup(all_avms1, true, transform(Layout_AVM_Plus, self := left));


Layout_AVM_Plus add_AVM2(Layout_AVM_Plus le, avm_v2.Key_AVM_Address_FCRA ri) := transform
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
avm2_roxie := join(avms1, avm_v2.Key_AVM_Address_FCRA,  
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
												
avm2_thor := join(distribute(avms1, hash64(address_history_1.prim_name,
																					 address_history_1.zip5,
																					 address_history_1.prim_range)), 
							distribute(pull(avm_v2.Key_AVM_Address_FCRA), hash64(prim_name, zip, prim_range)),  
							left.address_history_1.prim_name!='' and left.address_history_1.zip5!='' and
							left.address_history_1.prim_name = right.prim_name and
							left.address_history_1.st = right.st and
							left.address_history_1.zip5 = right.zip and
							left.address_history_1.prim_range = right.prim_range and
							left.address_history_1.sec_range = right.sec_range and	// NNEQ here?
							left.address_history_1.predir=right.predir and 
							left.address_history_1.postdir=right.postdir,
						add_AVM2(left, right), left outer, 
								atmost(	left.address_history_1.prim_name=right.prim_name and
												left.address_history_1.st=right.st and
												left.address_history_1.zip5=right.zip and 
												left.address_history_1.prim_range=right.prim_range and
												left.address_history_1.sec_range=right.sec_range, riskwise.max_atmost), keep(100), LOCAL);												

#IF(onThor)
	avm2 := avm2_thor;
#ELSE
	avm2 := ungroup(avm2_roxie);
#END

// when choosing which AVM to output if the addr returns more than 1 result, 
// always pick the record with the most recent recording date and secondarily the most recent assessed value year
// all_avms2 := group(sort(avm2, avm.seq, -AVM.Input_Address_Information.avm_recording_date, -AVM.Input_Address_Information.avm_assessed_value_year), avm.seq);
all_avms2 := group(sort(avm2, avm.seq, -AVM.Address_History_1.avm_recording_date, -AVM.Address_History_1.avm_assessed_value_year), avm.seq);
avms2 := rollup(all_avms2, true, transform(Layout_AVM_Plus, self := left));


Layout_AVM_Plus add_AVM3(Layout_AVM_Plus le, avm_v2.Key_AVM_Address_FCRA ri) := transform
	full_history_date := iid_constants.full_history_date(le.avm.historydate);
	AVM_V2.MOD_get_AVM_from_History.MAC_get_AVM(ri, full_history_date, avm_record);
	
	SELF.AVM.Address_History_2.avm_land_use_code := avm_record.land_use;
	SELF.AVM.Address_History_2.avm_recording_date := avm_record.recording_date;
	SELF.AVM.Address_History_2.avm_assessed_value_year := avm_record.assessed_value_year;
	SELF.AVM.Address_History_2.avm_sales_price := avm_record.sales_price;  
	SELF.AVM.Address_History_2.avm_assessed_total_value := avm_record.assessed_total_value;
	SELF.AVM.Address_History_2.avm_market_total_value := avm_record.market_total_value;
	SELF.AVM.Address_History_2.avm_tax_assessment_valuation := avm_record.tax_assessment_valuation;
	SELF.AVM.Address_History_2.avm_price_index_valuation := avm_record.price_index_valuation;
	SELF.AVM.Address_History_2.avm_hedonic_valuation := avm_record.hedonic_valuation;
	SELF.AVM.Address_History_2.avm_automated_valuation := avm_record.automated_valuation;
	SELF.AVM.Address_History_2.avm_confidence_score := avm_record.confidence_score;
	
			// new fields
	SELF.AVM.Address_History_2.avm_automated_valuation2 := avm_record.automated_valuation2;
	SELF.AVM.Address_History_2.avm_automated_valuation3 := avm_record.automated_valuation3;
	SELF.AVM.Address_History_2.avm_automated_valuation4 := avm_record.automated_valuation4;
	SELF.AVM.Address_History_2.avm_automated_valuation5 := avm_record.automated_valuation5;
	SELF.AVM.Address_History_2.avm_automated_valuation6 := avm_record.automated_valuation6;
	
	self.AVM.input_address_information := le.avm.input_address_information;
	self.AVM.address_history_1 := le.avm.address_history_1;
	self.AVM.seq := le.avm.seq;
	self := le;
END;
avm3_roxie := join(avms2, avm_v2.Key_AVM_Address_FCRA,  
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
							
avm3_thor := join(distribute(avms2, hash64(address_history_2.prim_name,
																					 address_history_2.zip5,
																					 address_history_2.prim_range)), 
							distribute(pull(avm_v2.Key_AVM_Address_FCRA), hash64(prim_name, zip, prim_range)),  
							left.address_history_2.prim_name!='' and left.address_history_2.zip5!='' and
							left.address_history_2.prim_name = right.prim_name and
							left.address_history_2.st = right.st and
							left.address_history_2.zip5 = right.zip and
							left.address_history_2.prim_range = right.prim_range and
							left.address_history_2.sec_range = right.sec_range and	// NNEQ here?
							left.address_history_2.predir=right.predir and 
							left.address_history_2.postdir=right.postdir,
						add_AVM3(left, right), left outer, 
								atmost(	left.address_history_2.prim_name=right.prim_name and
												left.address_history_2.st=right.st and
												left.address_history_2.zip5=right.zip and 
												left.address_history_2.prim_range=right.prim_range and
												left.address_history_2.sec_range=right.sec_range, riskwise.max_atmost), keep(100), LOCAL);

#IF(onThor)
	avm3 := avm3_thor;
#ELSE
	avm3 := ungroup(avm3_roxie);
#END

// when choosing which AVM to output if the addr returns more than 1 result, 
// always pick the record with the most recent recording date and secondarily the most recent assessed value year
// all_avms3 := group(sort(avm3, avm.seq, -avm.Input_Address_Information.avm_recording_date, -avm.Input_Address_Information.avm_assessed_value_year), avm.seq);
all_avms3_roxie := group(sort(avm3, avm.seq, -avm.Address_History_2.avm_recording_date, -avm.Address_History_2.avm_assessed_value_year), avm.seq);
all_avms3_thor := group(sort(distribute(avm3, hash64(avm.seq)), avm.seq, -avm.Address_History_2.avm_recording_date, -avm.Address_History_2.avm_assessed_value_year, LOCAL), avm.seq, LOCAL);

#IF(onThor)
	all_avms3 := all_avms3_thor;
#ELSE
	all_avms3 := all_avms3_roxie;
#END

avms3 := rollup(all_avms3, true, transform(Layout_AVM_Plus, self := left));
	

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
											
	statefips := codes.st2FipsCode(state);
	
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

Layout_AVM getMedians(fipsNorm le, avm_v2.Key_AVM_Medians_fcra ri) := transform
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
medians_roxie := join(fipsNorm, avm_v2.Key_AVM_Medians_fcra, left.fips_code=right.fips_geo_12, getMedians(left,right), left outer, atmost(riskwise.max_atmost));
medians_thor := join(distribute(fipsNorm), 
										 pull(avm_v2.Key_AVM_Medians_fcra), 
																left.fips_code=right.fips_geo_12, getMedians(left,right), 
																left outer, atmost(riskwise.max_atmost), MANY LOOKUP);
																
#IF(onThor)
	medians := group(sort(distribute(medians_thor, hash64(seq)), seq, LOCAL), seq, LOCAL);
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
rolledMedians := rollup(medians, true, rollMedians(left,right));


Layout_AVM addMedians(avms3 le, rolledMedians ri) := transform
	self.Input_Address_Information.avm_median_fips_level := MAX(le.avm.input_Address_Information.avm_median_fips_level, ri.Input_address_information.avm_median_fips_level);
	self.Input_Address_Information.avm_median_geo11_level := MAX(le.avm.input_Address_Information.avm_median_geo11_level, ri.Input_address_information.avm_median_geo11_level);
	self.Input_Address_Information.avm_median_geo12_level := MAX(le.avm.input_Address_Information.avm_median_geo12_level, ri.Input_address_information.avm_median_geo12_level);
							
	self.Address_history_1.avm_median_fips_level := MAX(le.avm.Address_history_1.avm_median_fips_level, ri.address_history_1.avm_median_fips_level);	
	self.Address_history_1.avm_median_geo11_level := MAX(le.avm.Address_history_1.avm_median_geo11_level, ri.address_history_1.avm_median_geo11_level);
	self.Address_history_1.avm_median_geo12_level := MAX(le.avm.Address_history_1.avm_median_geo12_level, ri.address_history_1.avm_median_geo12_level);

	self.Address_history_2.avm_median_fips_level := MAX(le.avm.Address_history_2.avm_median_fips_level, ri.address_history_2.avm_median_fips_level);	
	self.Address_history_2.avm_median_geo11_level := MAX(le.avm.Address_history_2.avm_median_geo11_level, ri.address_history_2.avm_median_geo11_level);
	self.Address_history_2.avm_median_geo12_level := MAX(le.avm.Address_history_2.avm_median_geo12_level, ri.address_history_2.avm_median_geo12_level);
	
	self.seq := le.avm.seq;
	self.historydate := le.avm.historydate;
	self.Input_Address_Information := le.avm.input_address_information;
	self.Address_History_1 := le.avm.address_history_1;
	self.Address_History_2 := le.avm.address_history_2;
	self := le;
end;
fullavm_roxie := join(avms3, rolledMedians, left.avm.seq=right.seq, addMedians(left,right), left outer, lookup);
fullavm_thor := join(distribute(avms3, hash64(avm.seq)), 
										 distribute(rolledMedians, hash64(seq)), 
										 left.avm.seq=right.seq, addMedians(left,right), left outer, LOCAL);

#IF(onThor)
	fullavm :=  group(sort(fullavm_thor, seq, local), seq, local);
#ELSE
	fullavm := fullavm_roxie;
#END

Layout_Address_AVM intoblank(fullavm le, integer i) := transform
	self.avm_median_fips_level := CHOOSE(i, le.input_Address_Information.avm_median_fips_level,
																					le.Address_history_1.avm_median_fips_level,
																					le.Address_history_2.avm_median_fips_level);
	self.avm_median_geo11_level := CHOOSE(i, le.input_Address_Information.avm_median_geo11_level,
																						le.Address_history_1.avm_median_geo11_level,
																						le.Address_history_2.avm_median_geo11_level);
	self.avm_median_geo12_level := CHOOSE(i,le.input_Address_Information.avm_median_geo12_level,
																					le.Address_history_1.avm_median_geo12_level,
																					le.Address_history_2.avm_median_geo12_level);
							
	self := [];
end;
	

// need to check to see if avm_corr is populated, if so, return blank output except for median values
Layout_AVM check_corr(fullavm le, avm_corr ri) := transform
	correction := ri.Input_Address_Information.avm_automated_valuation<>0;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.Input_Address_Information := if(correction, project(ri.input_address_information, intoblank(le,1)), le.input_address_information);
	self.address_history_1 := if(correction, project(ri.input_address_information, intoblank(le,2)), le.address_history_1);
	self.address_history_2 := if(correction, project(ri.input_address_information, intoblank(le,3)), le.address_history_2);
end;
final := join(fullavm, avm_corr, left.seq=right.seq, check_corr(left,right), left outer, lookup);

return group(sort(final,seq),seq);

END;