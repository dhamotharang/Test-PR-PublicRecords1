import fcra, doxie, risk_indicators, ut, riskwise, avm_v2;

EXPORT _address_Data(
	dataset(layouts.layout_addresses_data_input) addresses_in, 
  dataset (fcra.Layout_override_flag) flag_file
) := function

dk := choosen(doxie.Key_FCRA_max_dt_last_seen, 1);
header_build_date := (unsigned3)dk[1].max_date_last_seen[1..6];
today := ut.GetDate;
DataRestriction := '000000000000000';

temp := record
	layouts.layout_addresses_data_input;
	unsigned6 did_from_addr;	
	string9 ssn_from_addr;
	string10 phone_from_addr;
	integer current_adls_per_address;
	integer current_ssns_per_address;
	integer current_phones_per_address;
	
	string8 avm_recording_date;
	string4 avm_assessed_value_year;
	integer avm_1_yr;
	integer avm_5_yrs;
end;

temp add_header_by_address(addresses_in le, Doxie.Key_FCRA_Header_Address rt) := transform
	self.DID_from_addr := rt.did;
	self.ssn_from_addr := rt.ssn;	
	
	self.current_adls_per_address := if(rt.did!=0 and rt.dt_last_seen>=header_build_date, 1, 0);
	self.current_ssns_per_address := if(trim(rt.ssn)!='' and rt.dt_last_seen>=header_build_date,1,0);
	self := le;
	self := [];
end;									
header_by_address := join(addresses_in, Doxie.Key_FCRA_Header_Address,
		left.prim_name!='' and left.zip!='' and
		keyed(left.prim_name=right.prim_name) and
		keyed(left.zip=right.zip) and 
		keyed(right.prim_range=left.prim_range) and
		left.predir=right.predir and 
		left.postdir=right.postdir and
		left.sec_range=right.sec_range and
		// filter out records we don't use in Riskview queries and records (bankruptcy and liens) that need to roll off the header after 7+ years
		~risk_indicators.iid_constants.filtered_source(right.src, right.st) and  
		((right.src='BA' and FCRA.bankrupt_is_ok(today,(string)right.dt_first_seen))
		OR (right.src='L2' and FCRA.lien_is_ok(today,(string)right.dt_first_seen))
		OR right.src not in ['BA','L2']),
		add_header_by_address(left,right), left outer, 
		atmost(left.prim_name=right.prim_name 
					and left.zip=right.zip
					and right.prim_range=left.prim_range, 1000), 
		keep(500));
															

// ssns per address counts
counts_per_ssn := table(header_by_address, {zip, prim_range, prim_name, predir, postdir, sec_range, ssn_from_addr,
															_current_ssns_per_address := count(group, current_ssns_per_address>0),
															}, zip, prim_range, prim_name, predir, postdir, sec_range, ssn_from_addr);									

ssns_per_address := table(counts_per_ssn, {zip, prim_range, prim_name, predir, postdir, sec_range,
															current_ssns_per_address := count(group, _current_ssns_per_address>0)
															}, zip, prim_range, prim_name, predir, postdir, sec_range);			

// ADL per address counts
counts_per_adl := table(header_by_address, {zip, prim_range, prim_name, predir, postdir, sec_range, did_from_addr, 
															_current_adls_per_address := count(group, current_adls_per_address>0),
															}, zip, prim_range, prim_name, predir, postdir, sec_range, did_from_addr);
															
adls_per_address := table(counts_per_adl, {zip, prim_range, prim_name, predir, postdir, sec_range, 
															current_adls_per_address := count(group, _current_adls_per_address>0)
															}, zip, prim_range, prim_name, predir, postdir, sec_range);	
															
						
with_ssns_per_address := join(addresses_in, ssns_per_address,
			left.zip=right.zip and 
			left.prim_range=right.prim_range and
			left.prim_name=right.prim_name and
			left.predir=right.predir  and
			left.postdir=right.postdir and
			left.sec_range=right.sec_range,
		transform(layouts.layout_addresses_data_output, 
			self.current_ssns_per_address := right.current_ssns_per_address,
			self := left, 
			self := []), left outer, keep(1) );	
			
with_adls_per_address := join(with_ssns_per_address, adls_per_address,
			left.zip=right.zip and
			left.prim_range=right.prim_range and
			left.prim_name=right.prim_name and
			left.predir=right.predir and
			left.postdir=right.postdir and
			left.sec_range=right.sec_range,
		transform(layouts.layout_addresses_data_output, 
			self.current_adls_per_address := right.current_adls_per_address,
			self := left), left outer, keep(1) );
	
	
dirs_prep := project(addresses_in, transform(Risk_Indicators.Layouts.Layout_Input_Plus_Overrides, 
	self.z5 := left.zip,
	self.addr_suffix := left.suffix,
	self := left,
self := []));

