import corp2;
//********************************************************************
//FileLPMaster -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LPLayoutIn LPTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.lp_record_ind_52001						:= corp2.t2u(l.payload[1..1]);
	self.lp_file_number_52001						:= corp2.t2u(l.payload[2..8]);
	self.lp_date_duration_52001					:= corp2.t2u(l.payload[9..16]);
	self.lp_date_sos_filed_52001				:= corp2.t2u(l.payload[17..24]);
	self.lp_date_effective_52001				:= corp2.t2u(l.payload[25..32]);
	self.lp_date_br_mailed_52001				:= corp2.t2u(l.payload[33..40]);
	self.lp_date_br_deliq_52001					:= corp2.t2u(l.payload[41..48]);
	self.lp_date_br_filed_52001					:= corp2.t2u(l.payload[49..56]);
	self.lp_renewal_year_month_52001		:= corp2.t2u(l.payload[57..62]);
	self.lp_status_52001								:= corp2.t2u(l.payload[63..64]);
	self.lp_status_date_52001						:= corp2.t2u(l.payload[65..72]);
	self.lp_intent_code_52001						:= corp2.t2u(l.payload[75..80]);
	self.lp_contributions_52001					:= corp2.t2u(l.payload[81..89]);
	self.lp_date_org_filed_52001				:= corp2.t2u(l.payload[90..97]);
	self.lp_filing_org_cnty_filed_52001	:= corp2.t2u(l.payload[98..100]);
	self.lp_filing_org_doc_nbr_52001		:= corp2.t2u(l.payload[101..111]);
	self.lp_assumed_ind_52001						:= corp2.t2u(l.payload[112..112]);
	self.lp_old_ind_52001 							:= corp2.t2u(l.payload[113..114]);
	self.lp_admitting_ind_52001					:= corp2.t2u(l.payload[114..114]);
	self.lp_partnership_name_52001			:= corp2.t2u(l.payload[115..303]);
	self.lp_business_state_52001				:= corp2.t2u(l.payload[304..305]);
	self.lp_records_office_street_52001	:= corp2.t2u(l.payload[306..335]);
	self.lp_records_office_city_52001		:= corp2.t2u(l.payload[336..353]);
	self.lp_records_office_state_52001	:= corp2.t2u(l.payload[354..355]);
	self.lp_records_office_zip_52001		:= corp2.t2u(l.payload[356..364]);
	self.lp_records_office_cnty_52001		:= corp2.t2u(l.payload[365..367]);
	self.lp_agent_code_52001						:= corp2.t2u(l.payload[368..368]);
	self.lp_agent_name_52001 						:= corp2.t2u(l.payload[369..428]);
	self.lp_agent_firm_name_52001 			:= corp2.t2u(l.payload[429..488]);
	self.lp_agent_street_52001					:= corp2.t2u(l.payload[489..518]);
	self.lp_agent_city_52001						:= corp2.t2u(l.payload[519..536]);
	self.lp_agent_zip_52001							:= corp2.t2u(l.payload[537..545]);
	self.lp_agent_cnty_code_52001				:= corp2.t2u(l.payload[546..548]);
	self.lp_date_agent_chge_52001				:= corp2.t2u(l.payload[549..556]);
end;

export FileLPMaster(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLP) := project(pInLP(corp2.t2u(payload[1..1])='M'),LPTransform(LEFT));  