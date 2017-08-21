import ut, liensV2;

export LJExtract(string filterType) := function

// party := choosen(liensv2.file_Hogan_party(date_vendor_last_reported < '20091121' and zip in fds_test.ZipcodeSet), 500); //testing
party := liensv2.file_liens_party;

// main := liensv2.file_Hogan_main; //testing
main := liensv2.file_liens_main;

searchString := if(stringlib.stringtolowercase(filterType[1]) = 'l', '(tax)|(lien)|(warrant)','(judgment)|(judgement)|(judgments)');

liens_zipfilter := dedup(sort(party(date_vendor_last_reported < '20091121' and zip in fds_test.ZipcodeSet), tmsid, did, lname, fname, bdid, cname, -prim_name), tmsid, did, lname, fname, bdid, cname);

MainForJoin := dedup(sort(main(regexfind(searchString, stringlib.stringtolowercase(filing_type_desc + orig_filing_type))), tmsid, -filing_date, -release_date, -case_number, -filing_number, -orig_filing_number), tmsid);

JnToParty := join(MainForJoin, liens_zipfilter, 
							left.tmsid = right.tmsid,
							lookup, many);

DblChkJn := dedup(sort(JnToParty(zip in fds_test.ZipcodeSet and regexfind(searchString, stringlib.stringtolowercase(filing_type_desc + orig_filing_type))), tmsid,  did, lname, fname, bdid, cname, -filing_date, -release_date, -case_number), tmsid,  did, lname, fname, bdid, cname);

GetAttorneys := sort(join(DblChkJn(name_type <> 'A'), dedup(DblChkJn(name_type = 'A'), tmsid, all),
							left.tmsid = right.tmsid,
							transform({recordof(DblChkJn), string attorney, unsigned8 counted := 1},
								self.attorney := stringlib.stringcleanspaces(trim(left.lname, left, right) + ', ' + left.fname + ' ' + left.mname);
								self.did  := if((unsigned6)left.did = 0, '', left.did);
								self.bdid  := if((unsigned6)left.bdid = 0, '', left.bdid);
								self := left), lookup, left outer), zip, fname, lname, cname);

output_layoutL := RECORD
  string sourcezip;
  string record_id;
  string ssn;
  string first_name;
  string middle_name;
  string last_name;
  string company_name;
  string address1;
  string address2;
  string city;
  string state;
  string zip_code;
  string association_;
  string chapter;
  string case_number;
  string secondary_case_number;
  string filing_date;
  string disposition;
  string release_date;
  string amount;
  string plaintiff_firm;
  string book_number;
  string court_id;
  string court;
  string trustee;
  string attorney;
  string filing_type_desc;
  string filing_jurisdiction;
  string filing_state;
  string orig_filing_type;
  string judge;
  string case_title;
  string filing_page;
  string eviction;
  string satisifaction_type;
  string judg_satisfied_date;
  string judg_vacated_date;
  string tax_code;
  string irs_serial_number;
  string effective_date;
  string lapse_date;
  string accident_date;
  string sherrif_indc;
  string expiration_date;
  string agency_city;
  string agency_state;
  string agency_county;
  string legal_lot;
  string legal_block;
  string legal_borough;
  string certificate_number;
  unsigned8 counted := 1;
  string did; string bdid;
 END;

output_layoutJ := RECORD
  string sourcezip;
  string record_id;
  string ssn;
  string first_name;
  string middle_name;
  string last_name;
  string company_name;
  string address1;
  string address2;
  string city;
  string state;
  string zip_code;
  string case_number;
  string secondary_case_number;  
	string association_;
  string chapter;
  string filing_date;
  string disposition;
  string release_date;
  string amount;
  string plaintiff_firm;
  string book_number;
  string court_id;
  string court;
  string trustee;
  string attorney;
  string filing_type_desc;
  string filing_jurisdiction;
  string filing_state;
  string orig_filing_type;
  string judge;
  string case_title;
  string filing_page;
  string eviction;
  string satisifaction_type;
  string judg_satisfied_date;
  string judg_vacated_date;
  string tax_code;
  string irs_serial_number;
  string effective_date;
  string lapse_date;
  string accident_date;
  string sherrif_indc;
  string expiration_date;
  string agency_city;
  string agency_state;
  string agency_county;
  string legal_lot;
  string legal_block;
  string legal_borough;
  string certificate_number;
  unsigned8 counted := 1;
  string did; string bdid;
 END;

removals := record
  unsigned8 counted := 1; string did; string bdid;
end;

prFile := dedup(sort(distribute(project(GetAttorneys, transform(output_layoutL, 
						self.ssn := if((unsigned8)left.ssn > 0, left.ssn, left.app_ssn);
						self.first_Name := left.fname;
						self.middle_Name := left.mname;
						self.last_Name := left.lname;
						self.company_name := ut.CleanCompany(left.cname);
						self.Address1 := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.addr_suffix + ' ' + left.postdir);
						self.Address2 := stringlib.stringcleanspaces(left.unit_desig + ' ' + left.sec_range);
						self.City := left.p_city_name;
						self.State := left.st;
						self.Zip_Code := left.zip + left.zip4;
						self.association_ := '';
						self.chapter := '';
						self.case_number := left.filing_number;
						self.secondary_case_number := if(left.orig_filing_number <> '', left.orig_filing_number, left.case_number);
						self.filing_date := if(left.filing_date <> '', left.filing_date, left.orig_filing_date);
						self.disposition := '';
						self.release_date := left.release_date;
						self.amount := left.amount;
						self.plaintiff_firm := '';
						self.book_number := left.filing_book;
						self.court_ID := '';;
						self.court := left.agency;
						self.trustee := '';
						self.attorney := if(length(trim(left.attorney, all)) < 2, '', left.attorney);	
						self.sourcezip := left.zip[1..5];
						// self.counted := if(left.did = left.did or left.bdid = left.bdid or (left.lname = left.lname and left.fname = left.fname) or left.cname = left.cname,
																// left.counted, left.counted + 1);
						self.record_id := '';
						self := left)), hash(first_name, last_name, company_name)),record), record);
						
recordID_Assignment := iterate(prFile, transform(output_layoutL,
																	format_date(string8 indate) := function
																			yyyy := if(indate[1..4] <> '', indate[1..4], '0000');
																			mm := if(indate[5..6] <> '', indate[5..6], '00');
																			dd :=  if(indate[7..8] <> '' and mm <> '00', indate[7..8], '00');
																	return stringlib.stringfindreplace(mm+dd+yyyy, '00000000', '');
																	end;
																			self.filing_date := format_date(right.filing_date);
																			self.release_date := format_date(right.release_date);
																			self.record_id := (string)if(ut.nbeq(left.did,right.did) or ut.nbeq(left.bdid ,right.bdid) or (ut.nbeq(left.last_name,right.last_name) and ut.nbeq(left.first_name,right.first_name)) or ut.nbeq(left.company_name,right.company_name),
																														left.record_id, (string)counter);
																			self.counted := if(self.record_id = left.record_id, left.counted + 1, 1);
																			self := right))(counted <= 5);

// return recordID_Assignment;											
return if(stringlib.stringtolowercase(filterType[1]) = 'l', 
					project(recordID_Assignment, output_layoutL - removals),
					project(recordID_Assignment, transform(output_layoutJ - removals, self := left)));
end;