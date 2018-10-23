import _Control, advo, riskwise, ut, fcra;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Advo(GROUPED DATASET(layout_bocashell_neutral) clam_pre_ADVO, 
											boolean isFCRA, string50 DataRestrictionMask, boolean isPreScreen,
											integer bsVersion) := FUNCTION

// they wanted to change value of blank in the data to an S to distinguish between a simplified carrier route and a miss on advo
simplified_carrier_rt := 'S'; 

// Must be exact match on all parts -- including sec range being blank.
// Must be exact match on all parts -- including sec range being blank.

Layout_Advo := RECORD
	Risk_Indicators.Layout_Boca_Shell;
	string8 date_first_seen;
END;

Layout_Advo getAdvo1(clam_pre_ADVO le, Advo.Key_Addr1_history ri) := TRANSFORM
	// Take all the Advo fields
	self.advo_input_addr.drop_indicator := if(ri.zip<>'' and ri.drop_indicator='', simplified_carrier_rt, ri.drop_indicator);
	self.advo_input_addr := ri;
	self.date_first_seen := ri.date_first_seen;
	self.advo_addr_hist1 := [];
	self := le;
END;

with_advo1_roxie := join(clam_pre_ADVO, Advo.Key_Addr1_history,  //Advo.Key_Addr1_FCRA_history or Advo.Key_Addr1_history - replace and roll to most recent
					left.Address_Verification.Input_Address_Information.zip5 != '' and 
					left.Address_Verification.Input_Address_Information.prim_range != '' and
					keyed(left.Address_Verification.Input_Address_Information.zip5 = right.zip) and
					keyed(left.Address_Verification.Input_Address_Information.prim_range = right.prim_range) and
					keyed(left.Address_Verification.Input_Address_Information.prim_name = right.prim_name) and
					keyed(left.Address_Verification.Input_Address_Information.addr_suffix = right.addr_suffix) and
					keyed(left.Address_Verification.Input_Address_Information.predir = right.predir) and
					keyed(left.Address_Verification.Input_Address_Information.postdir = right.postdir) and
					keyed(left.Address_Verification.Input_Address_Information.sec_range = right.sec_range)  and
					((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)), 
					getAdvo1(LEFT,RIGHT), 
					left outer,
					atmost(riskwise.max_atmost));

with_advo1_thor := join(distribute(clam_pre_ADVO, hash64(Address_Verification.Input_Address_Information.zip5,
																												 Address_Verification.Input_Address_Information.prim_range,
																												 Address_Verification.Input_Address_Information.prim_name)), 
					distribute(pull(Advo.Key_Addr1_history), hash64(zip, prim_range, prim_name)),  
					//Advo.Key_Addr1_FCRA_history or Advo.Key_Addr1_history - replace and roll to most recent
					left.Address_Verification.Input_Address_Information.zip5 != '' and 
					left.Address_Verification.Input_Address_Information.prim_range != '' and
					left.Address_Verification.Input_Address_Information.zip5 = right.zip and
					left.Address_Verification.Input_Address_Information.prim_range = right.prim_range and
					left.Address_Verification.Input_Address_Information.prim_name = right.prim_name and
					left.Address_Verification.Input_Address_Information.addr_suffix = right.addr_suffix and
					left.Address_Verification.Input_Address_Information.predir = right.predir and
					left.Address_Verification.Input_Address_Information.postdir = right.postdir and
					left.Address_Verification.Input_Address_Information.sec_range = right.sec_range  and
					((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)), 
					getAdvo1(LEFT,RIGHT), 
					left outer,
					atmost(riskwise.max_atmost), LOCAL);
					
#IF(onThor)
	with_advo1 := group(sort(with_advo1_thor, seq), seq);
#ELSE
	with_advo1 := with_advo1_roxie;
#END

