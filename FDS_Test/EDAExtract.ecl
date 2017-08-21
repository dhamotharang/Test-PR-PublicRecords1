import gong, risk_indicators, yellowpages, cellphone;

export EDAExtract := module

inConsumer := fds_test.files.input.CleanConsumerRec;

matched_layout := record
	recordof(fds_test.files.input.ConsumerRec);
	fds_did := inConsumer.did;
	fds_bdid := inConsumer.bdid;
	fds_app_ssn := inConsumer.app_ssn;
	fds_app_tax_id := inConsumer.app_tax_id;
	recordof(gong.File_History);
	string25 matched_code := '';
	string9 app_ssn := '';
	string9 app_tax_id := '';
end;

infile := dedup(sort(distribute(dataset('~fds::eda_ready', matched_layout, thor)(~regexfind('[0-9]', name_first + name_last + name_middle) and  name_first <> '' and name_last <> '' and z5 in fds_test.ZipcodeSet), hash(did, name_first, name_last, prim_name)), did, name_first, name_last, prim_name, -err_stat[1..1], z5, phone10), did, name_first, name_last, prim_name, z5, phone10);

iPrepped_Layout := record
	fds_test.layouts.EDA_Extract;
	unsigned6 counted;
end;

prInfile := project(infile, transform(iPrepped_layout,
	self.record_id := if(left.did = 0, (string)hash(left.name_first, left.name_last, left.prim_name, left.z5), (string)left.did);
	self.sourcezip := left.z5[1..5];
	self.first_Name := left.name_first;
	self.middle_Name := left.name_middle;
	self.last_Name := left.name_last;
	self.Address1 := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.suffix + ' ' + left.postdir);
	self.Address2 := stringlib.stringcleanspaces(left.unit_desig + ' ' + left.sec_range);
	self.City_ := left.p_city_name;
	self.State_ := left.St;
	self.Zip_Code_ := left.Z5 + left.z4;
	self.address_type := left.rec_type;
	self.MSA := left.MSA;
	self.county := left.county_code;
	self.phone := left.phone10;
	self.line_type := '';
	self.original_carrier := '';
	self.last_update := left.dt_first_seen;
	self.first_reported := left.filedate[1..8];
	self := []));

IterateInfile := iterate(group(prInfile, record_id), transform(iPrepped_Layout, 
	self.counted := counter;
	self := right));
	
no_address_records := IterateInfile(address1 = '' and zip_code_ = '');
address_records := IterateInfile(address1 <> '' or zip_code_ <> '');

keep_no_address_records := join(address_records, no_address_records, 
								left.first_name = right.first_name and 
								left.last_name = right.last_name and 
								left.zip_code_ = right.zip_code_ and 
								left.phone = right.phone,
									transform(recordof(IterateInfile), self := right), right outer);
									
addr_comb := keep_no_address_records + address_records;

srtAddr_Comb := dedup(sort(addr_comb, record), record);
								
yellowpages.NPA_PhoneType(srtAddr_Comb, phone, phone_type, outfile, false);

outfile2 := outfile : persist('~fds_eda_extract_npa');

jocn_applied2	:= sort(join(outfile2,risk_indicators.File_Telcordia_tpm,
						left.phone[1..7]= right.npa+right.nxx+right.tb,
							transform(recordof(fds_test.layouts.EDA_Extract), 
								self.original_carrier := right.ocn; 
								self.line_type := if(left.phone <> '', stringlib.stringfindreplace(left.phone_type, 'POTS', 'LANDLINE'), '');
								self.county := left.county[3..5];
								self.last_update := left.last_update[5..8] + left.last_update[1..4];
								self.first_reported := left.first_reported[5..8] + left.first_reported[1..4];
								self := left),  
						left outer,lookup), record); 
						
						
														
shared ocn_applied2 := iterate(jocn_applied2, transform(recordof(jocn_applied2),
															// self.record_id := (string)counter;
															SELF.record_id :=if(counter = 1, '1', 
																					if(right.last_name = left.last_name and right.first_name = left.first_name and
																						right.address1 = left.address1 and left.zip_code_[1..5] = right.zip_code_[1..5],
																							left.record_id,
																							(string)(1 + (unsigned6)left.record_id)));
															self := right));								

export  outputfile := output(ocn_applied2(phone <> ''),,'~thor_data400::out::fds::eda::extract', overwrite,csv(separator('|')));

pop_layout := record
	decimal10_2 sourcezip := count(group, ocn_applied2.sourcezip <> '');
	decimal10_2 record_ID := count(group, ocn_applied2.record_ID <> '');
	decimal10_2 first_Name := count(group, ocn_applied2.first_Name <> '');
	decimal10_2 middle_Name := count(group, ocn_applied2.middle_Name <> '');
	decimal10_2 last_Name := count(group, ocn_applied2.last_Name <> '');
	decimal10_2 Address1 := count(group, ocn_applied2.Address1 <> '');
	decimal10_2 Address2 := count(group, ocn_applied2.Address2 <> '');
	decimal10_2 City_ := count(group, ocn_applied2.City_ <> '');
	decimal10_2 State_ := count(group, ocn_applied2.State_ <> '');
	decimal10_2 Zip_Code_ := count(group, ocn_applied2.Zip_Code_ <> '');
	decimal10_2 address_type := count(group, ocn_applied2.address_type <> '');
	decimal10_2 MSA := count(group, ocn_applied2.MSA <> '');
	decimal10_2 county := count(group, ocn_applied2.county <> '');
	decimal10_2 phone := count(group, ocn_applied2.phone <> '');
	decimal10_2 line_type := count(group, ocn_applied2.line_type <> '');
	decimal10_2 original_carrier := count(group, ocn_applied2.original_carrier <> '');
	decimal10_2 last_update := count(group, ocn_applied2.last_update <> '');
	decimal10_2 first_reported := count(group, ocn_applied2.first_reported <> '');

end;

export stats := parallel( 
		output(ocn_applied2(phone <> ''));
		output(choosen(ocn_applied2(phone <> ''), 1000),,'~thor_data400::out::fds::eda::extract_qa', overwrite),
		output(sort(table(ocn_applied2(phone <> ''), {sourcezip, count_ := count(group)}, sourcezip, few), sourcezip), all,named('ExtractZipMatches'));
		output(table(ocn_applied2(phone <> ''), pop_layout, '1', few), named('ExtractFieldPopulations')));
end;