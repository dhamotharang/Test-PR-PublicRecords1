import bankruptcyv2_services, bankruptcyv3_services, codes, ut, risk_indicators;

// main rollup layouts
layout_v2_rollup := bankruptcyv2_services.layouts.layout_rollup;
layout_v3_rollup := bankruptcyv3_services.layouts.layout_rollup;

// trustee layouts
layout_v2_trustee := bankruptcyv2_services.layouts.layout_party;
layout_v3_trustee := bankruptcyv3_services.layouts.layout_trustee;

// misc layouts
layout_v2_name := bankruptcyv2_services.layouts.layout_name;
layout_v2_address := bankruptcyv2_services.layouts.layout_address;
layout_v2_phone := bankruptcyv2_services.layouts.layout_phone;

/*
	function to transform bkv3 rollup layout to the bkv2 rollup layout
	for the purpose of converting services to only use bkv3 payload keys
*/
export fn_bkv3_to_bkv2_rollup(dataset(layout_v3_rollup) ds_v3_rollup, boolean isSearch = false) := function

	/* extra layout to contain missing fields that we will try to append */
	layout_v3_rollup_xtra := record (layout_v3_rollup)
		string4  trustee_timezone := '';
		string10 trustee_phone;
	end;
	
	/* transform to xtra layout and move trustee phone "up" to use getTimeZone MACRO more easily */
	layout_v3_rollup_xtra xfm_v3_rollup_xtra(layout_v3_rollup le) := transform
		self.trustee_phone 	:= le.trustee.phone;
		self 								:= le;
	end;
	
	ds_v3_rollup_xtra := project(ds_v3_rollup, xfm_v3_rollup_xtra(left));	
	
	/* append timezone for use in trustee phone info */
	ut.getTimeZone(ds_v3_rollup_xtra, trustee_phone, trustee_timezone, ds_v3_rollup_w_tz);

	/* transform trustee name fields */
	layout_v2_name xfm_v3_trustee_name(layout_v3_trustee t) := transform
		/* no "ssn" field in v3 trustee layout */
		self.ssn 	:= t.app_ssn;
		self 			:= t;
		self 			:= [];
	end;
	
	/* transform trustee address fields */
	layout_v2_address xfm_v3_trustee_address(layout_v3_trustee t) := transform
		self.orig_zip5 		:= t.orig_zip;
		self.orig_addr1 	:= t.orig_address;
		self 							:= t;
		self 							:= [];
	end;
	
	/* transform trustee phone fields */
	layout_v2_phone xfm_v3_trustee_phone(layout_v3_trustee t, string4 tz) := transform
		self.timezone := tz;
		self 					:= t;
		self 					:= [];
	end;

	/* transform trustee fields */
	layout_v2_trustee xfm_v3_trustee_to_v2(layout_v3_trustee t, string4 tz) := transform
		self.names 			:= project(t, xfm_v3_trustee_name(left));
		self.addresses 	:= project(t, xfm_v3_trustee_address(left));
		self.phones 		:= project(t, xfm_v3_trustee_phone(left, tz));
		/* no "ssn" field in v3 trustee layout */
		self.ssn				:= t.app_ssn; 
		self := t;
		self := [];
	end;
	
	/* final transform from v3 rollup to v2 rollup */
	layout_v2_rollup xfm_v3_to_v2(layout_v3_rollup_xtra le) := transform
	
		ds_trust 									:= project(dataset(le.trustee), 
																					xfm_v3_trustee_to_v2(left, le.trustee_timezone));
																					
		self.trustees 						:= if(~isSearch,ds_trust);
		
		self.matched_party.parsed_party.orig_name 	:= if(le.matched_party.parsed_party.cname = '', 
																											trim(le.matched_party.parsed_party.fname)+' '+trim(le.matched_party.parsed_party.mname)+' '+trim(le.matched_party.parsed_party.lname),
																											'');
		/* 
			by using the first debtor we are assuming that the debtors are sorted in the order 
			that we want them to be in to pick off the correct debtor-level values and put them 
			into the case-level layout. it's probably a safe assumption since bankruptcy_raw 
			sorts to keep the primary debtor on top.
		*/
		self.chapter 							:= le.debtors[1].chapter;
		self.pro_se_ind 					:= le.debtors[1].pro_se_ind;
		self.converted_date				:= le.debtors[1].converted_date;
		self.disposed_date				:= le.debtors[1].discharged;
		self.disposition					:= le.debtors[1].disposition;
		self.orig_filing_type			:= le.debtors[1].filing_type;
		self.orig_filing_type_ex	:= codes.BANKRUPTCIES.FILING_TYPE(le.debtors[1].filing_type);
		self.corp_flag						:= le.debtors[1].corp_flag;
		self 											:= le;
	end;

	ds_v2_rollup := project(ds_v3_rollup_w_tz, xfm_v3_to_v2(left));
	
	return ds_v2_rollup;
end;
