import gong, did_add, didville, business_header_ss, watchdog, business_header, ut, yellowpages, cellphone, risk_indicators;

export EDAAppend := module

/* //////// REQUESTED LAYOUT

record ID
name
address
address type
MSA
county
phone
line type
original carrier
last update
first reported

///////////////////// */

/////////// INPUT FILES - GONG Current and Consumer FDS
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

gongHBase := project(gong.File_History(current_record_flag = 'Y'), transform(matched_layout, self := left, self := []));

DID_Add.MAC_Add_SSN_By_DID(gongHBase, did, app_ssn, SSNAppended);
Business_Header_SS.MAC_Add_FEIN_By_BDID(SSNAppended, bdid, app_tax_id, SSNTAXID_App);

EDA_Ready := SSNTAXID_App : persist('~fds::eda_ready');
// EDA_ready := dataset('~fds::eda_ready',recordof(SSNTAXID_App), thor);

/////////// MATCHING

prepped_layout := record
	unsigned6 iRecord_ID := 0;
	unsigned6 counter_ := 0;	
	matched_layout;
end;

prepped_layout tMatchThem(matched_layout le, inConsumer ri) := transform

	self.matched_code := map(
						le.phone10 = ri.phone_number and ri.phone_number <> '' => '01-phone',	
						
						le.app_ssn = ri.ssn and ri.ssn <> '000000000' and
							le.name_last = ri.lname and ri.lname <> '' and
							le.name_first = ri.lname and ri.fname <> '' => '02-gappssnname',

						le.app_ssn[6..9] = ri.ssn[6..9] and ri.ssn <> '000000000' and
							le.name_last = ri.lname and ri.lname <> '' and
							le.name_first = ri.lname and ri.fname <> '' => '03-gappssn4name',
			
						le.name_first = ri.fname and ri.fname <> '' and
							le.name_last = ri.lname and ri.lname <> '' and
							le.st = ri.state and ri.state <> '' and 
							le.p_city_name = ri.p_city_name and ri.p_city_name <> '' and 
							le.prim_name = ri.prim_name and ri.prim_name <> ''  and 
							le.prim_range = ri.prim_range and ri.prim_range <> '' => '04-namecitystprangepname',
						
						le.name_first = ri.fname and ri.fname <> '' and
							le.name_last = ri.lname and ri.lname <> '' and
							le.z5 = ri.zip and ri.zip <> '' => '06-namestatebyzip',							
						
						le.name_first = ri.fname and ri.fname <> '' and
							le.name_last = ri.lname and ri.lname <> '' and
							le.st = ri.state and ri.state <> '' => '07-namest',
							
						trim((string20)le.did, all) = trim((string20)ri.did, all) and ri.did > 0 => '08-did',
					'99');
					
	self.fds_did := ri.did;
	self.fds_bdid := ri.bdid;
	self.fds_app_ssn := ri.app_ssn;
	self.fds_app_tax_id := ri.app_tax_id;	
	self.Record_ID := ri.Record_ID;
	self.Name := ri.Name;
	self.Business_Name := ri.Business_Name;
	self.Address := ri.Address;
	self.Secondary_Address := ri.Secondary_Address;
	self.City := ri.City;
	self.State := ri.State;
	self.Zip_Code := ri.Zip_Code;
	self.Phone_Number := ri.Phone_Number;
	self.SSN := ri.SSN;
	self.Tax_ID_Number := ri.Tax_ID_Number;
	self.VIN := ri.VIN;
	self.Craft_ID := ri.Craft_ID;
	self.License_Plate_Number := ri.License_Plate_Number;
	self.License_Plate_State := ri.License_Plate_State;
	self.iRecord_ID := (unsigned6)ri.record_id;
	self := le;
end;

DSJoinedLName := join(EDA_Ready, 
				inConsumer, 
				left.name_last = right.lname and right.lname <> '',
				tMatchThem(left, right),
				lookup);
DSJoinedDID := join(EDA_Ready, 
				inConsumer, 
				left.did = right.did and right.did > 0,
				tMatchThem(left, right),
				lookup);
