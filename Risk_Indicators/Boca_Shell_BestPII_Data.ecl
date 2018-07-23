import _Control, doxie, did_add, ut, riskwise, address, gateway, watchdog;
onThor := _Control.Environment.OnThor;

// this function will first append the BEST fname, lname, phone and ssn
// then perform the necessary searching and counting logic to calculate velocity counters for each of those elements

EXPORT Boca_Shell_BestPII_Data(grouped dataset(risk_indicators.Layout_Boca_Shell) bsData, 
	boolean isFCRA,
	integer glbpurpose,
	integer dppapurpose,
	integer bsversion,
	string datarestrictionmask, 
	string datapermissionmask,
	unsigned8 BSOptions
	) := function

gateways := dataset([], Gateway.Layouts.Config); // set this to nothing for now until we can prove any of this logic needs gateway info 

best_prep := project(bsData, transform(doxie.layout_references, self.did := if(left.truedid, left.did, 0)) );  // only map the DID if we have truedid
best_prep_deduped := ungroup(dedup(sort(best_prep, did), did));

outfile := risk_indicators.Collection_Shell_MOD.getBestCleaned(best_prep_deduped, DataRestrictionMask, GLBPurpose, false);

// get the best fname, lname, ssn, phone from the appropriate best file based upon environment and datarestrictions
withBest_nonfcra := join(bsData, outfile,
	LEFT.did = (UNSIGNED6)right.did,
		transform(risk_indicators.Layout_Boca_Shell,
		self.best_flags := right; self := left), left outer, atmost(riskwise.max_atmost), keep(1));

withBest_FCRA_noEQ_roxie := join(bsData, Watchdog.Key_Watchdog_FCRA_nonEQ, keyed(left.did=right.did),
	transform(risk_indicators.Layout_Boca_Shell,
		self.best_flags := right; self := left), left outer, atmost(riskwise.max_atmost), keep(1));

withBest_FCRA_noEQ_thor := join(distribute(bsData, hash64(did)), 
	distribute(pull(Watchdog.Key_Watchdog_FCRA_nonEQ), hash64(did)), 
	(left.did=right.did),
	transform(risk_indicators.Layout_Boca_Shell,
		self.best_flags := right; self := left), left outer, atmost(riskwise.max_atmost), keep(1), LOCAL);

#IF(onThor)
	withBest_FCRA_noEQ := GROUP(SORT(withBest_FCRA_noEQ_thor, seq, LOCAL), seq, LOCAL);
#ELSE
	withBest_FCRA_noEQ := withBest_FCRA_noEQ_roxie;
#END

withBest_FCRA_noEN_roxie := join(bsData, Watchdog.Key_Watchdog_FCRA_nonEN, keyed(left.did=right.did),
	transform(risk_indicators.Layout_Boca_Shell,
		self.best_flags := right; self := left), left outer, atmost(riskwise.max_atmost), keep(1));
		
withBest_FCRA_noEN_thor := join(distribute(bsData, hash64(did)), 
	distribute(pull(Watchdog.Key_Watchdog_FCRA_nonEN), hash64(did)), 
	(left.did=right.did),
	transform(risk_indicators.Layout_Boca_Shell,
		self.best_flags := right; self := left), left outer, atmost(riskwise.max_atmost), keep(1), LOCAL);

#IF(onThor)
	withBest_FCRA_noEN := GROUP(SORT(withBest_FCRA_noEN_thor, seq, LOCAL), seq, LOCAL);
#ELSE
	withBest_FCRA_noEN := withBest_FCRA_noEN_roxie;
#END

// based upon the datarestrictionmask, either use the copy without equifax data or the copy without experian data		
withBest_FCRA := if(datarestrictionmask[risk_indicators.iid_constants.posEquifaxRestriction]='1', withBest_FCRA_noEQ, withBest_FCRA_noEN);
		
withBest := if(isFCRA, withBest_FCRA, group(withBest_nonfcra, seq));