with_advo1_deduped :=  dedup(sort(with_advo1, seq, did, Address_Verification.Input_Address_Information.zip5,Address_Verification.Input_Address_Information.prim_range,
															Address_Verification.Input_Address_Information.prim_name, Address_Verification.Input_Address_Information.addr_suffix, 
															Address_Verification.Input_Address_Information.predir, Address_Verification.Input_Address_Information.postdir, 
															Address_Verification.Input_Address_Information.sec_range, -date_first_seen), seq, did,
															Address_Verification.Input_Address_Information.zip5, Address_Verification.Input_Address_Information.prim_range, 
															Address_Verification.Input_Address_Information.prim_name, 
															Address_Verification.Input_Address_Information.addr_suffix, Address_Verification.Input_Address_Information.predir, 
															Address_Verification.Input_Address_Information.postdir, Address_Verification.Input_Address_Information.sec_range	);

// Must be exact match on all parts -- including sec range being blank.

Layout_Advo getAdvo2(with_advo1_deduped le, Advo.Key_Addr1_history ri) := TRANSFORM
	// Take all the Advo fields
	self.advo_addr_hist1.drop_indicator := if(ri.zip<>'' and ri.drop_indicator='', simplified_carrier_rt, ri.drop_indicator);
	self.advo_addr_hist1 := ri;
	self.date_first_seen := ri.date_first_seen;
	self := le;;
END;

with_advo2_roxie := join(with_advo1_deduped, Advo.Key_Addr1_history,
					left.Address_Verification.Address_History_1.zip5 != '' and 
					left.Address_Verification.Address_History_1.prim_range != '' and
					keyed(left.Address_Verification.Address_History_1.zip5 = right.zip) and
					keyed(left.Address_Verification.Address_History_1.prim_range = right.prim_range) and
					keyed(left.Address_Verification.Address_History_1.prim_name = right.prim_name) and
					keyed(left.Address_Verification.Address_History_1.addr_suffix = right.addr_suffix) and
					keyed(left.Address_Verification.Address_History_1.predir = right.predir) and
					keyed(left.Address_Verification.Address_History_1.postdir = right.postdir) and
					keyed(left.Address_Verification.Address_History_1.sec_range = right.sec_range)  and
					((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)), 
					getAdvo2(LEFT,RIGHT), left outer,
					atmost(riskwise.max_atmost));																	
		
with_advo2_thor := join(distribute(with_advo1_deduped, hash64(Address_Verification.Address_History_1.zip5,
																															Address_Verification.Address_History_1.prim_range,
																															Address_Verification.Address_History_1.prim_name)), 
					distribute(pull(Advo.Key_Addr1_history), hash64(zip, prim_range, prim_name)),
					left.Address_Verification.Address_History_1.zip5 != '' and 
					left.Address_Verification.Address_History_1.prim_range != '' and
					left.Address_Verification.Address_History_1.zip5 = right.zip and
					left.Address_Verification.Address_History_1.prim_range = right.prim_range and
					left.Address_Verification.Address_History_1.prim_name = right.prim_name and
					left.Address_Verification.Address_History_1.addr_suffix = right.addr_suffix and
					left.Address_Verification.Address_History_1.predir = right.predir and
					left.Address_Verification.Address_History_1.postdir = right.postdir and
					left.Address_Verification.Address_History_1.sec_range = right.sec_range  and
					((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)), 
					getAdvo2(LEFT,RIGHT), left outer,
					atmost(riskwise.max_atmost), LOCAL);

#IF(onThor)
	with_advo2 := group(sort(with_advo2_thor,seq),seq);
#ELSE
	with_advo2 := with_advo2_roxie;
#END

with_advo2_deduped :=  dedup(sort(with_advo2, seq, did, Address_Verification.Address_History_1.zip5,Address_Verification.Address_History_1.prim_range,
															Address_Verification.Address_History_1.prim_name, Address_Verification.Address_History_1.addr_suffix, 
															Address_Verification.Address_History_1.predir, Address_Verification.Address_History_1.postdir, 
															Address_Verification.Address_History_1.sec_range, -date_first_seen), seq, did,
															Address_Verification.Address_History_1.zip5, Address_Verification.Address_History_1.prim_range, 
															Address_Verification.Address_History_1.prim_name, 
															Address_Verification.Address_History_1.addr_suffix, Address_Verification.Address_History_1.predir, 
															Address_Verification.Address_History_1.postdir, Address_Verification.Address_History_1.sec_range	);	
		

