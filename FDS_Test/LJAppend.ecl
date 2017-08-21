import ut, liensv2, lib_stringlib;
export LJAppend := module

prePubRec_clean := fds_test.fnPublic_Record_Clean;

pubrec_clean := project(prePubRec_clean, transform(recordof(prePubRec_clean), 
														self.st := left.state,
														self.p_city_name := if(left.p_city_name <> '', left.p_city_name, left.city),
														self.zip := if(left.zip <> '', left.zip, left.zip_code);
														self := left));
//first match party

search_lj := dataset('~thor_200::persist::fds::liens_party', LiensV2.Layout_liens_party_ssn, thor); //large multiple files

jnParty_layout := record
recordof(PubRec_clean);
	search_lj.tmsid;
	search_lj.rmsid;
	search_lj.cname;
	search_lj.phone;
	search_lj.name_type;
	search_lj.date_first_seen;
	search_lj.date_last_seen;
	search_lj.date_vendor_first_reported;
	search_lj.date_vendor_last_reported;
	string9 zip_set_match;
	string25 matchrank := '';
	string73 attorney := '';
end;

jnParty_layout jnAppendParty(LiensV2.Layout_liens_party_ssn le, PubRec_clean ri) := transform
	self.tmsid := le.tmsid;
	self.rmsid := le.rmsid;
	self.cname := le.cname;
	self.phone := le.phone;
	self.name_type := le.name_type;
	self.date_first_seen := le.date_first_seen;
	self.date_last_seen := le.date_last_seen;
	self.date_vendor_first_reported := le.date_vendor_first_reported;
	self.date_vendor_last_reported := le.date_vendor_last_reported;
	self.zip_set_match := le.zip;
	self.fname := le.fname;
	self.lname := le.lname;
	self.mname := le.mname;
	self.name_suffix := le.name_suffix;
	self.prim_range := le.prim_range;	
	self.predir := le.predir;	
	self.prim_name := le.prim_name;
	self.addr_suffix := le.addr_suffix;	
	self.postdir := le.postdir;	
	self.unit_desig := le.unit_desig;
	self.sec_range := le.sec_range;
	self.p_city_name := le.p_city_name;
	self.v_city_name := le.v_city_name;
	self.st := le.st;
	self.zip := le.zip;
	self.zip4 := le.zip4;
	self.cart := le.cart;
	self.cr_sort_sz := le.cr_sort_sz;
	self.lot := le.lot;
	self.lot_order := le.lot_order;
	self.dbpc := le.dbpc;
	self.chk_digit := le.chk_digit;
	self.rec_type := le.rec_type;
	self.county := le.county;
	self.geo_lat := le.geo_lat;
	self.geo_long := le.geo_long;
	self.msa := le.msa;
	self.geo_blk := le.geo_blk;
	self.geo_match := le.geo_match;
	self.err_stat := le.err_stat;
	self.ssn := if(ri.ssn <> '', ri.ssn, if(ri.app_ssn <> '', ri.app_ssn, if(le.ssn <> '', le.ssn, le.app_ssn)));

	self.matchrank := map(
						(unsigned6)le.did = ri.did and ri.did > 0 => '01-did',
						(unsigned6)le.bdid = ri.bdid and ri.bdid > 0=> '02-bdid',
						le.ssn = ri.ssn and ri.ssn <> '' => '03-ssn',
						le.tax_id = ri.tax_id_number and ri.tax_id_number <> '' => '04-taxid',
						le.app_ssn = ri.ssn and ri.ssn <> '' => '05-appssn',
						le.app_tax_id = ri.tax_id_number and ri.tax_id_number <> '' => '06-apptaxid',
						le.fname = ri.fname and ri.fname <> '' and
							le.lname = ri.lname and ri.lname <> '' and
							le.st = ri.state and ri.state <> '' and 
							le.p_city_name = ri.p_city_name and ri.p_city_name <> '' and 
							le.prim_range = ri.prim_range and ri.prim_range <> '' => '07-namecitystprange',
						ut.CleanCompany(le.cname)[1..40] = ut.CleanCompany(ri.business_name)[1..40] and ri.business_name <> '' and
							le.st = ri.state and ri.state <> '' and
							le.p_city_name = ri.p_city_name and ri.p_city_name <> '' and 
							le.prim_range = ri.prim_range and ri.prim_range <> '' => '08-cnamecitystprange',
						le.fname = ri.fname and ri.fname <> '' and
							le.lname = ri.lname and ri.lname <> '' and
							le.zip = ri.zip and ri.zip <> '' => '09-namezip',							
						ut.CleanCompany(le.cname)[1..40] = ut.CleanCompany(ri.business_name)[1..40] and ri.business_name <> '' and
							le.zip = ri.zip and ri.zip <> '' => '10-cnamezip',							
						le.fname = ri.fname and ri.fname <> '' and
							le.lname = ri.lname and ri.lname <> '' and
							le.st = ri.state and ri.state <> '' and 
							le.p_city_name = ri.p_city_name and ri.p_city_name <> '' => '11-namestcity',
						ut.CleanCompany(le.cname)[1..40] = ut.CleanCompany(ri.business_name)[1..40] and ri.business_name <> '' and
							le.st = ri.state and ri.state <> '' and
							le.p_city_name = ri.p_city_name and ri.p_city_name <> '' => '12-cnamestcity',
						le.fname = ri.fname and ri.fname <> '' and
							le.lname = ri.lname and ri.lname <> '' and
							le.st = ri.state and ri.state <> '' => '13-namest',
						ut.CleanCompany(le.cname)[1..40] = ut.CleanCompany(ri.business_name)[1..40] and ri.business_name <> '' and
							le.st = ri.state and ri.state <> '' =>  '14-cnamest',
						le.prim_name = ri.prim_name and ri.prim_name <> '' and
							le.sec_range = ri.sec_range and ri.sec_range <> '' and
							le.p_city_name = ri.p_city_name and ri.p_city_name <> '' and
							le.st = ri.state and ri.state <> '' and 
							le.prim_range = ri.prim_range and ri.prim_range <> ''=> '15-addr',
						le.fname = ri.fname and ri.fname <> '' and
							le.lname = ri.lname and ri.lname <> '' => '16-name',
						le.lname = ri.lname and ri.lname <> '' and
							le.st = ri.state and ri.state <> '' and
							le.p_city_name = ri.p_city_name and ri.p_city_name <> '' and
							le.prim_range = ri.prim_range and ri.prim_range <> '' => '17-lnamestcityprange',
						ut.CleanCompany(le.cname)[1..40] = ut.CleanCompany(ri.business_name)[1..40] and  ri.business_name <> '' => '18-cname',
						'99');
	self := ri;