risk_indicators.Layout_Boca_Shell set_match_flags(risk_indicators.Layout_Boca_Shell le) := transform
	self.best_flags.input_fname_isbestmatch := map(le.truedid=false => '-1',
																								 le.best_flags.fname='' => '-2',
																								 trim(le.shell_input.fname)='' => '-3',
																								 risk_indicators.iid_constants.g(risk_indicators.FnameScore(le.shell_input.fname, le.best_flags.fname) ) => '1',
																								 '0');
	self.best_flags.input_lname_isbestmatch := map(le.truedid=false => '-1',
																								 le.best_flags.lname='' => '-2',
																								 trim(le.shell_input.lname)='' => '-3',
																								 risk_indicators.iid_constants.g(risk_indicators.LnameScore(le.shell_input.lname, le.best_flags.lname) ) => '1',
																								 '0');
	self.best_flags.input_phone_isbestmatch := map(le.truedid=false => '-1',
																								 le.best_flags.phone='' => '-2',
																								 trim(le.shell_input.phone10)='' => '-3',
																								 risk_indicators.iid_constants.gn(risk_indicators.phonescore(le.shell_input.phone10, le.best_flags.phone) ) => '1',
																								 '0');
	self.best_flags.input_ssn_isbestmatch := map(le.truedid=false => '-1',
																								 le.best_flags.ssn='' => '-2',
																								 trim(le.shell_input.ssn)='' => '-3',
																								 risk_indicators.iid_constants.gn(did_add.ssn_match_score(le.shell_input.ssn, le.best_flags.ssn, LENGTH(TRIM(le.shell_input.ssn))=4) ) => '1',
																								 '0');
	self := le;																							 
																								 
end;

with_match_flags := project(withBest, set_match_flags(left));

// replace the input fields with the data from "BEST" so that all of the elements can be calculated from "BEST" instead of the input
iid_prep := group(
project(with_match_flags, transform(risk_indicators.layout_output,
	self.fname := left.best_flags.fname;
	self.lname := left.best_flags.lname;
	self.ssn := left.best_flags.ssn;
	self.phone10 := left.best_flags.phone;
	self.dob := if(left.reported_dob=0, '', (string)left.reported_dob);// requirements say to use the reported_dob to be the best
	
	// use the address picked by address hierarchy as the "best address"
	// address_verification.Address_History_1
	SELF.in_streetAddress := address.Addr1FromComponents(
		left.address_verification.Address_History_1.prim_range,
		left.address_verification.Address_History_1.predir,
		left.address_verification.Address_History_1.prim_name,
		left.address_verification.Address_History_1.addr_suffix,
		left.address_verification.Address_History_1.postdir,
		left.address_verification.Address_History_1.unit_desig,
		left.address_verification.Address_History_1.sec_range
	);
		
	SELF.in_city := left.address_verification.Address_History_1.city_name;
	SELF.in_state := left.address_verification.Address_History_1.st;
	SELF.in_zipCode := left.address_verification.Address_History_1.st;
	self.prim_range := left.address_verification.Address_History_1.prim_range;
	self.predir := left.address_verification.Address_History_1.predir;
	self.prim_name := left.address_verification.Address_History_1.prim_name;
	self.addr_suffix := left.address_verification.Address_History_1.addr_suffix;
	self.postdir := left.address_verification.Address_History_1.postdir;
	self.unit_desig := left.address_verification.Address_History_1.unit_desig;
	self.sec_range := left.address_verification.Address_History_1.sec_range;
	self.p_city_name := left.address_verification.Address_History_1.city_name;
	self.st := left.address_verification.Address_History_1.st;
	self.z5 := left.address_verification.Address_History_1.zip5;
	// self.zip4 := left.address_verification.Address_History_1.zip4;  // zip4 not in the layout
	self.lat := left.address_verification.Address_History_1.lat;
	self.long := left.address_verification.Address_History_1.long;
	self.addr_type := left.address_verification.addr_type2;
	// self.addr_status := left.address_verification.Address_History_1.;  // addr status not available
	self.county := left.address_verification.Address_History_1.county;
	self.geo_blk := left.address_verification.Address_History_1.geo_blk;
	
	self.historydate := left.historydate;
	self.historydatetimestamp := left.historydatetimestamp;
	self := left.shell_input;
	self := [];
	)), seq);


