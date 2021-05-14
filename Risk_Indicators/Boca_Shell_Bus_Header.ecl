/*2014-12-03T01:11:33Z (David Schlangen)
change for bug 165691
*/
import ut, business_risk, did_add, Risk_Indicators, doxie, _control;

export Boca_Shell_Bus_Header(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam_pre_bus_header, doxie.IDataAccess mod_access, integer bsversion) := FUNCTION

bha := business_risk.Key_Business_Header_Address;

temp_rec := record
	unsigned6 seq;
	// recordof(business_risk.Key_Business_Header_Address) bus_hdr;
	bha.dt_first_seen;
	bha.dt_last_seen;	
	string50 bus_hdr_source_category := '';
	string2 bus_hdr_source_category_code := '';
	boolean fnamematch := 0;
	boolean lnamematch := 0;
	boolean fullnamematch := 0;
	integer bus_name_match := 0;
	integer ssnmatch := 0;
	integer phonematch := 0;
	integer years_since_first_seen := 0;
end;


temp_rec add_business_header(Risk_Indicators.Layout_Boca_Shell  le, bha rt) := transform

		self.dt_first_seen := rt.dt_first_seen;
		self.dt_last_seen := rt.dt_last_seen;
		
		nomatch := rt.source='';
		today := risk_indicators.iid_constants.myGetDate(le.historydate);

		h_dt_first_seen := (string)rt.dt_first_seen;
		dt_first_seen := if(length(trim(h_dt_first_seen))=6, 
						h_dt_first_seen + '01', 
						h_dt_first_seen);
		self.years_since_first_seen := if(nomatch, 0, 
																		ut.Age((unsigned)dt_first_seen, 
																										(unsigned)today) );, 
		fnamematch := risk_indicators.iid_constants.g( business_risk.CnameScore(le.shell_input.fname, rt.company_name) );
		lnamematch := risk_indicators.iid_constants.g( business_risk.CnameScore(le.shell_input.lname, rt.company_name) );
		fullnamematch := risk_indicators.iid_constants.g( business_risk.CnameScore(trim(le.shell_input.fname) + ' ' + trim(le.shell_input.lname), rt.company_name) );
		self.fnamematch := fnamematch;
		self.lnamematch := lnamematch;
		self.fullnamematch := fullnamematch;

		self.bus_name_match := map(nomatch => 0, fullnamematch => 4, lnamematch => 3, fnamematch => 2, 1);

		ssnmatch := did_add.ssn_match_score(le.shell_input.ssn, (string9)rt.fein, false);
		self.ssnmatch := map(nomatch =>0, ssnmatch=255 => 1, risk_indicators.iid_constants.g(ssnmatch)=>3, 2);

		phonematch := risk_indicators.PhoneScore(le.shell_input.phone10, if(rt.phone=0, '', (string)rt.phone));
		self.phonematch := map(nomatch =>0, phonematch=255 => 1, risk_indicators.iid_constants.g(phonematch)=>3, 2);

		bus_hdr_source := rt.source;
		
	// can remove bus_hdr_source_category when this goes to production as the categories will be documented
		self.bus_hdr_source_category := map(bus_hdr_source='' => '',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='E' and bus_hdr_source <> 'FE' => 'ExperianVeh',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='V' and bus_hdr_source <> 'CV' => 'Veh',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='X' and bus_hdr_source not in ['CX','TX'] => 'ExperianDL',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[1]='D' and bus_hdr_source not in ['MD'] => 'DL',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='W' and bus_hdr_source <> 'MW' => 'Watercraft',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[1]='C' and bus_hdr_source not in ['CD','CL','CT','CU','CW','CY'] => 'Corporation',
		(length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='F' and bus_hdr_source not in ['CF','DF','FF']) or bus_hdr_source in ['FL'] => 'FBN',
		bus_hdr_source in ['BA']                                 => 'Bankruptcy',
		bus_hdr_source in ['L2','LC','LI','LJ']                  => 'Lien',     
		bus_hdr_source in ['BR']                                 => 'BusinessRegistration',
		bus_hdr_source in ['BM','BN']                            => 'BBB',
		bus_hdr_source in ['CL','CT','IL','LL','OL','TL','PI']   => 'LiquorLicense',
		bus_hdr_source in ['FT','IT','TX']                       => 'SalesTax',
		bus_hdr_source in ['CY']                                 => 'Certegy',
		bus_hdr_source in ['D','DN']                             => 'DunnBradStreet',
		bus_hdr_source in ['DF']                                 => 'DCA',
		bus_hdr_source in ['EN']                                 => 'ExperianHeader',
		bus_hdr_source in ['EQ']                                 => 'EquifaxHeader',
		bus_hdr_source in ['ER']                                 => 'ExperianBusinessHeader',
		bus_hdr_source in ['FA']                                 => 'FAAAircraftRegistrations',
		bus_hdr_source in ['FB','FP','LA','LP']                  => 'Property',
		bus_hdr_source in ['GB','GG']                            => 'GongBusiness',
		bus_hdr_source in ['I']                                  => 'IRS5500',
		bus_hdr_source in ['IN','FN']                            => 'NonProfit',
		bus_hdr_source in ['IA','IC','II']                       => 'InfoUSA',
		bus_hdr_source in ['JI']                                 => 'JigSaw',
		bus_hdr_source in ['ML']                                 => 'AMIDIR',
		bus_hdr_source in ['PL']                                 => 'ProfessionalLicense',
		bus_hdr_source in ['OS']                                 => 'OSHair',
		bus_hdr_source in ['QQ']                                 => 'EqEmployer',
		bus_hdr_source in ['RB','SA']                            => 'RedbookAdvertiser',
		bus_hdr_source in ['SK']                                 => 'SK&AMedicalProfessional',
		bus_hdr_source in ['SL']                                 => 'AmericanStudent',
		bus_hdr_source in ['SP']                                 => 'Spoke',
		bus_hdr_source in ['U','U2','UH']                        => 'UCC',
		bus_hdr_source in ['UT','ZT']                            => 'Utility',
		bus_hdr_source in ['V']                                  => 'Vickers',
		bus_hdr_source in ['EM','VO']                            => 'Voter',
		bus_hdr_source in ['W']                                  => 'DomainRegistration',
		bus_hdr_source in ['WP']                                 => 'TargusWhitePage',
		bus_hdr_source in ['Y']                                  => 'YellowPage',
		bus_hdr_source in ['ZM']                                 => 'Zoom',					
		'other'
		);

		// limit some of these fields to just the time period of when the subject lived there, bug 165691
		valid_business_header := bsversion < 50 or ((unsigned)rt.dt_first_seen<>0 and
							(unsigned)(((STRING)rt.dt_first_seen)[1..6]) between le.address_verification.input_address_information.date_first_seen and 
																													le.address_verification.input_address_information.date_last_seen);
																													
		self.bus_hdr_source_category_code := map(bus_hdr_source='' or ~valid_business_header => '',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='E' and bus_hdr_source <> 'FE' => 'EV',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='V' and bus_hdr_source <> 'CV' => 'VE',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='X' and bus_hdr_source not in ['CX','TX'] => 'ED',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[1]='D' and bus_hdr_source not in ['MD'] => 'DL',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='W' and bus_hdr_source <> 'MW' => 'WC',
		length(trim(bus_hdr_source))=2 and bus_hdr_source[1]='C' and bus_hdr_source not in ['CD','CL','CT','CU','CW','CY'] => 'CP',
		(length(trim(bus_hdr_source))=2 and bus_hdr_source[2]='F' and bus_hdr_source not in ['CF','DF','FF']) or bus_hdr_source in ['FL'] => 'FB',
		bus_hdr_source in ['BA']                                 => 'BK',
		bus_hdr_source in ['L2','LC','LI','LJ']                  => 'L2',     
		bus_hdr_source in ['BR']                                 => 'BR',
		bus_hdr_source in ['BM','BN']                            => 'BB',
		bus_hdr_source in ['CL','CT','IL','LL','OL','TL','PI']   => 'LL',
		bus_hdr_source in ['FT','IT','TX']                       => 'ST',
		bus_hdr_source in ['CY']                                 => 'CY',
		bus_hdr_source in ['D','DN']                             => 'DB',
		bus_hdr_source in ['DF']                                 => 'DF',
		bus_hdr_source in ['EN']                                 => 'EN',
		bus_hdr_source in ['EQ']                                 => 'EQ',
		bus_hdr_source in ['ER']                                 => 'ER',
		bus_hdr_source in ['FA']                                 => 'FA',
		bus_hdr_source in ['FB','FP','LA','LP']                  => 'PR',
		bus_hdr_source in ['GB','GG']                            => 'GB',
		bus_hdr_source in ['I']                                  => 'IR',
		bus_hdr_source in ['IN','FN']                            => 'NP',
		bus_hdr_source in ['IA','IC','II']                       => 'IA',
		bus_hdr_source in ['JI']                                 => 'JI',
		bus_hdr_source in ['ML']                                 => 'ML',
		bus_hdr_source in ['PL']                                 => 'PL',
		bus_hdr_source in ['OS']                                 => 'OS',
		bus_hdr_source in ['QQ']                                 => 'QQ',
		bus_hdr_source in ['RB','SA']                            => 'RB',
		bus_hdr_source in ['SK']                                 => 'SK',
		bus_hdr_source in ['SL']                                 => 'SL',
		bus_hdr_source in ['SP']                                 => 'SP',
		bus_hdr_source in ['U','U2','UH']                        => 'U2',
		bus_hdr_source in ['UT','ZT']                            => 'UT',
		bus_hdr_source in ['V']                                  => 'VI',
		bus_hdr_source in ['EM','VO']                            => 'VO',
		bus_hdr_source in ['W']                                  => 'WI',
		bus_hdr_source in ['WP']                                 => 'WP',
		bus_hdr_source in ['Y']                                  => 'YP',
		bus_hdr_source in ['ZM']                                 => 'ZM',					
		'XX'												
		);
		self := le;