isFCRA := true;
dirs_by_addr := riskwise.getDirsByAddr(dirs_prep, isFCRA);

// ssns per address counts
counts_per_phone := table(dirs_by_addr(current_flag), {zip := z5, prim_range, prim_name, predir, postdir, sec_range, phone10[1..7],
															_current_phones_per_address := count(group),
															}, z5, prim_range, prim_name, predir, postdir, sec_range, phone10[1..7]);									

phones_per_address := table(counts_per_phone, {zip, prim_range, prim_name, predir, postdir, sec_range,
															current_phones_per_address := count(group, _current_phones_per_address>0)
															}, zip, prim_range, prim_name, predir, postdir, sec_range);		


with_phones_per_address := join(with_adls_per_address, phones_per_address,
			left.zip=right.zip and
			left.prim_range=right.prim_range and
			left.prim_name=right.prim_name and
			left.predir=right.predir and
			left.postdir=right.postdir and
			left.sec_range=right.sec_range,
		transform(layouts.layout_addresses_data_output, 
			self.current_phones_per_address := right.current_phones_per_address,
			self := left), left outer, keep(1) );
	

with_avm_history := join(addresses_in, avm_v2.Key_AVM_Address_FCRA,  
							left.prim_name!='' and left.zip!='' and
							keyed(left.prim_name = right.prim_name) and
							keyed(left.st = right.st) and
							keyed(left.zip = right.zip) and
							keyed(left.prim_range = right.prim_range) and
							keyed(left.sec_range = right.sec_range) and
							left.predir=right.predir and 
							left.postdir=right.postdir,
						transform(temp,
							// now that we have quarterly AVM snapshots, just select the september builds so we get yearly
							avm_history := sort(right.history(history_date[5..8]='0930'), -history_date);
							self.avm_1_yr := avm_history[1].automated_valuation;
							self.avm_5_yrs := avm_history[5].automated_valuation;
							self.avm_recording_date := right.recording_date;  // for selecting the property record with the most recent recording date
							self.avm_assessed_value_year := right.assessed_value_year;  // for selecting the property record with the most recent recording date
							self := left,
							self := []), left outer, 
								atmost(	left.prim_name=right.prim_name and
												left.st=right.st and
												left.zip=right.zip and 
												left.prim_range=right.prim_range and
												left.sec_range=right.sec_range, riskwise.max_atmost), keep(100));

// when choosing which AVM to output if the addr returns more than 1 result, 
// always pick the record with the most recent recording date and secondarily the most recent assessed value year
deduped_avm := dedup(sort(with_avm_history,  zip, prim_range, prim_name, predir, postdir, sec_range, -avm_recording_date, -avm_assessed_value_year),  
						zip, prim_range, prim_name, predir, postdir, sec_range);



			
with_avm := join(with_phones_per_address, deduped_avm,
			left.zip=right.zip and
			left.prim_range=right.prim_range and
			left.prim_name=right.prim_name and
			left.predir=right.predir and
			left.postdir=right.postdir and
			left.sec_range=right.sec_range,
		transform(layouts.layout_addresses_data_output, 
			self.avm_1_yr := right.avm_1_yr;
			self.avm_5_yrs := right.avm_5_yrs;
			self := left), left outer, keep(1) );
					

ds_override_flags := flag_file(file_id = FCRA.FILE_ID.ADDRESSES);

// now that we have everything appended to the input dataset, also check the fcra flag file to make sure
// the input address hasn't been corrected or suppressed	
roxie_raw_data := join(with_avm, ds_override_flags,
				trim((string)left.did)+trim(left.prim_range)+trim(left.prim_name)+trim(left.sec_range)+trim(left.zip)=right.record_id,
				transform(layouts.layout_addresses_data_output, self := left),
				left only);


override_data	:= dedup(join(ds_override_flags, fcra.key_override_avm.address_data,
	left.flag_file_id=right.flag_file_id,
		transform(layouts.layout_addresses_data_output, self := right)));

with_corrections := if(count(roxie_raw_data)>0, roxie_raw_data, override_data);

// output(counts_per_ssn, named('counts_per_ssn'));
// output(counts_per_adl, named('counts_per_adl'));	
// output(ssns_per_address, named('ssns_per_address'));	
// output(adls_per_address, named('adls_per_address'));	
// output(dirs_prep, named('dirs_prep'));
// output(dirs_by_addr, named('dirs_by_addr'));
// output(phones_per_address, named('phones_per_address'));
// output(with_phones_per_address, named('with_phones_per_address'));	
// output(with_avm_history, named('with_avm_history'));
// output(deduped_avm, named('deduped_avm'));
// output(with_avm, named('with_avm'));
// output(ds_override_flags, named('ds_override_flags'));
// output(roxie_raw_data, named('roxie_raw_data'));
// output(override_data, named('override_data'));

	return with_corrections;

END;