// call boca_shell_inquiries function with the best fields instead of the original input PII
inquiries_prep := project(iid_prep, transform(risk_indicators.layout_bocashell_neutral,
	self.shell_input := left;
	self.age := 0;
	self := left;
	self := [];) );
	
best_inquiries := if(isFCRA, risk_indicators.Boca_Shell_Inquiries_FCRA(inquiries_prep, bsoptions, bsversion, gateways),
														risk_indicators.Boca_Shell_Inquiries(inquiries_prep, bsoptions, bsversion, gateways, datapermissionmask) );

with_best_inquiries := join(with_match_flags, best_inquiries, left.seq=right.seq,
	transform(risk_indicators.Layout_Boca_Shell,
		self.best_flags.inq_perbestssn := right.acc_logs.inquiryperssn	;
		self.best_flags.inq_adlsperbestssn := right.acc_logs.inquiryadlsperssn	;
		self.best_flags.inq_lnamesperbestssn := right.acc_logs.inquirylnamesperssn	;
		self.best_flags.inq_addrsperbestssn := right.acc_logs.inquiryaddrsperssn	;
		self.best_flags.inq_dobsperbestssn := right.acc_logs.inquirydobsperssn	;
		self.best_flags.inq_percurraddr := right.acc_logs.inquiryperaddr	;
		self.best_flags.inq_adlspercurraddr := right.acc_logs.inquiryadlsperaddr	;
		self.best_flags.inq_lnamespercurraddr := right.acc_logs.inquirylnamesperaddr	;
		self.best_flags.inq_ssnspercurraddr := right.acc_logs.inquiryssnsperaddr	;
		self.best_flags.inq_perbestphone := right.acc_logs.inquiryperphone	;
		self.best_flags.inq_adlsperbestphone := right.acc_logs.inquiryadlsperphone	;
		self.best_flags.inq_curraddr_ver_count := right.acc_logs.inquiry_addr_ver_ct	;
		self.best_flags.inq_bestfname_ver_count := right.acc_logs.inquiry_fname_ver_ct	;
		self.best_flags.inq_bestlname_ver_count := right.acc_logs.inquiry_lname_ver_ct	;
		self.best_flags.inq_bestssn_ver_count := right.acc_logs.inquiry_ssn_ver_ct	;
		self.best_flags.inq_bestdob_ver_count := right.acc_logs.inquiry_dob_ver_ct	;
		self.best_flags.inq_bestphone_ver_count	:= right.acc_logs.inquiry_phone_ver_ct	;
		self := left), left outer, keep(1));

// get the flags and counts for the rest of the best_flags section
IID_best_flags := risk_indicators.get_IID_Best_Flags(iid_prep, GLBPurpose, DPPApurpose, isFCRA, datarestrictionmask, datapermissionmask, bsversion, bsoptions);