end;

//perform matching
jndidparty := join(search_lj(name_type <> 'A'), PubRec_clean(did > 0), right.did = (unsigned8)left.did, jnAppendParty(left, right), lookup);
jnbdidparty := join(search_lj(name_type <> 'A'), PubRec_clean(bdid > 0), right.bdid = (unsigned8)left.bdid, jnAppendParty(left, right), lookup);
jnssnapnparty := join(search_lj(name_type <> 'A'), PubRec_clean(app_ssn <> ''), (unsigned8)left.app_ssn = (unsigned8)right.ssn, jnAppendParty(left, right), lookup);
jnfeinapnparty := join(search_lj(name_type <> 'A'), PubRec_clean(tax_id_number <> ''), left.app_tax_id = right.tax_id_number, jnAppendParty(left, right), lookup);

jnssnparty := join(search_lj(name_type <> 'A'), PubRec_clean(ssn <> ''), (unsigned8)right.ssn = (unsigned8)left.ssn, jnAppendParty(left, right), lookup);
jnfeinparty := join(search_lj(name_type <> 'A'), PubRec_clean(tax_id_number <> ''), left.tax_id = right.tax_id_number, jnAppendParty(left, right), lookup);
jnnameparty := join(search_lj(name_type <> 'A'), PubRec_clean(fname <> '' and lname <> ''), left.fname = right.fname and left.lname = right.lname, jnAppendParty(left, right), lookup);
jnaddrparty := join(search_lj(name_type <> 'A'), PubRec_clean(fname <> '' and lname <> ''), 
									left.prim_range = right.prim_range and 
									left.prim_name = right.prim_name and 
									left.zip = right.zip, 
										jnAppendParty(left, right), lookup);
										
