
import ut, riskwise, doxie, LN_PropertyV2, paw, Inquiry_AccLogs, liensv2, doxie_files, 
BankruptcyV2, BankruptcyV3, american_student_list, AlloyMedia_student_list, prof_licenseV2, Impulse_Email, thrive, mdr;

// this function gives a high level overview of different public records attributes at the household level
EXPORT Boca_Shell_HHID_Summary(grouped DATASET(risk_indicators.iid_constants.layout_outx) all_header,
unsigned1 dppa, string50 DataRestriction=iid_constants.default_DataRestriction, integer bsVersion

)  := function

isFCRA := false;  // this function is only valid in nonfcra shell

// dedup to make sure there is just 1 hhid per seq before slimming the layout to run this function
hhid_input := table(dedup(sort(all_header, seq, -hhid_summary.hhid), seq), 
										{seq, did, hhid := hhid_summary.hhid, historydate, fname, lname});

layout_hhid_temp := record
	unsigned seq;
	unsigned historydate;  
	risk_indicators.layouts.layout_hhid_summary;
	unsigned did := 0;  // keep track of each did tied to that household for searching later
	integer age := 0; 
	unsigned6 contact_id := 0;  // for the people at work join
	string50 bk_tmsid := '';  // for the bankruptcy join
	string35 crim_case_num := ''; // criminal extras
	STRING50 rmsid := ''; // liens extras
	string50 tmsid := ''; // liens extras
end;

hhids := dedup(hhid_input(hhid<>0), hhid);

with_hhid_dids := join(hhids, doxie.Key_HHID_Did,
	keyed(left.hhid=right.hhid_relat),
	transform(layout_hhid_temp, self.did := right.did, 
		self.hh_members_ct := if(right.did<>0, 1, 0),
		self := left), atmost(riskwise.max_atmost), keep(100));

dppa_ok := risk_indicators.iid_constants.dppa_ok(dppa, isFCRA);

with_age := join(with_hhid_dids, risk_indicators.Key_ADL_Risk_Table_v4, 
	keyed(left.did=right.did),
	transform(layout_hhid_temp, 

	// determine which section of the table is permitted for use based on the data restriction mask
	header_version := map(DataRestriction[risk_indicators.iid_constants.posEquifaxRestriction]=risk_indicators.iid_constants.sFalse and
												DataRestriction[risk_indicators.iid_constants.posTransUnionRestriction]=risk_indicators.iid_constants.sFalse and
												((~isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianRestriction]=risk_indicators.iid_constants.sFalse) or (isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction]=risk_indicators.iid_constants.sFalse)) => right.combo,
												((~isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianRestriction]=risk_indicators.iid_constants.sFalse) or (isFCRA and DataRestriction[risk_indicators.iid_constants.posExperianFCRARestriction]=risk_indicators.iid_constants.sFalse)) => right.en,
												~isFCRA and DataRestriction[risk_indicators.iid_constants.posTransUnionRestriction]=risk_indicators.iid_constants.sFalse => right.tn,
												right.eq);  // default to the EQ version
	reported_dob := if(dppa_ok, header_version.reported_dob, header_version.reported_dob_no_dppa);
	
	age := risk_indicators.years_apart((unsigned)risk_indicators.iid_constants.mygetdate(left.historydate), reported_dob);
	
	self.hh_age_65_plus := if(age>65, 1, 0);  
	self.hh_age_31_to_65 := if(age between 31 and 65, 1, 0);  
	self.hh_age_18_to_30 := if(age between 18 and 30, 1, 0);  
	self.hh_age_lt18 := if(age between 1 and 17, 1, 0);  
	self.age := age;
	self := left), left outer, atmost(riskwise.max_atmost), keep(1));

with_property_ownership := join(with_age, LN_PropertyV2.Key_Prop_Ownership_V4, 
	keyed(left.did=right.did) and (unsigned)((string)right.purchase_date)[1..6] < left.historydate,
	transform(layout_hhid_temp, 
		self.hh_property_owners_ct := if(right.did<>0, 1, 0);
		self := left), left outer, atmost(riskwise.max_atmost), keep(1) );
		
with_paw_did := join(with_property_ownership, paw.Key_Did,
						keyed(left.did=right.did), 
						transform(layout_hhid_temp,
											self.contact_id := right.contact_id,
											self := left),
						left outer, atmost(riskwise.max_atmost), keep(1000));

pawfile_full_nonfcra := join(with_paw_did, paw.Key_contactid,
						left.contact_id<>0 and 
						keyed(left.contact_id=right.contact_id) 
						and (unsigned)right.dt_first_seen[1..6] < left.historydate,
						transform(layout_hhid_temp,
							self.hh_workers_paw := if(right.contact_id<>0, 1, 0),
							self := left), left outer, atmost(riskwise.max_atmost), keep(1));
with_paw_rolled := dedup(sort(pawfile_full_nonfcra, seq, did, -hh_workers_paw, seq, did), seq, did );