DSJoinedSSN := join(EDA_Ready, 
				inConsumer, 
				left.app_ssn[6..9] = right.ssn[6..9] and right.ssn[6..9] <> '0000',
				tMatchThem(left, right),
				lookup);
DSJoinedPhone := join(EDA_Ready, 
				inConsumer, 
				left.phone10[4..10] = right.phone_number[4..10] and right.phone_number[4..10] <> '', 
				tMatchThem(left, right),
				lookup);
				
combined := (DSJoinedLName + DSJoinedDID + DSJoinedSSN + DSJoinedPhone)(matched_code[1..2] <> '99') : persist('~fds::eda_combined');

suppression_set := set(dedup(combined, record_id, all), record_id);

prConsumer := sort(distribute(project(inConsumer(record_id not in suppression_set), transform(prepped_layout,
														self.matched_code := '99';
														self.iRecord_ID := (unsigned6)left.record_id;
														self := left; self := [])) + combined, hash(irecord_id)), irecord_id, matched_code);

iPrepped_Layout := record
prConsumer.irecord_id;
prConsumer.counter_;
string matched_code;
fds_test.layouts.EDA_Append;
end;

iPrepped_Layout prepForIterate(prConsumer le) := transform
	self.Record_ID := le.Record_ID;
	self.Name := le.Name;
	self.Business_Name := le.business_name;
	self.Address := le.Address;
	self.Secondary_Address := le.Secondary_Address;
	self.City := le.City;
	self.State := le.State;
	self.Zip_Code := le.Zip_Code;
	self.Phone_Number := le.Phone_Number;
	self.SSN := le.SSN;
	self.Tax_ID_Number := le.Tax_ID_Number;
	self.VIN := le.vin;
	self.Craft_ID := le.craft_id;
	self.License_Plate_Number := le.License_Plate_Number;
	self.License_Plate_State := le.License_Plate_State;

	self.first_Name := le.name_first;
	self.middle_Name := le.name_middle;
	self.last_Name := le.name_last;
	self.Address1 := stringlib.stringcleanspaces(le.prim_range + ' ' + le.predir + ' ' + le.prim_name + ' ' + le.suffix + ' ' + le.postdir);
	self.Address2 := stringlib.stringcleanspaces(le.unit_desig + ' ' + le.sec_range);
	self.City_ := le.p_city_name;
	self.State_ := le.St;
	self.Zip_Code_ := le.Z5 + le.z4;
	self.address_type := le.rec_type;
	self.MSA := le.MSA;
	self.county := le.county_code;
	self.phone := le.phone10;
	self.line_type := '';
	self.original_carrier := '';
	self.last_update := le.dt_first_seen;
	self.first_reported := le.filedate[1..8];
	
	self.irecord_id := le.irecord_id;
	self.counter_ := 0;
	self.matched_code := le.matched_code;
end;

PreppedFile := iterate(group(project(prConsumer, prepForIterate(left)), record_id), 
							transform(iPrepped_Layout, 	self.counter_ := counter; self := right));

///////////// PHONE/LINE TYPES AND ORIG CARRIER

phoneit := 	PreppedFile(phone <> '');
									
yellowpages.NPA_PhoneType(phoneit, phone, phone_type, outfile1, false);

ocn_applied1	:= join(outfile1,risk_indicators.File_Telcordia_tpm,
						left.phone[1..7]= right.npa+right.nxx+right.tb,
					transform(iPrepped_Layout, 
								self.original_carrier := right.ocn; 
								self.line_type := left.phone_type;
								self := left), 
						left outer,lookup); 
					
phone_numberit := PreppedFile(phone = '');	
								
yellowpages.NPA_PhoneType(phone_numberit, phone_number, phone_type, outfile2, false);

ocn_applied2	:= join(outfile2,risk_indicators.File_Telcordia_tpm,
						left.phone_number[1..7]= right.npa+right.nxx+right.tb,
					transform(iPrepped_Layout, 
								self.original_carrier := right.ocn; 
								self.line_type := left.phone_type;
								self := left),  
						left outer,lookup); 
						