jncnameparty := join(search_lj(name_type <> 'A'), PubRec_clean(business_name <> ''), ut.CleanCompany(left.cname)[1..40] = ut.CleanCompany(right.business_name)[1..40], jnAppendParty(left, right), lookup);

//sort and dedup findings by recid and tmsid and highest ranking match type
precollect_search := dedup(sort(distribute(jncnameparty + jndidparty + jnbdidparty + jnssnapnparty + jnfeinapnparty + jnssnparty + jnfeinparty + jnnameparty + jnaddrparty, hash(record_id, tmsid)), record_id, tmsid, matchrank, local), record_id, tmsid, local) : persist('~thor_200::persist::fds::party_match');

find_attorney := dedup(join(search_lj(name_type = 'A' and lname <> '' and ~regexfind('PRO SE', lname+fname)), precollect_search, left.tmsid = right.tmsid, 
					 transform({string tmsid, string rmsid, string name}, self.name := left.lname + ', ' + left.fname, self := left), local)
						(name <> ''), tmsid, all);

collect_search := join(precollect_search, find_attorney, left.tmsid = right.tmsid, 
						transform(jnParty_layout, self.attorney := right.name, self := left), lookup, left outer)(matchrank[1..2] not in ['16','17','18','99']);

											
// second match main

main_lj := distribute(dataset('~thor_200::persist::fds::liens_main', liensv2.layout_liens_main_module.layout_liens_main, thor)
											(regexfind('(tax)|(lien)|(warrant)|(judgment)|(judgement)|(judgments)', 
													stringlib.stringtolowercase(filing_type_desc + orig_filing_type))), hash(tmsid));

full_layout := record
jnParty_layout;
// SSN - in party
// name - in party
// address - in party
// association - bank
// chapter - bank
string filing_number; // case number
string orig_filing_number; // secondary case number
string filing_date; // filing date
string orig_filing_date;
// disposition - bank
string release_date; // release date
string amount; // amount
// plaintiff firm - n/a
string filing_book; // book number
// court ID - bank
string agency;// court
// trustee - bank
// attorney - in party
string filing_type_desc;
string filing_jurisdiction := '';
string filing_state := '';
string orig_filing_type := '';
string orig_filing_time := '';
string lncase_number   := '';
string filing_time := '';
string vendor_entry_date := '';
string judge := '';
string case_title := '';
string filing_page := '';
string eviction := '';
string satisifaction_type := '';
string judg_satisfied_date := '';
string judg_vacated_date := '';
string tax_code := '';
string irs_serial_number := '';
string effective_date := '';
string lapse_date := '';
string accident_date := '';
string sherrif_indc := '';
string expiration_date := '';
string agency_city :='';
string agency_state :='';
string agency_county :='';
string legal_lot := '';
string legal_block := '';
string legal_borough := '';
string certificate_number := '';
end;

jnmain := dedup(sort(join(main_lj, distribute(collect_search, hash(tmsid)), left.tmsid = right.tmsid, 
					transform(full_layout, self.lncase_number := left.case_number, self := right, self := left), local),
						record_id, tmsid, matchrank, local), record_id, tmsid, local);


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

appended_data := jnmain;

trim_output_layout := record
	fds_test.Layouts.input.pubrec.record_id;
	appended_data.ssn;
	
	first_name := appended_data.fname ;
	middle_name := appended_data.mname ;
	last_name := appended_data.lname ;
	company_name := appended_data.cname ;
	
	string street_address := '';
	string secondary_address := '';
	city := appended_data.p_city_name;
	state := appended_data.st;
	string zip;
	
	string association := '';
	string chapter := '';
	string case_number := '';
	string secondary_case_number := '';
	appended_data.filing_date;
	string disposition := '';
	appended_data.release_date;
	appended_data.amount;
	string plaintiff_firm := '';
	book_number := appended_data.filing_book ;
	string court_id := '';
	court := appended_data.agency;
	string trustee := '';
	appended_data.attorney;
	