collections_bucket := if(bsversion>=50, Inquiry_AccLogs.shell_constants.collections_vertical_set, 	['COLLECTIONS','1PC','3PC']);	
with_collection_inquiries := join(with_paw_rolled, Inquiry_AccLogs.Key_Inquiry_DID, 
						keyed(left.did=right.s_did) and
						trim(StringLib.StringToUpperCase(right.search_info.function_description)) in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(bsVersion) and
						trim(right.search_info.product_code) in Inquiry_AccLogs.shell_constants.valid_product_codes and
						trim(right.bus_intel.use)='' and
						(
								trim(StringLib.StringToUpperCase(right.bus_intel.vertical)) IN collections_bucket or
								trim(StringLib.StringToUpperCase(right.bus_intel.industry)) IN Inquiry_AccLogs.shell_constants.collection_industry or
								StringLib.StringFind(trim(StringLib.StringToUpperCase(right.bus_intel.sub_market)),'FIRST PARTY', 1) > 0
						) and
					  trim(right.search_info.datetime)<>'' and
						(unsigned)right.search_info.datetime[1..6] < left.historydate,  
			transform(layout_hhid_temp,
							self.hh_collections_ct := if(right.s_did<>0, 1, 0);
							self := left),
						left outer, atmost(riskwise.max_atmost), keep(1)) ;	

with_impulse := join(with_collection_inquiries, Impulse_Email.Key_Impulse_DID, 
									keyed(left.did=right.did) and (unsigned)stringlib.stringfilterout(right.created[1..7],'-')< left.historydate,	
									transform(layout_hhid_temp,
										self.hh_payday_loan_users := if(right.did<>0, 1, 0);
										self := left), left outer, atmost(riskwise.max_atmost), keep(1));

with_thrive := join(with_impulse, thrive.keys().did.qa, 
									keyed(left.did=right.did) and 
									((unsigned)RIGHT.dt_first_seen < (unsigned)iid_constants.full_history_date(left.historydate)) AND
									right.src = mdr.sourceTools.src_Thrive_PD, 
									transform(layout_hhid_temp,
										self.hh_payday_loan_users := if(right.did<>0 or left.hh_payday_loan_users=1, 1, 0);
										self := left), left outer, atmost(riskwise.max_atmost), keep(1));										
										

with_professional_license := join(with_thrive, prof_licenseV2.Key_Proflic_Did (),
											left.did!=0 and keyed(right.did = left.did) and trim(right.prolic_key)!='' and
											(unsigned)right.date_first_seen[1..6] < left.historydate,
											transform(layout_hhid_temp,
											self.hh_prof_license_holders := if(right.did<>0, 1, 0);
											self := left), left outer, atmost(riskwise.max_atmost), keep(1));
												
with_alloy := join(with_professional_license, AlloyMedia_student_list.Key_DID, 
			keyed(left.did=right.did)
			and (right.file_type in ['H','C'] or
				(right.file_type='M' and (right.school_name<>'' or right.public_private_code<>'') ) )
			and right.date_vendor_first_reported < risk_indicators.iid_constants.myGetDate(left.historydate),
			transform(layout_hhid_temp, 
				self.hh_college_attendees := if(right.did<>0, 1, 0);
				self := left), left outer, atmost(riskwise.max_atmost), keep(1));

with_american_student := join(with_alloy, american_student_list.key_DID, 
			left.hh_college_attendees<>1
			and keyed(left.did=right.l_did)
			and (right.file_type in ['H','C','O'] or
				(right.file_type='M' and (right.college_code<>'' or right.college_name<>'' or right.college_type<>'') ) )
			and right.date_vendor_first_reported < risk_indicators.iid_constants.myGetDate(left.historydate),
			transform(layout_hhid_temp, 
				self.hh_college_attendees := if(right.did<>0 or left.hh_college_attendees=1, 1, 0);
				self := left), left outer, atmost(riskwise.max_atmost), keep(1));

with_bk := join(with_american_student, BankruptcyV3.key_bankruptcyV3_did(),
	keyed(left.did=right.did),
	transform(layout_hhid_temp, 
				self.bk_tmsid := right.tmsid;
				self := left), left outer, atmost(riskwise.max_atmost), keep(100));

with_bk_search := join(with_bk, BankruptcyV3.key_bankruptcyv3_search_full_bip(), 
	LEFT.bk_tmsid<>'' AND
	keyed(LEFT.bk_tmsid = RIGHT.tmsid) AND
	right.name_type='D' and
	(unsigned)right.did=left.did and
	(unsigned)(RIGHT.date_filed[1..6]) < left.historydate,
	transform(layout_hhid_temp, 
		self.hh_bankruptcies := if(trim(right.case_number)<>'', 1, 0);
		self := left),
	LEFT OUTER, 
	ATMOST(Riskwise.max_atmost), KEEP(1));

with_bk_deduped := dedup(sort(with_bk_search, seq, did, -hh_bankruptcies, seq, did), seq, did );

with_crim := join(with_bk_deduped, doxie_files.key_offenders_risk, 
			keyed(left.did=right.sdid) and
		 (unsigned3)(RIGHT.earliest_offense_date[1..6]) < left.historydate, 		
			transform(layout_hhid_temp, 
				self.hh_criminals := if(right.sdid<>0, 1, 0);
				self := left), left outer, atmost(riskwise.max_atmost), keep(1));

