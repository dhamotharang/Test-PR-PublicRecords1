import crim_common, corrections, hygenics_search;

df := hygenics_crim.Out_Moxie_Crim_Offender2;
			
corrections.layout_offender into(df L) := transform
	self.orig_state 										:= L.state_origin;
	self.ssn 														:= L.orig_ssn;
	self.ssn_appended 									:= L.ssn;
	self.case_date 											:= L.case_filing_dt;
	self.case_num 											:= L.case_number;
	self.st 														:= L.state;
	self.record_type										:= '';
	self.county_of_origin 							:= '';
	self.datasource											:= '';
	self.clean_errors										:= (integer)L.err_stat;
	self.county_name										:= L.ace_fips_county;
	self.score													:= '';
	self.curr_incar_flag								:= '';
	self.curr_parole_flag								:= '';
	self.curr_probation_flag 						:= '';
	self.fcra_conviction_flag 					:= '';
	self.fcra_traffic_flag							:= '';
	self.fcra_date											:= '';
	self.fcra_date_type									:= '';
	self.conviction_override_date 			:= '';
	self.conviction_override_date_type 	:= '';
	self.offense_score 									:= '';
	self.offender_persistent_id					:= L.offender_persistent_id;
	self 																:= L;
end;

export AllOffenders := project(df,into(LEFT)):persist('~thor_data400::persist::alloffenders');