// Must be exact match on all parts -- including sec range being blank.

Layout_Advo getAdvo3(with_advo2_deduped le, Advo.Key_Addr1_history ri) := TRANSFORM
	// Take all the Advo fields
	self.advo_addr_hist2.drop_indicator := if(ri.zip<>'' and ri.drop_indicator='', simplified_carrier_rt, ri.drop_indicator);
	self.advo_addr_hist2 := ri;
	self.date_first_seen := ri.date_first_seen;
	self := le;
END;


with_advo3_roxie := join(with_advo2_deduped, Advo.Key_Addr1_history,
					left.Address_Verification.Address_History_2.zip5 != '' and 
					left.Address_Verification.Address_History_2.prim_range != '' and
					keyed(left.Address_Verification.Address_History_2.zip5 = right.zip) and
					keyed(left.Address_Verification.Address_History_2.prim_range = right.prim_range) and
					keyed(left.Address_Verification.Address_History_2.prim_name = right.prim_name) and
					keyed(left.Address_Verification.Address_History_2.addr_suffix = right.addr_suffix) and
					keyed(left.Address_Verification.Address_History_2.predir = right.predir) and
					keyed(left.Address_Verification.Address_History_2.postdir = right.postdir) and
					keyed(left.Address_Verification.Address_History_2.sec_range = right.sec_range)  and
					((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)), 
					getAdvo3(LEFT, RIGHT), left outer,
					atmost(riskwise.max_atmost));																	

with_advo3_thor := join(distribute(with_advo2_deduped, hash64(Address_Verification.Address_History_2.zip5,
																															Address_Verification.Address_History_2.prim_range,
																															Address_Verification.Address_History_2.prim_name)), 
					distribute(pull(Advo.Key_Addr1_history), hash64(zip, prim_range, prim_name)),
					left.Address_Verification.Address_History_2.zip5 != '' and 
					left.Address_Verification.Address_History_2.prim_range != '' and
					left.Address_Verification.Address_History_2.zip5 = right.zip and
					left.Address_Verification.Address_History_2.prim_range = right.prim_range and
					left.Address_Verification.Address_History_2.prim_name = right.prim_name and
					left.Address_Verification.Address_History_2.addr_suffix = right.addr_suffix and
					left.Address_Verification.Address_History_2.predir = right.predir and
					left.Address_Verification.Address_History_2.postdir = right.postdir and
					left.Address_Verification.Address_History_2.sec_range = right.sec_range  and
					((unsigned)RIGHT.date_first_seen < (unsigned)Risk_Indicators.iid_constants.full_history_date(left.historydate)), 
					getAdvo3(LEFT, RIGHT), left outer,
					atmost(riskwise.max_atmost), LOCAL);
					
#IF(onThor)
	with_advo3 := group(sort(with_advo3_thor,seq),seq);
#ELSE
	with_advo3 := with_advo3_roxie;
#END

with_advo3_deduped :=  dedup(sort(with_advo3, seq, did, Address_Verification.Address_History_2.zip5,Address_Verification.Address_History_2.prim_range,
															Address_Verification.Address_History_2.prim_name, Address_Verification.Address_History_2.addr_suffix, 
															Address_Verification.Address_History_2.predir, Address_Verification.Address_History_2.postdir, 
															Address_Verification.Address_History_2.sec_range, -date_first_seen), seq, did,
															Address_Verification.Address_History_2.zip5, Address_Verification.Address_History_2.prim_range, 
															Address_Verification.Address_History_2.prim_name, 
															Address_Verification.Address_History_2.addr_suffix, Address_Verification.Address_History_2.predir, 
															Address_Verification.Address_History_2.postdir, Address_Verification.Address_History_2.sec_range	);	
		
