import Business_Header, ut, Address, _validate, mdr;

export fVickers_As_Business_Contact(

	 dataset(Layout_13d13g_Base					)	pFile_13d13g_Base
	,dataset(layout_insider_filing_base	) pFile_insider_filing_base
	,dataset(Layout_Insider_Security_In	) pFile_Insider_Security_In

) :=
function


	boolean CheckStreet(string100 street, string4 err_stat, string4 addr_suffix) := 
			 err_stat[1] = 'S' or
			 addr_suffix <> '' or
			 (integer)(street[1..stringlib.stringfind(street, ' ', 1)]) <> 0;


	set_non_employee_relationships := ['TR OFF', 'AT B/O', 'B/O', 'P', 'DIR', 'CBE', 'TTEE', 'ATTY-FT', 'AGNT', 'GEN CNSL',
									   'PLN CMTEE MBR', 'MBR', ' '];

	boolean CheckEmployeeRelationship(string20 rel) := rel[1] <> 'X' and rel not in set_non_employee_relationships;

  // Extract Business Contacts from 13d/13g file
	v_13g13d := pFile_13d13g_Base(filer_name <> '',
							                  trim(filer_name_first + filer_name_last, left, right) = '');

	Business_Header.Layout_Business_Contact_Full_New Translate_Vickers_13g13d_To_BCF(Layout_13d13g_Base l, unsigned1 c) := transform
	temp_dt_first_seen := map(length(trim(l.filing_date)) = 8 => l.filing_date,
													  length(trim(l.entered_date)) = 8 => l.entered_date,
														length(trim(l.upd_date)) = 8 => l.upd_date,
														'');
	temp_dt_last_seen := map(length(trim(l.upd_date)) = 8 and l.upd_date[3..] <> l.filing_date[3..] => l.upd_date,
													 length(trim(l.entered_date)) = 8 and l.entered_date[3..] <> l.filing_date[3..] => l.entered_date,
													 length(trim(l.filing_date)) = 8 => l.filing_date,
													 '');
																		
	self.source := MDR.sourceTools.src_Vickers;
	self.vl_id     := '';
	self.vendor_id := trim(l.cusip) + ',' + trim(l.form_id) + ',' + trim(l.filer_id) + ',' + l.form_type;
	self.dt_first_seen := if(_validate.date.fIsValid(temp_dt_first_seen) and _Validate.Date.fIsValid(temp_dt_first_seen, _Validate.Date.Rules.DateInPast), (unsigned4)temp_dt_first_seen, 0);
	self.dt_last_seen := if(_validate.date.fIsValid(temp_dt_last_seen) and _Validate.Date.fIsValid(temp_dt_last_seen, _Validate.Date.Rules.DateInPast) and (unsigned4)temp_dt_last_seen >= (unsigned4)temp_dt_first_seen, (unsigned4)temp_dt_last_seen, (unsigned4)temp_dt_first_seen);
	self.title := choose(c, l.signer_name_prefix, l.contact_name_prefix);
	self.fname := choose(c, l.signer_name_first, l.contact_name_first);
	self.mname := choose(c, l.signer_name_middle, l.contact_name_middle);
	self.lname := choose(c, l.signer_name_last, l.contact_name_last);
	self.name_suffix := choose(c, l.signer_name_suffix, l.contact_name_suffix);
	self.name_score := choose(c, Business_Header.CleanName(l.signer_name_first, l.signer_name_middle, l.signer_name_last, l.signer_name_suffix)[142],
								 Business_Header.CleanName(l.contact_name_first, l.contact_name_middle, l.contact_name_last, l.contact_name_suffix)[142]);
	self.email_address := '';
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := choose(c, 0, (unsigned6)Address.CleanPhone(l.contact_phone));
	self.company_title := choose(c, l.signer_title, '');
	self.company_name := Stringlib.StringToUpperCase(l.filer_name);
	self.company_source_group := '';
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	v_13g13d_contact_norm := normalize(v_13g13d, 2, Translate_Vickers_13g13d_To_BCF(left, counter));
	v_13g13d_contact_init := v_13g13d_contact_norm(lname <> '');

	// Join Vickers Insider Filings and Security
	layout_insider_filing_temp := record
	Layout_Insider_Filing_base;
	string30  issuer_name;
	end;

	v_insider_filing := pFile_insider_filing_base(cusip <> '');
	v_insider_filing_dist := distribute(v_insider_filing, hash(cusip));

	v_insider_security := dedup(pFile_Insider_Security_In(cusip <> ''), cusip, all);
	v_insider_security_dist := distribute(v_insider_security, hash(cusip));

	layout_insider_filing_temp AddIssuerName(Layout_Insider_Filing_base l, Layout_Insider_Security_In r) := transform
	self.issuer_name := r.issuer_name;
	self := l;
	end;

	v_insider_filing_name := join(v_insider_filing_dist,
								  v_insider_security_dist,
								  left.cusip = right.cusip,
								  AddIssuerName(left, right),
								  local);

	Business_Header.Layout_Business_Contact_Full_New Translate_Vickers_Insider_Filing_To_BCF(layout_insider_filing_temp l, unsigned1 ctyp) := transform
	temp_dt_first_seen := map(length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
														length(trim(l.date_entered)) = 8 => l.date_entered,
														length(trim(l.upd_date)) = 8 => l.upd_date,
														'');
	temp_dt_last_seen := map(length(trim(l.upd_date)) = 8 => l.upd_date,
													 length(trim(l.date_entered)) = 8 => l.date_entered,
													 length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
													 '');

	self.source := MDR.sourceTools.src_Vickers;
	self.vl_id     := '';
	self.vendor_id := trim(l.cusip) + ',' + trim(l.form_id) + ',' + trim(l.filer_id) + ',' + l.form_type;
	self.dt_first_seen := if(_validate.date.fIsValid(temp_dt_first_seen) and _Validate.Date.fIsValid(temp_dt_first_seen, _Validate.Date.Rules.DateInPast), (unsigned4)temp_dt_first_seen, 0);
	self.dt_last_seen := if(_validate.date.fIsValid(temp_dt_last_seen) and _Validate.Date.fIsValid(temp_dt_last_seen, _Validate.Date.Rules.DateInPast) and (unsigned4)temp_dt_last_seen >= (unsigned4)temp_dt_first_seen, (unsigned4)temp_dt_last_seen, (unsigned4)temp_dt_first_seen);
	self.city := l.v_city_name;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142];
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.email_address := '';
	self.company_title := choose(ctyp, Stringlib.StringToUpperCase(l.relationship_desc),
															 '');
	self.company_name := choose(ctyp, Stringlib.StringToUpperCase(l.issuer_name),
															trim(stringlib.stringfindreplace(stringlib.StringToUpperCase(l.street), 'C/O', ' '), left));
	self.company_source_group := '';
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	// Filer is a person name who is an employee, Company name is issuer, street address belongs to issuer
	v_insider_filing_issuer_contact_init := project(v_insider_filing_name(trim(name_first + name_last, left, right) <> ''
											                                                 ,CheckEmployeeRelationship(relationship_alpha)
                                                                       ,CheckStreet(street, err_stat, addr_suffix))
		                                             ,Translate_Vickers_Insider_Filing_To_BCF(left, 1));

	// Filer is a person name, Company name in street field
	v_insider_filing_street_contact_init := project(v_insider_filing_name(trim(name_first + name_last, left, right) <> '',
											not CheckStreet(street, err_stat, addr_suffix),
											datalib.companyclean(trim(stringlib.stringfindreplace(stringlib.StringToUpperCase(street), 'C/O', ' '), left))[41..120] <> '' or
											ut.CompanySimilar100(ut.CleanCompany(issuer_name), ut.CleanCompany(trim(stringlib.stringfindreplace(stringlib.StringToUpperCase(street), 'C/O', ' '), left))) < 35),
		Translate_Vickers_Insider_Filing_To_BCF(left, 2));


	// Filer is a person name who is not an employee, Company name is issuer name, street address belongs to filer so blank company address
	Business_Header.Layout_Business_Contact_Full_New Translate_Vickers_Blank_Address_To_BCF(layout_insider_filing_temp l) := transform
	temp_dt_first_seen := map(length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
														length(trim(l.date_entered)) = 8 => l.date_entered,
														length(trim(l.upd_date)) = 8 => l.upd_date,
														'');
	temp_dt_last_seen := map(length(trim(l.upd_date)) = 8 => l.upd_date,
													 length(trim(l.date_entered)) = 8 => l.date_entered,
													 length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
													 '');
													 
	self.source := MDR.sourceTools.src_Vickers;
	self.vl_id     := '';
	self.vendor_id := trim(l.cusip) + ',' + trim(l.form_id) + ',' + trim(l.filer_id) + ',' + l.form_type;
	self.dt_first_seen := if(_validate.date.fIsValid(temp_dt_first_seen) and _Validate.Date.fIsValid(temp_dt_first_seen, _Validate.Date.Rules.DateInPast), (unsigned4)temp_dt_first_seen, 0);
	self.dt_last_seen := if(_validate.date.fIsValid(temp_dt_last_seen) and _Validate.Date.fIsValid(temp_dt_last_seen, _Validate.Date.Rules.DateInPast) and (unsigned4)temp_dt_last_seen >= (unsigned4)temp_dt_first_seen, (unsigned4)temp_dt_last_seen, (unsigned4)temp_dt_first_seen);
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142];
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.email_address := '';
	self.company_title := Stringlib.StringToUpperCase(l.relationship_desc);
	self.company_name :=  Stringlib.StringToUpperCase(l.issuer_name);
	// Blank the company street address
	self.company_prim_range := '';
	self.company_predir := '';
	self.company_prim_name := '';
	self.company_addr_suffix := '';
	self.company_postdir := '';
	self.company_unit_desig := '';
	self.company_sec_range := '';
	self.company_city := '';
	self.company_state := '';
	self.company_zip := 0;
	self.company_zip4 := 0;
	self.company_phone := 0;
	self.record_type := 'C';
	self := l;
	end;

	v_insider_filing_issuer_blank_contact_init := project(v_insider_filing_name(trim(name_first + name_last, left, right) <> '',
											not CheckEmployeeRelationship(relationship_alpha),
											CheckStreet(street, err_stat, addr_suffix)),
		Translate_Vickers_Blank_Address_To_BCF(left));

	// Blank Company Addressed for filings unless company name/address match to other business header records
	bh := Business_Header.File_Business_Header(not MDR.sourceTools.SourceIsVickers(source), zip <> 0, prim_name <> '');

	layout_nameaddr := record
	bh.match_company_name;
	bh.prim_range;
	bh.prim_name;
	bh.zip;
	end;

	bh_nameaddr := table(bh, layout_nameaddr);
	bh_nameaddr_dedup := dedup(bh_nameaddr, all);
	bh_nameaddr_dist := distribute(bh_nameaddr_dedup, hash(zip, prim_name, prim_range));

	v_insider_filing_contact_init := v_insider_filing_issuer_contact_init + v_insider_filing_street_contact_init + v_insider_filing_issuer_blank_contact_init;

	v_insider_filing_contact_blank_addr := v_insider_filing_contact_init(not(zip <> 0 and prim_name <> ''));
	v_insider_filing_contact_nonblank_addr := v_insider_filing_contact_init(zip <> 0 and prim_name <> '');
	v_insider_filing_contact_nonblank_addr_dist := distribute(v_insider_filing_contact_nonblank_addr, hash(zip, prim_name, prim_range));

	Business_Header.Layout_Business_Contact_Full_New BlankAddress(Business_Header.Layout_Business_Contact_Full_New l, layout_nameaddr r) := transform
	self.company_prim_range := if(r.zip = 0, '', l.company_prim_range);
	self.company_predir := if(r.zip = 0, '', l.company_predir);
	self.company_prim_name := if(r.zip = 0, '', l.company_prim_name);
	self.company_addr_suffix := if(r.zip = 0, '', l.company_addr_suffix);
	self.company_postdir := if(r.zip = 0, '', l.company_postdir);
	self.company_unit_desig := if(r.zip = 0, '', l.company_unit_desig);
	self.company_sec_range := if(r.zip = 0, '', l.company_sec_range);
	self.company_city := if(r.zip = 0, '', l.company_city);
	self.company_state := if(r.zip = 0, '', l.company_state);
	self.company_zip := if(r.zip = 0, 0, l.company_zip);
	self.company_zip4 := if(r.zip = 0, 0, l.company_zip4);
	self := l;
	end;

	v_insider_filing_contact_nonblank_fixed := join(v_insider_filing_contact_nonblank_addr_dist,
												  bh_nameaddr_dist,
												  left.company_zip = right.zip and
													left.prim_name = right.prim_name and
													left.prim_range = right.prim_range and
													ut.CompanySimilar100(ut.CleanCompany(left.company_name),right.match_company_name) <= 35,
												  BlankAddress(left, right),
												  left outer,
												  local);
												  
	v_insider_filing_contact_nonblank_fixed_dedup := 	dedup(v_insider_filing_contact_nonblank_fixed, all);									  


	vickers_contact_init := v_13g13d_contact_init + v_insider_filing_contact_nonblank_fixed_dedup + v_insider_filing_contact_blank_addr;

	vickers_contact_noroll := vickers_contact_init((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

	return vickers_contact_noroll;
  end
 ;