appended_data.filing_type_desc;
appended_data.filing_jurisdiction;
appended_data.filing_state;
appended_data.orig_filing_type;
appended_data.judge;
appended_data.case_title;
appended_data.filing_page;
appended_data.eviction;
appended_data.satisifaction_type;
appended_data.judg_satisfied_date;
appended_data.judg_vacated_date;
appended_data.tax_code;
appended_data.irs_serial_number;
appended_data.effective_date;
appended_data.lapse_date;
appended_data.accident_date;
appended_data.sherrif_indc;
appended_data.expiration_date;
appended_data.agency_city;
appended_data.agency_state;
appended_data.agency_county;
appended_data.legal_lot;
appended_data.legal_block;
appended_data.legal_borough;
appended_data.certificate_number;
appended_data.matchrank;
end;
	
trim_output_layout tRefAppends(appended_data le) := transform
format_date(string8 indate) := function
	yyyy := if(indate[1..4] <> '', indate[1..4], '0000');
	mm := if(indate[5..6] <> '', indate[5..6], '00');
	dd :=  if(indate[7..8] <> '' and mm <> '00', indate[7..8], '00');
return stringlib.stringfindreplace(mm+dd+yyyy, '00000000', '');
end;

	self.first_name := le.fname;
	self.middle_name := le.mname;
	self.last_name := le.lname;
	self.company_name := le.cname;
	self.street_address := 	stringlib.stringcleanspaces(le.prim_range + ' ' + le.predir + ' ' + le.prim_name + ' ' + le.addr_suffix + ' ' + le.postdir);
	self.secondary_address := stringlib.stringcleanspaces(le.unit_desig + ' ' + le.sec_range);
	self.city := le.p_city_name;
	self.state := le.st;
	self.zip := le.zip + le.zip4;
	self.case_number := if(le.orig_filing_number <> '', le.orig_filing_number,
							if(le.filing_number <> '', le.filing_number,
								if(le.lncase_number <> '', le.lncase_number, '')));
	self.secondary_case_number := if(self.case_number <> le.filing_number and le.filing_number <> '', le.filing_number,
									if(self.case_number <> le.case_number and le.lncase_number <> '', le.lncase_number, '')); 
	
	self.filing_date := if(format_date(le.orig_filing_date) <> '', format_date(le.orig_filing_date), format_date(le.filing_date));
	self.release_date := format_date(le.release_date);
	self.book_number := le.filing_book;
	self.court := le.agency;
	self := le;
end;

// export LJAppend_all := dataset('~thor_200::out::fds_test::ljappended', recordof(appended_data), thor);

prAppendBeforeSplit := project(appended_data, tRefAppends(left));
export LJAppend_goodonly := prAppendBeforeSplit(matchrank[1..2] not in ['16','17','18','99']);


// export LJAppend_prefile := 	output(filtered_good,,'~thor_200::out::fds_test::ljappended_projected', overwrite, __compressed__);

// export LJAppend_goodonly := 	dataset('~thor_200::out::fds_test::ljappended_projected', trim_output_layout, thor);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 filterliens :=			LJAppend_goodonly(regexfind('(tax)|(lien)|(warrant)', stringlib.stringtolowercase(filing_type_desc + orig_filing_type)));

	liens_iterate_layout := record fds_test.Layouts.liens_out; unsigned counted := 0; unsigned srtrecid := 0; end;
	
 prfilterliens :=		project(filterliens, transform(liens_iterate_layout, self.ssn := if((unsigned)left.ssn = 0, '', left.ssn);
																				self.srtrecid := (unsigned)left.record_id;
																				self := left));
																				
 in_addback_liens := 	dedup(sort(
								project(fds_test.Files.input.pubrec(record_id not in set(prfilterliens, record_id)),
											transform(liens_iterate_layout, 	self.srtrecid := (unsigned)left.record_id;
																				self.record_id := left.record_id;
																				self := [])) + 
								prfilterliens, 
						srtrecid, -filing_date[5..8], -release_date[5..8], -case_number, matchrank), 
						srtrecid, filing_date, case_number);
	
	liens_iterate_layout iterateLiensOut(liens_iterate_layout le, liens_iterate_layout ri, integer c) := transform
		self.counted := le.counted + 1;
		self := ri;
	end;		

