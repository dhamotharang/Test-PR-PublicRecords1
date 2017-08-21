import Business_Header, ut, Vickers, _validate, mdr;

export fVickers_As_Business_Header(

	 dataset(Layout_13d13g_base					)	pFile_13d13g_Base
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

	// Extract Business Filings from 13d/13g file
	v_13g13d := pFile_13d13g_Base(filer_name <> '',
							                  trim(filer_name_first + filer_name_last, left, right) = '');

	Business_Header.Layout_Business_Header_New Translate_Vickers_13g13d_To_BHF(Layout_13d13g_base l) := transform
	temp_dt_first_seen 				 := map(length(trim(l.filing_date)) = 8 => l.filing_date,
																		length(trim(l.entered_date)) = 8 => l.entered_date,
																		length(trim(l.upd_date)) = 8 => l.upd_date,
																		'');	
	temp_dt_last_seen  				 := map(length(trim(l.upd_date)) = 8 and l.upd_date[3..] <> l.filing_date[3..] => l.upd_date,
																		length(trim(l.entered_date)) = 8 and l.entered_date[3..] <> l.filing_date[3..] => l.entered_date,
																		length(trim(l.filing_date)) = 8 => l.filing_date,
																		'');
	temp_dt_ven_first_reported := map(length(trim(l.entered_date)) = 8 and l.entered_date[3..] <> l.filing_date[3..] => l.entered_date,
																		length(trim(l.upd_date)) = 8 and l.upd_date[3..] <> l.filing_date[3..] => l.upd_date,
																		length(trim(l.filing_date)) = 8 => l.filing_date,
																		'');						  
	temp_dt_ven_last_reported := map(length(trim(l.upd_date)) = 8 and l.upd_date[3..] <> l.filing_date[3..] => l.upd_date,
																	 length(trim(l.entered_date)) = 8 and l.entered_date[3..] <> l.filing_date[3..] => l.entered_date,
																	 length(trim(l.filing_date)) = 8 => l.filing_date,
																	 '');
																	 
	self.source := MDR.sourceTools.src_Vickers;
	self.source_group := '';
	self.vl_id := '';
	self.vendor_id := trim(l.cusip) + ',' + trim(l.form_id) + ',' + trim(l.filer_id) + ',' + l.form_type;
	
	self.dt_first_seen := if(_validate.date.fIsValid(temp_dt_first_seen) and _Validate.Date.fIsValid(temp_dt_first_seen, _Validate.Date.Rules.DateInPast), (unsigned4)temp_dt_first_seen, 0);
	self.dt_last_seen  := if(_validate.date.fIsValid(temp_dt_last_seen) and _Validate.Date.fIsValid(temp_dt_last_seen, _Validate.Date.Rules.DateInPast) and (unsigned4)temp_dt_last_seen >= (unsigned4)temp_dt_first_seen, (unsigned4)temp_dt_last_seen, (unsigned4)temp_dt_first_seen);
	self.dt_vendor_first_reported := if(_validate.date.fIsValid(temp_dt_ven_first_reported) and _Validate.Date.fIsValid(temp_dt_ven_first_reported, _Validate.Date.Rules.DateInPast), (unsigned4)temp_dt_ven_first_reported, 0);
	self.dt_vendor_last_reported  := if(_validate.date.fIsValid(temp_dt_ven_last_reported) and _Validate.Date.fIsValid(temp_dt_ven_last_reported, _Validate.Date.Rules.DateInPast) and (unsigned4)temp_dt_ven_last_reported >= (unsigned4)temp_dt_ven_first_reported, (unsigned4)temp_dt_ven_last_reported, (unsigned4)temp_dt_ven_first_reported);
	self.company_name := Stringlib.StringToUpperCase(l.filer_name);
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self.pflag := '0';
	self := l;
	end;

	v_13g13d_init := project(v_13g13d, Translate_Vickers_13g13d_To_BHF(left));

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

	Business_Header.Layout_Business_Header_New Translate_Vickers_Insider_Filing_To_BHF(layout_insider_filing_temp l, unsigned1 ctyp) := transform
	temp_dt_first_seen 					:= map(length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
																		 length(trim(l.date_entered)) = 8 => l.date_entered,
																		 length(trim(l.upd_date)) = 8 => l.upd_date,
																		 '');
	temp_dt_last_seen 				 := map(length(trim(l.upd_date)) = 8 => l.upd_date,
																		length(trim(l.date_entered)) = 8 => l.date_entered,
																		length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
																		'');
	temp_dt_ven_first_reported := map(length(trim(l.date_entered)) = 8 => l.date_entered,
																		length(trim(l.upd_date)) = 8 => l.upd_date,
																		length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
																		'');						  
	temp_dt_ven_last_reported  := map(length(trim(l.upd_date)) = 8 => l.upd_date,
																		length(trim(l.date_entered)) = 8 => l.date_entered,
																		length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
																		'');
	self.source := MDR.sourceTools.src_Vickers;
	self.source_group := '';
	self.vl_id := '';
	self.vendor_id := trim(l.cusip) + ',' + trim(l.form_id) + ',' + trim(l.filer_id) + ',' + l.form_type;
	self.dt_first_seen	:= if(_validate.date.fIsValid(temp_dt_first_seen) and _Validate.Date.fIsValid(temp_dt_first_seen, _Validate.Date.Rules.DateInPast), (unsigned4)temp_dt_first_seen, 0);
	self.dt_last_seen		:= if(_validate.date.fIsValid(temp_dt_last_seen) and _Validate.Date.fIsValid(temp_dt_last_seen, _Validate.Date.Rules.DateInPast) and (unsigned4)temp_dt_last_seen >= (unsigned4)temp_dt_first_seen, (unsigned4)temp_dt_last_seen, (unsigned4)temp_dt_first_seen);
	self.dt_vendor_first_reported := if(_validate.date.fIsValid(temp_dt_ven_first_reported) and _Validate.Date.fIsValid(temp_dt_ven_first_reported, _Validate.Date.Rules.DateInPast), (unsigned4)temp_dt_ven_first_reported, 0);						  
	self.dt_vendor_last_reported 	:= if(_validate.date.fIsValid(temp_dt_ven_last_reported) and _Validate.Date.fIsValid(temp_dt_ven_last_reported, _Validate.Date.Rules.DateInPast) and (unsigned4)temp_dt_ven_last_reported >= (unsigned4)temp_dt_ven_first_reported, (unsigned4)temp_dt_ven_last_reported, (unsigned4)temp_dt_ven_first_reported);
	self.company_name :=  choose(ctyp, Stringlib.StringToUpperCase(l.filer_name),
															 Stringlib.StringToUpperCase(l.issuer_name),
															 trim(stringlib.stringfindreplace(stringlib.StringToUpperCase(l.street), 'C/O', ' '), left));
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self.pflag := intformat(ctyp, 1, 1);
	self := l;
	end;

	// Filer is a company name, street address belongs to filer
	v_insider_filing_filer_init := project(v_insider_filing_name(trim(name_first + name_last, left, right) = '') 
		                                    ,Translate_Vickers_Insider_Filing_To_BHF(left, 1));

	// Filer is a person name who is an employee, Company name is issuer, street address belongs to issuer
	v_insider_filing_issuer_init := project(v_insider_filing_name(trim(name_first + name_last, left, right) <> ''
											                                         ,CheckEmployeeRelationship(relationship_alpha)
                                                               ,CheckStreet(street, err_stat, addr_suffix))
                                         ,Translate_Vickers_Insider_Filing_To_BHF(left, 2));
		
	// Filer is a person name, Company name in street field
	v_insider_filing_street_init := project(v_insider_filing_name(trim(name_first + name_last, left, right) <> ''
											                                         ,not CheckStreet(street, err_stat, addr_suffix)
											                                         ,datalib.companyclean(trim(stringlib.stringfindreplace(stringlib.StringToUpperCase(street), 'C/O', ' '), left))[41..120] <> '' or
											                                          ut.CompanySimilar100(ut.CleanCompany(issuer_name)
                                                                                    ,ut.CleanCompany(trim(stringlib.stringfindreplace(stringlib.StringToUpperCase(street), 'C/O', ' '), left))) < 35)
		                                     ,Translate_Vickers_Insider_Filing_To_BHF(left, 3));
		
	// Filer is a person name who is not an employee, Company name is issuer name, street address belongs to filer so blank company address
	Business_Header.Layout_Business_Header_New Translate_Vickers_Blank_Address_To_BHF(layout_insider_filing_temp l) := transform
	temp_dt_first_seen					:= map(length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
																		 length(trim(l.date_entered)) = 8 => l.date_entered,
																		 length(trim(l.upd_date)) = 8 => l.upd_date,
																		 '');
	temp_dt_last_seen 					:= map(length(trim(l.upd_date)) = 8 => l.upd_date,
																		 length(trim(l.date_entered)) = 8 => l.date_entered,
																		 length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
																		 '');
	temp_dt_ven_first_reported	:= map(length(trim(l.date_entered)) = 8 => l.date_entered,
																		 length(trim(l.upd_date)) = 8 => l.upd_date,
																		 length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
																		 '');						  
	temp_dt_ven_last_reported		:= map(length(trim(l.upd_date)) = 8 => l.upd_date,
																		 length(trim(l.date_entered)) = 8 => l.date_entered,
																		 length(trim(l.trans_date_from)) = 8 => l.trans_date_from,
																		 '');
	self.source := MDR.sourceTools.src_Vickers;
	self.source_group := '';
	self.vl_id := '';
	self.vendor_id := trim(l.cusip) + ',' + trim(l.form_id) + ',' + trim(l.filer_id) + ',' + l.form_type;
	self.dt_first_seen	:= if(_validate.date.fIsValid(temp_dt_first_seen) and _Validate.Date.fIsValid(temp_dt_first_seen, _Validate.Date.Rules.DateInPast), (unsigned4)temp_dt_first_seen, 0);
	self.dt_last_seen		:= if(_validate.date.fIsValid(temp_dt_last_seen) and _Validate.Date.fIsValid(temp_dt_last_seen, _Validate.Date.Rules.DateInPast) and (unsigned4)temp_dt_last_seen >= (unsigned4)temp_dt_first_seen,(unsigned4)temp_dt_last_seen, (unsigned4)temp_dt_first_seen);
	self.dt_vendor_first_reported := if(_validate.date.fIsValid(temp_dt_ven_first_reported) and _Validate.Date.fIsValid(temp_dt_ven_first_reported, _Validate.Date.Rules.DateInPast), (unsigned4)temp_dt_ven_first_reported, 0);						  
	self.dt_vendor_last_reported 	:= if(_validate.date.fIsValid(temp_dt_ven_last_reported) and _Validate.Date.fIsValid(temp_dt_ven_last_reported, _Validate.Date.Rules.DateInPast) and (unsigned4)temp_dt_ven_last_reported >= (unsigned4)temp_dt_ven_first_reported, (unsigned4)temp_dt_ven_last_reported, (unsigned4)temp_dt_ven_first_reported);
	self.company_name :=  Stringlib.StringToUpperCase(l.issuer_name);
	// Blank the street address
	self.prim_range := '';
	self.predir := '';
	self.prim_name := '';
	self.addr_suffix := '';
	self.postdir := '';
	self.unit_desig := '';
	self.sec_range := '';
	self.city := '';
	self.state := '';
	self.zip := 0;
	self.zip4 := 0;
	self.county := '';
	self.msa := '';
	self.geo_lat := '';
	self.geo_long := '';
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self.pflag := '4';
	end;

	v_insider_filing_issuer_blank_init := project(v_insider_filing_name(trim(name_first + name_last, left, right) <> ''
											                                               ,not CheckEmployeeRelationship(relationship_alpha)
                                                                     ,CheckStreet(street, err_stat, addr_suffix))
		                                           ,Translate_Vickers_Blank_Address_To_BHF(left));

	vickers_insider_filing_init := v_13g13d_init + v_insider_filing_filer_init + v_insider_filing_issuer_init + v_insider_filing_issuer_blank_init + v_insider_filing_street_init;

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

	vickers_insider_filing_blank_addr := vickers_insider_filing_init(not(zip <> 0 and prim_name <> ''));
	vickers_insider_filing_nonblank_addr := vickers_insider_filing_init(zip <> 0 and prim_name <> '');
	vicker_insider_filing_nonblank_addr_dist := distribute(vickers_insider_filing_nonblank_addr, hash(zip, prim_name, prim_range));

	Business_Header.Layout_Business_Header_New BlankAddress(Business_Header.Layout_Business_Header_New l, layout_nameaddr r) := transform
	self.prim_range := if(r.zip = 0, '', l.prim_range);
	self.predir := if(r.zip = 0, '', l.predir);
	self.prim_name := if(r.zip = 0, '', l.prim_name);
	self.addr_suffix := if(r.zip = 0, '', l.addr_suffix);
	self.postdir := if(r.zip = 0, '', l.postdir);
	self.unit_desig := if(r.zip = 0, '', l.unit_desig);
	self.sec_range := if(r.zip = 0, '', l.sec_range);
	self.city := if(r.zip = 0, '', l.city);
	self.state := if(r.zip = 0, '', l.state);
	self.zip := if(r.zip = 0, 0, l.zip);
	self.zip4 := if(r.zip = 0, 0, l.zip4);
	self.county := if(r.zip = 0, '', l.county);
	self.msa := if(r.zip = 0, '', l.msa);
	self.geo_lat := if(r.zip = 0, '', l.geo_lat);
	self.geo_long := if(r.zip = 0, '', l.prim_range);
	self := l;
	end;

	vickers_insider_filing_nonblank_fixed := join(vicker_insider_filing_nonblank_addr_dist,
												  bh_nameaddr_dist,
												  left.zip = right.zip and
													left.prim_name = right.prim_name and
													left.prim_range = right.prim_range and
													ut.CompanySimilar100(ut.CleanCompany(left.company_name),right.match_company_name) <= 35,
												  BlankAddress(left, right),
												  left outer,
												  local);
												  
	vickers_insider_filing_nonblank_fixed_dedup := 	dedup(vickers_insider_filing_nonblank_fixed, all);									  

	vickers_init := v_13g13d_init + vickers_insider_filing_nonblank_fixed_dedup + vickers_insider_filing_blank_addr;

	// Rollup
	Business_Header.Layout_Business_Header_New RollupVickers(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSFORM
	SELF.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	SELF.dt_last_seen := max(L.dt_last_seen,R.dt_last_seen);
	SELF.dt_vendor_last_reported := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	SELF.company_name := IF(L.company_name = '', R.company_name, L.company_name);
	SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
	SELF.vendor_id := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
						 L.vendor_id = '', R.vendor_id, L.vendor_id);
	SELF.source_group := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
						 L.source_group = '', R.source_group, L.source_group);
	SELF.phone := IF(L.phone = 0, R.phone, L.phone);
	SELF.phone_score := IF(L.phone = 0, R.phone_score, L.phone_score);
	SELF.fein := IF(L.fein = 0, R.fein, L.fein);
	SELF.prim_range := IF(l.prim_range = '' AND l.zip4 = 0, r.prim_range, l.prim_range);
	SELF.predir := IF(l.predir = '' AND l.zip4 = 0, r.predir, l.predir);
	SELF.prim_name := IF(l.prim_name = '' AND l.zip4 = 0, r.prim_name, l.prim_name);
	SELF.addr_suffix := IF(l.addr_suffix = '' AND l.zip4 = 0, r.addr_suffix, l.addr_suffix);
	SELF.postdir := IF(l.postdir = '' AND l.zip4 = 0, r.postdir, l.postdir);
	SELF.unit_desig := IF(l.unit_desig = ''AND l.zip4 = 0, r.unit_desig, l.unit_desig);
	SELF.sec_range := IF(l.sec_range = '' AND l .zip4 = 0, r.sec_range, l.sec_range);
	SELF.city := IF(l.city = '' AND l.zip4 = 0, r.city, l.city);
	SELF.state := IF(l.state = '' AND l.zip4 = 0, r.state, l.state);
	SELF.zip := IF(l.zip = 0 AND l.zip4 = 0, r.zip, l.zip);
	SELF.zip4 := IF(l.zip4 = 0, r.zip4, l.zip4);
	SELF.county := IF(l.county = '' AND l.zip4 = 0, r.county, l.county);
	SELF.msa := IF(l.msa = '' AND l.zip4 = 0, r.msa, l.msa);
	SELF.geo_lat := IF(l.geo_lat = '' AND l.zip4 = 0, r.geo_lat, l.geo_lat);
	SELF.geo_long := IF(l.geo_long = '' AND l.zip4 = 0, r.geo_long, l.geo_long);
	SELF := L;
	END;

	Vickers_Init_Dist := DISTRIBUTE(Vickers_Init,
						HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
	Vickers_Init_Sort := SORT(Vickers_Init_Dist, zip, prim_range, prim_name, source_group, company_name,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(phone <> 0, 0, 1), phone,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	Vickers_Init_Rollup := ROLLUP(Vickers_Init_Sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.company_name = right.company_name and
						  left.source_group = right.source_group and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.phone = 0 OR left.phone = right.phone) and
						  (right.fein = 0 OR left.fein = right.fein),
						RollupVickers(LEFT, RIGHT),
						LOCAL);
	
	return Vickers_Init_Rollup;
  end
 ;