end;

with_business_header_roxie := join(clam_pre_bus_header, bha,
						left.shell_input.prim_name!='' and left.shell_input.z5!='' and
						keyed((unsigned)left.shell_input.z5=right.zip) and
						keyed(left.shell_input.prim_name=right.prim_name) and
						keyed(right.prim_range=left.shell_input.prim_range) and
						keyed(right.sec_range=left.shell_input.sec_range) and
						(unsigned)(((STRING)right.dt_first_seen)[1..6]) < left.historydate and 
						doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
			 add_business_header(left, right), atmost(10000),
						keep(1000),
			 left outer);
			 
with_business_header_thor := join(
distribute(clam_pre_bus_header, hash64(shell_input.z5, shell_input.prim_name, shell_input.prim_range, shell_input.sec_range)), 
distribute(pull(bha), hash64(zip, prim_name, prim_range, sec_range)),
						left.shell_input.prim_name!='' and left.shell_input.z5!='' and
						((unsigned)left.shell_input.z5=right.zip) and
						(left.shell_input.prim_name=right.prim_name) and
						(right.prim_range=left.shell_input.prim_range) and
						(right.sec_range=left.shell_input.sec_range) and
						(unsigned)(((STRING)right.dt_first_seen)[1..6]) < left.historydate and 
						doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
			 add_business_header(left, right), 
						keep(1000),
			 left outer, local);
			 