export liens_out :=	sort(iterate(group(in_addback_liens, record_id), iterateLiensOut(left, right, counter)), srtrecid);

	pre_top5_liens := project(liens_out(counted < 6), transform(fds_test.Layouts.liens_out, self := left));
	
	top5_liens := join(pre_top5_liens, fds_test.Files.input.pubrec, left.record_id = right.record_id, transform(fds_test.Layouts.liens_out,
			self.FDS_Name := right.Name;
			self.FDS_Business_Name := right.Business_Name;
			self.FDS_Address := right.Address;
			self.FDS_Secondary_Address := right.Secondary_Address;
			self.FDS_City := right.City;
			self.FDS_State := right.State;
			self.FDS_Zip_Code := right.Zip_Code;
			self.FDS_Phone_Number := right.Phone_Number;
			self.FDS_SSN := right.SSN;
			self.FDS_Tax_ID_Number := right.Tax_ID_Number;
			self.FDS_Case_Number := right.Case_Number;
			self.FDS_Case_State := right.Case_State;
			self.FDS_Charter_Number := right.Charter_Number;
			self.FDS_Charter_State := right.Charter_State;
			self := left), left outer, lookup);
	
export top_Liens_Out := 	output(top5_liens,, '~thor_200::out::fds_test::liens_ouput_appends', overwrite, csv(separator('|')));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 filterjudgments :=		LJAppend_goodonly(stringlib.stringfind(stringlib.stringtolowercase(filing_type_desc + orig_filing_type), 'lien', 1) = 0 and
							regexfind('(judgment)|(judgement)|(judgments)', stringlib.stringtolowercase(filing_type_desc + orig_filing_type)));

	judgments_iterate_layout := record fds_test.Layouts.judgments_out; unsigned counted := 0; unsigned srtrecid := 0; end;

 prfilterjudgments :=	project(filterjudgments, transform(judgments_iterate_layout, self.ssn := if((unsigned)left.ssn = 0, '', left.ssn);
																				self.srtrecid := (unsigned)left.record_id;
																				self := left));

 in_addback_judgments := 	dedup(sort(project(fds_test.Files.input.pubrec(record_id not in set(prfilterjudgments, record_id)),
											transform(judgments_iterate_layout, 	self.srtrecid := (unsigned)left.record_id;
																				self.record_id := left.record_id;
																				self := [])) + prfilterjudgments, 
									srtrecid, -filing_date[5..8], -release_date[5..8], -case_number, matchrank), srtrecid, filing_date, case_number);
	
	judgments_iterate_layout iterateJudgmentsOut(judgments_iterate_layout le, judgments_iterate_layout ri, integer c) := transform
		self.record_id := (string10)trim(ri.record_id,all);
		self.counted := le.counted + 1;
		self := ri;
	end;		

export judgments_out :=			iterate(group(in_addback_judgments, record_id), iterateJudgmentsOut(left, right, counter));

	pre_top5_judgments := project(judgments_out(counted < 6), transform(fds_test.Layouts.judgments_out, self := left));
	
	top5_judgments := join(pre_top5_judgments, fds_test.Files.input.pubrec, left.record_id = right.record_id, transform(fds_test.Layouts.judgments_out,
			self.FDS_Name := right.Name;
			self.FDS_Business_Name := right.Business_Name;
			self.FDS_Address := right.Address;
			self.FDS_Secondary_Address := right.Secondary_Address;
			self.FDS_City := right.City;
			self.FDS_State := right.State;
			self.FDS_Zip_Code := right.Zip_Code;
			self.FDS_Phone_Number := right.Phone_Number;
			self.FDS_SSN := right.SSN;
			self.FDS_Tax_ID_Number := right.Tax_ID_Number;
			self.FDS_Case_Number := right.Case_Number;
			self.FDS_Case_State := right.Case_State;
			self.FDS_Charter_Number := right.Charter_Number;
			self.FDS_Charter_State := right.Charter_State;
			self := left), left outer, lookup);

	
export top_Judgments_Out := output(top5_judgments,, '~thor_200::out::fds_test::judgments_ouput_appends', overwrite, csv(separator('|'))); 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

end;