with_advo_nonfcra_deduped := if(bsversion>=50, with_advo3_deduped,with_advo2_deduped);
with_advo3_nonfcra_slim := project(with_advo_nonfcra_deduped, transform(Risk_Indicators.Layout_Boca_Shell, self := left));
					
// FCRA branch
// last seen date must be within the last 7 years and search corrections key by ffid

// put both addresses into layout input, creating 2 records.  search the advo raw key and corrections data, put the results together, dedup by address, 
// keeping the corrections record if it exists
risk_indicators.layout_input concat_addresses(risk_indicators.layout_bocashell_neutral le, integer C) := transform
	self.z5 := choose(c, le.Address_Verification.Input_Address_Information.zip5, le.Address_Verification.Address_History_1.zip5, le.Address_Verification.Address_History_2.zip5 );
	self.prim_range := choose(c, le.Address_Verification.Input_Address_Information.prim_range, le.Address_Verification.Address_History_1.prim_range, le.Address_Verification.Address_History_2.prim_range  );
	self.prim_name := choose(c, le.Address_Verification.Input_Address_Information.prim_name, le.Address_Verification.Address_History_1.prim_name, le.Address_Verification.Address_History_2.prim_name);
	self.addr_suffix := choose(c, le.Address_Verification.Input_Address_Information.addr_suffix, le.Address_Verification.Address_History_1.addr_suffix, le.Address_Verification.Address_History_2.addr_suffix);
	self.predir := choose(c, le.Address_Verification.Input_Address_Information.predir, le.Address_Verification.Address_History_1.predir, le.Address_Verification.Address_History_2.predir);
	self.postdir := choose(c, le.Address_Verification.Input_Address_Information.postdir, le.Address_Verification.Address_History_1.postdir, le.Address_Verification.Address_History_2.postdir );
	self.sec_range := choose(c, le.Address_Verification.Input_Address_Information.sec_range, le.Address_Verification.Address_History_1.sec_range, le.Address_Verification.Address_History_2.sec_range );
  self.historydate := le.historydate,		
	self := le.shell_input;
end;

normed_addresses := normalize(clam_pre_ADVO, 3, concat_addresses(left, counter));



advo_corrections_data_roxie := join(clam_pre_ADVO, FCRA.Key_Override_ADVO_FFID,
					left.advo_correct_ffid <> [] and 
					keyed(right.flag_file_id in left.advo_correct_ffid),
					transform(FCRA.Layout_Override_ADVO, self := right),
					atmost(riskwise.max_atmost), KEEP(100));

advo_corrections_data_thor := join(clam_pre_ADVO(advo_correct_ffid <> []), 
					pull(FCRA.Key_Override_ADVO_FFID),
					right.flag_file_id in left.advo_correct_ffid,
					transform(FCRA.Layout_Override_ADVO, self := right),
					KEEP(100), LOCAL, ALL);
					
#IF(onThor)
	advo_corrections_data := advo_corrections_data_thor;
#ELSE
	advo_corrections_data := advo_corrections_data_roxie;
#END

Layout_Advo_Raw := RECORD
	FCRA.Layout_Override_ADVO; 
	integer seq;
END;

Layout_Advo_Raw getRawAdvo(normed_addresses le, Advo.Key_Addr1_FCRA_history ri) := TRANSFORM
	self.seq := le.seq;
	self.flag_file_id:='';
	self := ri;
END;

advo_raw_data_roxie := join(normed_addresses, Advo.Key_Addr1_FCRA_history ,
					left.z5 != '' and left.prim_range != '' and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					keyed(left.sec_range = right.sec_range) and
					((unsigned)RIGHT.date_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate)),
					getRawAdvo(LEFT,RIGHT),
					atmost(riskwise.max_atmost));	
					