/////////// OUTPUTS

export phone_typed := sort(ocn_applied1 + ocn_applied2, record) : persist('~fds::eda_append_ready');
	
shared for_write := project(sort(dedup(phone_typed(counter_ <= 5), record, except irecord_id, except counter_, all), record), transform(fds_test.layouts.EDA_Append, 
																		self.phone := if(left.phone = '', left.phone_number, left.phone);
																		self.county := left.county[3..5];
																		self.line_type := if(self.phone = '', '', if(left.phone <> '', stringlib.stringfindreplace(left.line_type, 'POTS', 'LANDLINE'), ''));
																		self.last_update := left.last_update[5..8] + left.last_update[1..4];
																		self.first_reported := left.first_reported[5..8] + left.first_reported[1..4];
																		self := left));

export outputs := parallel(
output(choosen(phone_typed, 1000), named('AppendTest_TopN1000'));
output(choosen(phone_typed(matched_code[1..2] <> '99'), 100), named('AppendTest_TopN100Good'));

output(choosen(for_write, 1000),,'~thor_data400::out::fds::eda::append_qa', overwrite, __compressed__);
output(for_write,,'~thor_data400::out::fds::eda::append', overwrite,csv(separator('|')))
);

pop_layout := record
decimal10_2 Record_ID := count(group, for_write.Record_ID <> '');
decimal10_2 Name := count(group, for_write.Name <> '');
decimal10_2 Business_Name := count(group, for_write.Business_Name <> '');
decimal10_2 Address := count(group, for_write.Address <> '');
decimal10_2 Secondary_Address := count(group, for_write.Secondary_Address <> '');
decimal10_2 City := count(group, for_write.City <> '');
decimal10_2 State := count(group, for_write.State <> '');
decimal10_2 Zip_Code := count(group, for_write.Zip_Code <> '');
decimal10_2 Phone_Number := count(group, for_write.Phone_Number <> '');
decimal10_2 SSN := count(group, for_write.SSN <> '');
decimal10_2 Tax_ID_Number := count(group, for_write.Tax_ID_Number <> '');
decimal10_2 VIN := count(group, for_write.VIN <> '');
decimal10_2 Craft_ID := count(group, for_write.Craft_ID <> '');
decimal10_2 License_Plate_Number := count(group, for_write.License_Plate_Number <> '');
decimal10_2 License_Plate_State := count(group, for_write.License_Plate_State <> '');
decimal10_2 first_Name := count(group, for_write.first_Name <> '');
decimal10_2 middle_Name := count(group, for_write.middle_Name <> '');
decimal10_2 last_Name := count(group, for_write.last_Name <> '');
decimal10_2 Address1 := count(group, for_write.Address1 <> '');
decimal10_2 Address2 := count(group, for_write.Address2 <> '');
decimal10_2 City_ := count(group, for_write.City_ <> '');
decimal10_2 State_ := count(group, for_write.State_ <> '');
decimal10_2 Zip_Code_ := count(group, for_write.Zip_Code_ <> '');
decimal10_2 address_type := count(group, for_write.address_type <> '');
decimal10_2 MSA := count(group, for_write.MSA <> '');
decimal10_2 county := count(group, for_write.county <> '');
decimal10_2 phone := count(group, for_write.phone <> '');
decimal10_2 line_type := count(group, for_write.line_type <> '');
decimal10_2 original_carrier := count(group, for_write.original_carrier <> '');
decimal10_2 last_update := count(group, for_write.last_update <> '');
decimal10_2 first_reported := count(group, for_write.first_reported <> '');
end;

export stats := parallel( 
		output(table(dedup(phone_typed(counter_ <= 5), record, except irecord_id, except counter_, all), {matched_code, counted := count(group)}, matched_code, few), named('AppendMatches'));
		output(table(for_write, pop_layout, '1', few), named('AppendPops')));

end;