#IF(_control.Environment.onThor) 
	with_business_header := with_business_header_thor;
#ELSE
	with_business_header := with_business_header_roxie;
#END;
		
 
t_roxie := table(with_business_header, {seq, 
													 bus_hdr_source_category_code,
														records_per_source := count(group),
														bus_name_match_level := max(group, bus_name_match),
														bus_ssn_match_level := max(group, ssnmatch),
														bus_phone_match_level := max(group, phonematch),
														first_seen_at_source := min(group, if(dt_first_seen=0, 99999999, dt_first_seen)),
														last_seen_at_source := max(group, dt_last_seen),
													}, seq, bus_hdr_source_category_code, few);
t_thor := table(with_business_header, {seq, 
													 bus_hdr_source_category_code,
														records_per_source := count(group),
														bus_name_match_level := max(group, bus_name_match),
														bus_ssn_match_level := max(group, ssnmatch),
														bus_phone_match_level := max(group, phonematch),
														first_seen_at_source := min(group, if(dt_first_seen=0, 99999999, dt_first_seen)),
														last_seen_at_source := max(group, dt_last_seen),
													}, seq, bus_hdr_source_category_code, merge);  // difference in the thor workunit, since the with_business_header dataset is distributed

#IF(_control.Environment.onThor) 
	t := t_thor;
	sorted_t := sort(distribute(t, seq), seq, first_seen_at_source,bus_hdr_source_category_code, local);