advo_raw_data_thor := join(distribute(normed_addresses(z5!='' and prim_range!=''), hash64(z5, prim_range, prim_name)), 
					distribute(pull(Advo.Key_Addr1_FCRA_history), hash64(zip, prim_range, prim_name)),
					left.z5 = right.zip and
					left.prim_range = right.prim_range and
					left.prim_name = right.prim_name and
					left.addr_suffix = right.addr_suffix and
					left.predir = right.predir and
					left.postdir = right.postdir and
					left.sec_range = right.sec_range and
					((unsigned)RIGHT.date_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate)),
					getRawAdvo(LEFT,RIGHT), atmost(left.z5 = right.zip and
						left.prim_range = right.prim_range and
						left.prim_name = right.prim_name and
						left.addr_suffix = right.addr_suffix and
						left.predir = right.predir and
						left.postdir = right.postdir and
						left.sec_range = right.sec_range,riskwise.max_atmost), LOCAL);	

#IF(onThor)
	advo_raw_data := group(sort(advo_raw_data_thor, seq),seq);
#ELSE
	advo_raw_data := advo_raw_data_roxie;
#END

advo_raw_deduped := dedup(sort(advo_raw_data, seq, zip,prim_range,
															prim_name, addr_suffix, predir, postdir, sec_range, -date_first_seen, record), 
															seq, zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range	);

advo_raw_override := project(advo_raw_deduped, transform(FCRA.Layout_Override_ADVO, self := left));

advo_fcra_data_rolled := dedup(sort(ungroup(advo_corrections_data + advo_raw_override), zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range, -flag_file_id),
											zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range);
					
// Must be exact match on all parts -- including sec range being blank.

Risk_Indicators.Layout_Boca_Shell getAdvo1FCRA(clam_pre_ADVO le, advo_fcra_data_rolled ri) := TRANSFORM
	// Take all the Advo fields
	self.advo_input_addr.drop_indicator := if(ri.zip<>'' and ri.drop_indicator='', simplified_carrier_rt, ri.drop_indicator);
	self.advo_input_addr := ri;
	self.advo_addr_hist1 := [];
	self := le;
END;