with_best_flags := join(with_best_inquiries, IID_best_flags, left.seq=right.seq,
	transform(risk_indicators.Layout_Boca_Shell,
		self.best_flags.best_phone_phonetype := right.hphonetypeflag ; 
		self.best_flags.best_phone_phoneval := right.hphonevalflag;
		self.best_flags.best_phone_phonezip := right.pwphonezipflag;
		self.best_flags.curraddr_hriskaddrflag := right.hriskaddrflag;
		self.best_flags.best_ssn_dod := if(right.deceasedDate=0, '', (string)right.deceasedDate);
		self.best_flags.best_ssn_decsflag := right.decsflag;
		self.best_flags.best_ssn_ssndobflag := right.socsdobflag;
		self.best_flags.best_ssn_valid := right.socsvalflag;
		self.best_flags.adls_per_bestssn := right.adls_per_ssn_seen_18months;
		self.best_flags.addrs_per_bestssn := right.addrs_per_ssn;
		self.best_flags.adls_per_curraddr_curr := right.adls_per_addr_current;
		self.best_flags.ssns_per_curraddr_curr := right.ssns_per_addr_current;
		self.best_flags.phones_per_curraddr_curr := right.phones_per_addr_current;
		self.best_flags.adls_per_bestphone_curr := right.adls_per_phone_current;
		self.best_flags.adls_per_bestssn_c6 := right.adls_per_ssn_created_6months;
		self.best_flags.addrs_per_bestssn_c6 := right.addrs_per_ssn_created_6months;
		self.best_flags.adls_per_curraddr_c6 := right.adls_per_addr_created_6months;
		self.best_flags.ssns_per_curraddr_c6 := right.ssns_per_addr_created_6months;
		self.best_flags.phones_per_curraddr_c6 := right.phones_per_addr_created_6months;
		self.best_flags.adls_per_bestphone_c6 := right.adls_per_phone_created_6months;
		self := left;  // take everything else from the left
		));

		  
// ticket RQ-13363, they want all fields blanked out if the truedid=false. per MS-184, don't blank out some fields as they need to return special values for "not found" conditions.
with_best_flags_final := project(with_best_flags, 
	transform(risk_indicators.Layout_Boca_Shell, 
		self.best_flags.input_fname_isbestmatch := left.best_flags.input_fname_isbestmatch; //for the 'isbestmatch' fields, keep the value we calculated above (don't blank out)
		self.best_flags.input_lname_isbestmatch := left.best_flags.input_lname_isbestmatch; 
		self.best_flags.input_phone_isbestmatch := left.best_flags.input_phone_isbestmatch; 
		self.best_flags.input_ssn_isbestmatch   := left.best_flags.input_ssn_isbestmatch; 
		self.best_flags.best_phone_phonetype    := if(left.best_flags.input_phone_isbestmatch in ['-1','-2','-3'], 'Z', left.best_flags.best_phone_phonetype); 
		self.best_flags.best_phone_phoneval     := if(left.best_flags.input_phone_isbestmatch in ['-1','-2','-3'], '6', left.best_flags.best_phone_phoneval); 
		self.best_flags.best_phone_phonezip     := if(left.best_flags.input_phone_isbestmatch in ['-1','-2','-3'], '5', left.best_flags.best_phone_phonezip); 
		self.best_flags.best_ssn_decsflag       := if(left.best_flags.input_ssn_isbestmatch in ['-1','-2','-3'], '2', left.best_flags.best_ssn_decsflag); 
		self.best_flags.best_ssn_ssndobflag     := if(left.best_flags.input_ssn_isbestmatch in ['-1','-2','-3'], '3', left.best_flags.best_ssn_ssndobflag); 
		self.best_flags.best_ssn_valid          := if(left.best_flags.input_ssn_isbestmatch in ['-1','-2','-3'], '7', left.best_flags.best_ssn_valid); 
		self.best_flags.curraddr_hriskaddrflag  := if(left.truedid, left.best_flags.curraddr_hriskaddrflag, '5'); 
		self.best_flags                         := if(left.truedid, left.best_flags); //all other fields get blanked out if 'trueDID' is false
		self := left));
		
							
// output(best_prep, named('best_prep'));
// output(outfile, named('best_records_outfile'));	
// output(withBest, named('withBest'));	
// output(with_match_flags, named('with_match_flags'));	
// output(iid_prep, named('iid_prep'));
// output(inquiries_prep, named('inquiries_prep'));
// output(best_inquiries, named('best_inquiries'));
// output(with_best_inquiries, named('with_best_inquiries'));
// output(IID_best_flags, named('IID_best_flags'));
// output(with_best_flags, named('with_best_flags'));

return group(with_best_flags_final, seq);

end;