#ELSE
	t := t_roxie;
	sorted_t := sort(t, seq, first_seen_at_source,bus_hdr_source_category_code);
#END;

// output(choosen(t, eyeball), named('stats'));

temp_rec2 := record
	unsigned seq;
	integer bus_addr_match_cnt := 0;
	string100 bus_sources := '';
	string100 bus_sources_record_cnt :='';
	string200 bus_sources_first_seen_dates := '';
	integer bus_name_match := 0;
	integer bus_ssn_match := 0;
	integer bus_phone_match := 0;
end;

with_bus_fields := project(sorted_t, 
transform(temp_rec2,
	self.seq := left.seq;
	nomatch := left.bus_hdr_source_category_code='';
	self.bus_addr_match_cnt:= if(nomatch, 0, left.records_per_source);
	self.bus_sources_record_cnt := if(nomatch, '', (string)left.records_per_source + ',');
	self.bus_sources := if(nomatch, '', left.bus_hdr_source_category_code + ',');
	self.bus_sources_first_seen_dates := if(nomatch, '', if(left.first_seen_at_source=99999999, '0', (string)left.first_seen_at_source) + ',');
	self.bus_name_match := left.bus_name_match_level;
	self.bus_ssn_match := left.bus_ssn_match_level;
	self.bus_phone_match := left.bus_phone_match_level;));

	
// output(choosen(with_bus_fields, eyeball), named('with_bus_fields'));

grped := group(with_bus_fields, seq); 

temp_rec2 roll_bus(temp_rec2 le, temp_rec2 rt) := transform
	self.bus_addr_match_cnt:= le.bus_addr_match_cnt+ rt.bus_addr_match_cnt;
	self.bus_sources_record_cnt := trim(le.bus_sources_record_cnt) + rt.bus_sources_record_cnt +',';
	self.bus_sources := trim(le.bus_sources) + rt.bus_sources +',';
	self.bus_sources_first_seen_dates := trim(le.bus_sources_first_seen_dates) + rt.bus_sources_first_seen_dates +',';
	self.bus_name_match := max(le.bus_name_match, rt.bus_name_match);
	self.bus_ssn_match := max(le.bus_ssn_match,rt.bus_ssn_match);
	self.bus_phone_match := max(le.bus_phone_match, rt.bus_phone_match);

	self := rt;
end;

rolled := rollup(grped, true, roll_bus(left, right));
// output(choosen(rolled, eyeball), named('rolled'));


#if(_control.Environment.onThor_LeadIntegrity)
	with_bus_header_summary := clam_pre_bus_header;  // for initial trending attributes, we don't need this function, so we can skip all of this code and make it run faster
#else
	with_bus_header_summary := group(join(clam_pre_bus_header, rolled, left.seq=right.seq,
									transform(risk_indicators.Layout_Boca_Shell, 
														self.business_header_address_summary := right,
														self := left), left outer, keep(1)), seq);
#end


														
return with_bus_header_summary;
												
end;