with_advo1_fcra_roxie := join(clam_pre_ADVO, advo_fcra_data_rolled,
					left.Address_Verification.Input_Address_Information.zip5 != '' and 
					left.Address_Verification.Input_Address_Information.prim_range != '' and
					left.Address_Verification.Input_Address_Information.zip5 = right.zip and
					left.Address_Verification.Input_Address_Information.prim_range = right.prim_range and
					left.Address_Verification.Input_Address_Information.prim_name = right.prim_name and
					left.Address_Verification.Input_Address_Information.addr_suffix = right.addr_suffix and
					left.Address_Verification.Input_Address_Information.predir = right.predir and
					left.Address_Verification.Input_Address_Information.postdir = right.postdir and
					left.Address_Verification.Input_Address_Information.sec_range = right.sec_range and
					(ut.daysapart(RIGHT.date_last_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
					(trim(left.Address_Verification.Input_Address_Information.zip5) + trim(left.Address_Verification.Input_Address_Information.prim_range) + 
					trim(left.Address_Verification.Input_Address_Information.prim_name) + trim(left.Address_Verification.Input_Address_Information.sec_range) 
					not in left.ADVO_correct_record_id),
					getAdvo1FCRA(LEFT,RIGHT), left outer, keep(1));

with_advo1_fcra_thor := join(distribute(clam_pre_ADVO, hash64(Address_Verification.Input_Address_Information.zip5,
																															Address_Verification.Input_Address_Information.prim_range,
																															Address_Verification.Input_Address_Information.prim_name)), 
					distribute(advo_fcra_data_rolled, hash64(zip, prim_range, prim_name)),
					left.Address_Verification.Input_Address_Information.zip5 != '' and 
					left.Address_Verification.Input_Address_Information.prim_range != '' and
					left.Address_Verification.Input_Address_Information.zip5 = right.zip and
					left.Address_Verification.Input_Address_Information.prim_range = right.prim_range and
					left.Address_Verification.Input_Address_Information.prim_name = right.prim_name and
					left.Address_Verification.Input_Address_Information.addr_suffix = right.addr_suffix and
					left.Address_Verification.Input_Address_Information.predir = right.predir and
					left.Address_Verification.Input_Address_Information.postdir = right.postdir and
					left.Address_Verification.Input_Address_Information.sec_range = right.sec_range and
					(ut.daysapart(RIGHT.date_last_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
					(trim(left.Address_Verification.Input_Address_Information.zip5) + trim(left.Address_Verification.Input_Address_Information.prim_range) + 
					trim(left.Address_Verification.Input_Address_Information.prim_name) + trim(left.Address_Verification.Input_Address_Information.sec_range) 
					not in left.ADVO_correct_record_id),
					getAdvo1FCRA(LEFT,RIGHT), left outer, keep(1), LOCAL);
					
#IF(onThor)
	with_advo1_fcra := with_advo1_fcra_thor;
#ELSE
	with_advo1_fcra := with_advo1_fcra_roxie;
#END

Risk_Indicators.Layout_Boca_Shell getAdvo2FCRA(with_advo1_fcra le, advo_fcra_data_rolled ri) := TRANSFORM
	// Take all the Advo fields/check corrections (if addr_flags are populated, that means we need to use that value because a correction was made									
	self.advo_addr_hist1.Address_Vacancy_Indicator := if(le.address_verification.addr_flags_1.deliveryStatus='V', 'Y', ri.Address_Vacancy_Indicator);
	self.advo_addr_hist1.Throw_Back_Indicator := if(trim(le.address_verification.addr_flags_1.deliveryStatus)<>'', if(le.address_verification.addr_flags_1.deliveryStatus='V','Y','N'),ri.Throw_Back_Indicator);
	self.advo_addr_hist1.Seasonal_Delivery_Indicator := if(le.address_verification.addr_flags_1.deliveryStatus='S', 'Y', ri.Seasonal_Delivery_Indicator);
	self.advo_addr_hist1.DND_Indicator := if(trim(le.address_verification.addr_flags_1.doNotDeliver)<>'', if(le.address_verification.addr_flags_1.doNotDeliver in ['Y','1'],'Y','N'), ri.DND_Indicator);
	self.advo_addr_hist1.College_Indicator := if(le.address_verification.addr_flags_1.deliveryStatus='C', 'Y', ri.College_Indicator);
	self.advo_addr_hist1.Drop_Indicator := if(trim(le.address_verification.addr_flags_1.dropIndicator)<>'', le.address_verification.addr_flags_1.dropIndicator, if(trim(ri.zip)<>'' and ri.drop_indicator='', simplified_carrier_rt, ri.drop_indicator));
	self.advo_addr_hist1.Residential_or_Business_Ind := if(trim(le.address_verification.addr_flags_1.addressType)<>'', le.address_verification.addr_flags_1.addressType, ri.Residential_or_Business_Ind);
	self.advo_addr_hist1.Mixed_Address_Usage := if(trim(le.address_verification.addr_flags_1.addressType)<>'', if(le.address_verification.addr_flags_1.addressType in ['C','D'], le.address_verification.addr_flags_1.addressType, 'U'), ri.Mixed_Address_Usage);
	self.advo_addr_hist1 := ri;
	self := le;
END;

// Must be exact match on all parts -- including sec range being blank.
with_advo2_fcra_roxie := join(with_advo1_fcra, advo_fcra_data_rolled,
					left.Address_Verification.Address_History_1.zip5 != '' and 
					left.Address_Verification.Address_History_1.prim_range != '' and
					left.Address_Verification.Address_History_1.zip5 = right.zip and
					left.Address_Verification.Address_History_1.prim_range = right.prim_range and
					left.Address_Verification.Address_History_1.prim_name = right.prim_name and
					left.Address_Verification.Address_History_1.addr_suffix = right.addr_suffix and
					left.Address_Verification.Address_History_1.predir = right.predir and
					left.Address_Verification.Address_History_1.postdir = right.postdir and
					left.Address_Verification.Address_History_1.sec_range = right.sec_range and
					// ((unsigned)RIGHT.date_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) and
					(ut.daysapart(RIGHT.date_last_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)),
					getAdvo2FCRA(LEFT,RIGHT), left outer, keep(1));					

// Must be exact match on all parts -- including sec range being blank.
with_advo2_fcra_thor := join(distribute(with_advo1_fcra, hash64(Address_Verification.Address_History_1.zip5,
																																Address_Verification.Address_History_1.prim_range,
																																Address_Verification.Address_History_1.prim_name)), 
					distribute(advo_fcra_data_rolled, hash64(zip, prim_range, prim_name)),
					left.Address_Verification.Address_History_1.zip5 != '' and 
					left.Address_Verification.Address_History_1.prim_range != '' and
					left.Address_Verification.Address_History_1.zip5 = right.zip and
					left.Address_Verification.Address_History_1.prim_range = right.prim_range and
					left.Address_Verification.Address_History_1.prim_name = right.prim_name and
					left.Address_Verification.Address_History_1.addr_suffix = right.addr_suffix and
					left.Address_Verification.Address_History_1.predir = right.predir and
					left.Address_Verification.Address_History_1.postdir = right.postdir and
					left.Address_Verification.Address_History_1.sec_range = right.sec_range and
					// ((unsigned)RIGHT.date_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) and
					(ut.daysapart(RIGHT.date_last_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)),
					getAdvo2FCRA(LEFT,RIGHT), left outer, keep(1), LOCAL);				

#IF(onThor)
	with_advo2_fcra := with_advo2_fcra_thor;
#ELSE
	with_advo2_fcra := with_advo2_fcra_roxie;
#END

Risk_Indicators.Layout_Boca_Shell getAdvo3FCRA(with_advo2_fcra le, advo_fcra_data_rolled ri) := TRANSFORM
	// Take all the Advo fields/check corrections (if addr_flags are populated, that means we need to use that value because a correction was made									
	self.advo_addr_hist2.Address_Vacancy_Indicator := if(le.address_verification.addr_flags_2.deliveryStatus='V', 'Y', ri.Address_Vacancy_Indicator);
	self.advo_addr_hist2.Throw_Back_Indicator := if(trim(le.address_verification.addr_flags_2.deliveryStatus)<>'', if(le.address_verification.addr_flags_2.deliveryStatus='V','Y','N'),ri.Throw_Back_Indicator);
	self.advo_addr_hist2.Seasonal_Delivery_Indicator := if(le.address_verification.addr_flags_2.deliveryStatus='S', 'Y', ri.Seasonal_Delivery_Indicator);
	self.advo_addr_hist2.DND_Indicator := if(trim(le.address_verification.addr_flags_2.doNotDeliver)<>'', if(le.address_verification.addr_flags_2.doNotDeliver in ['Y','1'],'Y','N'), ri.DND_Indicator);
	self.advo_addr_hist2.College_Indicator := if(le.address_verification.addr_flags_2.deliveryStatus='C', 'Y', ri.College_Indicator);
	self.advo_addr_hist2.Drop_Indicator := if(trim(le.address_verification.addr_flags_2.dropIndicator)<>'', le.address_verification.addr_flags_2.dropIndicator, if(trim(ri.zip)<>'' and ri.drop_indicator='', simplified_carrier_rt, ri.drop_indicator));
	self.advo_addr_hist2.Residential_or_Business_Ind := if(trim(le.address_verification.addr_flags_2.addressType)<>'', le.address_verification.addr_flags_2.addressType, ri.Residential_or_Business_Ind);
	self.advo_addr_hist2.Mixed_Address_Usage := if(trim(le.address_verification.addr_flags_2.addressType)<>'', if(le.address_verification.addr_flags_2.addressType in ['C','D'], le.address_verification.addr_flags_2.addressType, 'U'), ri.Mixed_Address_Usage);
	self.advo_addr_hist2 := ri;
	self := le;
END;

// Must be exact match on all parts -- including sec range being blank.
with_advo3_fcra_roxie := join(with_advo2_fcra, advo_fcra_data_rolled,
					left.Address_Verification.Address_History_2.zip5 != '' and 
					left.Address_Verification.Address_History_2.prim_range != '' and
					left.Address_Verification.Address_History_2.zip5 = right.zip and
					left.Address_Verification.Address_History_2.prim_range = right.prim_range and
					left.Address_Verification.Address_History_2.prim_name = right.prim_name and
					left.Address_Verification.Address_History_2.addr_suffix = right.addr_suffix and
					left.Address_Verification.Address_History_2.predir = right.predir and
					left.Address_Verification.Address_History_2.postdir = right.postdir and
					left.Address_Verification.Address_History_2.sec_range = right.sec_range and
					// ((unsigned)RIGHT.date_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) and
					(ut.daysapart(RIGHT.date_last_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)),
					getAdvo3FCRA(LEFT,RIGHT), left outer, keep(1));	

// Must be exact match on all parts -- including sec range being blank.
with_advo3_fcra_thor := join(distribute(with_advo2_fcra, hash64(Address_Verification.Address_History_2.zip5,
																																Address_Verification.Address_History_2.prim_range,
																																Address_Verification.Address_History_2.prim_name)), 
					distribute(advo_fcra_data_rolled, hash64(zip, prim_range, prim_name)),
					left.Address_Verification.Address_History_2.zip5 != '' and 
					left.Address_Verification.Address_History_2.prim_range != '' and
					left.Address_Verification.Address_History_2.zip5 = right.zip and
					left.Address_Verification.Address_History_2.prim_range = right.prim_range and
					left.Address_Verification.Address_History_2.prim_name = right.prim_name and
					left.Address_Verification.Address_History_2.addr_suffix = right.addr_suffix and
					left.Address_Verification.Address_History_2.predir = right.predir and
					left.Address_Verification.Address_History_2.postdir = right.postdir and
					left.Address_Verification.Address_History_2.sec_range = right.sec_range and
					// ((unsigned)RIGHT.date_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) and
					(ut.daysapart(RIGHT.date_last_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)),
					getAdvo3FCRA(LEFT,RIGHT), left outer, keep(1), LOCAL);	
	
#IF(onThor)
	with_advo3_fcra := with_advo3_fcra_thor;
#ELSE
	with_advo3_fcra := with_advo3_fcra_roxie;
#END

// don't search ADVO on address 3 unless running shell version 5.0 and higher
with_advo_fcra := if(bsversion>=50, with_advo3_fcra,with_advo2_fcra);

with_advo := if(isFCRA, group(sort(with_advo_fcra, seq), seq), with_advo3_nonfcra_slim);

advo_permitted := datarestrictionmask[iid_constants.posADVORestriction]<>'1' and isPrescreen=false;


with_advo_final := if(advo_permitted, with_advo, project(clam_pre_ADVO, transform(risk_indicators.Layout_Boca_Shell, self := left)));
// output(clam_pre_ADVO, named('clam_pre_ADVO'));
// output(advo_permitted, named('advo_permitted'));
// output(with_advo1, named('with_advo1'));
// output(with_advo2, named('with_advo2'));

// output(advo_raw_data, named('advo_raw_data'));
// output(advo_corrections_data, named('advo_corrections_data'));
// output(advo_fcra_data_rolled, named('advo_fcra_data_rolled'));
// output(with_advo1_fcra, named('with_advo1_fcra'));
// output(with_advo2_fcra, named('with_advo2_fcra'));
// output(with_advo, named('with_advo'));
// output(with_advo_final, named('with_advo_final'));

return with_advo_final;

end;