with_lien_ids := join(with_crim, liensv2.key_liens_DID, 
		keyed(left.did=right.did),
			transform(layout_hhid_temp,
				self.tmsid := right.tmsid;
				SELF.rmsid := right.rmsid;
				SELF := left), left outer, atmost(riskwise.max_atmost), keep(1));

with_liens := join(with_lien_ids, liensv2.key_liens_party_id, 
		LEFT.rmsid<>'' AND
		keyed(left.tmsid=right.tmsid) and keyed(LEFT.rmsid=RIGHT.rmsid) AND 
		right.name_type='D' and 
		(unsigned3)(RIGHT.date_first_seen[1..6]) < left.historydate,
			transform(layout_hhid_temp,
				lien_hit := if(right.rmsid<>'', 1, 0);
				self.hh_lienholders := lien_hit;
				self.hh_tot_derog := left.hh_criminals + left.hh_bankruptcies + lien_hit;  // sum the 3 categories
				self.hh_members_w_derog := if(left.hh_criminals=1 or left.hh_bankruptcies=1 or lien_hit=1, 1, 0);  // flag if any of the 3 categories
				SELF := left),
				LEFT OUTER, KEEP(1), ATMOST(Riskwise.max_atmost));

with_liens_deduped := dedup(sort(with_liens, seq, did, -hh_lienholders, seq, did), seq, did );

rolled_household := rollup(with_liens_deduped, left.seq=right.seq,
	transform(layout_hhid_temp,
		self.hh_members_ct := left.hh_members_ct + right.hh_members_ct;  //Total number of household members
		self.hh_property_owners_ct := left.hh_property_owners_ct + right.hh_property_owners_ct ;  //Total number of household members shown to own property
		self.hh_age_65_plus := left.hh_age_65_plus + right.hh_age_65_plus ;  //Total number of household members aged 65 and up
		self.hh_age_31_to_65 := left.hh_age_31_to_65 + right.hh_age_31_to_65 ;  //Total number of household members aged 30 to 65
		self.hh_age_18_to_30 := left.hh_age_18_to_30 + right.hh_age_18_to_30 ;  //Total number of household members aged 18 to 30
		self.hh_age_lt18 := left.hh_age_lt18 + right.hh_age_lt18 ;  //Total number of household members less than 18
		self.hh_collections_ct := left.hh_collections_ct + right.hh_collections_ct ;  //Total number of household members with collection inquiry activity
		self.hh_workers_paw := left.hh_workers_paw + right.hh_workers_paw ;  //Total number of household members with a People at Work record
		self.hh_payday_loan_users := left.hh_payday_loan_users + right.hh_payday_loan_users ;  //Total number of household members with payday loan activity on file (Impulse)
		self.hh_members_w_derog := left.hh_members_w_derog + right.hh_members_w_derog ;  //Total number of household members with derogatory public records
		self.hh_tot_derog := left.hh_tot_derog + right.hh_tot_derog ;  //Total number of derogatory public records for the entire household
		self.hh_bankruptcies := left.hh_bankruptcies + right.hh_bankruptcies ;  //Total number of household members with a bankruptcy on file
		self.hh_lienholders := left.hh_lienholders + right.hh_lienholders ;  //Total number of household members with any lien record
		self.hh_prof_license_holders := left.hh_prof_license_holders + right.hh_prof_license_holders ;  //Total number of household members with a professional license
		self.hh_criminals := left.hh_criminals + right.hh_criminals ;  //Total number of criminals in the household
		self.hh_college_attendees := left.hh_college_attendees + right.hh_college_attendees ;  //Total number of household members with evidence of college attendance
		self := left	) );

with_hhid_summary := group(
join(all_header, rolled_household, left.seq=right.seq,
	transform(risk_indicators.iid_constants.layout_outx,
		self.hhid_summary := right;
		self := left), left outer, keep(1)), 
		seq);

// ==================================================
// debugging section
// ==================================================
// output(hhid_input, named('hhid_input'));
// output(with_hhid_dids, named('with_hhid_dids'));
// output(with_age, named('with_age'));		
// output(with_property_ownership, named('with_property_ownership'));
// output(with_paw_rolled, named('with_paw_rolled'));
// output(with_collection_inquiries, named('with_collection_inquiries'));
// output(with_impulse, named('with_impulse'));
// output(with_thrive, named('with_thrive'));
// output(with_professional_license, named('with_professional_license'));
// output(with_alloy, named('with_alloy'));
// output(with_american_student, named('with_american_student'));
// output(with_bk, named('with_bk'));
// output(with_bk_search, named('with_bk_search'));
// output(with_bk_deduped, named('with_bk_deduped'));
// output(with_crim, named('with_crim'));
// output(with_lien_ids, named('with_lien_ids'));
// output(with_liens, named('with_liens'));
// output(with_liens_deduped, named('with_liens_deduped'));
// output(rolled_household, named('rolled_household'));
// output(with_hhid_summary, named('with_hhid_summary'));

return with_hhid_summary;

end;
